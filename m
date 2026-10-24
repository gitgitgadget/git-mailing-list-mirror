Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879228;
	b=MK8apxLybhtAxdxZ3tUc0aGiJsP5WGA21gGxOXpaEg+vVZ5sejYSUhpCaG/Ou8n3RTr+
	 FTjW4P9pU/4xMSMUXZiMCwajRJ+9DlT4By2Brfj7zFidn4jSS8eL6M5DOUZ3fuTyEC9Yi
	 +YlKiB5ADkdDp5yiMUf7LlxrrzQPLkzZiUkxYlzwnpZISU7EfrzFshU7Q+y+MuGq9i+cp
	 hJ+hYyJNu4C3+VtwTrcYenPXcECn+KclPcEnqoyo5qgcQGVGxN1lzQ0bnfQyxgcUHDwMH
	 0RnkC0gnCpBURSA2BFaphrC5wA/Jz/KIVAIss8JsWXnGfjZpYsFHpWgK0HmOgqmNk5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NWsRjFOiCzZHNzFCf762W8Huf61DxFmaFSlIJb3+znE=;
	b=Yls1O0SRu2ybCPv2pt2aZsjBGCZekAjCHyP8rYbmWXEaerzvban8IpvXx8Jpfsp9kKXa
	 pzi/Cee0E5uPIIVsRDVgw9nJzGncY+1RJcWw2jI+/Ir3/VScDS9Uh7BSR3mSre3KnDRQr
	 ESaXuVAm7gRMuVtwJc2qNbunH6wN4yZP6I88tUjJHBk43t1gUJhw8znKGWka6W9QRqzrT
	 sntgHhVjw6OOjAF0K+wqXkZEcr0hW8Fzn7An0fc2i/IE5pBP3KlcOEFDWoJq9caU4lYpT
	 T3FWex3lp0cQt7pXrikb1Fi5E8X0bUnHfXRgPJlS3nvINEa91QtOVh6XUoSE9FWUs2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="o/VBEweH";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C709606A31D
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 22:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C709606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o/VBEweH
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35b2c599f43so966469eec.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792879227; x=1793484027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWsRjFOiCzZHNzFCf762W8Huf61DxFmaFSlIJb3+znE=;
        b=o/VBEweHSEKpSjxIeLJRqkAkmytLYbdfFz7+eILUjdCfRDCp3Z7n/1Ux2J1dC/9E0O
         dmqOG2gXQraxXdZsfOjVVu1kJNaDXQE/UyDhdgpLwhIXhiAkFP7gBv29BgwlXoIn1YOA
         onl3m0Z2GGVq9qNzwIw6y7zneNWX/Xyv3DGICVDyR0eo3c8bqnysd9PBWAxy8sPIG5ae
         A2YQU1tmIllgoNdMeqvTvhnN1gtnN4SpfTK0CdToifJzILCLtJHH8favi7eCqHw8zXL+
         FK7fz6qcFlqetRJXkrDab6Q1wu27b2TtEN/VaqEWUHrgqhci23hvz8WaJbSh1aLiJKo0
         fODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879227; x=1793484027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NWsRjFOiCzZHNzFCf762W8Huf61DxFmaFSlIJb3+znE=;
        b=qZkauwEddYPEYdockhaOdccZYqNMni/gtje8lKxwaC+Q0xEQLEeNpm1RHusPBlZwrZ
         OBgeyU1IQPl/SeJa6OvGtLclRHYCLDEYSg4bF6byc00BuTDuxumGUVwms1nf80veB+1N
         OVkM78I0/alruv2hJOFf80BfhgJCjaup8PELb5sVHAKDsyeKKT562taspCyJAF5dWaKm
         /fyVLnUYk32r0DGbdZvqU8kaYw+iO/V2VS+qSCn9sKYeSb4kJyTrnhcJ55/fHnRM0AuG
         QNz9hLVe3Ja/sn5C9RW6SLvK+ceAYqRxvPSSoqREesrlqDSWbIfQArewC2hJRA7L8ow+
         BlTA==
