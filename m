From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 22:50:09 +0200
Message-ID: <1114462210.8442.54.camel@laptopd505.fenrus.org>
References: <426CD1F1.2010101@tiscali.de>
	 <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
	 <426D21FE.3040401@tiscali.de>
	 <Pine.LNX.4.58.0504251021280.18901@ppc970.osdl.org>
	 <426D33BA.8040604@tiscali.de>
	 <Pine.LNX.4.58.0504251147290.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 22:46:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQASY-0003tq-H8
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 22:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVDYUub (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 16:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDYUub
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 16:50:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61347 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261161AbVDYUuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 16:50:17 -0400
Received: from g133107.upc-g.chello.nl ([80.57.133.107] helo=[172.31.3.43])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DQAWy-0004Qi-DF; Mon, 25 Apr 2005 21:50:13 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251147290.18901@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-25 at 11:50 -0700, Linus Torvalds wrote:
> 
> On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
> >
> > But this makes, like "register", direct use of processor registers (it
> > stores int arguments in eax, ebx, etc.).
> 
> No. It make _unlike_ "register", direct use of processor registers.
> 
> The "register" keyword does _not_ use processor registers. It's just 
> syntactic fluff, and tells the compiler exactly one thing:
> 
>  - that the compiler should warn if you take the address of such a thing.
> 
> In addition, the compiler may generate code that takes it into account, 
> which most likely means _worse_ code than if it didn't take it into 
> account.

afaik gcc just otherwise ignores it entirely.


