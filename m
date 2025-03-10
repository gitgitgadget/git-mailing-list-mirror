Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56719AD89
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571466; cv=none; b=d93ucGRAEK3h6Ub5eCf10DLSkzSdae3b1a4HQGxm0KUnwWIqiBYSpuw2/Iy2nFTaUvNeCVLI446/FnwMqeLnGKNC3JcibyYjgUlh56G9wJmSBvjC/SXMxl+hO6UHZaeuE+iDR29cVZQP7MixqCC/CVO3UDtd6lh0Et3spsrBNCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571466; c=relaxed/simple;
	bh=VKzCS4+J4c+a2bADBzOl/ID0LzdFqJw8WrDmhoAZ2bI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bG6cNVLk4b4dlVMc5U7JIhsrrbdrMEYXG4pYzQRjPC5/w5rRb4wIHivPinG2jltLT8bFrnRg8cWbXP+M10G+bCWzxwreUCfQ+S61ifZr0zpIw6xoL7dTKE1cqNbQlAY4gkcWAzbAdT29aCa0bqtU9RgKIdNebC0G09M6RfXQkgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OePNud1U; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OePNud1U"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so3703022a12.3
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571463; x=1742176263; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuIjb/N2dp4mBjCWsq+GPDm/h9ofrW0nynyOfOo4Te8=;
        b=OePNud1UfKKI6l2fIwZaRr1tRnUQLINAg6JnXU6LKtrYFQh6hU5qiY61b7H089POCr
         UZCFwmXWEGhtTOEdSteZ0wzIEDVHU8YOONNcpqkYfGkL+iqkUmIl/nwtuy7wC96iIb+I
         osGT5KKdNtbH6lUaaEPQnmL38T7ndinbV+KVSWYqRZejdZ47o+9xsgAPe5L6wxifEQ9f
         p7mk3y7DqnbteBEvu5TDPXIoaGGm4cvo2RJvSLb1axRNYKp5uyWUQgW5nPlTPSOwiHSU
         7a7+Bb/Ac7zB/liCVA1cnq7W4jXjpmi6l1fZtO6wgJcDNfYp2xWIYRtutH0yOU/loq9Y
         +BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571463; x=1742176263;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuIjb/N2dp4mBjCWsq+GPDm/h9ofrW0nynyOfOo4Te8=;
        b=RKHSHY59fCq08Hjck1/3evzza828c/mUis1nJTDLV7ojVA+M8rfW57BHYztsjralwD
         5y/rwZfea0QwUMT8T/HcltqTdoOs3vdlun/r5VOqaPi+XqJH+NIuk1FRrmJVEVuP+Bp9
         nf87a5k1QuBWvC4vjsfMh5mOANPq+yOn1QZ5QhUycigHdzUIvRKwjjxIgZR8zYX8YWkq
         n0a66gxoScoFmsA4KIekFWyL8rZmyQive02fB3tNtkHh5ZXUrf9mktEif+zwfuv/U6RV
         nvLQtNLWpzQdCGo87wy+XN8BUDibHhrHe2wMfJrm1eT4dd0cwDSTPUAtdVANuqV3iNRt
         3OpQ==
X-Gm-Message-State: AOJu0YzxUW59JUR6iQ6uGHUME9BgGtbl90A1C+gtPOOBn0d0b2GxtSRm
	sDvt1Xnb5FbSMUfF805V8xzUNZGc7whxX+zPxjOqQDD58GL85gH/B1PzYA==
X-Gm-Gg: ASbGncs7oMFUnW/tEZvgwRgzLJY78AfMM3PdcuTN2vn4reSPup+PAqN8zUv/xx/0kYG
	4lwyvdMtCrVx44qyGciF7AWbG9XvpBqSv24oFc6EPV4X9vKqg63mPf956WWWD84M0TEsSZ5d4SY
	Jb4eeo++4ghXs3h4Sgix8Vz1FYyg6BPhacddU4HDpOfmT5Q0piJv/USQLelxoc79pEETYvxHew0
	iPg6m1a2zi9M6mIt6SbckaTdcRK9cUhJhz5wfxzH4FpTjvhqiGUdFzoGpb5YEvz/y2F8lvAErfy
	G4So2NFxmjCdF47ri2TEnOejKKRRH3l2kWvC8lv9pyrNsA==
