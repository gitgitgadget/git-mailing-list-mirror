Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F091F404
	for <e@80x24.org>; Mon,  1 Jan 2018 22:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeAAWAY (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 17:00:24 -0500
Received: from mout.web.de ([212.227.17.12]:50501 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeAAWAW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 17:00:22 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lheqz-1fIe9a1k01-00moM1; Mon, 01
 Jan 2018 23:00:03 +0100
From:   tboegi@web.de
To:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/1] convert_to_git(): checksafe becomes int conv_flags
Date:   Mon,  1 Jan 2018 22:59:59 +0100
Message-Id: <20180101215959.1460-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.4.ga4e00d4fa4
In-Reply-To: <96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com>
References: <96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:8JKZ420Dhc7g/Qi5f9NlgZ34RJOr2sRH8nmSfTSIPdPTrihqxVa
 U9ZQnybvU5hcPu9xijH2cNozgJahxKOdVZHxDsak22pz5Gvo63qitIZD8yypIWnT1aZLkDE
 Bk3nk2arN2kPJ7AL2cfacFuessogKR98dFmRUs/BDOLdAZ8p43D4LVnidw1g1rjMG9dQNtS
 FO4fWv0f8L1mOqdt/0k0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0Rps7aSipEY=:pBlY7c2u2V0Vvbd3FNWDyh
 AIBki+zpN3nC9m4TWz/Pp2HArHCYQtVr0FmsiTWE8tPJilAfyOB24W9agP7nPLAzgrS3LjxHl
 SWK3imcUmSM2dE01cqYVdnZ+7zK1/LT83oDzs8L6id6XS2j7HgcjPZjBwUauWIiMO91SprcnD
 HPX5Br0G3PqWHLoqhCSePQeUKqo4cmSlj0jL9Oc/y+P9N29eXLBNuKHBInqVf5a0GBIq7USB0
 o0J2ntPfZKNfaJ/WnJftw/PDGBuZo1WDbh+ITEyEsEmQNMp3VsVEO7Jr3eIldeMAAhgCo4G4W
 DkjT/gX5+xKT/mBXu7JQlBUC7E3WHWeSsQ//wCWbUG/SLdZUD/j8D1sjpwtWO8errYuENOWRu
 mNfz2WGU3KAz/UtkJXs46CXtMfeYH/sFI68cpY1IrkxFOgfe48LVc7Mfli5P1mnxAQe34hHkF
 t+Pbfklt3JaIBHOT4CnB0ukpHBo30RNGRNcFhEW8I9ecn0Z3NbHmnY/jOzrIlP5FPRxUsAAbx
 tc4+pZiSFVgIXe7P8gCUmPYZVR7e11zZ6Prbgnk+pt/4zBvTP46r10nPjjhP2JQEin7ykLMXW
 Y+Dw08PIuRtkktFOwbJCN9NRf+07Y0L+x3/2mcYHAifP1PjmDULMr/khJUiEN4xT+Ac+PKb6K
 CUNvjwzwV3ibGxbMATF9gRLhsjpb72GZk7DN3dR2avfQr9XQ42j7YanzJvMWlTA4DiJCWYzus
 rr4bnAt5U51Dz2qjbWErybDmjF+YBfenqunHHQD/KMzGCH1qgH3YJikiNl9o6rJXhZi08G5Hd
 VGWccw26LyhJkfCfeHwD/MU/DOF7vCe3Z1H7szlO7X3D9v4Xqk=
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

Already today the integer value 0 is passed as the parameter checksafe
instead of the correct enum value SAFE_CRLF_FALSE.

Turn the whole call chain to use an integer with single bits, which
can be extended in the next commits:
- The global configuration variable safe_crlf is now conv_flags_eol.
- The parameter checksafe is renamed into conv_flags.

Helped-By: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
This is my suggestion.
(1) The flag bits had been renamed.
(2) The (theoretical ?) mix of WARN/FAIL is still there,
    I am not sure if this is a real problem.

(3) There are 2 reasons that CONV_EOL_RENORMALIZE is set.
    Either in a renormalizing merge, or by running
    git add --renormalize .
    Therefor HASH_RENORMALIZE is not the same as CONV_EOL_RENORMALIZE.

apply.c        |  6 +++---
 combine-diff.c |  2 +-
 config.c       |  7 +++++--
 convert.c      | 38 +++++++++++++++++++-------------------
 convert.h      | 17 +++++++----------
 diff.c         |  8 ++++----
 environment.c  |  2 +-
 sha1_file.c    | 12 ++++++------
 8 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68d..f8b67bfee2 100644
--- a/apply.c
+++ b/apply.c
@@ -2263,8 +2263,8 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 static int read_old_data(struct stat *st, struct patch *patch,
 			 const char *path, struct strbuf *buf)
 {
-	enum safe_crlf safe_crlf = patch->crlf_in_old ?
-		SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_RENORMALIZE;
+	int conv_flags = patch->crlf_in_old ?
+		CONV_EOL_KEEP_CRLF : CONV_EOL_RENORMALIZE;
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
@@ -2281,7 +2281,7 @@ static int read_old_data(struct stat *st, struct patch *patch,
 		 * should never look at the index when explicit crlf option
 		 * is given.
 		 */
-		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf);
+		convert_to_git(NULL, path, buf->buf, buf->len, buf, conv_flags);
 		return 0;
 	default:
 		return -1;
diff --git a/combine-diff.c b/combine-diff.c
index 2505de119a..dbc877d0fe 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1053,7 +1053,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(&the_index, elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(&the_index, elem->path, result, len, &buf, conv_flags_eol)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/config.c b/config.c
index e617c2018d..bdc7ce2a7e 100644
--- a/config.c
+++ b/config.c
@@ -1149,11 +1149,14 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.safecrlf")) {
+		int eol_rndtrp_die;
 		if (value && !strcasecmp(value, "warn")) {
-			safe_crlf = SAFE_CRLF_WARN;
+			conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 			return 0;
 		}
-		safe_crlf = git_config_bool(var, value);
+		eol_rndtrp_die = git_config_bool(var, value);
+		conv_flags_eol = eol_rndtrp_die ?
+			CONV_EOL_RNDTRP_DIE : CONV_EOL_RNDTRP_WARN;
 		return 0;
 	}
 
diff --git a/convert.c b/convert.c
index 1a41a48e15..0207ddab24 100644
--- a/convert.c
+++ b/convert.c
@@ -193,30 +193,30 @@ static enum eol output_eol(enum crlf_action crlf_action)
 	return core_eol;
 }
 
-static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
+static void check_conv_flags_eol(const char *path, enum crlf_action crlf_action,
 			    struct text_stat *old_stats, struct text_stat *new_stats,
-			    enum safe_crlf checksafe)
+			    int conv_flags)
 {
 	if (old_stats->crlf && !new_stats->crlf ) {
 		/*
 		 * CRLFs would not be restored by checkout
 		 */
-		if (checksafe == SAFE_CRLF_WARN)
+		if (conv_flags & CONV_EOL_RNDTRP_DIE)
+			die(_("CRLF would be replaced by LF in %s."), path);
+		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("CRLF will be replaced by LF in %s.\n"
 				  "The file will have its original line"
 				  " endings in your working directory."), path);
-		else /* i.e. SAFE_CRLF_FAIL */
-			die(_("CRLF would be replaced by LF in %s."), path);
 	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
 		 * CRLFs would be added by checkout
 		 */
-		if (checksafe == SAFE_CRLF_WARN)
+		if (conv_flags & CONV_EOL_RNDTRP_DIE)
+			die(_("LF would be replaced by CRLF in %s"), path);
+		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("LF will be replaced by CRLF in %s.\n"
 				  "The file will have its original line"
 				  " endings in your working directory."), path);
