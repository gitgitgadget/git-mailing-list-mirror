Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 225A91F4C0
	for <e@80x24.org>; Sun, 27 Oct 2019 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfJ0RQa (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 13:16:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46603 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfJ0RQa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 13:16:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so7426633wrw.13
        for <git@vger.kernel.org>; Sun, 27 Oct 2019 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=55VUvjhLPX5zLDxR8NmwyA8NomYXKpk7FIvKZlCJKqM=;
        b=PKCIb4peu0DRbB6dNbp71CzFLZtCcZMYsHfTD7ZzwGrSAyMiZjOfABdMyMAJcog49P
         lSu0cVACfiHhPpy+rjS11aL3OzjpKWTxOPTzxRVj/6qZQGy0q0kKgapEfaOxaMBO+PbE
         PdeOm1ckHwMvLD9J4he1UgGdZBXmi4gzVrc60uL5J6178h/4sRpGZpHi4gH9tlD6Sg51
         xZYObCVWK11s453uua3c43vQ/hqCWkFgf9ns2Wi+sLXelFSM7D5a/I3/5B9a04MlHgP3
         t52eIX48mjkFPkcxm6POwo5pnZf+CL2DStCFFfes4RSKfYCmB/ML5MIUBHwnV9KFNAm1
         OUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=55VUvjhLPX5zLDxR8NmwyA8NomYXKpk7FIvKZlCJKqM=;
        b=gDar7ccdDPhfBANDsGVdV8qAIBYInHxGtETLX7QUMXaGhDQWa4LIw/jaX3Ykxz8wD8
         6w0LE730QFMxoPNNysMKXb15y+gTiZmbj2FdcZ+jeYUh/rZdegpdamFcJr9jmGt1hw4/
         nbQWrjDizXW/DsmaSScY0F2HqZgCbZUjnwjwE/iJgiMCNrlBygJw4fBYpobH6ogA2zS6
         1Dfhg4TAneBIoD/zJh5iJzW1T+XIrjg3scDtcBohd3Z0VuJTql3NkG5eqKWMvN3cowcd
         T9iUSd178G2e720rQ3zdMhJkZl3KCh3mLErwJIeM58efYQJOUi88k/HPklXm0wl0khg6
         OE3g==
X-Gm-Message-State: APjAAAXLo7iGRy/tw+HNFNiMFVx8A2gx16klr39gWpP+3Vg2JfciDy5q
        vMT5OcXS8D2jT0O42ThOJ2+8lyfO
X-Google-Smtp-Source: APXvYqzE6zYav1PHruX0frKGL4SBQ8lRM+E79nC+dFLsGX5avlAA/VX+guwg9Q5nCKQSlhVwyD2UMg==
X-Received: by 2002:adf:e30a:: with SMTP id b10mr11247064wrj.44.1572196587994;
        Sun, 27 Oct 2019 10:16:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm9760163wrj.35.2019.10.27.10.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 10:16:27 -0700 (PDT)
Message-Id: <e707bcc0a8482a8e8e82ecb259fa0dff84e63955.1572196585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.430.git.1572196585.gitgitgadget@gmail.com>
References: <pull.430.git.1572196585.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Oct 2019 17:16:25 +0000
Subject: [PATCH 1/1] worktree: teach "add" to ignore submodule.recurse config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

"worktree add" internally calls "reset --hard", but if
submodule.recurse is set, reset tries to recurse into
initialized submodules, which makes start_command try to
cd into non-existing submodule paths and die.

Fix that by making sure that the call to reset in "worktree add"
does not recurse.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/worktree.c      |  2 +-
 t/t2400-worktree-add.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a5bb02b207..958bea97fe 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -377,7 +377,7 @@ static int add_worktree(const char *path, const char *refname,
 	if (opts->checkout) {
 		cp.argv = NULL;
 		argv_array_clear(&cp.args);
-		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+		argv_array_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
 			argv_array_push(&cp.args, "--quiet");
 		cp.env = child_env.argv;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index e819ba741e..8a9831413c 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -587,4 +587,28 @@ test_expect_success '"add" should not fail because of another bad worktree' '
 	)
 '
 
+test_expect_success '"add" with uninitialized submodule, with submodule.recurse unset' '
+	test_create_repo submodule &&
+	test_commit -C submodule first &&
+	test_create_repo project &&
+	git -C project submodule add ../submodule &&
+	git -C project add submodule &&
+	test_tick &&
+	git -C project commit -m add_sub &&
+	git clone project project-clone &&
+	git -C project-clone worktree add ../project-2
+'
+test_expect_success '"add" with uninitialized submodule, with submodule.recurse set' '
+	git -C project-clone -c submodule.recurse worktree add ../project-3
+'
+
+test_expect_success '"add" with initialized submodule, with submodule.recurse unset' '
+	git -C project-clone submodule update --init &&
+	git -C project-clone worktree add ../project-4
+'
+
+test_expect_success '"add" with initialized submodule, with submodule.recurse set' '
+	git -C project-clone -c submodule.recurse worktree add ../project-5
+'
+
 test_done
-- 
gitgitgadget
