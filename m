Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029447B431
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401564; cv=none; b=CQjV/PZkP4nbjt4HkrQuNpbnkbpmATbyvvIcZ5tjmUVTmmoDDl9zIGf5OTTtY2I8H8rl9qJVbRc0y9qS9q9ZaB2JbpAo2Z53y2bPDC6/ECOpGmpt7lrXxzwG/FUgsOCCFLJKZn6IKgPp2VPKnBeOBwjpoOTfWTR6q2b/sWCEY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401564; c=relaxed/simple;
	bh=8kfNHTLf88QUizxh/ERs1eZR5wQo0Tdtk0yyamX9Dew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ftFhD7s+GKYwGSC8kx49glgIT4KNFbyRWkTWDsz57fRgzKyV4aaJ3BYxgev7JJjO2d2oug6UMzah9m5neL626vcmu0AdtnU7iXXg1eFOIyLD9gIJfwzvn2p8xIbR9y4ixL6Wd3wxCHVH7FuzIsGGL1SLv7yjomE4h36FFYYFG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyOuZyQM; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyOuZyQM"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12dcdcd54adso1842868c88.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777401561; x=1778006361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfI140ofMyE62mQjg6oLyFecqqsy2avPp3tJ+m9QJeI=;
        b=FyOuZyQMYhwQiXxMwyFdTL8SVk32HQ0vhbYt3JnhUtMQbZ3Fk10/UIS/gaeFkloc5K
         oPesXECtdA7bOJIt+zfucjDkNLrAJaK8FoBcRx0dzec6OaUtunCIQq3NxQcXOxKygsx8
         S0puCVleazsYNYaE8/SJ6/TMgOI4QNs6gSb4fvp2qtLxBkQejtppJCxCAYz8rLp1sKiZ
         5ywgGBDa8CWE+eXOpngSXJ06MVGTARLba8EJwzytYy8nTivgaN2ne18RyjJfNldxOIOq
         BevAYBwhD50K3zbYJ+tWBB1so/kvyCIMahAnZNDJf3XL6MmCd4xY3x7JoV7JbdZ25Rf0
         CdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777401561; x=1778006361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfI140ofMyE62mQjg6oLyFecqqsy2avPp3tJ+m9QJeI=;
        b=G4OSYrs4Dl2CHtb/r+KQRFGU3NxO/l+aej4+eV+YGVXye3rbRvS2P9+scui+OPMKpk
         lHWF2OuIBOr4ystrCx6TnFUsz0O3VIRVUa0di55iMFOf8pQiwCkvK+1vf+a9CTTUtbJj
         lIrqndxIfAghJjC9zOAGA2dQ+quJ6EPLsxoyoWujmO8tRz0jlaYIYLM9FQ+R0W7bFmlx
         0Lqo/K8qfdOoevaxMLdxLylmi9RIIMnT9XRFQ4i2DRxm8UsPOAvh5SKOVTEZCMHeLRoX
         SaD2L5QqCmvd0tUAvuKFXAVl+uwnv+o+bICfK50DxWC78GzyJwU6vC5SkVkBCbZwxSNF
         yrXA==
X-Gm-Message-State: AOJu0YxhO0C0zsoTxNY+PQdgb2OUnvinDn8/f3LQLdlXudrepKZY59xY
	E/COy8Jan6+gJgTEWU5Ho/BQ9P3qCnAG9EArm+HOwmoAMlMSwtIV5mp87WiEIKbY
X-Gm-Gg: AeBDieubbMXUU4hgr3xE1iqtVSuZN0YrmVBo9E8UiugKwPU++2E6LmriWhkLXmlmiOf
	ZXyY/yW1wPzvQidRVipHjP/cL4V/DnGt2dvmI/D5xJ3/Yos1BAqSwnlZGI1m7qbSQCcuYl/K5yy
	FCjVhrqbdEcCJifoBXfnyRZ+AoSfyYezMGmDdZl5MVccjQ+TJGj0dUCHTWYhOioX1K+ZVJ+Q303
	WM8+52D1ZQ3uboI2J+Nul1Q4JzeU9mHuEYF4YliB6xUdc2Fq6QnKrG1Q33Na2Txa3bVIGikny4x
	APCtfial3/N/2urjJ4SgPopzRO4MEo25moqr0+Jyb1mTRUjYoOUvYKPBt56DeaL0oTwnS1LNaWe
	JA+M5tYtoxK1sAq/nyjhDnIAafV4rInUP2qAaeuVi03uavdDTSjLVKwdU8MXJYC5SjSJkqYqy3q
	oT4G4xpyNW02hFrszmocI13TcsshLnszdTT6M2OPZtf1shjMM=
