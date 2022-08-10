Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F0AC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 23:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiHJXfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiHJXe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 19:34:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3338FD5F
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z16so19424154wrh.12
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=7GCnYaiyaqpfB+KodketEyI+zYP82WFm71eckKhZD9k=;
        b=MuhLGFDFICHCeu9ApDjFqVT5E0QzyZv3S5FxJlf9l66qpMKW0d3HDNncPqLjhubS6C
         mgo+NdOpEGddZIfFcLQngoamZiG+vAjbLU6EZxuUXX5PTDOI+3zzuYiTe2CKeNsaxy9R
         77rT154LuRfMRhgq1+UEz8lBejqiylWE9yqsBjVKRBHdBG2q89e/LIrN9ICx0ucPq3B8
         JWyB4Jl1B67COwmgPAL3A3xws3pSxDrzsrSq/dUhCJI/BXAT0gHi0k92xIgqXhTD6+ON
         CAPbw8Wrk/kEqmz8mpQw0yTfYeGYflChcayhJM/m1RLfqg2KKzn3MV06C76K6tn3k0sR
         lXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=7GCnYaiyaqpfB+KodketEyI+zYP82WFm71eckKhZD9k=;
        b=5KSD0Avkvhw2rXbHEES4bUkgZI1HYMXZG3G3WMG3AwP5EUbwX348M2du9H1a8nCRT+
         UEBdAQJs3yBV29Ro0JuOe8Ej6c/q6kF9hTijMQRGX5PfXhEWUXtpVx6LZepznHnT2FeH
         0ZI4uzV4i2Z9LzT5YJXs3zxr+e2XLf2dKUvYZUUdUEnKUg4xmCTGW3zfBwzOovG5pMtd
         19zgaJTLoPmQmvALnTsDxkp4LXYXwYet5TZbb317Fv7890YANj5jTpBA1h/BJnjzYERF
         pnBDkwDXa0i9/qjg/L1AjjNHE3l1yUTOaBuhBV2yZiOF6H319eZLkIZ6OVo1hcucji2T
         NhSg==
X-Gm-Message-State: ACgBeo2hpCCgDgOqKKn+l3+E3cl+d/plQ/akdQb+Wl9bwTogQSMXk4eu
        Ip4colQY7iZCPMHjVOtCQJwKbcbNj9E=
X-Google-Smtp-Source: AA6agR72P+1DsK7YzZBRUXY8EBznmptmEgHGPBS9UsaJv24W/nkvqfa0Nu0SNpWRDk1lRemBEDSQuA==
X-Received: by 2002:a5d:6687:0:b0:21e:d501:1b03 with SMTP id l7-20020a5d6687000000b0021ed5011b03mr18166019wru.387.1660174483093;
        Wed, 10 Aug 2022 16:34:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c7416000000b003a541358bdbsm3771481wmc.21.2022.08.10.16.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:34:42 -0700 (PDT)
Message-Id: <d22674752f04a543185c29bbc51511f176682fdf.1660174473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 23:34:32 +0000
Subject: [PATCH v3 10/11] scalar-diagnose: use 'git diagnose --mode=all'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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
'git diagnose --mode=all'. This simplifies the implementation of
'cmd_diagnose' by making it a direct alias of 'git diagnose' and removes
some code in 'scalar.c' that is duplicated in 'builtin/diagnose.c'. The
simplicity of the alias also sets up a clean deprecation path for 'scalar
diagnose' (in favor of 'git diagnose'), if that is desired in the future.

This introduces one minor change to the output of 'scalar diagnose', which
is that the prefix of the created zip archive is changed from 'scalar_' to
'git-diagnostics-'.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index d538b8b8f14..68571ce195f 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -11,7 +11,6 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
-#include "diagnose.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -510,34 +509,19 @@ static int cmd_diagnose(int argc, const char **argv)
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
 
-	res = create_diagnostics_archive(&zip_path, DIAGNOSE_ALL);
+	res = run_git("diagnose", "--mode=all", "-s", "%Y%m%d_%H%M%S",
+		      "-o", diagnostics_root.buf, NULL);
 
-diagnose_cleanup:
-	strbuf_release(&zip_path);
+	strbuf_release(&diagnostics_root);
 	return res;
 }
 
-- 
gitgitgadget

