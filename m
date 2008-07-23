From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Make non-static functions, that may be static, static
Date: Thu, 24 Jul 2008 01:09:35 +0200
Message-ID: <1216854575-25893-1-git-send-email-s-beyer@gmx.net>
Cc: gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 01:10:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLnTr-0000KT-6o
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbYGWXJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbYGWXJq
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:09:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:54775 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753907AbYGWXJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:09:45 -0400
Received: (qmail invoked by alias); 23 Jul 2008 23:09:43 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp042) with SMTP; 24 Jul 2008 01:09:43 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+WaBkhwjSWCG9OfQREPdvSkFeq74BkVnfrH70bQu
	+eYR1VS5Urflc2
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLnSh-0008P2-Af; Thu, 24 Jul 2008 01:09:35 +0200
X-Mailer: git-send-email 1.6.0.rc0.102.ga1791
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89801>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Or are there any reasons against that? :)

 builtin-commit.c       |    2 +-
 builtin-config.c       |    2 +-
 builtin-for-each-ref.c |    2 +-
 builtin-merge.c        |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 97e64de..9d7100c 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -877,7 +877,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	}
 }
 
-int git_commit_config(const char *k, const char *v, void *cb)
+static int git_commit_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "commit.template"))
 		return git_config_string(&template_file, k, v);
diff --git a/builtin-config.c b/builtin-config.c
index 0cf191a..91fdc49 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -145,7 +145,7 @@ free_strings:
 	return ret;
 }
 
-char *normalize_value(const char *key, const char *value)
+static char *normalize_value(const char *key, const char *value)
 {
 	char *normalized;
 
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 76282ad..445039e 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -809,7 +809,7 @@ static struct ref_sort *default_sort(void)
 	return sort;
 }
 
-int opt_parse_sort(const struct option *opt, const char *arg, int unset)
+static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
 {
 	struct ref_sort **sort_tail = opt->value;
 	struct ref_sort *s;
diff --git a/builtin-merge.c b/builtin-merge.c
index 8825dcf..e78fa18 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -431,7 +431,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		sha1_to_hex(remote_head->sha1), remote);
 }
 
-int git_merge_config(const char *k, const char *v, void *cb)
+static int git_merge_config(const char *k, const char *v, void *cb)
 {
 	if (branch && !prefixcmp(k, "branch.") &&
 		!prefixcmp(k + 7, branch) &&
-- 
1.6.0.rc0.102.ga1791
