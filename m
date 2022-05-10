Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7295EC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 19:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiEJT1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 15:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbiEJT1S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 15:27:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD5C3616B
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d5so8072wrb.6
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FJ0VvqP8x2j0FbHa0XDUiAhX7eAX+nOlgM67ZhMwLss=;
        b=alYqXdoz0W4CSRa3xDK2B4vwS167cMjw8Bc0zzyDi/7DkvS235OxL5D58vEalFihXI
         /l3lrqc1XFK+JbsyCxWBGuPImdqvnMc98xRxDuct5FHz6qjYRddItFuL79P7nE2+G25B
         +SEJC8DBaV9DZ73HNpUj6PG706xr7oIC0qlsnAN56OVBdX8/ZoB9f/tt7KtlcXtk4+Pn
         3Pwh6u+AmZbkZL+wWEQLM8Y45DrRHxtg8Mw6BeJWUCdm8I0Br5Cb2xBbBIy9UO/mPCMj
         5vvbAej+mjX+OoDr4329xsa1LR7rgH06m76nuAfOO2kW1bimAmZlhWDGDH37VtQnu3Ij
         BuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FJ0VvqP8x2j0FbHa0XDUiAhX7eAX+nOlgM67ZhMwLss=;
        b=Q0JV0Cm9j7HXpAjR7NCQu1GmmA05GieFA39qfPfzPfNBESCezvUQKhYky9SOOn8NNz
         nltHvhyLTkJB1FfCTSLY1Ik12PhOitLqCr44cWFfW91LJyc+RAqljjHcq5otcZLdLPAh
         j5s2ooiC7NZi3bi+oF8ICOe0soxxJTsqxchFtrtbLUaen5waW51Q8toXCIqdMkeOorCu
         7Mowdgzsy4/eYy1TgXJRHf7cjlFm2kkPI/jFfDyFpfH+MuLIOeGsry6sbXQxP9SENkU1
         a0CgRQNCItYMECh1M8abCmfBzHUzNEOvqePR+hIebPrF3Vk9/MzsjdmWsTaq/odaxyD9
         /gtw==
X-Gm-Message-State: AOAM533R8WmJATl+Fgl8aqEJh/D0pdrEtP12z1REarUvcK90WviF4Wu/
        44ObgbX4Ch7UXYzt+Qh+3rJZ4m1fyAo=
X-Google-Smtp-Source: ABdhPJxE/KFvCzNoJJXyAb5HYeUqcZ9weWTw7ohQWn5XdThHKFJQ7FkRDGxGkr4nwV67eqf7qtxZJA==
X-Received: by 2002:a5d:5051:0:b0:20a:e005:cca3 with SMTP id h17-20020a5d5051000000b0020ae005cca3mr19394365wrt.560.1652210834537;
        Tue, 10 May 2022 12:27:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0a5200b003942a244ec8sm106147wmq.13.2022.05.10.12.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:27:13 -0700 (PDT)
Message-Id: <3f63b197d420c35f7606d823a981b067964876a6.1652210824.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 19:27:02 +0000
Subject: [PATCH v4 5/7] scalar diagnose: include disk space information
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
index 367a2c50e25..34cbec59b45 100644
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
 		     "--add-file-with-content=diagnostics.log:%.*s",
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

