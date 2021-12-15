Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5678AC433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 22:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhLOW7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 17:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhLOW7B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 17:59:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E284C061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 14:59:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j9so8666743wrc.0
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 14:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j5cFkxR9CyR3RYEw9bGdQo+NUnJVtJa5mm6gEHBDcIs=;
        b=FUNj0dLdlq0bY4wOFYjP2MPb/DB/ywxc9QOvjcz29HATjPXRGzOl7ssF53rG4/eDwE
         LIzKBxSR4/fJnnGLa7jc48sQZpSra6Ks8sRTM1eleH41fI2+YfcRFm4lc6gdVXMZqsWH
         P+kribCydpFNGa4XrNABKb8OZYsCkAhBSzqv/Qp72m68unss2FSLVi3z9VLkgZOo9t16
         D+0MA+s37xWj4DzoDZWafWY5eiwetePAVWaKYBA7DzvWl8ncSNBkmGY35XZoz4cOBAMF
         +W60V7TeMOc8vlGekB42Whf3cbmX/CAGuqeLccFcj/l5Uqufc0F2lc8oZj6wpvr4sCGN
         7IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j5cFkxR9CyR3RYEw9bGdQo+NUnJVtJa5mm6gEHBDcIs=;
        b=F3WRuJYeVhf+O6tKFjPhsSyQRI2zdU6k4WzZXxOxxcB/wjZ2dHvwi7WQF1lvmA1ZJm
         HeKDkNDjPOJwfIfc20GMTifeS2eFIi+EvJDbK3M5tXwQSQQCFN81OQ9gxGPc9dzYsxLl
         D4XukIuUDkRq2sJonVHR2w10dw7qf1E2fLJluUIt23da/wtmZwXdAIVsi7Roi2XECo/m
         yR8BlzszQ/qs0y5c8siEH7YCpyRnvRZOsw8HFEov398lzGdYSP9L4UpqpCOanwRxTvea
         +cujrS4oK5VFLqbm7GpGNFOycQydWiPn8Rt6Q5T7T8iw+rIQr8YuZCIPgPesfBekY5w1
         nzHQ==
X-Gm-Message-State: AOAM530b9TMZgAdoXJSCLGpnzXHk6+9XMYU5pm8M0fGHfpWqwwHutX9w
        epYcKNYFAf8eBYijtiuIaG8rtGRlEC8=
X-Google-Smtp-Source: ABdhPJwO8iZbN0Pi1hrj+AolbthIsto78syPDKLgC693dRN+SoH2NiCSX0nyWMkILj6jZal4v6qjSQ==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr6274029wrd.33.1639609140059;
        Wed, 15 Dec 2021 14:59:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm3033464wrx.83.2021.12.15.14.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:58:59 -0800 (PST)
Message-Id: <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.git.git.1639604468498.gitgitgadget@gmail.com>
References: <pull.1166.git.git.1639604468498.gitgitgadget@gmail.com>
From:   "kashav madan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Dec 2021 22:58:58 +0000
Subject: [PATCH v2] help: make auto-correction prompt more consistent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     kashav madan <kshvmdn@gmail.com>, Kashav Madan <kshvmdn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kashav Madan <kshvmdn@gmail.com>

There are three callsites of git_prompt() that ask the user for "yes/no"
confirmation, but the one in help.c, used for auto-correction, is
formatted differently from the others. This updates that format string
to make the prompt look more consistent.

Signed-off-by: Kashav Madan <kshvmdn@gmail.com>
---
    help: make auto-correction prompt more consistent
    
    Changes since v1:
    
     * Appended (y/N) after the question mark
     * Enclosed the choices in (), not []

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1166%2Fkashav%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1166/kashav/master-v2
Pull-Request: https://github.com/git/git/pull/1166

Range-diff vs v1:

 1:  5df696252dd ! 1:  e6dc616c964 help: add space after autocorrect prompt
     @@ Metadata
      Author: Kashav Madan <kshvmdn@gmail.com>
      
       ## Commit message ##
     -    help: add space after autocorrect prompt
     +    help: make auto-correction prompt more consistent
     +
     +    There are three callsites of git_prompt() that ask the user for "yes/no"
     +    confirmation, but the one in help.c, used for auto-correction, is
     +    formatted differently from the others. This updates that format string
     +    to make the prompt look more consistent.
      
          Signed-off-by: Kashav Madan <kshvmdn@gmail.com>
      
     @@ help.c: const char *help_unknown_cmd(const char *cmd)
       			char *answer;
       			struct strbuf msg = STRBUF_INIT;
      -			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
     -+			strbuf_addf(&msg, _("Run '%s' instead? (y/N) "), assumed);
     ++			strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
       			answer = git_prompt(msg.buf, PROMPT_ECHO);
       			strbuf_release(&msg);
       			if (!(starts_with(answer, "y") ||


 help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 973e47cdc30..71444906ddf 100644
--- a/help.c
+++ b/help.c
@@ -643,7 +643,7 @@ const char *help_unknown_cmd(const char *cmd)
 		else if (autocorrect == AUTOCORRECT_PROMPT) {
 			char *answer;
 			struct strbuf msg = STRBUF_INIT;
-			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
+			strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
 			answer = git_prompt(msg.buf, PROMPT_ECHO);
 			strbuf_release(&msg);
 			if (!(starts_with(answer, "y") ||

base-commit: e773545c7fe7eca21b134847f4fc2cbc9547fa14
-- 
gitgitgadget
