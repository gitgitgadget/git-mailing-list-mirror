Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759841;
	b=nLhiddC+Mr5ZaQTxQcy6EAb3DLIGm/EqhqmqrY9JdLYQVL5EIO7316ulSwStrTvfBVYH
	 sr64g/VN3Mx3K2pzaV7lXAhUTBKiUlTIHft3u386HVum36IHS5oeWpPMD8xkGE+QCBsvT
	 WyTsCHgqo15lsuTkcKl13IR+p9CssJuuZC4MMHX2hpjN8Hu6mcFmYweQwWQGeUOzYybWC
	 7m2xTyUXxD+ufZL2tFAomt5eo5nVTypmo36XbKoKvok4rXdv4nLsXbx/59bVIcYcgZgFC
	 eNRlQQomkm52kXlcw+Bqf0BzVv1fMDxMy5BQ3tV+78W8jOWhfH00EhgaUCkHXU2HSaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759841;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=NMJXcRiZ6tncck4G3wdDqWlDn0TchiNmmfeF1W3IISQ=;
	b=wi9M5HL+PdfwLyVnXN0zQdJryMNgEcLXrhty5+s0xlz/E/+uCx7EPK9eb7KAEHB52TUY
	 p5A+/OQEhFMgxr0LvGvuuMZcrKDN71tYZ4eDHbYpV+0iyrXjaW/takB2iAX5SdPYTWNWS
	 mn/j68IUWM8X1tNZshRwdNOMSvgdIiaTXN29p01u8E2LJNlLfXgmk+hiqgITXCaymFsnu
	 gprcjWr4NJiWDxCbGGTkuDcyzE1nW2DmhnOCHSXGj1L1w58Ryuu2iw7QpMP44FFcO1wcr
	 nzoqgbk+pY/6pyP63WfiR8r5+MI5HMdZFXPgTQ2E9yPk0dA0/BKcUOJvGEDlxaAIpOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=udwNAsoW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XG0HAWkC;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03965606A332
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03965606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=udwNAsoW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XG0HAWkC
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CF551D0020A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 08:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759840;
	 x=1792846240; bh=NMJXcRiZ6tncck4G3wdDqWlDn0TchiNmmfeF1W3IISQ=; b=
	udwNAsoWcdfxhl2mwsl7cHBBc7iyD3n3KwuakF9ziVWCpbCk9mZPqkh1W9y1LVaA
	qHlDZvwjZhNMg+Lgz/ua2KqRwp3xaGGwP+UhxthEec0ABsO5cNMRtgwzdPA4XDGi
	SI3jsVF6u3rAdFnqY3DNujqO1toEiWSuU1ImJdJbbX8BFRciUKiiskA2FtehZtjI
	vmRfPx3lWnGmHuNmaNO/qZ/eQTOr9I2+i27W1ivRTDciQfvIk3vbsQ0vVxYor+VC
	SnoOnG4LgoJwbA4CXiQ+OqAQAaRS/fqUUey6IWgK3mfBUZTw/eCqjglYur11PGB8
	IQw9pzo3Sl+HR+BB291lig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759840; x=
	1792846240; bh=NMJXcRiZ6tncck4G3wdDqWlDn0TchiNmmfeF1W3IISQ=; b=X
	G0HAWkCkheiTmQp/hOjN0WKJXnJ7TnjLjKtNqdVYLUb9CtKw93REkQXJUWEs3ZKQ
	V4Vh8BbqECAmQfUQc+Ps5jwGfXOoko7epuOSfNaKajlsAVd42ZfZhNM61u0h8YgF
	RqQfELJ3cNtCUGtlRnTniQLepq+P8K9Hix5LbJehPp8PeGcXyr6yiuU0gi2eS74B
	YyAD1plxO4dyOeH5/lNo9no94sMS5SAgm/Hic+c10KF4e0zrRpcFOEVLSszz3uLk
	BwEu+/zIJnVb7uCeeqr1bpwQUDqdFkn76BZAH2QNEFaDRmDxR6SUb0LPjgSmT312
	z0uu2sBkqMnGJXVkRFByA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759840; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mHVp6ZKtjV1hBmmmsM5Rw0NinrCG0/Rorbemnb9iYDUJ7ow
	PEC1zI6NrTQYm4SS9JPh9dJyrjIQ90EBiwRnLxWHC0RAYpolpyKw7PgwPYxKDVLa
	fw/4jbAfSbf0kG7vTna/B6ElDS2JpHfvceQWYlMNcM8o1P8NLqBRStVSulSr+KRi
	B/wjfoigz9J0yHxxIx2NWLn70JjKzsRQs8l8QrCyPRJIdgGSH2IXfCwWSoASHrPk
	lzkf21sBA4xwHi/5w9Wj3j3fEhIo2501MFVgP3Ly0jcMC/0WXMF/kuMc5Md09kh+
	gcuTR3LJ5ncPr0obyyGAtRYwMb4BDTyV4Akanew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JWs0y+EF8MiQQhUMRXdbP+/xg2wC3IYk4QZ5Sy+waxY=:SRYplToW8AizyA1/blO0x4DQgiOrEqjQr4aD5YiyEgk=;
