From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Thu, 6 Mar 2008 00:08:46 -0500
Message-ID: <20080306050846.GQ8410@spearce.org>
References: <20080304051149.GS8410@spearce.org> <20080305053612.GA8410@spearce.org> <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com> <200803052213.20501.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Imran M Yousuf <imyousuf@gmail.com>,
	Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 06:09:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX8MF-000248-My
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 06:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbYCFFIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 00:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbYCFFIy
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 00:08:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42641 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYCFFIx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 00:08:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JX8LL-00089D-1j; Thu, 06 Mar 2008 00:08:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A820120FBAE; Thu,  6 Mar 2008 00:08:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200803052213.20501.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76331>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> 
> You will find support in jgit for this today. Cloning over git and ssh real 
> soon. I'm clensing the oopses from the history right now. (bless rebase -i
> and git-gui).

I'm sort of waiting to see this fetch history soon.  :-)

The reason is I just got index v2 support (runtime read side) completed
and I want to add index v2 generation to IndexPack.  I also want to start
building a PackWriter so we can work on native transport push over SSH.

If we get fetch/push running I think we are heading into the area
where it is of some real use to people.
 
> There might be some operations that might be harder to do well in Java. For 
> those exec'ing might be the solution, I'm thinking repack, but then I haven't 
> tried it yet.

I'm determined to even get "proper" packfile generation in Java.
But it may be time consuming to build.  There may be license issues
around doing a direct cribbed port of the delta generation.  :-\

> In general jgit is almost as fast as git and probably 
> outperforms git on windows as git there doesn't use  memory mapped I/O for 
> packs (something I'd expect someone or even me to fix soon). For JNI'ed 
> operations the complexity is just horrible and even when possible, there is
> a lot of overhead for JNI itselt, conversion from UTF-16 to somehing 
> eightbitish and back. On windows there's even yet another layer of 
> eight-bitish to UTF-16 and back in the Win32 API. Jgit also uses memory
> mapped I/O on all platforms that support it for pack reading.
> 
> If someone *did* make a fully reentrant libgit, I'd be inclined to balance my
> opinions differently.

Really?  If jgit is basically as fast as C git, but doesn't have
the overheads of dropping in and out of JNI or fork/exec then you
can actually get pretty good performance out of a Java application.

I've never really liked doing JNI.  I try to avoid it whenever
I possibly can.  JVMs just don't seem to be all that happy about
loading other native code into them, but yet they can do some very
good optimizations when everything is 100% pure Java and the JIT
has free reign to do what it pleases.

-- 
Shawn.
