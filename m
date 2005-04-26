From: Sean Neakums <sneakums@zork.net>
Subject: Re: [PATCH] Cogito: do not clobber pre-existing $(bindir)'s mode
Date: Tue, 26 Apr 2005 11:52:21 +0100
Message-ID: <6usm1dizdm.fsf@zork.zork.net>
References: <6uwtqpj0oy.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 26 12:49:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQNcc-0004Mp-0p
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 12:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVDZKxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 06:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVDZKxb
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 06:53:31 -0400
Received: from zork.zork.net ([64.81.246.102]:18654 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261491AbVDZKwZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 06:52:25 -0400
Received: from sneakums by zork.zork.net with local (Exim 4.50)
	id 1DQNfx-0003kO-82
	for git@vger.kernel.org; Tue, 26 Apr 2005 03:52:21 -0700
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <6uwtqpj0oy.fsf@zork.zork.net> (Sean Neakums's message of "Tue,
	26 Apr 2005 11:23:57 +0100")
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is one that actually works.

That'll teach me to be tricky.  (It won't.)


Index: Makefile
===================================================================
--- f262000f302b749e485f5eb971e6aabefbb85680/Makefile  (mode:100644 sha1:4f01bbbbb3fd0e53e9ce968f167b6dae68fcfa92)
+++ uncommitted/Makefile  (mode:100644)
@@ -95,7 +95,7 @@
 	@chmod +x $@
 
 install: $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT)
-	install -m755 -d $(DESTDIR)$(bindir)
+	[ -d $(DESTDIR)$(bindir) ] || install -m755 -d $(DESTDIR)$(bindir)
 	install $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
 
 clean:

-- 
Dag vijandelijk luchtschip de huismeester is dood