X-ME-Sender: <xms:IFjbavURCj-8C9Kxbhn9ak763SZzegzP5lW2lBvZN5S4mh9Hqj10kA>
    <xme:IFjbaujX543EMdwqJyIkReYm8i7FoJzN-mYjr_blHBplkR3TtCU5az7dhZekGX22q
    Cc9RUV97oIGZdKRx7_5ubvzfKYfC8IlKEtK293nT_w2owpVEsgYrA>
X-ME-Received: <xmr:IFjbahDJs21DJZBgNap9aItwOjdH1r7Sv_2N6vnxnuJ7t7-Hrunq7hr3H9lXxGaeEngf4A>
X-ME-Proxy-Cause: dmFkZTEULBe8RAlpP2ZtTbAoqQi0+Zd71ZU/8ok9/tQcmFVCK7qn/P6h7sYuEz98YdD6zb
    EGwUeqTCkWcm60BLl2bU8LGFB1KUQ24d7Cb4+EJYvuK/p1YZRP4+zT0njrM2HM3z+eq2mw
    vaPBpZMRUO0aXLsMYeWb6MsGZ9qOI0yBLwhI9NC0QQXz2V7Zuaodkt7pYFmMkFN0uMQXGy
    0/PqA0kteTjct1G0s5dVsPIx6KnQEdjxCk5ssypQibFMIixOA1dQPhKUAVSkvh69JhiZPK
    myQVfwho2v2r+R7p8DHNbLL4TFqbSnt5vFWBwzmYfgm9ffWnfFvAD6pGCqOkR+l+e88QdX
    2xctWTTBHcAjMTJfqN69u73diBOeG4eXN7swk7zDq/XJsgSQzvUwyXt7Gi2e98pC5YNtt5
    MOAmWrvBdUjyS64b5mg79S6uiX+pCbFgRglV10ZJPF27kzZPbg8ylw1nd27KwFhod/DSFb
    PXE/7UPh+3pQJB+sYCDlNLO9QB3baOgohJWaoeQlhzQAoAMxv7QOkJJOppKy21MVLblrre
    E/CywqB6km5N3n+Kysd3FcgQ84ScnOh966xcC3f6Z9L3PULaRzqVMcaL9T+NUFKsBRTpLF
    OX+9sxD0X+1L6vcHPCmJ78ZBDE9ZsgpS+xlc2hcnxZmkF7FxkR7gojSHsUZQ
X-ME-Proxy: <xmx:IFjbavd8Zt91S564kgnPE71jXF-cN5KDrgb00YccgbyUsK9uWNnxEQ>
    <xmx:IFjbapcUwjnDX7Xy_JquMsXLkApY-4wjwzVek1BwT23eakCKd8fXxA>
    <xmx:IFjbajhbAaUpNMSRmqUMXwBCRorBV4yR7uqz4hHm1pHsb9FrP9ODtA>
    <xmx:IFjbalQwJzAQMIyale0pcKNLgEFwgJoCO-1Ac-4GJX5rL6JSC9XMVA>
    <xmx:IFjbain43yeOadZDqLWV833N2BZ8wp8Ayh8Woz0gwZ2DGbcXMF8D2kBm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c75d2ac3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 23 Oct 2026 12:50:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:50:18 +0200
Subject: [PATCH 1/7] rerere: stop using `the_repository` in `rerere_path()`
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-pks-rerere-wo-the-repository-v1-1-b6ac0c2e4b81@pks.im>
References: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
In-Reply-To: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `rerere_path()` computes paths of rerere cache entries
contained in the "rr-cache" directory of `the_repository`. This makes us
implicitly depend on global state.

