Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D48C433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 21:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbiCTV4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 17:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343758AbiCTV4V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 17:56:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0471910FE1
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m30so8621786wrb.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=zyDHw+zxGizXnRHPB7DNFSp0YST+9toLA7uDECDfe4k=;
        b=RhAj8Zxf0pyV4HrCP+3rz8Xw4UzHu1a3XeyMFCeJL3pRhSWMkEk/CZmF6o//sIMFmn
         0UfHLVl71vHhtku2YwrBRB9nfnp91/C+sLbSktzCyV8N/aNw8Jwh7uLskCjnEwfEROcl
         0lv4ThwHL4PS0FHj+82wxI8Y0EwDqmctI8MGY/daTCN/Kl1/SZmcPOgfIFZtsb9hb6dY
         x0OTyZT4LlYE+7dVJszCQ7l8D3XVL54P0c3G55B98hh5uDfviYyznxuyWrkhipVW7jCB
         FCobTASoZKZH5u/LjZNVBM5vSvL4Hyr8F+dWh8EbkYbQyMVRgBB/vEGXyfRMfgl5e1SI
         kr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=zyDHw+zxGizXnRHPB7DNFSp0YST+9toLA7uDECDfe4k=;
        b=VfY7XgXmkUy5ENwhqW8H2fY/1RPoSRkn7+ggOOKN1Zdvsa62mfmhlRvAiTWCCTLoKY
         kdDQ8FDUgcQyuL8gC7VX653xjLPv8XukvKKUzkv3/UkReaG9c3kdMp9f2lAZf4B8aE7d
         +d28juYtiyAGKOnmc4SrdtXjrdbYB9vM9fIh5VgS7SndO10iCRS6tdBykimSlaJmlVhP
         2nBPekCCxFBlUWjbf2/w+3e9xLt+5PJLzob7kEsyC/xeJqYjRe8eHJTWst2L4zh9jfuI
         Pegu7vedA2pJk/TH6O8hMVwyndlsyPDwjzhN151G8woDLtlHMjsPaFU4TS8Sbn0Qcjxj
         2gmw==
X-Gm-Message-State: AOAM532QQ0UApuAoLeaF+QjNlyOHnlXU6A+DhI6uHuZLVAvQv/Ba+Q3K
        f5LjYSk0IBldKR+f4vSb9hlic+rDfSE=
X-Google-Smtp-Source: ABdhPJxEa3hYhyKbPEJHi+DEffS+dCXofIuXdHdD5ktds/nt7kak7DPa4MUzLVlPSoLpzvzbic9kOA==
X-Received: by 2002:a05:6000:1a8f:b0:203:7ca5:8dc0 with SMTP id f15-20020a0560001a8f00b002037ca58dc0mr15632381wry.358.1647813296464;
        Sun, 20 Mar 2022 14:54:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9-20020adfd849000000b00203d18bf389sm11248758wrl.17.2022.03.20.14.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 14:54:56 -0700 (PDT)
Message-Id: <c94d5c932f4bd0311c7d85e6fdb36f8801a81a83.1647813292.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 21:54:47 +0000
Subject: [PATCH 3/7] i18n: factorize "bad argument" messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/bisect--helper.c | 2 +-
 diff.c                   | 4 ++--
 submodule.c              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8b2b259ff0d..289a7d2bc9e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -268,7 +268,7 @@ static int bisect_write(const char *state, const char *rev,
 	} else if (one_of(state, terms->term_good, "skip", NULL)) {
 		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
 	} else {
-		res = error(_("Bad bisect_write argument: %s"), state);
+		res = error(_("bad %s argument: %s"), "bisect_write", state);
 		goto finish;
 	}
 
diff --git a/diff.c b/diff.c
index 6b22946cd0e..5e045b4ba87 100644
--- a/diff.c
+++ b/diff.c
@@ -5010,7 +5010,7 @@ static int diff_opt_color_moved(const struct option *opt,
 	} else {
 		int cm = parse_color_moved(arg);
 		if (cm < 0)
-			return error(_("bad --color-moved argument: %s"), arg);
+			return error(_("bad %s argument: %s"), "--color-moved", arg);
 		options->color_moved = cm;
 	}
 	return 0;
@@ -5334,7 +5334,7 @@ static int diff_opt_word_diff(const struct option *opt,
 		else if (!strcmp(arg, "none"))
 			options->word_diff = DIFF_WORDS_NONE;
 		else
-			return error(_("bad --word-diff argument: %s"), arg);
+			return error(_("bad %s argument: %s"), "--word-diff", arg);
 	} else {
 		if (options->word_diff == DIFF_WORDS_NONE)
 			options->word_diff = DIFF_WORDS_PLAIN;
diff --git a/submodule.c b/submodule.c
index 5ace18a7d94..010f8252c5e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -470,7 +470,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 	else if (!strcmp(arg, "dirty"))
 		diffopt->flags.ignore_dirty_submodules = 1;
 	else if (strcmp(arg, "none"))
-		die(_("bad --ignore-submodules argument: %s"), arg);
+		die(_("bad %s argument: %s"), "--ignore-submodules", arg);
 	/*
 	 * Please update _git_status() in git-completion.bash when you
 	 * add new options
-- 
gitgitgadget

