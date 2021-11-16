Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9CC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C4D60EE4
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhKPF4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbhKPF4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:56:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B12C048F02
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 21:18:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so35069445wru.13
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 21:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ez3cLfyqnrmjCbY1o+SRE5150MsDM6GzaDsj/wvZk4o=;
        b=NE1AlvapWHlgKDG6vpnX7XoarQUjjY17YoXL/G7tUAMqwPocVDYe3yTzNvAm8HYImD
         vQbomKj9zJmGc+P87L3g2Q0KZAB2f4MnHZWt4F1FlUaJmzwzxH7Zw3brr8/BIALr0dc+
         VUC4to/m7BaFFk3OwOq1aqP+kNgR9htRC85H0yRH71sIkvVSOIPo2/cyK8IWfdKbWvDv
         4Cro8C2jIRzw5A6GZOt6KZrgTk2ve8QN1Zz10QeumCvCB+cNBtKAZBOXDnEficIsFzau
         JyCP/WNVwQkvx5gU1L8yf356O1xSrvDQ3pXL/VrWjkvL+QBb8PLsFXcNubg8HWt+6gzo
         jRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ez3cLfyqnrmjCbY1o+SRE5150MsDM6GzaDsj/wvZk4o=;
        b=T8F1D/ayIv6Z+ENyMFBLsqhICK/N3j2wBFhJA/eivPFDjWTJxHzJHGfj/TjMVtadMK
         usIclhuJdlX5FzwivKngkuT2/b96FLJTZUx8hqBDGLd7HOlcZW1mNM3W0EWolYfEKdAa
         dBrsPz+tVCUyCjoACExkLaR6W8jHB5CSdDsHf5O9JKLU/P+f8GLDbM7kGFxqow5ATkM1
         H6qP5mVqWcPmBF1Jiql1szgXqgy75jmDRXD2IGyUrb2tl9sjpEX9vKkCEygo6uhXD18h
         57GgkcPaM5qm0zFvArDKw15bnMrxtf2EUU7vijXACWyxPHKE9flx+LNF/llI/KooMWmq
         kjRA==
X-Gm-Message-State: AOAM530ik0Jq2kguVjp7aMWtpsgz7BsB5RsF0vgmfH//g4iJKxS+EHvD
        S2UQ18pQiMPsNWhINZSVHCJhwmCYaBc=
X-Google-Smtp-Source: ABdhPJxi4yGZ9ojz9YExhG0XsyJsaDae3tL1g5fILZqYYNwLd9/zeIGIspSw9yAuhyEmGgpqC3Yqfw==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr5882011wrm.229.1637039889731;
        Mon, 15 Nov 2021 21:18:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6sm1205686wmq.45.2021.11.15.21.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 21:18:09 -0800 (PST)
Message-Id: <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
References: <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 05:18:06 +0000
Subject: [PATCH v4 0/2] am: support --empty-commit=(die|skip|asis) option to am empty commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option
 2. rename the --always option to --allow-empty

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases
 2. grep -f cannot be used under Mac OS

----------------------------------------------------------------------------

Aleen (2):
  doc: git-format-patch: describe the option --always
  am: support --empty-commit option to handle empty patches

 Documentation/git-am.txt           |  9 ++++
 Documentation/git-format-patch.txt |  6 ++-
 builtin/am.c                       | 48 ++++++++++++++++++--
 t/t4150-am.sh                      | 73 ++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 6 deletions(-)


base-commit: b550198c73edd4cc058832dcf74b41aeec2adba2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v3:

 1:  9f1b3dd6d0b = 1:  9f1b3dd6d0b doc: git-format-patch: describe the option --always
 2:  ef33ce8c6f9 ! 2:  b7e30c9b7ab am: support --empty-commit option to handle empty patches
     @@ t/t4150-am.sh: test_expect_success setup '
      +	git commit -m "empty commit" --allow-empty &&
      +
      +	git format-patch --stdout empty-commit^ >empty.patch &&
     ++	git format-patch --stdout --cover-letter empty-commit^ >cover-letter.patch &&
      +	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&
      +
       	# reset time
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
      +
      +	git am --empty-commit=skip cover-letter.patch >err &&
      +	test_path_is_missing .git/rebase-apply &&
     -+	git rev-parse empty-commit^ >expected &&
     -+	git rev-parse HEAD >actual &&
     -+	test_cmp expected actual
     ++	test_cmp_rev empty-commit^ HEAD
      +'
      +
      +test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
      +	git am --empty-commit=asis empty-commit.patch &&
      +	test_path_is_missing .git/rebase-apply &&
     -+	git show empty-commit --format="%B" >expected &&
     ++	{
     ++		git show empty-commit --format="%B" &&
     ++		echo "--" &&
     ++		git version | sed -e "s/^git version //" &&
     ++		echo
     ++	} >expected &&
      +	git show HEAD --format="%B" >actual &&
     -+	grep -f actual expected &&
     ++	test_cmp actual expected &&
      +
      +	git am --empty-commit=asis cover-letter.patch &&
      +	test_path_is_missing .git/rebase-apply &&
     -+	git show empty-commit --format="%B" >expected &&
     ++	{
     ++		echo "*** SUBJECT HERE ***" &&
     ++		echo &&
     ++		echo "*** BLURB HERE ***" &&
     ++		echo &&
     ++		echo "A U Thor (1):" &&
     ++		printf "  " &&
     ++		git show empty-commit --format="%B" &&
     ++		echo "--" &&
     ++		git version | sed -e "s/^git version //" &&
     ++		echo
     ++	} >expected &&
      +	git show HEAD --format="%B" >actual &&
     -+	grep -f actual expected
     ++	test_cmp actual expected
      +'
      +
       test_done

-- 
gitgitgadget
