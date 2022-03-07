Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2F6C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiCGVwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbiCGVvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA49975C29
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u10so23833323wra.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fNheW1b+asSmnco6QI/G36xhoYryAVIU6gGEtM847Co=;
        b=UmXEA5oCzS3wYLzb36VXwKc4ajm5K29cAiCk+z+1gEaydW1kZccfYnTHuNos/BmJwv
         Zvf1edhxUGVX/t0yS1EfMNMfOJgmWjSX/UgEz47/qcHqbqT5LUEw6/qMIled8zsQ7A36
         dD74SdyygDAv74WvwXMeuFot/3hQU1sgLfIsuHNVCdNrmNblbFrAuUQbZ8mhI5fklLD/
         PwLxtZTer47fRE11TFPLtH9HnM4QSg2LZAFZVZgDonuVGzrV1m+qZg8ri9UrSV7rXMRl
         aE5ONFhB1MjIEBLO8+0W8rllb7cGFbjszBTwPYDOCJvwXZk4BhkJFrAuRpgXUkANuO7+
         0I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fNheW1b+asSmnco6QI/G36xhoYryAVIU6gGEtM847Co=;
        b=Fjc8zDjQ+QQWbzCvrHZtIAwjVxu3nJMaN1ZX8BDRnY4RPl8AJrWSUIT0m0PkN1L+AJ
         jqpybtszU7TwzJf9gLCiBX/wWINBPHC4jxrjkpxE3xUomc+iTJA4gvUSfeDLtuwe7zsQ
         1RhB+VAk3w6s9/r9IJ7PoP46+fhF57FjWU5c6NJz3RT1KBB4K+vMilqVep2KBUJYTJxK
         0sRLtDVlcvEhF+rNnHkmHmINSxarnMzkK1ucSk+sc0+8IOIJ1RG0aNGJAws2Qx09SrdS
         r3E73uujcow62v60VnQINCPOqcqWhwwCrp49l4UhiRVxNqvBgndANrv6Zf1XCABxY3wE
         2NKw==
X-Gm-Message-State: AOAM530092Sa7iNZc5H3avJm+5l9dA1Ai199MV07miEsbsNv385T1M+E
        R/gdbuj+RfdQGxq2l//llWkFIADFY2s=
X-Google-Smtp-Source: ABdhPJz8MJc51e9nc4TLs1x47EDpsZJIvaJPfoYsC2kYRpdv2YPnvY+UIfnosFFZUIcNXZdvRrhg9A==
X-Received: by 2002:a5d:4533:0:b0:1ef:b46d:1367 with SMTP id j19-20020a5d4533000000b001efb46d1367mr9914603wra.508.1646689851216;
        Mon, 07 Mar 2022 13:50:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h36-20020a05600c49a400b00382aa0b1619sm417292wmp.45.2022.03.07.13.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:50 -0800 (PST)
Message-Id: <82d93fc62e24ebf4a46eb195e5b5a2ed46ad9e2d.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:38 +0000
Subject: [PATCH v2 10/12] bundle: create filtered bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A previous change allowed Git to parse bundles with the 'filter'
capability. Now, teach Git to create bundles with this option.

Some rearranging of code is required to get the option parsing in the
correct spot. There are now two reasons why we might need capabilities
(a new hash algorithm or an object filter) so that is pulled out into a
place where we can check both at the same time.

The --filter option is parsed as part of setup_revisions(), but it
expected the --objects flag, too. That flag is somewhat implied by 'git
bundle' because it creates a pack-file walking objects, but there is
also a walk that walks the revision range expecting only commits. Make
this parsing work by setting 'revs.tree_objects' and 'revs.blob_objects'
before the call to setup_revisions().

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-bundle.txt |  4 +--
 bundle.c                     | 55 ++++++++++++++++++++++++++++--------
 t/t6020-bundle-misc.sh       | 48 +++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 72ab8139052..831c4788a94 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -75,8 +75,8 @@ verify <file>::
 	cleanly to the current repository.  This includes checks on the
 	bundle format itself as well as checking that the prerequisite
 	commits exist and are fully linked in the current repository.
-	'git bundle' prints a list of missing commits, if any, and exits
-	with a non-zero status.
+	'git bundle' prints the bundle's object filter and its list of
+	missing commits, if any, and exits with a non-zero status.
 
 list-heads <file>::
 	Lists the references defined in the bundle.  If followed by a
diff --git a/bundle.c b/bundle.c
index 2afced4d991..0016d70310c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -334,6 +334,9 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 		     "--stdout", "--thin", "--delta-base-offset",
 		     NULL);
 	strvec_pushv(&pack_objects.args, pack_options->v);
+	if (revs->filter)
+		strvec_pushf(&pack_objects.args, "--filter=%s",
+			     list_objects_filter_spec(revs->filter));
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
 	pack_objects.git_cmd = 1;
