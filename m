From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/4] git-fetch-pack: Implement client part of the multi_ack extension
Date: Tue, 25 Oct 2005 22:47:54 +0200
Message-ID: <20051025204754.GA8030@steel.home>
References: <Pine.LNX.4.63.0510230339090.21239@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Oct 25 22:48:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUViV-0006xP-62
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 22:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVJYUsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 16:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVJYUsQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 16:48:16 -0400
Received: from devrace.com ([198.63.210.113]:32011 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932374AbVJYUsP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 16:48:15 -0400
Received: from tigra.home (p54A0D7D2.dip.t-dialin.net [84.160.215.210])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j9PKlvaf067154;
	Tue, 25 Oct 2005 15:47:58 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EUVi6-0007v7-00; Tue, 25 Oct 2005 22:47:54 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EUVi6-0003Op-9j; Tue, 25 Oct 2005 22:47:54 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510230339090.21239@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.6 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10614>

Johannes Schindelin, Sun, Oct 23, 2005 03:40:13 +0200:
> This patch concludes the series, which makes 
> git-fetch-pack/git-upload-pack negotiate a potentially better set of 
> common revs. It should make a difference when fetching from a repository 
> with a few branches.

This broke git-pull for me (the local one):

    /d/e/f.git$ git-pull
    fatal: bad pack file
    fatal: git-unpack-objects died with error code 128
    Fetch failure: /a/b/c/.git

> applies-to: 6b4b7d9acf60aa99d961b599f37d0c824be79e27
> 9adb6b3971e7daa79221d7dbe05b66327b266b86
...
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 3a903c4..57602b9 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c

Reverting just fetch-pack.c part of the patch helps.
