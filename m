From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 10:31:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505021028540.3594@ppc970.osdl.org>
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com>
 <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
 <20050502172012.GD11726@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Davidsen <davidsen@tmr.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 19:32:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSekf-0004Bj-7L
	for gcvg-git@gmane.org; Mon, 02 May 2005 19:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVEBRdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 13:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVEBRb4
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 13:31:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:19090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261315AbVEBR33 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 13:29:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j42HT3s4021215
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 10:29:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j42HT2IA007330;
	Mon, 2 May 2005 10:29:03 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050502172012.GD11726@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 2 May 2005, Ryan Anderson wrote:
>
> On Mon, May 02, 2005 at 09:31:06AM -0700, Linus Torvalds wrote:
> > That said, I think the /usr/bin/env trick is stupid too. It may be more 
> > portable for various Linux distributions, but if you want _true_ 
> > portability, you use /bin/sh, and you do something like
> > 
> > 	#!/bin/sh
> > 	exec perl perlscript.pl "$@"
> 		if 0;
> 
> You don't really want Perl to get itself into an exec loop.

This would _not_ be "perlscript.pl" itself. This is the shell-script, and 
it's not called ".pl".

In other words, you'd put this as ~/bin/cg-xxxx, and then "perlscript.pl" 
wouldn't be in the path at all, it would be in some separate install 
directory.

But hey, if people want to be safe for bad installations, add the extra 
line. Shell won't care ;)

		Linus
