From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: How do I...
Date: Sat, 07 May 2005 00:20:40 +0100
Message-ID: <1115421642.29495.53.camel@localhost.localdomain>
References: <427B3DB3.4000507@tuxrocks.com>
	 <Pine.LNX.4.58.0505060905090.2233@ppc970.osdl.org>
	 <7vsm10cnx3.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0505061006060.2233@ppc970.osdl.org>
	 <1115404771.16187.343.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505061158520.2233@ppc970.osdl.org>
	 <1115406628.16187.353.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0505061552140.2233@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Sorenson <frank@tuxrocks.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 01:15:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUC1s-0002n2-CD
	for gcvg-git@gmane.org; Sat, 07 May 2005 01:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVEFXVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 19:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVEFXVZ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 19:21:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59538 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261313AbVEFXVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 19:21:19 -0400
Received: from shinybook.infradead.org ([81.187.226.99])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DUC8A-0002sy-Cj; Sat, 07 May 2005 00:21:15 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505061552140.2233@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-06 at 15:57 -0700, Linus Torvalds wrote:
> To do that, you'd just have to always show the commit/parent pairs, 
> regardless of whether it had a difference or not.

Nah, you just prune the commits from which aren't interesting, then dump
the graph you're left with. So instead of printing just the immediate
parent(s) for each interesting commit, you print the "nearest
interesting ancestor(s)".

Take copy of rev-tree, let it mark commits as interesting if they touch
the file(s) in question, then effectively perform a list_del() on any
commit which _isn't_ interesting, and any merge which merges only
uninteresting commits... then dump the resulting pruned graph.

-- 
dwmw2

