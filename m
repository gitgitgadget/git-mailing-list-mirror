Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB3E120248
	for <e@80x24.org>; Mon, 25 Mar 2019 18:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfCYSOZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:14:25 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41679 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfCYSOX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:14:23 -0400
Received: by mail-ed1-f46.google.com with SMTP id a25so8393673edc.8
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a1s78ePGcYIGjMfbIq9Y0wgOYdjX++nDCmviqjK1Pa8=;
        b=SvW79jZMxHxGWx6KZfLF2yoIuxc7eMlS24vN2UZlUtBdgWc19dI5z0zOeFGht3FvlQ
         /6GLRji/W63ekzNlnfppV8z9e2ojeMEc0MfLqonMF/NwPB45zPEfmKwtPuv/iR+7P514
         Ef9mrXtF9NsinkQR+fyWgBqQ901vSntafa/M6sA8l4rRyf2+jmVd2Zz/cCgnVpdlcVYi
         23C948cguwpAF5zxqQVfQoMZLmRkEkodYot1bevMqrPfgQ3hQL6klaYIHHwXS+IVBnE8
         cpVt4vI54IGTblPU1xwSlKancoCJy+R508VkhV+SoMQ75l6tc3tt3TBfqRrCYUz/8jQu
         FBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a1s78ePGcYIGjMfbIq9Y0wgOYdjX++nDCmviqjK1Pa8=;
        b=oGFCXOdchFRF91yLttmEGWg2wmGsh3TopvlpeG3dnjxgkfepym94a0hEm1SQBLDdbh
         6A1zRc636yRuR4/5pY1pHi3dRohlBD4U1xwOhIYos7z8W9UQJ1HAxp0WwTHMAtJNQcQX
         2n+DXKn62Cx894GYCgcIEtJc/jmsS4MuGNQZv98d6JYzVqfgkwvOmnXEP1HNWRgTL/33
         3PjVgXG9EceyO8P03ZWAE8VsepoesFn3GmnAzPtn4VAbNtZJ3x/gAmVwhOZ7p+bw1NB9
         tYDvdwpQ57iAZUbu7LJewN9cJzD7xFOVVcGWiWjjA3Nvwhm5N0xuydG4AKZ14YiNcwrX
         FLIA==
X-Gm-Message-State: APjAAAWjTWY0nexg8244mW0RuumXsUMuG1GyNvhKz9dSuOOE9hWtReiS
        YSS2bEWpBm4VQeP06lMGbmvYpb8F
X-Google-Smtp-Source: APXvYqz9Sww8e5tNGB2I8MPr7axHrnYQnjC2OuPes/b9I61FPD+a/fGJcF59R+ai1MbeJDZ6wNJoEg==
X-Received: by 2002:a17:906:9157:: with SMTP id y23mr15067669ejw.240.1553537661884;
        Mon, 25 Mar 2019 11:14:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm1166101ejm.4.2019.03.25.11.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:14:21 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:14:21 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 18:14:13 GMT
Message-Id: <7372059922710f392201cb32c5a7ac9cbdbe0616.1553537656.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/8] tests (push): do not abbreviate the `--follow-tags`
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We really want to spell out the option in the full form, to avoid any
ambiguity that might be introduced by future patches.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5516-fetch-push.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 37e8e80893..db0b1db458 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1370,7 +1370,7 @@ test_expect_success 'push does not follow tags by default' '
 	test_cmp expect actual
 '
 
-test_expect_success 'push --follow-tag only pushes relevant tags' '
+test_expect_success 'push --follow-tags only pushes relevant tags' '
 	mk_test testrepo heads/master &&
 	rm -fr src dst &&
 	git init src &&
@@ -1384,7 +1384,7 @@ test_expect_success 'push --follow-tag only pushes relevant tags' '
 		git tag -m "future" future &&
 		git checkout master &&
 		git for-each-ref refs/heads/master refs/tags/tag >../expect &&
-		git push --follow-tag ../dst master
+		git push --follow-tags ../dst master
 	) &&
 	(
 		cd dst &&
-- 
gitgitgadget

