Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA061F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeEMFwW (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:22 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32939 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEMFwU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:20 -0400
Received: by mail-lf0-f67.google.com with SMTP id h9-v6so12381131lfi.0
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aiSGRsz7NqNkbrM2uicsYl/yITIdcJlwsBWN+hKXmlA=;
        b=Q+iRbwjKrBeXpFpdCSJARslslopTPCnj9xXDEHKaFHKOozFgztkPXy8siend2l8y89
         3sGRALysl2W9HRsFbAFjurIhBm6EzKVsshNi8s0HLAydy6qbNHJGh+QdtyF5rdhnbAde
         /kBsNVZn4KuVbr2Fd+RFlhSujEYVzFYKp2s2ImI21BHUVX4nkX/mV9DdffCZcE3/eh7V
         zCr1lYFymiMR47j3Cz+wfc7ps545NekUxdym4q+Qe3ekrTTM8+Q1Py9/M0rBKktYP+5G
         YYTHduCESLL1wmVEr0aiuorN7F72wVigSk1rK0NbZ69HeB9jSYn7+k9dlhBN+7UiK+To
         M7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiSGRsz7NqNkbrM2uicsYl/yITIdcJlwsBWN+hKXmlA=;
        b=tVWxFjGtf1M5Av+333LVK+rL1qo4HP0nz7UOsb9H6ydvZhfj1OHF2ZebV2Fssv5i6b
         Oa0hz5dYIVC9g4IjbXXene1wUDatXIUYNVn6tdvAPDIa3TFKRBofNysq/VPSMiAoN/iJ
         69I1ihxxddLijmYT7Mv0X6ImqepkB+goYagQAgkn/Nkb5ZwrNsdjcmWOlhXrtzdVqpfX
         z9QO9tnXQCXcnlDgaAbgAHz5IlhS1aUg01frAGtetx2RB6Q803uOmA1buthToqsh3AF0
         U8GrNXK6WRqSJwxNvPehkt7sN0gf96G8WNEdbxQhBImdItofMCB75okK71ouKSa8OXzd
         j1Kw==
X-Gm-Message-State: ALKqPwf6gKKWGCCEzY3lNEGBEwWB/YR+ARxs7q2A/+Z92syGsgVwTD9Y
        IyJHfS0Ss88k2yf+DU4AXNzjkg==
X-Google-Smtp-Source: AB8JxZrvCczrzHhMgz8ExEKKi7fhijhz3R8SCOArGGbPWQiWg0T4sf8ggh00A4e+nmKpYGBJjfg0NA==
X-Received: by 2002:a2e:7c02:: with SMTP id x2-v6mr2058090ljc.96.1526190738732;
        Sat, 12 May 2018 22:52:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/14] describe: use commit-slab for commit names instead of commit->util
Date:   Sun, 13 May 2018 07:51:58 +0200
Message-Id: <20180513055208.17952-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513055208.17952-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/describe.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b5afc45846..1b6ca42553 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -15,9 +15,12 @@
 #include "run-command.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "commit-slab.h"
 
 #define MAX_TAGS	(FLAG_BITS - 1)
 
+define_commit_slab(commit_names, struct commit_name *);
+
 static const char * const describe_usage[] = {
 	N_("git describe [<options>] [<commit-ish>...]"),
 	N_("git describe [<options>] --dirty"),
@@ -37,6 +40,7 @@ static struct string_list patterns = STRING_LIST_INIT_NODUP;
 static struct string_list exclude_patterns = STRING_LIST_INIT_NODUP;
 static int always;
 static const char *suffix, *dirty, *broken;
+static struct commit_names commit_names;
 
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
@@ -321,11 +325,14 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	if (!have_util) {
 		struct hashmap_iter iter;
 		struct commit *c;
-		struct commit_name *n = hashmap_iter_first(&names, &iter);
+		struct commit_name *n;
+
+		init_commit_names(&commit_names);
+		n = hashmap_iter_first(&names, &iter);
 		for (; n; n = hashmap_iter_next(&iter)) {
 			c = lookup_commit_reference_gently(&n->peeled, 1);
 			if (c)
-				c->util = n;
+				*commit_names_at(&commit_names, c) = n;
 		}
 		have_util = 1;
 	}
@@ -336,8 +343,11 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	while (list) {
 		struct commit *c = pop_commit(&list);
 		struct commit_list *parents = c->parents;
+		struct commit_name **slot;
+
 		seen_commits++;
-		n = c->util;
+		slot = commit_names_peek(&commit_names, c);
+		n = slot ? *slot : NULL;
 		if (n) {
 			if (!tags && !all && n->prio < 2) {
 				unannotated_cnt++;
-- 
2.17.0.705.g3525833791

