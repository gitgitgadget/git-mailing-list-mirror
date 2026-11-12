Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794474325;
	b=SruXna6NueAXozfXtcJiB9n8wdDxuhweZMOJs0v45tBw/UHbyBSEai0RXtqtIeYxT7bx
	 Z4dQuGO2K7rTZzk8g9f1wtXoup4jIdhpTNvuQ9XmIq821RNcPCYFcUJOiaHmIA4+AItod
	 f5N5iijpbVGn4ZJWBQkgtYr7lKqQ24aYoe6T+2rSK5uWgw2ZSEXA+7XgOqBVMci2z4KhE
	 d1G7pnt4IAZAfRJPGhPq2doybGC/TPALnWsO+oc5NF7HmCBewptSrh6cuB6wY+05iRRgZ
	 OM+orQxbfurgmMQ6k3fOjBk/w+CxR7U4vnVyI4+hM4Bk3FDHZUafdDZeq/0D5bY/5fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474325;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=xH/HLPxfM2i4LMomSJS6nOc89mP/sy8PcRbiJZz4YII=;
	b=DTyMMerI5rcXW9BWMLfWLCfPKxlYcxXQH49Xb8zIPns9M110Plq4aX33hzqSsdRbFWkx
	 F+lKcH1uG/+OB7qiJlxyRBQuI3dWCluS+1nHApLpwLVxTkF4Y+o3sef4EwjsfFMLjxHRK
	 opPB8PJaVBageviOoN6qJIKCr+cBFmBWDZJDbpmHnsvocrcNzCJsWw94rb09QPXVExgaD
	 2nSRnPQ5myTLST1z0nXb4k3aawps0Dbyy2uPWg7cxwMja5JmNrztJhTOCBjBP7VeZJM5g
	 CY4cRNh5DJQzu8yFoCIPd7ST/7CkpmkVcmqbkKi2D1e+kSa+/pH/uYtSjOHHWJBBKdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=aY5NniLF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B01D606A89A
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B01D606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=aY5NniLF
ARC-Seal: i=1; a=rsa-sha256; t=1794474317; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fUgCuyoyCjkSbkxiGLmzzY2GpE9dlbOhf862ue06qQuHWOxmZY4dcvrX0dof8dBXmbNouVZMSnXvPPHmi57OrdrWYvQQ1BHq8sWS4f+8uTj0Pq/Jf5XrMHD7a5wMk4G/mw28tqjwCqfzHVNzI+dPbXNVvIdgzgKhpkwFSQInZv4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794474317; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xH/HLPxfM2i4LMomSJS6nOc89mP/sy8PcRbiJZz4YII=; 
	b=MWQca1otrM5GXocecLOAJwJKmsItfvCTRMxdI4tBNqlXhOUabcl4pPGwjy78kUUpQvryxnPJZPTBYwqJ77cwZLZ4+Fhuy6fKGD+nLhEOUE1Vqsc4U/m75FshiMYL30eJPBI391yNGZdly0LYjm6DioYMk8tBSITdiMfoYNN1HPo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=aY5NniLF5uUu3bypFOeZRMYOUn1j5haI3gYX0qYyb8uvp0LUlRa2H2xB5JBx/qdjsd76i3EoJCfVpBgW1pdVlYvZbJpumMn8RpOUDRLHcJMDIbznQ/q9l4hXPYIIApzPQkBB7agkWQGGxOrjoZhVtSmZlUdJJsqviV/5bQbCJQs=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=xH/HLPxfM2i4LMomSJS6nOc89mP/sy8PcRbiJZz4YII=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794474316222636.5706619678624;
	Thu, 12 Nov 2026 01:05:16 -0800 (PST)
Date: Thu, 12 Nov 2026 09:05:07 +0000
From: Miklos Vajna <vmiklos@collabora.com>
To: gitster@pobox.com
Cc: ps@pks.im, jltobler@gmail.com, szeder.dev@gmail.com,
	git@vger.kernel.org
Subject: [PATCH] log: make --follow following renames for non-linear history
 optional
Message-ID: <avWBQ_10mHUNQcFi@collabora.com>
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
In-Reply-To: <avRtsm5VQpC_g9yN@pks.im>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.450.56
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

Hi Junio,

