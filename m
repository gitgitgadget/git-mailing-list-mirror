Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C4FC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 19:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiCQTzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCQTzN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 15:55:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E722156C7
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 12:53:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a1so7444687wrh.10
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8JlIa/0gMgvotxMGaUqa8UOorZrljM2UYznq583Hs/Y=;
        b=i57UhjSB6Pp4S65P1PP3Vf28hyO4l8T1bO/9iHq1+WV+pWIX8ThO0UxMtGbBbyr8Ce
         3o6sX6Pdih8mon655uf1CUdVXN+CChAp44QhP9Qt+yEeBJ21hGh7GM6QPVL5ZavivYIk
         mWx2hGil9ptK57gnibe9CMlUwEokk+AMZ8WAcUQ90/qKimtLp58OdN4AxeSSb1SaIWNf
         QjOVhMf781GHcb6VNdk1GJYZjMmbFyCVqg13h85cENtA3OdRvMCvdpF5z7bE5W3+fkZ4
         9ieyVQfBwl5WU8ZEN5ekIx+PMIfhYeG4v638nJcuNkOd4Df83248IPP0p5Xi8WdFvS5a
         pHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8JlIa/0gMgvotxMGaUqa8UOorZrljM2UYznq583Hs/Y=;
        b=YTxlm0m/MRQUyWRCZje/BP8za/euYxDDdmZ9U516u33vFrd5bo/mzQcn4JjJnNIu/a
         rnfM+GbL1PVpX9lXj3+nwjvqRS8nfRYN3KYNBqKjajV7efYwwNFB3n7VLifHpfb1vcDQ
         8Y6eMbepFO+B4tSfTAwpP+svBrAs+sNAmcOK9wwtWtYZt++4Ss724xb2kZnW4jK73aX+
         Pvxb3AZdsEV+xWw1bZJda1AwhoQAX0OYp7C/ahgBLvV9QD1gTdGef02xf0Z1doPgEDvZ
         uWQVR+hnQT6da4rnsomBMOMPIP0j5UnjozNUs7J1fIM1ez6NglK20oPoVpcpK+mGHbxh
         UTzA==
X-Gm-Message-State: AOAM530ddNI19asuFHF/jFgaGSrjARqI55Iqra8I+bE4D3edaANoCr/G
        G8XE5VIJ9IC/pCDZP6alAqrjkR64w6g=
X-Google-Smtp-Source: ABdhPJxd2rvucXG/F2PlpxzyEVZqkUObdQcknPpGYKGBEdOZhjBEUmlVhAUf31t5nX/53ebiKbZBnA==
X-Received: by 2002:a5d:6311:0:b0:203:dd90:562d with SMTP id i17-20020a5d6311000000b00203dd90562dmr5519200wru.195.1647546830164;
        Thu, 17 Mar 2022 12:53:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b00203e4c8bdf1sm3063343wrs.93.2022.03.17.12.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 12:53:49 -0700 (PDT)
Message-Id: <cac51a949eed0fa593247a593aae2b100be6f4f2.1647546828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
        <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 19:53:46 +0000
Subject: [PATCH v4 1/3] rebase: test showing bug in rebase with non-branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Currently when rebase is used with a non branch, and <oid> is up to
date with base:

git rebase base <oid>

It will update the ref that HEAD is pointing at to <oid>, and leave HEAD
unmodified.

This is a bug. The expected behavior is that the branch HEAD points at
remains unmodified while HEAD is updated to point to <oid> in detached
HEAD mode.

Signed-off-by: John Cai <johncai86@gmail.com>
Reported-by: Michael McClimon <michael@mcclimon.org>
---
 t/t3400-rebase.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 71b1735e1dd..5c4073f06d6 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -399,6 +399,15 @@ test_expect_success 'switch to branch not checked out' '
 	git rebase main other
 '
 
+test_expect_success 'switch to non-branch changes branch HEAD points to' '
+	git checkout main &&
+	old_main=$(git rev-parse HEAD) &&
+	git rebase First Second^0 &&
+	test_cmp_rev HEAD main &&
+	test_cmp_rev main $(git rev-parse Second) &&
+	git symbolic-ref HEAD
+'
+
 test_expect_success 'refuse to switch to branch checked out elsewhere' '
 	git checkout main &&
 	git worktree add wt &&
-- 
gitgitgadget

