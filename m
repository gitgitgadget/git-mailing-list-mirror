From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 20:16:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0703301855480.4757@poirot.grange>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
 <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
 <20070329214654.GI6143@fieldses.org> <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
 <Pine.LNX.4.64.0703291531030.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 20:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXLf3-0007hI-1c
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 20:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbXC3SRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 14:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbXC3SRO
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 14:17:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:56052 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750714AbXC3SRM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 14:17:12 -0400
Received: (qmail invoked by alias); 30 Mar 2007 18:17:10 -0000
Received: from dynamic-unidsl-85-197-31-110.westend.de (EHLO poirot.grange) [85.197.31.110]
  by mail.gmx.net (mp045) with SMTP; 30 Mar 2007 20:17:10 +0200
X-Authenticated: #20450766
X-Provags-ID: V01U2FsdGVkX1/K+k9rvY7KDodf43B7oxlXpjPt6Mf6fCtKBHsOnH
	T3+R4Wro+/GGAY
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1HXLek-0002gx-00; Fri, 30 Mar 2007 20:16:58 +0200
In-Reply-To: <Pine.LNX.4.64.0703291531030.6730@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Mar 2007, Linus Torvalds wrote:

> On Fri, 30 Mar 2007, Guennadi Liakhovetski wrote:
> 
> > Strange. Is my git 1.4.0 criminally broken? I have a clone of Linus' tree 
> > on a USB disk on ext3 without any objects, which I just cloned at some 
> > point and then did a couple of pulls from the same source. Now
> > 
> > 1545084 /mnt/sda2/kernel-git/linux-2.6/
> > 1255084 /mnt/sda2/kernel-git/linux-2.6/.git
> 
> The old git that always exploded all pulls and generated lots of loose 
> objects? You can check with "git count-objects".

Installed 1.5.0.6 and its output of "git count-objects" is

180932 objects, 1112656 kilobytes

git gc removed everything (uh?) and then

linux-2.6$ du -ks .git
183040  .git

cool...

> And to fix it, just do a "git gc" (or with older git versions, the secret 
> handshake is just a simple "git repack -a -d").
> 
> > But that's a freshly cloned tree, without any pulls. I re-cloned it, 
> > because the tree I had earlier had the problem with each pull:
> > 
> > Unpacking 12452 objects
> >  100% (12452/12452) done
> > * refs/heads/origin: does not fast forward to branch 'master' of 
> > git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc;
> >   not updating.
> 
> Sounds like either Paul re-based his tree, or you did some work on your 
> "origin" branch..

It must be the former then:-) Did I have a chance to re-synchronize 
locally to be able to pull normally again or was the only way to re-clone?

Thanks
Guennadi
---
Guennadi Liakhovetski
