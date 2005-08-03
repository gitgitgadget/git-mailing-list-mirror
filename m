From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 19:08:22 +0200
Message-ID: <200508031908.22562.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0508030944210.3258@g5.osdl.org> <Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 03 19:11:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Mjf-00058w-3g
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVHCRIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVHCRIv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:08:51 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:35023 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262348AbVHCRIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 13:08:50 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 03 August 2005 18:50, you wrote:
> Hi,
>
> On Wed, 3 Aug 2005, Linus Torvalds wrote:
> > Are you sure you have a good git version on master? I've never seen
> > anything like that, and I push all the time..
>
> Call him Zaphod: he has two heads (master and pu). You don't. As I said in
> another mail, this could be very well related to Junio's problems.

Yes it is. To reproduce:
Create a repository with 2 branches.
Make 2 clones of the 2 branches via SSH.
Make a commit on one clone and push.
Make another commit on the other clone and push => ERROR

A log of this last push:
=============================================
~/tmp/git/clone2> cg-push
'refs/heads/branch2': updating from 80e4d426dd4c865b943cc1121b580a946eee921d 
to 8196067677e3415ce404ea5bc35731ac7d56115d
fatal: bad object f7e944b036fd00af656b262140c1dc93ceffadb1
Packing 0 objects
Unpacking 0 objects

fatal: unpack should have generated 8196067677e3415ce404ea5bc35731ac7d56115d, 
but I can't find it!
=============================================

f7e9... is the commit pushed from the first clone.

I had the same problem yesterday.

Josef
