Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159FC329371
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776297487; cv=none; b=iWWWlrz4g0r2CunpVM+9GBi54V4k95Vp82a3Onnhd9MaqY7MnPZsXSHM4ZtaUsX3LnZJGTQXPdDOgk/hWhAOedGkHDu3jhiKwWHFfSZZlAfKVPvi3Ir+ce73jhIeMk8WywBIMDqx56mpD8wWokSCOA4BzU1vzCWo6FLfJaTEdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776297487; c=relaxed/simple;
	bh=KfyzMCkcSZJ6iCbrevDkRSHR6Kd3WwGffm6LQjGa6hg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SvP1EjQPM36+t0T9f/XlxlvcaE6M5jwg/f5jN9VarSW+J0Ct8nkyBCHNSDEPl7igIEICplpiAD/zvjB0dHAD8DfGdnSyeibCH6+ctrZHgbucDmRv6R7ZcMz4UwRQzuiDF2lp/EsT51xrGgZ+Z5irBUBzRpJIiqShVKWQBSHS3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6m9qMdD; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6m9qMdD"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50babbce85fso76890541cf.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776297485; x=1776902285; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK+N8bmEb0gmgn/WSgXNY2vyT1IMsfIatBfY3g/Mhw4=;
        b=E6m9qMdDIpXYoD4yrv/8ZwW3+kq2KvOhr/qnRMBOycDkZYGUFgDgB42YN5NrH0vj7C
         iJn9GKd7tZTTfo+g53Td0+R3ZvYoy8gNkFqDfHtd3upYu3gkvQoLX39RKtAys3hp2yTa
         TANipTJPngJzb3GU/BframYcoI0KGNJrdwgi4C/gyqtrvM8TomUXDlzm0zsHWBGAilO1
         TwFj4nlpIZHW9PAAwE4rPjx5ZTUMJgss6JIKtN+8H4dVbt3zKhq8z2bXvKqgW1xcCzLW
         hJg/4bJotdfFCrUidm+BLoM/8S9nV92OHxLkklzRrIWplcevsEPMANom3lIJ+4zP30mU
         OHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776297485; x=1776902285;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XK+N8bmEb0gmgn/WSgXNY2vyT1IMsfIatBfY3g/Mhw4=;
        b=OpJOky2QAmvoqtrNCG5w6vX3aIvw1Hrlusac94zI7Dlu7lX659J7qt84X0lEP7VHmO
         uHTxWCog0exqW/C7bxHkHz9n5WRZOmT3OD7hF9NMCz+i/bMbOoz0J5PSuIWQEU71Fvi4
         n2CWpxNa8hSugfYUnpZptjONyb0NpGDEXfrjhaSzTD9QLnZdBC8ttV3hjlO4a7N+iIJ3
         gmjFj8xVqvuYK+iHgAAIyfyzmSNOodmIwjWs6xRxGaGV1TqgJ0ZmYfHnM8cmagmx9vkG
         ptwEGE7h3lSTG/5BZ6i+AwZ128MeCt4HSIRJIczJaR48BqA0niKQdTskp/woalEc08lS
         o9Ow==
X-Gm-Message-State: AOJu0Yy9Kzg7dVM9wLV6g3y2H8rGnCILKP6esS66+MKbVDlVjLMDr171
	iVQkSzhxhPRTcVnHDfNWpZWm8h9/58rKZ+U+U/cRRbWpXooPQOcaCgMaAT5nJA==
