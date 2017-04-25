Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE266207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 00:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979440AbdDYAM3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 20:12:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33808 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979435AbdDYAMY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 20:12:24 -0400
Received: by mail-wr0-f196.google.com with SMTP id 6so8871862wrb.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 17:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SyrjjiQeJZnZIyumF/Cc4L1gE+B/ZprWaQ+ungLBx94=;
        b=OgC4rVeAwYuid6ngjYGx6SObGY4SFqWaRi0wS0OA/q/f4ZQZ7jz5MHqkUE8BLbH8sH
         48/IyirjcbVw3JccJFU69tXHBGZjmntLKzj6hmH1RGv7FKI2cxRflYBTiEqi55XzHWb8
         j6SHYCshaN5udIgMcfRgjbvbRqGnAxbxSwSRN1LLSmGPVk+gbkJ9SGAgQx5SXHA84cQK
         PGkVaTJcvtJCNzccVdAuQTuPUqwREhpiFwxPgXTpzTgXnmV2gRrH5IKR3lTKBiLAEcef
         5+EX6zMTq227v1u9555xRE3ZBDAqXUXH61X1RRWgqAFJXkDNwHnOB0G/DIJ9z9IXcXhf
         J6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=SyrjjiQeJZnZIyumF/Cc4L1gE+B/ZprWaQ+ungLBx94=;
        b=P3kdeBCXrFH7uoJ3chHUm88Zm/H1IWUIFq8z4ZTOK0e1jTkk6LGddzpWPoLidkKi31
         rwz5ezUUcHMzhuriJbBBxLn8+ZqBNhSxASWPiuMS+zym4Z2QsXZzJdC6yWBpuJHDlvvp
         ELYHbSlQPTcx9JUN74BG1ZJubtF8g9c69gZBaZRfEw3J8r1sPgej+WVB6qtRBwbdySze
         AsE9gkVoHLSzdzQqEsJ7IBgl9ua+msmpEB9MHA6CmVGMBhA+pESDdVGr0bs1bpq6GZeZ
         0vTmpaWDKhvCXL88LdNlaB5se+7nZyG+rm6nVshr3h3UBeKZ0aOHMLkM4RRDISoAc1b/
         nYsw==
X-Gm-Message-State: AN3rC/5DCIMAon/cSnWLWjdEIh3dJ5ZQ0bK8BccfucyaoPMzHAOgN5dp
        NceCKcSYSjBjqg==
X-Received: by 10.223.150.18 with SMTP id b18mr7592084wra.98.1493079143392;
        Mon, 24 Apr 2017 17:12:23 -0700 (PDT)
Received: from localhost.localdomain (66.red-88-8-179.dynamicip.rima-tde.net. [88.8.179.66])
        by smtp.gmail.com with ESMTPSA id y190sm1007142wmy.15.2017.04.24.17.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 17:12:22 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     git@vger.kernel.org
Cc:     Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH 2/2] fast-export: DIFF_STATUS_RENAMED instead of 'R'
Date:   Tue, 25 Apr 2017 02:12:17 +0200
Message-Id: <1493079137-1838-2-git-send-email-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1493079137-1838-1-git-send-email-miguel.torroja@gmail.com>
References: <1493079137-1838-1-git-send-email-miguel.torroja@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minor change to be consistent with the rest of the fast-export code.
DIFF_STATUS_RENAMED is defined as 'R'.

Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a3ab7da..4d39324 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -280,7 +280,7 @@ static int diff_type_cmp(const void *a_, const void *b_)
 	 * appear in the output before it is renamed (e.g., when a file
 	 * was copied and renamed in the same commit).
 	 */
-	return (a->status == 'R') - (b->status == 'R');
+	return (a->status == DIFF_STATUS_RENAMED) - (b->status == DIFF_STATUS_RENAMED);
 }
 
 static void print_path_1(const char *path)
-- 
2.1.4

