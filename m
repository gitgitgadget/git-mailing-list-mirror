Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB86C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbiC3FHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbiC3FHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B991D66AFE
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q20so11523434wmq.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RIF5CAZ9hTXQxe5JpOeXS1KOLlyZ8DHo3e5ICWJYFAY=;
        b=cg/VnRJVSzjavnMvPA0/sBzx3C/xMKQWwbSgHtMMsqjAXAMVj0iAk6bzo2J4ceFEnZ
         DrAPIrHQ81d0M7khoYbxhILjvHeayiWYLSCi5a213L7gBPHkz79DRDO3kGq9f7gM8Cui
         ufQksd8rSokkcQrCRzcPoXZyBTilLMlUGr7qiWGepH4Xp/7mCW7C/Cb3Doqvb8RK9CaR
         300wM+q82YZmAyW0nivvLAdbP2W2AO7UxQHIti7WxSlRvvFIbRlx5cPYaj7UUKctfnU8
         kX49HcwkQckCJWHbFo5FKeBMf8hi4t7zowy/9gzRvMqQjg3CRRpeBpqpmcE7tFsK1xuS
         kNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RIF5CAZ9hTXQxe5JpOeXS1KOLlyZ8DHo3e5ICWJYFAY=;
        b=nbJLPNXFGlqUk+12bESmEBn0yetstvt9oa6riHklY7WjBegDBwJH70vwOCNR/eC0HT
         dyH4qEd+GfKKXcQsKA0vjs7ujUXsHMTB1QiTEohOe2WFHmWfcmhzWG3r+ABBpc7U6gaf
         x5cGd9RHoOplcBzOgd/rfsAtL+EtgdFznRJsSoX8qMsHzZ9tJVezwIRfkxnCFZFVA/gN
         Mt1pq/yBlQGGQpJZyh7HaDOk5u9WtVi2Jcla1qr6zYlbQp9RFCu+27HehuPhVb9LHXJy
         UErDoAyCIwGUAC+OuYD0dC/qhLYVzmAye16MkJtfNQ3T22Gw9MBpq3zuhR3L3UguynLa
         5b7g==
X-Gm-Message-State: AOAM533b8Isf3PDEXLlPpIeLYPAFAO2pCe0n72vt8wWjIS/dpS87z8yh
        IWdZ5e4KXafEmaxJaO49lxKTk079SO4=
X-Google-Smtp-Source: ABdhPJzfLqDSyjhxsdal6OCNEUE3nZ8W8MH/83Gq7TzZzOemiQzczj+7ByUUvwtKpmicQwSld9eX1Q==
X-Received: by 2002:a1c:7219:0:b0:38c:a4f8:484f with SMTP id n25-20020a1c7219000000b0038ca4f8484fmr2537303wmc.99.1648616742893;
        Tue, 29 Mar 2022 22:05:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17-20020adff951000000b00205c1b97ac4sm6690967wrr.20.2022.03.29.22.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:42 -0700 (PDT)
Message-Id: <8cac94598a58704d9b625a9d8a593779f7adc30f.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:25 +0000
Subject: [PATCH v5 07/14] update-index: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The update-index functionality is used internally by 'git stash push' to
setup the internal stashed commit.

This change enables odb-transactions for update-index infrastructure to
speed up adding new objects to the object database by leveraging the
batch fsync functionality.

There is some risk with this change, since under batch fsync, the object
files will be in a tmp-objdir until update-index is complete, so callers
using the --stdin option will not see them until update-index is done.
This risk is mitigated by not keeping an ODB transaction open around
--stdin processing if in --verbose mode. Without --verbose mode,
a caller feeding update-index via --stdin wouldn't know when
update-index adds an object, event without an ODB transaction.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/update-index.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index aafe7eeac2a..50f9063e1c6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -1116,6 +1117,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	 */
 	parse_options_start(&ctx, argc, argv, prefix,
 			    options, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	/*
+	 * Allow the object layer to optimize adding multiple objects in
+	 * a batch.
+	 */
+	begin_odb_transaction();
 	while (ctx.argc) {
 		if (parseopt_state != PARSE_OPT_DONE)
 			parseopt_state = parse_options_step(&ctx, options,
@@ -1167,6 +1174,17 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.version = preferred_index_format;
 	}
 
+	/*
+	 * It is possible, though unlikely, that a caller could use the verbose
+	 * output to synchronize with addition of objects to the object
+	 * database. The current implementation of ODB transactions leaves
+	 * objects invisible while a transaction is active, so end the
+	 * transaction here if verbose output is enabled.
+	 */
+
+	if (verbose)
+		end_odb_transaction();
+
 	if (read_from_stdin) {
 		struct strbuf buf = STRBUF_INIT;
 		struct strbuf unquoted = STRBUF_INIT;
@@ -1190,6 +1208,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	/*
+	 * By now we have added all of the new objects
+	 */
+	if (!verbose)
+		end_odb_transaction();
+
 	if (split_index > 0) {
 		if (git_config_get_split_index() == 0)
 			warning(_("core.splitIndex is set to false; "
-- 
gitgitgadget

