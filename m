Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710126;
	b=pneLJv6rvg6Ntq7nWEeGK7pZrLdRe+CNGnGEsBuPgJA8UkC5whw5EJokhs9qHB1fdQI6
	 91/X27VfJ7n8yMB1hgjD089MtkYdDwoUSr8hWvexypa6wDnXc5LcqEp+7kviJpMWXgnl6
	 o756+GP7AKO2GYKoycT5ueXU1BPirz+Ea5As8FNhPU+Gfhd/3LgZ2wGNeUYUnVIDzzwC+
	 yseospHAcP3B8rFrgxWzpj33jadx5g9OF5VQF91ben0q9Sf6um2eqP32m6m5/6p5q7WQt
	 NFariqU3MjA3GtrvH34zNNwJaro42rNCaECQCnk/EpySPqswVjuq48pe3jE1/vB/iBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=RFs0hSlv90sd3ashD55+FVRZv4kgb67zAtvvsx9sQ6A=;
	b=Uj6z2ysZX8NxIgSztBKNBvTsQDNoetMKTZdq0p+PgM/+j8wJUhiwDeLCt4ErRcb6xAx7
	 N3Uqt3WEjldjBRtni/zAzeHUXTLtUN8E2jISwyxfOrd5DWv0HhceGqO9+DLZQAfWCgMbZ
	 jorFgWJ2vEWObtgN5q67P3eCu8D8DQRBVqa7x/3/HpF2ghUunVFm3O416cqi8po/ejgui
	 mdbM/eHIFAosGKAKMj4wp1Bcbz5cZZOTdp2gvSsNI3Puac+bGzd/0EBRJfcRqY8bR1Tka
	 ZtcSxY8dFVFQ3LcuWSGWqlDgU/VnzEU3ObOfrKF3q+FtTb3YbE01xeEq6WZxqgFmEQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=job7g1S+;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A568606A33A
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A568606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=job7g1S+
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-486f013db83so1048491fac.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 04:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793710125; x=1794314925; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RFs0hSlv90sd3ashD55+FVRZv4kgb67zAtvvsx9sQ6A=;
        b=job7g1S+Ko7NG22tiKcbmoANfogGo3+VjA9EPRS+bbp4x0v9UhoKH2AaKj68Zeg8jW
         Fm8D5a9c/bM6ITnVBXL9Jv2EEekonWZX5WTK5nA0JUAoQZLmWmgMsy5Q2mPoIKOyv8Eh
         XvWKnElQPCvcoqr42y67T6PfOodrR1weqBcPsW404yrxhnsWHszlWsZGvXxhS64wMDoT
         EiMmiRESERvO4efxb4hWi8maL85YM1ATBlgh2JM0NaIjAgM5Zk38l8XN0EEiPQj3VA2Q
         tNDXKvzcbtEDqS9OWcA9zc/kjegr/H2QXOA6pzL84jN4XO1ZD+607nD4T33AKvsOqYJN
         8cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710125; x=1794314925;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFs0hSlv90sd3ashD55+FVRZv4kgb67zAtvvsx9sQ6A=;
        b=AslT8FmwuYTbK45zXhTg/8NBwMJ2Yous+nuDAG2yzg44re26I1SdO5eR+zKETmor1e
         4vaMA9j11xiZPN7mGstV/7IbfEpyaArM4gIf7qXSAWT5I3zFwB0JwNbKGXpkTb4gBQXc
         +11j9tsMD4m7Nfzbe9+Ml+rW6eN752vPkzoFSgcBLRqZE4I/CAZ6FyO91dJ4aEEu71pd
         n/B3pfh5acKErJCZ4iidTx/RE/8slnGsly7zVgorMhE2+JhqAoJXollCYQLGXVfyiH/r
         UcEJwlot9oTMuH3HesXVG1UhmVOvrF90L2CunamzV71pliFSwYU+ho+yahDONcKVKIV4
         /tyw==
X-Gm-Message-State: APuU4Z+DUmIHzWYRa1TN6nNiMmWrw0Akp6XCslZJ5DUYHrxUwvkTTRzg
	Ag1OQdHKTbje7Xequ6H1l4eBWAP6C0ml9g++CGtFsEAyyrd3ffS2W3U+3/SyGC/2LM8=
