Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F319AC678D4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 13:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCCNrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 08:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCCNq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 08:46:59 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6945507F
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 05:46:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n6so2706018plf.5
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 05:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHaduuJjt5wL13miaDpxITC3g1nqWps7NMgzcDaHVM0=;
        b=kk3NIYBMsPUc/Wb1k8xb0WGLucPSF9vBHurG9da8+Q3gAh9M96InZutGMrIfJ05hix
         YOpctlGU4IYEJWeJ4JGUZ/xIUjaCuoFdKpKDJMspo91soVQyS4mV3qBHOPkgWB+Z9hzx
         hW/B+1Nqm/w+cu4t7qMhte9uPsX5XcXSiaIeuuGXCeBWSQsU37AHYp0lT/81AmSEoig+
         vPCJkrazSjqd150dqimjshcx0OEvwm9vGvFwrce88t65zFyINFB0kodOlrsYy6H3Fvi0
         HMFZ1x/uPzDdgn43SGpT8YH2vQ48z1h+Egp32UUstAFOcxmYUPUY/fHOJDP2oqF5sVPK
         6i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHaduuJjt5wL13miaDpxITC3g1nqWps7NMgzcDaHVM0=;
        b=hX8kuxuwmBWybC8TfNs/T7ip+D4GO3YC6bKaL7m5SyR1YKpuTKXCSMj9i2yteCu9M9
         J8009aLLj/mTpk89eCvFRDs4GWAWM3CgGWvtzaXlAF/b8J/6ZmBtC3ooutio28nt1HA1
         U1OO74hqwbVk0i062v8SyytddLLX2dmVrsLlqacnEFe/m9FvQJw8zdKOKhX6+v6rnbVe
         MBc5CTS5jY9a8QqjW1OD3kTYroCH9IQOizG1It/EmsNGWW/cYS50ZDjnE/7++9c/9LwS
         4AgLrWSUkNsdtr0QHmB0O+kY7Qjc0bLtkc0Sm6XyazM9vqJaDdKFpKtiWo6BPF1Oejix
         VZcw==
X-Gm-Message-State: AO0yUKWxWHnIuzT8UMmWzklHs2geXmjZXXSIZ77AwGZ3xXpWRhiRm4kd
        yxribp9jetWcxD/5tFqbqaZRj6tOhzc=
X-Google-Smtp-Source: AK7set9MwCDuc/rO05ioojhHso8Quw1oF+e25tGC2PNjUaD1+sijGQqaXunFDC4gw4waP5+K1qDPxg==
X-Received: by 2002:a17:90b:1d08:b0:238:e9:8994 with SMTP id on8-20020a17090b1d0800b0023800e98994mr1850428pjb.0.1677851216238;
        Fri, 03 Mar 2023 05:46:56 -0800 (PST)
Received: from localhost.localdomain ([113.172.118.59])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090aab1500b00234465cd2a7sm1536138pjq.56.2023.03.03.05.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:46:55 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/4] ci/lib.sh: remove an useless break
Date:   Fri,  3 Mar 2023 20:46:03 +0700
Message-Id: <c7312724f8a7ec9ccf63fb0621a996ebad3c6128.1677850518.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.2.gd15644fe02
In-Reply-To: <cover.1677850517.git.congdanhqx@gmail.com>
References: <cover.1677850517.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This statement was silently skipped for a long time.

> ci/lib.sh: line 232: break: only meaningful in a `for', `while', or `until' loop

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index db7105e8a8..661076e70b 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -227,11 +227,6 @@ export SKIP_DASHED_BUILT_INS=YesPlease
 
 case "$runs_on_pool" in
 ubuntu-*)
-	if test "$jobname" = "linux-gcc-default"
-	then
-		break
-	fi
-
 	PYTHON_PACKAGE=python2
 	if test "$jobname" = linux-gcc
 	then
-- 
2.40.0.rc1.2.gd15644fe02

