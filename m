Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257DDC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351964AbiCXQyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352161AbiCXQxF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5729FB0A71
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a1so7478325wrh.10
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m9DN75giL4DkfXgjIHSefTx3kfWRfMmtvJlMhpRXtOQ=;
        b=UKGJxgOgyJqnFChPBNoUIit85V7N5K+KS5g75dlG7trKNt3kSIFkPWUFmBviq33Px2
         MttNi3TadQA9e8blIR72LWcydcz4TXJBsbt0aoj1TwoecevfHXpj114RS1KDX0XIdsKD
         P9ciVZaKnzVLhNPj5z9GIlk/WpXe+h18p3HHgA4eV2ak1frk4kX/rPD7GeFIetEuhlp1
         x2GssNlYbsuqANKs70mfjeETVOm2485fTYpb1cN3UECz3Mi4gYs7aECul+o03YIei1ET
         zYafPxACAkzV9ExFesIL3JffCsbbmuMUoUiw8gi2Z3UOq1+sBgXETDQhdKvisD8tc2mq
         VoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m9DN75giL4DkfXgjIHSefTx3kfWRfMmtvJlMhpRXtOQ=;
        b=kkI4PMCdnguYUmjJzhUbeLFEuBOYqWFMArfg6LK+zQwvw9sNAw9HcpWpl9tXSS2KzP
         uEV2lJ2lxCSHYhQ6v2wGx86u81LQbTeUnjv9bim+NDmMhE2CrapbHfzm+wFFHYMaUybJ
         4MlbMChufkFuRy53UqYGiJP30R4Xun5WAVhiAPQ7hzjC68hdLetFO+sQmMZpfS5uG0eA
         T5UQ4P+XbgnwndT0R4QJgaQsYXguAzK7WB7SUzOVUwbHT0MO8K4Jl8zJZUh6Stps1SZE
         jcIOJTiDb5TgRW31TMaeRLh8mQbAKZ312RZMREfawX2vQ0dYJV+sDjdxSRB0TvH7w+c7
         MlyQ==
X-Gm-Message-State: AOAM532KkO2UMy+adCgqkvfmy6oVMIFcGrCb2LwD7Ys85vN/XE6gHpaB
        QkJFr44HV22KFoPOnCFlRTsq1moX3vM=
X-Google-Smtp-Source: ABdhPJw4B5fd0tmj+dgigkhS4fk1ffyakCHja9N/Eq0hN61kJLimdzMfLBYyGMqeqjms/4bheYhvdg==
X-Received: by 2002:a05:6000:1ace:b0:203:d45b:fbce with SMTP id i14-20020a0560001ace00b00203d45bfbcemr5162272wry.673.1648140684761;
        Thu, 24 Mar 2022 09:51:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600002c600b002057f1738fcsm3416733wry.110.2022.03.24.09.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:24 -0700 (PDT)
Message-Id: <d14f17146042a01abd0bd69771428245fe89167d.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:50:55 +0000
Subject: [PATCH v4 02/27] t7527: test FSMonitor on repos with Unicode root
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create some test repos with UTF8 characters in the pathname of the
root directory and verify that the builtin FSMonitor can watch them.

This test is mainly for Windows where we need to avoid `*A()`
routines.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 9004fbf2043..0509ffe30f2 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -682,4 +682,27 @@ do
 	done
 done
 
+# Test Unicode UTF-8 characters in the pathname of the working
+# directory root.  Use of "*A()" routines rather than "*W()" routines
+# on Windows can sometimes lead to odd failures.
+#
+u1=$(printf "u_c3_a6__\xC3\xA6")
+u2=$(printf "u_e2_99_ab__\xE2\x99\xAB")
+u_values="$u1 $u2"
+for u in $u_values
+do
+	test_expect_success "Unicode in repo root path: $u" '
+		test_when_finished "stop_daemon_delete_repo $u" &&
+
+		git init "$u" &&
+		echo 1 >"$u"/file1 &&
+		git -C "$u" add file1 &&
+		git -C "$u" config core.fsmonitor true &&
+
+		start_daemon -C "$u" &&
+		git -C "$u" status >actual &&
+		grep "new file:   file1" actual
+	'
+done
+
 test_done
-- 
gitgitgadget

