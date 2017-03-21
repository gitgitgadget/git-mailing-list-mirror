Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3212095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757455AbdCUNA7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:00:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35537 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757344AbdCUNAz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so2790430wmb.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=amMXUhlusFx22/t5UdWTYlwEY6uc8SaGqWIiJ4HVzuk=;
        b=tV6LtCO9ZfwGWgG4KMkqrvWTRHZRyDbVtcgzUggmrUaQlO5Ed2aMwld9LZmyZjv3XX
         pc9iNJiscKGU8nCbsmxbbaZPjHbe8VULX318DH7kL1Dxkl2ZqJZZbFEPYHMxM1lK3TOe
         eOfmAszd9Mdb6vbJr8IZwPj/iqfzQTFrMcNkQBo1/rpJRMFHDgLNwX9c9v8drFu7bHUp
         Mmu+rG8HUw23OYrduUB9Lki95fgOx6Uk+GF9U5VeXOGr6p5DSfJF51TLiCPF3xP9puWb
         dQiLt8dGRxBK+70JTHwZdGGx9PHJJGs3b1HaKTxrSFqARXDqZXIU9PsDdmYujyPE+gPF
         TsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=amMXUhlusFx22/t5UdWTYlwEY6uc8SaGqWIiJ4HVzuk=;
        b=KT8JX5E5kVITQvsXEYkX8HKzj9Hechk+YkFoPBSjY7Y8QkHqN1jO60ZeSS05uM5IxY
         s81qV0mVZik1tgIm4n6uo4msRkFBsSLVHI7/aSAQNylVHC7xqzTouoKl/STc5ha96ufB
         z0mP+Z3dWu/YAV67GKbV/NALa82Xi/4GltdNoV9hJWx+p4RoeOrs+CiHFKR7JGIxJkSw
         Xx4IN8KXVIB4O6c1gQYA6kCnZ0/2p+dBUViRv3hqqeRptoy32g9LFUIK4fhXPFTuyG+C
         tZ7mkDd8GdAHfzbe7au4obBxzgDAprVd0r8wGdIJnKFoAgAvEbB2Y+NuwAaipoyo9XT4
         EMJg==
X-Gm-Message-State: AFeK/H1CAWYf8EkRfn0D3PtjFXgk/rK7L5jfI/jRHsz11Hu4MV/yXUnab+wTyIzdsYV2VA==
X-Received: by 10.28.65.196 with SMTP id o187mr2706315wma.9.1490101253745;
        Tue, 21 Mar 2017 06:00:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:00:53 -0700 (PDT)
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
Subject: [PATCH v2 14/16] ref-filter: reflow recently changed branch/tag/for-each-ref docs
Date:   Tue, 21 Mar 2017 12:58:59 +0000
Message-Id: <20170321125901.10652-15-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reflow the recently changed branch/tag-for-each-ref
documentation. This change shows no changes under --word-diff, except
the innocuous change of moving git-tag.txt's "[--sort=<key>]" around
slightly.
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
index b399b91931..c249072001 100644
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

