Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2560BC433FE
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2AF610CA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhJ1QYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhJ1QYi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB4AC061243
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s13so4015347wrb.3
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=v6JMOKU3RGD2+PV7riIVVihQJcTAUhpnzP9zr1uqq7U=;
        b=kNT9zvUTTeUAIeLzASeCdjDn0ZSaftJI7FoXsbrgdAMpZwUIwDM8wgSqytAscHszA7
         D73KNBlFr9qDhFsifTZNMnEU4ZIXGXW82sjGUvzofM3OPeQzlcOYms9my0Myyd1Z+K3v
         zsPGAO38SEez1h4oeUwRxLTedIthpsMsRRERQPQPQpgvn6bLLhvKGfHD4yD8iMh0Noug
         ClOrYbwDYCHVwlj1GG4du1Gx5TaNDLiQzE3LCoMBR1lYJMich+KZebV+MaCDjZ1K3WD/
         4a7GaLlhcn+CRvwzZb30IJ6cJjzYqb6u+DGWhXZXgd/stn2agHUjjmsY0XKQSUwOMGzt
         fkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=v6JMOKU3RGD2+PV7riIVVihQJcTAUhpnzP9zr1uqq7U=;
        b=ZZB0Qd1Mfc+81y7gxuTfUj34EisjOdOJepDDwR29SIKSJiVHeGpUAku0zLd4z2/Q+L
         cL31Jzv9vGrUShMi9HD//ZTE8r4yhuBzJQZnAWrzCL2/bwrZjjum/qr5txlNPdrDkYqc
         QLhMDsJdC44xw4MQMaYmUykVQlcRnzKd69pg62oO0N0U5LzmrGQPVHgGr5dnLZ2uK/J2
         +OiDcMzanV0NMZWR/ddA1rutveBQVisEG9NXdTu/o0yGWGaCOGq2IMRsO4JG7a8HmHnB
         WVU4ccAZlC1+20bYmcObH/XtZDFGiGBa4YctPyZBZoOhIlgi2WGcgxEq+75dDnySDHYk
         OLSw==
X-Gm-Message-State: AOAM530qtm5zMT9Z3UnxzDEcowau+7RlwtbtuisAZQXK82io4kN/CH2I
        K8tYTz2p00USO+WovpnnzAh40ppK0K0=
X-Google-Smtp-Source: ABdhPJzD2Jsbb0RAutj+MWL5OC9vyGfGR6P16rO6QVPMCH2+TMshbo5F0zV2fuLS6PbnVJesCL+3vA==
X-Received: by 2002:a5d:404e:: with SMTP id w14mr88326wrp.428.1635438129665;
        Thu, 28 Oct 2021 09:22:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p188sm3029992wmp.30.2021.10.28.09.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:22:09 -0700 (PDT)
Message-Id: <8f85da3bb4ad1ca0c864d925b621426bb38ca5bb.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:22:02 +0000
Subject: [PATCH v2 7/9] doc: uniformize <URL> placeholders' case
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

URL being an acronym, it deserves to be kept uppercase.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-http-fetch.txt   | 2 +-
 Documentation/git-http-push.txt    | 2 +-
 Documentation/git-remote.txt       | 8 ++++----
 Documentation/git-request-pull.txt | 8 ++++----
 Documentation/gitcredentials.txt   | 4 ++--
 Documentation/gitsubmodules.txt    | 2 +-
 Documentation/gitworkflows.txt     | 6 +++---
 Documentation/urls-remotes.txt     | 8 ++++----
 8 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index fa4bb6cbc3e..319062c021b 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -9,7 +9,7 @@ git-http-fetch - Download from a remote Git repository via HTTP
 SYNOPSIS
 --------
 [verse]
-'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w <filename>] [--recover] [--stdin | --packfile=<hash> | <commit>] <url>
+'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w <filename>] [--recover] [--stdin | --packfile=<hash> | <commit>] <URL>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index ea03a4eeb0f..78f2bb75523 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -9,7 +9,7 @@ git-http-push - Push objects over HTTP/DAV to another repository
 SYNOPSIS
 --------
 [verse]
