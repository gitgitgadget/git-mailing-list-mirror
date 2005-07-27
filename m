From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux BKCVS kernel history git import..
Date: Wed, 27 Jul 2005 08:50:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507270846360.3227@g5.osdl.org>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org> 
 <1122457238.3027.37.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0507270819550.3227@g5.osdl.org> <1122478870.28128.52.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tglx@linutronix.de, Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262430AbVG0Pww@vger.kernel.org Wed Jul 27 18:00:32 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262430AbVG0Pww@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxoJt-0005LR-RH
	for glk-linux-kernel@gmane.org; Wed, 27 Jul 2005 17:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVG0Pww (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Wed, 27 Jul 2005 11:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVG0Pwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:52:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38842 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262398AbVG0Puw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:50:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6RFoWjA030175
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Jul 2005 08:50:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6RFoRIr027180;
	Wed, 27 Jul 2005 08:50:29 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1122478870.28128.52.camel@hades.cambridge.redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jul 2005, David Woodhouse wrote:
> 
> Hm, OK. That works and can also be used for the "fake _absence_ of
> parent" thing -- if I'm space-constrained and want only the history back
> to some relatively recent point like 2.6.0, I can do that by turning the
> 2.6.0 commit into an orphan instead of also using all the rest of the
> history back to 2.4.0. 

Yes. The grafting really should work pretty well for various things like
this, and at the same time I don't think it's ever going to be a huge 
problem: people may have a couple of graft-points (if you want to drop 
history, you may well have more than one point you need to "cauterize": 
you may not be able to just cut it off at 2.6.0, since there may be merges 
furhter back in history), but I don't think it's going to explode and 
become unwieldly.

I just don't see people having more than a few trees that they might want
to graft together, and while the "drop history" thing might cause more
issues, even that is bounded by the amount of development parallellism, so 
while it probably causes more graft-points than the "join trees" usage, it 
should still be just a small handful of points.

			Linus
