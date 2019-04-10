Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C2E520248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfDJRiA (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:38:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34754 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbfDJRh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:37:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so2814795eds.1
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yWirg5v6fuZl0to3sdCOyFAvFYKD32E8HlXBuqhxkhA=;
        b=qe57E74j7OE0XnqQq/RCsPFH+xnR5bmqe5BSJ2r4n3xFB59OnSuCL49h1/5cSth3W/
         MRz1dRxQVAGVTMFSAdISkjSwFtsUTAy3OWQsaFsBuaArX9JyTttl/udh+3P8FO5FTm5c
         01snClyF7ZUPUMHZz40UC+eqYxkjui/jt8/wgibMMq41tvHnKJVve7Puys9sLrxOw+YR
         E/S9LKANHXb+MZmcbHz4VtxjibV4g7UiAwureKMTJuNW7C6kYuRtzTQhZKzfkDvzuuuq
         h2NCb6dTbfPVXXh8wilhVl6boAzjj4nxreuk0YFvy3/tUqIoq6i9yq/odGd3Qkm1lw7C
         Skeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yWirg5v6fuZl0to3sdCOyFAvFYKD32E8HlXBuqhxkhA=;
        b=Jgth8e2Z9mjNDOMcUCTx3fdZVsBGl9ZF9xCk/ZC83pR3zjRfbWOiRKZ2LGRQ9Yv8TC
         e/F/01OOpmAll6oIcCtT7lW5ucaBrcCEh5qGCdZb5iSU1/0wLjFoD6SUIdTkj4prclKP
         zJkyna6DMGkgZfu1T1kj9nYnNiZ/7jgGqyH2uc0lGHdaJpRV7PSE1tqExplScCjT8ffQ
         OXcGzsZsu4ivNt/04Pe8RPMjSEObaJZb2lxKQdmeTauxSUMNdc3c8eTJn1mzdIxLTEFE
         3XKhWXZho26X6r1frOdkDDbdi+Suj77z8bhuTVRhGos3bL6EfvVAOVCD/9f4E1LeAlhG
         mFzw==
X-Gm-Message-State: APjAAAVAvzqkRTKnaEeZrRTFlWnNmU2PnKARLeCnxDUmJjMU+bbyT8tN
        k7DJvAc5PBAsWkRoz6xpFsFhWR2A
X-Google-Smtp-Source: APXvYqxWte379svjWmbB/Zr9JrNWv48HkgaGWetMaxWkjmBC0+MU383fadU16cwyEDscFS/5aOWQMQ==
X-Received: by 2002:aa7:ce8b:: with SMTP id y11mr13373966edv.149.1554917874677;
        Wed, 10 Apr 2019 10:37:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm436381edi.28.2019.04.10.10.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:54 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:54 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:42 GMT
Message-Id: <f7c8df058c3c84d7c98d64b08fc43b8325b994e6.1554917868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/11] built-in add -i: color the header in the `status`
 command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

For simplicity, we only implemented the `status` command without colors.
This patch starts adding color, matching what the Perl script
`git-add--interactive.perl` does.

Original-Patch-By: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 51 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index d971b58552..79adc58321 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,13 +1,56 @@
 #include "cache.h"
 #include "add-interactive.h"
 #include "config.h"
+#include "color.h"
+#include "config.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "refs.h"
 
+static int use_color = -1;
+
+enum color_add_i {
+	COLOR_HEADER = 0,
+};
+
+static char list_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_BOLD,      /* Header */
+};
+
+static const char *get_add_i_color(enum color_add_i ix)
+{
+	if (want_color(use_color))
+		return list_colors[ix];
+	return "";
+}
+
+static int parse_color_slot(const char *slot)
+{
+	if (!strcasecmp(slot, "header"))
+		return COLOR_HEADER;
+
+	return -1;
+}
+
 int add_i_config(const char *var, const char *value, void *cb)
 {
-	return git_default_config(var, value, cb);
+	const char *name;
+
+	if (!strcmp(var, "color.interactive")) {
+		use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+
+	if (skip_prefix(var, "color.interactive.", &name)) {
+		int slot = parse_color_slot(name);
+		if (slot < 0)
+			return 0;
+		if (!value)
+			return config_error_nonbool(var);
+		return color_parse(value, list_colors[slot]);
+	}
+
+	return git_color_default_config(var, value, cb);
 }
 
 struct item {
@@ -27,8 +70,10 @@ static void list(struct item **list, size_t nr, struct list_options *opts)
 	if (!nr)
 		return;
 
-	if (opts->header)
-		printf("%s\n", opts->header);
+	if (opts->header) {
+		const char *header_color = get_add_i_color(COLOR_HEADER);
+		color_fprintf_ln(stdout, header_color, "%s", opts->header);
+	}
 
 	for (i = 0; i < nr; i++) {
 		opts->print_item(i, list[i], opts->print_item_data);
-- 
gitgitgadget

