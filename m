From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: SCSI trees, merges and git status
Date: Mon, 18 Apr 2005 14:39:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
References: <1113856118.4998.70.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, SCSI Mailing List <linux-scsi@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:34:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNdsK-0002x1-Ew
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 23:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVDRVhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 17:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVDRVhm
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 17:37:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:61591 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbVDRVhU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 17:37:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3ILbCs4032577
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 14:37:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3ILbAFo005607;
	Mon, 18 Apr 2005 14:37:11 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1113856118.4998.70.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, James Bottomley wrote:
>
> As of today, I have two SCSI git trees operational:
> 
> rsync://www.parisc-linux.org/~jejb/scsi-rc-fixes-2.6.git

Merged. Here's the command line history:

	~/git/git-pull-script rsync://www.parisc-linux.org/~jejb/scsi-rc-fixes-2.6.git
	merge-cache ~/git/git-merge-one-file-script -a
	write-tree 
	commit-tree 2c8de70faf92af971667a26a6a397052fc572add -p $(cat .git/HEAD) -p $(cat .git/MERGE_HEAD)

ie the "git-pull-script" failed due to the content merge (I didn't trust 
the merge-cache stuff enough to put that into it), but then doing the 
automated merge was successful without any editing, so I just wrote the 
tree and committed it.

Again, if anybody wants to reproduce this, you'll need to then do the

	checkout-cache -f -a
	update-cace --refresh

afterwards to make your working area match the merged tree.

> Linus, the rc-fixes repo is ready for applying ... it's the same one I
> announced on linux-scsi and lkml a while ago just with the git date
> information updated to be correct (the misc one should wait until after
> 2.6.12 is final).

Ok. Can you verify? I did a "git diff" between your old head and my new
head, and it did not show any SCSI files (only the expected arm etc stuff
that you didn't have in your), so it all _looks_ good. But hey, just to
make sure that I didn't do anything stupid..

		Linus
