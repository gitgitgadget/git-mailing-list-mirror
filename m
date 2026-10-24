Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879225;
	b=aIjWIPfO3/dmbsvEqxGEbywVb7mEyDPZcdsvjWfnydgMTp63n3rO+U9tm/EsCnVaxyzn
	 gzuMV2Mt5FmZVZzihqAHNnFlU1VVccz+rxgx2jobeVIDPBaFe1rweFNa+BKgJPQmGuShw
	 rF0ssHROOXNuoCVgeieb/3cbNaLe0SMBT7lba+7Hn5BHUZsKnV3sJA+0GEXm7wiaUi4fO
	 G9+SemXpE5TtjRUzo0UG/+d7+aLSLeO2C6w5YQZSN2wYzqT70IbWBbRFgzVhycRBQq6XY
	 zVgvHZNEM2XWHSxE7NNzSLEI5kAh/s67ftB9SzcuwJl/QMbRsS8HbD/mNvjqET7SXdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wjviDUmo7LruwKOMoKTMEBMFUnWMDnUOUwtMuMMlpOE=;
	b=OcQq31wU5I9nO4RRboFMZ1ybQHF1Rj9hEX8cDOTqZjosD1TRrFc/6cdi+IsZTMHbHceS
	 6G3dF5buJIW7mO9l9IOjpB01Oyanvn/3Ui4zySmqWCWmZRtX1U//iLFOQoErL3QPScmc5
	 MHjKDPdW7vAXBJ2DM0z9ts5ZIBnc/cHlsLbaPAn/5G3t6MX6Gv94KXvbtsTp7Fw8414Ny
	 RMiezHQ2A1pykdBytFwl4xnN5SQuFa/3LJxJ9rFQUnISIbZAuEcb6Zt2pNCsFqw9W+jNB
	 zvWfZyYItrZ5axO9qVYwLgyniS9io4wyJDLlRrMaM98fwQrQkSsZDi+ujOYTSem1kvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Lhv3N/k1";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A5606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 22:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F8A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lhv3N/k1
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36681e85e87so1172163eec.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792879223; x=1793484023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wjviDUmo7LruwKOMoKTMEBMFUnWMDnUOUwtMuMMlpOE=;
        b=Lhv3N/k1UkuBOoO3/0dN4UwMagrFp/hyMcX4jP6DnXHruhuz2zw1h6A7Kv1Ah2s1K5
         6WHFIl1I097Ih2ieEOLH2fXMrdFh+knQ+O9yAG+c8R0XxFYzvt0p+CkwI2WJRblNSIH4
         Am+/pNk5ZUGMjanoqNLjPQpumt1Nq3wk8hTW2/GzQMbmto3Fh3R88OSx9MlyHT8xa0AU
         xUm11EMLTpPyDPvM6bISsBIMljTK+x05Y1GpAWzgLIRZMrnDhIwaVW4O1J006khVwhGo
         RZMIGAl8DSfoSht26w1WRtJZ4bW50lrZXOCsszPje/XGeHJl4x2U9+hPXs+KtZDGDjq4
         1utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879223; x=1793484023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wjviDUmo7LruwKOMoKTMEBMFUnWMDnUOUwtMuMMlpOE=;
        b=YlF/OtILQw0uk/8riZB4+4LKOU+nmrGw5ITghlG4QRoOLPW/J6wKT8aNU4UJPsqbHA
         kAdl78hCOeSk8afW+tHp4fTx/q3Q0PC/BPd711wXgS0Qtk6yFEexs27Z4o9WBIpMKezM
         2Z0kbf1dIQXtAHozuRrbPovYronRqMMPd/Fqc0mRw2b+X5HxU0h7raBnHBZzNoTtHABh
         lersHRIYMGjNGBSgyV4l9tIWrbjt0+DpRctB+IQJ1I3J2ms5S2vNCIO7EV+TSohnt4Wz
         tdOwRiMM0WPy5nKb+lWb83LJ3IrNBz8NkdXVWaI4u5PIolqYYxgJ67cwx6I6At+8su8M
         paJg==