@@ -507,10 +510,37 @@ int create_bundle(struct repository *r, const char *path,
 	int bundle_to_stdout;
 	int ref_count = 0;
 	struct rev_info revs, revs_copy;
-	int min_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
+	int min_version = 2;
 	struct bundle_prerequisites_info bpi;
 	int i;
 
+	/* init revs to list objects for pack-objects later */
+	save_commit_buffer = 0;
+	repo_init_revisions(r, &revs, NULL);
+
+	/*
+	 * Pre-initialize the '--objects' flag so we can parse a
+	 * --filter option successfully.
+	 */
+	revs.tree_objects = revs.blob_objects = 1;
+
+	argc = setup_revisions(argc, argv, &revs, NULL);
+
+	/*
+	 * Reasons to require version 3:
+	 *
+	 * 1. @object-format is required because our hash algorithm is not
+	 *    SHA1.
+	 * 2. @filter is required because we parsed an object filter.
+	 */
+	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] || revs.filter)
+		min_version = 3;
+
+	if (argc > 1) {
+		error(_("unrecognized argument: %s"), argv[1]);
+		goto err;
+	}
+
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
 		bundle_fd = 1;
@@ -533,17 +563,14 @@ int create_bundle(struct repository *r, const char *path,
 		write_or_die(bundle_fd, capability, strlen(capability));
 		write_or_die(bundle_fd, the_hash_algo->name, strlen(the_hash_algo->name));
 		write_or_die(bundle_fd, "\n", 1);
-	}
-
-	/* init revs to list objects for pack-objects later */
-	save_commit_buffer = 0;
-	repo_init_revisions(r, &revs, NULL);
 
-	argc = setup_revisions(argc, argv, &revs, NULL);
-
-	if (argc > 1) {
-		error(_("unrecognized argument: %s"), argv[1]);
-		goto err;
+		if (revs.filter) {
+			const char *value = expand_list_objects_filter_spec(revs.filter);
+			capability = "@filter=";
+			write_or_die(bundle_fd, capability, strlen(capability));
+			write_or_die(bundle_fd, value, strlen(value));
+			write_or_die(bundle_fd, "\n", 1);
+		}
 	}
 
 	/* save revs.pending in revs_copy for later use */
@@ -566,6 +593,12 @@ int create_bundle(struct repository *r, const char *path,
 	bpi.fd = bundle_fd;
 	bpi.pending = &revs_copy.pending;
 
+	/*
+	 * Nullify the filter here, and any object walking. We only care
+	 * about commits and tags here. The revs_copy has the right
+	 * instances of these values.
+	 */
+	revs.filter = NULL;
 	revs.blob_objects = revs.tree_objects = 0;
 	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
 	object_array_remove_duplicates(&revs_copy.pending);
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 6522401617d..f10cf011519 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -487,4 +487,52 @@ test_expect_success 'unfiltered bundle with --objects' '
 	test_cmp expect actual
 '
 
+for filter in "blob:none" "tree:0" "tree:1" "blob:limit=100"
+do
+	test_expect_success "filtered bundle: $filter" '
+		test_when_finished rm -rf .git/objects/pack cloned unbundled &&
+		git bundle create partial.bdl \
+			--all \
+			--filter=$filter &&
+
+		git bundle verify partial.bdl >unfiltered &&
+		make_user_friendly_and_stable_output <unfiltered >actual &&
+
+		cat >expect <<-EOF &&
+		The bundle contains these 10 refs:
+		<COMMIT-P> refs/heads/main
+		<COMMIT-N> refs/heads/release
+		<COMMIT-D> refs/heads/topic/1
+		<COMMIT-H> refs/heads/topic/2
+		<COMMIT-D> refs/pull/1/head
+		<COMMIT-G> refs/pull/2/head
+		<TAG-1> refs/tags/v1
+		<TAG-2> refs/tags/v2
+		<TAG-3> refs/tags/v3
+		<COMMIT-P> HEAD
+		The bundle uses this filter: $filter
+		The bundle records a complete history.
+		EOF
+		test_cmp expect actual &&
+
+		test_config uploadpack.allowfilter 1 &&
+		test_config uploadpack.allowanysha1inwant 1 &&
+		git clone --no-local --filter=$filter --bare "file://$(pwd)" cloned &&
+
+		git init unbundled &&
+		git -C unbundled bundle unbundle ../partial.bdl >ref-list.txt &&
+
+		# Count the same number of reachable objects.
+		reflist=$(git for-each-ref --format="%(objectname)") &&
+		git rev-list --objects --filter=$filter --missing=allow-any \
+			$reflist >expect &&
+		for repo in cloned unbundled
+		do
+			git -C $repo rev-list --objects --missing=allow-any \
+				$reflist >actual &&
+			test_cmp expect actual || return 1
+		done
+	'
+done
+
 test_done
-- 
gitgitgadget

