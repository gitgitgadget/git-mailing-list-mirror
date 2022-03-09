Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B6BC433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 23:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbiCIXEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiCIXE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 18:04:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A446120F4D
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:03:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e24so5250418wrc.10
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 15:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iS29yHd10pfhgSmUnfUcOUWlb5yXia0SwcOp6jW9HYE=;
        b=mXP+x/kq/5pdDiQj+9ZN5lqhvilJspnN6rCMDko26xvpfI2wIYrMeBmG+3IgumO7Xn
         Iy6uqMofVWyDUxXWMoAMUjs0jTgaTAh4UKwjCPQr/yRYLxfND0g4ujWXklkVJye1X5Nr
         6bllshMN519LLzoNjJIv3ALfyvBd389d+hSzfAC2azNuJrzQFwGc/EaqFNMlWqEK514i
         LETCqWf14Y3p/SkxsKSoM/eN9QSJAl3zgeuMMVtMRQVhqpTe8CH0rTG7L+e/2C8H+q/F
         ZVr9swSpww1wMQZESfvbi6C9cNUIrF9NWhdJJNoxghhHIWFMQEr/rucwQwRyfXeoD4ty
         fLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iS29yHd10pfhgSmUnfUcOUWlb5yXia0SwcOp6jW9HYE=;
        b=FTkJus+Dn7JEb5QuLQPokFlzK/jWNrMzZymgfoO57uVLEiqCY5OCnJtrC4VbjCcTyK
         ash7lsMCxhd4xdDU/HSxNPrZGdFxMN8mn+HTUkoxfAjBdu7PzKiaEBjYHkqC3Y3ZOZcF
         MklOnzYaGzyIZQHtIKr0zz9dKFzA5x4uw4S3X5aR3MP/87tC5JMgo+43O1RnpUQUNY0a
         uUbeN2MCLZqxv4qTwrE8SuWOTJG+5I3Gs/0aT3ohJwbABhqVMW6SoPTEVtopbEc9TczQ
         kO+MyTSBsoxAjNGAq6bqye0jxFrKph4KYRkZ4A/Y1rVFtqWhGwoXJYyzTAMpzdZWhsYU
         xu7Q==
X-Gm-Message-State: AOAM533++W8s6e4/d0A5/1Lzq6dNCLo9GGrTFCNz2KVhYNjZLG1I/3kD
        zuexcaehAKLK8J3RHVfVg1h0dZ7RXlw=
X-Google-Smtp-Source: ABdhPJzYTpvi5OIglgQAEINRPrQ1ayZApCnPeM2bnshJxWfGuarQDrp/umIfIHKXAmCJNQ6U1w2dUg==
X-Received: by 2002:a5d:62cd:0:b0:1f0:23d2:b38c with SMTP id o13-20020a5d62cd000000b001f023d2b38cmr1437604wrv.82.1646867005142;
        Wed, 09 Mar 2022 15:03:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm3515688wmb.3.2022.03.09.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 15:03:24 -0800 (PST)
Message-Id: <2d71346b10e8beb3c44bdf8e06694e4dafc657d5.1646866998.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 23:03:18 +0000
Subject: [PATCH v5 5/5] core.fsync: documentation and user-friendly aggregate
 options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
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
 Documentation/config/core.txt | 36 +++++++++++++++++++++++++++++++++++
 cache.h                       | 23 +++++++++++++++++++---
 config.c                      |  6 ++++++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 74399072843..973805e8a98 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -547,6 +547,42 @@ core.whitespace::
   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
+core.fsync::
+	A comma-separated list of parts of the repository which should be
+	hardened via the core.fsyncMethod when created or modified. You can
+	disable hardening of any component by prefixing it with a '-'. Later
+	items take precedence over earlier ones in the comma-separated list.
+	For example, `core.fsync=all,-pack-metadata` means "harden everything
+	except pack metadata." Items that are not hardened may be lost in the
+	event of an unclean system shutdown. Unless you have special
+	requirements, it is recommended that you leave this option as default
+	or pick one of `committed`, `added`, or `all`.
++
+* `none` disables fsync completely. This value must be specified alone.
+* `loose-object` hardens objects added to the repo in loose-object form.
+* `pack` hardens objects added to the repo in packfile form.
+* `pack-metadata` hardens packfile bitmaps and indexes.
+* `commit-graph` hardens the commit graph file.
+* `index` hardens the index when it is modified.
+* `objects` is an aggregate option that is equivalent to
+  `loose-object,pack`.
+* `derived-metadata` is an aggregate option that is equivalent to
+  `pack-metadata,commit-graph`.
+* `default` is an aggregate option that is equivalent to
+  `objects,derived-metadata,-loose-object`. This mode is enabled by default.
+  It has good performance, but risks losing recent work if the system shuts
+  down uncleanly, since commits, trees, and blobs in loose-object form may be
+  lost.
+* `committed` is an aggregate option that is currently equivalent to
+  `objects`. This mode sacrifices some performance to ensure that all work
+  that is committed to the repository with `git commit` or similar commands
+  is preserved.
+* `added` is an aggregate option that is currently equivalent to
+  `committed,index`. This mode sacrifices additional performance to
+  ensure that the results of commands like `git add` and similar operations
+  are preserved.
+* `all` is an aggregate option that syncs all individual components above.
+
 core.fsyncMethod::
 	A value indicating the strategy Git will use to harden repository data
 	using fsync and related primitives.
diff --git a/cache.h b/cache.h
index 3fefe8f6f60..833f0236e68 100644
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
index bb44f6f506d..3976ec74fd4 100644
--- a/config.c
+++ b/config.c
@@ -1332,6 +1332,12 @@ static const struct fsync_component_entry {
 	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
 	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
 	{ "index", FSYNC_COMPONENT_INDEX },
+	{ "objects", FSYNC_COMPONENTS_OBJECTS },
+	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
+	{ "default", FSYNC_COMPONENTS_DEFAULT },
+	{ "committed", FSYNC_COMPONENTS_COMMITTED },
+	{ "added", FSYNC_COMPONENTS_ADDED },
+	{ "all", FSYNC_COMPONENTS_ALL },
 };
 
 static enum fsync_component parse_fsync_components(const char *var, const char *string)
-- 
gitgitgadget
