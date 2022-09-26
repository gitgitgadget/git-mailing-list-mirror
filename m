Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62734C6FA82
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 18:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiIZSsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIZSsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 14:48:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AB083BEA
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 11:48:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so4204134wms.4
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=+wfgInJm6w/BE/avCK/39XOq++2Nf2TlMT5gggZ1o1U=;
        b=RIkG8eegqeW0+Sv4+4HCXFwQlUStrKX1GD3/MUdK8XIGbCsZtioeSt32l27MuKo4NC
         XxRermIu0wpx6+ZMWrI36TVCOHHVzzx+2oRelNyPd8URrd3pF3iO5Mpo91RbsPxwjKkt
         v4s0l5L/OXdpWqNlMwgS2DtIPN4xUH0uwj3+lxnhamAsjk0TaZOGEmWkMUxX9VqpdZ+U
         MNtbvXTh/8cy13D778s3ZHKVQsGEhZRSBLKYhAh+Jys+ei9sL0elORycmm+6s0MulEec
         SLcWuEwhN/S4Inw4/M0GfSLw0dKOQXMGaN9aG8fToB1orSWRiipkx2+Zhjg1KlyE7ycA
         oERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+wfgInJm6w/BE/avCK/39XOq++2Nf2TlMT5gggZ1o1U=;
        b=L3QhOkjGI8Ay/y1L9SOYw4BQOLkVl6osVJPJyjU8OU+gJ2JxN5+yH03qjajNC+NpNl
         4da44MjuQcylefOZhchkhe3tAcus1+4eH8Hv5CxG8r0pVfPUXg2TYVQ4JOD+k3618tTV
         CRDOTsDSBmEeg0SZWdkm7BdEhCbUifwIn5YpHV96LK+ZdFw7LW94HE2NvTMscXgZxkWs
         lIqfouagOwTylAIZSRk0uyUO2P8H8hMIEBNXAN6VesdwX9nXuNC1mdgutJT3+D7Q/VRq
         sWKzCTqVlOhwmNyTfjLMqMuCDS/FUhnA3W0gPxhQWxmGmSEUf9PxcVf/lkUBwm/+mAFe
         BNLA==
X-Gm-Message-State: ACrzQf22UhWqbcILJut0f0ClNGsKnqRm5WQn4tBAhghWItp+1p5vKMKP
        ycnNe96Drd4ffc49eyKBXHV1mltZhQY=
X-Google-Smtp-Source: AMsMyM7HFsnEo2y4Q+csY1572pmMa7R51+J1MgfqO+R49wSo6nDYaqicGyXU3iEUuo1dW/KMzbprFw==
X-Received: by 2002:a05:600c:4e0f:b0:3b4:88bb:19cb with SMTP id b15-20020a05600c4e0f00b003b488bb19cbmr69476wmq.195.1664218089844;
        Mon, 26 Sep 2022 11:48:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p37-20020a05600c1da500b003a3170a7af9sm12243614wms.4.2022.09.26.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:48:09 -0700 (PDT)
Message-Id: <06d5ef3fc57e1961adb541274f6f9b99ab058b66.1664218087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
        <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 18:48:05 +0000
Subject: [PATCH v3 2/3] scalar: make 'unregister' idempotent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'scalar unregister' command removes a repository from the list of
registered Scalar repositories and removes it from the list of
repositories registered for background maintenance. If the repository
was not already registered for background maintenance, then the command
fails, even if the repository was still registered as a Scalar
repository.

After using 'scalar clone' or 'scalar register', the repository would be
enrolled in background maintenance since those commands run 'git
maintenance start'. If the user runs 'git maintenance unregister' on
that repository, then it is still in the list of repositories which get
new config updates from 'scalar reconfigure'. The 'scalar unregister'
command would fail since 'git maintenance unregister' would fail.

Further, the add_or_remove_enlistment() method in scalar.c already has
this idempotent nature built in as an expectation since it returns zero
when the scalar.repo list already has the proper containment of the
repository.

The previous change added the 'git maintenance unregister --force'
option, so use it within 'scalar unregister' to make it idempotent.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 scalar.c          | 5 ++++-
 t/t9210-scalar.sh | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scalar.c b/scalar.c
index c5c1ce68919..6de9c0ee523 100644
--- a/scalar.c
+++ b/scalar.c
@@ -207,7 +207,10 @@ static int set_recommended_config(int reconfigure)
 
 static int toggle_maintenance(int enable)
 {
-	return run_git("maintenance", enable ? "start" : "unregister", NULL);
+	return run_git("maintenance",
+		       enable ? "start" : "unregister",
+		       enable ? NULL : "--force",
+		       NULL);
 }
 
 static int add_or_remove_enlistment(int add)
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 14ca575a214..be51a8bb7a4 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -116,7 +116,10 @@ test_expect_success 'scalar unregister' '
 	test_must_fail git config --get --global --fixed-value \
 		maintenance.repo "$(pwd)/vanish/src" &&
 	scalar list >scalar.repos &&
-	! grep -F "$(pwd)/vanish/src" scalar.repos
+	! grep -F "$(pwd)/vanish/src" scalar.repos &&
+
+	# scalar unregister should be idempotent
+	scalar unregister vanish
 '
 
 test_expect_success 'set up repository to clone' '
-- 
gitgitgadget

