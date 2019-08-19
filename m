Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8351F4B7
	for <e@80x24.org>; Mon, 19 Aug 2019 06:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfHSG0X (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 02:26:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33780 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfHSG0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 02:26:23 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so1789930iog.0
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wW2gjw9I46llkgy5tpWsUTNYT7ORl7TKgWsO50Tz5Gg=;
        b=cdUeaeqkpanHBuMaH3h2sNABtamlnIXpFWJgzxRMiAy1QsXZAhXeK0kPqJYaJ4mOHJ
         GdHwZQI5hZaJFvWO0KtT3eynrF3R94m1SLxxrJo6dgyxYFfThcxtq9tT+dPn08/kAqQV
         +zIUdZPfNt2bbE6ncssigowbPEMAeokK4HqOk7gr1S8xgs76tbx2bnptr4g55uvTV918
         F5HAdhFlHuWhjHBfLBjQfLJjl8k1yrxdXMepueZdQJUSLv9H27sV4AyP9ApvcjWaeS/9
         bDorVBrV1bTB8z4P1ySw1y0SBBJrvgKJdl03s3pwFprLWnMl220EIVLs+0JRUMfIXSon
         n45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wW2gjw9I46llkgy5tpWsUTNYT7ORl7TKgWsO50Tz5Gg=;
        b=EtSE3HOzxzRp8IXyT//ivafJ/rq8Lq8hfDu5U2jE9gaV/uQ6KO+HnQiGSZZvKGGGje
         7KkPANYLSmuHOd54793GbX4dwWUnyV4ZEICSS/zQAbUNtGcftm8wuHyPwaRfV9CEzDU/
         ne4/K1B7V3bZp+/iOZfKNSg5rAZZN7T+5GFocCAk3Tr6s0GNlmqMo05Dj8UnG8x1y7jN
         0eyBMYIXPtwDTrdsHOl6EkdeiTcV/xmWyyZwhwcqIdC22/qP9VagdR+gLbpd+mfCih88
         FprkVxAvxRe4z/3gX8drlHb0xmq4is2Bkuf5Y3n8VemO3ebjmCbF2bfqcupKYCswTY+t
         Wz0w==
X-Gm-Message-State: APjAAAUrEwb8J1SsOqES78OS0gXHP/avcavkIPn+kp/3nQPA3gSC8n+c
        wQBsdxFJ9FfcgzMXbFPtd+MElCqi
X-Google-Smtp-Source: APXvYqxHzHvwwM92E3ALWEc/tlywiPzZzWy7lB9VLflnwvA+MdtIUp3aHrUVkvM1TD1ExDYCasagmQ==
X-Received: by 2002:a5d:9690:: with SMTP id m16mr14043053ion.180.1566195982009;
        Sun, 18 Aug 2019 23:26:22 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id e22sm10704090iog.2.2019.08.18.23.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 23:26:21 -0700 (PDT)
Date:   Mon, 19 Aug 2019 02:26:19 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] packfile.h: drop extern from function declaration
Message-ID: <58862d9d6f4eb1af7ac6a09a703c2ace66917ee3.1566195817.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 336226c259 (packfile.h: drop extern from function declarations,
2019-04-05), `extern` was removed from function declarations because
it's redundant. However, in 8434e85d5f (repack: refactor pack deletion
for future use, 2019-06-10), an `extern` was mistakenly included.

Remove this spurious `extern`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 packfile.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.h b/packfile.h
index 3e98910bdd..fc7904ec81 100644
--- a/packfile.h
+++ b/packfile.h
@@ -100,7 +100,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
  * Does not unlink if 'force_delete' is false and the pack-file is
  * marked as ".keep".
  */
-extern void unlink_pack_path(const char *pack_name, int force_delete);
+void unlink_pack_path(const char *pack_name, int force_delete);
 
 /*
  * Make sure that a pointer access into an mmap'd index file is within bounds,
-- 
2.23.0.248.g3a9dd8fb08

