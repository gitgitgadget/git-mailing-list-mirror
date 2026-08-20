Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43338F255
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249445; cv=none; b=rmksWSkAL+TWZtgpEkUJaiHp5DMXh0stEoXThVZuMRhVaQ3oRvy3rap4AzBBpQaDqbTaoeHwYKoGMKa595eYU6lgEBBGS8kaFnD984wvm5nWZAMhCtRjwVo576NSHC/qbpBs8A/+NqUdrP22xPuqdn4Ktu4EqJcNeBKzLIvkyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249445; c=relaxed/simple;
	bh=esUKddLDnRuL+19tQbyT9ApolJMOwW9JzH+HujwWrMA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VWhbw63uidzwl43ZefJMxEB4e9fKYSFwiiMSS/62xjXnVzLBp78DfUwIqnsFy/acesXxKZflHhfHCwaIrHdUOgGvMbMXYcjZiFXd+2+y7bf9jCGxfF0HNRXOHmjwj/OroIPbeqHPfNp6vJbM5szEEHZEsnTRErRq45lLyx3L4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMqT19jC; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMqT19jC"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6ae9b721927so198444eaf.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787249442; x=1787854242; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b91JNwKgJ7B/tzSvgBY0hO5MxPl4gJf8QNtJTIoAg3I=;
        b=QMqT19jC8s5mM4So9ZMFOnoR4wgOJZkL53M7NAunSRxkTMv/pV0I5jDM9iXnnesoJe
         oFP7HSUW4IowzBmsWcJWvr6nIUKsJgUeIDnB2GtlRJQXRp2M04OHWj2+OJgstu23ZO73
         MyjqdN84lyTau8/+MRlHZGxDZT0U/nV5zd8NP2Rs5INDVPZX/yyTgKZp6JRjB4rshWBC
         F5fbvuTKGA1DsO7blhieI6/oPkwLAVebZvQa9sWPRLqCghp2WVgZXRUaqEnDI6zkxaaP
         c5x8tcaDN96KeT1nXjqrQ5t3SnVFlpzcqXHMewUGx3x09hoFEOB6UQ1kvlYtHIlw4reM
         Gdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787249442; x=1787854242;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b91JNwKgJ7B/tzSvgBY0hO5MxPl4gJf8QNtJTIoAg3I=;
        b=YXkyaK5yPwtLVEKZ/UiB5DWa6AlvHx0iaKlH4HHWfn/T4eSPW9VIhBXwUpaBcLFrCM
         4YZP0PiwxZiNW/Zz/Jt8JU+WS5miw0LL5oUUuxam8rLU0/CYRGWv/uEOA2qy1s2dtM7a
         xZttwxGCb6ZrAqSnlOvF7LbftlRrWC0E74a67Hxf1p4nEYsSfCVt6fcPPCKEprg0GcQy
         7ysSWCWNasWyOShqQGaGC+DtTsxNa/F/zyXECum/vCEqgwPXWF3LzNzdi+HsqabUAqDK
         Td+VZxPjldcMnIPSjggsLPfUHhOTljaNfl6Wes13t+taoATivJM9R88rJ+tM4wr4CrvX
         ar8A==
X-Gm-Message-State: AOJu0YzAiD6Ib1aP37s/EuDRzaYhkkq3e98bzby6xfDnOacSHA0f588s
	ua+Huk5lbj4KvBxdP2XhXsbAUuUerLr4nZ8ccqNttJl+rX4G6jA70VaLYMIKPwgx
X-Gm-Gg: AR+sD102+Bria0nTLMWL3HJWDSx5ICbl1ZTHRXW5QCcfJHNfaWomPigBu1VwroIhyMx
	WBPYOqmBatvv4RFkO55h33Rm9j/eViv+ZaHV8vp3M6dhrkk0J84srxuLs0eU/M+X/Bggjt3eEYe
	mrXYfwQukx4X4nyhpb79nmVVBgudy/l9oYrg80hTmR4zo0HGLF6/cd82BsVtDXgSqCZRoZy8Wps
	jrNiIFTkEYL3lfoZmd/SF+VA7MAm3ZvBSVRtXd2KwjD+cWgNJ9/VL0XIKfe6cXYUHdP6sBF0SMr
	TcLfXh2zQxG7F2lct+5c2BxoDSPm2S9Vr0b0b0pT3eHY4GluvNgU4LRRbSPL/Cs6CJLtxD4BcbH
	fKkUveYappHFUlt4GKVloHp8xEKIBs7ypwUlENjjzyVh1FMpZi94DNhmfTaGBQE9xf4QbCfns46
	NCDXCiOp2g7ZjBNN4hYiKtr92B3lFkkEoPa9u84NFwI7bFY2fMnYRRQ9fph0qfIuMQ
