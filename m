Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A8AC433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 19:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ2T4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 15:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ2T4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 15:56:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE118B7F4
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 12:56:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n14so5028697wmq.3
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCD4Q2aB0/P0mRf184wbEzyQSOV5PhfNUe3x+asv7k8=;
        b=BMZPGUwUUFrkx8y7lvUPS+SKAFv2wPTIIFGIEFaBrIuzX0V6prwvrdFQiHI2Oy72/C
         81CsYKC1jsIhHguEKvNTnUW7XciyQrJdSRtfMmsoGvB/SsKZdRXgW/14DWzYgSIHB8mb
         /7j1/jZsY2wxfragMzYPcgegnkQFL1QxwY+5a0kCZBAyXWPW9xsrlLX9C7qXfdAOf/Cn
         cGGIGVbJ+O3SDWwZylehNd3K/3l36jhWNnueEta3v7VCen9HSLlzOPi4hDNlYkxbxS0K
         b0d6xGSVkhOztwfJCVI+3pjefXD/kgq1w60EDLU3lO/FFSI25YeF5mJAt7+dvfrJLIya
         MTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCD4Q2aB0/P0mRf184wbEzyQSOV5PhfNUe3x+asv7k8=;
        b=I8ulkeFBi21mhPTxaFw+88wAXC3eNehKTCahGd9zbHa0uCPpD2pcHi6ZKIEwSTd9S3
         7CC/+6nv34BnnBY8Of9XfO3aCYWyxC/SJ3EgxJyRmOtRnM8EafNYUGtiwH2eQlA4tp5d
         QsoaUl54CCPK1bA3fhzNLL1D9fghJyzj4hdedJvUOHbtNyoGkUX1PWH0CDVfVygfbcZg
         7pSmDg86KiwQEmgnQ0NsIJgestIv04Kq1Fhq9QTnmT4MZtOewsq3UjDAoCfJRaeySCDw
         FfEgPRz+3H8CYUQVPn7WoylB1qyVDgo+tJ9Y1GOIM/ktCH6dhYSh+hW7BFq7VSHLjxXE
         R04w==
X-Gm-Message-State: ACrzQf0hWqvmtyW4bgKRZv3Vdwq2qEJV8CjegTE78BZDw+7s19g4hYdk
        8ae5CVsDJQe8AsSomaAynz6znjvNFdc=
X-Google-Smtp-Source: AMsMyM6TPqTziJvtiX3VzRDqVkR0K9dDv4eGN+0pKmHVOK5G6rDwuUDyiEi3DM7MQBCvIT2ExRZbrA==
X-Received: by 2002:a1c:f20b:0:b0:3cf:4eca:900c with SMTP id s11-20020a1cf20b000000b003cf4eca900cmr11142426wmc.102.1667073376039;
        Sat, 29 Oct 2022 12:56:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs14-20020a056000070e00b0023647841c5bsm2302444wrb.60.2022.10.29.12.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 12:56:15 -0700 (PDT)
Message-Id: <pull.1373.v2.git.git.1667073374852.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
References: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
From:   "Simon Gerber via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Oct 2022 19:56:14 +0000
Subject: [PATCH v2] help.c: fix autocorrect in work tree for bare repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Simon Gerber <gesimu@gmail.com>, Simon Gerber <gesimu@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Simon Gerber <gesimu@gmail.com>

Currently, auto correction doesn't work reliably for commands which must
run in a work tree (e.g. `git status`) in Git work trees which are
created from a bare repository.

As far as I'm able to determine, this has been broken since commit
659fef199f (help: use early config when autocorrecting aliases,
2017-06-14), where the call to `git_config()` in `help_unknown_cmd()`
was replaced with a call to `read_early_config()`. From what I can tell,
the actual cause for the unexpected error is that we call
`git_default_config()` in the `git_unknown_cmd_config` callback instead
of simply returning `0` for config entries which we aren't interested
in.

Calling `git_default_config()` in this callback to `read_early_config()`
seems like a bad idea since those calls will initialize a bunch of state
in `environment.c` (among other things `is_bare_repository_cfg`) before
we've properly detected that we're running in a work tree.

