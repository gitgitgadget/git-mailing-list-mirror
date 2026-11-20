Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176170;
	b=NKs5NNyiC7nj1pISUJZAflUjOcAeGHmLgj++Vgn0zfQgNelCAKUXzoL/fQUOhUOH9Tms
	 aLxeDG5vCLWBqWTEnADhPnyF82QUJRZNLZgmewbGMs+CKoX9Wp8Ow4LrcOwOIOC5b1PIG
	 GCp08CAGqPTczpYpk9FEUW33fZGZ5VMMgbEAsVqaqlI05e/aLI7wNdfy8jJx5OuPfxC4N
	 rN8y5ANu6ztZCryriOuWG33syFSJhYbBiM59ojO6fpcHZicDEdNgLdNZkpSu3t81gYEgO
	 eyEa79dDpt6bK4dAQ/Yq5ZiYEr4QWBD8Mc3QFzqmLY+2dXFx0gvtg1F7rj9rnI6w64A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176170;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=0tLv8G3dDM9ShRulqchRmBhVzGKwsnRBxpedodA/RjA=;
	b=VzwJZBaWyymlr7k+AyPE/eI58KhIU5eUjPjgCygBSV6HsISL1owKgAFtdc0pqPUOZFnT
	 DTOjoh/9e835gSw9tELkaDxF02zrPTwJ2hqhr+OrMpprhhiemxcd2J1g7Mmh7dOfDN2e/
	 m8YraH07Ku/2S/LboLVNdc/OvhjJk8EOlt6g718SHcVVH8mH8Q+huQMHidHJkDqY+nLCw
	 FE8UiqCxFRYZuTr9ZJJGY9N7EeW9ZuoksLT5fwlaamOZI2d+SYJ27DhbPOAFBPNYCzG51
	 SW0jIpy4K9ZNNzfYU+X/oo0JpGVhoLX+9CfNTa2iSx1Bs9bZI4JwWlDnYbIVFNktoQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Kr17Qcfq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aCAL6t6F;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0838606A326
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0838606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Kr17Qcfq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aCAL6t6F
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 03847EC08F7
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Nov 2026 07:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795176168;
	 x=1795262568; bh=0tLv8G3dDM9ShRulqchRmBhVzGKwsnRBxpedodA/RjA=; b=
	Kr17QcfqNEktAeDV09tLkTSBzZkVycHBKr09T6ThCjMYJgEaaQ39Gbc1ibn9PsMT
	gYsa8z8eXQRvRNOCmBJ05ZDyJWfQOx2PxJE31LCOlHSCcF7xh5ZEveqrEh5YxT44
	WS2UEmaDVhlpcWwdRo6ugXBJP4KES8rHY35180B+rt7DFuPCVkSLRyrrIYKkHs36
	8dGYXUTQcia3Gj6gS5C9Dw9FZsXiyC73FUuVSjzkdxcbGsgaVOk/trjb6ndGVot9
	3FnBI1vO3juMJKIeH3zm8okdSf0EVPL6VMp4Fxu735L4nmGYg4YKtCsBWW/yiTzc
	Tl67JLdTYvzYPLHSkd4fSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795176168; x=
	1795262568; bh=0tLv8G3dDM9ShRulqchRmBhVzGKwsnRBxpedodA/RjA=; b=a
	CAL6t6FfGf10nWshFT9D0urAVbjXeu82c6mBfe4KcBRSfDs30KLNe0WYzbZlG6ss
	QQaMZuQEWnHREFx6NaGhnSlD8EdJWmPCqWY7P733YEdgFg+b0xerQnSZ7vXIKVtl
	0DlN1MFvppMwo/bzzcFfn9mHErzyF2DNNWlfWuJQsFUSjDQFPdwe2Tc35OeesDFO
	kuiGVZciw12VojwkRpACF5SJEBaCPdAzlxIJDXeJH832yTPcfDhvmvTOsv3xyIJr
	e1Sx50SvwTkpOIU3BWGKLx3XUbTWClQYf/dOak6kHoxwcvYY79+4UjHHcBNHW8t7
	jkJrNh6jIl9sHpGzGg5OA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795176168; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:wOVQBNNNyoGf0VKgpjWW3y+iy5Y9iuZAYpYTywKcARLVJfl
	nPtDGFG8e0u6wB6GQC0PFYaRkfaHNR3i21waeBMyYwcZjB/SP9dqGR9J8Q44bFus
	84VyZxu2QKxeZWKNmfBx3u4e12Wc37Fx1I8maCM0VxSrTsA/78r1pin6jiwNiP2w
	gPaz9g8w7SHTg/byMIH32HtHI9rQ3wwSRyhKY4yuG+zoHxDVcVUr+owLfvNcKV54
	3BDNk0p+TyrbMWu+RQ5cQZ0KkjOBE6P0p5xE+NX8jTHaGpB/H4ksiBkzWzCaWaFQ
	FGQgdBHW9YEIMKfbau9CVmuQbQUufxYzhdLDToQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/T6AkjBNR44hEF4I/bUdbX110g3WV/196doA3AhffuM=:Xawpff4GX3ypPV9WmNljDO8C3ZhmqvUfm4RtWVkzhtA=;
