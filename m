Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32489200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 23:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932859AbcL0XnS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 18:43:18 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33691 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbcL0XnR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 18:43:17 -0500
Received: by mail-pg0-f51.google.com with SMTP id g1so110105490pgn.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 15:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dd77zkO5B8WLEI9A8HIflGKGX8Oq/p+dt8yHNdr9mCc=;
        b=AzjRO/HX+y7LF26+UOc6/9yVFOKzKYpAkzhnSexLh9LER2Sb6qWESEjdZufz1NDy2c
         i3POyRf6F/7S97Exg71m9xbn4CYjDfZD32dHOa0LltSWRSVv4lFjZg9fXCHi2kHXIXxc
         aTgSJIKODvE/kFutFHB+TtR8ET+wMp9BshzrsyvJtcLf20Xd+Kom1Varjca+yPbd4aVq
         p8CAbhNkKMPBp47lSqCPQMBgGzqyiBbrknqqevnHq2MvnwaUsmfClZuIkLuPQyXelKRW
         xpiLTZ0WnCUk+3AgS0ZzdSbaNcYUN4OtduU9nNzcH4lZ6ReDOplxYypu+dYWmIwPoQB2
         nzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dd77zkO5B8WLEI9A8HIflGKGX8Oq/p+dt8yHNdr9mCc=;
        b=J23VzYNOKHBeTmctQyQTNlpVMc0S+FHZrbuAoolWMyVdMWPDn110MURD6awYXRb0kJ
         020mGw9ZPnkPnx4pwV7G5drvCUooIhHW8NKZYjscBxgKYpLZKvVwukbRxf/FTk2snih7
         4z+Gg9ztbNZ+uRAvcjlXgrYqSYukAidn8DTH74MPGvQVKdUReUp/KRT9GNP5+1a4shAK
         xc5WQXOAhzOVwtPWYsUn4UiNwPUMxv5xHYV4zcs11eFrkP4dncik9M4tjLwSdUnKKEqx
         uyGd9BJqGqigyE9ZRw1cb0y24HQeqQKzZzFDmFYQqjvvZviY9sSuT72JL1ExcSCeVUl7
         zX9g==
X-Gm-Message-State: AIkVDXIj2IG5gBICzi+0rLAI4JWbJ4cJNnJEy8qr04g6VQWsaK4NHa1+DUM9HMTj4yBazD82
X-Received: by 10.99.176.76 with SMTP id z12mr62593886pgo.158.1482882195644;
        Tue, 27 Dec 2016 15:43:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1aa:810:98b9:be05])
        by smtp.gmail.com with ESMTPSA id s197sm92548491pgc.38.2016.12.27.15.43.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Dec 2016 15:43:15 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule documentation: add options to the subcommand
Date:   Tue, 27 Dec 2016 15:43:08 -0800
Message-Id: <20161227234310.13264-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.196.gee862f456e.dirty
In-Reply-To: <20161227234310.13264-1-sbeller@google.com>
References: <20161227234310.13264-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading up on a subcommand of `git submodule <subcommand>`,
it is convenient to have its options nearby and not just at the
top of the man page.  Add the options to each subcommand.

While at it, also document the `--checkout` option for `update`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index d841573475..f9da0d9e91 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,17 +9,12 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
-	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
+'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [--[no-]recommend-shallow] [-f|--force] [--rebase|--merge]
-	      [--reference <repository>] [--depth <depth>] [--recursive]
-	      [--jobs <n>] [--] [<path>...]
-'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
-	      [commit] [--] [<path>...]
+'git submodule' [--quiet] update [<options>] [--] [<path>...]
+'git submodule' [--quiet] summary [<options>] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
 
@@ -62,7 +57,7 @@ if you choose to go that route.
 
 COMMANDS
 --------
-add::
+add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
@@ -103,7 +98,7 @@ together in the same relative location, and only the
 superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
 
-status::
+status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1 of the
 	currently checked out commit for each submodule, along with the
 	submodule path and the output of 'git describe' for the
@@ -120,7 +115,7 @@ submodules with respect to the commit recorded in the index or the HEAD,
 linkgit:git-status[1] and linkgit:git-diff[1] will provide that information
 too (and can also report changes to a submodule's work tree).
 
-init::
+init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
 	added and committed elsewhere) by copying submodule
 	names and urls from .gitmodules to .git/config.
@@ -135,7 +130,7 @@ init::
 	the explicit 'init' step if you do not intend to customize
 	any submodule locations.
 
-deinit::
+deinit [-f|--force] (--all|[--] <path>...)::
 	Unregister the given submodules, i.e. remove the whole
 	`submodule.$name` section from .git/config together with their work
 	tree. Further calls to `git submodule update`, `git submodule foreach`
@@ -151,7 +146,7 @@ instead of deinit-ing everything, to prevent mistakes.
 If `--force` is specified, the submodule's working tree will
 be removed even if it contains local modifications.
 
-update::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -197,7 +192,7 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
-summary::
+summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
 	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
 	in the submodule between the given super project commit and the
@@ -210,7 +205,7 @@ summary::
 Using the `--submodule=log` option with linkgit:git-diff[1] will provide that
 information too.
 
-foreach::
+foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
 	The command has access to the variables $name, $path, $sha1 and
 	$toplevel:
@@ -231,7 +226,7 @@ As an example, +git submodule foreach \'echo $path {backtick}git
 rev-parse HEAD{backtick}'+ will show the path and currently checked out
 commit for each submodule.
 
-sync::
+sync [--recursive] [--] [<path>...]::
 	Synchronizes submodules' remote URL configuration setting
 	to the value specified in .gitmodules. It will only affect those
 	submodules which already have a URL entry in .git/config (that is the
-- 
2.11.0.196.gee862f456e.dirty

