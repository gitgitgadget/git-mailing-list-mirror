From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] "checkout-cache -m" writes unmerged contents for each
 stage.
Date: Sun, 17 Apr 2005 19:56:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171954410.7211@ppc970.osdl.org>
References: <7v1x99vwdg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504171833450.7211@ppc970.osdl.org> <7vfyxovm6j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:51:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNMLU-0003NG-Tw
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVDRCyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDRCyh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:54:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:52966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261619AbVDRCyf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:54:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3I2sVs4009883
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 19:54:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3I2sUUU021150;
	Sun, 17 Apr 2005 19:54:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyxovm6j.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Junio C Hamano wrote:
> 
> One small detail.  What about the "-x" bit?

You'll need to merge those kinds of changes separately for now. We'll have 
to resolve that too, right now I think the -x bit gets lost on a merge 
simply because we just write the temp-files, something merges them, and 
does an "update-cache" on the merged result, and we'll pick up the -x bit 
(or rather, lack of one) at that point.

		Linus
