From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add SubmittingPatches
Date: Mon, 15 Aug 2005 17:24:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508151715520.3553@g5.osdl.org>
References: <7vslxep5jq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508160147560.26580@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 02:26:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4pGX-0006fw-JJ
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 02:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVHPAZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 20:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbVHPAZK
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 20:25:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36589 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965049AbVHPAZJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 20:25:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7G0OvjA008860
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 Aug 2005 17:24:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7G0OubQ023820;
	Mon, 15 Aug 2005 17:24:56 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508160147560.26580@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 16 Aug 2005, Johannes Schindelin wrote:
> 
> BTW, I don't know how many people still use pine, but for those poor souls 
> it may be good to mention that the quell-flowed-text is needed for recent 
> versions.

And 4.58 needs at least this

		Linus

---
diff-tree 8326dd8350be64ac7fc805f6563a1d61ad10d32c (from e886a61f76edf5410573e92e38ce22974f9c40f1)
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Mon Aug 15 17:23:51 2005 -0700

    Fix pine whitespace-corruption bug
    
    There's no excuse for unconditionally removing whitespace from
    the pico buffers on close.

diff --git a/pico/pico.c b/pico/pico.c
--- a/pico/pico.c
+++ b/pico/pico.c
@@ -219,7 +219,9 @@ PICO *pm;
 	    switch(pico_all_done){	/* prepare for/handle final events */
 	      case COMP_EXIT :		/* already confirmed */
 		packheader();
+#if 0
 		stripwhitespace();
+#endif
 		c |= COMP_EXIT;
 		break;
 
