From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Tue, 28 Jun 2005 22:54:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506282252001.14331@ppc970.osdl.org>
References: <20050624.212009.92584730.davem@davemloft.net> <42BCE026.8050405@pobox.com>
 <Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org> <42BCF02B.5090706@pobox.com>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
 <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
 <Pine.LNX.4.58.0506281201510.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506281655140.1667@localhost.localdomain>
 <Pine.LNX.4.58.0506281424420.19755@ppc970.osdl.org>
 <Pine.LNX.4.63.0506282314320.1667@localhost.localdomain>
 <Pine.LNX.4.63.0506290111250.1667@localhost.localdomain>
 <Pine.LNX.4.58.0506282243180.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 29 07:45:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnVNt-0007v4-DE
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 07:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVF2Fw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 01:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVF2Fw1
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 01:52:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262435AbVF2FwY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 01:52:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5T5qLjA023727
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 22:52:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5T5qKYG022490;
	Tue, 28 Jun 2005 22:52:20 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.58.0506282243180.19755@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Linus Torvalds wrote:
> 
> On Wed, 29 Jun 2005, Nicolas Pitre wrote:
> > 
> > Of course by the time I sent the above you already rewrote the ting to 
> > be streamable.
> 
> And by the time you sent me a new version, I'd already taken part of your 
> old one by hand ;)

Btw, I have the size/type bits reversed from your setup, but please don't 
change that, since that would be yet another incompatible pack format 
change, and I'd like to calm things down.

Also, I notice that you decode the sizes really strangely: you have a 
"while() { }" loop and two separate loads. It's much nicer to do it with a 
"do { } while()" loop and a single load, since not only is it less code, 
a do-while loop compiles to better code than a while() loop (unless the 
compiler is crazy, which it sometimes is).

		Linus
