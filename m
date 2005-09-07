From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Wed, 7 Sep 2005 14:33:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509071409470.23242@iabervon.org>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Sep 07 20:32:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED4gB-000495-6X
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 20:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVIGS3q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 14:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVIGS3q
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 14:29:46 -0400
Received: from iabervon.org ([66.92.72.58]:64520 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932191AbVIGS3q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 14:29:46 -0400
Received: (qmail 5237 invoked by uid 1000); 7 Sep 2005 14:33:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Sep 2005 14:33:42 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050907164734.GA20198@c165.ib.student.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8172>

On Wed, 7 Sep 2005, Fredrik Kuivinen wrote:

> Of the 500 merge commits that currently exists in the kernel
> repository 19 produces non-clean merges with git-merge-script. The
> four merge cases listed in
> <20050827014009.GB18880@c165.ib.student.liu.se> are cleanly merged by
> git-merge-script. Every merge commit which is cleanly merged by
> git-resolve-script is also cleanly merged by git-merge-script,
> furthermore the results are identical. There are currently two merges
> in the kernel repository which are not cleanly merged by
> git-resolve-script but are cleanly merged by git-merge-script.

If you use my read-tree and change git-resolve-script to pass all of the 
ancestors to it, how does it do? I expect you'll still be slightly ahead, 
because we don't (yet) have content merge with multiple ancestors. You 
should also check the merge that Tony Luck reported, which undid a revert, 
as well as the one that Len Brown reported around the same time which had 
similar problems. I think maintainer trees are a much better test for a 
merge algorithm, because the kernel repository is relatively linear, while 
maintainers tend more to merge things back and forth.

	-Daniel
*This .sig left intentionally blank*
