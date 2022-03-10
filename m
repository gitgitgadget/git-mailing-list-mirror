Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC2EC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344404AbiCJWot (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbiCJWog (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:44:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73290D2276
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u10so10278434wra.9
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kEvQF8GZwqNj9QVImtLId8cF12bFTehdlgQQfVzDGQ4=;
        b=KAr24GH2aZmDMtArA7GQZn/dcKTN9LphBYU3DH+GDpe60G3DPc+UoT2JgyFqgGu3na
         5boakKQ4JV0UGDSPOFyv1XyCKhk6nySPCfgMHcssMG8bju2K0eS1MHlT8yzb+VKlNeaP
         incBn/PKKu+7Cnb/FrfQ9b1fbQTavZ/B8PskSBpPqBooytOvZ2ZdwHMWxwRfR64M1PFE
         Gb1ENk+RcToZ5SY7KvDGjiaP8nlNejfIqMIExeu1FzcL/1/5pEEA/cqTNpzGaiqIKMq1
         4Tlzz0i54GNtuWEYO6RGF5KfAB53T5k8NSLrE8LXwNeR8sU4PnYbPQfrQzW66pal/o8X
         qrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kEvQF8GZwqNj9QVImtLId8cF12bFTehdlgQQfVzDGQ4=;
        b=FxY1u8YN49bBxo+gbgnShpAiBcAFksO8tFvF/c6G5S1yI35nc179XMFvx7Yakse5ad
         zBsO8wPaOcK2QHohKOMNiN7YGe6zLgBUr3J6/4ZC6eTVKmxVgcUfJ+JfeYbbNyGbDefz
         krVtKp/nKeDbDCc1RYHvYHkTCsqG2dpvNoQ1bmAR/K48w27lcnoaiuchFqfRH0NXfpUw
         uimlZy6XZqzWTN/Pvgk4yd5NYv+AM9zEA0hg6hQ3cz7aTa6QBZYrawLY3RBn4X+/3Dhk
         8yNHjrogyLFTSAtbvyz2Oc4+zGrNNajjwvbLV1zt42k46AhTu28VyQG9vPo1Y9Zpzewz
         0uvw==
X-Gm-Message-State: AOAM532QXY3cimlxs8p2HL3F58fETAkzdTtfjm8yjYKQFG5pa8fEB+qg
        ADi8vmQ53FHzy98K3O+r4DlLRHVeny8=
X-Google-Smtp-Source: ABdhPJz1giO/ozzYWLTVfx4ffFd1tTZJODU2e9bB3gh1C9ZanZ2FsJ7Ctj84N4JEyYxfHb8EwoUAAg==
X-Received: by 2002:a5d:64e5:0:b0:1fb:5b9a:1a20 with SMTP id g5-20020a5d64e5000000b001fb5b9a1a20mr5091012wri.34.1646952212821;
        Thu, 10 Mar 2022 14:43:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4a4c000000b001e68ba61747sm5154996wrs.16.2022.03.10.14.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:43:32 -0800 (PST)
Message-Id: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 22:43:24 +0000
Subject: [PATCH v6 6/6] core.fsync: documentation and user-friendly aggregate
 options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit adds aggregate options for the core.fsync setting that are
more user-friendly. These options are specified in terms of 'levels of
safety', indicating which Git operations are considered to be sync
points for durability.

The new documentation is also included here in its entirety for ease of
review.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt | 40 +++++++++++++++++++++++++++++++++++
 cache.h                       | 23 +++++++++++++++++---
 config.c                      |  5 +++++
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index ab911d6e269..37105a7be40 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -547,6 +547,46 @@ core.whitespace::
   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
+core.fsync::
+	A comma-separated list of components of the repository that
+	should be hardened via the core.fsyncMethod when created or
+	modified.  You can disable hardening of any component by
+	prefixing it with a '-'.  Items that are not hardened may be
+	lost in the event of an unclean	system shutdown. Unless you
+	have special requirements, it is recommended that you leave
+	this option empty or pick one of `committed`, `added`,
+	or `all`.
++
+When this configuration is encountered, the set of components starts with
+the platform default value, disabled components are removed, and additional
+components are added. `none` resets the state so that the platform default
+is ignored.
++
+The empty string resets the fsync configuration to the platform
+default. The platform default on most platform is equivalent to
+`core.fsync=committed,-loose-object`, which has good performance,
+but risks losing recent work in the event of an unclean system shutdown.
++
+* `none` clears the set of fsynced components.
+* `loose-object` hardens objects added to the repo in loose-object form.
+* `pack` hardens objects added to the repo in packfile form.
+* `pack-metadata` hardens packfile bitmaps and indexes.
+* `commit-graph` hardens the commit graph file.
+* `index` hardens the index when it is modified.
+* `objects` is an aggregate option that is equivalent to
+  `loose-object,pack`.
+* `derived-metadata` is an aggregate option that is equivalent to
+  `pack-metadata,commit-graph`.
+* `committed` is an aggregate option that is currently equivalent to
+  `objects`. This mode sacrifices some performance to ensure that work
+  that is committed to the repository with `git commit` or similar commands
+  is hardened.
+* `added` is an aggregate option that is currently equivalent to
+  `committed,index`. This mode sacrifices additional performance to
+  ensure that the results of commands like `git add` and similar operations
+  are hardened.
+* `all` is an aggregate option that syncs all individual components above.
+
 core.fsyncMethod::
 	A value indicating the strategy Git will use to harden repository data
 	using fsync and related primitives.
diff --git a/cache.h b/cache.h
index e08eeac6c15..86680f144ec 100644
--- a/cache.h
+++ b/cache.h
@@ -1007,9 +1007,26 @@ enum fsync_component {
 	FSYNC_COMPONENT_INDEX			= 1 << 4,
 };
 
-#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
-				  FSYNC_COMPONENT_PACK_METADATA | \
-				  FSYNC_COMPONENT_COMMIT_GRAPH)
+#define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
+				  FSYNC_COMPONENT_PACK)
+
+#define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA | \
+					   FSYNC_COMPONENT_COMMIT_GRAPH)
+
+#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENTS_OBJECTS | \
+				  FSYNC_COMPONENTS_DERIVED_METADATA | \
+				  ~FSYNC_COMPONENT_LOOSE_OBJECT)
+
+#define FSYNC_COMPONENTS_COMMITTED (FSYNC_COMPONENTS_OBJECTS)
+
+#define FSYNC_COMPONENTS_ADDED (FSYNC_COMPONENTS_COMMITTED | \
+				FSYNC_COMPONENT_INDEX)
+
+#define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
+			      FSYNC_COMPONENT_PACK | \
+			      FSYNC_COMPONENT_PACK_METADATA | \
+			      FSYNC_COMPONENT_COMMIT_GRAPH | \
+			      FSYNC_COMPONENT_INDEX)
 
 /*
  * A bitmask indicating which components of the repo should be fsynced.
diff --git a/config.c b/config.c
index 80f33c91982..fd8e1659312 100644
--- a/config.c
+++ b/config.c
@@ -1332,6 +1332,11 @@ static const struct fsync_component_name {
 	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
 	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
 	{ "index", FSYNC_COMPONENT_INDEX },
+	{ "objects", FSYNC_COMPONENTS_OBJECTS },
+	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
+	{ "committed", FSYNC_COMPONENTS_COMMITTED },
+	{ "added", FSYNC_COMPONENTS_ADDED },
+	{ "all", FSYNC_COMPONENTS_ALL },
 };
 
 static enum fsync_component parse_fsync_components(const char *var, const char *string)
-- 
gitgitgadget