X-Received: by 2002:a05:6820:5711:10b0:69d:e676:6f66 with SMTP id 006d021491bc7-6b15936ff40mr488192eaf.21.1787249442170;
        Thu, 20 Aug 2026 11:10:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.230.251.200])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cf07704sm6387686eaf.14.2026.08.20.11.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:10:41 -0700 (PDT)
Message-Id: <4992d14ce48f436197101c0627ffe7d436597781.1787249432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 18:10:29 +0000
Subject: [PATCH v14 5/8] history: validate squash revision ranges
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Walk the selected commits in topological order from oldest to newest and
mark each one as it is seen. Every parent after the oldest commit must
already be selected or also be a parent of the oldest commit. This
accepts merges contained by the range while rejecting a merge arm that
entered it from elsewhere.

Track the remaining graph tips during the same walk and require exactly
one. Also reject empty and single-commit ranges and any selection that
reaches a root commit. These checks identify the oldest commit whose
parents will be preserved and the single tip whose tree will be used by
the rewrite.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/history.c         | 119 ++++++++++++++++++++++++++++++++++----
 object.h                  |   1 +
 t/meson.build             |   1 +
 t/t3455-history-squash.sh |  65 +++++++++++++++++++++
 4 files changed, 174 insertions(+), 12 deletions(-)
 create mode 100755 t/t3455-history-squash.sh

diff --git a/builtin/history.c b/builtin/history.c
index 4f5a7a46ce..6541a397e8 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1006,6 +1006,9 @@ out:
 	return ret;
 }
 
+#define SQUASH_SEEN (1u << 11)
+#define SQUASH_TIP (1u << 12)
+
 static int setup_squash_revisions(struct repository *repo,
 				  int argc, const char **argv,
 				  struct rev_info *revs)
@@ -1052,6 +1055,104 @@ static int setup_squash_revisions(struct repository *repo,
 	return error(_("not a '<base>..<tip>' revision range"));
 }
 
+/*
+ * Resolve a revision range into its oldest commit and single tip. Every
+ * parent after the oldest commit must either be selected or also be a parent
+ * of the oldest commit.
+ */
+static int resolve_squash_range(struct repository *repo,
+				int argc, const char **argv,
+				struct commit **oldest_out,
+				struct commit **tip_out)
+{
+	struct rev_info revs;
+	struct commit *commit, *oldest = NULL, *tip = NULL;
+	int ret, tip_count = 0;
+	bool walk_started = false;
+
+	ret = setup_squash_revisions(repo, argc, argv, &revs);
+	if (ret < 0)
+		goto out;
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+	walk_started = true;
+	while ((commit = get_revision(&revs))) {
+		struct commit_list *p;
+
+		if (!commit->parents) {
+			ret = error(_("cannot squash down to root commit"));
+			goto out;
+		}
+		for (p = commit->parents; oldest && p; p = p->next) {
+			struct commit_list *q;
+			struct object *o;
+			bool seen;
+
+			if (repo_parse_commit(repo, p->item)) {
+				ret = error(_("cannot parse commit"));
+				goto out;
+			}
+			o = &p->item->object;
+			seen = o->flags & SQUASH_SEEN;
+			/*
+			 * Allow parents that match the parents of the
+			 * squashed commit.
+			 */
+			for (q = oldest->parents; !seen && q; q = q->next)
+				if (p->item == q->item)
+					seen = true;
+			if (!seen) {
+				ret = error(_("parent %s of commit %s is "
+					      "outside the revision range"),
+					    repo_find_unique_abbrev(repo, &o->oid,
+								    DEFAULT_ABBREV),
+					    repo_find_unique_abbrev(repo,
+								    &commit->object.oid,
+								    DEFAULT_ABBREV));
+				goto out;
+			}
+			if (o->flags & SQUASH_TIP) {
+				tip_count--;
+				o->flags &= ~SQUASH_TIP;
+			}
+		}
+		if (!oldest)
+			oldest = commit;
+		tip = commit;
+		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
+		tip_count++;
+	}
+
+	if (!tip_count) {
+		ret = error(_("the revision range is empty"));
+		goto out;
+	} else if (tip_count != 1) {
+		ret = error(_("the revision range contains more than one tip "
+			      "commit"));
+		goto out;
+	} else if (oldest == tip) {
+		ret = error(_("the revision range holds a single commit; "
+			      "nothing to squash"));
+		goto out;
+	} else if (!oldest->parents) {
+		BUG("an in-range commit must have a parent");
+	}
+
+	*oldest_out = oldest;
+	*tip_out = tip;
+	ret = 0;
+
+out:
+	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP);
+	if (walk_started)
+		reset_revision_walk();
+	release_revisions(&revs);
+	return ret;
+}
+
 static int cmd_history_squash(int argc,
 			      const char **argv,
 			      const char *prefix,
@@ -1074,26 +1175,20 @@ static int cmd_history_squash(int argc,
 			 N_("edit the commit message")),
 		OPT_END(),
 	};