X-Gm-Message-State: AFq9FYLXo4Sj9OmDEcpyWtp3Zk5sPVardg/6UwELrlVpNA5rYWCZmEth
	fP0paIyzNIQtqMB7P1hDUFoA0/QzfG2lGJu4J/X2REMtdKEFQZQnUsxlgRg1Om1WQYc=
X-Gm-Gg: AYBFou1zYRCjBR9XH/Izsbwx7gJetLYgs/SXu3AAJzdRxq9AKU0+qXFXp7S+3htCkIZ
	eYFH2kurzuEm67frAcYSUQe9NuxGGuasWTPM1kJSsWOx73dLHKAiUttmlZmgfui9v/m8rpydil3
	ANxYw+M06lPReRoZAgjMpxn11kBeGMKxRmppSqU+aLvPXziia1uBJ071SlAMvujiv+7SLLPvaCG
	nu/FHATESPsvO2xAJJdsrhYVX6rJBSFro+Kc9xSBcNuwl0iKHjTWOtBaQcQW2md7G2PP83KKNU5
	NGliYTQH8GWOFVPabpRY8vAWUu9ROJhseP/cZjHOnFzWEqrEcTQKQqG6wU23ZrBoObnLAcrPEd6
	2kYQjWZXuLvUkcp3jOxmYsFro0au1Bs7ojOz8UmS2/om7mjpgsXNZnrcIGulnB+XSlmfiOsIceT
	+G3WN+ym1YpJPrRB+rAw3VtWQU2h1bKHa05IhHqj0LYjtRIueYNzHlsKDXDmZMNz3Mkx7yZ2UGY
	IN3v7X38uOpcz3LmCMO+WN4V2o7mVMb19OeywNX502OaRIgbGhziEWInptVQ/nFuEMPPsS1WHGT
	pQbufXuDJ4To1Rs/r4ls5jGu85+1bVOnExwKb1Rowg==
X-Received: by 2002:a05:701b:260c:b0:191:5cd8:818b with SMTP id a92af1059eb24-19935625a4fmr3780848c88.7.1792879223232;
        Sat, 24 Oct 2026 15:00:23 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm11578875c88.11.2026.10.24.15.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:00:22 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	cat@malon.dev,
	belkid98@gmail.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH 1/4] convert: pass 'repo' to the working tree conversion functions
Date: Sat, 24 Oct 2026 22:00:09 +0000
Message-ID: <20261024220012.486-2-aniketgupta3001@gmail.com>
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

The functions that convert a blob to its working tree format take a
'struct conv_attrs' but no repository, even though what they do
depends on configuration such as 'core.autocrlf' and 'core.eol'. As
we migrate these configuration variables into the repository struct,
the functions need access to the repository context.

Add a 'struct repository *' parameter to convert_to_working_tree_ca(),
async_convert_to_working_tree_ca() and get_stream_filter_ca(), and
update all callers to pass the appropriate repository instance. The
parameter is not used yet, so mark it as UNUSED for now.

The convert_to_working_tree() and async_convert_to_working_tree()
wrappers were static inline functions in 'convert.h'. They need to
get the repository from the index, which 'convert.h' does not know
about, so move them into 'convert.c'.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 convert.c           | 39 +++++++++++++++++++++++++++++++++++----
 convert.h           | 38 ++++++++++++++++----------------------
 entry.c             | 16 +++++++++++-----
 parallel-checkout.c |  8 +++++---
 4 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/convert.c b/convert.c
index 036506842c..95bdfafdd0 100644
--- a/convert.c
+++ b/convert.c
@@ -1520,7 +1520,8 @@ static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
 	return ret | ret_filter;
 }
 
-int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
+int async_convert_to_working_tree_ca(struct repository *repo UNUSED,
+				     const struct conv_attrs *ca,
 				     const char *path, const char *src,
 				     size_t len, struct strbuf *dst,
 				     const struct checkout_metadata *meta,
@@ -1530,7 +1531,8 @@ int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
 						   meta, dco);
 }
 
