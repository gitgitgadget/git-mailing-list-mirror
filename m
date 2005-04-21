From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] Add DEST Makefile variable
Date: Thu, 21 Apr 2005 22:39:04 +1000 (EST)
Message-ID: <20050421123904.9F2EB7F8AD@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 14:48:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOb6P-00025y-3y
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 14:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVDUMwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 08:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVDUMwk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 08:52:40 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:52446 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261339AbVDUMwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 08:52:38 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DObAG-0004up-Jg
	for git@vger.kernel.org; Thu, 21 Apr 2005 14:52:22 +0200
Received: (nullmailer pid 1114 invoked by uid 501);
	Thu, 21 Apr 2005 12:52:16 -0000
Received: from [150.203.247.5] (helo=smurf.noris.de)
	by server.smurf.noris.de with esmtp (Exim 4.50)
	id 1DOb6J-0004lx-1B
	for smurf@smurf.noris.de; Thu, 21 Apr 2005 14:48:21 +0200
Received: by smurf.noris.de (Postfix, from userid 501)
	id 9F2EB7F8AD; Thu, 21 Apr 2005 22:39:04 +1000 (EST)
To: git@vger.kernel.org
X-Smurf-Spam-Score: -1.1 (-)
X-Smurf-Spam-Score: -1.4 (-)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch changes the Makefile to add a DEST variable (still defaulting
to ~/bin/) so that people (or scripts) can trivially install git
Somewhere Else.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

--- 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/Makefile  (mode:100644 sha1:1fef8e4ae93b2abae2ceb69c265c7c8176fe44c0)
+++ 265515f9c4f089b1b61e9d2312c4b3babe189618/Makefile  (mode:100644 sha1:af90bd4e1d53fa3b930c77a240b4681a0b2a886e)
@@ -8,6 +8,7 @@
 # break unless your underlying filesystem supports those sub-second times
 # (my ext3 doesn't).
 CFLAGS=-g -O3 -Wall
+DEST=$(HOME)/bin
 
 CC=gcc
 AR=ar
@@ -56,7 +57,7 @@
 	@chmod +x $@
 
 install: $(PROG) $(GEN_SCRIPT)
-	install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(HOME)/bin/
+	install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(DEST)/
 
 clean:
 	rm -f *.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE)