X-Gm-Gg: AeBDietBcfLbpaORs688l30TbIK4NoRvtQ9GB1Oa5nRDGM2FRjGoarP+iH2l/lCYVTj
	AruwPfxIxLQw3k/pRa13bkF6K0uxvORJnsjHqJo8d08bbJNNXM3HJTL8c14PJ8QKbmM8bnM/MuK
	F7fxPK1coBLiMFFK/XMxhJVqRtE36VhlnQarmoS4PFEtFeOXC/PKJfSe3G1c0CCpzK3VKEE8Qva
	/bBKt8i1eFVnB2hmkXuv6q1ALQm4+nUjIvI3X6EVeN0mNdLN+NuQKme65pEBZHusrZTUxWPfSec
	xM7T6VemhXr3tVwI+fyH4yDCaRRn6Xe2vDDnQSNugIsuqI+1AjhSOfilc5mljcgQrizAsNxxn2K
	myCtJv1gwbM5EQAOhZAYcTXO3KqvJzgL+n7YIz5eJkrPW47YJzb17kHjuhi7F+kTRco5bE2JOVC
	5UTAYNLwXuvp8TtBT7BSLzpI/aOsA=
X-Received: by 2002:a05:622a:5912:b0:50d:811e:3ee8 with SMTP id d75a77b69052e-50dd5c906efmr380274461cf.54.1776297484592;
        Wed, 15 Apr 2026 16:58:04 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cda9277sm22881126d6.41.2026.04.15.16.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:58:04 -0700 (PDT)
Message-Id: <6c76f1e862790858297ff9b1debc1a38756b1913.1776297482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
References: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 23:58:00 +0000
Subject: [PATCH 1/3] backfill: reject rev-list arguments that do not make
 sense
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Some rev-list options accepted by setup_revisions() are silently
ignored or actively counterproductive when used with 'git backfill',
because the path-walk API has its own tree-walking logic that bypasses
the mechanisms these options rely on:

  * -S/-G (pickaxe) and --diff-filter work by computing per-commit
    diffs in get_revision_1() and filtering commits whose diffs don't
    match.  Since backfill's goal is to download all blobs reachable
    from commits in the range, filtering out commits based on diff
    content would silently skip blobs -- the opposite of what users
    want.

  * --follow disables path pruning (revs->prune) and only makes
    sense for tracking a single file through renames in log output.
    It has no useful interaction with backfill.

  * -L (line-log) computes line-level diffs to track the evolution
    of a function or line range.  Like pickaxe, it filters commits
    based on diff content, which would cause blobs to be silently
    skipped.

  * --diff-merges controls how merge commit diffs are displayed.
    The path-walk API walks trees directly and never computes
    per-commit diffs, so this option would be silently ignored.

  * --filter (object filtering, e.g. --filter=blob:none) is used by
    the list-objects traversal but is completely ignored by the
    path-walk API, so it would silently do nothing.

Rather than letting users think these options are being honored,
reject them with a clear error message.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/backfill.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index d794dd842f..a9edddcb7e 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -78,6 +78,28 @@ static int fill_missing_blobs(const char *path UNUSED,
 	return 0;
 }
 
+static void reject_unsupported_rev_list_options(struct rev_info *revs)
+{
+	if (revs->diffopt.pickaxe)
+		die(_("'%s' cannot be used with 'git backfill'"),
+		    (revs->diffopt.pickaxe_opts & DIFF_PICKAXE_REGEX) ? "-G" : "-S");
+	if (revs->diffopt.filter || revs->diffopt.filter_not)
+		die(_("'%s' cannot be used with 'git backfill'"),
+		    "--diff-filter");
+	if (revs->diffopt.flags.follow_renames)
+		die(_("'%s' cannot be used with 'git backfill'"),
+		    "--follow");
+	if (revs->line_level_traverse)
+		die(_("'%s' cannot be used with 'git backfill'"),
+		    "-L");
+	if (revs->explicit_diff_merges)
+		die(_("'%s' cannot be used with 'git backfill'"),
+		    "--diff-merges");
+	if (revs->filter.choice)
+		die(_("'%s' cannot be used with 'git backfill'"),
+		    "--filter");
+}
+
 static int do_backfill(struct backfill_context *ctx)
 {
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
@@ -144,6 +166,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
+	reject_unsupported_rev_list_options(&ctx.revs);
 
 	repo_config(repo, git_default_config, NULL);
 
-- 
gitgitgadget

