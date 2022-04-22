Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53725C4167E
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiDVWie (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiDVWhx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E0C1632D4
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:29:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e28so2548386wra.8
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FYejdevIv/sNJ+Pm7nNh32hrd+w9z8t9/s1drm2KRzs=;
        b=nNchwVD1ZBXgP2wkGp02oJBmdb7QgRVLgOwkB+4c5IclKLmF2FUGfFuFNQYWfN1Efh
         fREw+n6ubXqXhILwuCQMT8SGfjIfU1LklGAfKoWy4Yi9DyS4niI659+sqAJ2MsVnvQ6m
         MPRWmpS8eGAtq1jtDqo9Bxzyy1juK+kuJV2rmMpBYx9OvKNdQhoX9H0pCTxLVScbEzCa
         E8x0Amqwt9nqHxqV1Sog9TAnZoTfFGZOk6YHYXW72DwGlAkExOU76c3oYaNgtr9mn1/O
         85boZO3tVSU1LiQ61sICdszZuKTgwWZ6eF5iP4aYdziOR94gceVsoN4eU6C52wPYzlMX
         Wc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FYejdevIv/sNJ+Pm7nNh32hrd+w9z8t9/s1drm2KRzs=;
        b=E3rIopfFfjKynRUZvEg6L+TYLYi9nuWw1iwc113TulZytFxCZidK5e3A5aPzyecweM
         il1229MDtHlTFulxdUC0Nvv/va19CNAM75WJ42b8HO6IO7leyYsRdmULewXueQGJGFBj
         2oDAZjBDdCQwojYKQQxJk+2ur/vaJY6iCkGrM31w9aARa5XSgfyDIBKhcogp7bIoQU6x
         xglFQrn3RwD+kOsCCtR73JpoCQIEH6qaW4xBq7PVfYioRHbUjW8SqvrfRfRQMR/pPJFm
         MOMZbEau45WdtTCfgnbJLmbDat0nrxxr8ltagM9BEgdgMBwBqK3Y0/GBUMg+Gr/QAJdD
         V95g==
X-Gm-Message-State: AOAM532Au9/UzefY0p+uDenKB4dJxK09plOr1JnSQ106JMwmBPzhcMul
        5IERe237/XkF46v8Fmt9oD8GryxFooA=
X-Google-Smtp-Source: ABdhPJwrzeCHuNVq0ckKisMfMAEe2rwNCMIOJoxLxHmDXPNwzDJsdLzIPWdxT9rVkuKGslTh+tdp8g==
X-Received: by 2002:a5d:58d6:0:b0:20a:cc61:2d4f with SMTP id o22-20020a5d58d6000000b0020acc612d4fmr3439360wrf.339.1650662997993;
        Fri, 22 Apr 2022 14:29:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a7bcb84000000b00389efb7a5b4sm5331994wmi.17.2022.04.22.14.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:29:57 -0700 (PDT)
Message-Id: <5b246bec2470431898ddc74013f6fb325c2bc281.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:28 +0000
Subject: [PATCH v6 02/28] t7527: test FSMonitor on repos with Unicode root
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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
index 1be21785162..c9c7dd77e3c 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -671,4 +671,27 @@ do
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