X-ME-Sender: <xms:6DYAa7ty2DOriMc1QwpXgebLpmaNOUVo659qMccqBxQyHdd8zB241w>
    <xme:6DYAazbwQB8ZyGk41VtQkxAvCSMjqTL-kHuOIUm9MHVFOkUKammupX5Awc1IIOZig
    gyjjCfQdw0K6a5JNh2W0yNKMSncYA82eoRjkNqUthn4CIPwVjAGeNc>
X-ME-Received: <xmr:6DYAa0Y2YWg2Bz7a1a1qB_tLXhSGf-rg626o65NJroV2Yljr7P5FM6ImGOvnUjiBHqBFiig>
X-ME-Proxy-Cause: dmFkZTFKfMoyZ8OsQp9Wthl1HVhqbad1g1+0FOaTNrvwg/0Vd8GZUZgulm8uuAavm4txZm
    rO3CHbCoKwYYBbsY9QWAQ06x8eZrSeU0ua3vKZjzTEfsCFacma4xkKSA05wxdhhlOVlLsS
    ceKeJl0kUvaNeEYJ9RYdq8nkFwGnncNUCAN/DQ+m70/sQDBWWaiEw065fia2LIgNHUXYJQ
    9SR479uoFdaE+Y1cVkI7Ky/y56H5gBMNB5MYoU8ogwGsgTjsIoy/Q52Y+bAfZOXcP9bJwi
    aS3rRjTuRGQQz0YREwLmG9Ffr8hpmsvEZBGl8DenEqVkHuPRsEzB9OWIPoObsNzcc3yciX
    ucWCkB3Q5cHDyEnHTzsF+dHwTh0PhEPG/tPATC/oluvUno0k9huA0rShqf3cjMMmBYi3MA
    wgdXjo5vYrFn+AtuUSmkQRpC1JLYvV88LmGyp6IaJSIYOWW14xizl+IW3bFR/5edumIlta
    +7Bpp53hsvfi0+yN2uDFqbgvPQY5HnH3/5OKdFkBg9QMjOUWQv2QvLsZ+V0XQ5u6KLPRGv
    T7QM5KQrEnQbFLv7+wQLx20A2IO6XfJGg8reH82jLYd7DrEXWqPyxapHOS/7MO9H5c1Czu
    5uF74sVe2n3EOXPVGxmaJnQpWidpCCT2mKTYUOCkEXiSc83N8nOGKIsZa5Wg
X-ME-Proxy: <xmx:6DYAa_WAJO3u1qlA42KVrbLFTflKXggQDFbeIibIiRpX6eUW0JdrCw>
    <xmx:6DYAa737Z72K6qsOvLhvH1gfY6V4Ybiu8uasEXUXkq9mnORfcxup7w>
    <xmx:6DYAa2bqWMvGu6jiKt9ICVP_TW0fupbbwEzPs44XEd27W5rsUOlWrg>
    <xmx:6DYAa-p6ehAy3e_6p5IGA11P7yabt0qJVJA0d_yWDtcmdweAIZh1Pw>
    <xmx:6DYAa6f3PjDYoKez14zrNqmGbE4Lrm3rXuM1wsHoY_ADI4V1tf2YyL9l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81654b6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Nov 2026 12:02:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:02:31 +0100
Subject: [PATCH 4/6] packfile: introduce function to free a packfile
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
Message-Id: <20261120-pks-packfile-global-statistics-v1-4-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We have a bunch of callsites that want to free a packfile, which
requires them to first close it followed by a call to free(3p). This
feels rather leaky as an abstraction.

Introduce `packfile_free()` to handle this properly. This function will
also be extended in a subsequent patch to maintain a list of all packs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/index-pack.c | 10 +---------
 commit-graph.c       |  6 ++----
 connected.c          |  6 ++----
 http-walker.c        |  6 ++----
 http.c               |  2 +-
 midx-write.c         |  9 +++------
 odb/source-packed.c  |  2 +-
 packfile.c           | 10 ++++++++--
 packfile.h           |  1 +
 9 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 71048a5a8af..663375fbb36 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1755,15 +1755,7 @@ static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 	if (opts->version == 2)
 		read_v2_anomalous_offsets(p, opts);
 
-	/*
-	 * Get rid of the idx file as we do not need it anymore.
-	 * NEEDSWORK: extract this bit from free_pack_by_name() in
-	 * object-file.c, perhaps?  It shouldn't matter very much as we
-	 * know we haven't installed this pack (hence we never have
-	 * read anything from it).
-	 */
-	packfile_close_index(p);
-	free(p);
+	packfile_free(p);
 }
 
 static void show_pack_info(int stat_only)
