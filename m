Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9980A2018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbcHIEIb (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:08:31 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34871 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbcHIEI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:08:26 -0400
Received: by mail-pf0-f181.google.com with SMTP id x72so673609pfd.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:08:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6+uEAmcCGSrxwb6sihpziRYyv6ecMYO53CKFrUaXFJ4=;
        b=NZ/KG6IqHo4NSlgM6ti/ChWqJH5ai4KlZ4C5krM0mnq9dfdmFCyqNTJ8LXswEF+I9N
         mKICoY11fPqcrAkSNzHafeNsCRakreVtTPdsAUa4j5SXBP8reTu+GrMrPRs2TGyEU86b
         LmfNXh/chzQH/9f87X8XszP8z7dEWtYQlP+b/AiL1t12qGySml4PSnvL7YCjVXRb2XTb
         wFgpuq3U2XMQiRDr/l4N5AZ5orTd373nYQFp4p6ul6mEX/QWK8+CGdwKPnbQv/+ioDG4
         jqXyLhn/qlgnmvNXrcw0NkFiDW4D1CuCbm08MXuYopb3hc/jXcYfNggse8bPfSoXChzV
         tvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6+uEAmcCGSrxwb6sihpziRYyv6ecMYO53CKFrUaXFJ4=;
        b=LADeTwnHlUM3MK9h3e+FKKYsMFWESHSFyM1npjvYC9bgF7laEqK/z38lJFW/6n1faY
         hftcYhh0/1K5gz7dTzpXunczKy9nv9sfIgpMSO5z7XbAl2sF+efHeTWxKLqBZ49q5L1D
         IP+XTWeFD4D6i+dL30iL5zqAjxhDBrZtkPsx3qqZeIliD2SUdpA+39iufhkgF0fP/X/q
         YtItZWQ/3kazQpzlYD39v+V9qKhCJL52qRS97rTGE9yoJuLeU6BFPrGF+RuL2tqHgu75
         hiyr93ytXRn/ieHqin+FP0COhofhpdUeAY8RaPt1z0kCWbIMLasbC+ABKW+C0DIKGJne
         2tLA==
X-Gm-Message-State: AEkoouv1gpmMVTJwugmE58/NhatcC6GBJl7wby9XTuSXR4/DiJLK6bgHPdU89OuRDTHJHWW7
X-Received: by 10.98.93.25 with SMTP id r25mr168133679pfb.122.1470715705747;
        Mon, 08 Aug 2016 21:08:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id vt10sm51613366pab.43.2016.08.08.21.08.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:25 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 5/9] clone: clarify option_reference as required
Date:	Mon,  8 Aug 2016 21:08:05 -0700
Message-Id: <20160809040811.21408-6-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the next patch we introduce optional references; To better distinguish
between optional and required references we rename the variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/clone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f044a8c..052a769 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,7 +50,7 @@ static int option_verbosity;
 static int option_progress = -1;
 static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
-static struct string_list option_reference = STRING_LIST_INIT_NODUP;
+static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 
@@ -79,7 +79,7 @@ static struct option builtin_clone_options[] = {
 		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
 		   N_("directory from which templates will be used")),
-	OPT_STRING_LIST(0, "reference", &option_reference, N_("repo"),
+	OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
 			N_("reference repository")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
 		 N_("use --reference only while cloning")),
@@ -325,7 +325,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 
 static void setup_reference(void)
 {
-	for_each_string_list(&option_reference, add_one_reference, NULL);
+	for_each_string_list(&option_required_reference, add_one_reference, NULL);
 }
 
 static void copy_alternates(struct strbuf *src, struct strbuf *dst,
@@ -977,7 +977,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
-	if (option_reference.nr)
+	if (option_required_reference.nr)
 		setup_reference();
 
 	fetch_pattern = value.buf;
-- 
2.9.2.583.gd6329be.dirty

