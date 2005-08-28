From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Sun, 28 Aug 2005 10:46:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508281045060.3317@g5.osdl.org>
References: <19723.1125249085@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 19:47:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9RFN-0001eP-OA
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 19:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVH1RrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 13:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVH1RrG
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 13:47:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750714AbVH1RrF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2005 13:47:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7SHkxjA015207
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 Aug 2005 10:46:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7SHkwtU023503;
	Sun, 28 Aug 2005 10:46:58 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <19723.1125249085@lotus.CS.Berkeley.EDU>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7881>



On Sun, 28 Aug 2005, Jason Riedy wrote:
> 
> I'm fine with requiring a limited C99 compiler.  A
> pedantic compiler will reject members with a length
> of zero.  6.7.5.2 para1 requires a value greater than
> zero for a constant array size.  So the code now (with
> [0] decls) is neither C89 nor C99.

But using "array[]" means that "sizeof()" no longer works, and then you 
have to use "offsetof()", which is a big pain.

I think all relevant compilers end up accepting [0] (probably giving a
warning, especially in some pedantic mode), since it's been how gcc users
have been doing things for years (gcc was late to the [] syntax).

			Linus
