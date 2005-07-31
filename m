From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sun, 31 Jul 2005 13:11:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507311305170.29650@g5.osdl.org>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 22:13:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzKBg-0000Zx-5b
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 22:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVGaUMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 16:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVGaUMN
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 16:12:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261982AbVGaUMI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 16:12:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6VKBxjA005648
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 31 Jul 2005 13:12:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6VKBwEY001157;
	Sun, 31 Jul 2005 13:11:59 -0700
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <200507312117.43957.Josef.Weidendorfer@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 31 Jul 2005, Josef Weidendorfer wrote:
>
> Added hook in git-receive-pack
> 
> After successful update of a ref,
> 
>  $GIT_DIR/hooks/update refname old-sha1 new-sha2
> 
> is called if present. This allows e.g sending of a mail
> with pushed commits on the remote repository.
> Documentation update with example hook included.

This looks sane. However, I also get the strong feeling that
git-update-server-info should be run as part of a hook and not be built 
into receive-pack..

Personally, I simply don't want to update any dumb server info stuff for 
my own local repositories - it's not like I'm actually serving those out 
anyway.

		Linus
