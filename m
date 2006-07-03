From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Compression speed for large files
Date: Mon, 3 Jul 2006 16:02:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607031556480.12404@g5.osdl.org>
References: <loom.20060703T124601-969@post.gmane.org>
 <20060703214503.GA3897@coredump.intra.peff.net> <44A99961.8090504@fys.uio.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Joachim B Haga <cjhaga@student.matnat.uio.no>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 01:05:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxXRO-00065e-TT
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 01:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWGCXCt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 19:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWGCXCt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 19:02:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932287AbWGCXCs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 19:02:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k63N2enW001493
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 16:02:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k63N2dBb005541;
	Mon, 3 Jul 2006 16:02:40 -0700
To: Joachim Berdal Haga <c.j.b.haga@fys.uio.no>
In-Reply-To: <44A99961.8090504@fys.uio.no>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23223>



On Tue, 4 Jul 2006, Joachim Berdal Haga wrote:
> 
> Here's a test with "time gzip -[169] -c file >/dev/null". Random data
> from /dev/urandom, kernel headers are concatenation of *.h in kernel
> sources. All times in seconds, on my puny home computer (1GHz Via Nehemiah)

That "Via Nehemiah" is probably a big part of it.

I think the VIA Nehemiah just has a 64kB L2 cache, and I bet performance 
plummets if the tables end up being used past that. 

And I think a large part of the higher compressions is that they allow the 
compression window and tables to grow bigger.

		Linus
