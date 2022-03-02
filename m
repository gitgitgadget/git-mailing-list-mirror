Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F3DC433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 22:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiCBW2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiCBW2N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 17:28:13 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22757767C
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 14:27:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk29so4988208wrb.4
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 14:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DRZJWo4FagMDILbxHAxnJSCsufprXNixCTMsPSruw3U=;
        b=bC4hJrOCdiupx0m8DTE0cIfj+B5nGPW9dCc3wYBdJUgzyGZvkj57NDhq6J3MZF6SEv
         fLWgPjpJWbcrqLwVC9RjHbZlCx/2EfeeETY00bIXgQ/TCWGAuomTlB1WHA9/hdT4YCA+
         BoK/mM9tUl+ltGPxzgTKrvSJdZf9zalEBAskSW3Rw9OSkJ88hQv/k1jSuaOC15R/+XLN
         ABwOatsT11c0ARrZKM85zG/R9287PSUyTeX57vmVxXjp6x5eD6ogWLqSP7wJuyi2cubZ
         x/sXpQzSbhIAVY/Msz8uBAYbg4Wv7Gkotxe38AckhPrNXvIQtKxeC2F+j5/aj7+KrzBp
         Qnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DRZJWo4FagMDILbxHAxnJSCsufprXNixCTMsPSruw3U=;
        b=amDscBvkPamNEgXvufMPB8lxdSXcO3kUv8Ry1Idqts3iy/JQaz4FxCoVUrLPH1CQ7r
         wr9ndc+Qf63bqHcC7IB20+hUMMWR8ayV/s4pwPqThiQ/mSDb3IPGR9ySxVDfg81YUH0P
         s5ExyYZqKzi9NPqulTPTik3GXDlecD4q/hrstIwdufLb+18bkVLd4rWWnOymPFrJ+uxk
         Nlx+z74ulFu8lOSjF7amoFfY9kboqQ2+Ptzees/oGX13VnS1ZzLIg2P9ZD7UuhP5jArO
         VZQ03LqvUaoJQx42ws4/zfvVxKZqCyYODd7NERSAGku8tIwNsCUifLH8n+XU13tOBTaw
         AGJA==
X-Gm-Message-State: AOAM533P6NHCTY3bhIQjFWdvjbC6EVzBTFR8d2cwMfjQq+MguOTYnV8e
        zsd8xEW6uQG3N6IE/j4gvHhfIdLCXlk=
X-Google-Smtp-Source: ABdhPJywngkZPf/W0LwqHaXi0vtksEMs+jdnrjmc8Kn/ZkScJTj8TwwhupoLH8DhbnS9EYGqoFKWaw==
X-Received: by 2002:a5d:4084:0:b0:1f0:2381:871d with SMTP id o4-20020a5d4084000000b001f02381871dmr5398478wrp.663.1646260047629;
        Wed, 02 Mar 2022 14:27:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d554b000000b001f0326a23ddsm232175wrw.70.2022.03.02.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:27:27 -0800 (PST)
Message-Id: <cb32d9bfe60a6c5588260a88702bf058e6113ceb.1646260044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
        <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Mar 2022 22:27:24 +0000
Subject: [PATCH v4 3/3] stash: call reflog_delete() in reflog.c
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
