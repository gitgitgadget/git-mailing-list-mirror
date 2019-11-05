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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B27A1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 23:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfKEXbj (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 18:31:39 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38645 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfKEXbh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 18:31:37 -0500
Received: by mail-wr1-f52.google.com with SMTP id j15so2875380wrw.5
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 15:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jr/Lv7p2nzXRsPIogcspXT268ulF93Rcfgq7ZjnFyPk=;
        b=aCaW6uAZxxXunVkHLb/ThhO5hM95BVhB0vcD3c8pRbTkQdYCbr0e2YxdNvbptzjJS4
         nq37pjE0hyYRb4zl6x6TMEQVG+fh0eJzK1Fjae88KRy1Xk9wCCeVy7BLcMAkmhdr60ro
         FwTDzdE2olQ4ccHTMEYJ7wPXTtarfZBDjqDPMbYehelkkvt6En2PMknaEklq6yi++Sx6
         UZEuJXQ2yrzYQzTKEcqF1UxNlb1heKFN94SpXwCafiB+MmAE6owUAtijBejh6e2eKXFK
         A0bq4qfE+n7tIjj/wLztyy57C3qfUkmilPHt3dnj4g/fl8MJciWCQIuUO2NsrrIm/NvC
         7s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jr/Lv7p2nzXRsPIogcspXT268ulF93Rcfgq7ZjnFyPk=;
        b=Yy1WlbVvfXs9EMKMQ0OIlKtpHRi0+9WDmEk8uJ0GMhXbmEXl6egVMUG2OsOnHIgnmm
         JBg143uSamszfXcNCXmfNTaD3GLU9zODHtmiKl0gjhuzTxu2AYjo2tTXRTDBgR+VJen1
         wSQpnXbR9he+j+Hspd5Jt3smdHj6b+HwnYRAb7V8+IotT5sMZDI6p1ENKQ2TNbHPFG3E
         dythdL4uh84OVo9k8WXAXRDE1t6DGXZwi3WlxRIzQcf5oxMQit/rJ1ACwDWC9/U6AR2u
         Ewt31cBLl6mDvXUuEeqcxew1UBtd8L2BJ16GGFuQG2qFZ0A7XBCFyNQU15kMOmEhaHY6
         wCeg==
X-Gm-Message-State: APjAAAUk/zIuK5JjyEZ31XvynZTf4DFxlfOMtbZM8oRLhAxT62RArps7
        N4q+yX6xUpk8h78G0JrbJv8p0Tco
X-Google-Smtp-Source: APXvYqz6iEqNft8U2lIs1dt4VzHgMLB1SibQ5TzyZmeXEUGnea9QJiA6940Ct7pYhWaBK2tbSnPudA==
X-Received: by 2002:adf:e488:: with SMTP id i8mr29816486wrm.302.1572996694537;
        Tue, 05 Nov 2019 15:31:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1sm17692619wrp.56.2019.11.05.15.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:31:34 -0800 (PST)
Message-Id: <ebf6c7a8120438466e0a679d3066ac1d1525bf76.1572996692.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.454.git.1572996692.gitgitgadget@gmail.com>
References: <pull.454.git.1572996692.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 23:31:31 +0000
Subject: [PATCH 2/3] hashmap: fix documentation misuses of -> versus .
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
 hashmap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hashmap.h b/hashmap.h
index bd2701549f..6036069c23 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -59,7 +59,7 @@
  *
  *         if (!strcmp("print_all_by_key", action)) {
  *             struct long2string k, *e;
- *             hashmap_entry_init(&k->ent, memhash(&key, sizeof(long)));
+ *             hashmap_entry_init(&k.ent, memhash(&key, sizeof(long)));
  *             k.key = key;
  *
  *             flags &= ~COMPARE_VALUE;
@@ -87,12 +87,12 @@
  *
  *         if (!strcmp("has_exact_match_no_heap_alloc", action)) {
  *             struct long2string k;
- *             hashmap_entry_init(&k->ent, memhash(&key, sizeof(long)));
+ *             hashmap_entry_init(&k.ent, memhash(&key, sizeof(long)));
  *             k.key = key;
  *
  *             flags |= COMPARE_VALUE;
  *             printf("%sfound\n",
- *                    hashmap_get(&map, &k->ent, value) ? "" : "not ");
+ *                    hashmap_get(&map, &k.ent, value) ? "" : "not ");
  *         }
  *
  *         if (!strcmp("end", action)) {
-- 
gitgitgadget

