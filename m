Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580C51F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbfBFRQV (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:16:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32794 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731572AbfBFRQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:16:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id t3so1702139edq.0
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K7XMEqacsNErwgjvmp6bzVQzRfa2GXAzEYSNV9LuXmU=;
        b=D5lCXPyqgMqUQDd/OqcnYzDylRu0f9PIY7BAPYx1NSoe98Q04x1Oz7K5Fvhs8YCsjL
         OO6GDYC7qdH3OMX+BGYYSlpoKY+0cg61PtVblYMkJb3kZ60XNzBwcY9VVPI1nXA5AQLA
         3KE2sW4xnDB5FC5ABI9Ghp+9sHKisD+wcJWGXOIRJ2P0oKJ4lkYENtgKjlsLGVnfvXDk
         64+yHEjJifgtI20iYIRuWM5FBsbcfCx0/w+gacEWjR+mMJqxIBCXvZHhsb7KmJ7Rag8T
         XFg2Td444/kKLkPjCs91JEp+uOVCgfNlckaXpd7PPyjuvhWmNdq4YfAVARbT1HwmhVSa
         wUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K7XMEqacsNErwgjvmp6bzVQzRfa2GXAzEYSNV9LuXmU=;
        b=LBT8FrJndDxGUcdG5jOI1WTmBoA9TrgjyCHDnUFq9mupTU4jz2dClRlzHpCz8fkG1f
         XhpYI2s0rQAW9pmTpNGhxy8KO19NMvbQLq+KyuTQYosfI+ayocxjn+zN+PUV+AHKgHD5
         COVXAlvGqwG13tsHdOiGxCQxVxTA2rX/o3vz2Ffb2KNR6TJV+vESEGyQMhpJm4oCRron
         ci+Z2/k8DGxJpNmok4QmgluQJ+bgeY709G82P/sPpaXNXOgIa4kxpEZagffMQwcznu2T
         7B7a6rSZXGQzoXlJ2p/6qiS/ZurcWsJqpibTmU7dMfAAJwRLvk75W8grmOT56ba7sLQS
         58Cg==
X-Gm-Message-State: AHQUAuabb0es2QVnLdgDTs1qn5nyE56Sb0CR6a3RCGVExQxincCDyndV
        tJuNYRW4wYC7pnnqCIIuwWQ/Y5Q4
X-Google-Smtp-Source: AHgI3IaOX5dmlUpLHauq57l61VBvUzL3wXdCQW73LseCxei284Di9pGfeIXyhqD06o/teibTJDbF7Q==
X-Received: by 2002:a17:906:6b03:: with SMTP id q3mr2571078ejr.66.1549473361992;
        Wed, 06 Feb 2019 09:16:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f38sm1307849edd.97.2019.02.06.09.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:16:01 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:16:01 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:45 GMT
Message-Id: <68269ee0609b162b9d585d8b1792fa5145224b69.1549473350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 10/15] trace2:data: pack-objects: add trace2 regions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When studying the performance of 'git push' we would like to know
how much time is spent at various parts of the command. One area
that could cause performance trouble is 'git pack-objects'.

Add trace2 regions around the three main actions taken in this
command:

1. Enumerate objects.
2. Prepare pack.
3. Write pack-file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/pack-objects.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0a70d04604..8a64c2868e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -33,6 +33,7 @@
 #include "object-store.h"
 #include "dir.h"
 #include "midx.h"
+#include "trace2.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
@@ -3472,6 +3473,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	trace2_region_enter("pack-objects", "enumerate-objects",
+			    the_repository);
 	prepare_packing_data(the_repository, &to_pack);
 
 	if (progress)
@@ -3486,12 +3489,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (include_tag && nr_result)
 		for_each_ref(add_ref_tag, NULL);
 	stop_progress(&progress_state);
+	trace2_region_leave("pack-objects", "enumerate-objects",
+			    the_repository);
 
 	if (non_empty && !nr_result)
 		return 0;
-	if (nr_result)
+	if (nr_result) {
+		trace2_region_enter("pack-objects", "prepare-pack",
+				    the_repository);
 		prepare_pack(window, depth);
+		trace2_region_leave("pack-objects", "prepare-pack",
+				    the_repository);
+	}
+
+	trace2_region_enter("pack-objects", "write-pack-file", the_repository);
 	write_pack_file();
+	trace2_region_leave("pack-objects", "write-pack-file", the_repository);
+
 	if (progress)
 		fprintf_ln(stderr,
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
-- 
gitgitgadget

