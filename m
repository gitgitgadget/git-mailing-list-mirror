From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Cogito: Use git-rev-parse instead of cg-Xnormid.
Date: Sun, 3 Jul 2005 15:40:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507031535420.3570@g5.osdl.org>
References: <42C77ECE.2080903@didntduck.org> <20050703065920.GA11765@pasky.ji.cz>
 <42C7D925.2070007@didntduck.org> <20050703154127.GA31848@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 00:42:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpD9Y-0004wC-PC
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 00:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVGCWl0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 18:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVGCWlZ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 18:41:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261557AbVGCWlV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 18:41:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j63MevjA032033
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 3 Jul 2005 15:40:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j63MeqN9024849;
	Sun, 3 Jul 2005 15:40:55 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050703154127.GA31848@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 3 Jul 2005, Petr Baudis wrote:
> 
> That's right. Well, for everything but the short id matching we could
> just check the ID validity by git-rev-parse instead of peeking into
> the object store - I just did that.

What's the format of the short ID? Minimum 6 characters of the SHA1 or
something?

Pack-files in many ways should be even easier to look up the ID in, since
the pack-file index has all the SHA1's for that pack file listed in sorted
order, so it should be fairly easy to just look it up based on the first
few bytes.. If somebody sends me a patch, that should be fine.

> > The only thing missing is the short id matching.
> 
> Yes, but as I said, I think it's very important to have. BTW, another
> cool thing cg-Xnormid does and git-rev-parse does not: time specifiers.
> E.g. you could specify revisions as "2 days ago" or so, very useful for
> cg-log, cg-diff and such.

That is indeed something that seems to make more sense in cg-Xnormid.

		Linus
