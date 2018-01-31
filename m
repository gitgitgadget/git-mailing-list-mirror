Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694D21F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbeAaLIl (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:41 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41965 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbeAaLIj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:39 -0500
Received: by mail-pf0-f193.google.com with SMTP id c6so12244490pfi.8
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sd3kcM8e7HSR9/ldRCUtcfRgvdtngqJ6N9I0n5hX0jw=;
        b=I7qSO5oenGiQqHzTMuu90nXOWh9agLlOV3ksCd8uf+Q0Lx5XwA5fGTFlJvD3WZs9Jv
         HLKg6bchHz8DnFWXfFSjIYwacWnd99jcrfCYWkGHTUg59VFxTyX0WqBmXk/EARbOGqLJ
         0PlvBJXbXyZrOwaRG+/cuxK28zOnJQ8Jq8NYVMCUXmI9y/Ti2WcCJ4rbqpHcwPdcxasS
         FJda/o3F4YO3OdDXNVuDD5iUTsT/NaJhhnR3VIjB1bHvnG4VzT96htis+x5oiko7XRFm
         0u1mAb1HSd6mKrCGJEUAw3fji5DEH4pu4fR0C8INMVeKY6c8LtDtyVQoq7DNAw+gkqyT
         YgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sd3kcM8e7HSR9/ldRCUtcfRgvdtngqJ6N9I0n5hX0jw=;
        b=C7bwKKS+Lc4RZJn2cYYaq0Va4aerLmZ+oXf35iy3j72CI5OJOzz0n9/Gqwe+peWNL9
         Zx/aUoWshPCnlNHWgCtR66Ci92Ze1HNSzcoYPFSr7JopzS17N7o/mLoK9chM/ckvIhWu
         E6VGvGcJwS3EoEfqGLaPgfp7SKafWNZF/JKAFqLJPgSz7GJ36W3fkkp0LDX7Hoox+djU
         I1xQ/fDlrPOnLj+bwqo6GX7cqYi+uMJ2CobuSxNdLwNK2lTBu2KByYB+A5gueML/eTeq
         /sfkB4gFs/lN2gY/YwrUXI5Ltg7Y6DAWT9zHVYNSvU9CrHQ2Od8gH88IUnJvS8QkzAN7
         hjXw==
X-Gm-Message-State: AKwxytdELzfrRBz10tU+4XC7n4DUGYDhMjiRLCj0mUUUJ5bPmGjIaWPp
        YanOsIhVaCqi3qlz23ivWN8VMw==
X-Google-Smtp-Source: AH8x226u/4i1aSBmVJNuGR7jQM2cAXs77ibHWstvcf/0cZv+tVoInpGoxdjOw42WGU4pdJ7Pc4aZQw==
X-Received: by 2002:a17:902:930c:: with SMTP id bc12-v6mr28643933plb.328.1517396919212;
        Wed, 31 Jan 2018 03:08:39 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id q10sm39146807pfh.178.2018.01.31.03.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 36/41] completion: use __gitcomp_builtin in _git_revert
Date:   Wed, 31 Jan 2018 18:05:42 +0700
Message-Id: <20180131110547.20577-37-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable option is --gpg-sign

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/revert.c                       | 12 +++++++++---
 contrib/completion/git-completion.bash |  5 +----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b9d927eb09..c8e045911b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -96,9 +96,15 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	const char *me = action_name(opts);
 	int cmd = 0;
 	struct option base_options[] = {
-		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
-		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
-		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
+		OPT_CMDMODE_F(0, "quit", &cmd,
+			      N_("end revert or cherry-pick sequence"),
+			      'q', PARSE_OPT_NOCOMPLETE),
+		OPT_CMDMODE_F(0, "continue", &cmd,
+			      N_("resume revert or cherry-pick sequence"),
+			      'c', PARSE_OPT_NOCOMPLETE),
+		OPT_CMDMODE_F(0, "abort", &cmd,
+			      N_("cancel revert or cherry-pick sequence"),
+			      'a', PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a830c9c854..d6215c494e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2687,10 +2687,7 @@ _git_revert ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--edit --mainline --no-edit --no-commit --signoff
-			--strategy= --strategy-option=
-			"
+		__gitcomp_builtin revert "--no-edit"
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