-		else /* i.e. SAFE_CRLF_FAIL */
-			die(_("LF would be replaced by CRLF in %s"), path);
 	}
 }
 
@@ -268,7 +268,7 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 static int crlf_to_git(const struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
-		       enum crlf_action crlf_action, enum safe_crlf checksafe)
+		       enum crlf_action crlf_action, int conv_flags)
 {
 	struct text_stat stats;
 	char *dst;
@@ -298,12 +298,12 @@ static int crlf_to_git(const struct index_state *istate,
 		 * unless we want to renormalize in a merge or
 		 * cherry-pick.
 		 */
-		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
+		if ((!(conv_flags & CONV_EOL_RENORMALIZE)) &&
 		    has_crlf_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
-	if ((checksafe == SAFE_CRLF_WARN ||
-	    (checksafe == SAFE_CRLF_FAIL)) && len) {
+	if (((conv_flags & CONV_EOL_RNDTRP_WARN) ||
+	     ((conv_flags & CONV_EOL_RNDTRP_DIE) && len))) {
 		struct text_stat new_stats;
 		memcpy(&new_stats, &stats, sizeof(new_stats));
 		/* simulate "git add" */
@@ -316,7 +316,7 @@ static int crlf_to_git(const struct index_state *istate,
 			new_stats.crlf += new_stats.lonelf;
 			new_stats.lonelf = 0;
 		}
-		check_safe_crlf(path, crlf_action, &stats, &new_stats, checksafe);
+		check_conv_flags_eol(path, crlf_action, &stats, &new_stats, conv_flags);
 	}
 	if (!convert_crlf_into_lf)
 		return 0;
@@ -1129,7 +1129,7 @@ const char *get_convert_attr_ascii(const char *path)
 
 int convert_to_git(const struct index_state *istate,
 		   const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+		   struct strbuf *dst, int conv_flags)
 {
 	int ret = 0;
 	struct conv_attrs ca;
@@ -1144,8 +1144,8 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
-	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
-		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
+	if (!(conv_flags & CONV_EOL_KEEP_CRLF)) {
+		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, conv_flags);
 		if (ret && dst) {
 			src = dst->buf;
 			len = dst->len;
@@ -1156,7 +1156,7 @@ int convert_to_git(const struct index_state *istate,
 
 void convert_to_git_filter_fd(const struct index_state *istate,
 			      const char *path, int fd, struct strbuf *dst,
-			      enum safe_crlf checksafe)
+			      int conv_flags)
 {
 	struct conv_attrs ca;
 	convert_attrs(&ca, path);
@@ -1167,7 +1167,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
-	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
@@ -1226,7 +1226,7 @@ int renormalize_buffer(const struct index_state *istate, const char *path,
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
+	return ret | convert_to_git(istate, path, src, len, dst, CONV_EOL_RENORMALIZE);
 }
 
 /*****************************************************************
diff --git a/convert.h b/convert.h
index 4f2da225a8..21a176f16c 100644
--- a/convert.h
+++ b/convert.h
@@ -8,15 +8,12 @@
 
 struct index_state;
 
-enum safe_crlf {
-	SAFE_CRLF_FALSE = 0,
-	SAFE_CRLF_FAIL = 1,
-	SAFE_CRLF_WARN = 2,
-	SAFE_CRLF_RENORMALIZE = 3,
-	SAFE_CRLF_KEEP_CRLF = 4
-};
+#define CONV_EOL_RNDTRP_DIE   (1<<0)
+#define CONV_EOL_RNDTRP_WARN  (1<<1)
+#define CONV_EOL_RENORMALIZE  (1<<2)
+#define CONV_EOL_KEEP_CRLF    (1<<3)
 
-extern enum safe_crlf safe_crlf;
+extern int conv_flags_eol;
 
 enum auto_crlf {
 	AUTO_CRLF_FALSE = 0,
@@ -66,7 +63,7 @@ extern const char *get_convert_attr_ascii(const char *path);
 /* returns 1 if *dst was used */
 extern int convert_to_git(const struct index_state *istate,
 			  const char *path, const char *src, size_t len,
-			  struct strbuf *dst, enum safe_crlf checksafe);
+			  struct strbuf *dst, int conv_flags);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int async_convert_to_working_tree(const char *path, const char *src,
@@ -85,7 +82,7 @@ static inline int would_convert_to_git(const struct index_state *istate,
 extern void convert_to_git_filter_fd(const struct index_state *istate,
 				     const char *path, int fd,
 				     struct strbuf *dst,
-				     enum safe_crlf checksafe);
+				     int conv_flags);
 extern int would_convert_to_git_filter_fd(const char *path);
 
 /*****************************************************************
diff --git a/diff.c b/diff.c
index fb22b19f09..2470af52b2 100644
--- a/diff.c
+++ b/diff.c
@@ -3524,9 +3524,9 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 	 * demote FAIL to WARN to allow inspecting the situation
 	 * instead of refusing.
 	 */
-	enum safe_crlf crlf_warn = (safe_crlf == SAFE_CRLF_FAIL
-				    ? SAFE_CRLF_WARN
-				    : safe_crlf);
+	int conv_flags = (conv_flags_eol == CONV_EOL_RNDTRP_DIE
+				    ? CONV_EOL_RNDTRP_WARN
+				    : conv_flags_eol);
 
 	if (!DIFF_FILE_VALID(s))
 		die("internal error: asking to populate invalid file.");
@@ -3603,7 +3603,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn)) {
+		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, conv_flags)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/environment.c b/environment.c
index 63ac38a46f..0df21eb633 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,7 @@ enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
-enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
+int conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..c0714c1107 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -133,14 +133,14 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 }
 
 
-static enum safe_crlf get_safe_crlf(unsigned flags)
+static int get_conv_flags(unsigned flags)
 {
 	if (flags & HASH_RENORMALIZE)
-		return SAFE_CRLF_RENORMALIZE;
+		return CONV_EOL_RENORMALIZE;
 	else if (flags & HASH_WRITE_OBJECT)
-		return safe_crlf;
+		return conv_flags_eol;
 	else
-		return SAFE_CRLF_FALSE;
+		return 0;
 }
 
 
@@ -1752,7 +1752,7 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(&the_index, path, buf, size, &nbuf,
-				   get_safe_crlf(flags))) {
+				   get_conv_flags(flags))) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
@@ -1786,7 +1786,7 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 	assert(would_convert_to_git_filter_fd(path));
 
 	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
-				 get_safe_crlf(flags));
+				 get_conv_flags(flags));
 
 	if (write_object)
 		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-- 
2.16.0.rc0.4.ga4e00d4fa4

