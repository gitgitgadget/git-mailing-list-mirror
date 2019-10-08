Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDEF1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 11:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfJHLdb (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 07:33:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51503 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbfJHLda (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 07:33:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so2768141wme.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4uZC+yyYb7wCVfwMaNqNSxlQAsQtUPxvjS9dnJCPrE0=;
        b=Mmih9384ERJ+vwq2nL/6ZDQQmJW2KPo5TI4g5pdc9dLfWfjuxhRWK4A4Oo1xcs9D5n
         zoYfFhtCSSvLxFIhgSrX1MxuY1oNflHMRi0WExSDRdU1SBkiYNbrx4qBq6hpY+umiGqa
         vU2ElDOPNgvA66HNHA59BM0fniUGmHs4wPSXx/e2cJz1xqtm1eitLlbg4EDyd3DvW1Fy
         VO7rw2qc5rfIOGU9R8+wtnIefVaT2ZVO45BRgY861JufDTKR97OwokG6LZGkgUnrRqiT
         FutFwpFExkm9AEb5F0sEl0b24ngbJowXUFf/p+ljlK4t4xsBKAGWMHEj5uP4AS7iUl2v
         dFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4uZC+yyYb7wCVfwMaNqNSxlQAsQtUPxvjS9dnJCPrE0=;
        b=sgzCPuaX+hgk64GSJ0tOlOEJgqcATXmoobGXvB/QW8NXIoaq+AoRZX8UpFcDHWqhmm
         E0iZd8dYQDfdsZaoQZhxTjgO0iA+JcLEtUCqrxQMIiqOq+AtlhYZ/4wcMb8SIfcgv+Lv
         lmxfvU5t6k/4oQk3v3Mow3Pgbd1l0o5gfbiGOhdoxbHE92OTo0gac2NMLgU8hVJ3ypsx
         lr26DVXtYM6+nx2n5GbqAq529rQ6o3173nFda857F5FIlS7lJ4Y2qFVQg9+k/wsDQzxC
         PRtIeUVUlmtYQeZQK4R4J6qDkf1Mu6jph8/iK40H3sI7FqQNNhLm1sa8Dr5mHFvVNbIw
         UqQQ==
X-Gm-Message-State: APjAAAWgwsaJQtcL9VJbju5l8kougxYcmIr/AF+8SihUOvmFFKx6+F/o
        YW3rIPaCGQmOxTYGLtyWTP8jlPIp
X-Google-Smtp-Source: APXvYqwQc7YCjclBFNlDS/LQCJ4EkAvKSLmL4Vf5Tyx6KtMCmbwqEJIDmQkS1Db39Mh8A7KJl0d1lA==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr3391640wmb.97.1570534407063;
        Tue, 08 Oct 2019 04:33:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm21875753wrq.48.2019.10.08.04.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 04:33:26 -0700 (PDT)
Date:   Tue, 08 Oct 2019 04:33:26 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 11:33:25 GMT
Message-Id: <2f55d6fb2a158c5b26b93ddb9c144ce1af5d9c32.1570534405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.361.v4.git.gitgitgadget@gmail.com>
References: <pull.361.v3.git.gitgitgadget@gmail.com>
        <pull.361.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 1/1] Make gitdir work with worktrees, respect
 core.hooksPath, etc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Since v2.9.0, Git knows about the config variable core.hookspath that
allows overriding the path to the directory containing the Git hooks.

Since v2.10.0, the `--git-path` option respects that config variable,
too, so we may just as well use that command.

Other paths inside `.git` are equally subject to differ from
`<gitdir>/<path>`, i.e. inside worktrees, where _some_ paths live in the
"gitdir" and some live in the "commondir" (i.e. the "gitdir" of the main
worktree).

For Git versions older than v2.5.0 (which was the first version to
support the `--git-path` option for the `rev-parse` command), we simply
fall back to the previous code.

An original patch handled only the hooksPath setting, however, during
the code submission it was deemed better to fix all call to the `gitdir`
function.

To avoid spawning a gazillion `git rev-parse --git-path` instances, we
cache the returned paths, priming the cache upon startup in a single
`git rev-parse invocation` with some paths (that have been
determined via a typical startup and via grepping the source code for
calls to the `gitdir` function).

This fixes https://github.com/git-for-windows/git/issues/1755

Initial-patch-by: Philipp Gortan <philipp@gortan.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index fd476b6999..c684dc7ae1 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -158,6 +158,7 @@ if {[tk windowingsystem] eq "aqua"} {
 
 set _appname {Git Gui}
 set _gitdir {}
+array set _gitdir_cache {}
 set _gitworktree {}
 set _isbare {}
 set _gitexec {}
@@ -197,12 +198,59 @@ proc appname {} {
 	return $_appname
 }
 
+proc prime_gitdir_cache {} {
+	global _gitdir _gitdir_cache
+
+	set gitdir_cmd [list git rev-parse --git-dir]
+
+	# `--git-path` is only supported since Git v2.5.0
+	if {[package vcompare $::_git_version 2.5.0] >= 0} {
+		# This list was generated from a typical startup as well as from
+		# grepping through Git GUI's source code.
+		set gitdir_keys [list \
+			CHERRY_PICK_HEAD FETCH_HEAD GITGUI_BCK GITGUI_EDITMSG \
+			GITGUI_MSG HEAD hooks hooks/prepare-commit-msg \
+			index.lock info info/exclude logs MERGE_HEAD MERGE_MSG \
+			MERGE_RR objects "objects/4\[0-1\]/*" \
+			"objects/4\[0-3\]/*" objects/info \
+			objects/info/alternates objects/pack packed-refs \
+			PREPARE_COMMIT_MSG rebase-merge/head-name remotes \
+			rr-cache rr-cache/MERGE_RR SQUASH_MSG \
+		]
+
+		foreach key $gitdir_keys {
+			lappend gitdir_cmd --git-path $key
+		}
+	}
+
+	set i -1
+	foreach path [split [eval $gitdir_cmd] "\n"] {
+		if {$i eq -1} {
+			set _gitdir $path
+		} else {
+			set _gitdir_cache([lindex $gitdir_keys $i]) $path
+		}
+		incr i
+	}
+}
+
 proc gitdir {args} {
-	global _gitdir
+	global _gitdir _gitdir_cache
+
 	if {$args eq {}} {
 		return $_gitdir
 	}
-	return [eval [list file join $_gitdir] $args]
+
+	set args [eval [list file join] $args]
+	if {![info exists _gitdir_cache($args)]} {
+		if {[package vcompare $::_git_version 2.5.0] >= 0} {
+			set _gitdir_cache($args) [git rev-parse --git-path $args]
+		} else {
+			set _gitdir_cache($args) [file join $_gitdir $args]
+		}
+	}
+
+	return $_gitdir_cache($args)
 }
 
 proc gitexec {args} {
@@ -1242,7 +1290,7 @@ if {[catch {
 	&& [catch {
 		# beware that from the .git dir this sets _gitdir to .
 		# and _prefix to the empty string
-		set _gitdir [git rev-parse --git-dir]
+		prime_gitdir_cache
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
 	load_config 1
@@ -1453,10 +1501,16 @@ proc rescan {after {honor_trustmtime 1}} {
 	global HEAD PARENT MERGE_HEAD commit_type
 	global ui_index ui_workdir ui_comm
 	global rescan_active file_states
-	global repo_config
+	global repo_config _gitdir_cache
 
 	if {$rescan_active > 0 || ![lock_index read]} return
 
+	# Only re-prime gitdir cache on a full rescan
+	if {$after ne "ui_ready"} {
+		array unset _gitdir_cache
+		prime_gitdir_cache
+	}
+
 	repository_state newType newHEAD newMERGE_HEAD
 	if {[string match amend* $commit_type]
 		&& $newType eq {normal}
-- 
gitgitgadget
