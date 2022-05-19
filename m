Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A4C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbiESSS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243789AbiESSSR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:18:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9C6EBA9D
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r23so8355777wrr.2
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sXZbh0MamYACiDTr6HvklkpnU4A4eZMx4voLUuNMvpg=;
        b=G5DoKSlVFslUU7jbeQnIGBLc6yl8wzceirTENODVQtDmC5nI9TnuKS7L93eUZ1rMUt
         fnFIHexfU3Cmai2WD7dPU9X7GIt9Yn3wfalBYuQluliFcStA3ZxFgnrwlv13DU9qrTmz
         Hj4RZf3vryUpFAYiKCMKqARLL21DXPEjxNwkCyMBFnOZ2myXVsKU5KlDd8XecZIfDaVh
         kR9FLprY67WZr7krxqEzZaP3CB6vkQaRTB+46WxpJomYgTUWXio2MU5Cj6fg4Rp4JSzq
         BEktmRQL4VBJQtW/stcvOLTAzTWn6o/9Xmgn5tBxIR+g/mDh4J2Q4DsnBzFhfL7CV6QO
         SoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sXZbh0MamYACiDTr6HvklkpnU4A4eZMx4voLUuNMvpg=;
        b=Za6WS3dBTyH5k7HiiT3QCpZBpejnD0xH10/yzNJ+dG5lLy6YYGddLBQIC+nFFExCfY
         lF9Q4skyT8tofs/sgMy0esHMZ6GSD+VD1R7pFdPpOgVtFdv6IN2pJitNT3PdyIPaJth3
         H+FpfjWItm4jHvXSkI9/RZrjyQeU/ZGDSMw8u/AS4NYha3wlNObdPrBHogL1335Pqznh
         M3uvYEfLwIx/hb5lnbXAYgZsTpM0r+/yd3obZvYe1jOQLIXqTQuHvCKibUJ0072/fFev
         iHcmsjcHsSv2xZJmQlXxHpd1QekYACKN4xZWezenSnT7ohcMXuL3tCkvdlx305TGt+2Q
         cbFg==
X-Gm-Message-State: AOAM532moju6fRuqPSVHgDg47kTCV5MA1dJBHbEHMXvr23IxN/lDSic+
        VRlVZKN4w8lKtz6Rju0daIiMCbwKtQU=
X-Google-Smtp-Source: ABdhPJxcGU4Fcf8epFbzHLP+68MwuW6g9ZJzoO2w2EuhjqMtg/lwNZebHC8PFtA4IDHIbsqY+aWi+A==
X-Received: by 2002:a5d:52ce:0:b0:20c:e030:b05a with SMTP id r14-20020a5d52ce000000b0020ce030b05amr5003081wrv.174.1652984291130;
        Thu, 19 May 2022 11:18:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c035000b00396fbf6f524sm282950wmd.1.2022.05.19.11.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:18:10 -0700 (PDT)
Message-Id: <2e645b08a9e3c8505d4c525dadddd1f3eac77201.1652984283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
References: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 18:18:01 +0000
Subject: [PATCH v5 5/7] scalar diagnose: include disk space information
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

