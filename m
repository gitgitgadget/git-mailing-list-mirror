Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12F681F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbeHPJJq (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 05:09:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35478 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388857AbeHPJJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 05:09:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id g1-v6so3048867wru.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 23:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nygb35vwxi7JnXzcpo+/wMWrAL+9G0D7rjnnusOql6g=;
        b=tEZ0tdk1Y4YaSUDO0fR+IAGKBqDuekeG9j5xk4pXHl/cvOebGx7Hd972ldJIGK/gEG
         jlDuXUQ02wPtjZOJwQP1F864+5Z9iwlprRpMxZNgpnpcZgkyj14B4MERgPzR1NzE+nps
         vkRz6zQ847eEHtCQ4UiK4lynYooyJ67GY8NYfiX81Z/aQhzK6XSqBcWMmTnqOpNKq/pj
         LLn5YNpVFOsX492u8Vqj2wKU3tKErUFqP49klTWuGoa7LvDBpwgF/7VtgTlQfT/SEQhi
         ug01vjZuDyT0RWYnc5Mx7+O/urn/PNJmP0LDnSXKZISGbTPOO+kfG9Cabu+J5LSwgBuH
         mE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nygb35vwxi7JnXzcpo+/wMWrAL+9G0D7rjnnusOql6g=;
        b=W+HWDpHzeLh0jVWJJpnOJpSXDsZeN+f4Wlsfk754Tu+6mgIHRMT1zPYgyIi8Mtzo5b
         kJY0lYUaCFJ4i5b6GdXHzt4ZUJaUIaJ0iDrptzSmFREuAaT28JE8PvByJAYsR+SWgCkb
         c5hLAHl+vWvlao/RwoHKstNGQd63BzkXGKdOO85D0ggk/YqSfszrITpNFHPNWgHmAwqy
         QTc/TMwiqpiAssvQ7CooHs8qwZsKOYNxqFU3Q/yjLUZTqVuvhmSTrVgnwhPWwYUypsUw
         zKg7U5Ur0rvlhJGmv6Fg/aBNnJgk5I+y8nkwFpRLfAKPmNkFDUqusjP72SzwQ7PZP2eg
         gjHA==
X-Gm-Message-State: AOUpUlFD1EEtpnUdEeDSh/ZUj+4qL54mgWX8ywjNK87+9sxdkxk5tlxh
        Wq5DpQQR4MOabfAhW6DQBKXSQM+f
X-Google-Smtp-Source: AA+uWPzn5K2hj+BhUfp1BDTPB2EOKzbVOX/ApitPU621hJ2o1HUCdehfHrWsal12X0Cg90dgY6bLPg==
X-Received: by 2002:adf:ef03:: with SMTP id e3-v6mr18458032wro.182.1534400016114;
        Wed, 15 Aug 2018 23:13:36 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id d8-v6sm22325182wrv.68.2018.08.15.23.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 23:13:35 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER Gabor <szeder.dev@gmail.com>
Subject: [PATCH v5 4/7] repack: add delta-islands support
Date:   Thu, 16 Aug 2018 08:13:10 +0200
Message-Id: <20180816061313.19298-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.673.gcd86e60100
In-Reply-To: <20180816061313.19298-1-chriscool@tuxfamily.org>
References: <20180816061313.19298-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Implement simple support for --delta-islands option and
repack.useDeltaIslands config variable in git repack.

This allows users to setup delta islands in their config and
get the benefit of less disk usage while cloning and fetching
is still quite fast and not much more CPU intensive.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt     | 4 ++++
 Documentation/git-repack.txt | 5 +++++
 builtin/repack.c             | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af8c746e75..486536f505 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3160,6 +3160,10 @@ repack.packKeptObjects::
 	index is being written (either via `--write-bitmap-index` or
 	`repack.writeBitmaps`).
 
+repack.useDeltaIslands::
+	If set to true, makes `git repack` act as if `--delta-islands`
+	was passed. Defaults to `false`.
+
 repack.writeBitmaps::
 	When true, git will write a bitmap index when packing all
 	objects to disk (e.g., when `git repack -a` is run).  This
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d90e7907f4..a8b2d4722f 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -155,6 +155,11 @@ depth is 4095.
 	being removed. In addition, any unreachable loose objects will
 	be packed (and their loose counterparts removed).
 
+-i::
+--delta-islands::
+	Pass the `--delta-islands` option to `git-pack-objects`, see
+	linkgit:git-pack-objects[1].
+
 Configuration
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159e..5ab9ee69e4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -12,6 +12,7 @@
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
 static int write_bitmaps;
+static int use_delta_islands;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -40,6 +41,10 @@ static int repack_config(const char *var, const char *value, void *cb)
 		write_bitmaps = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "repack.usedeltaislands")) {
+		use_delta_islands = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -194,6 +199,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("pass --local to git-pack-objects")),
 		OPT_BOOL('b', "write-bitmap-index", &write_bitmaps,
 				N_("write bitmap index")),
+		OPT_BOOL('i', "delta-islands", &use_delta_islands,
+				N_("pass --delta-islands to git-pack-objects")),
 		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
 				N_("with -A, do not loosen objects older than this")),
 		OPT_BOOL('k', "keep-unreachable", &keep_unreachable,
@@ -267,6 +274,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_pushf(&cmd.args, "--no-reuse-object");
 	if (write_bitmaps)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
+	if (use_delta_islands)
+		argv_array_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
-- 
2.18.0.673.gcd86e60100

