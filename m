From: Florian Forster <octo@verplant.org>
Subject: [PATCH 5/7] Don't use empty structure initializers.
Date: Sun, 18 Jun 2006 17:18:07 +0200
Message-ID: <11506438893544-git-send-email-octo@verplant.org>
References: <11506438893167-git-send-email-octo@verplant.org>
Reply-To: Florian Forster <octo@verplant.org>
Cc: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 17:18:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frz2Y-0005I9-0a
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 17:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWFRPSP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 11:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWFRPSP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 11:18:15 -0400
Received: from verplant.org ([213.95.21.52]:35977 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1751174AbWFRPSN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 11:18:13 -0400
Received: from leeloo.lan.home.verplant.org ([2001:780:104:1:2e0:18ff:fead:37e4] ident=Debian-exim)
	by huhu.verplant.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Frz2S-0004Zb-8K; Sun, 18 Jun 2006 17:18:12 +0200
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=octo)
	by leeloo.lan.home.verplant.org with esmtp (Exim 4.62)
	(envelope-from <octo@verplant.org>)
	id 1Frz2P-00028O-DC; Sun, 18 Jun 2006 17:18:09 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3
In-Reply-To: <11506438893167-git-send-email-octo@verplant.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22086>

Empty initializers for structures are not allowed in ANSI C99. This patch
removes such an initializer from `builtin-read-tree.c'. Since the struct was
static (and is therefore implicitely initialized to zero anyway) it wasn't
actually needed.

Signed-off-by: Florian Forster <octo@verplant.org>


---

 builtin-read-tree.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

91df4330d35f1f1670dd04af0a14f1ca84a72b2b
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index bb50fbd..fdd6706 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -30,8 +30,7 @@ static int merge_size = 0;
 
 static struct object_list *trees = NULL;
 
-static struct cache_entry df_conflict_entry = {
-};
+static struct cache_entry df_conflict_entry;
 
 struct tree_entry_list {
 	struct tree_entry_list *next;
-- 
1.3.3
