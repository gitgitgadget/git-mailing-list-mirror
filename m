Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C5401F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbeGaOrz (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:47:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53550 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbeGaOry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:47:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so3002796wmh.3
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lduHd3WP/fVRh3tQNvlvIAZZIyyc4oQvXTdcjhG94AM=;
        b=bVWU6TLWvsThqYEg/KJd/ZXwzLPUoOXERzuh9legGHK+h465+clA0QB0tJUMaJunjX
         QSKd5/EzLjV3+fw6/QvLKgq6WKKiVtSrtqGCTZ9qwKJwK216HSL9+nQymne9sSG6QmRE
         TGzxUfT/tEs0WV0dzrx2QqS/4N/Ay6BqyJJRHr+ACKCY+M7s2joc9JS0q1NDnAKbWHhl
         j6ye8s/HZDIDnuRlRhqz9W38QcY1m9Uu/rbq2xIhLdtTYWWx+8tsYn3ES6wNxoZ36/PZ
         TP+Y7wUgBjiv1o9ia7Jkldxhj/priSGVdCtogziT6eaWAkJGU7KcrQJojNOUzhB3Ndnu
         NrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lduHd3WP/fVRh3tQNvlvIAZZIyyc4oQvXTdcjhG94AM=;
        b=iaoR70kCr6q8D3Mc9bg02EVwlg6JhZneMRRsobB8gnM5CJ6O98WeJXkEmv4LBtTKX3
         j1IF/XXiFkLST+kdFroliyP0BdhmtE7OFYkE4AUQcY1A8w5TDNOJwrLGm1/n/85t10fW
         drbKNBc8hE4cyDN+fHLoohEZ7pB9xXtttNozbAOUciaawpbx5W1VzCqbJUWNQ5Z2fski
         b8bkolWGLCrH9tKCZXMDO2tFOGHonzM6RK2/xc/f6pXxtI/09s413doQbwMX7qMdHowT
         tInFhwSGJjQUi9HQm1pfqw/55cUjS9HXYl9SOPmyyJlciaTCOmvqTmEVywFf7ZGaRGia
         Uf8Q==
X-Gm-Message-State: AOUpUlFABlf5tqmrOT+r33ORQCFhlG5U6cQT87dm5vvkxV8m6+5itIGi
        fsdv1HCQTMNbFWN+7h6xJmvrdBio3Nk=
X-Google-Smtp-Source: AAOMgpftsO0HLXT7U6X1dy/qZELwE9ArFbeBOkpRTcb9ZlO1LvqQcunKDLv2gZu8q+q7UDqkfOZGzA==
X-Received: by 2002:a1c:b609:: with SMTP id g9-v6mr2113259wmf.73.1533042458146;
        Tue, 31 Jul 2018 06:07:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] push tests: remove redundant 'git push' invocation
Date:   Tue, 31 Jul 2018 13:07:10 +0000
Message-Id: <20180731130718.25222-3-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove an invocation of 'git push' that's exactly the same as the one
on the preceding line. This was seemingly added by mistake in
dbfeddb12e ("push: require force for refs under refs/tags/",
2012-11-29) and doesn't affect the result of the test, the second
"push" was a no-op as there was nothing new to push.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 08b9cf581d..4d487d6875 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -973,7 +973,6 @@ test_expect_success 'push requires --force to update lightweight tag' '
 		cd child1 &&
 		git tag testTag &&
 		git push ../child2 testTag &&
-		git push ../child2 testTag &&
 		>file1 &&
 		git add file1 &&
 		git commit -m "file1" &&
-- 
2.18.0.345.g5c9ce644c3

