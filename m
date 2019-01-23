Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92F91F453
	for <e@80x24.org>; Wed, 23 Jan 2019 21:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfAWV7W (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 16:59:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37956 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfAWV7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 16:59:20 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so2954619ede.5
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 13:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WK4pOERtgzeysttqPNBR+dwND7YX0Bo1nbAcBF7zGoI=;
        b=j+0BegA5HuHtSgbH5/3iR8xyc6YSqnpHwU414zkPfh4sxw/KNkrr+PqwAhrmA07CSp
         FG1zBdrKkqL09mawnTIKv25JyhmEbyjtwFa8z8ifXlyLVH660Z6dHNf6u7isScA71zmK
         u4nlD+beZR5vJK3OHlQhuHkrVBIHDhTAHkMroP+PjTsokXewVL5T0pLbqbiudrQTA4H8
         EvZt3mPqtMbCw5KlcqBUR0XnajycujkBvj9NjJ97fb4XNUi/3D/4mIlQaIns29IqOR8g
         Zn2vr5ZLJai7hFzoLQGr2P19+4kCrAsR5VfWHSPYbEHmppTBy9ynqcV5XieN+AR8saET
         HjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WK4pOERtgzeysttqPNBR+dwND7YX0Bo1nbAcBF7zGoI=;
        b=SUtJ4bsrErmtddGOrHInV9HxnIeF+vJjSbvtDSjMRYLYBi75QN7h31yg1gmw1reNIP
         5ShfLfG50hQ1nJrWCSh+ZB/ZqrREV7q5KipsU7ElIaDKdwh6rvdqIsQk25H/SgicO1ZN
         PI9x8dSNAQu7HEhi9B/8JNo5YY7gyQyjn8xxnGiQAICgFcUR6mGcTnAlFFnUVNy21zle
         AKu9ow8xI0rtmM56ihp+UD9eGNLO10ZJ7HB7UJcPXbAcphLQpc0UgoLfVnRFc5Rw+p/v
         5m/NOCozhNWvP3D1xybLO2CzOS7ZACIQqeQCq5K5xvIv8a1xxZnIqMCujas5QSOblp3F
         Ux1A==
X-Gm-Message-State: AJcUukfFItrmS+AhMAlnltLijQLVLiMWMVYpkd23iFhv7ROtRromkIeS
        mHQ/Nl4B23BYymp+lgIy9B4a7/DX
X-Google-Smtp-Source: ALg8bN4avwg/P4rNsQJVhP032bnGQjkaHMRRbTuC89CqHMv3A4ExnuF5yrzfuyZHMGAFfugIzW/n4w==
X-Received: by 2002:a50:a395:: with SMTP id s21mr4344413edb.1.1548280758913;
        Wed, 23 Jan 2019 13:59:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m44sm11065247edm.54.2019.01.23.13.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 13:59:18 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:59:18 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 21:59:11 GMT
Message-Id: <e7ae3007f55efcccd8827ce7d8db5f9dc180cb39.1548280753.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.git.gitgitgadget@gmail.com>
References: <pull.112.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/6] commit-graph: add --version=<n> option
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

Allo the commit-graph builtin to specify the file format version
using the '--version=<n>' option. Specify the version exactly in
the verification tests as using a different version would change
the offsets used in those tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  3 +++
 builtin/commit-graph.c             | 13 +++++++++++--
 t/t5318-commit-graph.sh            |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

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
index 0c92421f75..b1bed84260 100644
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
 
 
@@ -141,6 +142,8 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_INTEGER(0, "version", &opts.version,
+			N_("specify the file format version")),
 		OPT_END(),
 	};
 
@@ -155,6 +158,12 @@ static int graph_write(int argc, const char **argv)
 	if (opts.append)
 		flags |= COMMIT_GRAPH_APPEND;
 
+	switch (opts.version) {
+	case 1:
+		flags |= COMMIT_GRAPH_VERSION_1;
+		break;
+	}
+
 	read_replace_refs = 0;
 
 	if (opts.reachable)
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index f4deb13b1d..b79d6263e9 100755
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

