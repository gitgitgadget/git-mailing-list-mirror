Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794814568;
	b=KXHNAnmIFjHdDq+CZa57QhdtNUAJRFq5ohU6iLdsYscgk9BM79sol0pqRES1ZQIivIGo
	 3aFwjKbWbdlavMD+UgDr6ov80gXHrRrBoYVC9XongGpQ5ab12jeE35xPOju3K/N75Yk28
	 985CehJWSHpmbUBX2C5gRU8vQdNkn10js6v21WdfvgBvoagpKM7CnLQsho/r0ptjF6TAI
	 uM5XO8es8/MF+05rZ/2LzZbCug3cs/KMrBOsgIMI8D9g6+d59Ty+K+MgXPuQtBhQnMFLo
	 lUINkPjg1MLBJyteC6emj4s3WoFXL4GqRkhU3AXqcJsMYj7zguuO+tOEafyTGoBLbtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814568;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=1URoFHuel1H/nebicqChvnWsljQcq6sxc3onbKKC8rc=;
	b=K5oiNrzdhJoh2/VQAbdyI4eOAKfmGeydic2BRPdZOkc1UXRtaHRYJQys5ZAjfZ3rFyq3
	 +jPooL7rPwU+B8nLx0UKPSfeMEb6xTSeHqwIIKz3G/Qkmw5JZaqrrS+UHH71c5AHw0a6e
	 xHPWNzciuNdFpKqZ4Ty6RdiqDAU72k8P7K5MMjs4BOZP05vsAuIwZY2tTiYp26Ihg8TDJ
	 UD3aukEGu/CuYU9cPw0rk0k+gGwIJY8O0gnbCBXNnyChKEhbb3ZLCnFnYmfaaXRPKCUoN
	 JaX2KKaa/7YLS/e/Itmx3y+jqPFjnVS9tPsV6qURlXVNqkj52x4wYxB24O/Y6+EkJIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="hvACbs/r";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.109