diff --git a/commit-graph.c b/commit-graph.c
index c3b04e8c1f4..03df5fb7c1f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1958,14 +1958,12 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		}
 		if (packfile_open_index(p)) {
 			ret = error(_("error opening index for %s"), pack_indexes->items[i].string);
-			packfile_close(p);
-			free(p);
+			packfile_free(p);
 			goto cleanup;
 		}
 		for_each_object_in_pack(p, add_packed_commits, ctx,
 					ODB_FOR_EACH_OBJECT_PACK_ORDER);
-		packfile_close(p);
-		free(p);
+		packfile_free(p);
 	}
 
 cleanup:
diff --git a/connected.c b/connected.c
index fbacff734b6..78f08b41383 100644
--- a/connected.c
+++ b/connected.c
@@ -238,9 +238,7 @@ int check_connected(struct repository *repo,
 		err = error_errno(_("failed to close rev-list's stdin"));
 
 	sigchain_pop(SIGPIPE);
-	if (new_pack) {
-		packfile_close(new_pack);
-		free(new_pack);
-	}
+	if (new_pack)
+		packfile_free(new_pack);
 	return finish_command(&rev_list) || err;
 }
diff --git a/http-walker.c b/http-walker.c
index de43d9cf673..616a5fd234d 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -587,10 +587,8 @@ static void cleanup(struct walker *walker)
 
 			alt_next = alt->next;
 
-			for (e = alt->packs.head; e; e = e->next) {
-				packfile_close(e->pack);
-				free(e->pack);
-			}
+			for (e = alt->packs.head; e; e = e->next)
+				packfile_free(e->pack);
 			packfile_list_clear(&alt->packs);
 
 			free(alt->base);
diff --git a/http.c b/http.c
index e86bebdffb2..d518683e15e 100644
--- a/http.c
+++ b/http.c
@@ -2661,7 +2661,7 @@ static int fetch_and_setup_pack_index(struct packfile_list *packs,
 	packfile_close_index(new_pack);
 	free(tmp_idx);
 	if (ret) {
-		free(new_pack);
+		packfile_free(new_pack);
 		return -1;
 	}
 
diff --git a/midx-write.c b/midx-write.c
index d5be4e40843..3e227bb5e57 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -182,8 +182,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		if (packfile_open_index(p)) {
 			warning(_("failed to open pack-index '%s'"),
 				full_path);
-			packfile_close(p);
-			free(p);
+			packfile_free(p);
 			return;
 		}
 
@@ -1827,10 +1826,8 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 cleanup:
 	for (size_t i = 0; i < ctx.nr; i++) {
-		if (ctx.info[i].p) {
-			packfile_close(ctx.info[i].p);
-			free(ctx.info[i].p);
-		}
+		if (ctx.info[i].p)
+			packfile_free(ctx.info[i].p);
 		free(ctx.info[i].pack_name);
 	}
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 87e2dcdf52e..866b4e890b6 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -862,7 +862,7 @@ static void odb_source_packed_free(struct odb_source *source)
 
 	odb_source_close(source);
 	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
-		free(e->pack);
+		packfile_free(e->pack);
 	packfile_list_clear(&packed->packs);
 
 	strmap_clear(&packed->packs_by_path, 0);
diff --git a/packfile.c b/packfile.c
index 9b03258311f..077b0395a79 100644
--- a/packfile.c
+++ b/packfile.c
@@ -217,7 +217,7 @@ struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
 	free(path);
 	hashcpy(p->hash, sha1, p->repo->hash_algo);
 	if (check_packed_git_idx(idx_path, p)) {
-		free(p);
+		packfile_free(p);
 		return NULL;
 	}
 
@@ -732,7 +732,7 @@ struct packed_git *packfile_from_idx(struct repository *r, const char *path,
 
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
-		free(p);
+		packfile_free(p);
 		return NULL;
 	}
 
@@ -752,6 +752,12 @@ struct packed_git *packfile_from_idx(struct repository *r, const char *path,
 	return p;
 }
 
+void packfile_free(struct packed_git *p)
+{
+	packfile_close(p);
+	free(p);
+}
+
 void packfile_store_add_pack(struct odb_source_packed *store,
 			     struct packed_git *pack)
 {
diff --git a/packfile.h b/packfile.h
index f817bc69e29..f314a55a904 100644
--- a/packfile.h
+++ b/packfile.h
@@ -223,6 +223,7 @@ struct object_database;
 
 struct packed_git *packfile_from_idx(struct repository *r, const char *path,
 				     size_t path_len, int local);
+void packfile_free(struct packed_git *p);
 
 /*
  * mmap the index file for the specified packfile (if it is not

-- 
2.56.1.831.g720f3f5937.dirty

