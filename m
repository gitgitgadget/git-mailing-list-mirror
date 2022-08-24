Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F1C48BE4
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiHXVWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbiHXVV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:21:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42EB165BC
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:21:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e20so21771885wri.13
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=S23Yrq2a5cJCgvTqD4EtlmQDsQQqxQPl5o1PKt5LxgI=;
        b=cTZ34AVF/AdbQkcJlbNu8m9FX4lIle3yPsmcUtIeJfHTVavdMwGbPhB1uvWxHMZ8YS
         uWxuGXeshXqeOuDWQN30UrGli2Z09anrQmGyGvRoW/5szgPs/L5NxuHhwMTV3/JH8Ey5
         Si1KkKFtY6YH6cgTTrnBNxmdplCc6dOZuXmLFX4BzKg21sZmRDtS6Gj+h561VIh/FnEI
         NoHjEU/d5Eb8n1SGS0DA0miT+5t6168N4N0cvM3KiWUy7b148OYFM9foG8uWnjzShlrt
         FLnaxr7lfd6hSYZAWp3CXVmWr+aQEvXVHFRR2+hjEqbGhuauC680xdkzotDxSsVHpjzv
         8SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=S23Yrq2a5cJCgvTqD4EtlmQDsQQqxQPl5o1PKt5LxgI=;
        b=2M6PXDCiKbKnz9CrN60FQux7U5IHSWXGbtrj1TyfOiPtweTIlHfhLz3+miae4esN9e
         GS8nCmWoMkDEzsc1mJ9XYTdR7iJ1Tt7aXHSC0UUrBO8/jb5/JRDjOfkOCqLW+d7whg4B
         P4YkGNFB74IDmw3cWU24LYDnwHUYm1ABa8fqQcNWwm/fF/bP1l2dkY5ryybiDg2foaR9
         N1SKMdjtm23oEsMDQUklUUlOLLoSlEIbhTbme3RUswQ10ADxlGdfqIiDgAmoWxQ/OlRj
         pqLDKZK4LrtdwoYdkaD+SMFE6xKBvaD+cqsDtR1xX+iEdrZEEEaKmzBohvb3Ud+1MMyx
         svKA==
X-Gm-Message-State: ACgBeo3gaNVXLvpzutJOe7jwA1nihlDa5i8Le8ORnRLD7t/8c1BwiMgM
        dNJ6eg8AHw6g0oIttydHDnZnb8k11o4=
X-Google-Smtp-Source: AA6agR71Z4Ldk9ABk6sdwiY9dcpTcPnHdyn/607E1gJIl6veccAjoetAThFr7HZ9NSqov+WvzDqpkA==
X-Received: by 2002:a05:6000:1210:b0:225:5eeb:fdf3 with SMTP id e16-20020a056000121000b002255eebfdf3mr549756wrx.334.1661376116764;
        Wed, 24 Aug 2022 14:21:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh19-20020a05600c3d1300b003a54d610e5fsm3253706wmb.26.2022.08.24.14.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:21:56 -0700 (PDT)
Message-Id: <540ce27c38a68bebc9504a1cb19fb4076f87ae1c.1661376112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
        <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 21:21:51 +0000
Subject: [PATCH v2 4/4] add -p: ignore dirty submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks to alwyas running `diff-index` and `diff-files` with the
`--numstat` option (the latter with `--ignore-submodules=dirty`) before
even generating any real diff to parse, the Perl version of `git add -p`
simply ignored dirty submodules and does not even offer them up for
staging.

However, the built-in variant did not use that flag because it tries to
run only one `diff` command, skipping the unneeded
`diff-index`/`diff-files` invocation of the Perl variant and therefore
only faithfully recapitulates what the Perl code does once it _does_
generate and parse the real diff.

This causes a problem when running the built-in `add -p` with
`diff-so-fancy` because that diff colorizer always inserts an empty line
before the diff header to ensure that it produces 4 lines as expected by
`git add -p` (the equivalent of the non-colorized `diff`, `index`, `---`
and `+++` lines). But `git diff-files` does not produce any `index` line
for dirty submodules.

The underlying problem is not even the discrepancy in lines, but that
`git add -p` presents diffs for dirty submodules: there is nothing that
_can_ be staged for those.

Let's fix that bug, and teach the built-in `add -p` to ignore dirty
submodules, too. This _incidentally_ also fixes the `diff-so-fancy`
problem ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                |  3 ++-
 t/t3701-add-interactive.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 1f3f3611ee9..64807e7cdc0 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -417,7 +417,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	}
 	color_arg_index = args.nr;
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
-	strvec_pushl(&args, "--no-color", "-p", "--", NULL);
+	strvec_pushl(&args, "--no-color", "--ignore-submodules=dirty", "-p",
+		     "--", NULL);
 	for (i = 0; i < ps->nr; i++)
 		strvec_push(&args, ps->items[i].original);
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 9deb7a87f1e..10058b7ce42 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -941,6 +941,18 @@ test_expect_success 'status ignores dirty submodules (except HEAD)' '
 	! grep dirty-otherwise output
 '
 
+test_expect_success 'handle submodules' '
+	echo 123 >>for-submodules/dirty-otherwise/initial.t &&
+
+	force_color git -C for-submodules add -p dirty-otherwise >output 2>&1 &&
+	grep "No changes" output &&
+
+	force_color git -C for-submodules add -p dirty-head >output 2>&1 <y &&
+	git -C for-submodules ls-files --stage dirty-head >actual &&
+	rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
+	grep "$rev" actual
+'
+
 test_expect_success 'set up pathological context' '
 	git reset --hard &&
 	test_write_lines a a a a a a a a a a a >a &&
-- 
gitgitgadget
