From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 8 Sep 2005 08:06:51 +0200
Message-ID: <20050908060651.GA22734@c165.ib.student.liu.se>
References: <20050907164734.GA20198@c165.ib.student.liu.se> <Pine.LNX.4.63.0509071409470.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Sep 08 08:08:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDFZ9-0001Pq-Ow
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 08:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVIHGHE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 02:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVIHGHE
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 02:07:04 -0400
Received: from [85.8.31.11] ([85.8.31.11]:6113 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932624AbVIHGHC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 02:07:02 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 938B340FF; Thu,  8 Sep 2005 08:11:36 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EDFYh-0006BO-00; Thu, 08 Sep 2005 08:06:51 +0200
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509071409470.23242@iabervon.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8195>

On Wed, Sep 07, 2005 at 02:33:42PM -0400, Daniel Barkalow wrote:
> On Wed, 7 Sep 2005, Fredrik Kuivinen wrote:
> 
> > Of the 500 merge commits that currently exists in the kernel
> > repository 19 produces non-clean merges with git-merge-script. The
> > four merge cases listed in
> > <20050827014009.GB18880@c165.ib.student.liu.se> are cleanly merged by
> > git-merge-script. Every merge commit which is cleanly merged by
> > git-resolve-script is also cleanly merged by git-merge-script,
> > furthermore the results are identical. There are currently two merges
> > in the kernel repository which are not cleanly merged by
> > git-resolve-script but are cleanly merged by git-merge-script.
> 
> If you use my read-tree and change git-resolve-script to pass all of the 
> ancestors to it, how does it do? I expect you'll still be slightly ahead, 
> because we don't (yet) have content merge with multiple ancestors. You 
> should also check the merge that Tony Luck reported, which undid a revert, 
> as well as the one that Len Brown reported around the same time which had 
> similar problems. I think maintainer trees are a much better test for a 
> merge algorithm, because the kernel repository is relatively linear, while 
> maintainers tend more to merge things back and forth.

Junio tested some of the multiple common ancestor cases with your
version of read-tree and reported his results in
<7virxeycod.fsf@assigned-by-dhcp.cox.net>.

The two cases my algorithm merges cleanly and git-resolve-script do
not merge cleanly are 0e396ee43e445cb7c215a98da4e76d0ce354d9d7 and
0c168775709faa74c1b87f1e61046e0c51ade7f3. Both of them have two common
ancestors. The second one have, as far as I know, not been tested with
your read-tree.

The merge cases reported by Tony Luck and Len Brown are both cleanly
merged by my code.

You are probably right about the maintainer trees. I should have a
look at some of them. Do you know any specific repositories with
interesting merge cases?

- Fredrik
