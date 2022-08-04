Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A40DC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiHDBqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbiHDBqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:46:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C4C5E331
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:45:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l22so23587434wrz.7
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 18:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YKKdcJFhp+40tORJ9u012i+7uSC/4xTtFFym2CPkqAw=;
        b=TyUUEFQxkLGmxvp5jwsDKC6C1/7W4xX+v01fZh1hngRzDy2boXkcbHbCcO5ijlDVxj
         86otoiYP8CFaLp2IoG/RVUQvYxhQxsL+iNoHSx60hfbl2lHxrcfIXGgN5j4GsVBp5lVE
         54xR+IqWD+QDqMvFKmSFAB/VCD24jeSVG6LZMz247SlG85QoYu9oNsnWtqLul/vxTtmA
         NWChLFTv5/VXaOLE1um81OS1hSsRivokHNFrFgMy/T7x5utp4rRpgoJbfpVkRyHteUjL
         yX8GyMHHWYDcEyNdr2KHsB32UoSHKW6XxR5kI0FpQythYuFxb/SmJPg+YB7be08fUwgF
         UPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YKKdcJFhp+40tORJ9u012i+7uSC/4xTtFFym2CPkqAw=;
        b=3ym6/W7NeM5kHDFJKypFIACumVA/oWfztQlgBP6FbVGNlFu5Am30xdyjpaASJm9mTq
         6+sC93RN/ZSkd/i/cPHNE/A2C9uljBFPL24WpnNm/UCiUOsL3lQuO7rlsJXsfa1wdJV+
         3y2DrYDjJF14ah1CPtl6ZH2DHyJvjajo9hjjgQk2tj1UYaEMWPq7oqFu1SBXGY3bGMS3
         SCWI5FyRO27pkjzONHwc1Aw/5oqoFrzziAl1TMJgjcsin74DLlBTE+elewBOmtKd8kWK
         yidfvx+TzGr1wShL1Ap9qW066r+5xCo5JPoNqUpreVnlUK0YPq60oYYs7YctiNUf7qj8
         HdaQ==
X-Gm-Message-State: ACgBeo3+fTrQ+LCIzXItUVXR/b/SqD4dEatiucr1Iu5u55gH/Z+aEemB
        GcV6sf0YcvSM+O0pVkbDbBny9jisWL0=
X-Google-Smtp-Source: AA6agR4eLhgZ2LxMYhrQnEHG0aWzWBkjSBzNiHxU0yaQj00hxbWKA9Q7iNMi8x6WQPQUZjJss9qEIw==
X-Received: by 2002:a5d:4b45:0:b0:220:79cf:65c4 with SMTP id w5-20020a5d4b45000000b0022079cf65c4mr3792704wrs.443.1659577555249;
        Wed, 03 Aug 2022 18:45:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f25-20020a5d58f9000000b0021ef34124ebsm4831315wrd.11.2022.08.03.18.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:45:54 -0700 (PDT)
Message-Id: <05bba1e699ff242d496fb22d0735f23a901f8357.1659577543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 01:45:37 +0000
Subject: [PATCH v2 04/10] scalar-diagnose: move 'get_disk_info()' to 'compat/'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Move 'get_disk_info()' function into 'compat/'. Although Scalar-specific
code is generally not part of the main Git tree, 'get_disk_info()' will be
used in subsequent patches by additional callers beyond 'scalar diagnose'.
This patch prepares for that change, at which point this platform-specific
code should be part of 'compat/' as a matter of convention.

The function is copied *mostly* verbatim, with two exceptions:

* '#ifdef WIN32' is replaced with '#ifdef GIT_WINDOWS_NATIVE' to allow
  'statvfs' to be used with Cygwin.
* the 'struct strbuf buf' and 'int res' (as well as their corresponding
  cleanup & return) are moved outside of the '#ifdef' block.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 compat/disk.h           | 56 +++++++++++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.c | 53 +-------------------------------------
 git-compat-util.h       |  1 +
 3 files changed, 58 insertions(+), 52 deletions(-)
 create mode 100644 compat/disk.h

