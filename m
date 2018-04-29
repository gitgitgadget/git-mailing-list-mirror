Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7601F428
	for <e@80x24.org>; Sun, 29 Apr 2018 20:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754230AbeD2UVW (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 16:21:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36401 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754220AbeD2UVU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 16:21:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id n10so11120152wmc.1
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aMdChPPEjU+UT2oPgTSi+1YdfY6ca21bC/r7K7F3Dyo=;
        b=nkVo0tXoZs3XwjF8JvYy08EJFtmCADpOOCRv4UGx6c1VvWURylgwA5l0SiUWK5MkTB
         bQwicr133HFPRN145jkURLMS/4RKjj0L5lzNLtXlBioSRfNu2H/Jyu/j5P4ndKtmA8zZ
         bJrUvgHkmCMRZ++d9BfGn+DQIvZFAvHHoh3JFebRN/BhEs1Fe/UG1aJyX83LXEs8/4EG
         0V32z9UKgvHOcFO0GuSoXXrf1dqYmjIwcH4cpB+Qgpnk45Y+tM8NL/OoeCfsG/Gu9h06
         tsp57R/X+lDCZCDBdIEfwNxQ9G7lHPM5CvLdSfcX6G4vK/k/ZRAl/jI2+Ipcr2WBGwf9
         VhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aMdChPPEjU+UT2oPgTSi+1YdfY6ca21bC/r7K7F3Dyo=;
        b=X+UQQGgsH7GuDwf3Zbb0m3jN53c0Abk8aZ6Bn+jJd8hO1skNwKdS2oe/Jz2rA1OlXJ
         DqvUinzAx/bxSHtHZWmWRM/YYXBUbI8STOrLhAaP+7NkMcCOuvaPo8DZuQ33mzYQNFn7
         ptMXxcMsov0bO/h6Jfc5QNT2aT6PGytvmOTMu+7GPDbMTV8XdV3b/kyANPBz0ggHWv4B
         8OF+wx2bD5onhAFWT458aE4btXKv+e9Tk/X1zUVEE668P8HcoZUTb6e3lvGYPHuVgfSA
         rIRuGYdnqN3gmC85Tj3Uvyzur9gWkgLlKAaJzltC7hWflfCykic9XYEhAlQhHwyKdM+c
         YWZw==
X-Gm-Message-State: ALQs6tCn8s2bzrG5mnNSEwRhN7gyQVvno7XJqoMg3L0h6OandcV93Gou
        DEA/HdXMecCiyKEmrK/1xl8CqK3u
X-Google-Smtp-Source: AB8JxZoJwGOZ6UjFqclfDgu7gmJ/lU+K5opiIrrcJm4FFBYwxb/z2dEm+HCYscQWw8ph8zp+5lwBtg==
X-Received: by 10.28.107.76 with SMTP id g73mr5937093wmc.65.1525033279249;
        Sun, 29 Apr 2018 13:21:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y42-v6sm8134917wry.21.2018.04.29.13.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 13:21:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/8] push tests: remove redundant 'git push' invocation
Date:   Sun, 29 Apr 2018 20:20:53 +0000
Message-Id: <20180429202100.32353-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
In-Reply-To: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
References: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
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
index 82239138d5..7b5a553398 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -973,7 +973,6 @@ test_expect_success 'push requires --force to update lightweight tag' '
 		cd child1 &&
 		git tag Tag &&
 		git push ../child2 Tag &&
-		git push ../child2 Tag &&
 		>file1 &&
 		git add file1 &&
 		git commit -m "file1" &&
-- 
2.17.0.290.gded63e768a