-	struct rev_info revs = { 0 };
+	struct commit *oldest, *tip;
 	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
-	if (argc < 2) {
-		ret = error(_("command expects a revision range"));
-		goto out;
-	}
+	if (argc < 2)
+		return error(_("command expects a revision range"));
 	repo_config(repo, git_default_config, NULL);
 
-	ret = setup_squash_revisions(repo, argc, argv, &revs);
+	ret = resolve_squash_range(repo, argc, argv, &oldest, &tip);
 	if (ret < 0)
-		goto out;
-
-	ret = error(_("squashing commits is not implemented yet"));
+		return ret;
 
-out:
-	release_revisions(&revs);
-	return ret;
+	return error(_("squashing commits is not implemented yet"));
 }
 
 static int update_worktree(struct repository *repo,
diff --git a/object.h b/object.h
index 8fb03ff90a..dcf30156ca 100644
--- a/object.h
+++ b/object.h
@@ -74,6 +74,7 @@ void object_array_init(struct object_array *array);
  * bisect.c:                                        16
  * bundle.c:                                        16
  * http-push.c:                          11-----14
+ * builtin/history.c:                    1112
  * commit-graph.c:                                15
  * commit-reach.c:                                  16-------20
  * builtin/last-modified.c:                         1617
diff --git a/t/meson.build b/t/meson.build
index 2133c840da..a349bb73b5 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -407,6 +407,7 @@ integration_tests = [
   't3452-history-split.sh',
   't3453-history-fixup.sh',
   't3454-history-drop.sh',
+  't3455-history-squash.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
new file mode 100755
index 0000000000..df92aa4f6c
--- /dev/null
+++ b/t/t3455-history-squash.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+test_description='tests for git-history squash subcommand'
+
+. ./test-lib.sh
+
+test_expect_success 'setup linear history' '
+	test_commit base file a start &&
+	test_commit one file b &&
+	test_commit two file c &&
+	test_commit three file d
+'
+
+test_expect_success 'errors on missing range argument' '
+	test_must_fail git history squash 2>err &&
+	test_grep "expects a revision range" err
+'
+
+test_expect_success 'errors on an empty range' '
+	test_must_fail git history squash HEAD..HEAD 2>err &&
+	test_grep "the revision range is empty" err
+'
+
+test_expect_success 'errors on a single revision that is not a range' '
+	test_must_fail git history squash HEAD 2>err &&
+	test_grep "not a .*range" err &&
+	test_must_fail git history squash HEAD~1 2>err &&
+	test_grep "not a .*range" err
+'
+
+test_expect_success 'errors on a range holding a single commit' '
+	test_must_fail git history squash "HEAD^!" 2>err &&
+	test_grep "single commit; nothing to squash" err
+'
+
+test_expect_success 'rejects a root commit' '
+	oid=$(git commit-tree -m root three^{tree}) &&
+	test_must_fail git history squash \
+		--ancestry-path=start "$oid..three" 2>err &&
+	test_grep "cannot squash down to root commit" err
+'
+
+test_expect_success 'rejects multiple tips' '
+	oid=$(git commit-tree -m tip -p start^0 three^{tree}) &&
+	test_must_fail git history squash ^start "$oid" three~1 2>err &&
+	test_grep "revision range contains more than one tip" err
+'
+
+test_expect_success 'rejects a merge parent outside the range' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b outside-parent &&
+	test_commit --no-tag outside-parent outside x &&
+	git checkout "$main" &&
+	test_commit --no-tag outside-main file b &&
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag outside-mid file c &&
+	git merge --no-ff -m "merge outside-parent" outside-parent &&
+	git branch -D outside-parent &&
+
+	test_must_fail git history squash "$base.." 2>err &&
+	test_grep "parent .* of commit .* is outside the revision range" err
+'
+
+test_done
-- 
gitgitgadget

