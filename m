Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9469833D4EC
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065023; cv=none; b=uT2PU8DWk5oGttO2Dsr9VocrZQl4/629aDgeaS+qsWOv2MIMriBBCaoFlx0rpzF0mgzyRzAdv3U5sxIfBJ+WvSo5jrTuezPwUDy3j4kkw/jRLuBrkPWIKs1JCFDxhw64DwjwMn0V6xY18Hv9iv3zUpe3AEeyDXRp9oHvyZ7gyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065023; c=relaxed/simple;
	bh=8kfNHTLf88QUizxh/ERs1eZR5wQo0Tdtk0yyamX9Dew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qPR0lmwrPiAjZ5DG1Y5W1MffBnu13sOU2ekYomP2D29/8Vc7dZv5JLNbtfwUmTw2k5jRGSp/XfqBBi4ZKQuHLQpGZUYgyp+GVMs5zOvQHidZ7NR762dDMSe1ZYD6fw5UmR8uhuqOg7PBWArCpKXjRJySt17z+G+3aVXsnaoMaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/fI3jcP; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/fI3jcP"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso4549374eec.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 14:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065020; x=1777669820; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfI140ofMyE62mQjg6oLyFecqqsy2avPp3tJ+m9QJeI=;
        b=i/fI3jcP2wVvTCX+5KXb8KaSdq1H6Sj+M5a3VesXncxMvmcw42cRwqQON/4+MMxVG7
         ipAWa9RAJUPMOsnUutn35tIx8wx9NPEfJN01+bUvSB3okrqCGSpVrzaq8YmIs3k6y7lJ
         qjqQmkzo78KVvsvuOTnZ5l6SVvwsgEsR1JVh7PBBkYnlb9q6mNy9d4b3DpAMLpTWN13p
         wycPWZ7U7zVasgzl9Bx32LNL6QGK9Nob46z4ZQPQKip5hmLyHUrXSQmMNB1vXaW3IIXr
         5Y8aj29trnfJsIOFhS3jmB+jasvbde6aVG6IP3/0Qr33ffdmr06jJHCrgPDsGWmSWj67
         RsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065020; x=1777669820;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfI140ofMyE62mQjg6oLyFecqqsy2avPp3tJ+m9QJeI=;
        b=JYM2/jio5jFayc5WGOe2U6iid51KOKaCFjt6+PlglM7s8ADI848y0rTYF+dB6uaSNd
         /ajtS73aMgVLPYG9Igxm/2y24QOFy3yro4v1IszYZQsLwXnzxga+LAegH8k7SvOyslzl
         KrcmJnX5PNxjAvdjQeK46z9Wof9avUlqWSL0Pxwohd9NMriWJ2LrJHtxsUK6TQc2BwHj
         bP0xxSz2QGqWzkrqdk2FPagGC9gChSzBDm6Bk9NjjxgzOeudVoNJf7SH1Ar6/jQzrIYl
         COVW0+JIIwu99Lj+hLxSyj/vsPrjgqOqZ1CRx7QxGF5h+pxeUsjTbsJCF3395bWr0XsD
         FrJA==
X-Gm-Message-State: AOJu0YzECnUmH4bzWbaK6rUoQ318QqbYvj76S3CfkAhjsOrvopnl8VVS
	Db5hlgdU9rCyr8sP3FywnqdVcvbFpO0GJbuKKhvJ4bEpUS61cz/JKMGUV0o4Jg==
X-Gm-Gg: AeBDiesbJXVaDOt5kN3/INumgc/cGhVQezvRPp0QrY0iWotmz6LG0ZBpeEFSefdKukK
	yvp10OWWowQME0nMDgA1mClHA6JuRWVNkivTloFJA/31/TWN8xMs/6WYZV7IvQYz7uCtamiGRs4
	KUzHNjdOjm1HwlclpAXt+IjUgqir1V12XXUCwHT8XoGVmgmWB/BxuhdWGAMDr9ROlyzqITDZleZ
	ppsuT/+sfisH7cQKP8SMcoeQCeNe50vNb0V4SwU2mTjZO0r2rmxetyjKqleWcMlUfL5C8iAfys4
	zWgfJ1yh0BP6/ah/yWdCgNKx4smSaEpviX3U8cH81N/Y/SdDullAHH8lT2pJYtzMG4P33ZNnluM
	ILCp7aXlAnajYjqhlV/KBnpMjWmCCmhdbQqW+VEcSRALBGm9OwOOt3r1cHA/ETy+yMIKylI0NPd
	DlctAAEkjnV9D80btn0z8S4hfabhK4yVXk1qkGsrk=
X-Received: by 2002:a05:7300:8622:b0:2c1:7480:ff9b with SMTP id 5a478bee46e88-2e42e6e99b7mr14224439eec.18.1777065020217;
        Fri, 24 Apr 2026 14:10:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c86sm40715583eec.1.2026.04.24.14.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:10:19 -0700 (PDT)
Message-Id: <f35842408527a8c69f9936cdb127fb35efe2509c.1777065012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
	<pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 21:10:11 +0000
Subject: [PATCH v15 4/5] checkout: rollback lock on early returns in
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

