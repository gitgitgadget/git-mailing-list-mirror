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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9FB207E2
	for <e@80x24.org>; Mon, 24 Apr 2017 23:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979101AbdDXXEp (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 19:04:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33720 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S978909AbdDXXEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 19:04:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so9988775wmh.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 16:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SyrjjiQeJZnZIyumF/Cc4L1gE+B/ZprWaQ+ungLBx94=;
        b=h9kHcULadHbm+vsQEnX+qJtj9DtVZT0yZMXr1HyvthImgIr7fG28y6pfpbL5fv91TH
         dfIumTEMhWV36FPdU2nqeobtsapUPfWRYhifWuW1u6KNUPR72jbOsIuwcAvQ5os8DpE1
         M1trttdPBLWWCVWe5ohBbsqId1dgnkG0h5LxR8NnUoy311oqW0s5GPxPB7FsBKMMuIvk
         fwVsQx5U3f/78zGCwXCekzoHDE1renH9n6gq/cUU23W+DD7tVNc0gebrGg1fNFwMZBw5
         /QqCFpZ+nEAqTmAC+g5PGvHol1W/eGxubAQMb0H6mUKvg9wCJ02ZvMAE2tW+/IKFW3MK
         eAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=SyrjjiQeJZnZIyumF/Cc4L1gE+B/ZprWaQ+ungLBx94=;
        b=jTL+WYKmOPGbVBh3FKDd/UnxDWGCUrbeyKFxxE0Aw3qoGnoRNWA5NYUKMjHo/IcGWp
         l0L3ZFGrnVeeIF4X8ashQPYo+XTjcwv2YzhYFTu6NBj4Og7L4rgphEK5PSHITD24+JFF
         6XpxD9aUSaPKT2VodBe2k2vKVPUmPwAXXzmqovGc4wmY4yTnhGkaIMtkNLOJE2uv9nV3
         8PmAx2Ju4ZiJ2Nte3IbfXgIRXiEUNw74/sFVlNBK/YqlO2cGOY4WJfEQNmzeYQ/kJXKR
         Od2FAd3+FGUDN7DXtnJnXLHHaUXUt+lqnEwZkUxt+FJX3QZ8ogMvyUHALBh73+HCvL5D
         8X5Q==
X-Gm-Message-State: AN3rC/7cA3k7ss3gxEYkwq6LSfLVa+KptzlcLteya2GOzloeiOH39ryR
        UrWSosby5X/eogGXYhU=
X-Received: by 10.28.213.132 with SMTP id m126mr42701wmg.28.1493075082031;
        Mon, 24 Apr 2017 16:04:42 -0700 (PDT)
Received: from berenguela.telefonica.net (152.red-95-120-155.dynamicip.rima-tde.net. [95.120.155.152])
        by smtp.gmail.com with ESMTPSA id s27sm23920525wra.25.2017.04.24.16.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 16:04:41 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     git@vger.kernel.org
Cc:     Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH 2/2] fast-export: DIFF_STATUS_RENAMED instead of 'R'
Date:   Tue, 25 Apr 2017 01:04:08 +0200
Message-Id: <1493075048-6665-2-git-send-email-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1493075048-6665-1-git-send-email-miguel.torroja@gmail.com>
References: <1493075048-6665-1-git-send-email-miguel.torroja@gmail.com>
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

