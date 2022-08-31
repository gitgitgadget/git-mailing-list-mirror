Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB2ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiHaUbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiHaUb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:31:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF23ADEA61
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:31:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n17so19734144wrm.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=+hBrOL8Dca+RUgK/6ufJERYm9VBDUOLT2dFYPIEr2Fk=;
        b=Ncz06QkoDYEATMPZ7mGbdEytv3adTXhj3mSUlptMpkM8QeieJVAPp6CO9lkCRLQC1b
         +GYaKWYw/uXU/SnKA42RxhhGIn5VvwEADNN9Mq5eZOxb8P+l6fofZcfCD8B2eAIo+Faz
         TH7SOxQHQkYxBmc2B+UB8Sl2JKPPDo29d0NVIHtL9+bdFE93dWHxSu3cn5afYOrJoy1+
         VnO0Vkd24UOcdo7NjGSWyLP8kTO14SOcMqGS8EOJYUE7jgUDuU35nZD+TOoAdksQZ79U
         L1IAJEfoIiTT24A4WGAWteF9tR5cRj39ic+62sSOGz+RJKNT59vP/Vb9tVscxHDMc3fa
         QuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=+hBrOL8Dca+RUgK/6ufJERYm9VBDUOLT2dFYPIEr2Fk=;
        b=T+Mh6/7JfBuwcAHgLUFqZrBslZlCarN4qBwCaerH4Q9xLuNM9ImGrEZLg+rVLJkvK2
         dIG/FjzrKIYXf0LSmE1uA1Yyhiu3yNanKNk0rOMqf2BOWCF6AiT326quN+BOiOp2ym7F
         UOri+OxWPVupGsuecC/RuRi+RNZjlKuusWNdxTV9Azk71FAPbSKSofu2PKyxsYlppp0m
         th62sxIi4Ib3zayoYohhsJj8NpL5PXmd0oQ8KGLQIdfh2PAHw0lTAUjfPms6CbWYsP9n
         MHiYrFDo07B3Q3TZytyK8IOrnxD0aF8QZiwaDDqmCIldkI1PQB0LwUwo4iUYbI8PwEFR
         sjnA==
X-Gm-Message-State: ACgBeo1wpAsZdrTwjX+SYehCyHQb+1UNjdFwq5DsOJRZn05oXvcdMm5d
        XqQTSR6i2B+B0plJoMDb8eBCJcDBceQ=
X-Google-Smtp-Source: AA6agR6ngS5npnOJA2wVmcmZmwPTCUIWkqUyhltztu7+C0Kp56RZryhMhuyWd7PgRDxjp2NZjwbnBw==
X-Received: by 2002:a05:6000:78d:b0:226:d5c1:5ebd with SMTP id bu13-20020a056000078d00b00226d5c15ebdmr10417764wrb.565.1661977884040;
        Wed, 31 Aug 2022 13:31:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az26-20020adfe19a000000b0022529d3e911sm13717397wrb.109.2022.08.31.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:31:23 -0700 (PDT)
Message-Id: <116f0cf5cabee3590957731740b33e800b762f34.1661977877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
        <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 20:31:17 +0000
Subject: [PATCH v4 3/3] add -p: ignore dirty submodules
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
index 3699ca1fcaf..c7eebe9de89 100644
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
index 47ed6698943..2d710645719 100755
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
