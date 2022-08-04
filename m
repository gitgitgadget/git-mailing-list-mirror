Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC10C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiHDBqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiHDBqH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:46:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DB95F13A
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:46:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l22so23587611wrz.7
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 18:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OEmtdGU8qXH7SuKiN2jSh+u+/7wuMXmDrbKytRpmLpM=;
        b=nzjS50iqt9vYHa2CttPqNS322cOB2LGd9Qlh1+WH3Tau9whqb4hIMw6vbgLH2ovA0/
         Cl9iHx8z/bnus6Ztg32Q+/Np1oNRMu3rX/cO3aR9n7YtwAYjATPLuVmez7utXLbHl7AW
         JJhp5HZLDdzSZ0uAViSIML1GNK2RsyQRBlgh6h02MD21zOsAhyNj5sX7cGZ2Qowc8CTv
         VsGuXsS+m3UgDiIg0yjKGr6NeXg5GkeEpkMhM6b1HDUYpri37D2tg5eRJgvsFWRfo/Hn
         t851TT622SvGsPm+b8tg87r3FRBkqqOxpIn4m390ODOKaQfBrAE7w/q5HMVHN17h2g/A
         LYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OEmtdGU8qXH7SuKiN2jSh+u+/7wuMXmDrbKytRpmLpM=;
        b=XaxUTF+wvblXDeJmC5m4p9Fqij22B4aM825jAE4qETJGdgpgDvteZxFvLWfD4lF0UJ
         ER2SSM04oyjyoIjgZkcqgfScl3MhTF2m0kK5hHdBVWlDTZE6J6S9Wfoi+BTiutr40TSM
         8jX69HBRiBCK43JPXjXNhGV15WpaZLceWvRSrDV0mM3536NHEv8sMsnDGMbL+VmYZz0O
         6N/S1FeVGh09lFxQ/MpjBWuWmzt72BMzDIoNbR4rALUUJ4560TfTURlpjmZavLLT1eo9
         Ent4FCtRiNVyTZkahN3TPgqwFawXHUW3+eCBYTw7aJUkDBNhX2DqY/Vt6kCTLMUEy32+
         AYBQ==
X-Gm-Message-State: ACgBeo31il3sVdVS/XFbcJ58EVMi9anGNODCuQiFyVhZk8Oh0yyVbZ0v
        1s6m6rsMGF5tdR8b8egq585fC1rJ+34=
X-Google-Smtp-Source: AA6agR4exdZdvpuNZZd6Q2mV44ZIDI4A7v2ewCBGlshUc36SChMg1wEHxqWTXl3z/r6PmMABTbaW9w==
X-Received: by 2002:a5d:444f:0:b0:21e:e83e:66d6 with SMTP id x15-20020a5d444f000000b0021ee83e66d6mr16894927wrr.102.1659577561647;
        Wed, 03 Aug 2022 18:46:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d40c6000000b002207a8773b7sm4079541wrq.27.2022.08.03.18.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:46:00 -0700 (PDT)
Message-Id: <6834bdcaea838cc49f209efd785bf2bdf09e9c08.1659577543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 01:45:42 +0000
Subject: [PATCH v2 09/10] scalar-diagnose: use 'git diagnose --all'
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

Replace implementation of 'scalar diagnose' with an internal invocation of
'git diagnose --all'. This simplifies the implementation of 'cmd_diagnose'
by making it a direct alias of 'git diagnose' and removes some code in
'scalar.c' that is duplicated in 'builtin/diagnose.c'. The simplicity of the
alias also sets up a clean deprecation path for 'scalar diagnose' (in favor
of 'git diagnose'), if that is desired in the future.

This introduces one minor change to the output of 'scalar diagnose', which
is that the prefix of the created zip archive is changed from 'scalar_' to
'git-diagnostics-'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index b10955531ce..fe2a0e9decb 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -11,7 +11,6 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
-#include "diagnose.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -510,34 +509,20 @@ static int cmd_diagnose(int argc, const char **argv)
 		N_("scalar diagnose [<enlistment>]"),
 		NULL
 	};
-	struct strbuf zip_path = STRBUF_INIT;
-	time_t now = time(NULL);
-	struct tm tm;
+	struct strbuf diagnostics_root = STRBUF_INIT;
 	int res = 0;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     usage, 0);
 
-	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
-
-	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
-	strbuf_addftime(&zip_path,
-			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
-	strbuf_addstr(&zip_path, ".zip");
-	switch (safe_create_leading_directories(zip_path.buf)) {
-	case SCLD_EXISTS:
-	case SCLD_OK:
-		break;
-	default:
-		error_errno(_("could not create directory for '%s'"),
-			    zip_path.buf);
-		goto diagnose_cleanup;
-	}
+	setup_enlistment_directory(argc, argv, usage, options, &diagnostics_root);
+	strbuf_addstr(&diagnostics_root, "/.scalarDiagnostics");
 
-	res = create_diagnostics_archive(&zip_path, 1);
+	if (run_git("diagnose", "--all", "-s", "%Y%m%d_%H%M%S",
+		    "-o", diagnostics_root.buf, NULL) < 0)
+		res = -1;
 
-diagnose_cleanup:
-	strbuf_release(&zip_path);
+	strbuf_release(&diagnostics_root);
 	return res;
 }
 
-- 
gitgitgadget

