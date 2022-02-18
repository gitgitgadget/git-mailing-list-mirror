Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C4C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiBRSXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:23:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiBRSXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:23:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5616D48E6B
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:23:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i14so15923623wrc.10
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ielkz8QHotBtE/FrvWE7acgciQk61gjydC4noInf6m0=;
        b=BjCubyFVFk9cVSoRY2gnLGSx2FAYLJxZd/kC5XrK94ynKiLpg3iALMA0BWsg8QhyAu
         S1lYh0/vvdRgX98FWQJzwKzNai2obkvfokyza/Jl4CcMy6BPYNIMv9AQ7WMIORYZJakB
         +/UdvHjy3XCyoD/ZzGl6Ef7j9TnB9iIQbplW/Ih0PNtOOBCO89rrnMVYYaILLQeMdIRr
         MrtWzIV+4pN8pFwQGeLCJQqt83vICS2f0p+1cidYBCokdExwTKJe9JKcYwKPQpSzyDL6
         Qc+tjqMuYZi3Epg2f+V8ig3alIPOMQP/grbDGtrISLrepA6MtGGw56AXoL6/nqYnXDbn
         bkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ielkz8QHotBtE/FrvWE7acgciQk61gjydC4noInf6m0=;
        b=LSR6nW4Aofh2gu+jezCf/JkfV9oFY+k/eoL2n5vCQM34PmnnxlFBp4lYs0NxxriNLN
         O3DZvaCOfjWAbsuHZC7W5Y3fokOZoV41ed8iKInf8vEiUCk9aJEMZtmBG/ZD6TYz3AdX
         W3MqlaJUR5qs8iRMIzdcadflIywojGGbSbIZQgbiWu4pvnhCL4GEq2xn4NHfvLgfzvaK
         rIbHWcaPHK/ogvbVwb6U3mdiqqRe5G+f2C34eOXikLQymyJetl6NfK1jo0SoaV8uYpL6
         KQGNJ4PjHJDNcijhE72xpkumwFGC4t5ZE8M4v3XMpIoza9669AdC2qiBu4oZoQdUD75H
         cG5Q==
X-Gm-Message-State: AOAM533CYAupIg2nsDIDOzyC30tO7gdwqGwl0AXKyo8LxeNPVrfBVq4Q
        xcFbZVfeSLg5b8tqrqKC8WgCBZ5YhXQ=
X-Google-Smtp-Source: ABdhPJxQYUz7bGGR1byFbEMpBbePCFaqk3tKuJkJlEi44ZEbAmQBfOYLOtLziGSZpifi56zmkYPhJw==
X-Received: by 2002:adf:e951:0:b0:1e6:85e6:65d9 with SMTP id m17-20020adfe951000000b001e685e665d9mr6783027wrn.412.1645208597702;
        Fri, 18 Feb 2022 10:23:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 129-20020a1c0287000000b0037bc55c8fabsm166325wmc.12.2022.02.18.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:23:17 -0800 (PST)
Message-Id: <12084a335cb9128db5d122dea9f74edc86b64595.1645208594.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
References: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
        <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 18:23:12 +0000
Subject: [PATCH v10 2/4] cat-file: introduce batch_mode enum to replace
 print_contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

A future patch introduces a new --batch-command flag. Including --batch
and --batch-check, we will have a total of three batch modes. print_contents
is the only boolean on the batch_options sturct used to distinguish
between the different modes. This makes the code harder to read.

To reduce potential confusion, replace print_contents with an enum to
help readability and clarity.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/cat-file.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5f015e71096..5e38af82af1 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,10 +17,15 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 
+enum batch_mode {
+	BATCH_MODE_CONTENTS,
+	BATCH_MODE_INFO,
+};
+
 struct batch_options {
 	int enabled;
 	int follow_symlinks;
-	int print_contents;
+	enum batch_mode batch_mode;
 	int buffer_output;
 	int all_objects;
 	int unordered;
@@ -386,7 +391,7 @@ static void batch_object_write(const char *obj_name,
 	strbuf_addch(scratch, '\n');
 	batch_write(opt, scratch->buf, scratch->len);
 
-	if (opt->print_contents) {
+	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
@@ -536,7 +541,7 @@ static int batch_objects(struct batch_options *opt)
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
 	 */
-	if (opt->print_contents)
+	if (opt->batch_mode == BATCH_MODE_CONTENTS)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
@@ -635,7 +640,14 @@ static int batch_option_callback(const struct option *opt,
 	}
 
 	bo->enabled = 1;
-	bo->print_contents = !strcmp(opt->long_name, "batch");
+
+	if (!strcmp(opt->long_name, "batch"))
+		bo->batch_mode = BATCH_MODE_CONTENTS;
+	else if (!strcmp(opt->long_name, "batch-check"))
+		bo->batch_mode = BATCH_MODE_INFO;
+	else
+		BUG("%s given to batch-option-callback", opt->long_name);
+
 	bo->format = arg;
 
 	return 0;
-- 
gitgitgadget

