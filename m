From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Deb Packaging fixes: Build against Mozilla libs for
 Debian, conflict with "git"
Date: Sat, 23 Jul 2005 09:24:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507230921320.6074@g5.osdl.org>
References: <20050723073707.GA3255@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 18:27:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwMq2-0000UJ-Vi
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 18:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVGWQ0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 12:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVGWQ0N
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 12:26:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262087AbVGWQYy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 12:24:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6NGOYjA002709
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Jul 2005 09:24:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6NGOX89027819;
	Sat, 23 Jul 2005 09:24:34 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050723073707.GA3255@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Jul 2005, Ryan Anderson wrote:
> 
>     * Compile against the unencumbered Mozilla SHA1 code, instead of
>       the iffy OpenSSL code.  This makes it easier to get the package
>       included for distribution with Debian.

Note that this is just not true.

We still use openssl for the bignum stuff in epoch.c, so using the mozilla
SHA1 libraries just doesn't make any difference at all from an openssl 
standpoint. You'd have to disable the "--merge-order" flag entirely to get 
rid of the openssl dependency, methinks.

		Linus