X-Gm-Message-State: AFq9FYJOsmU4tqXiK/wIXwWLpuP+WBODO87kpWaL7R75F402YvBLKpRK
	DdQdMRIlpyg3x8l/ZnDnFxxoCXhd4XQP3iI6fQg3vgks2bzeF8/FqO2EI5O5z8GQnNI=
X-Gm-Gg: AYBFou2iyPD/09XlpTgT/xpGl7oqZlbUAvDko8rr+/1HEqW0KaDp8zU768Tn91ko/+j
	RJAX32XgcUx7cSM1EQDylnDbPpY0kZHak3oIJ8tdq/tPfeneFelAMHWJMI910KTEdQPbDzKj1Aj
	k59UklGlwQJsEoZF9zeiSDvoUh9ObbPbr7/himKg9SJnt8vQJ6XPSOZvzXIDEO4HsHZc0DreTuN
	sbcXjTEUOAv2ddja+fVqBkUKkcswgyrydyuAOuUJg0o3zNniCnVOhDvaVK4jtVvtzkepqdUPSCL
	hlhf1RvOjFPVlS1DyhcFNsdTE9qxJjoh5vgeVIOGTPzz8qXftBnrup4ta9OaKgTRo1YRX3GcCcn
	fhNnHus7VAgbVA9ZgnggrbcT1cKjDC8oUfLamcHAB/fZzsIfHjSqAObjcdXuxkitNLIhEgRoVDv
	2xPMElnUTU0MqLexTNxyRyjz9T+8XWnGQHwvOSRFIgzThM65zA5QLNvDF3sUH2FnexDE9LNZcFZ
	57fr/TW2ytNYJitOC+FwL22g3m8QIYixgC43p7TNh5GCYXfyD8hG5bq0brotsT87geC2QgLtiJi
	ZnJWpB+Yk1oUcpUNDW/64YGtAn0prXnaHbtv+WoAsRx2ihqQIooaa6f32Mh6gts=
X-Received: by 2002:a05:701b:4192:10b0:193:8116:f5bf with SMTP id a92af1059eb24-1993571a391mr4239309c88.16.1792879226763;
        Sat, 24 Oct 2026 15:00:26 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm11578875c88.11.2026.10.24.15.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:00:26 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	cat@malon.dev,
	belkid98@gmail.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH 2/4] environment: move auto_crlf into repo_config_values
Date: Sat, 24 Oct 2026 22:00:10 +0000
Message-ID: <20261024220012.486-3-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.240.gf97865f162
In-Reply-To: <20261024220012.486-1-aniketgupta3001@gmail.com>
References: <20261024220012.486-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable 'auto_crlf' holds the value of the 'core.autocrlf'
configuration, which controls whether line endings are converted when
files are added to and checked out of the repository. Move it into
'struct repo_config_values' to continue the libification effort.

While 'enum auto_crlf' ideally belongs in 'convert.h', moving it there
introduces a circular dependency chain:

  convert.h -> hash.h -> repository.h -> environment.h.

Therefore, the enum definition is kept in 'environment.h' just below
'enum object_creation_mode', under the existing NEEDSWORK comment for
future cleanup. Initialize the per-repository value to its default in
'repo_config_values_init()'.

Modify the configuration parsing in environment.c to update the
per-repository structure directly. To read the value, introduce the
getter 'repo_auto_crlf()' and pass the repository down to the helpers
in 'convert.c' that need it.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 convert.c     | 68 +++++++++++++++++++++++++++++++--------------------
 convert.h     |  8 ------
 environment.c | 13 +++++++---
 environment.h |  9 +++++++
 4 files changed, 60 insertions(+), 38 deletions(-)

diff --git a/convert.c b/convert.c
index 95bdfafdd0..7c7fdd4b2d 100644
--- a/convert.c
+++ b/convert.c
@@ -158,11 +158,11 @@ const char *get_wt_convert_stats_ascii(const char *path)
 	return ret;
 }
 
