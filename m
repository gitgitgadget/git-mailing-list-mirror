From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Missing statics.
Date: Thu,  7 Jun 2007 22:45:00 +0200
Message-ID: <1181249100664-git-send-email-madcoder@debian.org>
References: <118124910076-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 22:45:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwOr5-00084c-Nz
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 22:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763358AbXFGUpH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 16:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764282AbXFGUpH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 16:45:07 -0400
Received: from pan.madism.org ([88.191.52.104]:52103 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763358AbXFGUpF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 16:45:05 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8685FC0E5;
	Thu,  7 Jun 2007 22:45:01 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E1D85353E; Thu,  7 Jun 2007 22:45:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <118124910076-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49386>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-branch.c |    4 ++--
 builtin-revert.c |    2 +-
 daemon.c         |    2 +-
 wt-status.c      |    2 +-
 xdiff/xemit.c    |    4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 67f46c1..da48051 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -55,7 +55,7 @@ static int parse_branch_color_slot(const char *var, int ofs)
 	die("bad config variable '%s'", var);
 }
 
-int git_branch_config(const char *var, const char *value)
+static int git_branch_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "color.branch")) {
 		branch_use_color = git_config_colorbool(var, value);
@@ -72,7 +72,7 @@ int git_branch_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
-const char *branch_get_color(enum color_branch ix)
+static const char *branch_get_color(enum color_branch ix)
 {
 	if (branch_use_color)
 		return branch_colors[ix];
diff --git a/builtin-revert.c b/builtin-revert.c
index 80c348c..8f02ed7 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -107,7 +107,7 @@ static char *get_oneline(const char *message)
 	return result;
 }
 
-char *get_encoding(const char *message)
+static char *get_encoding(const char *message)
 {
 	const char *p = message, *eol;
 
diff --git a/daemon.c b/daemon.c
index 674e30d..4c8c322 100644
--- a/daemon.c
+++ b/daemon.c
@@ -439,7 +439,7 @@ static void parse_extra_args(struct interp *table, char *extra_args, int buflen)
 	}
 }
 
-void fill_in_extra_table_entries(struct interp *itable)
+static void fill_in_extra_table_entries(struct interp *itable)
 {
 	char *hp;
 
diff --git a/wt-status.c b/wt-status.c
index 4bfe8f1..5205420 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -198,7 +198,7 @@ static void wt_read_cache(struct wt_status *s)
 	read_cache();
 }
 
-void wt_status_print_initial(struct wt_status *s)
+static void wt_status_print_initial(struct wt_status *s)
 {
 	int i;
 	char buf[PATH_MAX];
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index e291dc7..86315b7 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -99,8 +99,8 @@ static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll) {
 }
 
 
-int xdl_emit_common(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
-		    xdemitconf_t const *xecfg) {
+static int xdl_emit_common(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
+                           xdemitconf_t const *xecfg) {
 	xdfile_t *xdf = &xe->xdf1;
 	const char *rchg = xdf->rchg;
 	long ix;
-- 
1.5.2.1
