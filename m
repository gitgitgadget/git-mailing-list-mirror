Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF4CC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 17:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350725AbiCKR0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 12:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242130AbiCKRZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 12:25:59 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD19192C8A
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 09:24:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r10so13995182wrp.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 09:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/1sYErzcSd0ai11MCUe138RAAEGEmZzILDUfYsiZKDs=;
        b=JTw0kUGNMriRPDS1YWjLQzhB/ifFFwC+O2lg05CYOSL4T4FZjTlPXTLhdp8sLMxJx5
         dMPwoh/zOCRV9LXb6ZQalhSKRWAc3bS3YJQntbLbtupSPLKln7iEGIvWRyMwI1abhjdn
         JcEzuYkGK0PiKZCsgntQHG/dPqXXX9Q0s0f/FnYRa1Sf3CAPmjpUiEedTPEJh2iHQf7t
         6WZFAb6EAXE+4IfdF7lqeDAD4YcIj7Xl9NGGc7vlfWrzorR0iVg5XMeqNLhL2vxcKU6T
         W0UdQO61rIZRP0K4snca9svZx9j7kF/IaLTY2aMKAiIhuOKi2HVWbp9dHwsy9/YYs+iO
         Vw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/1sYErzcSd0ai11MCUe138RAAEGEmZzILDUfYsiZKDs=;
        b=bCVBnhariAP2ml3qJE/ULnWjLEYZrCco17W/3ekHHBo57LnKd4WLqfCUBFqFvZDh7H
         FyI2BOI1+mnHcHmlY8srXDQaWOa7Ygtub2kb+oXtpzx+2iHREoniAvu9qxDncyqdpA/G
         doB2lbBWkMvvNDz7kFnqN8EVIU18ogGR/JeSGgWvW4MJmVn1Q2Qk3B5Y2ngTVK5f1qfU
         JQhuoLvbRiuFJKKi43hVzlMLT+lZmb6mkt7DrTgd69XDbv3AO/VgHlQ/LjeQ8EPxvu01
         OGtvIf6EWzW2b753+kKZvyMn72sBirS57kK3g1+bp0TJ71elSo3OFQZ2bk1nJ8jAmQvF
         0h1A==
X-Gm-Message-State: AOAM533xG6UejQ+gtHE/q27ZpgnvVn/H7womkZ/ckvouaRaIQk6QeujF
        ygyHR9hIOvfmNq40jP3w1E5PYjQDzRk=
X-Google-Smtp-Source: ABdhPJz3wyxaooFVDStLNE6GKdkIotzI7cE1/XldqdCffUy+7Vb7xQ2uz7YwJHRgDpLSSlXWGcbjTQ==
X-Received: by 2002:a5d:628d:0:b0:1f1:d81d:c954 with SMTP id k13-20020a5d628d000000b001f1d81dc954mr8081496wru.273.1647019494578;
        Fri, 11 Mar 2022 09:24:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t184-20020a1c46c1000000b003814de297fcsm10818981wma.16.2022.03.11.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:24:54 -0800 (PST)
Message-Id: <f3f084adfa616a7bae7e7c94644f65a36f38652b.1647019492.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
        <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 17:24:51 +0000
Subject: [PATCH v2 1/2] rebase: use test_commit helper in setup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

To prepare for the next commit that will test rebase with oids instead
of branch names, update the rebase setup test to add a couple of tags we
can use. This uses the test_commit helper so we can replace some lines
that add a commit manually.

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

