Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5C21FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965659AbdCXSmW (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:42:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35202 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965618AbdCXSmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:42:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so2299844wmb.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtdHBDGHJrNZf7jSmL+O5yspx+GTVuMpaAIlFri+7bg=;
        b=aVCcrla9V3Zlp8tzpDSzZWvP2DmH9NZMOdGDUWEojyV3gCCMeTzWsIpruCMsCzwog0
         O53AqMjbc4no3hZxsJKoqZcm08nWNlFRUmAKXK2Rag8q2nqQ5h+fJqaEMGG3SnRR8n3c
         RLC+Q8ScDwSzrWefXFQdlpS1asGxdTNcq1AzecHuyl7rpC4GSXyGrE/aMPmXfvvkO5X+
         IACNXhlf4lhONDsfILV9sYzNEJJ3glhyeKOal2VIAlr1Q5VyA0PSMJ+s/+v7RZ9eK8Ab
         RGfQBC5IYNIxIolnD5ItHEQVtJZZt7fq5sEOQCiHigu5s4pb1qGKR2b0VIC6zZUUish2
         TnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtdHBDGHJrNZf7jSmL+O5yspx+GTVuMpaAIlFri+7bg=;
        b=efq8Nh5cRMEiwtgvzmjEb2KYi/a2ZBNTE00rl3dswOdu3XUByxWArmOHgGaQSQl7Kg
         KDRfDpdNbRApjgTiob1Nim7GdsUCiu8NWf/5Z8ziGRk+/hIJkGB8g2gMCn3m2vtnJJ85
         DZuYLq+khwkaVMZoe462sTMC6+UwITkM8r0mpEtnEy7qmYqAbxFZiIHWV5aQb7RPM2Te
         iT/98DrXr1JAIUGPjFpQ9iJEg/KLB2Qslp9+ingKwFYrMswfn+4hTxMWu1rmk9E6r4Ey
         yOQGmIotL6yCD0/o5T9LWZuY6BYF/8rivsl6XI/XFlxypE9q03AAhE+tqJggXyQ3MYMo
         TOtA==
X-Gm-Message-State: AFeK/H1WyplgplgkG/2faV/+p/+sYM6SWPHUjmhtedxdW32JTQGYI6N4ZXS8QeMaZ22BBQ==
X-Received: by 10.28.212.85 with SMTP id l82mr4416864wmg.45.1490380919351;
        Fri, 24 Mar 2017 11:41:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 15/16] ref-filter: reflow recently changed branch/tag/for-each-ref docs
Date:   Fri, 24 Mar 2017 18:40:58 +0000
Message-Id: <20170324184059.5374-16-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reflow the recently changed branch/tag-for-each-ref
documentation. This change shows no changes under --word-diff, except
the innocuous change of moving git-tag.txt's "[--sort=<key>]" around
slightly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-branch.txt | 15 ++++++++-------
 Documentation/git-tag.txt    |  7 ++++---
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index e4b5d5c3e1..5e175ec339 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -10,9 +10,9 @@ SYNOPSIS
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
-	[--column[=<options>] | --no-column]
+	[--column[=<options>] | --no-column] [--sort=<key>]
 	[(--merged | --no-merged) [<commit>]]
-	[--contains [<commit]] [--no-contains [<commit>]] [--sort=<key>]
+	[--contains [<commit]] [--no-contains [<commit>]]
 	[--points-at <object>] [--format=<format>] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
@@ -36,11 +36,12 @@ as branch creation.
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
-named commit), `--no-contains` inverts it. With `--merged`, only branches merged into the named
-commit (i.e. the branches whose tip commits are reachable from the named
-commit) will be listed.  With `--no-merged` only branches not merged into
-the named commit will be listed.  If the <commit> argument is missing it
-defaults to `HEAD` (i.e. the tip of the current branch).
+named commit), `--no-contains` inverts it. With `--merged`, only branches
+merged into the named commit (i.e. the branches whose tip commits are
+reachable from the named commit) will be listed.  With `--no-merged` only
+branches not merged into the named commit will be listed.  If the <commit>
+argument is missing it defaults to `HEAD` (i.e. the tip of the current
+branch).
 
 The command's second form creates a new branch head named <branchname>
 which points to the current `HEAD`, or <start-point> if given.
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 1be6570c90..f8a0b787f4 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,9 +12,10 @@ SYNOPSIS
 'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [--contains <commit>] [--points-at <object>]
-	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
-	[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
+'git tag' [-n[<num>]] -l [--contains <commit>] [--contains <commit>]
+	[--points-at <object>] [--column[=<options>] | --no-column]
+	[--create-reflog] [--sort=<key>] [--format=<format>]
+	[--[no-]merged [<commit>]] [<pattern>...]
 'git tag' -v [--format=<format>] <tagname>...
 
 DESCRIPTION
-- 
2.11.0

