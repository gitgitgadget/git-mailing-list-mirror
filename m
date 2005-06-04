From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: proper lazy reachability
Date: Sat, 4 Jun 2005 08:51:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506040847170.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
 <17052.21846.816147.370354@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org>
 <Pine.LNX.4.58.0505310813540.1876@ppc970.osdl.org> <7vekbigo8q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506040837190.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 17:46:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeaqV-0004AR-N7
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 17:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVFDPtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 11:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVFDPtR
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 11:49:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:36794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261355AbVFDPtN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 11:49:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j54Fn9jA017050
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Jun 2005 08:49:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j54Fn8Cd026650;
	Sat, 4 Jun 2005 08:49:08 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0506040837190.1876@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 4 Jun 2005, Linus Torvalds wrote:
> 
> Does this fix it for you (untested, of course)?

Btw, as shown by this patch, the lazy git-rev-list algorithm is actually
_supposed_ to be able to handle a lot more complicated cases than what the 
command line interface allows.

In other words, maybe I should have used the same syntax as for 
git-rev-tree, because it _can_ handle things like "show me all revisions 
that are reachable from a or b, but are _not_ reachable from c or d or e.

Is that useful? I dunno. It might be useful for somebody like Jeff, who
has lots of different heads, and he could say "ok, show me what is in all
my network driver heads, but isn't in linus' tree".

Would people prefer to have "git-rev-list" take arguments like

	git-rev-list a b ^c ^d

the way git-rev-tree does?

		Linus
