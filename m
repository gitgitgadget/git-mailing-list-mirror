Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202E1C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 19:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiBYTbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiBYTba (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 14:31:30 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06B91EE9FE
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:30:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s13so5967473wrb.6
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DRZJWo4FagMDILbxHAxnJSCsufprXNixCTMsPSruw3U=;
        b=UFDxQ9DsvuZ7x7qZRxzSee2dStSWE8esETzrcFe5gPGeo6bkFzcqxbhqo59YQAXWB0
         Xcr0aKMfjm0dEpVIXyPmolsbJyw/eb52e3Dy/SW8/f7XhMNl9xK2SQ5/kqVqzOaReheq
         9BOGR8+hasTcEwTEvN5GGDdb8AHGNIAHV8ymDhrzxVUSsXnBkaOBTK/fZn7ws3QyKBgG
         /XosI7WjL/3Xi3pCQJWJEKAS6kb9AtwUOmJQ4AO69O3xRtepC1NzA6+Hi8q0O2DlLS3z
         OJWzz0vUvbd52iYY00IxqIuoSMTfhPeQEA1C2bcuNNWHIXfmo2cySxCb2GU1uHw8OWu8
         7tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DRZJWo4FagMDILbxHAxnJSCsufprXNixCTMsPSruw3U=;
        b=fxJkszV/HtTVrNz5sN+QA6Qo1tt8BKYiB2tXzGsvZqX63ZcdIRBgjiJ2kYTpomwbV8
         fmLSBBKar5H/gHeA5tBKqagTVU4kWTY/gsJg8oTJoKfxK57XwVZI8GkJpyHdNC1f9ncx
         CDVQEyzwP/kSQblV0De/O6ch73pIxZup2WI9j0Gk/Hyx8PEVXO4Db3aKzI4gGiicp1ba
         MFQnLf70WCo1IXr81VaTikMn7NrGhn1sRaeV+xgdWahsKCpLfE73gewDxlAXQn7YjPhJ
         Vx9BMmdCBwj7j5aZXsZUghbW06IHhCS0anUbfA6e/71nArT+cF93SdINeCd8fU15igu0
         V6mg==
X-Gm-Message-State: AOAM530xBESqmAtKaV+5m/SfVeJeA5KvOT68KXDb4hNxPyJHC2V4Kw/R
        /j144cpLywQIBOtk91tPUKIoSlYe8As=
X-Google-Smtp-Source: ABdhPJxzZNJ8MJX8rekes2qDk512GfLYwRD3yPSDQiJcJAAz8w3RSsPBlI1Awl7ituZWOdpESkaKmw==
X-Received: by 2002:adf:f201:0:b0:1ed:c254:c1a2 with SMTP id p1-20020adff201000000b001edc254c1a2mr7108918wro.106.1645817456139;
        Fri, 25 Feb 2022 11:30:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0037c3659a12fsm8896060wmq.6.2022.02.25.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:30:55 -0800 (PST)
Message-Id: <b17d8e5d43ab98f76b4dd1387873eff5156f94af.1645817452.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
References: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
        <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 19:30:52 +0000
Subject: [PATCH v3 3/3] stash: call reflog_delete() in reflog.c
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
