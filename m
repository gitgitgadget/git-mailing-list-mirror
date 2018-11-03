Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C00A1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 19:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbeKDEaj (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 00:30:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41452 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeKDEaj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 00:30:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id c25-v6so4343912edt.8
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GSI9P1eTSSlnHBg3zb5IpdK2SboQc6J5/xrfVC93zh4=;
        b=WpKOGSim2E7UIzq0U2gIF1nmwwNQmubZXvjC60BqZgHOy9WddtPIkhlKhggoPUHFzI
         mz2cr87vwZ01L3cZj8C93MpUp1Ov2TO48buERIjxxU8cWYQRqKrUC6E0hcKTfLzMwKYb
         thpBelUsqxh/nSF5q5CnCuSNNhdaNxtVl5S07Y2liTMnEnX8qXkbgMc0jGsPJPB18HU2
         dYADztRXxkMlJqy+vLvSWgkBmdD9CJdUUW0/W4oqsxCv/VO/7SMWSox58dQjYt1YVtB9
         UcCL4VzjtrEsz9X+DMhSHJIPkdl/wsWygPxu2hDtVvRYC4qbp1whbYPh0E84dgN8eplQ
         YuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GSI9P1eTSSlnHBg3zb5IpdK2SboQc6J5/xrfVC93zh4=;
        b=GnSCTgraAZV+KMhfG89SCtNhXXTtisgBqeElua4AO65Zd/eq2NgJ/Fe8xsqYV1ScIh
         NTuO34iAQcDl6JS0YC3nIDpWWljFQe+0iHnaC3sYsguYS0KOyEqBocf/8Cem/WBjaDN6
         HtmJ+jxQ/0cQrBl66EAJoPfyyJhd5TUi5Ge7ue0hBaTT7j0NFGTtzxhTu6ELXSLd47hQ
         JOrSHTgOmP+TT1BT/jahPbPmkL91eFDmtlv3tNU1Lt7+2qIv47M0GszElLA3PWFyBUXp
         3I7P4tAtfuXl0x4Yh7AdbWjRnb7qagM48xkUdTaFcpCStuR0buq66PNmbHDGxnswDRfG
         4aUw==
X-Gm-Message-State: AGRZ1gKcPVQhwhwQotsGztv81ES0Q71zGSdmI7PP4HzN1YmNYg/DNE5+
        j4cKNP/u/BL8Txx2KjU8U5fBK+C2Cww=
X-Google-Smtp-Source: AJdET5eDANwMky43nNGf9brAvwIxSgkKfYn3ABw2tBf26fvNhEBx5zY5D5dO4+OrvFe10xyaH+gLgg==
X-Received: by 2002:a05:6402:13c8:: with SMTP id a8mr12072172edx.39.1541272707376;
        Sat, 03 Nov 2018 12:18:27 -0700 (PDT)
Received: from localhost.localdomain (d40a6ba6.rev.stofanet.dk. [212.10.107.166])
        by smtp.gmail.com with ESMTPSA id d21-v6sm1305825edq.93.2018.11.03.12.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 12:18:26 -0700 (PDT)
From:   Mikkel Kjeldsen <commonquail@gmail.com>
To:     git@vger.kernel.org
Cc:     Mikkel Kjeldsen <commonquail@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, "Simon A. Eugster" <simon.eugster@eps.ch>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH] checkout: add synonym of -b
Date:   Sat,  3 Nov 2018 20:18:24 +0100
Message-Id: <20181103191825.15674-1-commonquail@gmail.com>
X-Mailer: git-send-email 2.19.1.802.g3cec6c1c3f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add --new-branch as a long-form synonym of -b. I occasionally encounter
some confusion in new users having interpreted "checkout -b" to mean
"checkout branch", or internalized it as "the way to create a new
branch" rather than merely a convenience for "branch && checkout". I
think an explicit long-form can help alleviate that.

Signed-off-by: Mikkel Kjeldsen <commonquail@gmail.com>
---

Notes:
    This makes the synopsis and description lines look a little clumsy (and
    I think incorrect...?) so if this proposal is accepted perhaps those
    parts are better left out. It is meant more for training and
    documentation than regular usage, anyway.
    
    I thought I had seen something like "--create-branch" in use by another
    command and had intended to use that but I can no longer find that and
    so went with "--new-branch" named after the option's argument.
    
    There does not seem to be a practice for testing short- versus long-form
    arguments so I did not include one, but I'd be happy to.

 Documentation/git-checkout.txt | 5 +++--
 builtin/checkout.c             | 2 +-
 t/t9902-completion.sh          | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 801de2f764..7651d8b83d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [<branch>]
 'git checkout' [-q] [-f] [-m] --detach [<branch>]
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
-'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
+'git checkout' [-q] [-f] [-m] [[(-b|--new-branch)|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' [<tree-ish>] [--] <pathspec>...
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
@@ -52,7 +52,7 @@ You could omit <branch>, in which case the command degenerates to
 rather expensive side-effects to show only the tracking information,
 if exists, for the current branch.
 
-'git checkout' -b|-B <new_branch> [<start point>]::
+'git checkout' (-b|--new-branch)|-B <new_branch> [<start point>]::
 
 	Specifying `-b` causes a new branch to be created as if
 	linkgit:git-branch[1] were called and then checked out.  In
@@ -154,6 +154,7 @@ on your side branch as `theirs` (i.e. "one contributor's work on top
 of it").
 
 -b <new_branch>::
+--new-branch=<new_branch>::
 	Create a new branch named <new_branch> and start it at
 	<start_point>; see linkgit:git-branch[1] for details.
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..4a27d94a86 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1232,7 +1232,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
-		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+		OPT_STRING('b', "new-branch", &opts.new_branch, N_("branch"),
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 175f83d704..00614fdcc5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1428,6 +1428,7 @@ test_expect_success 'double dash "git checkout"' '
 	--ours Z
 	--theirs Z
 	--merge Z
+	--new-branch=Z
 	--conflict=Z
 	--patch Z
 	--ignore-skip-worktree-bits Z

base-commit: d582ea202b626dcc6c3b01e1e11a296d9badd730
-- 
2.19.1

