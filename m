Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522590;
	b=o65Zibq7EPpDe3lqZcR/s0NjuF+623GDizt4mJaAjXJjY4buj8sM5/S0pQCVoI+1pdC1
	 rCxmVAXAcocesy6nzQfecidPtTZEl9XI+gwR98Ywtruzerz1jkxF7rpcuHbaC28lCDKfF
	 96EPEpwdwTVeLdzQRpY1TVZpCtGHtAX3b909cAMPiT8LPdRvHD2kMi9dJWLbD3PDCufMl
	 EiL3n/s9nwRAeSEFvwbp07FQp87fKypzKSmVR7GJ+NTwvNJeTiMkodWw/OliGJBra1YWh
	 yAPZQyyYm43RBzlSKmhD5ZpYhLD5tpxOapsEggfLlPqv1yIT5mUV3jZKFZpiFslKmrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=tpOYhkA9WuRUFjNYGV81IX9v1Q2PrNySANaoi8RpAOM=;
	b=QaL8rnormSUxsnrIpqhKIwiH/9Jx5CmTNuZEpMvm88ADPBn8PD1BKoRw77xy7OAGIQW6
	 EHds0F61sJ2mk6n0mJz1al1YLgyF7kxTHmL3yRjrljaMn9q1Rggy3KieDmZwZRyHIKmjP
	 Yaos62MR58WzwS7YJ/+D52bdX9Z2Jh64KRDQs57tqCEkAOmR2k5LjjhYYUVd1isWHDrG/
	 N/+mjmUs+si9mLt1jp/GsO63j0jBLKkCsvCyWOdRYWqVYIwY25K6OvP/ddLgtVAzzPHpy
	 mmxPzdJipT8GvjJq0F+H7uSMGrt3FE9WaSLv3MsW2xjVGY4T1Fgr9s28okDFdbru4Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C4TRX9Wj;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61777606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61777606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C4TRX9Wj
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f432ac553fso2733078a34.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792522589; x=1793127389; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tpOYhkA9WuRUFjNYGV81IX9v1Q2PrNySANaoi8RpAOM=;
        b=C4TRX9WjQtzcWO0Mwo8nPoCCkHBccRxiSSGymKfRjFHEmgPIsIX4WZs+syxHYrdi6w
         JM1iUfRbEhsAMGnU9ccS12oNAL61UqS6zjraE9p7A1h1pAlUIZpJMirTs0UJl4qQFGWB
         ARNaozFR1jqzHaWkF8KFhbIEEZcmacbfInsx9nuRqI7m6aC0+JFmPQh2Iqm2blJkfCiA
         6wBErWdijhdQgZsR+IPid3cEbyMJWn/O8n55XEICqB1KJ1RXV6Du7tlp5OvQstXnP3Ep
         bTi02+Do+p7KBaheEyNuvLkReRtYx6nHu16sZk7xdc19h+fKdSSwZKk5nnv42jTKu6mH
         oYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792522589; x=1793127389;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tpOYhkA9WuRUFjNYGV81IX9v1Q2PrNySANaoi8RpAOM=;
        b=IqAptk3xfHn9ovPw63hlTcOtGRycWjXe39z3/Ub+K948vNhOh/GPZJKJwtYTyJEBkA
         or+vOkqHTJ+vEPt2V0Snk5JENxSfbYNo52+JnbHqKtfRNn9yZovPqA57D7qQs7059+H7
         SV3XYiy4C3F6PUnvTNh2+Q3HGQzVD1GwJX8KOPqIwRCmEo1ykbJDHb4z6i4f436NFWue
         f8AVPOKO0T1VUdWUHxLtmzoqWsi68rOfQ+9+xQwjT7KrTzyLIy6Uu4sjyQLbdtVCB6N8
         3lDumIX853zTp3O0SPqxZFscUJ7+3gvg5MgDXcrdsKRoB/V8Z4T2/eqPldJKZTmK97Hd
         y1hg==
X-Gm-Message-State: AFq9FYIIgBzB0JankUX9xf3cv3t+oFOOXbnc72BlDvltmtdzFhD/47K5
	UKjyR1lP4LBmsWp7uKw03FY+AbNmjPsJ4zGGpSVxQgQl0fERIHbl2zMl+uf0zQ==
X-Gm-Gg: AYBFou3W6EfDUeG2Mx9uKfZxx0ioPMDVPpmJXPrHvAlfeUYlH3qIjHmXBO3ycIisJkD
	iuIa4CWZwI+xTPtqdSqN2YQqOX2nBv6HfbIOntoSh0pS/B5LeX3kLRBcvdZCVwKMawX7XjM5PXU
	Wa4UaFX9BY80YyOlptkSSnCaRQnDcjOPQJEBVF2UZ+gU6Dt8utp12LtMJG76QCOEcB5xb/9k8Sy
	J3gZWraOfSgByfj+euHrNbHiBbkt57DaUwL/Z0M3Q2oBEbzSu6YkXGUkVXEs8y3AKnXoIDY2eq7
	Xgau/+8ff0o4M7+FmSvBbKX6as5ibhB4c0C/jkay/WJyv4VSfBggbTUVx8VfvP2Xmp7i3EgM2Sf
	yD/lCIljre6erlBOWnMsSsyp2fzqOutw7xMeTmbQkqyMGHkIxqQVpXqxHN+vmi8+Of82Sv2Lef1
	SxIY3mtsMSpPaMYnII+ZKfCoNfnImHmukyrCtEE8x42FRUA+/RxZ1zN9DIiTUpfXNHCWAP5HOec
	w==
