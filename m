From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 09:44:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504170937020.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <20050417170539.B13233@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 18:39:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCnH-0002FI-6W
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVDQQmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVDQQmd
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:42:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:49603 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261357AbVDQQm0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:42:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HGgHs4001077
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 09:42:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HGgGJV025777;
	Sun, 17 Apr 2005 09:42:17 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050417170539.B13233@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Russell King wrote:
> 
> BTW, there appears to be "errors" in the history committed thus far.
> I'm not sure where this came from though.  Some of them could be
> UTF8 vs ASCII issues, but there's a number which seem to have extra
> random crap in them ("^M)" and lots of blank lines).

Ah, yes. That is actually from the original emails from Andrew. I do not 
know why, but I see them there. It's his script that does something 
strange.

(Andrew: in case you care, the first one is

	[patch 003/198] arm: fix SIGBUS handling

which has the email looking like

	...
	From: akpm@osdl.org
	Date: Tue, 12 Apr 2005 03:30:35 -0700
	Status: 
	X-Status: 
	X-Keywords:                   
	
	^M)
	
	
	From: Russell King <rmk+lkml@arm.linux.org.uk>
	
	ARM wasn't raising a SIGBUS with a siginfo structure.  Fix
	__do_user_fault() to allow us to use it for SIGBUS conditions, and arrange
	for the sigbus path to use this.
	...

> One thing which definitely needs to be considered is - what character
> encoding are the comments to be stored as?

To git, it's just a byte stream, and you can have binary comments if you
want to. I personally would prefer to move towards UTF eventually, but I
really don't think it matters a whole lot as long as 99.9% of everything
we'd see there is still 7-bit ascii.

> ID: 75f86bac962b7609b0f3c21d25e10647ff8ed280
> [PATCH] intel8x0: AC'97 audio patch for Intel ESB2
>          
>         This patch adds the Intel ESB2 DID's to the intel8x0.c file for AC'97 audio
>         support.
>          
>         Signed-off-by: <A0>Jason Gaston <Jason.d.gaston@intel.com>

That <A0> is also there in Andrew's original email. It's "space with the
high bit set", and I have no idea why.

		Linus