-static int text_eol_is_crlf(void)
+static int text_eol_is_crlf(struct repository *repo)
 {
-	if (auto_crlf == AUTO_CRLF_TRUE)
+	if (repo_auto_crlf(repo) == AUTO_CRLF_TRUE)
 		return 1;
-	else if (auto_crlf == AUTO_CRLF_INPUT)
+	else if (repo_auto_crlf(repo) == AUTO_CRLF_INPUT)
 		return 0;
 	if (core_eol == EOL_CRLF)
 		return 1;
@@ -171,7 +171,8 @@ static int text_eol_is_crlf(void)
 	return 0;
 }
 
-static enum eol output_eol(enum convert_crlf_action crlf_action)
+static enum eol output_eol(struct repository *repo,
+			   enum convert_crlf_action crlf_action)
 {
 	switch (crlf_action) {
 	case CRLF_BINARY:
@@ -188,7 +189,7 @@ static enum eol output_eol(enum convert_crlf_action crlf_action)
 	case CRLF_TEXT:
 	case CRLF_AUTO:
 		/* fall through */
-		return text_eol_is_crlf() ? EOL_CRLF : EOL_LF;
+		return text_eol_is_crlf(repo) ? EOL_CRLF : EOL_LF;
 	}
 	warning(_("illegal crlf_action %d"), (int)crlf_action);
 	return core_eol;
@@ -244,10 +245,11 @@ static int has_crlf_in_index(struct index_state *istate, const char *path)
 	return has_crlf;
 }
 