X-Received: by 2002:a05:6830:6a8f:b0:844:ec25:c7e9 with SMTP id 46e09a7af769-844f93c57ddmr12811619a34.3.1792522589278;
        Tue, 20 Oct 2026 11:56:29 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.153.90])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd9d82sm292687a34.10.2026.10.20.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:56:28 -0700 (PDT)
Message-Id: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
From: "Joy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 18:56:27 +0000
Subject: [PATCH] config: move pack size limit into repo config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Usman Akinyemi>" <usmanakinyemi202@gmail.com>,
    "Christian Couder>" <christian.couder@gmail.com>,
    Joy <soniqjjj@gmail.com>,
    Joy Gundu <soniqjjj@gmail.com>

From: Joy Gundu <soniqjjj@gmail.com>

Store the pack.packsizelimit value in repository configuration
rather than keeping it in a standalone global variable for the repository.

Update the configuration parser and pack-writing code to read
the value from repo_config_values rather than a global variable.

This change removes one piece of global configuration state from Git
and helps make Git code easier to reuse as a library component.

Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
---
    config: move pack size limit into repo config

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2271%2FJoiejoie1%2Foutreachy%2Fglobal-state-mini-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2271/Joiejoie1/outreachy/global-state-mini-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2271

 builtin/pack-objects.c | 2 +-
 environment.c          | 4 ++--
 environment.h          | 3 +--
 object-file.c          | 6 ++++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index af9390a46b..1c9044060d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5380,7 +5380,7 @@ int cmd_pack_objects(int argc,
 	if (!HAVE_THREADS && delta_search_threads != 1)
 		warning(_("no threads support, ignoring --threads"));
 	if (!pack_to_stdout && !pack_size_limit)
-		pack_size_limit = pack_size_limit_cfg;
+		pack_size_limit = cfg->pack_size_limit;
 	if (pack_to_stdout && pack_size_limit)
 		die(_("--max-pack-size cannot be used to build a pack for transfer"));
 	if (pack_size_limit && pack_size_limit < 1024*1024) {
diff --git a/environment.c b/environment.c
index c83cf44839..e350d6949e 100644
--- a/environment.c
+++ b/environment.c
@@ -57,7 +57,6 @@ char *check_roundtrip_encoding;
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
 int grafts_keep_true_parents;
-unsigned long pack_size_limit_cfg;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
@@ -728,7 +727,7 @@ int git_default_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(var, value, ctx->kvi);
+		cfg->pack_size_limit = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
@@ -768,6 +767,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->check_stat = 1;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
+	cfg->pack_size_limit = 0;
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 	cfg->core_sparse_checkout_cone = 0;
 	cfg->warn_on_object_refname_ambiguity = 1;
diff --git a/environment.h b/environment.h
index b336459e90..070314f7ef 100644
--- a/environment.h
+++ b/environment.h
@@ -132,6 +132,7 @@ struct repo_config_values {
 	int check_stat;
 	int zlib_compression_level;
 	int pack_compression_level;
+	unsigned long pack_size_limit;
 	int precomposed_unicode;
 	int core_sparse_checkout_cone;
 	int warn_on_object_refname_ambiguity;
@@ -235,8 +236,6 @@ int have_git_dir(void);
 /* Environment bits from configuration mechanism */
 extern int minimum_abbrev, default_abbrev;
 extern int assume_unchanged;
-extern unsigned long pack_size_limit_cfg;
-
 extern int grafts_keep_true_parents;
 
 const char *get_log_output_encoding(void);
diff --git a/object-file.c b/object-file.c
index 210984f825..3178bd6e65 100644
--- a/object-file.c
+++ b/object-file.c
@@ -885,6 +885,8 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 								 struct odb_transaction_files,
 								 base);
 	struct transaction_packfile *state = &transaction->packfile;
+	struct repo_config_values *cfg =
+		repo_config_values(the_repository);
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
@@ -906,8 +908,8 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	 * the difference between the inflated and on-disk size is limited
 	 * to zlib compression and is sufficient for this check.
 	 */
-	if (state->nr_written && pack_size_limit_cfg &&
-	    pack_size_limit_cfg < state->offset + stream->size) {
+	if (state->nr_written && cfg->pack_size_limit &&
+	    cfg->pack_size_limit < state->offset + stream->size) {
 		flush_packfile_transaction(transaction);
 		odb_reprepare(transaction->base.source->odb);
 	}

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
gitgitgadget
