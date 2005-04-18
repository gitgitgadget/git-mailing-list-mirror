From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 15:01:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181459500.15725@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
 <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418102332.A21081@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0504180802060.7211@ppc970.osdl.org> <20050418225356.B16789@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:55:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNeDC-0005nH-5H
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 23:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDRV7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 17:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVDRV7V
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 17:59:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:12957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261179AbVDRV7S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 17:59:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3ILxBs4001683
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 14:59:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3ILxAdX006637;
	Mon, 18 Apr 2005 14:59:10 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050418225356.B16789@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Russell King wrote:
> > 
> > 	# Get the trees associated with those commits
> > 	common_tree=tree=$(cat-file commit $common | sed 's/tree //;q')
> > 	head_tree=tree=$(cat-file commit $head | sed 's/tree //;q')
> > 	merge_tree=tree=$(cat-file commit $merge | sed 's/tree //;q')
> 
> This wants to be:
> 
> 	common_tree=$(cat-file commit $common | sed 's/tree //;q')
> 	head_tree=$(cat-file commit $head | sed 's/tree //;q')
> 	merge_tree=$(cat-file commit $merge_head | sed 's/tree //;q')

Yup, I already fixed that in the current git version.

> > 		read-tree $merge_tree && checkout-cache -f -a
> 
> Don't we want to do an update-cache --refresh here?

Yes. Thanks, added.

		Linus
