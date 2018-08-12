Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302DE1F404
	for <e@80x24.org>; Sun, 12 Aug 2018 05:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeHLHs7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 03:48:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37740 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeHLHs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 03:48:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so5579621wmc.2
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6PwOhyLQ1sefsg93z7vcbW77EkfOmS+e3I+69Wk1Lk=;
        b=UNXNE+pBwzOEZgK/F2eUVs+YMhBS0oz560IAbsiLF7PKRZbki0gY2zptNBeNO+bDnB
         pYb2qu0nr9zOb+NsBAGat2ofKsYe7g2JEVpbeWp8/RPfYDL5Jy0NvIT9n2tG2jyvmUAj
         NOPPoEFCU64czuvC77EIv8pqvu0CtX8TTYYPUt49hqZmiVx1NWQsVazrRXTatDLto7uq
         mvS3X88nka+H9UOEbM1v8KzNWD4IRN0ngrpFzHRBB6jTG9IDFa/vmk/LuTVhuSIV+s6H
         b7R5ztnjljI2/w/q+3gn8ZAFBm0ih3upWIp+rfGyvijeTCIv+Sr1pizjw+dG98mXX+W8
         OITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6PwOhyLQ1sefsg93z7vcbW77EkfOmS+e3I+69Wk1Lk=;
        b=q9VfdbsAhusfZ1Vi1WWiZDp5QqKoOB5BdIiorB0iGNXFLdlIFKMeSPf1lPRhkLmXp1
         /WcHvOCydFmT1UakAOGiIOLS50vTr4mGCGVAe7l4UqH+RPj247cWDWAAa1+JG0PC0kpY
         E6ZrcOOFsD8USuJFWVdP0PXk06l9LkL0UlDiNOYMf8tiJii8NmmEb1/vPnVbvvFA8Svo
         +xgz4cY1z5DyAze1/z9BbU59ifzCS9sJhE2IlJYHUc44h3tqCQxNJBXKxEgEqkMLZolr
         A0KjKKVdjF/V4Lg6SOaY3mwex7EFny0nIctoNyj8zd8Oxir8f/gmsTU3LZkvuiwSuW3t
         P+zw==
X-Gm-Message-State: AOUpUlHkyp3w04zcY0Sy20hFs7SiWrj2C1d1naDxb7xJyW68l3wOMprW
        E/vJ/D0NhaBE3sqGVPloFX+xvXOZ
X-Google-Smtp-Source: AA+uWPyhVAw6Jn8+sQ11aPfPFQ1PgyROITMLLKtHLxjfacdZtDtSi7GbGfUyXaC8zHi798PO5/LyWQ==
X-Received: by 2002:a1c:a401:: with SMTP id n1-v6mr5389054wme.125.1534050736454;
        Sat, 11 Aug 2018 22:12:16 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id g10-v6sm13281205wrv.90.2018.08.11.22.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 22:12:15 -0700 (PDT)
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
Subject: [PATCH v4 4/7] repack: add delta-islands support
Date:   Sun, 12 Aug 2018 07:11:48 +0200
Message-Id: <20180812051151.6425-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.554.gdb07901040.dirty
In-Reply-To: <20180812051151.6425-1-chriscool@tuxfamily.org>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
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
index 27bb77f9e7..2bd31078b2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3145,6 +3145,10 @@ repack.packKeptObjects::
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
2.18.0.554.gdb07901040.dirty

