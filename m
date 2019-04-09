Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74EB820305
	for <e@80x24.org>; Tue,  9 Apr 2019 10:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDIKlZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 06:41:25 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38710 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIKlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 06:41:25 -0400
Received: by mail-ed1-f51.google.com with SMTP id d13so4458982edr.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7gN9nsFoWqXbe1R3feDEMax2/wjhV5m+ypVTmLEALRc=;
        b=aIKsyNRxif4Usa43aSacW1fzLbVvmubC7usUKqIudqyfX4b4hP8xq8sE2NKyzM9z35
         dlGJofualeZs2WkLvQ5FpcJ37CZqhGRkqsg85uwp7wlyXDZoDYE8mc9B082Y1lWRXvBK
         9GzF3v3kJ2CderbIYvxJSMN/kMxRRmzoMiWLnZe/UADA+E4rSD5O5ljeKH6etH1K6qsn
         /JJbTDNAiDwA2PG+X+/+2T5Gdojwr4FcBnqJ3ZALx8OorTsJ58PyaLBJyZVCX309Px2S
         3qSx8XGiiFoe5gxtkBr1O3FlYUoTg2qJtF4OHidgrNJbuYT2Sp3UW3D6t98+XfVnmAvT
         ddPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7gN9nsFoWqXbe1R3feDEMax2/wjhV5m+ypVTmLEALRc=;
        b=Khtkn18HnE9azCz70IRt8MM7sxW/p/Jlla98VWsjCKEHDkMNGtSTSPzXpPIN8bxlre
         RWiMrcCAa47mwZgbUvcmKBUHkNKbkq2c8A9fzSsjjin1punl0//OhHV7II99UiHnRg/E
         C2yWBnJNo1Kjklt9pqX2sO2aiN62Bev0+mn8ZZ86OFx89AwercgeD++K+YEfyDdnQJUu
         eLxgxL//TXM9ypNr8HyWvDjIXldsW8WR5u96PRvTs48wj64XWc9TxTs4DbNutyogcbYG
         3nh+c6uhebcspkA0aKrw5Huzt/1x4Oup95IN+Lp0maLvmoI33Lm6nS+w7BeOlbk3uyLK
         Zu+w==
X-Gm-Message-State: APjAAAX6Ib249O2prTm2pf2mMUH7VEu77WuxDUhm86W405lYD0szTJXo
        dM7iQiM5QrFZyvaarsj5v7sUEJzx
X-Google-Smtp-Source: APXvYqymmHMg0WzgUde+nF3EKfZCxsx0WD2x0/FjXPNsfQS3ol+KEqC0OZ/L0xsVu9vKAbzqBEU9Kg==
X-Received: by 2002:a17:906:37d2:: with SMTP id o18mr20197522ejc.112.1554806483560;
        Tue, 09 Apr 2019 03:41:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm3462830ejz.92.2019.04.09.03.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 03:41:23 -0700 (PDT)
Date:   Tue, 09 Apr 2019 03:41:23 -0700 (PDT)
X-Google-Original-Date: Tue, 09 Apr 2019 10:41:20 GMT
Message-Id: <a01a8c704ba03213aa59c59384dba46502089522.1554806481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.176.git.gitgitgadget@gmail.com>
References: <pull.176.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t3301: fix false negative
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 6956f858f6 (notes: implement helpers needed for note copying during
rewrite, 2010-03-12), we introduced a test case that verifies that the
config setting `notes.rewriteRef` can be overridden via the environment
variable `GIT_NOTES_REWRITE_REF`.

Back when it was introduced, it relied on a side effect of an earlier
test case that configured `core.noteRef` to point to `refs/notes/other`.

In 908a320363 (t3301: modernize style, 2014-11-12), this side effect was
removed.

The test case *still* passed, but for the wrong reason: we no longer
overrode the rewrite ref, but there simply was nothing to rewrite
anymore, as the overridden notes ref was "modernized" away.

Let's let that test case pass for the correct reason again.

To make sure of that, let's change the idea of the original test case:
it configured `notes.rewriteRef` to point to the actual notes ref,
forced that to be ignored and then verified that the notes were *not*
rewritten.

By turning that idea upside down (configure the `notes.rewriteRef` to
another notes ref, override it via the environment variable to force the
notes to be copied, and then verify that the notes *were* rewritten), we
make it much harder for that test case to pass for the wrong reason.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3301-notes.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 84bbf88cf9..704bbc6541 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1120,9 +1120,10 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
 	test_config notes.rewriteMode overwrite &&
 	test_config notes.rewriteRef refs/notes/other &&
 	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
-	GIT_NOTES_REWRITE_REF= git notes copy --for-rewrite=foo &&
+	GIT_NOTES_REWRITE_REF=refs/notes/commits \
+		git notes copy --for-rewrite=foo &&
 	git log -1 >actual &&
-	test_cmp expect actual
+	grep "replacement note 3" actual
 '
 
 test_expect_success 'git notes copy diagnoses too many or too few parameters' '
-- 
gitgitgadget
