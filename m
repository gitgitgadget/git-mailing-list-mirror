From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 16:16:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181613490.15725@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
 <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418150456.GC12750@kroah.com>
 <Pine.LNX.4.58.0504180840370.7211@ppc970.osdl.org> <20050418220541.GB19744@kroah.com>
 <20050418221407.GA20290@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Russell King <rmk@arm.linux.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 01:12:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNfP1-0005je-05
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVDRXPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 19:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVDRXPY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 19:15:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261178AbVDRXPJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 19:15:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3INEns4008460
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 16:14:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3INEkLU010819;
	Mon, 18 Apr 2005 16:14:47 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050418221407.GA20290@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Greg KH wrote:
> 
> Anyway, I try it this way and get:

You should update to the newest version anyway..

> $ dotest ~/linux/patches/usb/usb-visor-tapwave_zodiac.patch             
> 
> Applying USB: visor Tapwave Zodiac support patch
> 
> fatal: preparing to update file 'drivers/usb/serial/visor.c' not uptodate in cache
> 
> What did I forget to do?

The most common reason is that the scripts _really_ want the index to 
match your current tree exactly. Run "update-cache --refresh". And if you 
have any uncommitted information, make sure to commit it first.

(Not _strictly_ true - you can leave edited files in your directory, and 
just hope the patch never touches them. The thing you should _not_ do is 
to do an "update-cache xxxx.c" to commit any changes to the 'index', 
because then the patch applicator will actually commit that one too).

		Linus
