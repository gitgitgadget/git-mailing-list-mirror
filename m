From: Petr Baudis <pasky@suse.cz>
Subject: Makefile: COPTS vs CFLAGS
Date: Fri, 29 Jul 2005 15:40:11 +0200
Message-ID: <20050729134011.GD21909@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 29 15:45:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyVAB-0004CK-Ux
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 15:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVG2NoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 09:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVG2Nli
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 09:41:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22800 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262583AbVG2NkN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 09:40:13 -0400
Received: (qmail 31482 invoked by uid 2001); 29 Jul 2005 13:40:11 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  one more thing - should we keep the $COPTS variable? Most projects
(including Cogito) have the C flags controlled by the $CFLAGS variable.

  What I would propose:

	-COPTS=-g -O2
	-CFLAGS=$(COPTS) -Wall
	+CFLAGS?=-g -O2
	+CFLAGS+=-Wall

  That is, if user does not specify custom $CFLAGS, default to "-g -O2",
and always append -Wall (and more after I'll send my Makefile patches).

  Opinions?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