diff --git a/compat/disk.h b/compat/disk.h
new file mode 100644
index 00000000000..50a32e3d8a4
--- /dev/null
+++ b/compat/disk.h
@@ -0,0 +1,56 @@
+#ifndef COMPAT_DISK_H
+#define COMPAT_DISK_H
+
+#include "git-compat-util.h"
+
+static int get_disk_info(struct strbuf *out)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int res = 0;
+
+#ifdef GIT_WINDOWS_NATIVE
+	char volume_name[MAX_PATH], fs_name[MAX_PATH];
+	DWORD serial_number, component_length, flags;
+	ULARGE_INTEGER avail2caller, total, avail;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
+		error(_("could not determine free disk size for '%s'"),
+		      buf.buf);
+		res = -1;
+		goto cleanup;
+	}
+
+	strbuf_setlen(&buf, offset_1st_component(buf.buf));
+	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
+				   &serial_number, &component_length, &flags,
+				   fs_name, sizeof(fs_name))) {
+		error(_("could not get info for '%s'"), buf.buf);
+		res = -1;
+		goto cleanup;
+	}
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, avail2caller.QuadPart);
+	strbuf_addch(out, '\n');
+#else
+	struct statvfs stat;
+
+	strbuf_realpath(&buf, ".", 1);
+	if (statvfs(buf.buf, &stat) < 0) {
+		error_errno(_("could not determine free disk size for '%s'"),
+			    buf.buf);
+		res = -1;
+		goto cleanup;
+	}
+
+	strbuf_addf(out, "Available space on '%s': ", buf.buf);
+	strbuf_humanise_bytes(out, (off_t)stat.f_bsize * (off_t)stat.f_bavail);
+	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
+#endif
+
+cleanup:
+	strbuf_release(&buf);
+	return res;
+}
+
+#endif /* COMPAT_DISK_H */
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index b9092f0b612..607fedefd82 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -13,6 +13,7 @@
 #include "help.h"
 #include "archive.h"
 #include "object-store.h"
+#include "compat/disk.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -309,58 +310,6 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 	return res;
 }
 
-#ifndef WIN32
-#include <sys/statvfs.h>
-#endif
-
-static int get_disk_info(struct strbuf *out)
-{
-#ifdef WIN32
-	struct strbuf buf = STRBUF_INIT;
-	char volume_name[MAX_PATH], fs_name[MAX_PATH];
-	DWORD serial_number, component_length, flags;
-	ULARGE_INTEGER avail2caller, total, avail;
-
-	strbuf_realpath(&buf, ".", 1);
-	if (!GetDiskFreeSpaceExA(buf.buf, &avail2caller, &total, &avail)) {
-		error(_("could not determine free disk size for '%s'"),
-		      buf.buf);
-		strbuf_release(&buf);
-		return -1;
-	}
-
-	strbuf_setlen(&buf, offset_1st_component(buf.buf));
-	if (!GetVolumeInformationA(buf.buf, volume_name, sizeof(volume_name),
-				   &serial_number, &component_length, &flags,
-				   fs_name, sizeof(fs_name))) {
-		error(_("could not get info for '%s'"), buf.buf);
-		strbuf_release(&buf);
-		return -1;
-	}
-	strbuf_addf(out, "Available space on '%s': ", buf.buf);
-	strbuf_humanise_bytes(out, avail2caller.QuadPart);
-	strbuf_addch(out, '\n');
-	strbuf_release(&buf);
-#else
-	struct strbuf buf = STRBUF_INIT;
-	struct statvfs stat;
-
-	strbuf_realpath(&buf, ".", 1);
-	if (statvfs(buf.buf, &stat) < 0) {
-		error_errno(_("could not determine free disk size for '%s'"),
-			    buf.buf);
-		strbuf_release(&buf);
-		return -1;
-	}
-
-	strbuf_addf(out, "Available space on '%s': ", buf.buf);
-	strbuf_humanise_bytes(out, (off_t)stat.f_bsize * (off_t)stat.f_bavail);
-	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
-	strbuf_release(&buf);
-#endif
-	return 0;
-}
-
 /* printf-style interface, expects `<key>=<value>` argument */
 static int set_config(const char *fmt, ...)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 58d7708296b..9a62e3a0d2d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -258,6 +258,7 @@ static inline int is_xplatform_dir_sep(int c)
 #include <sys/resource.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#include <sys/statvfs.h>
 #include <termios.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
-- 
gitgitgadget

