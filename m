From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 00:13:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
 <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
 <20070329214654.GI6143@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 00:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX2rm-0007c3-KY
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 00:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934358AbXC2WNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 18:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934360AbXC2WNG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 18:13:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:39539 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934361AbXC2WNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 18:13:05 -0400
Received: (qmail invoked by alias); 29 Mar 2007 22:13:02 -0000
Received: from dynamic-unidsl-85-197-31-110.westend.de (EHLO poirot.grange) [85.197.31.110]
  by mail.gmx.net (mp038) with SMTP; 30 Mar 2007 00:13:02 +0200
X-Authenticated: #20450766
X-Provags-ID: V01U2FsdGVkX19pVfkOJeVpcSUyY97j8DRsu05dWYm3F93hysVoWH
	obzGlhQ8rPrhhC
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1HX2re-00042n-00; Fri, 30 Mar 2007 00:13:02 +0200
In-Reply-To: <20070329214654.GI6143@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43482>

On Thu, 29 Mar 2007, J. Bruce Fields wrote:

> On Thu, Mar 29, 2007 at 02:26:10PM -0700, Junio C Hamano wrote:
> > 
> > How about suggesting "clone -l -s"?

Yes, but how do "advanced git users" kernel developers work? Do they just 
do 1 clone and build / clean every time they want to test another 
configuration / arch, or do they clone -l or what? Do they create branches 
for each development thread, then pull / push between trees?...

> If you really want to share as much as possible, then I guess you want
> to share the working trees too, since (as evidenced above), they're at
> least as large as the compressed history.

But I don't want to re-build. Apart from i386 I build for a couple of ARM 
and PPC targets too...

> Though actually on a second look, clone -l -s produces something that's
> only 377M.  I hadn't realized how much space the build output takes up.
> So judging from du the 1.5G Guennadi Liakhovetski mentions above seems
> to break down into something like:
> 
> 	330M .git
> 	380M working tree
> 	750M build output

Strange. Is my git 1.4.0 criminally broken? I have a clone of Linus' tree 
on a USB disk on ext3 without any objects, which I just cloned at some 
point and then did a couple of pulls from the same source. Now

1545084 /mnt/sda2/kernel-git/linux-2.6/
1255084 /mnt/sda2/kernel-git/linux-2.6/.git

Interestingly, both end up with 5084. For comparison:

465044  /mnt/sda2/kernel-git/powerpc
174980  /mnt/sda2/kernel-git/powerpc/.git

But that's a freshly cloned tree, without any pulls. I re-cloned it, 
because the tree I had earlier had the problem with each pull:

Unpacking 12452 objects
 100% (12452/12452) done
* refs/heads/origin: does not fast forward to branch 'master' of 
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc;
  not updating.

Wonderful and strange git world...

Thanks
Guennadi
---
Guennadi Liakhovetski
