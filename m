From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH 2/3] Makefile: Add "make help" telling users to read INSTALL and Makefile
Date: Mon, 25 May 2009 18:07:10 -0400
Message-ID: <1243289231-32500-2-git-send-email-naesten@gmail.com>
References: <1243289231-32500-1-git-send-email-naesten@gmail.com>
Cc: git@vger.kernel.org, Samuel Bronson <naesten@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 26 00:08:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iKv-0003Kc-TQ
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbZEYWH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 18:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbZEYWH0
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:07:26 -0400
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:52748 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbZEYWH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 18:07:26 -0400
Received: from mr02.lnh.mail.rcn.net ([207.172.157.22])
  by smtp02.lnh.mail.rcn.net with ESMTP; 25 May 2009 18:07:28 -0400
Received: from smtp01.lnh.mail.rcn.net (smtp01.lnh.mail.rcn.net [207.172.4.11])
	by mr02.lnh.mail.rcn.net (MOS 3.10.5-GA)
	with ESMTP id PXI13374;
	Mon, 25 May 2009 18:07:27 -0400 (EDT)
Received: from 207-172-203-39.c3-0.upd-ubr7.trpr-upd.pa.cable.rcn.com (HELO hydrogen) ([207.172.203.39])
  by smtp01.lnh.mail.rcn.net with ESMTP; 25 May 2009 18:07:28 -0400
Received: from naesten by hydrogen with local (Exim 4.69)
	(envelope-from <naesten@gmail.com>)
	id 1M8iKM-0008Sv-No; Mon, 25 May 2009 18:07:26 -0400
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1243289231-32500-1-git-send-email-naesten@gmail.com>
X-Junkmail-Whitelist: YES (by domain whitelist at mr02.lnh.mail.rcn.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119968>

Without this, "make help" first builds "help.o", then tries to link it to
make a "help" executable, which might take a while to fail in a clean tree.

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index eaae45d..07a141d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,12 @@
 # The default target of this Makefile is...
 all::
 
+.PHONY: help
+help:
+	@echo 'Building:'
+	@echo '  For help on building, see the INSTALL file and the comments at'
+	@echo '  the top of Makefile'
+
 # Define V=1 to have a more verbose compile.
 #
 # Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
-- 
1.6.3.1
