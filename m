From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [CORRECTED PATCH] git-fetch-pack: avoid unnecessary zero packing
Date: Tue, 18 Oct 2005 13:42:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181339220.3369@g5.osdl.org>
References: <Pine.LNX.4.64.0510181049050.17201@g5.osdl.org>
 <7vmzl6r78e.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510181333380.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 18 22:45:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERyII-0004Zj-Ma
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 22:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbVJRUmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 16:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbVJRUmm
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 16:42:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751494AbVJRUml (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 16:42:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9IKgbFC009190
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 13:42:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9IKgaUV029976;
	Tue, 18 Oct 2005 13:42:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0510181333380.3369@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10230>



On Tue, 18 Oct 2005, Linus Torvalds wrote:
> 
> I'll see if I can come up with a good patch.

I see you already did. Looks fine. I'd suggest limiting the commits by 
number in mark_recent_commit_complete(), because

 (a) somebody might have their clock set wrong and you don't want to walk 
     a huge tree just because of something like that.
 (b) you might just have imported a huge history (badly) from somewhere 
     else
 (c) a _lot_ can happen in five days with automated things.

but yes, the approach looks very sane otherwise.

		Linus
