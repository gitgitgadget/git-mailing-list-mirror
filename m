Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA59F1F453
	for <e@80x24.org>; Wed,  1 May 2019 13:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfEANLX (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 09:11:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38745 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfEANLU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 09:11:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id w11so8175041edl.5
        for <git@vger.kernel.org>; Wed, 01 May 2019 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gbA0dHfajDivlS81xMaAU1kWSmq8GxlhQXLAOYHsa9A=;
        b=sRLG7D2JrhKF4+jKvcSomnRbuxJiRFneYQLO6qbQ5SWLhhnGzfgYhU7xaOjtj7w/Ym
         RrvM5Xx5YDB1v5ajn2sy7oVuBiOKhPtc467yDxQXP3Mc3M37UhHAIFwsxeHsEWE1/9AU
         ywvVwKT7eACOMEzBfzBoyuNWXG6+N11vtt2SZngpnffzDygiEOJoVSb2HGI/rux21sQt
         qrCH+wyrzXDAIREGlOaIuSgXC8Mb671EB/JiupYVWTkdK/q5qj5TJmBJRiKfAMKldkLx
         Pa50CMfXpC/fVblhiNxsgLoRybNGeh3Dnz6YUP7RKs4mLnI7zqyKF/VJ8zGIG1/H975W
         Ll7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gbA0dHfajDivlS81xMaAU1kWSmq8GxlhQXLAOYHsa9A=;
        b=Ige97QugG8WBvl4m86M3tzZoZTHauaL35bUREEVv6nKhJKlviWUwUgVf7RCh6PHHUo
         LBVRggRO7IHedvBHStMBiSBnRY3hM3A+sRMOLpHROjw/FUMrYVLjcFwXuIZcCH54KIYZ
         9C6vSJHlnlatesZopqO1DDmMlulLbIj0ZEAxnunQ2/4Wl7JS7OC6/HguDNMGUZJWbMHf
         /UnaJETBu4AvnI49G/UOE9ZZtobYam99ud+mqL2zwZ72KXxP287E1jVhA06qM/Ijt6IP
         WG1Lnz/Gbazdt5eXdcEO9zge4o4zwt6Sta7WuTgdH3slqPKJm3EAVv0Bmc0CbkDmEC/O
         ahmA==
X-Gm-Message-State: APjAAAWUT/asGvoBTKFHANtQXT71m2tF2Mps2kQEMKddsDhZF4wYqbjU
        HtDrcIRY5k5PhAh1YIXmLq4J/2Sf
X-Google-Smtp-Source: APXvYqy7U0GVmqwAQVJt8Dvqs10DqJUFZIW1Rhw5ZO9agmjOPXVSRDDeZNIZ9HhTTOyHZM4Gg1eaNg==
X-Received: by 2002:a50:a915:: with SMTP id l21mr46877696edc.164.1556716277874;
        Wed, 01 May 2019 06:11:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p46sm2599783edc.66.2019.05.01.06.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 06:11:17 -0700 (PDT)
Date:   Wed, 01 May 2019 06:11:17 -0700 (PDT)
X-Google-Original-Date: Wed, 01 May 2019 13:11:10 GMT
Message-Id: <6a0e99f9f9d9027f95a47ec97b3bbafda4235522.1556716273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v3.git.gitgitgadget@gmail.com>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
        <pull.112.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 4/6] commit-graph: add --version=<n> option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Allow the commit-graph builtin to specify the file format version
using the '--version=<n>' option. Specify the version exactly in
the verification tests as using a different version would change
the offsets used in those tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  3 +++
 builtin/commit-graph.c             | 13 ++++++++-----
 t/t5318-commit-graph.sh            |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 624470e198..1d1cc70de4 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -51,6 +51,9 @@ or `--stdin-packs`.)
 +
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
++
+With the `--version=<n>` option, specify the file format version. Used
+only for testing.
 
 'read'::
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 7d9185dfc2..e766dd076e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,7 +10,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph verify [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits] [--version=<n>]"),
 	NULL
 };
 
@@ -25,7 +25,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits] [--version=<n>]"),
 	NULL
 };
 
@@ -35,6 +35,7 @@ static struct opts_commit_graph {
 	int stdin_packs;
 	int stdin_commits;
 	int append;
+	int version;
 } opts;
 
 
@@ -156,6 +157,8 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_INTEGER(0, "version", &opts.version,
+			N_("specify the file format version")),
 		OPT_END(),
 	};
 
@@ -168,12 +171,12 @@ static int graph_write(int argc, const char **argv)
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
 	if (opts.append)
-		flags |= COMMIT_GRAPH_APPEND;
+		flags |= COMMIT_GRAPH_APPEND;	
 
 	read_replace_refs = 0;
 
 	if (opts.reachable)
-		return write_commit_graph_reachable(opts.obj_dir, flags, 0);
+		return write_commit_graph_reachable(opts.obj_dir, flags, opts.version);
 
 	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
@@ -193,7 +196,7 @@ static int graph_write(int argc, const char **argv)
 	result = write_commit_graph(opts.obj_dir,
 				    pack_indexes,
 				    commit_hex,
-				    flags, 0);
+				    flags, opts.version);
 
 	UNLEAK(lines);
 	return result;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e80c1cac02..4eb5a09ef3 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -328,7 +328,7 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 
 test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
+	git rev-parse commits/8 | git commit-graph write --stdin-commits --version=1 &&
 	git commit-graph verify >output
 '
 
-- 
gitgitgadget