On Wed, Nov 11, 2026 at 08:44:42AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> This sounds sensible, and is far better than reverting and declaring
> "The original 'checkbox hack' should stay here forever because doing
> it right will be very expensive".

If that is fine with you, I suggest just replacing the
mv/log-follow-speedup branch with this patch.

Hi Patrick,

On Wed, Nov 11, 2026 at 02:29:22PM +0100, Patrick Steinhardt <ps@pks.im> wrote:
> I don't really have a good sense of how far this patch series is on its
> road to getting merged. So how about we first land a single-patch series
> that introduces the knob that we can merge without the remaining parts
> in this series here?

I like the idea, here is a patch to do that.

> With regards to how to opt-in, I can see two ways:
> 
>   - We could extend "--follow" to take an optional parameter so that the
>     user can pass "--follow=merges". Same with "log.follow", we could
>     teach it another option "merges".
> 
>   - We could introduce "--follow-merges" and "log.followMerges".
> 
> I'm leaning towards the first option myself.

Yes, --follow=merges also appears more natural to me, so I implemented
it that way.

Thanks,

Miklos

 Documentation/config/log.adoc |  4 +++-
 Documentation/git-log.adoc    |  7 +++++--
 builtin/log.c                 | 15 +++++++++++++--
 diff.c                        | 15 +++++++++++----
 diff.h                        |  2 ++
 log-tree.c                    |  6 ++++--
 t/t4219-log-follow-merge.sh   | 32 +++++++++++++++++++++++++-------
 7 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index f7dfce69b5..72a3486a73 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -53,7 +53,9 @@ This is the same as the `--decorate` option of the `git log`.
 `log.follow`::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files.
+	i.e. it cannot be used to follow multiple files and does not work well
+	on non-linear history.  If `merges`, `git log` will act as if the
+	`--follow=merges` option was used.
 
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
index 350b35c556..db707877f6 100644
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
@@ -505,7 +508,10 @@ static int git_log_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "log.follow")) {
-		cfg->default_follow = git_config_bool(var, value);
+		if (value && !strcmp(value, "merges"))
+			cfg->default_follow = 2;
+		else
+			cfg->default_follow = git_config_bool(var, value);
 		return 0;
 	}
 	if (skip_prefix(var, "color.decorate.", &slot_name))
@@ -814,9 +820,14 @@ int cmd_log_reflog(int argc,
 
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
index e370f82955..c2bc2b0c13 100755
--- a/t/t4219-log-follow-merge.sh
+++ b/t/t4219-log-follow-merge.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test --follow follows renames across merges'
+test_description='Test --follow=merges follows renames across merges'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -25,12 +25,30 @@ test_expect_success 'setup subtree-merged repository' '
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
+test_expect_success '--follow rejects an unknown argument' '
+	test_must_fail git -C outer log --follow=foo inner/inner.txt 2>err &&
+	test_grep "invalid argument to --follow: ${SQ}foo${SQ}" err
+'
+
 test_expect_success 'setup merge of two branches that both renamed a file to README' '
 	git init foo &&
 	mkdir foo/foo &&
@@ -65,8 +83,8 @@ test_expect_success 'setup merge of two branches that both renamed a file to REA
 	git -C foo commit -m "merge bar into foo"
 '
 
-test_expect_success '--follow follows renames across both sides of a merge' '
-	git -C foo log --follow --pretty=tformat:%s README >actual &&
+test_expect_success '--follow=merges follows renames across both sides of a merge' '
+	git -C foo log --follow=merges --pretty=tformat:%s README >actual &&
 	sort actual >actual.sorted &&
 	cat >expect <<-\EOF &&
 	add bar README
@@ -112,8 +130,8 @@ test_expect_success 'setup diamond with renames on both sides of a fork' '
 	git -C diamond commit -am "Z: modify path"
 '
 
-test_expect_success '--follow follows renames through a fork in a single history' '
-	git -C diamond log --follow --pretty=tformat:%s path >actual &&
+test_expect_success '--follow=merges follows renames through a fork in a single history' '
+	git -C diamond log --follow=merges --pretty=tformat:%s path >actual &&
 	sort actual >actual.sorted &&
 	cat >expect <<-\EOF &&
 	A: add path0
-- 
2.51.0

