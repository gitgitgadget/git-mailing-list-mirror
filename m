Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4039C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiC2Aoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiC2AoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC66B23B3DF
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so22608316wru.4
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RIF5CAZ9hTXQxe5JpOeXS1KOLlyZ8DHo3e5ICWJYFAY=;
        b=SwKrIF7ivZ2WCsReI+7WW3ylyxjAMLg5sa38NjXxy3NJG+mUa00pT2dkjYcKx4+zum
         vzfWX6rh01ktgwIdp3ZLzmZdhy3TTSG5ioJDuMZDYgd0v6UFxJsriXeat/AeYNRK5DE7
         9QIkbW6PyYvK+VVD+rN3aaRjy/UXhp36a15j8P4l7MbjwcVsvRbz9HdPU4eRWMkyT3Um
         Xldoeejw281S/kyganuKm9QIBdPJrV63qAOaciv+fu3SfnGKnMsqZcRa9y0hrBxMoe13
         1ZxUNp2T3WX4bLzWIYQrDGmcueVzp2S0RPqze5RdeJTCeaDkHLeFWgb/5vWj/1vgZSgw
         YOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RIF5CAZ9hTXQxe5JpOeXS1KOLlyZ8DHo3e5ICWJYFAY=;
        b=58cPv4Un2MDBsppuZnt8ZFCW+xtqjTTAlwwKOx+n38ibNvBoKY9BngPJdUA3lmuV0U
         m2S3f6ZyKMnbZtEAUzt26RAyiCvbM5LElFKYcVsARFNurFuxmt/zhcQ/9R2EZ8QwpU0p
         VPQnf7Yky528uULR+JapkTVCWBLRAy70FDMJQbApHi392r+e4IFyWS3ZiJN9EWPhIzh3
         ZCsE4t+VH5bnCmOUBvxwoXKfzwECaquhcvEq/37F/ab29uZLrwyXGKFd8REWgA+gwSsk
         6+JzPjXKxxGx61yX7qavkXRS5VMm2b/BBX/GeM1gjEwizIu4J/f9TqBYBr1RgesEX6W3
         /FSw==
X-Gm-Message-State: AOAM53137FMSq63U5r5ZqRWE5/TlHeTmXPNAkV+s034C1aDE9UIPe3EJ
        jDAJscQuomGJ/GPbDnv8a8KrRw+cMhA=
X-Google-Smtp-Source: ABdhPJwlVWPg8cNK5okeAiXS6+0kR/T2P3ebs7SOeS8SsWEdC238SuV/4JVge+j7YxNSKCpp02+DIw==
X-Received: by 2002:a5d:4ad2:0:b0:203:d56d:9c82 with SMTP id y18-20020a5d4ad2000000b00203d56d9c82mr27526959wrs.307.1648514560069;
        Mon, 28 Mar 2022 17:42:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b0038c8fdc93d6sm710513wmc.28.2022.03.28.17.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:39 -0700 (PDT)
Message-Id: <f03ebee695a5c21240d35aa5af12349e44931dff.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:23 +0000
Subject: [PATCH v4 06/13] update-index: use the bulk-checkin infrastructure
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

