Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D61BC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 11:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiC2L1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbiC2L1V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 07:27:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679341A9C80
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:25:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d7so24320705wrb.7
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ra5ZOL0dt7jh37YHshNH8YDpsMF9kaVzWq6R8kDWw3Y=;
        b=hsKYErLiuO+2nur+zAnA/8gzRWVycs5Yhzhwgn1/QiD1ubv9NukAFBUpDbgd/mOL+d
         TI0Uey4vrLqJWZIblho+ZPwB+Uwgd1kht/jT73lDx73lntQHAkw336MPW0o2ixgEb2Tl
         MJ2FjFX0M2f2Tf8BMt1MzEAIb6C8joCWdw2cn8/1tHdmWT/xUIxGYSP+tx4QCl9syNjy
         +RqdEuZRrUxyJDDp9ZJpMN1yA+QC2w+199Oiqe2Z+4RFF9Md2PwyyoMcmiv/h5+ofKUj
         iybYG1+PZehJ7PO3ugDAD7EFC/tgIPPC0OY677UGFwuGfe+j3OupLDZSM97W63OphGR/
         8JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ra5ZOL0dt7jh37YHshNH8YDpsMF9kaVzWq6R8kDWw3Y=;
        b=2gPO7WJnUazQVHXV34OfSuVL81/hFqcmjgUoBRE7Ic7spbV7wQ750/TcixnSwe3QED
         i22P/eZJahIPR+YE6VQGzE9J2uTVh2ebarrGn8h5zt+jQElYlXWvfARGWDrzu0yWGYW7
         y/vX8qV3fwlxhB+Fj4Jwdl3FEvHwkFE2t28tB+bIYLXe05QValYO4joExDgOXCsl+cyT
         yFFJUX7VBB+ejKpC6D0LGF+11wCFGIzbGC6IXlf39pscIrQaQm4BVQXyca9okK436DCl
         HOXAJZHomHlj4XXgqgXLw2kdbqeL+3Pec2uqufcRGtsnEGL0MPAV1er3a/N9L/VLgeBI
         Paeg==
X-Gm-Message-State: AOAM532IGEn1pOEEIyxn5g+Qg9yvJqncQeJfBNZ7eIercIb0NVX75xxi
        VFX3nnDMIEjJh6BhzPJBSvFyJW6QWn0=
X-Google-Smtp-Source: ABdhPJz27TIZA0pFvELDdy7xhcOtfBsXPMxkzhcywU/+FU6Uido9jnzJyhJmApIIZf24UFko98sclA==
X-Received: by 2002:a5d:6c69:0:b0:205:8472:e251 with SMTP id r9-20020a5d6c69000000b002058472e251mr30729582wrz.227.1648553136770;
        Tue, 29 Mar 2022 04:25:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm2497897wmp.13.2022.03.29.04.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:25:36 -0700 (PDT)
Message-Id: <98a4d8f35c5abfcda5590f7e511f7b576000fd5a.1648553134.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
References: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
        <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 11:25:33 +0000
Subject: [PATCH v5 1/2] untracked-cache: test untracked-cache-bypassing
 behavior with -uall
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

Untracked cache was originally designed to only work with
'--untracked-files=normal', and it gets ignored when
'--untracked-files=all' is specified instead.

Add explicit tests for this behavior.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7063-status-untracked-cache.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index ca90ee805e7..c44b70b96e4 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -190,6 +190,36 @@ test_expect_success 'untracked cache after second status' '
 	test_cmp ../dump.expect ../actual
 '
 
+cat >../status_uall.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? dthree/three
+?? dtwo/two
+?? three
+EOF
+
+# Bypassing the untracked cache here is not desirable, but it expected
+# in the current implementation
+test_expect_success 'untracked cache is bypassed with -uall' '
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
+	git status -uall --porcelain >../actual &&
+	iuc status -uall --porcelain >../status.iuc &&
+	test_cmp ../status_uall.expect ../status.iuc &&
+	test_cmp ../status_uall.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
+	cat >../trace.expect <<EOF &&
+ ....path:
+EOF
+	test_cmp ../trace.expect ../trace.relevant
+'
+
+test_expect_success 'untracked cache remains after bypass' '
+	test-tool dump-untracked-cache >../actual &&
+	test_cmp ../dump.expect ../actual
+'
+
 test_expect_success 'modify in root directory, one dir invalidation' '
 	: >four &&
 	test-tool chmtime =-240 four &&
-- 
gitgitgadget

