Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85E261F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfGAO3P (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:29:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42901 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfGAO3N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:29:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id z25so23861726edq.9
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aLzGHjxVg7G7PS5Ao8bnhETVG+GIFT0QLeedM3KJh00=;
        b=ad7FO1OYXA+rAsNJ8XnGkEwuq8CmSsTHjelBtidfBmc2SUdQayd9cJqINxKo2WZ8IC
         +JOtjoP9p4X4oYOUXPZiab/ru7ryieNROR1leH80ADOSas3wIVc4TbQA3MQ/lCtBDCqt
         4+GiaB8GiBc9gj6oXAc16KERBD/L6ZNrbDPHS2xvRkJwS6bPcju27khuprSD2cHp6jfi
         ajEtBs2tBOoPNDCDC43qDEEg2nDQrvEnz1ZWVuLCQPz47W37jKGZU7y5ExjDQtnLAGIy
         6lGqs0sh1wnSu6fphIIQiGvx1REQpq6+nKDFEoB67XWPtQMNx2pksov2HjKL6mdm/kPQ
         CNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aLzGHjxVg7G7PS5Ao8bnhETVG+GIFT0QLeedM3KJh00=;
        b=D5b4zKa/77oJYj3q5fVn5kp8E9VNDtjwgZ67vtbUoxioLGIbeGnphs09CLlSWEr9Pv
         oi6B80fRpCb1EWhiIUpazIZx3XUQl0GlrY873aw8KTe+4qIYotEL3yJPC+1+068aS7h7
         1zFfa2iKnRnvAZ8kd8Xf+1MLc4YT40cv3jyoClAnOwy5Co6y4oGUAmVal+s21texppOg
         bnpS8Y1XB9i8gfbR2Co9mFLoEeJai7AGFNPBqSxDFgsWh/ZsrkU67nweb3FdEmk2TZbf
         zEs0BxrdO9YDy4RZBZTQlUt6RgiSXK/6jCfe/cqW4TRw2H677VMaVFK1n4E6Huufb2o3
         KxpA==
X-Gm-Message-State: APjAAAVZn+N3fEoSmRSRovFFZl5dV966BeFDktoZsqGGGSdy+eiQpR5s
        ZQeUGyNZ5BACFbYfgjyp3MBC/Xgv
X-Google-Smtp-Source: APXvYqxfT63bZBqRSur5VC/X773NngF+9I2t15FSUeh2NhcROKxBO2vkV5aGW81cegR/lOLXEpLn/w==
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr23769288ejd.234.1561991351939;
        Mon, 01 Jul 2019 07:29:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e22sm3684733edd.25.2019.07.01.07.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:29:11 -0700 (PDT)
Date:   Mon, 01 Jul 2019 07:29:11 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 14:29:07 GMT
Message-Id: <d080065a9208852a7e551cc8bef7d326576c076d.1561991348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.v3.git.gitgitgadget@gmail.com>
References: <pull.254.v2.git.gitgitgadget@gmail.com>
        <pull.254.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/3] repo-settings: pack.useSparse=true
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a repo is large, then it probably has a very large working
directory. In this case, a typical developer's edits usually impact
many fewer paths than the full path set. The sparse treewalk
algorithm is optimized for this case, speeding up 'git push' calls.

Use pack.useSparse=true when core.featureAdoptionRate is at least
five. This is the first setting where the feature has only been
out for a single major version. This could be moved to the "at
least three" category after another major version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt | 9 +++++++++
 Documentation/config/pack.txt | 3 ++-
 builtin/pack-objects.c        | 9 +++++----
 repo-settings.c               | 8 ++++++++
 repo-settings.h               | 1 +
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 865252aba9..60356102a8 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -624,3 +624,12 @@ The settings do not modify the user-facing output of porcelain commands.
 +
 * `index.version=4` uses prefix-compression to reduce the size of the
 .git/index file.
++
+If the value is at least 5, then all of the defaults above are included,
+plus the defaults below. These represent new features that present
+significant performance benefits, but may not have been released for
+multiple major versions.
++
+* `pack.useSparse=true` uses the sparse tree-walk algorithm, which is
+optimized for enumerating objects during linkgit:git-push[1] from a
+client machine.
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 9cdcfa7324..9c4f8ea9ff 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -112,7 +112,8 @@ pack.useSparse::
 	objects. This can have significant performance benefits when
 	computing a pack to send a small change. However, it is possible
 	that extra objects are added to the pack-file if the included
-	commits contain certain types of direct renames.
+	commits contain certain types of direct renames. Defaults to
+	false, unless `core.featureAdoptionRate` is at least five.
 
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 41d7fc5983..f26b3f2892 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -34,6 +34,7 @@
 #include "dir.h"
 #include "midx.h"
 #include "trace2.h"
+#include "repo-settings.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
@@ -2707,10 +2708,6 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
-	if (!strcmp(k, "pack.usesparse")) {
-		sparse = git_config_bool(k, v);
-		return 0;
-	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
@@ -3330,6 +3327,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	read_replace_refs = 0;
 
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", 0);
+	prepare_repo_settings(the_repository);
+	if (!sparse && the_repository->settings->pack_use_sparse != -1)
+		sparse = the_repository->settings->pack_use_sparse;
+
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
 
diff --git a/repo-settings.c b/repo-settings.c
index 5753153a84..c700edc286 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -16,6 +16,9 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
 			UPDATE_DEFAULT(rs->index_version, 4);
 		}
+		if (rate >= 5) {
+			UPDATE_DEFAULT(rs->pack_use_sparse, 1);
+		}
 		return 0;
 	}
 	if (!strcmp(key, "core.commitgraph")) {
@@ -26,6 +29,10 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		rs->gc_write_commit_graph = git_config_bool(key, value);
 		return 0;
 	}
+	if (!strcmp(key, "pack.usesparse")) {
+		rs->pack_use_sparse = git_config_bool(key, value);
+		return 0;
+	}
 	if (!strcmp(key, "index.version")) {
 		rs->index_version = git_config_int(key, value);
 		return 0;
@@ -44,6 +51,7 @@ void prepare_repo_settings(struct repository *r)
 	/* Defaults */
 	r->settings->core_commit_graph = -1;
 	r->settings->gc_write_commit_graph = -1;
+	r->settings->pack_use_sparse = -1;
 	r->settings->index_version = -1;
 
 	repo_config(r, git_repo_config, r->settings);
diff --git a/repo-settings.h b/repo-settings.h
index b752dfe8b4..1151c2193a 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -4,6 +4,7 @@
 struct repo_settings {
 	int core_commit_graph;
 	int gc_write_commit_graph;
+	int pack_use_sparse;
 	int index_version;
 };
 
-- 
gitgitgadget