-'git http-push' [--all] [--dry-run] [--force] [--verbose] <url> <ref> [<ref>...]
+'git http-push' [--all] [--dry-run] [--force] [--verbose] <URL> <ref> [<ref>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 31c29c9b31b..2bebc32566b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
 'git remote rename' <old> <new>
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
@@ -18,7 +18,7 @@ SYNOPSIS
 'git remote get-url' [--push] [--all] <name>
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
 'git remote set-url --add' [--push] <name> <newurl>
-'git remote set-url --delete' [--push] <name> <url>
+'git remote set-url --delete' [--push] <name> <URL>
 'git remote' [-v | --verbose] 'show' [-n] <name>...
 'git remote prune' [-n | --dry-run] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
@@ -47,7 +47,7 @@ subcommands are available to perform operations on the remotes.
 'add'::
 
 Add a remote named <name> for the repository at
-<url>.  The command `git fetch <name>` can then be used to create and
+<URL>.  The command `git fetch <name>` can then be used to create and
 update remote-tracking branches <name>/<branch>.
 +
 With `-f` option, `git fetch <name>` is run immediately after
@@ -152,7 +152,7 @@ With `--push`, push URLs are manipulated instead of fetch URLs.
 With `--add`, instead of changing existing URLs, new URL is added.
 +
 With `--delete`, instead of changing existing URLs, all URLs matching
-regex <url> are deleted for remote <name>.  Trying to delete all
+regex <URL> are deleted for remote <name>.  Trying to delete all
 non-push URLs is an error.
 +
 Note that the push URL and the fetch URL, even though they can
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 4d4392d0f84..fa5a4267092 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -8,7 +8,7 @@ git-request-pull - Generates a summary of pending changes
 SYNOPSIS
 --------
 [verse]
-'git request-pull' [-p] <start> <url> [<end>]
+'git request-pull' [-p] <start> <URL> [<end>]
 
 DESCRIPTION
 -----------
@@ -21,7 +21,7 @@ the changes and indicates from where they can be pulled.
 The upstream project is expected to have the commit named by
 `<start>` and the output asks it to integrate the changes you made
 since that commit, up to the commit named by `<end>`, by visiting
-the repository named by `<url>`.
+the repository named by `<URL>`.
 
 
 OPTIONS
@@ -33,14 +33,14 @@ OPTIONS
 	Commit to start at.  This names a commit that is already in
 	the upstream history.
 
-<url>::
+<URL>::
 	The repository URL to be pulled from.
 
 <end>::
 	Commit to end at (defaults to HEAD).  This names the commit
 	at the tip of the history you are asking to be pulled.
 +
-When the repository named by `<url>` has the commit at a tip of a
+When the repository named by `<URL>` has the commit at a tip of a
 ref that is different from the ref you have locally, you can use the
 `<local>:<remote>` syntax, to have its local name, a colon `:`, and
 its remote name.
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 758bf39ba38..80517b4eb2c 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -132,7 +132,7 @@ because the hostnames differ. Nor would it match `foo.example.com`; Git
 compares hostnames exactly, without considering whether two hosts are part of
 the same domain. Likewise, a config entry for `http://example.com` would not
 match: Git compares the protocols exactly.  However, you may use wildcards in
-the domain name and other pattern matching techniques as with the `http.<url>.*`
+the domain name and other pattern matching techniques as with the `http.<URL>.*`
 options.
 
 If the "pattern" URL does include a path component, then this too must match
@@ -147,7 +147,7 @@ CONFIGURATION OPTIONS
 
 Options for a credential context can be configured either in
 `credential.*` (which applies to all credentials), or
-`credential.<url>.*`, where <url> matches the context as described
+`credential.<URL>.*`, where <URL> matches the context as described
 above.
 
 The following options are available in either location:
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 891c8da4fdf..941858a6ecc 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -226,7 +226,7 @@ Workflow for a third party library
 ----------------------------------
 
   # Add a submodule
-  git submodule add <url> <path>
+  git submodule add <URL> <path>
 
   # Occasionally update the submodule to a new version:
   git -C <path> checkout <new version>
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 47cf97f9bea..59305265c5a 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -394,7 +394,7 @@ request to do so by mail.  Such a request looks like
 
 -------------------------------------
 Please pull from
-    <url> <branch>
+    <URL> <branch>
 -------------------------------------
 
 In that case, 'git pull' can do the fetch and merge in one go, as
@@ -403,7 +403,7 @@ follows.
 .Push/pull: Merging remote topics
 [caption="Recipe: "]
 =====================================
-`git pull <url> <branch>`
+`git pull <URL> <branch>`
 =====================================
 
 Occasionally, the maintainer may get merge conflicts when they try to
@@ -440,7 +440,7 @@ merge because you cannot format-patch merges):
 .format-patch/am: Keeping topics up to date
 [caption="Recipe: "]
 =====================================
-`git pull --rebase <url> <branch>`
+`git pull --rebase <URL> <branch>`
 =====================================
 
 You can then fix the conflicts during the rebase.  Presumably you have
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index bd184cd6539..86d0008f94d 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -26,14 +26,14 @@ config file would appear like this:
 
 ------------
 	[remote "<name>"]
-		url = <url>
+		url = <URL>
 		pushurl = <pushurl>
 		push = <refspec>
 		fetch = <refspec>
 ------------
 
 The `<pushurl>` is used for pushes only. It is optional and defaults
-to `<url>`.
+to `<URL>`.
 
 Named file in `$GIT_DIR/remotes`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -67,10 +67,10 @@ This file should have the following format:
 
 
 ------------
-	<url>#<head>
+	<URL>#<head>
 ------------
 
-`<url>` is required; `#<head>` is optional.
+`<URL>` is required; `#<head>` is optional.
 
 Depending on the operation, git will use one of the following
 refspecs, if you don't provide one on the command line.
-- 
gitgitgadget

