Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D00EECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 15:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiIAPmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiIAPm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 11:42:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D03874DDB
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 08:42:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay12so9240653wmb.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=nf4twPT1TqiD8Fzhj1tZS8GKn6mD7SFi6fZUL/RXV7o=;
        b=Cz1xG+CO8Rg23sa24Ejrs43DV790ayBLkxCdnLC7sqjneLZuSPaNyCMhCvLhy5LyAL
         oYUOjmnwwgYU9qhy32NqdwIV4yXfgq68unZpG1KkjU6+3dYPZ2FGlHKlo8G1Ewi4PWSx
         GzzxwyEvCFmewTIEmVqZao74xl2HkRuQwJoePtCOmW2ifh+CupThWpHy+TfEylzSEHaF
         Domjfkgijg90R03qroQ3CR00LiILYv67+sQFBfe0Dp2nCMHACBDo/2iZ94yaXbucupB5
         ju57FpQipZ6L7Y/90RztTpAbm+p82Qx00sN3hPjox5xlqchO8eKOtAGIsgqhozXokqn5
         WtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nf4twPT1TqiD8Fzhj1tZS8GKn6mD7SFi6fZUL/RXV7o=;
        b=fImlgT/GlHOUuRln20GdHL8DNamt0pnPq+fh2DOQzG7XwEJP0FppPXExw0wkYCFoe8
         TuUTvV77E8TgrAUftMiA99I4JBiSFft8OhDWu3PDCOVsz/6SIDseLIM0AJJO4xUK2FBW
         6d/gLQkeUWysuNa+eekNkmca3sfbGWK82LmQh6AkiUpFXIf4hFyki9r/7PzMhhB6hrXS
         Gl5UtWxFq/VxCEdZvp1XeuDZS7FB1e6JUZEGPYkGxbRU76ApUExHrucEEi4u0boRP8rZ
         uKIjdqyKK8r8RxXCnteDE43ykKJz5jh7NwZQSznoUETgVYpvxs5bjXPik4H39tRUyC+d
         VE/g==
X-Gm-Message-State: ACgBeo1dXg09hsjXyXDrzg4Ihf4o1S8gyrzRM/JeFZpE5ctxB5fFT1Y+
        Nx3CY8+iwQIA17KR2FEIN2Sr2RMdu24=
X-Google-Smtp-Source: AA6agR7HS845lYuB1cHDb8gT9cmhUm7AD4mkTVeCITUHzMhZa85C1X9qFDzTalPO9+B+m9p9G0cwXA==
X-Received: by 2002:a05:600c:19d3:b0:3a8:3b06:655a with SMTP id u19-20020a05600c19d300b003a83b06655amr5567071wmq.182.1662046945660;
        Thu, 01 Sep 2022 08:42:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c35c500b003a5e9337967sm5772760wmq.13.2022.09.01.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:42:25 -0700 (PDT)
Message-Id: <47943b603b1f2330b36a3050fe7463bca6eeddef.1662046939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
References: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
        <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 15:42:19 +0000
Subject: [PATCH v5 3/3] add -p: ignore dirty submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
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
index a6bd150de51..a6596532867 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -419,7 +419,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	}
 	color_arg_index = args.nr;
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
-	strvec_pushl(&args, "--no-color", "-p", "--", NULL);
+	strvec_pushl(&args, "--no-color", "--ignore-submodules=dirty", "-p",
+		     "--", NULL);
 	for (i = 0; i < ps->nr; i++)
 		strvec_push(&args, ps->items[i].original);
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index a94e7c53c8a..5a7a0ea7e83 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -955,6 +955,18 @@ test_expect_success 'status ignores dirty submodules (except HEAD)' '
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
