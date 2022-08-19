Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4D0C25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 06:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346721AbiHSG5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345973AbiHSG5n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 02:57:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E4EDF081
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 23:57:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e20so3612289wri.13
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 23:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Y5XRwZYJ60SnP3PeQdhQBpF925vx06drV8D29y26RyU=;
        b=Fp7JX/f03U6MSO276nCAqTZjmpqwz76sfu6xe4UoDR3nOS/CjjQuyx6fa8eJERqXYO
         4BAXHwv7Pd69e6dn5pXIKbE857dqY9dqzhm7GVFQTpry/YIOZ7NSxeXTMg6wUvnzKI9e
         +ft6QKYIHnlWh3j502RfS3yiOVY+JXmljkG4dRmjk8gHbpaa3y6/S0vnd4lMSYsltZWA
         0qEiK1NNBIiVRNIbG3JuLTxVKEsOjbUadFDvBeEyd7YpsPd5vqyHEqBStufHDgtWgbqw
         qgQgFIDoV4/nqadrqkg5EbjRzPeWANFqo2NVjghDEGIKAOJBzmS2qBglbO+arHHH2CiR
         M1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Y5XRwZYJ60SnP3PeQdhQBpF925vx06drV8D29y26RyU=;
        b=0Ds1T3N/fU2s84lfML32spoOCWe274OtjkEMRMRE/Ens2jnMOUlJNWABZKbG3YV1N3
         DRfEdTDy89V0WWctduaGh7EyqSPO7aC56jF5by0i5unHUl34IcU9TxT1qHumAVbRmGYe
         Ryc2b7BjRlRcnIln3XZsI+FXDTaqUTo+O3j4k8FhZc7DzSIFQx85MG470YSl89+CK53W
         PiUCMaSbJQsFdlWQBMNFbYRpoLIjr9CC/Ho0XCxEsdEE9mVejeYG3MB+5dlx1TLOH1If
         Qo5UMcYGEyx7u/cC0/fihxSaapaBHYWnbm8pKzVl+9+cG9aPiYi1+l1FkXeLyzzjmjoj
         65/Q==
X-Gm-Message-State: ACgBeo2XZd2DdQ3GkTrR934Yvpq+R9UttDrl3ZpUpx2BWvaXQcoKZWlo
        A7dxkcaimPl9yvGBU/u4YN2TFwEp9zA=
X-Google-Smtp-Source: AA6agR7jP4KhmnOldnqoGa3Yvji8fjXfiMN5VFHqJTVGt2jf3epaSl0J83yEvSXO1NllDyGutw24OQ==
X-Received: by 2002:adf:d1e8:0:b0:223:bca:8019 with SMTP id g8-20020adfd1e8000000b002230bca8019mr3267915wrd.562.1660892260811;
        Thu, 18 Aug 2022 23:57:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b003a31fd05e0fsm3393682wmq.2.2022.08.18.23.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:57:40 -0700 (PDT)
Message-Id: <3b4ed8bb1bb615277ee51a7b2af5fc53bae0a6e4.1660892256.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1327.git.1660892256.gitgitgadget@gmail.com>
References: <pull.1327.git.1660892256.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 06:57:36 +0000
Subject: [PATCH 3/3] t4301: add a test case involving a rename, type change &
 modification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a reduced version of a real-world scenario that triggered the
work on the original file names.

Let's make sure that Git does not regress in that scenario.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4301-merge-tree-write-tree.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index e08452a8531..3c41ade0a47 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -137,6 +137,38 @@ test_expect_success 'test conflict notices and such' '
 	test_cmp expect actual
 '
 
+test_expect_success SYMLINKS 'original file names and type changes' '
+	git switch --detach side1^ &&
+	test_commit modified whatever &&
+
+	git switch --detach HEAD^ &&
+	git mv whatever wherever &&
+	ln -s wherever whatever &&
+	git add whatever &&
+	test_tick &&
+	git commit -m symlink &&
+	git tag symlink &&
+
+	test_expect_code 1 \
+	git merge-tree -z modified symlink >out &&
+	printf "\\n" >>out &&
+	anonymize_hash out >actual &&
+
+	q_to_tab <<-\EOF | lf_to_nul >expect &&
+	HASH
+	120000 HASH 3Qwhatever
+	100644 HASH 1Qwhatever
+	100644 HASH 2Qwhatever
+
+	EOF
+
+	q_to_nul <<-EOF >>expect &&
+	2QwhateverQwhatever~modifiedQCONFLICT (distinct modes)QCONFLICT (distinct types): whatever had different types on each side; renamed one of them so each can be recorded somewhere.
+	Q
+	EOF
+	test_cmp expect actual
+'
+
 for opt in $(git merge-tree --git-completion-helper-all)
 do
 	if test $opt = "--trivial-merge" || test $opt = "--write-tree"
-- 
gitgitgadget
