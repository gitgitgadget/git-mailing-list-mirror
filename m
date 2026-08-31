Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20EE37DEBE
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206527; cv=none; b=auPFpl/4+8ReYx2SCRHsV7htMt/5VuJU2sdFTjICIaD6D2R8ypeBSR7oIP8k40r243mLWq1FGd6LFqEhnP0AlCZsiMrXgfruZCfSi8mQwDP5z4DK1uLbMedCqV/l1BtGFq5P+wWHplFfvf4prUqZyJ7kVBihAXvvciTDdVEXvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206527; c=relaxed/simple;
	bh=ZE6En3Fst/bIDUvkH6uIqY1H2l3w7nnPDaVmy4MTXLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeYsTwg5kFgvp2WX065hFFAsRBF90FPRg4OdrGHjcOIFO8xZmpHXW20LfVqBZ1qEZvWfc9kLVaVPEuBbp25Wdsi3b+PNxdJuQl/sa+A2V0t+mgp67jhzpB3x3GTQSsUBXA0bPaJD4n/OQn76tTPJqOeJSEJ67Ll+Zh1BVXUrDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a77cwd/j; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a77cwd/j"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-857ff9fef54so1513357b3.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788206525; x=1788811325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4S2POTmH6xWaI35O09hV8AW6IzYD21o1nLw1AbudeyQ=;
        b=a77cwd/j1xo8ISfYDxukHYwwvvoQm4lifNwucnuivp41sMCk91dtgvQkemTYnJlo+q
         7pS4fWRZpHcUR2bNZK7ykb4hE50papyGr8EfmXi1K8tiZxu4IWZmy6hTgL0iPClKDKh5
         98CGeEDq9G9HWDOzbEqYilYTTqMCkms9pzppg9yhCuJt6lyYVqlCNrfAbr8aPG7/BCBJ
         Lz+Qdm0NJOa9+tLuvxjijMBdwbBlwU3PhKM4Z460spQO+wsdJkkAbq5Irf6uJP2iUMKM
         mrBgYy5RClXcIvC3QlIUYkxJv0SYrI3hvYni4Wc7kFZ+KtNCKIty+x7nR/MRDp41tG4D
         IWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206525; x=1788811325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4S2POTmH6xWaI35O09hV8AW6IzYD21o1nLw1AbudeyQ=;
        b=E+tdH41jH/pRD/FjfBKwZZhl+8ZNyQFjoA2oWxQEp1sev+9fqppmoyNf/El73sBPx0
         fWPnUP3KG/wpcgXToryvcwc2x0MHQnc5lSCY2YcUGaiV3Nr0edPqySq4sgj+z4kPDM9V
         6gEqdeyi9LvMSS0KaBVXYsVNJhwnwqsnZWRAJO5IqdVXVA9I85DhKhXe/Vc+JTZytDFV
         1MS9a36fPdsdEZL0FfpGHc2LHwKh9Nuy0Kc7JIpE+k0PwxJYI2th8sdIL7vM2BVzGG/P
         nRliuXCCQOZT4UT8GB9ZlA7gjiImWCjQ+uCnYfxZdpkeaNfLP6mlyl0ErXgKK8n30NtL
         vM0g==
X-Gm-Message-State: AFuF++kMgmGHxPvgeO+z0QI4Ng8Ub4KLGcKmu/NgaTdxwUD5sxHeNQ1Y
	7XRhs25kcSk4eFKEYCww2eTnukndRyz2YQRN63TmuoBLM7wYooS1QZ5MDV1fuG+9M8o=
X-Gm-Gg: AYBFou1yqt3CT8XUrhB8FJjW4BKXRq3WLo7TU+8Ijfu6aDBWbOShP5Gbyfe2d/AjChh
	xgsAWg9pDdwq9s8teKyXeQcHVNwnte1UbJ6xqTqr6oMdeGawkTWXQ9aa9MsMiLwODym/oy1FOCR
	WDWFSbvJB+E6gvb3GMl0gOjVHc+uk4wOzYbsl5KVD65zRUrceO0/8ONLcVPsOD2BzoZXxZ5YGxc
	YBtWm9ZUTbEbq5ro2xab2PuObUWd8PRsRrEJ/gMpz9LVTrSNeEe/V+ENtiPPkl646GEiRf9jwYY
	mCTqvLnSnsIzYk35fmc9RjdssEdo2cCg9RuJFpToxiXh3OydGQe/b3VmqTX+NJGTIKdAGyNRHG0
	V5dxXF/cAqwzVQF6bA9p5nzAqYK3AGucmD7v91HZ3uMtqYoS+FAuNxAYicbwb9G0YSpwBIcdcgs
	Jj12Qiwg+O9s1dWhUgS4whwpfcVGb2EwBDDK5dTadxsv413IFrHipyEWUeZ9mAcAep9gCa0SbjJ
	esNPZtWkQbmGYhh3R0lCZUxW3uHQOj6UNGMcg1Z+4Ht9I5PviY+A6qmZcCPjxVubz+1q5bFpw2U
	eUkWErnfhaUY
X-Received: by 2002:a05:690c:d1d:b0:844:9f61:92d9 with SMTP id 00721157ae682-85d6cfc3aedmr105983597b3.17.1788206522897;
        Mon, 31 Aug 2026 13:02:02 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed1e4fcsm60286997b3.18.2026.08.31.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 13:02:02 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Tian Yuchen <cat@malon.dev>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v6 2/3] environment: align repo_config_values_init with struct declaration
Date: Mon, 31 Aug 2026 16:01:36 -0400
Message-ID: <12974e07d088c1621248296d08b6583c568ba4cf.1788206466.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1788206466.git.ben.knoble@gmail.com>
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1788206466.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order of assignments in repo_config_values_init is chaotic and hard
to follow, especially with the definition of 'struct repo_config_values'
to ensure all members are initialized. As new members will be added in
the future, make it easier to validate changes by aligning the two.

Refactor assignment order with no behavioral changes.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 environment.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/environment.c b/environment.c
index 76ee65e62b..6676e6f5ae 100644
--- a/environment.c
+++ b/environment.c
@@ -745,6 +745,7 @@ int git_default_config(const char *var, const char *value,
 
 void repo_config_values_init(struct repo_config_values *cfg)
 {
+	/* section "core" config values */
 	cfg->attributes_file = NULL;
 	cfg->excludes_file = NULL;
 	cfg->editor_program = NULL;
@@ -756,20 +757,24 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->autorebase = AUTOREBASE_NEVER;
 	cfg->object_creation_mode = OBJECT_CREATION_MODE;
 	cfg->apply_sparse_checkout = 0;
-	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
-	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
-	cfg->ignore_case = 0;
-	cfg->trust_executable_bit = 1;
-	cfg->has_symlinks = platform_has_symlinks();
-	cfg->branch_track = BRANCH_TRACK_REMOTE;
 	cfg->trust_ctime = 1;
 	cfg->check_stat = 1;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 	cfg->core_sparse_checkout_cone = 0;
-	cfg->sparse_expect_files_outside_of_patterns = 0;
 	cfg->warn_on_object_refname_ambiguity = 1;
+	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
+	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
+	cfg->ignore_case = 0;
+	cfg->trust_executable_bit = 1;
+	cfg->has_symlinks = platform_has_symlinks();
+
+	/* section "sparse" config values */
+	cfg->sparse_expect_files_outside_of_patterns = 0;
+
+	/* section "branch" config values */
+	cfg->branch_track = BRANCH_TRACK_REMOTE;
 }
 
 void repo_config_values_clear(struct repo_config_values *cfg)
-- 
2.55.0.860.g4b6b3295ed.dirty

