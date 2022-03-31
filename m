Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83613C43217
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 16:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiCaQEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbiCaQEI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FB117154E
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:02:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h23so411366wrb.8
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o7OmvAksldXagPGU7wOVWp0YQJVO7+kQWG+Jyo0oXyU=;
        b=fYL0TGvKZRLj4yx48pmtBpbliINbXe5aqHPdV4mMQHFg+3SQMY0DjWbRd5b6RPjchg
         WIdurFTkvfHPf68gxdHB4ckxh0D6A2AjbstIOeYApXNKN39QJthKiXq99bP7tMUioMI2
         X6Pdn4K79CubWfoy42+JgmthJ5xv/8At9vNH7DhnyDrPOatxctKrqkpfRS7US7bPEjGh
         j32SLgYq2brc+60uPjRowutXmcV7P7+bqtOuA+d8tg+6eBjcQntLy8NPlfk0mwmU10BH
         ferzQHgQkFWTYP4OuPWhT6WNHNDYvCuT6UyPDAu7ZX0hLLPOVQiz2e3BRxfsQ0ls+EmR
         b4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o7OmvAksldXagPGU7wOVWp0YQJVO7+kQWG+Jyo0oXyU=;
        b=takSS5jlXj9Q2v0uFNDapxL8QObonmn6tvsdH75o+XreywOUg8csxQoYuk8y1R5owS
         f4NxY+Qp8NVoAnrdqQx42vikFiDM1j63vAHGndNCKpT42UKh7KK8qEQfCCeSzkYottQr
         RnhyqCVixkBGavH3SPlrpBGw12Y2h8NuJzucXac5603Z8fyniDo2Z3L8VK0P6jzC9XM5
         qbgM/UkeZjRCwV2GSJmvdiF3Y/9ep/LjDgAPJi03t+V+u1EBUzYgpEAkn5+4QT4JrYGi
         E8n9NBTuRO47FSaDNzSwbVKwTCrvQxqVQJbo6hxTWRJlwvY9XvU9U0IZFy7Dnk0AMmp2
         jZUw==
X-Gm-Message-State: AOAM530C9xWcbkgv6crDueJ43KHVx1KxexDmAqWdatIVA98SF6lyhIgc
        BP4/eGiQgX2RMqcs/QFU3RpYBePXw+E=
X-Google-Smtp-Source: ABdhPJwsnTBfRQXZRzCfvaEQKw+ag8Np2F4YgHjJXPYI6GxUFH6E9YxJTxqB+uT/4N/kNb39425y2A==
X-Received: by 2002:a05:6000:2c9:b0:204:1ce4:7c29 with SMTP id o9-20020a05600002c900b002041ce47c29mr4674541wry.51.1648742537640;
        Thu, 31 Mar 2022 09:02:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d6d0c000000b001a65e479d20sm24906763wrq.83.2022.03.31.09.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:02:17 -0700 (PDT)
Message-Id: <f27f018493afd56a1eacb2008a7284e9e262f73e.1648742535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.985.v6.git.1648742535.gitgitgadget@gmail.com>
References: <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
        <pull.985.v6.git.1648742535.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 16:02:14 +0000
Subject: [PATCH v6 1/2] untracked-cache: test untracked-cache-bypassing
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

Add explicit tests for this known as-designed behavior.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7063-status-untracked-cache.sh | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index ca90ee805e7..b89be8dc6d6 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -190,6 +190,38 @@ test_expect_success 'untracked cache after second status' '
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
+# Bypassing the untracked cache here is not desirable from an
+# end-user perspective, but is expected in the current design.
+# The untracked cache data stored for a -unormal run cannot be
+# correctly used in a -uall run - it would yield incorrect output.
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