Received: from sender5-pp-e109.zoho.com (sender5-pp-e109.zoho.com [165.173.182.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2B606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 07:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hvACbs/r
ARC-Seal: i=1; a=rsa-sha256; t=1794814558; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SbrLH+oME1yNHaJmxiLcgv/QZXrOVZYSPBAzQTLMH0FRTEAodrYhFW7q0WaG73XU77GfOqXZnL8IojiSYjmvjtIbKXxTpzBIP7/7rt3ccMipD6A8TPcXMpEYljGSzqK0YNUZje/XzVPDLBmXbrjckaDMB4SrZ34f4Fmp/bXjPC0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794814558; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1URoFHuel1H/nebicqChvnWsljQcq6sxc3onbKKC8rc=; 
	b=iBUMDH49o/vSTPWh73Xe7pJaxabow0XQL3m+eIJvhziCMoOKaH4ir2+h+uTYFVnVM5qfWh16Y2OMbI4QoUf1uohH9+e3HtRLHFM4QuIq8RJ7bV8uEPgDTBjSNSmLzhsYln/mHy3thOgOuoSLvdiN8G0IF65NuxzSqNLAM0Npl3A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=hvACbs/rDqm4tC3zJ+r/H/yjTAgZLEFjpa4Gd5UYoSdj9zC0o2sph4nSnj4D9zBs3EtuK5IPr+tFSEHBG7b3PpRx76JNpqpAXct17UVl22DnQyZr7q2J05qC0qBTF9nkcJ06kLLbg89tOnRivS9SarRGC/dTIFzmfSc9R9+2GEI=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=1URoFHuel1H/nebicqChvnWsljQcq6sxc3onbKKC8rc=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794814555515605.6388017525003;
	Sun, 15 Nov 2026 23:35:55 -0800 (PST)
Date: Mon, 16 Nov 2026 08:35:50 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: ps@pks.im, jltobler@gmail.com, szeder.dev@gmail.com,
	git@vger.kernel.org
Subject: [PATCH v2] log: make --follow following renames for non-linear
 history optional
Message-ID: <avqyVuMvKeQshZYS@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ava1ax5UFfcvkU_d@pks.im>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.637.76
X-ZohoMailClient: External

Since commit 304812ed33 (log: improve --follow following renames for
non-linear history, 2026-06-22), 'git log --stat --follow --
include/linux/rsc_table.h' on linux.git takes 6m43s, while it took about
28 seconds before.

What happens is that log_tree_commit() diffs each merge against all of
its parents with rename following, to find the path to follow in each
parent. diff_tree_oid() only does the expensive rename detection when
the path is added relative to a parent, but that is common for merges,
e.g. when a branch forked before the path was created merges mainline.

Fix the problem by making this per-parent diffing opt-in: plain --follow
behaves as before 304812ed33 again, and 'git log --follow=merges'
follows the path separately in each parent of a merge. Add a matching
log.follow=merges configuration option as well.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---

Hi Patrick,

On Fri, Nov 13, 2026 at 08:00:07AM +0100, Patrick Steinhardt <ps@pks.im> wrote:
> > +	i.e. it cannot be used to follow multiple files and does not work well
> > +	on non-linear history.  If `merges`, `git log` will act as if the
> > +	`--follow=merges` option was used.
> >  
> >  `log.graphColors`::
> >  	A list of colors, separated by commas, that can be used to draw
> 
> I'd think we should also document here that "merges" is expensive, same
> as you do for "--follow[=merges]".

Done.

> > +		if (value && !strcmp(value, "merges"))
> > +			cfg->default_follow = 2;
> > +		else
> > +			cfg->default_follow = git_config_bool(var, value);
> >  		return 0;
> >  	}
> >  	if (skip_prefix(var, "color.decorate.", &slot_name))
> 
> I think we should use `git_parse_maybe_bool()` here, as we otherwise die
> with "fatal: bad boolean config value 'bogus' for 'log.follow'" in case
> it's not a boolean. Then we can die with our own error message.

Done, I also added a test for this.

> > +	/* If --follow is not used, use the log.follow option. */
> >  	if (rev->diffopt.flags.default_follow_renames &&
> > -	    diff_check_follow_pathspec(&rev->prune_data, 0))
> > +	    !rev->diffopt.flags.follow_renames &&
> > +	    diff_check_follow_pathspec(&rev->prune_data, 0)) {
> >  		rev->diffopt.flags.follow_renames = 1;
> > +		rev->diffopt.flags.follow_merges =
> > +			rev->diffopt.flags.default_follow_merges;
> > +	}
> >  
> >  	if (rev->first_parent_only)
> >  		diff_merges_default_to_first_parent(rev);
> 
> I assume that this change here is done so that "--follow" overrides
> "log.follow=merge". Makes sense.

Yes. :-) The comment is meant to communicate that intent.

