Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D474C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbhLGNmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbhLGNl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:41:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC22C061748
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:38:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso1775518wml.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f9F7TJyomLrMSKcIkZcwHRa0eTQ9RZcolol+/4rLphg=;
        b=fCUqWXoj4XeF5B6yrIZxZa41XFKzQIfK1kg9FXjFOsn+lbkti4ciKxL0WkWg9ojdFs
         qw+aaq3lhh6qUc8tyA1Rx5FJvBGPzwESdWtJ7b5b8fgBqSFeYLR+fp6dpklwFKFlCXBW
         Zp3IBCbz8knadm4xx4FEEF77ZcsNQ1rI63u/VMf+SmWnKOIPjZCm2jzfdvT2WQkpGEhn
         r9VFKhlA/CM3v1DygvDTBtL/O4Sce0phWiH8mvK4svUKptXVhCM4YSVcHghkB51qq3x3
         /M8fGHV0tG0sgb/ilDx45NteoeL7gEHyLsCkLMWcg7zcGfBGIr8OmJUp7SXVBeMHTuus
         DsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f9F7TJyomLrMSKcIkZcwHRa0eTQ9RZcolol+/4rLphg=;
        b=NWmZOtk2SpWnmuY1IHvJnY6vqSd7RZ9H+xla0lZe/Cxnv4PEj5oke9GuWfdkrntT+r
         FHheMljcerH8QhhY2GufDMMBnXOIPh4FglS0Nadg5QO6znWUlRPPigMFrtpjWrLmCvaO
         qfJF5SKGgWE7KNKJUQiPFT9tgtTqoyp75SzxJtAaQcTI2mDEvwFTbMrCTTd2bVwEgkdv
         BNsbYk9oDRARoSkLkl/8ofKYLdWvQxyRS0ub7Br8gts0AZ9m+3Gv4vTOAw5mORNVIsYd
         TdLagQrRVd3sJOV0xJeH2xobCIK0VjgM9kBLBEACgNyTSFEqR3OYhxN4oXVt+ueA02cQ
         Z8zQ==
X-Gm-Message-State: AOAM5300cBY02hYv9ZAtcKCEPgcQotrPFzOxQtQzS6vR8ssplnZXAUun
        dMgj/JJg8F9L3mNtLB2GjGI0AYW5uOA=
X-Google-Smtp-Source: ABdhPJwoXaFJnbxopEHzTqptPOh11WMhZ8KGsws0QDL0jDm/LsaIaSkQ3Jnawt55YkZ3leVXM5auag==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr7216471wma.17.1638884307744;
        Tue, 07 Dec 2021 05:38:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm3243996wmf.2.2021.12.07.05.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:38:27 -0800 (PST)
Message-Id: <7597620ec83a2e956316d27835db423372d618a8.1638884300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
        <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:38:20 +0000
Subject: [PATCH v4 8/8] t1430: create valid symrefs using test-helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This still leaves some other direct filesystem access. Currently, the files
backend does not allow invalidly named symrefs. Fixes for this are currently in
the 'seen' branch

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1430-bad-ref-name.sh | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 84e912777c5..ff1c967d550 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -153,7 +153,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch shadow one &&
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
+	test-tool ref-store main create-symref refs/tags/shadow refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
@@ -203,7 +203,7 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
 
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -213,9 +213,8 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
 
 test_expect_success 'branch -d can delete symref to broken name' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
-
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -224,7 +223,7 @@ test_expect_success 'branch -d can delete symref to broken name' '
 '
 
 test_expect_success 'update-ref --no-deref -d can delete dangling symref to broken name' '
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -233,7 +232,7 @@ test_expect_success 'update-ref --no-deref -d can delete dangling symref to brok
 '
 
 test_expect_success 'branch -d can delete dangling symref to broken name' '
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
@@ -243,9 +242,8 @@ test_expect_success 'branch -d can delete dangling symref to broken name' '
 
 test_expect_success 'update-ref -d can delete broken name through symref' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
-
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref msg &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git update-ref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...ref &&
-- 
gitgitgadget