X-Google-Smtp-Source: AGHT+IEBiXijqXFtgq9SDYzQl+dYhLqn4I3GNjKI69qcTNTxsbKSR8oE8EXQK9FMkCXZxAvpakZegg==
X-Received: by 2002:a17:907:97d5:b0:ac2:32a:ee17 with SMTP id a640c23a62f3a-ac25273813cmr1462213566b.3.1741571463088;
        Sun, 09 Mar 2025 18:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2909da3a2sm189573466b.97.2025.03.09.18.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:51:02 -0700 (PDT)
Message-Id: <073cb44a47c904b26df613bf6312027076cc7d68.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:50 +0000
Subject: [PATCH 08/13] pack-objects: enable --path-walk via config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Users may want to enable the --path-walk option for 'git pack-objects' by
default, especially underneath commands like 'git push' or 'git repack'.

This should be limited to client repositories, since the --path-walk option
disables bitmap walks, so would be bad to include in Git servers when
serving fetches and clones. There is potential that it may be helpful to
consider when repacking the repository, to take advantage of improved deltas
across historical versions of the same files.

Much like how "pack.useSparse" was introduced and included in
"feature.experimental" before being enabled by default, use the repository
settings infrastructure to make the new "pack.usePathWalk" config enabled by
"feature.experimental" and "feature.manyFiles".

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/feature.adoc | 4 ++++
 Documentation/config/pack.adoc    | 8 ++++++++
 builtin/pack-objects.c            | 3 +++
 repo-settings.c                   | 3 +++
 repo-settings.h                   | 1 +
 5 files changed, 19 insertions(+)

diff --git a/Documentation/config/feature.adoc b/Documentation/config/feature.adoc
index f061b64b748..cb49ff2604a 100644
--- a/Documentation/config/feature.adoc
+++ b/Documentation/config/feature.adoc
@@ -20,6 +20,10 @@ walking fewer objects.
 +
 * `pack.allowPackReuse=multi` may improve the time it takes to create a pack by
 reusing objects from multiple packs instead of just one.
++
+* `pack.usePathWalk` may speed up packfile creation and make the packfiles be
+significantly smaller in the presence of certain filename collisions with Git's
+default name-hash.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
index da527377faf..08d06271177 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
@@ -155,6 +155,14 @@ pack.useSparse::
 	commits contain certain types of direct renames. Default is
 	`true`.
 
+pack.usePathWalk::
+	When true, git will default to using the '--path-walk' option in
+	'git pack-objects' when the '--revs' option is present. This
+	algorithm groups objects by path to maximize the ability to
+	compute delta chains across historical versions of the same
+	object. This may disable other options, such as using bitmaps to
+	enumerate objects.
+
 pack.preferBitmapTips::
 	When selecting which commits will receive bitmaps, prefer a
 	commit at the tip of any reference that is a suffix of any value
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 120202b05e9..c756ce50dd7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4649,6 +4649,9 @@ int cmd_pack_objects(int argc,
 		if (use_bitmap_index > 0 ||
 		    !use_internal_rev_list)
 			path_walk = 0;
+		else if (the_repository->gitdir &&
+			 the_repository->settings.pack_use_path_walk)
+			path_walk = 1;
 		else
 			path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
 	}
diff --git a/repo-settings.c b/repo-settings.c
index 67e9cfd2e63..9b5595c708e 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -47,11 +47,13 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
 		r->settings.pack_use_bitmap_boundary_traversal = 1;
 		r->settings.pack_use_multi_pack_reuse = 1;
+		r->settings.pack_use_path_walk = 1;
 	}
 	if (manyfiles) {
 		r->settings.index_version = 4;
 		r->settings.index_skip_hash = 1;
 		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
+		r->settings.pack_use_path_walk = 1;
 	}
 
 	/* Commit graph config or default, does not cascade (simple) */
@@ -66,6 +68,7 @@ void prepare_repo_settings(struct repository *r)
 
 	/* Boolean config or default, does not cascade (simple)  */
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
+	repo_cfg_bool(r, "pack.usepathwalk", &r->settings.pack_use_path_walk, 0);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
 	repo_cfg_bool(r, "index.skiphash", &r->settings.index_skip_hash, r->settings.index_skip_hash);
diff --git a/repo-settings.h b/repo-settings.h
index ddc11967e01..a31decad221 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -56,6 +56,7 @@ struct repo_settings {
 	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
+	int pack_use_path_walk;
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
-- 
gitgitgadget