X-Gm-Gg: AYBFou37z5TGlW06pkp2BdFArDdCUfHMbm+x7/Vi/B4AbQbzXXOsbm/LUXAV3n1fzPn
	Qq2PXuC8pieBl7Qv3I/CIYsxOZe+JPvguKBaAZyc7/S3Y0FdhQGhhiKlxAfvDUYx3DTjkT0Y2HQ
	Ar8/qQR3Wfb7Pv3buGuZTZRV6XoJrDliGBqomKAv2yWMcxKuOtHF8Lx4UpTf8MTHrUjkZf1yowB
	caWrleotLUP5EHMuqzSPrvF+SOF7BCKtVPJ+zIrbYYNnEQvCWDyk+V8MzIdYbuBjDQq6Q876Cno
	bW0ITNQNKVaF2HW4S5aMTovJ+aJm+50OL7ERKgQhY2D1JCDRS9mKQFW5mch1+eWZelUjCrHYZTr
	TRd9PDFBe0WSxtVdKgRJ2JuRfEQTW/KLVZ0PZtUimioSZA7ddDMl704PTA0sfp8kVbNaRdzAxBU
	q/h+qgKbYrPMWB2Qn++SK6uflT3w/93KCy2wawEXpA6l6grDrlWnvGohkFXQbD8EYNj4anGtILp
	663wY2gUUiVKUtCcukGmqLILRSeAuqJFu12dtW0rZZY7JyB+vOF5wzduMRP48EBcJr7Z6LxH/3r
	ez2n3jHwaaZ8bMW+NDwlTCqxiYS3JvU=
X-Received: by 2002:a05:6870:204b:b0:475:a112:1276 with SMTP id 586e51a60fabf-4a9076ca59bmr7314078fac.35.1793710125255;
        Tue, 03 Nov 2026 04:48:45 -0800 (PST)
Received: from [127.0.0.1] ([20.64.66.196])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a9219f28b9sm9827203fac.12.2026.11.03.04.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:48:44 -0800 (PST)
Message-Id: <ba34e82a0a6a99181637e2fe33be5506f2a1bdd0.1793710118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2271.v3.git.1793710118.gitgitgadget@gmail.com>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
	<pull.2271.v3.git.1793710118.gitgitgadget@gmail.com>
From: "Joy Gundu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 12:48:38 +0000
Subject: [PATCH v3 2/2] config: move pack size limit into repo config
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
Cc: "Patrick Steinhardt>" <ps@pks.im>,
    "Kristoffer Haugsbakk>" <kristofferhaugsbakk@fastmail.com>,
    "Christian Couder>" <christian.couder@gmail.com>,
    "Usman Akinyemi>" <usmanakinyemi202@gmail.com>,
    Joie Joie <soniqjjj@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Joy <soniqjjj@gmail.com>,
    Joy Gundu <soniqjjj@gmail.com>

From: Joy Gundu <soniqjjj@gmail.com>

The pack size limit is currently stored in a standalone global
variable, even though it is repository configuration.

Move the value into repo_config_values and update the configuration
parser and pack-writing code to read it from the repository's
configuration values.

This removes one piece of global configuration state and helps
make Git code easier to reuse as a library component.

Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
---
 builtin/pack-objects.c | 2 +-
 environment.c          | 4 +---
 environment.h          | 3 +--
 object-file.c          | 6 ++++--
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca3a891dfb..1bd6b2d566 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5370,7 +5370,7 @@ int cmd_pack_objects(int argc,
 	if (!HAVE_THREADS && delta_search_threads != 1)
 		warning(_("no threads support, ignoring --threads"));
 	if (!pack_to_stdout && !pack_size_limit)
-		pack_size_limit = pack_size_limit_cfg;
+		pack_size_limit = cfg->pack_size_limit;
 	if (pack_to_stdout && pack_size_limit)
 		die(_("--max-pack-size cannot be used to build a pack for transfer"));
 	if (pack_size_limit && pack_size_limit < 1024*1024) {
diff --git a/environment.c b/environment.c
index 5a2eb8b2e4..b004029025 100644
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
 
@@ -769,7 +768,6 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->trust_executable_bit = 1;
 	cfg->has_symlinks = platform_has_symlinks();
 
-
 	/* section "branch" config values */
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
 }
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
index c049bf13f7..7f55e6331f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -882,6 +882,8 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 								 struct odb_transaction_files,
 								 base);
 	struct transaction_packfile *state = &transaction->packfile;
+	struct repo_config_values *cfg =
+		repo_config_values(the_repository);
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
@@ -903,8 +905,8 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
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
-- 
gitgitgadget
