Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863691F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 15:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJHW3U (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 18:29:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37705 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeJHW3U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 18:29:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id az3-v6so10221479plb.4
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4K2X/DQ7XSdPmLpTKwl1TzdTYvEmKg//QkKKT4Llcd4=;
        b=Jt0Cvf/r0FUtJspfU6KHdzMiMBrlG7zYt6V8EEx0BlS/f2/AYE2yi/zPt5T57muN/c
         bMYPkLnLtr8Xytow7fjnqvSuewLW3jnbHIjDG9MGV5rrZ/xyQYvWUwp/VqI0j9q2uCak
         K/reXy55CMmqMi9WcFCAbb5+094nTfslUUC2EbcsacjpYfVywuYrY/CniCkRwMJRkmaG
         rsf7xfksT+VtkX0WbdM2J8O6PjYyYNly30IGE/gLVCsrSBsMmwB8XMFULYs+zxLCzOMh
         oUoRZtG0HybP4dl3TjzlByLo4+UAOdRmkjLpyKH7UlTXZ3sf4YPnAPQenLMtQ/3gIUWQ
         3+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4K2X/DQ7XSdPmLpTKwl1TzdTYvEmKg//QkKKT4Llcd4=;
        b=Ca7ROo9dFSoHVO3H0OuSF5LEOgTEGdHtBgOq8YZZ1gN5+0GVoE8pzFv/i1puAAlwtC
         3RNp1FpvKaUrxeFhBNGcNpxEb9JPXj04u19Ivt7Fuilicn6HHoAbenJXVrNGKo+D7BJG
         KXQ0ffdGjZJmvccBm2lh1uypDeoOyboq3T85Mc/qMg8c3zmzedFx7MiwG7STyCx5aGjB
         9IWqW1SiKZV1UkK0HKvyBRWOBO0CCWiiWe+mU+YTQKVSixyASkeQQakGO6cBfrGiRL8k
         0w7zuPzTksE601lapwkfDNW5Xw/JQ0mbEdrmjxAdlGDOr2lLpDIDA+OrH2f/hC9IiYF4
         PmEg==
X-Gm-Message-State: ABuFfohxakcmhFeeHQliWt1JPmllbK178U1x76PGvyEa3YaOEx3RG9ja
        R0nQk0EDM94wwAsUH7HYnHg4IiI9
X-Google-Smtp-Source: ACcGV61dx8mE+eat2s+CoDDFrszBh5ftNNv1poX6Aw/nQlBrIVTTbyTlAqJd+MdvY+wAW27K05fDig==
X-Received: by 2002:a17:902:bcc3:: with SMTP id o3-v6mr25005331pls.202.1539011827374;
        Mon, 08 Oct 2018 08:17:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id z26-v6sm13173963pfh.77.2018.10.08.08.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 08:17:06 -0700 (PDT)
Date:   Mon, 08 Oct 2018 08:17:06 -0700 (PDT)
X-Google-Original-Date: Mon, 08 Oct 2018 15:16:59 GMT
Message-Id: <04e3e9108266e322a3db827355689c887a9cae8c.1539011820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.27.git.gitgitgadget@gmail.com>
References: <pull.27.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The multi-pack-index feature is tested in isolation by
t5319-multi-pack-index.sh, but there are many more interesting
scenarios in the test suite surrounding pack-file data shapes
and interactions. Since the multi-pack-index is an optional
data structure, it does not make sense to include it by default
in those tests.

Instead, add a new GIT_TEST_MULTI_PACK_INDEX environment variable
that enables core.multiPackIndex and writes a multi-pack-index
after each 'git repack' command. This adds extra test coverage
when needed.

There are a few spots in the test suite that need to react to this
change:

* t5319-multi-pack-index.sh: there is a test that checks that
  'git repack' deletes the multi-pack-index. Disable the environment
  variable to ensure this still happens.

* t5310-pack-bitmaps.sh: One test moves a pack-file from the object
  directory to an alternate. This breaks the multi-pack-index, so
  delete the multi-pack-index at this point, if it exists.

* t9300-fast-import.sh: One test verifies the number of files in
  the .git/objects/pack directory is exactly 8. Exclude the
  multi-pack-index from this count so it is still 8 in all cases.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c            | 4 ++++
 midx.c                      | 9 +++++++--
 midx.h                      | 2 ++
 t/README                    | 4 ++++
 t/t5310-pack-bitmaps.sh     | 1 +
 t/t5319-multi-pack-index.sh | 2 +-
 t/t9300-fast-import.sh      | 2 +-
 7 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 7925bb976e..418442bfe2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -558,6 +558,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (!no_update_server_info)
 		update_server_info(0);
 	remove_temporary_files();
+
+	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
+		write_midx_file(get_object_directory());
+
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_packs, 0);
diff --git a/midx.c b/midx.c
index fe8532a9d1..aeafb58fa3 100644
--- a/midx.c
+++ b/midx.c
@@ -338,9 +338,14 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 	struct multi_pack_index *m;
 	struct multi_pack_index *m_search;
 	int config_value;
+	static int env_value = -1;
 
-	if (repo_config_get_bool(r, "core.multipackindex", &config_value) ||
-	    !config_value)
+	if (env_value < 0)
+		env_value = git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0);
+
+	if (!env_value &&
+	    (repo_config_get_bool(r, "core.multipackindex", &config_value) ||
+	    !config_value))
 		return 0;
 
 	for (m_search = r->objects->multi_pack_index; m_search; m_search = m_search->next)
diff --git a/midx.h b/midx.h
index af6b5cb58f..bec8f73d28 100644
--- a/midx.h
+++ b/midx.h
@@ -3,6 +3,8 @@
 
 #include "repository.h"
 
+#define GIT_TEST_MULTI_PACK_INDEX "GIT_TEST_MULTI_PACK_INDEX"
+
 struct multi_pack_index {
 	struct multi_pack_index *next;
 
diff --git a/t/README b/t/README
index 3ea6c85460..9d0277c338 100644
--- a/t/README
+++ b/t/README
@@ -327,6 +327,10 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
 be written after every 'git commit' command, and overrides the
 'core.commitGraph' setting to true.
 
+GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
+index to be written after every 'git repack' command, and overrides the
+'core.multiPackIndex' setting to true.
+
 Naming Tests
 ------------
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 1be3459c5b..82d7f7f6a5 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -191,6 +191,7 @@ test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pa
 
 test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
 	mv .git/objects/pack/$packbitmap.* alt.git/objects/pack/ &&
+	rm -f .git/objects/pack/multi-pack-index &&
 	test_when_finished "mv alt.git/objects/pack/$packbitmap.* .git/objects/pack/" &&
 	echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
 	git index-pack 3b.pack &&
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 6f56b38674..4024ff9a39 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -152,7 +152,7 @@ compare_results_with_midx "twelve packs"
 
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
-	git repack -adf &&
+	GIT_TEST_MULTI_PACK_INDEX=0 git repack -adf &&
 	test_path_is_missing $objdir/pack/multi-pack-index
 '
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 40fe7e4976..59a13b6a77 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1558,7 +1558,7 @@ test_expect_success 'O: blank lines not necessary after other commands' '
 	INPUT_END
 
 	git fast-import <input &&
-	test 8 = $(find .git/objects/pack -type f | wc -l) &&
+	test 8 = $(find .git/objects/pack -type f | grep -v multi-pack-index | wc -l) &&
 	test $(git rev-parse refs/tags/O3-2nd) = $(git rev-parse O3^) &&
 	git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
 	test_cmp expect actual
-- 
gitgitgadget
