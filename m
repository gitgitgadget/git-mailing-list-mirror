Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5820C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 13:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbiCRNz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiCRNzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 09:55:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7672192362
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 06:54:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u10so11833632wra.9
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ahZ5BMAE+CC4ogFJO+BKE7toN5aX/jwltR2QRCvh4uI=;
        b=gupOAvCKYI74iVSpKm8NrMa0R9ah9Irb70sTNFEHdYmayd1DX+tJyxG1dikpQqykmV
         hkuDtznXAf5kWw+9SKx+OodoYBNXnz2he5eFKXo85Qzao0zvqq2o1PUXyIdoGJPAbRhm
         qA5eKaeo0DPAUoB8xC5C1lN6f+1MOvjRRjhU+hrB695egRVdxiq4qK7R4NtsgyA7GrS5
         hS+ioj6ESgt+a2JdP7r1H27rYe/BR09zR5KOM0cO1kn+ze5xklR76TRRCdzCaJCZ0kE/
         eshNLRsC3GVAtC+iws8WgSCk1EKn+whfliN5AOXEwW8c7m530+zF/EbcEVoQqrrsL5ah
         GqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ahZ5BMAE+CC4ogFJO+BKE7toN5aX/jwltR2QRCvh4uI=;
        b=oz/31pBeU6o0LMYJSj+N52pWKTo1ifG9oEeEPAZxq1uPZHYt9f/DVY9ZvrkUeSxIlR
         AZaBR8snml4Bv5yBYNlQZgBVKuTOXyhxJKjNPyE5dM1xJ0X8U2FrqMvzENZFpBCmglfU
         BozzIQWT60KXb9OK83N59hY97VjwryX1MSjkkYJNtP+vWuoRClD8dZT0Bdim5VdHSeI7
         QwUcMic01xII+YOlfiYup91jlVGpJbwjdvW00k8zBbuuDpaYGh7tMzP8NcmwyT46dSjq
         z4MGpDUapEPQ/Wh0kt0SASS8LeNgrtpgF8PzlcwAlEvw27/9jXs/HgGnhc5Q6U1RXl7M
         VtAw==
X-Gm-Message-State: AOAM531RybqqR3ioqFUVBCVPSaCNeF2m6OWTOVm5ZBBNtSk2LgrRrRsf
        onKuMbxw5G27TmPd/M/bBdUA56sXXps=
X-Google-Smtp-Source: ABdhPJxe2JJpsKDoNvdBTpJQEfzJlx+Vr3rc7XB2ryDCpVdnUFUNymJCvtrhpyzVMco9vhebU5qdXg==
X-Received: by 2002:a05:6000:ca:b0:203:dbf3:8f8a with SMTP id q10-20020a05600000ca00b00203dbf38f8amr8260234wrx.10.1647611645096;
        Fri, 18 Mar 2022 06:54:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4f07000000b00203db8f13c6sm6325565wru.75.2022.03.18.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 06:54:04 -0700 (PDT)
Message-Id: <9dbd2ba430aa481bc7de69dd51bd89aeafd9e208.1647611643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v5.git.git.1647611643.gitgitgadget@gmail.com>
References: <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
        <pull.1226.v5.git.git.1647611643.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Mar 2022 13:54:02 +0000
Subject: [PATCH v5 1/2] rebase: use test_commit helper in setup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Michael McClimon <michael@mcclimon.org>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

To prepare for the next commit that will test rebase with oids instead
of branch names, update the rebase setup test to add a couple of tags we
can use. This uses the test_commit helper so we can replace some lines
that add a commit manually.

Setting logAllRefUpdates is not necessary because it's on by default for
repositories with a working tree.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t3400-rebase.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 71b1735e1dd..0643d015255 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -18,10 +18,7 @@ GIT_AUTHOR_EMAIL=bogus@email@address
 export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
 
 test_expect_success 'prepare repository with topic branches' '
-	git config core.logAllRefUpdates true &&
-	echo First >A &&
-	git update-index --add A &&
-	git commit -m "Add A." &&
+	test_commit "Add A." A First First &&
 	git checkout -b force-3way &&
 	echo Dummy >Y &&
 	git update-index --add Y &&
@@ -32,9 +29,7 @@ test_expect_success 'prepare repository with topic branches' '
 	git mv A D/A &&
 	git commit -m "Move A." &&
 	git checkout -b my-topic-branch main &&
-	echo Second >B &&
-	git update-index --add B &&
-	git commit -m "Add B." &&
+	test_commit "Add B." B Second Second &&
 	git checkout -f main &&
 	echo Third >>A &&
 	git update-index A &&
-- 
gitgitgadget

