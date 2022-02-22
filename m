Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5D1C4332F
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiBVSb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiBVSbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:31:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAB1EF79D
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:30:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d28so7334911wra.4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DRZJWo4FagMDILbxHAxnJSCsufprXNixCTMsPSruw3U=;
        b=Zej2EoyHcjmkopGN3T1vTpOzQ+43MTyW0Mzw9NMOGsh6JDQnxZnvzwyd+2DVJNG3Tn
         6ITrBm/9lsOioipnPi3Wpk0bG4QPYd4PDzPoptzvx2Ppvy8wGY1tiA8fHRa+DJIRKFB8
         NdDpzMOQpYv447xGrlpJttdUCgBtfkCMOjqY9OhmogfEW8+8yTZy+KdjwD9jBl94N9VY
         RPOME7nneooQtqnLL5z2yfi+PuYKbpJseqwYljz/YDCJebxedsAcJdnitDhPoWZiiMps
         SpPmkR0x9qHdoq4S42IdbxesPAdaBPMTfYxyd9Wqog65L86MPuRXkAttEPwonFxhPwIu
         Y82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DRZJWo4FagMDILbxHAxnJSCsufprXNixCTMsPSruw3U=;
        b=DSlJIo6miH8A/mDUuWpxQ1zXkpJMfPcy0t0OYlfPhjw+XggMbY2otWGqiuFxOEJt6K
         0zaRgVMlZTJqf4Z4BS6Ujkeo0Kxr54sxZrSBgyU4rmFESrd/4ia1QPunOyLUPiHVDg+L
         oPkB13irTYUVLrCPtLfZRpSW1MPPsLK84vpZZp7STel9ac5LlARRsV1cmRE3DPGXONSQ
         qxHsKWfIgnD/Xu8RCA8pWxoKlWto7Mr5Rryv4aFAGUCd4M8bJO1Nz+IuAagF0uZBKmOE
         MtvXFeoY4Q6V9bLAHMi6Qr1D8HkX7Fb1pHEjQp/BoCbabJ2u4f9OzbKjhNx9NZ4klUc7
         RI7g==
X-Gm-Message-State: AOAM533p56jMK6Obs91+9fvObMe4vAaImJ9A2fz9qn4AbHV4TDLxactH
        4cdd3/L1kX5PnB/TQmP6xdYN8qUYCww=
X-Google-Smtp-Source: ABdhPJzeWrnJ45/pJq7id88WtnhEu/uSGm0+Jfka1HCXaNr1/SXSiNlNv0mimdtQ0I4SOipr9Epbsw==
X-Received: by 2002:a5d:5885:0:b0:1e8:edbf:2d07 with SMTP id n5-20020a5d5885000000b001e8edbf2d07mr19871959wrf.85.1645554657267;
        Tue, 22 Feb 2022 10:30:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2sm52057769wrw.14.2022.02.22.10.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:30:56 -0800 (PST)
Message-Id: <a023a70092b805be0ca96a8ce3f9afd12d098b52.1645554652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 18:30:51 +0000
Subject: [PATCH v2 3/3] stash: call reflog_delete() in reflog.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Now that cmd_reflog_delete has been libified an exported it into a new
reflog.c library so we can call it directly from builtin/stash.c. This
not only gives us a performance gain since we don't need to create a
subprocess, but it also allows us to use the ref transactions api in the
future.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/stash.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 5897febfbec..3e2f478b761 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -17,6 +17,7 @@
 #include "diffcore.h"
 #include "exec-cmd.h"
 #include "entry.h"
+#include "reflog.h"
 
 #define INCLUDE_ALL_FILES 2
 
@@ -634,20 +635,9 @@ static int reflog_is_empty(const char *refname)
 
 static int do_drop_stash(struct stash_info *info, int quiet)
 {
-	int ret;
-	struct child_process cp_reflog = CHILD_PROCESS_INIT;
-
-	/*
-	 * reflog does not provide a simple function for deleting refs. One will
-	 * need to be added to avoid implementing too much reflog code here
-	 */
-
-	cp_reflog.git_cmd = 1;
-	strvec_pushl(&cp_reflog.args, "reflog", "delete", "--updateref",
-		     "--rewrite", NULL);
-	strvec_push(&cp_reflog.args, info->revision.buf);
-	ret = run_command(&cp_reflog);
-	if (!ret) {
+	if (!reflog_delete(info->revision.buf,
+			   EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_UPDATE_REF,
+			   0)) {
 		if (!quiet)
 			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
 				  oid_to_hex(&info->w_commit));
-- 
gitgitgadget
