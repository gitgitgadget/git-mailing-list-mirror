From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 09/11] initdb: make safe_create_dir public
Date: Mon,  9 Nov 2015 18:03:46 +0100
Message-ID: <3ca59b9ffc153e11361176249380ae605d73aafd.1447085798.git.mhagger@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:12:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvpz9-0006S8-JZ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbbKIRLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:11:53 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62822 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751698AbbKIRLx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 12:11:53 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2015 12:11:52 EST
X-AuditID: 1207440e-f79516d0000012b3-0a-5640d21460c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F6.34.04787.412D0465; Mon,  9 Nov 2015 12:04:20 -0500 (EST)
Received: from michael.fritz.box (p4FC97689.dip0.t-ipconnect.de [79.201.118.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA9H41Yw026059
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Nov 2015 12:04:19 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447085798.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqCtyySHMoHuutsX8TScYLbqudDNZ
	NPReYbaYNOUmk8XtFfOZLX609DBb9PZ9YnVg9/j7/gOTx85Zd9k9zh7M9HjWu4fR4+IlZY8F
	z++ze3zeJBfAHsVtk5RYUhacmZ6nb5fAndFyegJrwWKhivNzv7A1MJ7g62Lk5JAQMJG4e+gV
	O4QtJnHh3nq2LkYuDiGBy4wSy8+vBUsICZxgktg9VRPEZhPQlVjU08wEYosIqElMbDvEAtLA
	LPCRUWLuj4VgCWEBW4njP36xgdgsAqoSy+9vZQaxeQWiJG6vX8EMsU1OYsr9drB6TgELiR0n
	/jFCLDOXmLhqDdMERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUJC
	j28HY/t6mUOMAhyMSjy8ETPtw4RYE8uKK3MPMUpyMCmJ8kafcAgT4kvKT6nMSCzOiC8qzUkt
	PsQowcGsJMJbsAsox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4N10
	AahRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQb8cXA6ABJ8QDt3QHSzltckJgL
	FIVoPcWoKCXOK34RKCEAksgozYMbC0sorxjFgb4U5v0M0s4DTEZw3a+ABjMBDV7qDza4JBEh
	JdXAuGRBz4HQUlabrCs2zdu2Jmxh+M7Dn/FZ4/vF55P7mh5P+777iYD0UbWP/N/Tr/zoanA5
	aRg3M8a5+d2Hmd5zDyw+olB26Oi3ne8KF9RdObSua19Wi/vkr4d3rdF6uf2rD9c5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281066>

From: David Turner <dturner@twopensource.com>

Soon we will want to create initdb functions for ref backends, and
code from initdb that calls this function needs to move into the files
backend. So this function needs to be public.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c | 12 ------------
 cache.h           |  8 ++++++++
 path.c            | 12 ++++++++++++
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index f59f407..07229d6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -24,18 +24,6 @@ static int init_shared_repository = -1;
 static const char *init_db_template_dir;
 static const char *git_link;
 
-static void safe_create_dir(const char *dir, int share)
-{
-	if (mkdir(dir, 0777) < 0) {
-		if (errno != EEXIST) {
-			perror(dir);
-			exit(1);
-		}
-	}
-	else if (share && adjust_shared_perm(dir))
-		die(_("Could not make %s writable by group"), dir);
-}
-
 static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 			     DIR *dir)
 {
diff --git a/cache.h b/cache.h
index 9a905a8..0f9808c 100644
--- a/cache.h
+++ b/cache.h
@@ -1737,4 +1737,12 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 int versioncmp(const char *s1, const char *s2);
 void sleep_millisec(int millisec);
 
+/*
+ * Create a directory and (if share is nonzero) adjust its permissions
+ * according to the shared_repository setting. Only use this for
+ * directories under $GIT_DIR.  Don't use it for working tree
+ * directories.
+ */
+void safe_create_dir(const char *dir, int share);
+
 #endif /* CACHE_H */
diff --git a/path.c b/path.c
index 212695a..9e0283c 100644
--- a/path.c
+++ b/path.c
@@ -723,6 +723,18 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
+void safe_create_dir(const char *dir, int share)
+{
+	if (mkdir(dir, 0777) < 0) {
+		if (errno != EEXIST) {
+			perror(dir);
+			exit(1);
+		}
+	}
+	else if (share && adjust_shared_perm(dir))
+		die(_("Could not make %s writable by group"), dir);
+}
+
 static int have_same_root(const char *path1, const char *path2)
 {
 	int is_abs1, is_abs2;
-- 
2.6.2
