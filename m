Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C2C1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 23:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfKEXbh (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 18:31:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36438 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKEXbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 18:31:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id w18so23555202wrt.3
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 15:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Doz5ODYM6xicz8CU1w/dc4QiyYHFpPzeo+WEuWmKX8=;
        b=tWWPiGXLHba6qhkb+6Z7/OWWZJDloe85m7OAU02SWrVMWrCYqdyfhyw+iveawyupbR
         H/AZzwlUi33DNrxuX+5MRaM1IAYTiIsst+wJNqnkglOvHtMSgZ7DkRpeTSNVdOpXLR+4
         hV7C0+/s0/5Ae4PDT0mrhGs3bJRwkWDJMjG0zQlHnRRDjNwogmO9Vt/+sQXmQZbA/8EB
         4UwPOJoxuUiSHnxwWSe3HBWFkNyq8nefJCqzFGPG82ZI47rFekLkvQHl6VYr8sjNPoiy
         5kE1UyCMME2zjNi8gu0GFZfy/KCUClppJA/6zjE7GxnWg4YIGFqPbJUJqIFmxitErVse
         zkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5Doz5ODYM6xicz8CU1w/dc4QiyYHFpPzeo+WEuWmKX8=;
        b=E+1iWPfPkwez4snZWukHXVlEwU+2Rsm6PLhzSjkts7doRnOK757jd5+BCILtxkqdBS
         4oItkUzvPQDntKeg3toVYxs6+F5mkNqBeVZIUvKKs504tVrUhQJiwyfKDT9CIsrhZq93
         +u3e6eCqSUsyqTLNlQxfjDtnNbJpTWJ7ufxvBkJcEsUf6iDFpeXVZetjTplnctp/GoR4
         EYFjmRdfL9TgdO+JXcfsZbjiaAYAC5UuL7ZeVpsneky31JPwYfToW0LylQScUEf1q/RI
         9IDPxvrEn9fsrKa9ZzfUdO+uLF3cOdatcz5QoPDYAPl8Y6Cw15K3H3ZxZhtPHPq6Km5L
         YRGg==
X-Gm-Message-State: APjAAAUSDXxu0bXbrx/vq3OsQXHrxtoqvexx0+zN1DFSBYhvdruOh3eU
        hs7pUqiSsbxG1jNu6GJFQ4UcHiCm
X-Google-Smtp-Source: APXvYqzUtt1gWoSv3jnGUqE87JpEsy3cRmVjWigsu/evmkkJyd9KdJyVMSzv/J2EWhUkdyrl+fyXaA==
X-Received: by 2002:adf:de86:: with SMTP id w6mr30212049wrl.220.1572996695115;
        Tue, 05 Nov 2019 15:31:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5sm21225806wrl.86.2019.11.05.15.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:31:34 -0800 (PST)
Message-Id: <f7503d644c2baa9f5b8a71c998741f8232385508.1572996692.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.454.git.1572996692.gitgitgadget@gmail.com>
References: <pull.454.git.1572996692.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 23:31:32 +0000
Subject: [PATCH 3/3] name-hash.c: remove duplicate word in comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 name-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/name-hash.c b/name-hash.c
index ceb1d7bd6f..4885bae5da 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -218,7 +218,7 @@ static int lookup_lazy_params(struct index_state *istate)
  * However, the hashmap is going to put items into bucket
  * chains based on their hash values.  Use that to create n
  * mutexes and lock on mutex[bucket(hash) % n].  This will
- * decrease the collision rate by (hopefully) by a factor of n.
+ * decrease the collision rate by (hopefully) a factor of n.
  */
 static void init_dir_mutex(void)
 {
-- 
gitgitgadget
