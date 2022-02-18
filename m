Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D116DC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbiBRSlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:41:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbiBRSlK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:41:10 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A0E2A0730
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:40:53 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso7029843wmb.4
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=65UJj9XuaXpL/f3Pdi5qxi0MhgzQ0qOg3PfJ+oetn3g=;
        b=e83STtHMenrbm1bSBGnjSUwvm+fJejw698SyR0iRg7N4Q2DqgRPl8KISFlhpFfu2kT
         4c1BfiYoCTE6qAS0vd14p9tiSCoUNU9MwLgQuNlSrJp1VN22V4barAnidYolR0tC/oBU
         cJQp8fmIKjR3HImCbyGHeQiE4u/TEKiQ0LE+kWDLCy66eurQzlK7doPu59IaJpvQ28vU
         C354QBHG4skkbYiWxoZ55Qxzt8eg3bM3QdQhDc6e9epse6gfZSPUNlfY8J0V8o1+x9R9
         ekbTT/nf6Vx/7HvA+6goWVuIWcZw/zOjPyE2fgZARa/43uyEGhhibfFsJb1iwp+ESMBx
         ZQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=65UJj9XuaXpL/f3Pdi5qxi0MhgzQ0qOg3PfJ+oetn3g=;
        b=B6o3U7nbnFrPbEoWnPPSam4oFeY3823M6wyGQHs2AdhPK/UHTJBDp14Qx/Z/ok+uyS
         Nw9UyMi2PImGSPczPd7a6ITBZvCxIaFl9QnO9eXhaxV9m8XeSTGEu1k7cQptOxu9KPz2
         ppVAjsbrF6SUaWEGr1emTs1fwXoxQgIxlDbUHnA4ntb4ite3ZAs40v08AAASrfzQ7FR/
         lNm+Zg3BiRTgDQDNKG6+YgQvHBj1EJMpbTfF8qmkd3RlAVBBg/bAtBU2NMgr3wHK5cIo
         gNcv5zZRsecLUWIa3H5y9vQWsb7ehLxCtZc8jduO2Ap8Q9jLZeo247KNiyd6d2wbNkse
         puPQ==
X-Gm-Message-State: AOAM533+nTJrWYk20jsW3kIgt9fHzKxXnAQCXS6C6Ni/2mGrzscOMPWT
        zHto853SrkgMNOBTXG/tH1cyF3iw26g=
X-Google-Smtp-Source: ABdhPJyUGh23/II1NqkhdLzstD+n6HFheFgT6B0hVryeM8CbdgKJxNYXQmpLzPeWOCagdPiCYTP1uA==
X-Received: by 2002:a05:600c:3b21:b0:37b:c3e4:2118 with SMTP id m33-20020a05600c3b2100b0037bc3e42118mr11433157wms.66.1645209651592;
        Fri, 18 Feb 2022 10:40:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm22204145wri.82.2022.02.18.10.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:40:51 -0800 (PST)
Message-Id: <bcc1eae053124f6e68f60a7a02cbee4744a022f0.1645209647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 18:40:47 +0000
Subject: [PATCH 3/3] stash: call reflog_delete from reflog.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
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
 builtin/stash.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 9638c56303e..d0967b3d3c3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -17,6 +17,7 @@
 #include "diffcore.h"
 #include "exec-cmd.h"
 #include "entry.h"
+#include "reflog.h"
 
 #define INCLUDE_ALL_FILES 2
 
@@ -635,18 +636,9 @@ static int reflog_is_empty(const char *refname)
 static int do_drop_stash(struct stash_info *info, int quiet)
 {
 	int ret;
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
+	ret = reflog_delete(info->revision.buf,
+			    EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE,
+			    0);
 	if (!ret) {
 		if (!quiet)
 			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
-- 
gitgitgadget
