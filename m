Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5589634575A
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251527; cv=none; b=TtOauSjRvI1nqqrl3pP+xDOjS9VGpmEI0hs3zoFaF5SxChHPjmmjGKSnAttAeIliJOA7O2KfXF9Qro3jExrT5xphNMY1Ymx90fSEHsw/lG+yyYFS+hkbo3wmLb/0w7Wvif2KbaKMk9fpy1nRk5MLlfFJpciu5Zt8Hf1gkWXuTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251527; c=relaxed/simple;
	bh=8kfNHTLf88QUizxh/ERs1eZR5wQo0Tdtk0yyamX9Dew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AiuBteZg6pcmVPHLjp+s1QJmg1JO8BeCWlTqYcpxWJCwGvWfZEsX+t0ja8tPtDGE0tDpTZn/GTlyxb12/ZoVXlkYhA59JTfzu/aVIQ8NEuoeXusWmdHVJqh/8mdOFae61O1Tmfbpv9yHyWVLRbNb0Kq9/50z76sQwDAwwrJ6EPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIaEQGBx; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIaEQGBx"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb20bcff5aso619592185a.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776251524; x=1776856324; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfI140ofMyE62mQjg6oLyFecqqsy2avPp3tJ+m9QJeI=;
        b=YIaEQGBxkgA7A9DtMiT6YYnxHgMSZPOnh/Pz+rdgnPED969f8xAwhYsLze8hKqZw1l
         wi6OfsHQnCa3apkhJjf2CDWEZ1fpmtv7+0nRiUtcoqlcSQNZMwtN+ugc2uVsDr8pP2cj
         BuIGzqqYFqImInu+x5qzA+WYKM6dnbwiTZQEJKRFj7H9ZqzEgsP9MWBx3xxpYTDlJIXC
         iYU+q0jRj3XwZbXQkIwTZyY9GDqRJ/7mwcWTkopN/fcw8IVY0gMSroEqDyKQwt+ePHX6
         5GaPUSN6Znckt3nI6n6oWxCkIruBfYHH0HKb2WEb4pgfwZ7Peqql5pE1gcdm5eqKDHrK
         s7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251524; x=1776856324;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfI140ofMyE62mQjg6oLyFecqqsy2avPp3tJ+m9QJeI=;
        b=dOT1mqzyIPRRpub6WPhl3hYf/ygVlJtNOxS/HGw0A6FBDGe+QsQdva2N4eUQNKHXSC
         mx1+zrScx1XG9LZ08eEVvUHfia4xBCgPisYeOR9BHmXmZAaeZ2hYlbC2YUzo4TQzub9b
         x2NyafDJMtDo4xLVlTjELHp2F0zS/dkvZ9u2re4zogKEAZXtz/ryRb9gVoToovZoi+mj
         EAUphAlS/j2MLXe8VZRWo6za0nL02bqKUEbLHefziFDXI8l0ACk8NbkoLiLqXyoYq+4b
         P/cuRZb0O9OJLDvZ26kpyChXyE/GxsVJvKj5wPaqnG62lzniyc+dURr451xD8iOyREUU
         fj8A==
X-Gm-Message-State: AOJu0YwF7CH8jedSviufEwbSeAjIQUFZW1ji3NTMuEvNnC3T2UB1heGy
	5cyVYI6e/2Z7XJjGF7v4LO48fyDurI4oSEEdlWLJVpyq7NJ/6DonHLzVcYtlo6Gl
X-Gm-Gg: AeBDiev4IDiC5SjuXLUcty3Dr6+bvf5r73fWSOOOB1C6pnMQs4f7AfsJ4lKSbHPhhFu
	Dh10uP/nx7h41AkVu2SzB+ljmeoNuKAGCGzl3uOBRYIV2EJeClR9/IqxjtAeiKApIBwlCp7Hi2d
	hMITbYNObY714sqHruZXWf3bDex4IbfRizUDdksfWC7vTYRh2S3OShu0P7Jg9f3eIy2SMItnLVV
	GdyCRwtBw7oCEgYHz2vK2n/WjR6C99adMhfMvzArwl5zCftt5Do2//jIvOqICUUQW7uXTjpSolU
	iH3xGaxN4sfkn1n9Kiif3lTmVn8DKhIm8uXlP0+NTOUDmvPHe6cHv32D+PFOLMmhWU5lm/KKU0U
	Y49HVeRFYWhWWNnp4ddRFDykPqWDrkG8UpXpmhGyTW9/sGzPjsjPitnuu0Egdc7g9U/1SFn2mwn
	T7HvvXWDFExs4wR23RacmDVd/t2hIP
X-Received: by 2002:a05:620a:4506:b0:8cd:cd30:779e with SMTP id af79cd13be357-8ddcf1b80ebmr3094678485a.42.1776251523831;
        Wed, 15 Apr 2026 04:12:03 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.227.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f2dffa0asm91132885a.38.2026.04.15.04.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:12:03 -0700 (PDT)
Message-Id: <04869314ecd16c63c5067d23783a6054e8d63bf0.1776251517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
References: <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
	<pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 11:11:56 +0000
Subject: [PATCH v13 4/5] checkout: rollback lock on early returns in
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

