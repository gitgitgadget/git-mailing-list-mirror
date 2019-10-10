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
	by dcvr.yhbt.net (Postfix) with ESMTP id 185591F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 12:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfJJMBn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 08:01:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41335 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfJJMBn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 08:01:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so7547936wrm.8
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 05:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c2XsSggU7/6p8VKHegC/I8senjOvwqwUMY2ghRuiTmo=;
        b=P5Q90Wy3+MgcrISZubJUxMUu7NKGIHjkHnst3kUbBBu4UoxWKIaui93H8xn8ezd5ME
         Mw2bvvfGDBSFRWt2zwRaA+mYSgVRucBLzRYuBr7xE3ijZ7HdAZpNyRC+VMJXEedrfT2z
         dXZf862B6PceYTzT41J5IRaJ8qxAFJz1QHOdWRYpdUeab7LQ4tzOoTgR+k8XVOygmqiO
         bub4pGeED6pijkOa5rFDFCX/fau9T28UNCwNqr3iLjWIEJhKj4AwAam9F0zy3BrlBfaj
         Ux6jP8E0Nuc/1JnSW2JLo9TRRkbO2DA49IH8uDWTuXt8qWNih9BJyZwqaTnNjwFrT/5N
         jriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c2XsSggU7/6p8VKHegC/I8senjOvwqwUMY2ghRuiTmo=;
        b=gqJkhWt/TsK1GlJ4deg3Tifq4A0Kq7doDSrfOJFRECaoj5uHCWSQceQydfJ+HeWxaJ
         vIRdnskwxgq56kesHOUbv2udLwDGOqY+b564uC/E4tmmpDs+j+V341QX8Dg4KfrJ4rll
         qL9dNW8XrQIjxFaAs+msIO50HfknWQzZ6FXgq2lGUkEgC3hpqkiQaVBotZM4qKmCmSiJ
         kNBs3ZUWdfA0h1vZFBGLltYlotgBnOuIPWa4+DJN5Cty4qvjWghJDJ76INZgx/mtBxoQ
         gnAio3gN2WbNucrhvU3CFeMMbE0IU7909R5s+6eCt9yblQvcEdbKAH3BtJr2PCE36aqZ
         jC4g==
X-Gm-Message-State: APjAAAU9/PyP/vljESlfERDwfo4UMe8dmUbpC76JCZnU+igODIFFqjA+
        dsw+1PnhVhAdxOICKtwekkIgfzIN
X-Google-Smtp-Source: APXvYqzt+2yRg8P5M2sZQCe5OhW2guh3RicMS+2a8a5VEe91ADURKoP1HuXnc0C2MVi9tG3LMGt9xQ==
X-Received: by 2002:adf:facc:: with SMTP id a12mr8518493wrs.109.1570708899953;
        Thu, 10 Oct 2019 05:01:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm5990842wrt.59.2019.10.10.05.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 05:01:39 -0700 (PDT)
Date:   Thu, 10 Oct 2019 05:01:39 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 12:01:37 GMT
Message-Id: <83305732371f3f511b3f4acf2060610c80ad12fa.1570708898.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.385.git.gitgitgadget@gmail.com>
References: <pull.385.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] switch/restore: consistently pass through exit code of
 `post-checkout`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Magne Land <magne.land@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Currently, the exit code of the `post-checkout` hook becomes the exit
code of the `git restore` (or the equivalent `git checkout`) command,
_iff_ no error occurred during the `restore` operation.

That allows versatile scripting where the `post-checkout` failure modes
can be discerned from the `git restore` failure modes.

There is a problem, though: if that `git restore` operation fails
_before_ the `post-checkout` hook is run, -1 is returned from the
`checkout_paths()` function, which yields the misleading exit code 127
(which is reserved to indicate "command not found").

Another problem: a non-zero exit code of the `post-checkout` hook as run
at the end of a `git switch` run will always causes that command to exit
with exit code 1.

This is inconsistent. Let's pass through the exit code of the
`post-checkout` hook verbatim (unless the Git operation fails, in which
case we want to exit with code 1, even if the hook returns another exit
code).

Document this, and add a regression test for this behavior, too.

Inspired-by-a-patch-by: Magne Land <magne.land@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/githooks.txt    | 3 ++-
 builtin/checkout.c            | 8 +++++---
 t/t5403-post-checkout-hook.sh | 9 +++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 50365f2914..12c756a37b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -193,7 +193,8 @@ worktree.  The hook is given three parameters: the ref of the previous HEAD,
 the ref of the new HEAD (which may or may not have changed), and a flag
 indicating whether the checkout was a branch checkout (changing branches,
 flag=1) or a file checkout (retrieving a file from the index, flag=0).
-This hook cannot affect the outcome of `git switch` or `git checkout`.
+If this hook exits with an exit code other than 0, it causes the calling
+`git switch` or `git checkout` command to fail with the same exit code.
 
 It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
 used. The first parameter given to the hook is the null-ref, the second the
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1283727761..56afc3c1a8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -400,7 +400,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	static char *ps_matched;
 	struct object_id rev;
 	struct commit *head;
-	int errs = 0;
+	int errs = 0, ret;
 	struct lock_file lock_file = LOCK_INIT;
 	int checkout_index;
 
@@ -548,8 +548,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	read_ref_full("HEAD", 0, &rev, NULL);
 	head = lookup_commit_reference_gently(the_repository, &rev, 1);
 
-	errs |= post_checkout_hook(head, head, 0);
-	return errs;
+	ret = post_checkout_hook(head, head, 0);
+	return !errs ? ret : (errs < 0 ? 1 : errs);
 }
 
 static void show_local_changes(struct object *head,
@@ -1062,6 +1062,8 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
 	free(path_to_free);
+	if (ret > 0)
+		return ret;
 	return ret || writeout_error;
 }
 
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index a39b3b5c78..60ce81f6db 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -73,4 +73,13 @@ test_expect_success 'post-checkout hook is triggered by clone' '
 	test -f clone3/.git/post-checkout.args
 '
 
+test_expect_success 'exit code of post-checkout hook is passed through' '
+	mkdir -p exit-code &&
+	echo "exit 123" | write_script exit-code/post-checkout &&
+	test_expect_code 123 \
+	git -c core.hooksPath="$PWD/exit-code" switch -c trigger-exit-code &&
+	test_expect_code 123 \
+	git -c core.hooksPath="$PWD/exit-code" restore .
+'
+
 test_done
-- 
gitgitgadget
