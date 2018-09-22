Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D541F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIVX7f (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:59:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43435 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeIVX7e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 19:59:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id x24-v6so13555120lfe.10
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUXEU44daxGO9DgBB1x130uWr+j4ehZlHXxck0ZnfgI=;
        b=C4uv4Y6+Yxbl3UBarjgFPCMcbM3FouunzM0lZtbeqnDVYHyRWgmw6nucBuZR2FgGaV
         WGIbvvmJElduKgM6qsDvnkDq72hFoIUPlsH8wNXSh6xOrb8aqR34uNMm1LP22Z68IcrA
         NOqg/W1PqUJAOEZAuUc404nOQ1ITQyktZyxmXGmaaQ3QVtDneRmeFxPcqJkutOlIbk/h
         AxF9SqRZ+QqLaUBJvshriTABl1i1bg8yuDhlzazE/yuoHBdyguLfV/zaOMPbqpF28vxg
         cm9qU24ujc5BJY7vU3RHQVGrDc4SkMJrP8FEFBDf/rpkmpazNp77B51ssBsT808NnF81
         113g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUXEU44daxGO9DgBB1x130uWr+j4ehZlHXxck0ZnfgI=;
        b=Lw7n34cFvVLqwAIO/VyoUwUL5Bq9yeT4g0I1IC8SQDHVYhjmpu8WS8ojx0OHmQSwfB
         yEc0iUlFhUWIczgYXRPR4rKPusMxHnjaZ/G6ja7226XUSbDX3s039vYw2t6J0mStPWlF
         JPccNJzKx6XrG1UVN6SRivTHkXqNB0P/cL/rOnNflrgdkR9vzI1bMUY3tUxkk+1f9YPW
         gKQSsOgIHFoWEUrx8VvvngbF/LKAsfVg+/xxdVCigX4KJddifPvvkZrL3qq0c5aehn2a
         8Vilc/qfT3F8gAl4qrBxjuOddwNkSIdPFuZQlmBEhPKFv9jyvU4PujgkYlgwxafFbDCk
         op9Q==
X-Gm-Message-State: APzg51CYkq6bMBFOhNCOdvh3b/tKFAXrPXUy/E2KbjOUaghLPQJU2Mpp
        ZnpW6mK1pmikszKONFTGZaQ7epee
X-Google-Smtp-Source: ANB0Vda5qMnQHs7tN2N+75mSar/O+qghnhQQTRbn8RIh9WJWVzAW5B+RF7CpDBu4h7ioR/60owDh0g==
X-Received: by 2002:a19:1603:: with SMTP id m3-v6mr1824860lfi.82.1537639507388;
        Sat, 22 Sep 2018 11:05:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2877942lfa.9.2018.09.22.11.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:05:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/8] refs.c: indent with tabs, not spaces
Date:   Sat, 22 Sep 2018 20:04:53 +0200
Message-Id: <20180922180500.4689-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.647.gb9a6049235
In-Reply-To: <20180922180500.4689-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index a7a75b4cc0..9f7268d5fe 100644
--- a/refs.c
+++ b/refs.c
@@ -646,7 +646,7 @@ enum ref_type ref_type(const char *refname)
 		return REF_TYPE_PER_WORKTREE;
 	if (is_pseudoref_syntax(refname))
 		return REF_TYPE_PSEUDOREF;
-       return REF_TYPE_NORMAL;
+	return REF_TYPE_NORMAL;
 }
 
 long get_files_ref_lock_timeout_ms(void)
-- 
2.19.0.647.gb9a6049235

