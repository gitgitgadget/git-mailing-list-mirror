From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How do I...
Date: Fri, 6 May 2005 16:54:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505061652240.2233@ppc970.osdl.org>
References: <427B3DB3.4000507@tuxrocks.com>  <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
  <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0505061006060.2233@ppc970.osdl.org>
  <1115404771.16187.343.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.58.0505061158520.2233@ppc970.osdl.org> 
 <1115406628.16187.353.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.58.0505061552140.2233@ppc970.osdl.org>
 <1115421642.29495.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 01:51:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUCbV-0006WS-Vn
	for gcvg-git@gmane.org; Sat, 07 May 2005 01:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVEFXxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 19:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVEFXxO
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 19:53:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:32220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261337AbVEFXww (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 19:52:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46NqfU3016061
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 16:52:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46NqeMF007275;
	Fri, 6 May 2005 16:52:40 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115421642.29495.53.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 7 May 2005, David Woodhouse wrote:
> 
> Nah, you just prune the commits from which aren't interesting, then dump
> the graph you're left with. So instead of printing just the immediate
> parent(s) for each interesting commit, you print the "nearest
> interesting ancestor(s)".

Nope. That's just stupid. 

Use the whole commit history, and if you want to simplify it from there
once you notice that some branches end up never being interesting, then
that's ok.

But trying to be clever while building this up is just crazy talk. When
diff-tree prints out the changes, it has no way of knowing what the
context around it was - it doesn't know about merges far away, and it
_shouldn't_ know.

		Linus