-static int will_convert_lf_to_crlf(struct text_stat *stats,
+static int will_convert_lf_to_crlf(struct repository *repo,
+				   struct text_stat *stats,
 				   enum convert_crlf_action crlf_action)
 {
-	if (output_eol(crlf_action) != EOL_CRLF)
+	if (output_eol(repo, crlf_action) != EOL_CRLF)
 		return 0;
 	/* No "naked" LF? Nothing to convert, regardless. */
 	if (!stats->lonelf)
@@ -505,6 +507,8 @@ static int crlf_to_git(struct index_state *istate,
 		       struct strbuf *buf,
 		       enum convert_crlf_action crlf_action, int conv_flags)
 {
+	struct repository *repo = istate && istate->repo ?
+				  istate->repo : the_repository;
 	struct text_stat stats;
 	char *dst;
 	int convert_crlf_into_lf;
@@ -547,7 +551,7 @@ static int crlf_to_git(struct index_state *istate,
 			new_stats.crlf = 0;
 		}
 		/* simulate "git checkout" */
-		if (will_convert_lf_to_crlf(&new_stats, crlf_action)) {
+		if (will_convert_lf_to_crlf(repo, &new_stats, crlf_action)) {
 			new_stats.crlf += new_stats.lonelf;
 			new_stats.lonelf = 0;
 		}
@@ -589,17 +593,18 @@ static int crlf_to_git(struct index_state *istate,
 	return 1;
 }
 
-static int crlf_to_worktree(const char *src, size_t len, struct strbuf *buf,
+static int crlf_to_worktree(struct repository *repo,
+			    const char *src, size_t len, struct strbuf *buf,
 			    enum convert_crlf_action crlf_action)
 {
 	char *to_free = NULL;
 	struct text_stat stats;
 
-	if (!len || output_eol(crlf_action) != EOL_CRLF)
+	if (!len || output_eol(repo, crlf_action) != EOL_CRLF)
 		return 0;
 
 	gather_stats(src, len, &stats);
-	if (!will_convert_lf_to_crlf(&stats, crlf_action))
+	if (!will_convert_lf_to_crlf(repo, &stats, crlf_action))
 		return 0;
 
 	/* are we "faking" in place editing ? */
@@ -1321,6 +1326,8 @@ static struct attr_check *check;
 void convert_attrs(struct index_state *istate,
 		   struct conv_attrs *ca, const char *path)
 {
+	struct repository *repo = istate && istate->repo ?
+				  istate->repo : the_repository;
 	struct attr_check_item *ccheck = NULL;
 
 	if (!check) {
@@ -1354,12 +1361,16 @@ void convert_attrs(struct index_state *istate,
 	/* Save attr and make a decision for action */
 	ca->attr_action = ca->crlf_action;
 	if (ca->crlf_action == CRLF_TEXT)
-		ca->crlf_action = text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
-	if (ca->crlf_action == CRLF_UNDEFINED && auto_crlf == AUTO_CRLF_FALSE)
+		ca->crlf_action = text_eol_is_crlf(repo) ?
+				  CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
+	if (ca->crlf_action == CRLF_UNDEFINED &&
+	    repo_auto_crlf(repo) == AUTO_CRLF_FALSE)
 		ca->crlf_action = CRLF_BINARY;
-	if (ca->crlf_action == CRLF_UNDEFINED && auto_crlf == AUTO_CRLF_TRUE)
+	if (ca->crlf_action == CRLF_UNDEFINED &&
+	    repo_auto_crlf(repo) == AUTO_CRLF_TRUE)
 		ca->crlf_action = CRLF_AUTO_CRLF;
-	if (ca->crlf_action == CRLF_UNDEFINED && auto_crlf == AUTO_CRLF_INPUT)
+	if (ca->crlf_action == CRLF_UNDEFINED &&
+	    repo_auto_crlf(repo) == AUTO_CRLF_INPUT)
 		ca->crlf_action = CRLF_AUTO_INPUT;
 }
 
@@ -1479,7 +1490,8 @@ void convert_to_git_filter_fd(struct index_state *istate,
 	ident_to_git(dst->buf, dst->len, dst, ca.ident);
 }
 
-static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
+static int convert_to_working_tree_ca_internal(struct repository *repo,
+					       const struct conv_attrs *ca,
 					       const char *path, const char *src,
 					       size_t len, struct strbuf *dst,
 					       int normalizing,
@@ -1499,7 +1511,7 @@ static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
 	 * support smudge).  The filters might expect CRLFs.
 	 */
 	if ((ca->drv && (ca->drv->smudge || ca->drv->process)) || !normalizing) {
-		ret |= crlf_to_worktree(src, len, dst, ca->crlf_action);
+		ret |= crlf_to_worktree(repo, src, len, dst, ca->crlf_action);
 		if (ret) {
 			src = dst->buf;
 			len = dst->len;
@@ -1520,25 +1532,25 @@ static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
 	return ret | ret_filter;
 }
 
-int async_convert_to_working_tree_ca(struct repository *repo UNUSED,
+int async_convert_to_working_tree_ca(struct repository *repo,
 				     const struct conv_attrs *ca,
 				     const char *path, const char *src,
 				     size_t len, struct strbuf *dst,
 				     const struct checkout_metadata *meta,
 				     void *dco)
 {
-	return convert_to_working_tree_ca_internal(ca, path, src, len, dst, 0,
-						   meta, dco);
+	return convert_to_working_tree_ca_internal(repo, ca, path, src, len,
+						   dst, 0, meta, dco);
 }
 
-int convert_to_working_tree_ca(struct repository *repo UNUSED,
+int convert_to_working_tree_ca(struct repository *repo,
 			       const struct conv_attrs *ca,
 			       const char *path, const char *src,
 			       size_t len, struct strbuf *dst,
 			       const struct checkout_metadata *meta)
 {
-	return convert_to_working_tree_ca_internal(ca, path, src, len, dst, 0,
-						   meta, NULL);
+	return convert_to_working_tree_ca_internal(repo, ca, path, src, len,
+						   dst, 0, meta, NULL);
 }
 
 int convert_to_working_tree(struct index_state *istate,
@@ -1570,12 +1582,14 @@ int async_convert_to_working_tree(struct index_state *istate,
 int renormalize_buffer(struct index_state *istate, const char *path,
 		       const char *src, size_t len, struct strbuf *dst)
 {
+	struct repository *repo = istate && istate->repo ?
+				  istate->repo : the_repository;
 	struct conv_attrs ca;
 	int ret;
 
 	convert_attrs(istate, &ca, path);
-	ret = convert_to_working_tree_ca_internal(&ca, path, src, len, dst, 1,
-						  NULL, NULL);
+	ret = convert_to_working_tree_ca_internal(repo, &ca, path, src, len,
+						  dst, 1, NULL, NULL);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -2009,7 +2023,7 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
  * Note that you would be crazy to set CRLF, smudge/clean or ident to a
  * large binary blob you would want us not to slurp into the memory!
  */
-struct stream_filter *get_stream_filter_ca(struct repository *repo UNUSED,
+struct stream_filter *get_stream_filter_ca(struct repository *repo,
 					   const struct conv_attrs *ca,
 					   const struct object_id *oid)
 {
@@ -2021,7 +2035,7 @@ struct stream_filter *get_stream_filter_ca(struct repository *repo UNUSED,
 	if (ca->ident)
 		filter = ident_filter(oid);
 
-	if (output_eol(ca->crlf_action) == EOL_CRLF)
+	if (output_eol(repo, ca->crlf_action) == EOL_CRLF)
 		filter = cascade_filter(filter, lf_to_crlf_filter());
 	else
 		filter = cascade_filter(filter, &null_filter_singleton);
diff --git a/convert.h b/convert.h
index 137fa1593a..dae11d372d 100644
--- a/convert.h
+++ b/convert.h
@@ -19,14 +19,6 @@ struct strbuf;
 
 extern int global_conv_flags_eol;
 
-enum auto_crlf {
-	AUTO_CRLF_FALSE = 0,
-	AUTO_CRLF_TRUE = 1,
-	AUTO_CRLF_INPUT = -1
-};
-
-extern enum auto_crlf auto_crlf;
-
 enum eol {
 	EOL_UNSET,
 	EOL_CRLF,
diff --git a/environment.c b/environment.c
index c83cf44839..bbac8ed8c9 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,6 @@ int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
-enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding;
@@ -152,6 +151,13 @@ int repo_has_symlinks(struct repository *repo)
 		: platform_has_symlinks();
 }
 
+enum auto_crlf repo_auto_crlf(struct repository *repo)
+{
+	return repo->initialized
+		? repo_config_values(repo)->auto_crlf
+		: AUTO_CRLF_FALSE;
+}
+
 const char *repo_excludes_file(struct repository *repo)
 {
 	struct repo_config_values *cfg = repo_config_values(repo);
@@ -420,10 +426,10 @@ int git_default_core_config(const char *var, const char *value,
 
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
-			auto_crlf = AUTO_CRLF_INPUT;
+			cfg->auto_crlf = AUTO_CRLF_INPUT;
 			return 0;
 		}
-		auto_crlf = git_config_bool(var, value);
+		cfg->auto_crlf = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -777,6 +783,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->trust_executable_bit = 1;
 	cfg->has_symlinks = platform_has_symlinks();
 	cfg->use_nanosec = 0;
+	cfg->auto_crlf = AUTO_CRLF_FALSE;
 
 	/* section "sparse" config values */
 	cfg->sparse_expect_files_outside_of_patterns = 0;
diff --git a/environment.h b/environment.h
index 49c86e8879..872da3576b 100644
--- a/environment.h
+++ b/environment.h
@@ -123,6 +123,12 @@ enum object_creation_mode {
 	OBJECT_CREATION_USES_RENAMES = 1
 };
 
+enum auto_crlf {
+	AUTO_CRLF_FALSE = 0,
+	AUTO_CRLF_TRUE = 1,
+	AUTO_CRLF_INPUT = -1
+};
+
 struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
@@ -149,6 +155,7 @@ struct repo_config_values {
 	int trust_executable_bit;
 	int has_symlinks;
 	int use_nanosec;
+	enum auto_crlf auto_crlf;
 
 	/* section "sparse" config values */
 	int sparse_expect_files_outside_of_patterns;
@@ -203,6 +210,8 @@ int repo_trust_executable_bit(struct repository *repo);
 
 int repo_has_symlinks(struct repository *repo);
 
+enum auto_crlf repo_auto_crlf(struct repository *repo);
+
 const char *repo_excludes_file(struct repository *repo);
 
 void repo_config_values_init(struct repo_config_values *cfg);
-- 
2.43.0

