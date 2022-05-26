Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EDBC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbiEZVtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbiEZVtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B219A98E
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k30so3652931wrd.5
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LKUw9/jQ5pKOTmRH7NqnSRqnbMLjrfCSfR++z8h3F08=;
        b=chz7Z3E/IBXZwKnTyWyLEsI6F3/UOPhccPSfbCSltkAjWxAYBKX9lvAsrq+Xldp8AR
         4ynzxpFDycQJuPHol12qKrXAjMof5BuuI241lAPuLQuzvC4Ye/YjdEsqF6yZ/fd56NOk
         skU7qP37J3bQG2u70vape3KB+i5d+Ylt6L7rykJQJjo94Qaoh2Jm7tdEQE9FqF9YUDFA
         bFZycnO0cSjlqM9jI40ppKftiK+uuhRYg6KsmBVmsujhN9wrRvDufb9KI1k0oxMJ6JGP
         ei7MkR2p4+76m9C7NrJzBOqMrZW9/xKs4ooNHIne+pgZDNVwxrSCJgvrLUbqDs3ZcNiM
         LSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LKUw9/jQ5pKOTmRH7NqnSRqnbMLjrfCSfR++z8h3F08=;
        b=5jzAuk73zwfO9nTYcTQMTjKrEmMgsSuPeXlruvdpRriXoorF1N3fR1Cf/IiIunRmjQ
         TR1cL5p+uwHEprpig9RFwtveRL4B5ksmkngmE52hFhWGNnt0exfbl3LIDuGgeAfoYxiC
         uxWHmwJRkGKxtOKJn+eatOPU3Ss3KdOiGKX03iEcVIzWWaI7zb8MVh3bljb/yk+WjZs+
         d4EolyFeHe85N/E7UPAUypaQxCMe2intfWz6nC4loMxnUnPMuH/ZKwpJcdK6P6mnxd6m
         qPzfLmXX/b9F0EGf2Rl1ay8WhAagavtm28V6y6NKfoL/uo3zhqjLGcl3M2dnpZASTQJv
         hR2w==
X-Gm-Message-State: AOAM531sOfB8TU2JaWwBreSGV4R+fT2/FECOuMm1+eO1+TWme2XUZiSF
        U5/K/x9LHRPC9QNg50KMb01rOjRQ2fA=
X-Google-Smtp-Source: ABdhPJy9J7AHMLVq98jWchg2Rgd85DmVzWO1PS1zMWRWGC8/XgVswS0u/VZFJsfl5JjrkdHs0XK/hw==
X-Received: by 2002:adf:dc4d:0:b0:20d:2a1:553e with SMTP id m13-20020adfdc4d000000b0020d02a1553emr32646192wrj.636.1653601746504;
        Thu, 26 May 2022 14:49:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d4744000000b0020fe4c5e94csm248437wrs.19.2022.05.26.14.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:05 -0700 (PDT)
Message-Id: <2ae8a02ebe002afcd870c9e23cd0c5f414855575.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:46:56 +0000
Subject: [PATCH v9 02/30] t7527: test FSMonitor on repos with Unicode root
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
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
index 1be21785162..12655958e71 100755
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
+	test_expect_success "unicode in repo root path: $u" '
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