-int convert_to_working_tree_ca(const struct conv_attrs *ca,
+int convert_to_working_tree_ca(struct repository *repo UNUSED,
+			       const struct conv_attrs *ca,
 			       const char *path, const char *src,
 			       size_t len, struct strbuf *dst,
 			       const struct checkout_metadata *meta)
@@ -1539,6 +1541,32 @@ int convert_to_working_tree_ca(const struct conv_attrs *ca,
 						   meta, NULL);
 }
 
+int convert_to_working_tree(struct index_state *istate,
+			   const char *path, const char *src,
+			   size_t len, struct strbuf *dst,
+			   const struct checkout_metadata *meta)
+{
+	struct repository *repo = istate && istate->repo ?
+				  istate->repo : the_repository;
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return convert_to_working_tree_ca(repo, &ca, path, src, len, dst, meta);
+}
+
+int async_convert_to_working_tree(struct index_state *istate,
+				  const char *path, const char *src,
+				  size_t len, struct strbuf *dst,
+				  const struct checkout_metadata *meta,
+				  void *dco)
+{
+	struct repository *repo = istate && istate->repo ?
+				  istate->repo : the_repository;
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return async_convert_to_working_tree_ca(repo, &ca, path, src, len, dst,
+						meta, dco);
+}
+
 int renormalize_buffer(struct index_state *istate, const char *path,
 		       const char *src, size_t len, struct strbuf *dst)
 {
@@ -1981,7 +2009,8 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
  * Note that you would be crazy to set CRLF, smudge/clean or ident to a
  * large binary blob you would want us not to slurp into the memory!
  */
-struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
+struct stream_filter *get_stream_filter_ca(struct repository *repo UNUSED,
+					   const struct conv_attrs *ca,
 					   const struct object_id *oid)
 {
 	struct stream_filter *filter = NULL;
@@ -2006,7 +2035,9 @@ struct stream_filter *get_stream_filter(struct index_state *istate,
 {
 	struct conv_attrs ca;
 	convert_attrs(istate, &ca, path);
-	return get_stream_filter_ca(&ca, oid);
+	return get_stream_filter_ca(istate && istate->repo ?
+				    istate->repo : the_repository,
+				    &ca, oid);
 }
 
 void free_stream_filter(struct stream_filter *filter)
diff --git a/convert.h b/convert.h
index 0a6e4086b8..137fa1593a 100644
--- a/convert.h
+++ b/convert.h
@@ -8,6 +8,7 @@
 #include "string-list.h"
 
 struct index_state;
+struct repository;
 struct strbuf;
 
 #define CONV_EOL_RNDTRP_DIE   (1<<0) /* Die if CRLF to LF to CRLF is different */
@@ -103,34 +104,26 @@ const char *get_convert_attr_ascii(struct index_state *istate,
 int convert_to_git(struct index_state *istate,
 		   const char *path, const char *src, size_t len,
 		   struct strbuf *dst, int conv_flags);
-int convert_to_working_tree_ca(const struct conv_attrs *ca,
+int convert_to_working_tree_ca(struct repository *repo,
+			       const struct conv_attrs *ca,
 			       const char *path, const char *src,
 			       size_t len, struct strbuf *dst,
 			       const struct checkout_metadata *meta);
-int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
+int async_convert_to_working_tree_ca(struct repository *repo,
+				     const struct conv_attrs *ca,
 				     const char *path, const char *src,
 				     size_t len, struct strbuf *dst,
 				     const struct checkout_metadata *meta,
 				     void *dco);
-static inline int convert_to_working_tree(struct index_state *istate,
-					  const char *path, const char *src,
-					  size_t len, struct strbuf *dst,
-					  const struct checkout_metadata *meta)
-{
-	struct conv_attrs ca;
-	convert_attrs(istate, &ca, path);
-	return convert_to_working_tree_ca(&ca, path, src, len, dst, meta);
-}
-static inline int async_convert_to_working_tree(struct index_state *istate,
-						const char *path, const char *src,
-						size_t len, struct strbuf *dst,
-						const struct checkout_metadata *meta,
-						void *dco)
-{
-	struct conv_attrs ca;
-	convert_attrs(istate, &ca, path);
-	return async_convert_to_working_tree_ca(&ca, path, src, len, dst, meta, dco);
-}
+int convert_to_working_tree(struct index_state *istate,
+			   const char *path, const char *src,
+			   size_t len, struct strbuf *dst,
+			   const struct checkout_metadata *meta);
+int async_convert_to_working_tree(struct index_state *istate,
+				  const char *path, const char *src,
+				  size_t len, struct strbuf *dst,
+				  const struct checkout_metadata *meta,
+				  void *dco);
 int async_query_available_blobs(const char *cmd,
 				struct string_list *available_paths);
 int renormalize_buffer(struct index_state *istate,
@@ -183,7 +176,8 @@ struct stream_filter; /* opaque */
 struct stream_filter *get_stream_filter(struct index_state *istate,
 					const char *path,
 					const struct object_id *);
-struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
+struct stream_filter *get_stream_filter_ca(struct repository *repo,
+					   const struct conv_attrs *ca,
 					   const struct object_id *oid);
 void free_stream_filter(struct stream_filter *);
 int is_null_stream_filter(struct stream_filter *);
diff --git a/entry.c b/entry.c
index 1c4f0f4407..7fda86e67f 100644
--- a/entry.c
+++ b/entry.c
@@ -296,11 +296,14 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 	const struct submodule *sub;
 	struct checkout_metadata meta;
 	static int scratch_nr_checkouts;
+	struct repository *repo = state->istate && state->istate->repo ?
+				  state->istate->repo : the_repository;
 
 	clone_checkout_metadata(&meta, &state->meta, &ce->oid);
 
 	if (ce_mode_s_ifmt == S_IFREG) {
-		struct stream_filter *filter = get_stream_filter_ca(ca, &ce->oid);
+		struct stream_filter *filter =
+			get_stream_filter_ca(repo, ca, &ce->oid);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
 					   state, to_tempfile,
@@ -348,9 +351,11 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 		 * Convert from git internal format to working tree format
 		 */
 		if (dco && dco->state != CE_NO_DELAY) {
-			ret = async_convert_to_working_tree_ca(ca, ce->name,
+			ret = async_convert_to_working_tree_ca(repo, ca,
+							       ce->name,
 							       new_blob, size,
-							       &buf, &meta, dco);
+							       &buf, &meta,
+							       dco);
 			if (ret) {
 				struct string_list_item *item =
 					string_list_lookup(&dco->paths, ce->name);
@@ -362,8 +367,9 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 				}
 			}
 		} else {
-			ret = convert_to_working_tree_ca(ca, ce->name, new_blob,
-							 size, &buf, &meta);
+			ret = convert_to_working_tree_ca(repo, ca, ce->name,
+							 new_blob, size, &buf,
+							 &meta);
 		}
 
 		if (ret) {
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 0bf4bd6d4a..51a4db4f67 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -279,7 +279,8 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
 	/* Sanity check */
 	ASSERT(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
 
-	filter = get_stream_filter_ca(&pc_item->ca, &pc_item->ce->oid);
+	filter = get_stream_filter_ca(the_repository, &pc_item->ca,
+					&pc_item->ce->oid);
 	if (filter) {
 		if (odb_stream_blob_to_fd(the_repository->objects, fd,
 					  &pc_item->ce->oid, filter, 1)) {
@@ -302,8 +303,9 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
 	 * checkout, so pass NULL. Note: if that changes, the metadata must also
 	 * be passed from the main process to the workers.
 	 */
-	ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
-					 blob, size, &buf, NULL);
+	ret = convert_to_working_tree_ca(the_repository, &pc_item->ca,
+					 pc_item->ce->name, blob, size, &buf,
+					 NULL);
 
 	if (ret) {
 		size_t newsize;
-- 
2.43.0