X-Received: by 2002:a05:7022:ec3:b0:128:ca6f:adf2 with SMTP id a92af1059eb24-12ddd9ae9d0mr2062973c88.32.1777401561444;
        Tue, 28 Apr 2026 11:39:21 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.83.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd927bc6sm2581155c88.1.2026.04.28.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 11:39:20 -0700 (PDT)
Message-Id: <f35842408527a8c69f9936cdb127fb35efe2509c.1777401552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
References: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
	<pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 18:39:11 +0000
Subject: [PATCH v16 4/5] checkout: rollback lock on early returns in
 merge_working_tree
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

merge_working_tree() acquires the index lock via
repo_hold_locked_index() but several early return paths exit
without calling rollback_lock_file(), leaving the lock held.
While this is currently harmless because the process exits soon
after, it becomes a problem if the function is ever called more
than once in the same process.

Add rollback_lock_file() calls to all early return paths.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/checkout.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..c80c62b37b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -783,8 +783,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	struct tree *new_tree;
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
-	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
+	if (repo_read_index_preload(the_repository, NULL, 0) < 0) {
+		rollback_lock_file(&lock_file);
 		return error(_("index file corrupt"));
+	}
 
 	resolve_undo_clear_index(the_repository->index);
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
@@ -797,14 +799,18 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	} else {
 		new_tree = repo_get_commit_tree(the_repository,
 						new_branch_info->commit);
-		if (!new_tree)
+		if (!new_tree) {
+			rollback_lock_file(&lock_file);
 			return error(_("unable to read tree (%s)"),
 				     oid_to_hex(&new_branch_info->commit->object.oid));
+		}
 	}
 	if (opts->discard_changes) {
 		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
-		if (ret)
+		if (ret) {
+			rollback_lock_file(&lock_file);
 			return ret;
+		}
 	} else {
 		struct tree_desc trees[2];
 		struct tree *tree;
@@ -814,6 +820,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
 
 		if (unmerged_index(the_repository->index)) {
+			rollback_lock_file(&lock_file);
 			error(_("you need to resolve your current index first"));
 			return 1;
 		}
@@ -857,15 +864,19 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			struct strbuf sb = STRBUF_INIT;
 			struct strbuf old_commit_shortname = STRBUF_INIT;
 
-			if (!opts->merge)
+			if (!opts->merge) {
+				rollback_lock_file(&lock_file);
 				return 1;
+			}
 
 			/*
 			 * Without old_branch_info->commit, the below is the same as
 			 * the two-tree unpack we already tried and failed.
 			 */
-			if (!old_branch_info->commit)
+			if (!old_branch_info->commit) {
+				rollback_lock_file(&lock_file);
 				return 1;
+			}
 			old_tree = repo_get_commit_tree(the_repository,
 							old_branch_info->commit);
 
@@ -897,8 +908,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			ret = reset_tree(new_tree,
 					 opts, 1,
 					 writeout_error, new_branch_info);
-			if (ret)
+			if (ret) {
+				rollback_lock_file(&lock_file);
 				return ret;
+			}
 			o.ancestor = old_branch_info->name;
 			if (!old_branch_info->name) {
 				strbuf_add_unique_abbrev(&old_commit_shortname,
@@ -920,8 +933,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					 writeout_error, new_branch_info);
 			strbuf_release(&o.obuf);
 			strbuf_release(&old_commit_shortname);
-			if (ret)
+			if (ret) {
+				rollback_lock_file(&lock_file);
 				return ret;
+			}
 		}
 	}
 
-- 
gitgitgadget

