Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3181F404
	for <e@80x24.org>; Sun, 31 Dec 2017 08:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbdLaIGP (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 03:06:15 -0500
Received: from mout.web.de ([217.72.192.78]:53472 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbdLaIGM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 03:06:12 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyUgM-1f1xLg1ONC-015ngD; Sun, 31
 Dec 2017 09:05:54 +0100
From:   tboegi@web.de
To:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/5] convert_to_git(): checksafe becomes an integer
Date:   Sun, 31 Dec 2017 09:05:52 +0100
Message-Id: <20171231080552.22258-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.4.ga4e00d4fa4
In-Reply-To: <20171229152222.39680-1-lars.schneider@autodesk.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:6YOK5wRyoAZMmMB/vL9N+f/TYVaKBtxgycGICBRbl7uoe4djMiU
 TOGSReiDlCbCT9iPHojxsPcW7dPtZovXSVBNxWWwl0/B8i+1DSg1hNqX5gFqudc6B+TQLZw
 BuPUtymRc4U9BvenndY+b4KoP8HwTvckClk2LPsh1+fV/5/tSiZt7xSwHuLWaKSppI8N/rg
 sJjVaP/ZrswUXa5k/BzZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OlGLBIedQCw=:bfPWlYZblNxYxoUdf8miXx
 gn40UML0yyzmRbjYicWIDwBsbE4D2knU+bheNmxh5jgpZeGWWyZZErJg0BB8DC+SR6FR2XljY
 Lx6WRt1bJNvMYiu1CxqZo/HUynCcF3aAtsHrIT1164BVnPodpB7rVZI66ImjGgcJttduwyOHL
 /1rOiTEyMQrpWwO0K8xs54JsMmFo0sy91q7i39yTqDWkhvCHermdk4Uf/dpvjKptYV/m4CDQB
 suqar4c+KpG9Gf1d4Sagw4v3DSoNjaNr+yzIjzLugYEVSKSCqsLVvCo/Dw6ZpxP0CUTqQYnJ2
 veEA0Pj/zntRYGxtBlh6ifZhIoDbf0UB8vcTuk41aJQe2S6JZx0XnyI3liRIqBE4YkybP1QXY
 duSs9ndOrOOjOee/FoWOiGyF9PClV+VMjFt2FUGonI+HKSR3LkSk0gpOAykBD5cwNs8iVBzR6
 jF6LBcE42AgS2tZSJJZ1mJvwBgQYwcQ9oWpysQUyYWWx/z5+uWkVUjCE4NUCzom3s41+NszHz
 0LrmDib6Q5NhHrx7uyNhpoPjK+1/zFlQ0FwkVC2EMICfYZFHPEz0Kl/3HtLfQOjgQSGohKSKN
 erOsJu0Ij7jx0qv3Tadhg+VQPzOxIGOHhDaH5d1nnuDZvNFVL0I1nwuD1QUmZ+dqqko5quKj7
 6pfYMGJGyXdO6Tm3XRW2vCKaTZOILq1N/bXuh1K9OpwqtlN9JRa2w4TVkzIZEte8b02kU3TYX
 fiTu9cF7I7gj1YPcXzNV/GEDYtsBnc659uMtTLuwY+fpx+MaHiiGOnaGZRf78o4T0GhpaW3Kj
 puu98dPUsP92jVNL/I2i+rnfxkO6RrvaIjHKXZx+KRRj+jEoXI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When calling convert_to_git(), the checksafe parameter has been used to
check if commit would give a non-roundtrip conversion of EOL.

When checksafe was introduced, 3 values had been in use:
SAFE_CRLF_FALSE: no warning
SAFE_CRLF_FAIL:  reject the commit if EOL do not roundtrip
SAFE_CRLF_WARN:  warn the user if EOL do not roundtrip

Today a small flaw is found in the code base:
An integer with the value 0 is passed as the parameter checksafe
instead of the correct enum value SAFE_CRLF_FALSE.

In the next commit there is a need to turn checksafe into a bitmap, which
allows to tell convert_to_git() to obey the encoding attribute or not.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 apply.c       |  4 ++--
 convert.c     | 20 ++++++++++----------
 convert.h     | 18 ++++++++----------
 diff.c        |  4 ++--
 environment.c |  2 +-
 sha1_file.c   |  6 +++---
 6 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68d..a422516062 100644
--- a/apply.c
+++ b/apply.c
@@ -2263,7 +2263,7 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 static int read_old_data(struct stat *st, struct patch *patch,
 			 const char *path, struct strbuf *buf)
 {
-	enum safe_crlf safe_crlf = patch->crlf_in_old ?
+	int checksafe = patch->crlf_in_old ?
 		SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_RENORMALIZE;
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
@@ -2281,7 +2281,7 @@ static int read_old_data(struct stat *st, struct patch *patch,
 		 * should never look at the index when explicit crlf option
 		 * is given.
 		 */
-		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf);
+		convert_to_git(NULL, path, buf->buf, buf->len, buf, checksafe);
 		return 0;
 	default:
 		return -1;
diff --git a/convert.c b/convert.c
index 1a41a48e15..5efcc3b73b 100644
--- a/convert.c
+++ b/convert.c
@@ -195,13 +195,13 @@ static enum eol output_eol(enum crlf_action crlf_action)
 
 static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 			    struct text_stat *old_stats, struct text_stat *new_stats,
-			    enum safe_crlf checksafe)
+			    int checksafe)
 {
 	if (old_stats->crlf && !new_stats->crlf ) {
 		/*
 		 * CRLFs would not be restored by checkout
 		 */
-		if (checksafe == SAFE_CRLF_WARN)
+		if (checksafe & SAFE_CRLF_WARN)
 			warning(_("CRLF will be replaced by LF in %s.\n"
 				  "The file will have its original line"
 				  " endings in your working directory."), path);
@@ -211,7 +211,7 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 		/*
 		 * CRLFs would be added by checkout
 		 */
-		if (checksafe == SAFE_CRLF_WARN)
+		if (checksafe & SAFE_CRLF_WARN)
 			warning(_("LF will be replaced by CRLF in %s.\n"
 				  "The file will have its original line"
 				  " endings in your working directory."), path);
@@ -268,7 +268,7 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 static int crlf_to_git(const struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
-		       enum crlf_action crlf_action, enum safe_crlf checksafe)
+		       enum crlf_action crlf_action, int checksafe)
 {
 	struct text_stat stats;
 	char *dst;
@@ -298,12 +298,12 @@ static int crlf_to_git(const struct index_state *istate,
 		 * unless we want to renormalize in a merge or
 		 * cherry-pick.
 		 */
-		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
+		if ((!(checksafe & SAFE_CRLF_RENORMALIZE)) &&
 		    has_crlf_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
-	if ((checksafe == SAFE_CRLF_WARN ||
-	    (checksafe == SAFE_CRLF_FAIL)) && len) {
+	if (((checksafe & SAFE_CRLF_WARN) ||
+	     ((checksafe & SAFE_CRLF_FAIL) && len))) {
 		struct text_stat new_stats;
 		memcpy(&new_stats, &stats, sizeof(new_stats));
 		/* simulate "git add" */
@@ -1129,7 +1129,7 @@ const char *get_convert_attr_ascii(const char *path)
 
 int convert_to_git(const struct index_state *istate,
 		   const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+		   struct strbuf *dst, int checksafe)
 {
 	int ret = 0;
 	struct conv_attrs ca;
@@ -1144,7 +1144,7 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
-	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
+	if (!(checksafe & SAFE_CRLF_KEEP_CRLF)) {
 		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
 		if (ret && dst) {
 			src = dst->buf;
@@ -1156,7 +1156,7 @@ int convert_to_git(const struct index_state *istate,
 
 void convert_to_git_filter_fd(const struct index_state *istate,
 			      const char *path, int fd, struct strbuf *dst,
-			      enum safe_crlf checksafe)
+			      int checksafe)
 {
 	struct conv_attrs ca;
 	convert_attrs(&ca, path);
diff --git a/convert.h b/convert.h
index 4f2da225a8..532af00423 100644
--- a/convert.h
+++ b/convert.h
@@ -8,15 +8,13 @@
 
 struct index_state;
 
-enum safe_crlf {
-	SAFE_CRLF_FALSE = 0,
-	SAFE_CRLF_FAIL = 1,
-	SAFE_CRLF_WARN = 2,
-	SAFE_CRLF_RENORMALIZE = 3,
-	SAFE_CRLF_KEEP_CRLF = 4
-};
+#define SAFE_CRLF_FALSE       0
+#define SAFE_CRLF_FAIL        (1<<0)
+#define SAFE_CRLF_WARN        (1<<1)
+#define SAFE_CRLF_RENORMALIZE (1<<2)
+#define SAFE_CRLF_KEEP_CRLF   (1<<3)
 
-extern enum safe_crlf safe_crlf;
+extern int safe_crlf;
 
 enum auto_crlf {
 	AUTO_CRLF_FALSE = 0,
@@ -66,7 +64,7 @@ extern const char *get_convert_attr_ascii(const char *path);
 /* returns 1 if *dst was used */
 extern int convert_to_git(const struct index_state *istate,
 			  const char *path, const char *src, size_t len,
-			  struct strbuf *dst, enum safe_crlf checksafe);
+			  struct strbuf *dst, int checksafe);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int async_convert_to_working_tree(const char *path, const char *src,
@@ -85,7 +83,7 @@ static inline int would_convert_to_git(const struct index_state *istate,
 extern void convert_to_git_filter_fd(const struct index_state *istate,
 				     const char *path, int fd,
 				     struct strbuf *dst,
-				     enum safe_crlf checksafe);
+				     int checksafe);
 extern int would_convert_to_git_filter_fd(const char *path);
 
 /*****************************************************************
diff --git a/diff.c b/diff.c
index fb22b19f09..5e3aaea6e0 100644
--- a/diff.c
+++ b/diff.c
@@ -3524,7 +3524,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 	 * demote FAIL to WARN to allow inspecting the situation
 	 * instead of refusing.
 	 */
-	enum safe_crlf crlf_warn = (safe_crlf == SAFE_CRLF_FAIL
+	int checksafe = (safe_crlf == SAFE_CRLF_FAIL
 				    ? SAFE_CRLF_WARN
 				    : safe_crlf);
 
@@ -3603,7 +3603,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn)) {
+		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, checksafe)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/environment.c b/environment.c
index 63ac38a46f..10ee89a28d 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,7 @@ enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
-enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
+int safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..78e002392e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -133,7 +133,7 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 }
 
 
-static enum safe_crlf get_safe_crlf(unsigned flags)
+static int get_checksafe(unsigned flags)
 {
 	if (flags & HASH_RENORMALIZE)
 		return SAFE_CRLF_RENORMALIZE;
@@ -1752,7 +1752,7 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(&the_index, path, buf, size, &nbuf,
-				   get_safe_crlf(flags))) {
+				   get_checksafe(flags))) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
@@ -1786,7 +1786,7 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 	assert(would_convert_to_git_filter_fd(path));
 
 	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
-				 get_safe_crlf(flags));
+				 get_checksafe(flags));
 
 	if (write_object)
 		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-- 
2.16.0.rc0.4.ga4e00d4fa4

