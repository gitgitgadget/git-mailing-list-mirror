Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D74C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbiGSSeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbiGSSeC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:34:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD15D0E1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n12so10030850wrc.8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lQm7mXvTWwEQQhstrvWPOyiMvz0zhL33U5US1aO4raQ=;
        b=GuHk+eUYW8vTo1Vp0221TnCW6L4zDKXe48KBYJaYTXLntRE3e+w9LChl8RTi1YYZog
         /+od0xcjyyvJ9RAtKQdUCnmCR3c4CDdfpdDlFAQXqQFh96SuGbw3mub6e/XE/D+pjbN9
         ldmAVm+fa0eQOaW3BhBqPM9WfRUeo0kG1HdZAEamxCnTnhGZV51odP2KvvsLFf7dmKDk
         ZoQk2Q1SOG1Hv/GL09jduvNhuI7TW1LAw71MLPrvN6tVZC/2KayJ/QEDYA49lbXPn0im
         fTCV3uJ0MzLU66gr16DpToVZM5m2VcUNYm+2s/TXiAOh7SpH+5cd35zBEbORTEnppMw/
         qlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lQm7mXvTWwEQQhstrvWPOyiMvz0zhL33U5US1aO4raQ=;
        b=BLemTWE1HvD/9s9xngXlIOdOnA893uFvwAweNNqBi+4Js+8NQWRXH4dujycbbZrLP6
         0l8XAHO6+U0KuhoITQeqTY5A/sLz7IUE5XLUumtltAZErszfbKS4M8ye18xvyOo7ekkQ
         9O9C48RUWHm8MmZOHH2NgcTGyyZYjv6SKjRowQ+yQOW+xwXrYaTeaFGcH3ovNSdiKXkF
         8dJBdcoW1sjhZE7S5+Ah+/F5suUSLztW1UNv+yB+ZqnMrD5coz0uJcEfK7cnEdEdnXZy
         Reu7cEilhqSoVHqYHN8u7ms6BD/ftsajrKkOTKzhV24TJLgoOLCW3z/tgtYO3HYmx8f/
         +U/g==
X-Gm-Message-State: AJIora/pZvsZBCKvs+TTSx7j2spZL0Y/DmZ9m7Q6W2NMBF3VEFLR7929
        KfEnI8kEyv0As7J4TZsnngaUN0AKXo4=
X-Google-Smtp-Source: AGRyM1toDJp5SjmXsnVgk829XDExpb5eSCmM4eJcxRqQv0atDIRrc2dCj8uJp0KhVaARGw10EmtxLQ==
X-Received: by 2002:a05:6000:1888:b0:21d:beeb:785c with SMTP id a8-20020a056000188800b0021dbeeb785cmr26025119wri.34.1658255633712;
        Tue, 19 Jul 2022 11:33:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-20020a1c7914000000b003a2f6367049sm18540393wme.48.2022.07.19.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:33:52 -0700 (PDT)
Message-Id: <4c086d477f08d8e73a59861d34251aa94a26ba13.1658255624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:37 +0000
Subject: [PATCH v5 05/12] sequencer: define array with enum values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The todo_command_info array defines which strings match with which
todo_command enum values. The array is defined in the same order as the
enum values, but if one changed without the other, then we would have
unexpected results.

Make it easier to see changes to the enum and this array by using the
enum values as the indices of the array.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7d131d06cc3..2711182e43f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1708,20 +1708,20 @@ static struct {
 	char c;
 	const char *str;
 } todo_command_info[] = {
-	{ 'p', "pick" },
-	{ 0,   "revert" },
-	{ 'e', "edit" },
-	{ 'r', "reword" },
-	{ 'f', "fixup" },
-	{ 's', "squash" },
-	{ 'x', "exec" },
-	{ 'b', "break" },
-	{ 'l', "label" },
-	{ 't', "reset" },
-	{ 'm', "merge" },
-	{ 0,   "noop" },
-	{ 'd', "drop" },
-	{ 0,   NULL }
+	[TODO_PICK] = { 'p', "pick" },
+	[TODO_REVERT] = { 0,   "revert" },
+	[TODO_EDIT] = { 'e', "edit" },
+	[TODO_REWORD] = { 'r', "reword" },
+	[TODO_FIXUP] = { 'f', "fixup" },
+	[TODO_SQUASH] = { 's', "squash" },
+	[TODO_EXEC] = { 'x', "exec" },
+	[TODO_BREAK] = { 'b', "break" },
+	[TODO_LABEL] = { 'l', "label" },
+	[TODO_RESET] = { 't', "reset" },
+	[TODO_MERGE] = { 'm', "merge" },
+	[TODO_NOOP] = { 0,   "noop" },
+	[TODO_DROP] = { 'd', "drop" },
+	[TODO_COMMENT] = { 0,   NULL },
 };
 
 static const char *command_to_string(const enum todo_command command)
-- 
gitgitgadget

