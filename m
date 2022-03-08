Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEFDC433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347583AbiCHOkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347571AbiCHOka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:30 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FEF39147
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q14so13326987wrc.4
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DQYyduXCH8AzCMoe7NeiL6VRz0Am9b0h6i4kCTzpbs0=;
        b=kscVmkQfG2to4aLLMkV5ryh34ifG2IC6MBXI8XY5RLCt9K92vyTBQtqmVstSZUsLCp
         XlTE7WGjZTpxEXwaQPOzYy0YsS/4sKHtxZaI/NkL9nUcsCvq5yi22YAcr5wCrT6jJIV9
         lUG98dgJXA7TOMKJHpPCI6n473xBdGRiz3OfvaCJdn0nbQbo83gP3U3zvSeR4vlyxoE/
         CTv5AROWyIMVTcxZ7BfAQCQPge2bPACzv4qDbwqTEMTaT1rbk28jsf4hWzOzbGJPFQnA
         98/8JCCxAweev3QrkXQ8c5R2YiDnJO9WBmmYckeVXJNqzfLtPD9S6rgKa/YSm3gARdAr
         lYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DQYyduXCH8AzCMoe7NeiL6VRz0Am9b0h6i4kCTzpbs0=;
        b=ULIhBaAL0D4745QFAl/fDgAWNzy5q0xZ/RyQPvtreRgTaEoU0SqFIC6E7PbyJQXxDx
         bxjNmtGvhxTEi6+Sjqsk8HU0uojum/oso7NDo/osO1ViHLTyRBq0dqGHO02oaw4MOilW
         SiBadlesyfcul1AicErmllcUu6Gx76p3upNe1MdCnO6P8CT24do3KGSnwbBvSyHKwzTP
         8+P76TvBmxKtkXl3g/xX7C59ORhL9WOfmzDpRx+HIxFt1NwW5cAuzNAhEoEziylZvqVy
         D2OgZJ9ByLkK+iK3h07j1sZ9plQQJniZdoQAIca0esFF+QpCy8OQ36qEqbq2zrdoDEbo
         4o4Q==
X-Gm-Message-State: AOAM533QYBBE//aNUCuYNjeDUDoGt3fC9+Vo4i++2HYirf4Cjjcjo9zI
        d2gJ3Ybch+uEuqP8ZGNfdKwpFlapywE=
X-Google-Smtp-Source: ABdhPJxfrVoK+AmpfgXLcjidTDmDsAyzRmQGHPbo4DbOLraHg54HyHKMSe9ePZ1NEd+AHrcxMPhGFA==
X-Received: by 2002:a5d:64c5:0:b0:1f1:e6b8:bd3c with SMTP id f5-20020a5d64c5000000b001f1e6b8bd3cmr9783403wri.686.1646750369938;
        Tue, 08 Mar 2022 06:39:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm2331754wmc.47.2022.03.08.06.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:29 -0800 (PST)
Message-Id: <470b6f73e2805b0ed4ec83bc8eb8be45f16fbb5a.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:17 +0000
Subject: [PATCH v3 10/12] bundle: create filtered bundles
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
index 41922565627..393216c6246 100644
--- a/bundle.c
+++ b/bundle.c
@@ -332,6 +332,9 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 		     "--stdout", "--thin", "--delta-base-offset",
 		     NULL);
 	strvec_pushv(&pack_objects.args, pack_options->v);
+	if (revs->filter)
+		strvec_pushf(&pack_objects.args, "--filter=%s",
+			     list_objects_filter_spec(revs->filter));
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
 	pack_objects.git_cmd = 1;
@@ -499,10 +502,37 @@ int create_bundle(struct repository *r, const char *path,
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
@@ -525,17 +555,14 @@ int create_bundle(struct repository *r, const char *path,
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
@@ -558,6 +585,12 @@ int create_bundle(struct repository *r, const char *path,
 	bpi.fd = bundle_fd;
 	bpi.pending = &revs_copy.pending;
 
+	/*
+	 * Nullify the filter here, and any object walking. We only care
+	 * about commits and tags here. The revs_copy has the right
+	 * instances of these values.
+	 */
+	revs.filter = NULL;
 	revs.blob_objects = revs.tree_objects = 0;
 	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
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

