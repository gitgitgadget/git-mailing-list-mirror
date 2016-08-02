Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5231F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 18:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936384AbcHBSZK (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 14:25:10 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36038 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936349AbcHBSXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 14:23:13 -0400
Received: by mail-pf0-f179.google.com with SMTP id h186so68576870pfg.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 11:22:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yOrDH1tM8/SItLk+RWgx0NiX3XK4UBJVdsTPJX+1gus=;
        b=JjF1Cki+oitANwpM5cwwnfnzTXYr8+nHULJ9ZqvgXguKZzPNdDCUPO7lDRe4F6aczL
         iGctAzgr/tgj0Ro95645Fa4CHvxx7c/D6cQ40bFBXT3t3Kt8Yr989B1OOp7/0mbUYS6i
         rc7GgemEC/cUUEIDgejof/jWQ6lloC8StkfLiQjtEhqA4bTfhjEXBKucmvauLkV5kngM
         uSAs+65PCmu7cooo0Nl2x/Ax0gotaEgJmKmCngLf7xclscbSUJml+O14kzzpyxcLNjdm
         lSmTQZNDCpkqdLghD+9Dudnt1GVRfcepRdAG2KtQzR2ItNIuCfNqwDOey4/tGZ4pqxYC
         5ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yOrDH1tM8/SItLk+RWgx0NiX3XK4UBJVdsTPJX+1gus=;
        b=AXIpJYa7oSla8CfxROLMl3as77+xrW9QwgJbh+jM0NifmHufilKcuBRJaOzrc05GGu
         vh5C1G3aKHQQVFRlAi7X8pom3L7GzKGdBxk3vnJdygKdsbs77U/xoYLFFaWHBBjqspup
         F9EHZy9r8tCcCQGMAEOlhpwAlbivdgD08P8wAXlqKttk6FBRkfg3g1AryNcWVtI+kMtJ
         sC/WipF1HsTpk5GHJz+evSGJ3s6Iw5vidyHIRKT3Zg2nakWX6Hcp+iD/wd+6PckLGZqZ
         fgZ/o5dFUjTVFcMpXzUc+ZatVYg79bqtU7rGl7rmt9FrbO0Lvrlh1Aq+4fxr45J/Afn8
         hXmA==
X-Gm-Message-State: AEkoous8WRzpIDOifzbA4uz3EMMOCUbNx/dzJhLzhH8OvbHSSAHEBNheEyMxzuVnnHusvBn2
X-Received: by 10.98.72.28 with SMTP id v28mr107737210pfa.139.1470162121992;
        Tue, 02 Aug 2016 11:22:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c95e:4bc7:6c52:ebb0])
        by smtp.gmail.com with ESMTPSA id q26sm6478668pfj.53.2016.08.02.11.22.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Aug 2016 11:22:01 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, gitster@pobox.com
Cc:	Jens.Lehmann@web.de, hvoigt@hvoigt.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule documentation: add options to the subcommand
Date:	Tue,  2 Aug 2016 11:21:51 -0700
Message-Id: <20160802182152.20637-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.525.g1760797
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When reading up on a subcommand of `gi submodule`, it is convenient
to have its options nearby and not just at the top of the man page.
Add the options to each subcommand.

While at it, also document the `--checkout` option for `update`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  This mini series applies to master, there no other patches in flight
  that touch Documentation/git-submodules.txt except
  sb/submodule-default-paths, which we are holding back currently.
  
  Thanks,
  Stefan

 Documentation/git-submodule.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bf3bb37..1452c31 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [--[no-]recommend-shallow] [-f|--force] [--rebase|--merge]
+	      [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge]
 	      [--reference <repository>] [--depth <depth>] [--recursive]
 	      [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
@@ -62,7 +62,7 @@ if you choose to go that route.
 
 COMMANDS
 --------
-add::
+add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
@@ -103,7 +103,7 @@ together in the same relative location, and only the
 superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
 
-status::
+status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1 of the
 	currently checked out commit for each submodule, along with the
 	submodule path and the output of 'git describe' for the
@@ -120,7 +120,7 @@ submodules with respect to the commit recorded in the index or the HEAD,
 linkgit:git-status[1] and linkgit:git-diff[1] will provide that information
 too (and can also report changes to a submodule's work tree).
 
-init::
+init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
 	added and committed elsewhere) by copying submodule
 	names and urls from .gitmodules to .git/config.
@@ -135,7 +135,7 @@ init::
 	the explicit 'init' step if you do not intend to customize
 	any submodule locations.
 
-deinit::
+deinit [-f|--force] (--all|[--] <path>...)::
 	Unregister the given submodules, i.e. remove the whole
 	`submodule.$name` section from .git/config together with their work
 	tree. Further calls to `git submodule update`, `git submodule foreach`
@@ -151,7 +151,7 @@ instead of deinit-ing everything, to prevent mistakes.
 If `--force` is specified, the submodule's working tree will
 be removed even if it contains local modifications.
 
-update::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -197,7 +197,7 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
-summary::
+summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
 	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
 	in the submodule between the given super project commit and the
@@ -210,7 +210,7 @@ summary::
 Using the `--submodule=log` option with linkgit:git-diff[1] will provide that
 information too.
 
-foreach::
+foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
 	The command has access to the variables $name, $path, $sha1 and
 	$toplevel:
@@ -231,7 +231,7 @@ As an example, +git submodule foreach \'echo $path {backtick}git
 rev-parse HEAD{backtick}'+ will show the path and currently checked out
 commit for each submodule.
 
-sync::
+sync [--recursive] [--] [<path>...]::
 	Synchronizes submodules' remote URL configuration setting
 	to the value specified in .gitmodules. It will only affect those
 	submodules which already have a URL entry in .git/config (that is the
-- 
2.9.2.525.g1760797

