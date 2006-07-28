From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Licensing and the library version of git
Date: Fri, 28 Jul 2006 01:04:45 -0400
Message-ID: <20060728050444.GA30783@spearce.org>
References: <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> <20060727195614.7EDAE353B04@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 28 07:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6KWx-00027g-0m
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 07:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWG1FE4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 01:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWG1FE4
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 01:04:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:28807 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932580AbWG1FEz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 01:04:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G6KWm-0005kB-8S; Fri, 28 Jul 2006 01:04:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 99EDB20E433; Fri, 28 Jul 2006 01:04:45 -0400 (EDT)
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20060727195614.7EDAE353B04@atlas.denx.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24365>

Wolfgang Denk <wd@denx.de> wrote:
> In message <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> you wrote:
> >
> > I see that someone is already writing a pure Java version which will
> > work around the GPL problem assuming the Java version is released
> > under a compatible license.
> 
> ... and assuming it is a clean-room  implementation  which  does  not
> borrow from the GPL code.

Heh.  This is actually possibly a problem.

I'm the person developing the Java implementation.

I've seen some of the core GIT code.  The reflog implementation is my
most notable contribution, but I've seen other things in there too.

Most of the Java code is quite different from the C code; the
largest common component is the pack delta decompressor.  I ran it
past Nico as he wrote the C version. He didn't seem to think that
the Java version was derived from the C version.

The issue there really was that the pack file format wasn't
completely documented external from the code (I actually found a
bug in the docs and submitted a patch to correct it) and the delta
format is definately not documented so I had to dig around in the
C code to figure it out.  On the other hand the commit format,
tree format and the loose object header were all clearly self
describing so I didn't need to go digging through the source to
figure out how to parse (or generate) them.

So yes, the Java implementation is derived from the C
(GPL'd!) implementation, but also no, its not...

I think its going to really just come down to a list consensus.
If Linus, Junio, Nico, et.al. think that my Java version is too
derived from the C GPL'd implementation to be released under any
license other than the GPL then I'll probably just abandon the code
line entirely, as the GPL is incompatible with the Sun JRE runtime
lirbary.  On the other hand its probably going to be released under
the IBM Common Public License or the Apache License.

-- 
Shawn.
