Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814DAC43217
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 08:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiJMInU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJMInN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 04:43:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0D15DB37
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:43:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r13so1679073wrj.11
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c9p6wva0W7FqIhQJnIwqTZ3rUpQZJ2jSX0hmUXze58=;
        b=AkGYFCN8LCNDs5Hio/zMKVeMlxzq5TnUvByqASPrQGlrGdXHuKZbr6cLTjkrDM7DMg
         UbA2jh7yx8O8p3qe794+nTE/vqmQPRrYYyRboHOA7Hd9F4Ik3tmEuZXV0AmkohYX06gt
         49morilJs7ao4rzw0MUS7zm1p21zaXXcu0gRrTkoZ7m+fumdyBdbyfibSZi8Dpe6hi0s
         oL7vJtdSi//4yiy/H/vC/2u+6Su+59sfaz4BQWR5OMwzB4K6xxRg0CLgLVMeNOLJhE62
         5ikmy33EJFBOIwTNA6QjMKp244f9iqZkWWkOLVhV0sbTfwrkwoSrgPH3sokcgEzgKD67
         qEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c9p6wva0W7FqIhQJnIwqTZ3rUpQZJ2jSX0hmUXze58=;
        b=36hPA515YFaXqqD5zTYMWLUeSS87eK7rqCL+hUUSef8RwowhCABBXWvgCozmW/6gfa
         6oXkvmex5+dglyKPFBe0Ya10zgfZpIF/8ZX3DK7ZQ1wHpoZTh2fPk3GbdrnKLd8wlU4c
         j3nXQqTvmrDjwAfmz2rHOuzrzU1tYimN0Wq/fQJn4Trjp9UbgxI05Ax6DZEt4Wt7jr3N
         mnqM/B6rPUw+Rdy3X8CXF4WJxc3vo/AHcs//uYhwcr8qb+uOSZVWvTjIDwluCt80OORC
         trfIkZOkg0WKQ46WU38nbx0DsRWzkH7e5kn95nhG0FQp9RTx5Bq+D/+NcBlWuevli7nE
         KrWA==
X-Gm-Message-State: ACrzQf3wO5sp/9XO5+bsDFXluidc1vgjvoCLPNjl8DLUXoVSUfL+Ktrt
        mwWrWwqEUnRDF7pquRB87mXoflIanTQ=
X-Google-Smtp-Source: AMsMyM7PVjbu4fe/zvliqQOZwddSAqLXlibyl7P+Fb2bEOddsyBKvZ4Wrmlpakxoth83/lGqmNGm7Q==
X-Received: by 2002:a05:6000:1845:b0:22f:bfca:6439 with SMTP id c5-20020a056000184500b0022fbfca6439mr15066383wri.298.1665650581152;
        Thu, 13 Oct 2022 01:43:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b0022ed6ff3a96sm1477722wrr.39.2022.10.13.01.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:43:00 -0700 (PDT)
Message-Id: <4d0226e1dcc778ce310f956546e6c18c7d3f4d4b.1665650564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 08:42:44 +0000
Subject: [PATCH v3 8/8] rebase --keep-base: imply --no-fork-point
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Given the name of the option it is confusing if --keep-base actually
changes the base of the branch without --fork-point being explicitly
given on the command line.

The combination of --keep-base with an explicit --fork-point is still
supported even though --fork-point means we do not keep the same base
if the upstream branch has been rewound.  We do this in case anyone is
relying on this behavior which is tested in t3431[1]

[1] https://lore.kernel.org/git/20200715032014.GA10818@generichostname/

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt | 8 ++++----
 builtin/rebase.c             | 6 ++++++
 t/t3431-rebase-fork-point.sh | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index ee6cdd56949..1e2d543ced9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -218,7 +218,7 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	merge base of `<upstream>` and `<branch>`. Running
 	`git rebase --keep-base <upstream> <branch>` is equivalent to
 	running
-	`git rebase --reapply-cherry-picks --onto <upstream>...<branch> <upstream> <branch>`.
+	`git rebase --reapply-cherry-picks --no-fork-point --onto <upstream>...<branch> <upstream> <branch>`.
 +
 This option is useful in the case where one is developing a feature on
 top of an upstream branch. While the feature is being worked on, the
@@ -452,9 +452,9 @@ When `--fork-point` is active, 'fork_point' will be used instead of
 <branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
 ends up being empty, the `<upstream>` will be used as a fallback.
 +
-If `<upstream>` is given on the command line, then the default is
-`--no-fork-point`, otherwise the default is `--fork-point`. See also
-`rebase.forkpoint` in linkgit:git-config[1].
+If `<upstream>` or `--keep-base` is given on the command line, then
+the default is `--no-fork-point`, otherwise the default is
+`--fork-point`. See also `rebase.forkpoint` in linkgit:git-config[1].
 +
 If your branch was based on `<upstream>` but `<upstream>` was rewound and
 your branch contains commits which were dropped, this option can be used
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ecc965c8586..df8f7a8a5db 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1239,6 +1239,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--onto");
 		if (options.root)
 			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
+		/*
+		 * --keep-base defaults to --no-fork-point to keep the
+		 * base the same.
+		 */
+		if (options.fork_point < 0)
+			options.fork_point = 0;
 	}
 	/*
 	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 1d0b15380ed..70e81363569 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -50,7 +50,7 @@ test_rebase () {
 
 test_rebase 'G F E D B A'
 test_rebase 'G F D B A' --onto D
-test_rebase 'G F B A' --keep-base
+test_rebase 'G F C B A' --keep-base
 test_rebase 'G F C E D B A' --no-fork-point
 test_rebase 'G F C D B A' --no-fork-point --onto D
 test_rebase 'G F C B A' --no-fork-point --keep-base
-- 
gitgitgadget
