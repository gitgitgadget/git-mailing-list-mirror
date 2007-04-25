From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 2/5] entry.c: Use const qualifier for 'struct checkout'
 parameters
Date: Wed, 25 Apr 2007 11:18:08 -0300
Organization: Mandriva
Message-ID: <20070425111808.36ebef4d@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Apr 25 16:18:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgiKM-00042K-4E
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 16:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbXDYOSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 10:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754624AbXDYOSN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 10:18:13 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:46408 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbXDYOSL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 10:18:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id D62AD17AE2;
	Wed, 25 Apr 2007 11:18:09 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id hloyRJy60LRp; Wed, 25 Apr 2007 11:18:09 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 9398117AE0;
	Wed, 25 Apr 2007 11:18:09 -0300 (BRT)
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45528>

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 cache.h |    2 +-
 entry.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 89aaf00..fe1e2e8 100644
--- a/cache.h
+++ b/cache.h
@@ -377,7 +377,7 @@ struct checkout {
 		 refresh_cache:1;
 };
 
-extern int checkout_entry(struct cache_entry *ce, struct checkout *state, char *topath);
+extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/entry.c b/entry.c
index b51addb..82bf725 100644
--- a/entry.c
+++ b/entry.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 
-static void create_directories(const char *path, struct checkout *state)
+static void create_directories(const char *path, const struct checkout *state)
 {
 	int len = strlen(path);
 	char *buf = xmalloc(len + 1);
@@ -75,7 +75,7 @@ static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned
 	return NULL;
 }
 
-static int write_entry(struct cache_entry *ce, char *path, struct checkout *state, int to_tempfile)
+static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
 {
 	int fd;
 	long wrote;
@@ -163,7 +163,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 	return 0;
 }
 
-int checkout_entry(struct cache_entry *ce, struct checkout *state, char *topath)
+int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath)
 {
 	static char path[PATH_MAX + 1];
 	struct stat st;
-- 
1.5.1.1.320.g1cf2