Add a repository parameter so that callers can specify which repository
to compute the path for. Adjust the internal helpers that call it to
pass down the repository they already have available in their contexts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c |  6 +++--
 rerere.c         | 82 +++++++++++++++++++++++++++++---------------------------
 rerere.h         |  3 ++-
 3 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index ca69505283..e900e302c3 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -129,8 +129,10 @@ int cmd_rerere(int argc,
 		for (size_t i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
 			const struct rerere_id *id = merge_rr.items[i].util;
-			if (diff_two(rerere_path(&buf, id, "preimage"), path, path, path))
-				die(_("unable to generate diff for '%s'"), rerere_path(&buf, id, NULL));
+			if (diff_two(rerere_path(the_repository, &buf, id, "preimage"),
+				     path, path, path))
+				die(_("unable to generate diff for '%s'"),
+				    rerere_path(the_repository, &buf, id, NULL));
 		}
 
 		strbuf_release(&buf);
diff --git a/rerere.c b/rerere.c
index 7fc32f2cf0..356111838c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -95,17 +95,18 @@ static void assign_variant(struct rerere_id *id)
 	id->variant = variant;
 }
 
-const char *rerere_path(struct strbuf *buf, const struct rerere_id *id, const char *file)
+const char *rerere_path(struct repository *repo,
+			struct strbuf *buf, const struct rerere_id *id, const char *file)
 {
 	if (!file)
-		return repo_git_path_replace(the_repository, buf, "rr-cache/%s",
+		return repo_git_path_replace(repo, buf, "rr-cache/%s",
 					     rerere_id_hex(id));
 
 	if (id->variant <= 0)
-		return repo_git_path_replace(the_repository, buf, "rr-cache/%s/%s",
+		return repo_git_path_replace(repo, buf, "rr-cache/%s/%s",
 					     rerere_id_hex(id), file);
 
-	return repo_git_path_replace(the_repository, buf, "rr-cache/%s/%s.%d",
+	return repo_git_path_replace(repo, buf, "rr-cache/%s/%s.%d",
 				     rerere_id_hex(id), file, id->variant);
 }
 
@@ -609,8 +610,8 @@ static int try_merge(struct index_state *istate,
 	mmfile_t base = {NULL, 0}, other = {NULL, 0};
 	struct strbuf buf = STRBUF_INIT;
 
-	if (read_mmfile(&base, rerere_path(&buf, id, "preimage")) ||
-	    read_mmfile(&other, rerere_path(&buf, id, "postimage"))) {
+	if (read_mmfile(&base, rerere_path(istate->repo, &buf, id, "preimage")) ||
+	    read_mmfile(&other, rerere_path(istate->repo, &buf, id, "postimage"))) {
 		ret = LL_MERGE_CONFLICT;
 	} else {
 		/*
@@ -650,8 +651,8 @@ static int merge(struct index_state *istate, const struct rerere_id *id, const c
 	 * Normalize the conflicts in path and write it out to
 	 * "thisimage" temporary file.
 	 */
-	if ((handle_file(istate, path, NULL, rerere_path(&buf, id, "thisimage")) < 0) ||
-	    read_mmfile(&cur, rerere_path(&buf, id, "thisimage"))) {
+	if ((handle_file(istate, path, NULL, rerere_path(istate->repo, &buf, id, "thisimage")) < 0) ||
+	    read_mmfile(&cur, rerere_path(istate->repo, &buf, id, "thisimage"))) {
 		ret = 1;
 		goto out;
 	}
@@ -664,9 +665,9 @@ static int merge(struct index_state *istate, const struct rerere_id *id, const c
 	 * A successful replay of recorded resolution.
 	 * Mark that "postimage" was used to help gc.
 	 */
-	if (utime(rerere_path(&buf, id, "postimage"), NULL) < 0)
+	if (utime(rerere_path(istate->repo, &buf, id, "postimage"), NULL) < 0)
 		warning_errno(_("failed utime() on '%s'"),
-			      rerere_path(&buf, id, "postimage"));
+			      rerere_path(istate->repo, &buf, id, "postimage"));
 
 	/* Update "path" with the resolution */
 	f = fopen(path, "w");
@@ -705,11 +706,11 @@ static void update_paths(struct repository *r, struct string_list *update)
 		die(_("unable to write new index file"));
 }
 
-static void remove_variant(struct rerere_id *id)
+static void remove_variant(struct repository *r, struct rerere_id *id)
 {
 	struct strbuf buf = STRBUF_INIT;
-	unlink_or_warn(rerere_path(&buf, id, "postimage"));
-	unlink_or_warn(rerere_path(&buf, id, "preimage"));
+	unlink_or_warn(rerere_path(r, &buf, id, "postimage"));
+	unlink_or_warn(rerere_path(r, &buf, id, "preimage"));
 	id->collection->status[id->variant] = 0;
 	strbuf_release(&buf);
 }
@@ -743,7 +744,7 @@ static void do_rerere_one_path(struct index_state *istate,
 			const int had_postimage =
 				id->collection->status[variant] & RR_HAS_POSTIMAGE;
 			const char *postimage =
-				rerere_path(&buf, id, "postimage");
+				rerere_path(istate->repo, &buf, id, "postimage");
 
 			if (copy_file(the_repository,
 				      postimage,
@@ -784,7 +785,7 @@ static void do_rerere_one_path(struct index_state *istate,
 		 * cleanly, there is no point maintaining our own variant.
 		 */
 		if (0 <= id->variant && id->variant != variant)
-			remove_variant(id);
+			remove_variant(istate->repo, id);
 
 		if (rerere_autoupdate)
 			string_list_insert(update, path);
@@ -802,10 +803,10 @@ static void do_rerere_one_path(struct index_state *istate,
 
 	variant = id->variant;
 	if (handle_file(istate, path, NULL,
-			rerere_path(&buf, id, "preimage")) < 0)
+			rerere_path(istate->repo, &buf, id, "preimage")) < 0)
 		goto out;
 	if (id->collection->status[variant] & RR_HAS_POSTIMAGE) {
-		const char *path = rerere_path(&buf, id, "postimage");
+		const char *path = rerere_path(istate->repo, &buf, id, "postimage");
 		if (unlink(path))
 			die_errno(_("cannot unlink stray '%s'"), path);
 		id->collection->status[variant] &= ~RR_HAS_POSTIMAGE;
@@ -846,7 +847,7 @@ static int do_plain_rerere(struct repository *r,
 		 */
 		ret = handle_file(r->index, path, hash, NULL);
 		if (ret != 0 && string_list_has_string(rr, path)) {
-			remove_variant(string_list_lookup(rr, path)->util);
+			remove_variant(r, string_list_lookup(rr, path)->util);
 			string_list_remove(rr, path, 1);
 		}
 		if (ret < 1)
@@ -856,7 +857,7 @@ static int do_plain_rerere(struct repository *r,
 		string_list_insert(rr, path)->util = id;
 
 		/* Ensure that the directory exists. */
-		safe_create_dir_in_gitdir(the_repository, rerere_path(&buf, id, NULL));
+		safe_create_dir_in_gitdir(the_repository, rerere_path(r, &buf, id, NULL));
 	}
 
 	for (i = 0; i < rr->nr; i++)
@@ -1091,8 +1092,8 @@ static int rerere_forget_one_path(struct index_state *istate,
 		if (!has_rerere_resolution(id))
 			continue;
 
-		handle_cache(istate, path, hash, rerere_path(&buf, id, "thisimage"));
-		if (read_mmfile(&cur, rerere_path(&buf, id, "thisimage"))) {
+		handle_cache(istate, path, hash, rerere_path(istate->repo, &buf, id, "thisimage"));
+		if (read_mmfile(&cur, rerere_path(istate->repo, &buf, id, "thisimage"))) {
 			error(_("failed to update conflicted state in '%s'"), path);
 			goto fail_exit;
 		}
@@ -1108,7 +1109,7 @@ static int rerere_forget_one_path(struct index_state *istate,
 		goto fail_exit;
 	}
 
-	filename = rerere_path(&buf, id, "postimage");
+	filename = rerere_path(istate->repo, &buf, id, "postimage");
 	if (unlink(filename)) {
 		if (errno == ENOENT)
 			error(_("no remembered resolution for '%s'"), path);
@@ -1122,7 +1123,7 @@ static int rerere_forget_one_path(struct index_state *istate,
 	 * conflict in the working tree, run us again to record
 	 * the postimage.
 	 */
-	handle_cache(istate, path, hash, rerere_path(&buf, id, "preimage"));
+	handle_cache(istate, path, hash, rerere_path(istate->repo, &buf, id, "preimage"));
 	fprintf_ln(stderr, _("Updated preimage for '%s'"), path);
 
 	/*
@@ -1181,25 +1182,25 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
  * Garbage collection support
  */
 
-static timestamp_t rerere_created_at(struct rerere_id *id)
+static timestamp_t rerere_created_at(struct repository *r, struct rerere_id *id)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct stat st;
 	timestamp_t ret;
 
-	ret = stat(rerere_path(&buf, id, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
+	ret = stat(rerere_path(r, &buf, id, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
 
 	strbuf_release(&buf);
 	return ret;
 }
 
-static timestamp_t rerere_last_used_at(struct rerere_id *id)
+static timestamp_t rerere_last_used_at(struct repository *r, struct rerere_id *id)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct stat st;
 	timestamp_t ret;
 
-	ret = stat(rerere_path(&buf, id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
+	ret = stat(rerere_path(r, &buf, id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
 
 	strbuf_release(&buf);
 	return ret;
@@ -1208,11 +1209,11 @@ static timestamp_t rerere_last_used_at(struct rerere_id *id)
 /*
  * Remove the recorded resolution for a given conflict ID
  */
-static void unlink_rr_item(struct rerere_id *id)
+static void unlink_rr_item(struct repository *r, struct rerere_id *id)
 {
 	struct strbuf buf = STRBUF_INIT;
-	unlink_or_warn(rerere_path(&buf, id, "thisimage"));
-	remove_variant(id);
+	unlink_or_warn(rerere_path(r, &buf, id, "thisimage"));
+	remove_variant(r, id);
 	id->collection->status[id->variant] = 0;
 	strbuf_release(&buf);
 }
@@ -1231,18 +1232,19 @@ static void rerere_gc_cutoffs(struct repository *r,
 		*cutoff_noresolve = now - 15 * 86400;
 }
 
-static bool rerere_id_is_stale(struct rerere_id *id,
+static bool rerere_id_is_stale(struct repository *r,
+			       struct rerere_id *id,
 			       timestamp_t cutoff_resolve,
 			       timestamp_t cutoff_noresolve)
 {
 	timestamp_t then;
 	timestamp_t cutoff;
 
-	then = rerere_last_used_at(id);
+	then = rerere_last_used_at(r, id);
 	if (then) {
 		cutoff = cutoff_resolve;
 	} else {
-		then = rerere_created_at(id);
+		then = rerere_created_at(r, id);
 		if (!then)
 			return false;
 		cutoff = cutoff_noresolve;
@@ -1251,11 +1253,11 @@ static bool rerere_id_is_stale(struct rerere_id *id,
 	return then < cutoff;
 }
 
-static void prune_one(struct rerere_id *id,
+static void prune_one(struct repository *r, struct rerere_id *id,
 		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
 {
-	if (rerere_id_is_stale(id, cutoff_resolve, cutoff_noresolve))
-		unlink_rr_item(id);
+	if (rerere_id_is_stale(r, id, cutoff_resolve, cutoff_noresolve))
+		unlink_rr_item(r, id);
 }
 
 /* Does the basename in "path" look plausibly like an rr-cache entry? */
@@ -1297,7 +1299,7 @@ bool rerere_gc_needed(struct repository *r, size_t limit)
 		for (id.variant = 0;
 		     id.variant < id.collection->status_nr;
 		     id.variant++) {
-			if (rerere_id_is_stale(&id, cutoff_resolve,
+			if (rerere_id_is_stale(r, &id, cutoff_resolve,
 					       cutoff_noresolve)) {
 				count += 256;
 				if (count >= limit) {
@@ -1349,7 +1351,7 @@ void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 		for (id.variant = 0, id.collection = rr_dir;
 		     id.variant < id.collection->status_nr;
 		     id.variant++) {
-			prune_one(&id, cutoff_resolve, cutoff_noresolve);
+			prune_one(r, &id, cutoff_resolve, cutoff_noresolve);
 			if (id.collection->status[id.variant])
 				now_empty = 0;
 		}
@@ -1387,8 +1389,8 @@ void rerere_clear(struct repository *r, struct string_list *merge_rr)
 		struct strbuf buf = STRBUF_INIT;
 
 		if (!has_rerere_resolution(id)) {
-			unlink_rr_item(id);
-			rmdir(rerere_path(&buf, id, NULL));
+			unlink_rr_item(r, id);
+			rmdir(rerere_path(r, &buf, id, NULL));
 		}
 
 		strbuf_release(&buf);
diff --git a/rerere.h b/rerere.h
index 1182ee3fb1..ee8d97917d 100644
--- a/rerere.h
+++ b/rerere.h
@@ -34,7 +34,8 @@ int repo_rerere(struct repository *, int);
  * path to that filesystem entity.  With "file" specified with NULL,
  * return the path to the directory that houses these files.
  */
-const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
+const char *rerere_path(struct repository *,
+			struct strbuf *buf, const struct rerere_id *,
 			const char *file);
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);

-- 
2.56.0.307.g5fe7bd680c.dirty

