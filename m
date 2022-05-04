Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7F2C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352457AbiEDP3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352616AbiEDP3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:29:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2ECB
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:25:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x18so2552712wrc.0
        for <git@vger.kernel.org>; Wed, 04 May 2022 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BOwgeAE/S9vapjUog7cLOLjx8iiqWE8Gkn3eKwDI6+k=;
        b=BaYqYe/t8L2ihULODbUD/6yJfbzxj8yq2BlwMBUmU3BzC+48poK96BihjuLxCfMAHK
         PV5tvrfogGgQPGdQJzsNAjgjonkkMu9gUQoSIBqg82RlQDwJEtQfyoH85tfD7qjp2WV7
         06gJm3cjdYGDMjmDKA3UJPHB6+icCoAM21rCBdfNwT28LvA2Uc65Lz05Zcq8LMNYlhvw
         SQI5lpE9oDHHHOeAgVmrmPgz+REb/4Jzhqq5ErLkGyFxeXnBbPxdJnO4Z5QefXaZiLBt
         3Kl5A2Oeaht/a6b5Ui/VqSSbaJxQog3Fhx2WoSn/jneiTF5L+diLNXuRboVfGIiKorBZ
         hMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BOwgeAE/S9vapjUog7cLOLjx8iiqWE8Gkn3eKwDI6+k=;
        b=LDKSi+D+1M4YHjaGsZqN17XBPJ7YFHr7pKv+J+Gm4NsCSc/tyB6qrorVj7GfnArbDs
         CQQHVqbrttHe1QnNOjMfZuFbzfH915PeRKw2w3U/ZVmtvP3vozjkLYmPREdSYfhGVB26
         deAupS/25mZ+ZdSvVX3Y2l0+9XBfLdXOT3c2ihr/DiDIK0g++h8stTAFr71P2UI0JF6w
         9sj7u6IOL0dfTOxAIayl9B336B9lVrig81KCRtu5ikcwz5+79Rum0RcNCdfSqcBV99Gd
         QYS0sRI95Xh4rgFGyHdlLYEhPgQEs7uY8ZVV9rVdtjZIdDzEnP/lS2W4bGbsedR+gq9x
         fGtg==
X-Gm-Message-State: AOAM530i6ibN0Y6bCWyQlLpLURLSNr8DgwiXUV+ATPjSvN0dleSzOdxk
        w3WXloj5uMJzen0VQNxD81IBt30SUS0=
X-Google-Smtp-Source: ABdhPJwHqhFx5cMBXIx+JcZGg5AR0smvVsJsM5mAqUvSPnhFydCopPnUz0M3ASPWshIi8dhHOiufOQ==
X-Received: by 2002:adf:e241:0:b0:20a:d762:c4 with SMTP id bl1-20020adfe241000000b0020ad76200c4mr17599132wrb.371.1651677927681;
        Wed, 04 May 2022 08:25:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s6-20020a1cf206000000b003942a244f3fsm4032392wmc.24.2022.05.04.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:25:27 -0700 (PDT)
Message-Id: <bb162abd383efd57c2953812fe44ac9fad838523.1651677919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
References: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 May 2022 15:25:17 +0000
Subject: [PATCH v3 5/7] scalar diagnose: include disk space information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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
index a290e52e1d2..df44902c909 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -300,6 +300,58 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
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
@@ -596,6 +648,7 @@ static int cmd_diagnose(int argc, const char **argv)
 	get_version_info(&buf, 1);
 
 	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
+	get_disk_info(&buf);
 	write_or_die(stdout_fd, buf.buf, buf.len);
 	strvec_pushf(&archiver_args,
 		     "--add-file-with-content=diagnostics.log:%.*s",
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index bbd07a44426..f3d037823c8 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -94,6 +94,7 @@ SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	scalar diagnose cloned >out &&
+	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
 	zip_path=$(cat zip_path) &&
 	test -n "$zip_path" &&
-- 
gitgitgadget

