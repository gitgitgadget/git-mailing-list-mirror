Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8F5C4332F
	for <git@archiver.kernel.org>; Sat, 21 May 2022 15:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355351AbiEUPIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 11:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355218AbiEUPI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 11:08:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8282C9344F
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso5773839wmp.0
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sXZbh0MamYACiDTr6HvklkpnU4A4eZMx4voLUuNMvpg=;
        b=MS4K2LZLqvouQyHsVFZSkWyy9ektC9+61zMzubOFC3qdEf9JJsrKplmvz44WgK3Cc6
         VGTG/LYMckZmibCyUWkM8vZX4IOoKIa+BgZwdqvm/qDkh1biG0csXgM8wY4NowTygqq6
         GcfEg02u/+hA0FfLka6AV7wZJ0u9FNW2oPChGeAbyYLlasypIb7csawuODSu9KkwQgae
         fTsOzQt664X2bAbX3IqRFazf01q2AClefGLqOmm6LUaNBZ0/OUVdnLuE2o9QBTO5/0cc
         tgayxGoQs9/i6BErZQopjGf0EDxUz4d/un/p1niz6IEk5iuAcNBBotYMPdg9VvukV2L8
         b8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sXZbh0MamYACiDTr6HvklkpnU4A4eZMx4voLUuNMvpg=;
        b=yU37p3m0fYX7UIBE6YvIkY36WrYsygfNkjpllm9y5UQYxsFrRGYO93RBHw+xxdIVz/
         ZPeHRb/yieiOFrG/RdOR4JHaHH0Jq/eC8Ve7TX/ut95NnPLpdJcuNoI6CBhpIW24xXYT
         FlpRM9ERht73dUsOxy9ibLY+OTP2Mrhnu9GP/qCbgaAtTRijnj0Lf//L82cVN+lCrVu1
         wiGkj+OhiOBcIKLhXuj0x9IyTq+GI82mgsGPRn0224numaRWeB0z50bhSCnLKuf2Mx0J
         jxH9LJtnhjZJdJ3gUbCWFg3i9yJAU+cpWELlkfePuEKGqTOM6gOj36RWqj7nUmg2QZXg
         RNWg==
X-Gm-Message-State: AOAM532+k3lPLD+GkSPVZUMGxSR/16M/+FDknT3Txo+dHzx1+bLJhXsg
        TdvCYXGRWe2+9qOpP3r6Y7I2AbHrass=
X-Google-Smtp-Source: ABdhPJxnbTW3Dl04Cby90tknfaNvAopr4Knd49XDyuY9I+bmpsWz0sOoz4kqrFAhRB3yiruXvsXguQ==
X-Received: by 2002:a7b:c24c:0:b0:397:3751:2d2a with SMTP id b12-20020a7bc24c000000b0039737512d2amr8201226wmj.51.1653145703803;
        Sat, 21 May 2022 08:08:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020adfa202000000b0020adc114136sm6411977wra.0.2022.05.21.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 08:08:23 -0700 (PDT)
Message-Id: <8ffbaad30869ae03e8ba0b1eae4c23aa7d83759e.1653145696.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 15:08:14 +0000
Subject: [PATCH v6 5/7] scalar diagnose: include disk space information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When analyzing problems with large worktrees/repositories, it is useful
to know how close to a "full disk" situation Scalar/Git operates. Let's
include this information.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 53 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  1 +
 2 files changed, 54 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 53213f9a3b9..0a9e25a57f8 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -303,6 +303,58 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 	return res;
 }
 
+#ifndef WIN32
+#include <sys/statvfs.h>
+#endif
+
+static int get_disk_info(struct strbuf *out)
+{
+#ifdef WIN32
+	struct strbuf buf = STRBUF_INIT;
+	char volume_name[MAX_PATH], fs_name[MAX_PATH];
+	DWORD serial_number, component_length, flags;
+	ULARGE_INTEGER avail2caller, total, avail;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
+		error(_("could not determine free disk size for '%s'"),
+		      buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_setlen(&buf, offset_1st_component(buf.buf));
+	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
+				   &serial_number, &component_length, &flags,
+				   fs_name, sizeof(fs_name))) {
+		error(_("could not get info for '%s'"), buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, avail2caller.QuadPart);
+	strbuf_addch(out, '\n');
+	strbuf_release(&buf);
+#else
+	struct strbuf buf = STRBUF_INIT;
+	struct statvfs stat;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (statvfs(buf.buf, &stat) < 0) {
+		error_errno(_("could not determine free disk size for '%s'"),
+			    buf.buf);
+		strbuf_release(&buf);
+		return -1;
+	}
+
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
+	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
+	strbuf_release(&buf);
+#endif
+	return 0;
+}
+
 /* printf-style interface, expects `<key>=<value>` argument */
 static int set_config(const char *fmt, ...)
 {
@@ -599,6 +651,7 @@ static int cmd_diagnose(int argc, const char **argv)
 	get_version_info(&buf, 1);
 
 	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
+	get_disk_info(&buf);
 	write_or_die(stdout_fd, buf.buf, buf.len);
 	strvec_pushf(&archiver_args,
 		     "--add-virtual-file=diagnostics.log:%.*s",
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 6802d317258..934b2485d91 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -94,6 +94,7 @@ SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	scalar diagnose cloned >out 2>err &&
+	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
 	zip_path=$(cat zip_path) &&
 	test -n "$zip_path" &&
-- 
gitgitgadget

