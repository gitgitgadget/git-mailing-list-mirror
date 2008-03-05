From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Wed, 5 Mar 2008 22:13:20 +0100
Message-ID: <200803052213.20501.robin.rosenberg@dewire.com>
References: <20080304051149.GS8410@spearce.org> <20080305053612.GA8410@spearce.org> <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Carlos Rica" <jasampler@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:15:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX0x6-0005vZ-Hb
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbYCEVO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 16:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755261AbYCEVO0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:14:26 -0500
Received: from [83.140.172.130] ([83.140.172.130]:3547 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755022AbYCEVOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 16:14:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B01778027F2;
	Wed,  5 Mar 2008 22:14:23 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iyitU72COSHw; Wed,  5 Mar 2008 22:14:21 +0100 (CET)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id EF4718006B6;
	Wed,  5 Mar 2008 22:14:20 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76267>

Den Wednesday 05 March 2008 08.58.15 skrev Imran M Yousuf:
> I would like to suggest 2 projects that I want to work as a developer
> (and/or mentor):
>
> 1. GIT SCM Plugin for NetBeans (GPLv2 with CPE, same as NetBeans)
> The aim of the plugin is to integrate GIT with NetBeans using JNI so
> that any change in the implementation of GIT does not effect the SCM
> plugins way of work.
> Language: Java
> Goal: Make GIT available from IDE for NetBeans users and use GIT using
> Java Native Interfaces

As the current acting maintainer or egit/jgit I would not mind cooperating 
with making it available to Netbeans, J2EE and command line interface or
whatever.

You can make a plugin for Netbeans today that will do the basic like walking 
the history, finding out what to commit, commit, switch/create/reset 
branches, decorations based on jgit and you wouldn't need to change a thing 
in jgit. There might be things you *want* to change, but that's another story 
and applied to the continued development for the Eclipse plugin too. Even
the license might be changed.

You will find support in jgit for this today. Cloning over git and ssh real 
soon. I'm clensing the oopses from the history right now. (bless rebase -i
and git-gui).

There are no dependencies on Eclipse and I do not plan on introducing any.
Jgit and Egit live in the same repo at the moment simply because there are
no other users of egit so far.

There might be some operations that might be harder to do well in Java. For 
those exec'ing might be the solution, I'm thinking repack, but then I haven't 
tried it yet. In general jgit is almost as fast as git and probably 
outperforms git on windows as git there doesn't use  memory mapped I/O for 
packs (something I'd expect someone or even me to fix soon). For JNI'ed 
operations the complexity is just horrible and even when possible, there is
a lot of overhead for JNI itselt, conversion from UTF-16 to somehing 
eightbitish and back. On windows there's even yet another layer of 
eight-bitish to UTF-16 and back in the Win32 API. Jgit also uses memory
mapped I/O on all platforms that support it for pack reading.

If someone *did* make a fully reentrant libgit, I'd be inclined to balance my
opinions differently.

-- robin