All other callbacks provided to `read_early_config()` appear to only
extract their configurations while simply returning `0` for all other
config keys.

This commit changes the `git_unknown_cmd_config` callback to not call
`git_default_config()`. Instead we also simply return `0` for config
keys which we're not interested in.

Additionally the commit adds a new test case covering `help.autocorrect`
in a work tree created from a bare clone.

Signed-off-by: Simon Gerber <gesimu@gmail.com>
---
    Fix autocorrect in work tree for bare repository
    
    Currently, auto correction doesn't work reliably for commands which must
    run in a work tree (e.g. git status) in Git work trees which are created
    from a bare repository.
    
    This patch adds a test case illustrating the issue and proposes a fix
    which adjusts the usage of read_early_config() in help_unknown_cmd() to
    match other usages of read_early_config(). In particular the patch
    removes the call to git_default_config() in the read config callback.
    
    Changes since v1 (both suggested by Junio):
    
     * Moved test to 9003
     * Squashed change and test into a single commit

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1373%2Fsimu%2Ffix%2Fautocorrect-bare-worktree-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1373/simu/fix/autocorrect-bare-worktree-v2
Pull-Request: https://github.com/git/git/pull/1373

Range-diff vs v1:

 1:  d0a6eea93b5 < -:  ----------- tests: add test case for autocorrect in work tree for bare clone
 2:  7a2bef32439 ! 1:  4c598dbe778 help.c: don't call git_default_config in git_unknown_cmd_config
     @@ Metadata
      Author: Simon Gerber <gesimu@gmail.com>
      
       ## Commit message ##
     -    help.c: don't call git_default_config in git_unknown_cmd_config
     +    help.c: fix autocorrect in work tree for bare repository
      
          Currently, auto correction doesn't work reliably for commands which must
          run in a work tree (e.g. `git status`) in Git work trees which are
     @@ Commit message
          `git_default_config()`. Instead we also simply return `0` for config
          keys which we're not interested in.
      
     +    Additionally the commit adds a new test case covering `help.autocorrect`
     +    in a work tree created from a bare clone.
     +
          Signed-off-by: Simon Gerber <gesimu@gmail.com>
      
       ## help.c ##
     @@ help.c: static int git_unknown_cmd_config(const char *var, const char *value, vo
       }
       
       static int levenshtein_compare(const void *p1, const void *p2)
     +
     + ## t/t9003-help-autocorrect.sh ##
     +@@ t/t9003-help-autocorrect.sh: test_expect_success 'autocorrect can be declined altogether' '
     + 	test_line_count = 1 actual
     + '
     + 
     ++test_expect_success 'autocorrect works in work tree created from bare repo' '
     ++	git clone --bare . bare.git &&
     ++	git -C bare.git worktree add ../worktree &&
     ++	git -C worktree -c help.autocorrect=immediate stauts
     ++'
     ++
     + test_done


 help.c                      | 2 +-
 t/t9003-help-autocorrect.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index d04542d8261..ae534ff0bae 100644
--- a/help.c
+++ b/help.c
@@ -563,7 +563,7 @@ static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 	if (skip_prefix(var, "alias.", &p))
 		add_cmdname(&aliases, p, strlen(p));
 
-	return git_default_config(var, value, cb);
+	return 0;
 }
 
 static int levenshtein_compare(const void *p1, const void *p2)
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index f00deaf3815..f5b6b4f746b 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -60,4 +60,10 @@ test_expect_success 'autocorrect can be declined altogether' '
 	test_line_count = 1 actual
 '
 
+test_expect_success 'autocorrect works in work tree created from bare repo' '
+	git clone --bare . bare.git &&
+	git -C bare.git worktree add ../worktree &&
+	git -C worktree -c help.autocorrect=immediate stauts
+'
+
 test_done

base-commit: e7e5c6f715b2de7bea0d39c7d2ba887335b40aa0
-- 
gitgitgadget