> > +	if (opt->diffopt.flags.follow_renames &&
> > +	    opt->diffopt.flags.follow_merges) {
...
> As far as I've seen we only ever set `follow_merges` when
> `follow_renames = 1`, so it feels redundant to check for both. But on
> the other hand that's a bit more defensive, so maybe that's not a bad
> idea.

My thinking was that follow_merges is a modifier of follow_renames. If
some code path clears follow_renames later (like builtin/blame.c does)
without knowing about follow_merges, checking both flags means that we
still skip the per-parent rename diffs. So I would keep it as-is.

Thanks,

Miklos

 Documentation/config/log.adoc |  5 ++++-
 Documentation/git-log.adoc    |  7 +++++--
 builtin/log.c                 | 19 ++++++++++++++++--
 diff.c                        | 15 ++++++++++----
 diff.h                        |  2 ++
 log-tree.c                    |  6 ++++--
 t/t4219-log-follow-merge.sh   | 37 ++++++++++++++++++++++++++++-------
 7 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index f7dfce69b5..95867fa593 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -53,7 +53,10 @@ This is the same as the `--decorate` option of the `git log`.
 `log.follow`::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files.
+	i.e. it cannot be used to follow multiple files and does not work well
+	on non-linear history.  If `merges`, `git log` will act as if the
+	`--follow=merges` option was used, which follows the path separately
+	for each parent of a merge, but is more expensive.
 
 `log.graphColors`::
 	A list of colors, separated by commas, that can be used to draw
diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index fb3ac11283..742b832bbf 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -27,9 +27,12 @@ each commit introduces are shown.
 OPTIONS
 -------
 
-`--follow`::
+`--follow[=merges]`::
 	Continue listing the history of a file beyond renames
-	(works only for a single file).
+	(works only for a single file). This does not work well on
+	non-linear history, unless `merges` is given: then the path is
+	followed separately for each parent of a merge, which is more
+	expensive.
 
 `--no-decorate`::
 `--decorate[=(short|full|auto|no)]`::
diff --git a/builtin/log.c b/builtin/log.c
index 350b35c556..c0e7d7d14b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -108,6 +108,7 @@ static int parse_decoration_style(const char *value)
 struct log_config {
 	int default_abbrev_commit;
 	int default_show_root;
+	/* 0: no, 1: yes, 2: merges */
 	int default_follow;
 	int default_show_signature;
 	int default_encode_email_headers;
@@ -205,6 +206,8 @@ static void cmd_log_init_defaults(struct rev_info *rev,
 		get_commit_format(cfg->fmt_pretty, rev);
 	if (cfg->default_follow)
 		rev->diffopt.flags.default_follow_renames = 1;
+	if (cfg->default_follow == 2)
+		rev->diffopt.flags.default_follow_merges = 1;
 	rev->verbose_header = 1;
 	init_diffstat_widths(&rev->diffopt);
 	rev->diffopt.flags.recursive = 1;
@@ -505,7 +508,14 @@ static int git_log_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "log.follow")) {
-		cfg->default_follow = git_config_bool(var, value);
+		int b = git_parse_maybe_bool(value);
+		if (b >= 0)
+			cfg->default_follow = b;
+		else if (!strcmp(value, "merges"))
+			cfg->default_follow = 2;
+		else
+			return error(_("invalid value for '%s': '%s'"),
+				     var, value);
 		return 0;
 	}
 	if (skip_prefix(var, "color.decorate.", &slot_name))
@@ -814,9 +824,14 @@ int cmd_log_reflog(int argc,
 
 static void log_setup_revisions_tweak(struct rev_info *rev)
 {
+	/* If --follow is not used, use the log.follow option. */
 	if (rev->diffopt.flags.default_follow_renames &&
-	    diff_check_follow_pathspec(&rev->prune_data, 0))
+	    !rev->diffopt.flags.follow_renames &&
+	    diff_check_follow_pathspec(&rev->prune_data, 0)) {
 		rev->diffopt.flags.follow_renames = 1;
+		rev->diffopt.flags.follow_merges =
+			rev->diffopt.flags.default_follow_merges;
+	}
 
 	if (rev->first_parent_only)
 		diff_merges_default_to_first_parent(rev);
diff --git a/diff.c b/diff.c
index 414532d09f..b633cbea09 100644
--- a/diff.c
+++ b/diff.c
@@ -5739,12 +5739,19 @@ static int diff_opt_follow(const struct option *opt,
 {
 	struct diff_options *options = opt->value;
 
-	BUG_ON_OPT_ARG(arg);
 	if (unset) {
 		options->flags.follow_renames = 0;
+		options->flags.follow_merges = 0;
 		options->flags.default_follow_renames = 0;
-	} else {
+		options->flags.default_follow_merges = 0;
+	} else if (!arg) {
 		options->flags.follow_renames = 1;
+		options->flags.follow_merges = 0;
+	} else if (!strcmp(arg, "merges")) {
+		options->flags.follow_renames = 1;
+		options->flags.follow_merges = 1;
+	} else {
+		return error(_("invalid argument to --follow: '%s'"), arg);
 	}
 	return 0;
 }
@@ -6161,9 +6168,9 @@ struct option *add_diff_options(const struct option *opts,
 			      0, PARSE_OPT_NONEG),
 		OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
 			 N_("use empty blobs as rename source")),
-		OPT_CALLBACK_F(0, "follow", options, NULL,
+		OPT_CALLBACK_F(0, "follow", options, N_("merges"),
 			       N_("continue listing the history of a file beyond renames"),
-			       PARSE_OPT_NOARG, diff_opt_follow),
+			       PARSE_OPT_OPTARG, diff_opt_follow),
 		OPT_INTEGER('l', NULL, &options->rename_limit,
 			    N_("limit to cheap rename/copy detection if the number of rename/copy targets exceeds this value")),
 
diff --git a/diff.h b/diff.h
index bb5cddaf34..2548739e83 100644
--- a/diff.h
+++ b/diff.h
@@ -154,6 +154,7 @@ struct diff_flags {
 	unsigned find_copies_harder;
 
 	unsigned follow_renames;
+	unsigned follow_merges;
 	unsigned rename_empty;
 
 	/* Internal; used for optimization to see if there is any change. */
@@ -202,6 +203,7 @@ struct diff_flags {
 	unsigned dirstat_by_line;
 	unsigned funccontext;
 	unsigned default_follow_renames;
+	unsigned default_follow_merges;
 	unsigned stat_with_summary;
 	unsigned suppress_diff_headers;
 	unsigned dual_color_diffed_diffs;
diff --git a/log-tree.c b/log-tree.c
index 83a3c4bf9b..93cc61af2d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1277,7 +1277,8 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	opt->diffopt.no_free = 1;
 
 	/* Any recorded path for this commit? If so, restore it */
-	if (opt->diffopt.flags.follow_renames) {
+	if (opt->diffopt.flags.follow_renames &&
+	    opt->diffopt.flags.follow_merges) {
 		const char *stored = recall_follow_pathspec(opt, commit);
 		if (stored) {
 			const char *current = pathspec_single_path(&opt->diffopt.pathspec);
@@ -1300,7 +1301,8 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		show_diff_of_diff(opt);
 
 	/* Record what path each parent of this commit should use */
-	if (opt->diffopt.flags.follow_renames) {
+	if (opt->diffopt.flags.follow_renames &&
+	    opt->diffopt.flags.follow_merges) {
 		struct commit_list *parents = get_saved_parents(opt, commit);
 		if (parents && parents->next) {
 			struct commit_list *p;
diff --git a/t/t4219-log-follow-merge.sh b/t/t4219-log-follow-merge.sh
index e370f82955..3f8a0009dd 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test --follow follows renames across merges'
+test_description='Test --follow=merges follows renames across merges'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -25,12 +25,35 @@ test_expect_success 'setup subtree-merged repository' '
 	git -C outer commit -m "Merge inner repo into inner/ subdirectory"
 '
 
-test_expect_success '--follow finds the pre-merge commit through a subtree merge' '
-	git -C outer log --follow --pretty=tformat:%s inner/inner.txt >actual &&
+test_expect_success '--follow=merges finds the pre-merge commit through a subtree merge' '
+	git -C outer log --follow=merges --pretty=tformat:%s inner/inner.txt >actual &&
 	echo "inner init" >expect &&
 	test_cmp expect actual
 '
 
+test_expect_success 'log.follow=merges acts as --follow=merges' '
+	git -C outer -c log.follow=merges log --pretty=tformat:%s \
+		inner/inner.txt >actual &&
+	echo "inner init" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--follow overrides log.follow=merges' '
+	git -C outer -c log.follow=merges log --follow \
+		--pretty=tformat:%s inner/inner.txt >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'log.follow rejects an unknown value' '
+	test_must_fail git -C outer -c log.follow=foo log inner/inner.txt 2>err &&
+	test_grep "invalid value for ${SQ}log.follow${SQ}: ${SQ}foo${SQ}" err
+'
+
+test_expect_success '--follow rejects an unknown argument' '
+	test_must_fail git -C outer log --follow=foo inner/inner.txt 2>err &&
+	test_grep "invalid argument to --follow: ${SQ}foo${SQ}" err
+'
+
 test_expect_success 'setup merge of two branches that both renamed a file to README' '
 	git init foo &&
 	mkdir foo/foo &&
@@ -65,8 +88,8 @@ test_expect_success 'setup merge of two branches that both renamed a file to REA
 	git -C foo commit -m "merge bar into foo"
 '
 
-test_expect_success '--follow follows renames across both sides of a merge' '
-	git -C foo log --follow --pretty=tformat:%s README >actual &&
+test_expect_success '--follow=merges follows renames across both sides of a merge' '
+	git -C foo log --follow=merges --pretty=tformat:%s README >actual &&
 	sort actual >actual.sorted &&
 	cat >expect <<-\EOF &&
 	add bar README
@@ -112,8 +135,8 @@ test_expect_success 'setup diamond with renames on both sides of a fork' '
 	git -C diamond commit -am "Z: modify path"
 '
 
-test_expect_success '--follow follows renames through a fork in a single history' '
-	git -C diamond log --follow --pretty=tformat:%s path >actual &&
+test_expect_success '--follow=merges follows renames through a fork in a single history' '
+	git -C diamond log --follow=merges --pretty=tformat:%s path >actual &&
 	sort actual >actual.sorted &&
 	cat >expect <<-\EOF &&
 	A: add path0

Range-diff against v1:
1:  cdf63f7017 ! 1:  cd19ed03cc log: make --follow following renames for non-linear history optional
    @@ Documentation/config/log.adoc: This is the same as the `--decorate` option of th
     -	i.e. it cannot be used to follow multiple files.
     +	i.e. it cannot be used to follow multiple files and does not work well
     +	on non-linear history.  If `merges`, `git log` will act as if the
    -+	`--follow=merges` option was used.
    ++	`--follow=merges` option was used, which follows the path separately
    ++	for each parent of a merge, but is more expensive.
      
      `log.graphColors`::
      	A list of colors, separated by commas, that can be used to draw
    @@ builtin/log.c: static int git_log_config(const char *var, const char *value,
      	}
      	if (!strcmp(var, "log.follow")) {
     -		cfg->default_follow = git_config_bool(var, value);
    -+		if (value && !strcmp(value, "merges"))
    ++		int b = git_parse_maybe_bool(value);
    ++		if (b >= 0)
    ++			cfg->default_follow = b;
    ++		else if (!strcmp(value, "merges"))
     +			cfg->default_follow = 2;
     +		else
    -+			cfg->default_follow = git_config_bool(var, value);
    ++			return error(_("invalid value for '%s': '%s'"),
    ++				     var, value);
      		return 0;
      	}
      	if (skip_prefix(var, "color.decorate.", &slot_name))
    @@ t/t4219-log-follow-merge.sh: test_expect_success 'setup subtree-merged repositor
     +	test_must_be_empty actual
     +'
     +
    ++test_expect_success 'log.follow rejects an unknown value' '
    ++	test_must_fail git -C outer -c log.follow=foo log inner/inner.txt 2>err &&
    ++	test_grep "invalid value for ${SQ}log.follow${SQ}: ${SQ}foo${SQ}" err
    ++'
    ++
     +test_expect_success '--follow rejects an unknown argument' '
     +	test_must_fail git -C outer log --follow=foo inner/inner.txt 2>err &&
     +	test_grep "invalid argument to --follow: ${SQ}foo${SQ}" err
-- 
2.51.0

