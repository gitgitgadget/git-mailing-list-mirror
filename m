Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DA6C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352242AbiEUOtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244384AbiEUOtM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72506C57D
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso3583856wma.4
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O949/NoqHYMVq0u8jklITGgLuSWa8z/4rEyyWnamH8k=;
        b=XrYtTCyhi2MouzPBmwDkHvLsX2pgIJhOEgVHy+Tp52haFp6OMHDcq9wJLWeUnOiLro
         lG25nO5X95n0HAk1a3zFecX87y2A0AC6a2gjuxrLga2wXvW3rGDLnOPJgPLEV/+wpoy3
         o2mGOtCm0f7nb3cALnrJJxOYsWi9qTBWQq0zhw5GCmGDZ3/izoaVzc/Vb66ljVb15qb+
         9j25R2FsGDaqZmFy7P7lA44xujk+RP3FQWcUrnP9MTpY0qo9wBiSx/Mh/ngp6jiDqz+y
         sXj3juZxk2U9QHx7yxeTx7r1SF7SltAhhAMBvABIOXfVIEoxSZIsLg+Ee6jWjeByxefX
         OCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O949/NoqHYMVq0u8jklITGgLuSWa8z/4rEyyWnamH8k=;
        b=F18djlC4iNt4h75vU2Jzg/fMaeyju3t8r+WoaTyMUW917xTQI2OwKC+BoHuxLp+BSS
         EX99IqDxjfCXED+3xWebrU1H4k0Mqo3g3JturrVW1dw0F8Oz4isfKUOBcWPjNDxOgzu2
         4762Jq240UH0rhdIFEm3AysgwjP3uEcn+ayPgFrinLanHz/QtIzYNt55ZLnrMzVch2x2
         6huv7uAyNUMylEogdyhTloBWO5QXBaJwq1iBS2CWPBFAN8GbAgKchvRYqvOxZMGonId6
         rXlfUfpjt0Ng0Lc5RL/a42YeUWh4BUWyjX+7j4FLG98ZBGW7QUzzYnCnfuk6SQjl6jGV
         NgXA==
X-Gm-Message-State: AOAM530fPt1+yPiyh+Ezb3HI3RkUsTkjAm/w/V/enMoVng4Z+7Fs4GpB
        EFYkCEbVxPPaudgF+y8nr6azg0zluAM=
X-Google-Smtp-Source: ABdhPJx6qyvNV0zVzILNPLqBk6aTKwzha47pu3VqjTC5HMnvJHkZQN8oNHv3FNXzGzvVCj95KIyp+g==
X-Received: by 2002:a05:600c:1906:b0:394:5365:6720 with SMTP id j6-20020a05600c190600b0039453656720mr13197701wmq.102.1653144549884;
        Sat, 21 May 2022 07:49:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b0039726cd3ae5sm5850828wmq.3.2022.05.21.07.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:09 -0700 (PDT)
Message-Id: <cf6034625ddc7132c222152a62eb330d8f18fcbf.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:48:52 +0000
Subject: [PATCH v3 01/15] bisect run: fix the error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
in C, 2021-09-13), we ported the `bisect run` subcommand to C, including
the part that prints out an error message when the implicit `git bisect
bad` or `git bisect good` failed.

However, the error message was supposed to print out whether the state
was "good" or "bad", but used a bogus (because non-populated) `args`
variable for it.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c    |  2 +-
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d4eaaa345ee..207479ee9ff 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1261,7 +1261,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			printf(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed: 'git bisect--helper --bisect-state"
+			error(_("bisect run failed: 'git bisect"
 			" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 83931d482fb..0cacbf1469a 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1053,4 +1053,14 @@ test_expect_success 'bisect state output with bad commit' '
 	grep -F "waiting for good commit(s), bad commit known" output
 '
 
+test_expect_success 'verify correct error message' '
+	git bisect reset &&
+	git bisect start $HASH4 $HASH1 &&
+	write_script test_script.sh <<-\EOF &&
+	rm .git/BISECT*
+	EOF
+	test_must_fail git bisect run ./test_script.sh 2>error &&
+	grep "git bisect good.*exited with error code" error
+'
+
 test_done
-- 
gitgitgadget

