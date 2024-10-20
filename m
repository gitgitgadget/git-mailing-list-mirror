Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA51194A43
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431832; cv=none; b=R6s+w+YuoF+OAr0Vr45r35tgMwgeXxY0Sq4t46kIFGZUPSk86quM2d9d1HMW8BZV3IMGZTlRoNyliDhxA6rFhkUBYs0097nTHVw9iOoKcnBBsEt4snxc+E50ONqQTURspz0SFnT2onB/q1xoQ7l/K5o301YbNPbjQjJGSwWj9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431832; c=relaxed/simple;
	bh=Nfiu+0AxVx/VRfkIFNR8CJIV9740KXSzsSnAG8rORQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FYOxgPTYGHbnMFjbkY0zsFqd7hNNpQPIGvhtqMLEjliICfZNdfkPOGF28sUPnA3qQO4tzrHh9S69Y0u4ZF/b1mu3CGeVQKz2UrdvT3i3G6J7cjDampfGS94+Cow+GoT2osrCyW8eeYz9j2jKGld6CbvICxt0PLSCAZhpsVwS7qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBZl/75a; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBZl/75a"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so342700766b.0
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431828; x=1730036628; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGpXM44rY5FvP9DhPLf2Gor5TEffnwhr5pnOtktibnU=;
        b=NBZl/75ahgzeXvB/ma860otVoobbGfVQgeYqQKe/iucGqY4uYTFZiZZ8aIciOahl8T
         DWyd5auyt0TUo2R8iyEtWUcn6FcWam7W65HuHB3alYrqaXFmQHDiBiDXpryuInxtxUQG
         QEWFgWuX3uEYrlypQtZmkf/OLb7gGHOqswWH1EGaBgpLilFOBJR19IYKvO7M2kkwG3Ww
         GnHOF3l5fVLnE9ismH8y0BK7Q2Wb6728Ry0lljk+8YI6FWP4u08OpjP+hQzoQqBLZf9x
         mPGeibpYNsjjv3384nwnramHvTkkgPcy570ddpytxhPRkq4GwBAehcqeRrpxh9c5Dozg
         miqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431828; x=1730036628;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGpXM44rY5FvP9DhPLf2Gor5TEffnwhr5pnOtktibnU=;
        b=FsDup8/Vb2c0xqq5nkFpzkrKruNDiog0DH8hVITR/8Gu/MFeHkNEwxQTLCqOpqMUcv
         7QUAdj4VnxIZePJfVtjP7sjrn/ZckYdPBJdIqfcEyCDVgd6R2676VP/JH1aG2zY9JK8V
         s5QigCNUeSt+pdw5aEXhmijOfdoNaqUSAml87Hr44r+c1GT1stcBK0DJnpMnGh5ac/uo
         71c3CVGA5N8EqvjX5XSKjBYRB1QdIpPWil46rstKfiagO9zDLtgu4HxIRQAfspRFN1Tc
         EF3TR0sxlglsU0zm9MlCqs8rSGo/RiF7M9eB0nhJn5xLCwcJuOWRQIXjw/jcDVgpu7h4
         vcAA==
X-Gm-Message-State: AOJu0Yzd0eDujR1/4y7hDSoHeGirfy/pmaYDo4QlL2fojWAKTCDX7+/B
	hVRBsnEVP1ebkAfGUEr5h1yK60oE0kzXvwXh94/yqh7G4se3yBdCU4E16A==
X-Google-Smtp-Source: AGHT+IFTSyqJq4zYAwCL6+li98rYLbZ0hlfX7JNOES+B/TWe296uVdG53wxVjTWHsuchyX6xPLOGZg==
X-Received: by 2002:a17:907:7211:b0:a99:f0cf:f571 with SMTP id a640c23a62f3a-a9a69ba6087mr801372966b.33.1729431827782;
        Sun, 20 Oct 2024 06:43:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfe1sm92206166b.53.2024.10.20.06.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:47 -0700 (PDT)
Message-Id: <1db90e361bae53bebc03bd93ed09e94d570950f9.1729431811.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:27 +0000
Subject: [PATCH v2 14/17] pack-objects: enable --path-walk via config
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
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
 Documentation/config/feature.txt | 4 ++++
 Documentation/config/pack.txt    | 8 ++++++++
 builtin/pack-objects.c           | 3 +++
 repo-settings.c                  | 3 +++
 repo-settings.h                  | 1 +
 5 files changed, 19 insertions(+)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index f061b64b748..cb49ff2604a 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
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
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index da527377faf..08d06271177 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
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
index b97bec5661e..6805a55c60d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4587,6 +4587,9 @@ int cmd_pack_objects(int argc,
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
index 4699b4b3650..d8123b9323d 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -45,11 +45,13 @@ void prepare_repo_settings(struct repository *r)
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
@@ -64,6 +66,7 @@ void prepare_repo_settings(struct repository *r)
 
 	/* Boolean config or default, does not cascade (simple)  */
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
+	repo_cfg_bool(r, "pack.usepathwalk", &r->settings.pack_use_path_walk, 0);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
 	repo_cfg_bool(r, "index.skiphash", &r->settings.index_skip_hash, r->settings.index_skip_hash);
diff --git a/repo-settings.h b/repo-settings.h
index 51d6156a117..ae5c74ba60d 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -53,6 +53,7 @@ struct repo_settings {
 	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
+	int pack_use_path_walk;
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
-- 
gitgitgadget

