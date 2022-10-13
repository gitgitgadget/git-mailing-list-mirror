Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD978C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 08:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJMImy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJMImv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 04:42:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45F11C265
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j16so1715934wrh.5
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXEoc6/5lUfAgWQpoF3mlId0HIU3GZEyBxBCSN9AC7I=;
        b=NVdrzN8aTu1iRuFM6kvuZ8GuIEcOe+d0abMW0on+riOVoeMPchsMy5UKmRWm1+az0N
         zs20O0HnGb8oFlAf4dPoRUxMqoZqsGYBwUk4eLqJPrP0Fpbi/iQ1VXIYxZn7aw3Yj39q
         tPzT0FmEUZTG+QZSTzrf1yONVqj5zHY/9LvJGIQljqv5eDPZuhxj70l6EH6VnAESokDI
         GT0IBimV2VLhl9t/inQ/J5RbD/TLwt1ZyOnRtPEVy7QF7BRSDPNil0KNe5PgJc72kKAW
         tgRABcdij6reatN6pVVFu1bThsb5xdCkT/4IT23DlEtoKtUlPl2BAzS4VNI2zBblyTfO
         wfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXEoc6/5lUfAgWQpoF3mlId0HIU3GZEyBxBCSN9AC7I=;
        b=Dc2CayvhLkfQv67eGHtrKBEJ+qhMLBry7ElmSBkLm3BmYLUIZEGNOiII8+Yj8JmYrN
         2X0cbyz/Bnq/NfR3aFDs27hg5o4DYEX7fooeN3vUSoWeA5VjxKTW6l6K++dHoAVCmCqc
         MYhl2pRhJlvto2wiAmwyzYwawk3LeA7C/UFGtUAaNoTsbQS6Wf9wnIsEuIWtb26vdatu
         KetaH5ck+9pRHmpK9He9M9SarlmAZuyU6W3Sx36ByptZr2wG+HrUaO9hYu4HizbJLGl6
         Ccx3pjIBtrqKOMU+WqhcdoL45Rjx31ghFrsdsZFHsaRNwfyzH0cYhnXi9tj9QvHtwS5i
         +nsw==
X-Gm-Message-State: ACrzQf3k/lUVqINePZD0oNyt7eGhcCQs1KRNlRIZplPHNchnaf7jwI6v
        O3ZncHZflF6eWsV1INOMPpI7bmJqIbo=
X-Google-Smtp-Source: AMsMyM6vyRYt+HjWWwauPX0UNXHzdF4C7eyDtqVkfxJtZpuxdfz9qrh4xy+QLWD/uePJC0r4lavc6g==
X-Received: by 2002:a5d:55d0:0:b0:231:2304:3a6a with SMTP id i16-20020a5d55d0000000b0023123043a6amr9830030wrw.94.1665650568540;
        Thu, 13 Oct 2022 01:42:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d488a000000b0022e6178bd84sm1550659wrq.8.2022.10.13.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:42:47 -0700 (PDT)
Message-Id: <12fb0ac6d5d932f9a8685d803ed017c357182768.1665650564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 08:42:37 +0000
Subject: [PATCH v3 1/8] t3416: tighten two tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a check for the correct error message to the tests that check we
require a single merge base so we can be sure the rebase failed for
the correct reason. Also rename the tests to reflect what they are
testing.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3416-rebase-onto-threedots.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 3e04802cb00..dc67d2308f3 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -97,13 +97,14 @@ test_expect_success 'rebase -i --onto main...' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --onto main...side' '
+test_expect_success 'rebase --onto main...side requires a single merge-base' '
 	git reset --hard &&
 	git checkout side &&
 	git reset --hard K &&
 
 	set_fake_editor &&
-	test_must_fail git rebase -i --onto main...side J
+	test_must_fail git rebase -i --onto main...side J 2>err &&
+	grep "need exactly one merge base" err
 '
 
 test_expect_success 'rebase --keep-base --onto incompatible' '
@@ -182,13 +183,14 @@ test_expect_success 'rebase -i --keep-base main topic from main' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --keep-base main from side' '
+test_expect_success 'rebase --keep-base requires a single merge base' '
 	git reset --hard &&
 	git checkout side &&
 	git reset --hard K &&
 
 	set_fake_editor &&
-	test_must_fail git rebase -i --keep-base main
+	test_must_fail git rebase -i --keep-base main 2>err &&
+	grep "need exactly one merge base with branch" err
 '
 
 test_done
-- 
gitgitgadget

