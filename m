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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D02C207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 00:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979342AbdDYAEp (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 20:04:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32934 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979248AbdDYAEm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 20:04:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id w50so18554575wrc.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SyrjjiQeJZnZIyumF/Cc4L1gE+B/ZprWaQ+ungLBx94=;
        b=Si1EekFx3qO0613nm1UnuNeSYLBQa/Ec5qM60pDYPs8GV+5eYMZFhSoFFOSagpN2zS
         gNh6gQrUjLAldpxTtTPOWVOPgPXkU4av2bg2YzXXB7DVdQk664dp9uYmQsbU3EeV8D/k
         EEcSlEZsBOR543octpQus0a2MFEwoBbhc3cJ9wQCnAI3TVVzix1i3b69/EMFaOlPbWRl
         178ukJEbuz4nvK0meSccpu+i7IZv/y2s6iLRUGkbeOGDaOixJwRBkNvDb5/42nrJJu2u
         s4j3dgyIdjg5d/iYjs3kMrv6DeSeBR+0QtOPwzGR+78pKVoziIo3e+SxXAlDlVDvkg78
         KxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=SyrjjiQeJZnZIyumF/Cc4L1gE+B/ZprWaQ+ungLBx94=;
        b=QXwoglJxklx4Ud5q8r8J5tkCT2Dsa3T8CPX7JSG9YUtxuGQ5SU0GIZYGXkzArLa8N1
         6Dzgt7HLzW2yJUQaCjafztNzHDvIYxos/JuR40D9PVko1HgUOseLQNrIxdp3ZoD4nSFy
         FLqSSEJBnM9AErZ+6udTZO9TU6W8mDRCpaKprUHTQbohgoBNSDm7BEIN9fnh1Bc7p/1P
         5+LkrN4QL+L1w9MMbt6kf0fNTNuW4f3FpGEhbo98NcKYzYP0OXWIcXJXYPamZvR57Vjw
         rLUTVf5RK2rMcxM7Adzl6Yos8o1nka3KZs9P2VV+oyfowGCEz4oxUyIBBr9riQYPbt61
         Cxag==
X-Gm-Message-State: AN3rC/6rMe1t3+eam5RJnSEVdngBvSZqLGgeITKWfE1f5HAiRvlRohlT
        vAVsZNdhtOz2gw==
X-Received: by 10.223.138.250 with SMTP id z55mr617942wrz.50.1493078681417;
        Mon, 24 Apr 2017 17:04:41 -0700 (PDT)
Received: from localhost.localdomain (66.red-88-8-179.dynamicip.rima-tde.net. [88.8.179.66])
        by smtp.gmail.com with ESMTPSA id a5sm1917228wma.28.2017.04.24.17.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 17:04:40 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     git@vger.kernel.org
Cc:     Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH 2/2] fast-export: DIFF_STATUS_RENAMED instead of 'R'
Date:   Tue, 25 Apr 2017 02:04:28 +0200
Message-Id: <1493078668-1354-2-git-send-email-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1493078668-1354-1-git-send-email-miguel.torroja@gmail.com>
References: <1493078668-1354-1-git-send-email-miguel.torroja@gmail.com>
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

