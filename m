Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BABC433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC56611C0
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhKFSwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 14:52:16 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:63708 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234266AbhKFSwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 14:52:16 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 5E94C19F57E;
        Sat,  6 Nov 2021 19:49:30 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/10] doc: split placeholders as individual tokens
Date:   Sat,  6 Nov 2021 19:48:50 +0100
Message-Id: <20211106184858.11500-3-jn.avila@free.fr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211106184858.11500-1-jn.avila@free.fr>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <20211106184858.11500-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The placeholders represent atoms of tokens and must not be
aggregates.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-archimport.txt  | 14 +++++++-------
 Documentation/git-p4.txt          |  2 +-
 Documentation/git-web--browse.txt |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index a595a0ffee..847777fd17 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -9,14 +9,14 @@ git-archimport - Import a GNU Arch repository into Git
 SYNOPSIS
 --------
 [verse]
-'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D depth] [-t tempdir]
-               <archive/branch>[:<git-branch>] ...
+'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D <depth>] [-t <tempdir>]
+	       <archive>/<branch>[:<git-branch>]...
 
 DESCRIPTION
 -----------
 Imports a project from one or more GNU Arch repositories.
 It will follow branches
-and repositories within the namespaces defined by the <archive/branch>
+and repositories within the namespaces defined by the <archive>/<branch>
 parameters supplied. If it cannot find the remote branch a merge comes from
 it will just import it as a regular commit. If it can find it, it will mark it
 as a merge whenever possible (see discussion below).
@@ -27,7 +27,7 @@ import new branches within the provided roots.
 
 It expects to be dealing with one project only. If it sees
 branches that have different roots, it will refuse to run. In that case,
-edit your <archive/branch> parameters to define clearly the scope of the
+edit your <archive>/<branch> parameters to define clearly the scope of the
 import.
 
 'git archimport' uses `tla` extensively in the background to access the
@@ -42,7 +42,7 @@ incremental imports.
 
 While 'git archimport' will try to create sensible branch names for the
 archives that it imports, it is also possible to specify Git branch names
-manually.  To do so, write a Git branch name after each <archive/branch>
+manually.  To do so, write a Git branch name after each <archive>/<branch>
 parameter, separated by a colon.  This way, you can shorten the Arch
 branch names and convert Arch jargon to Git jargon, for example mapping a
 "PROJECT{litdd}devo{litdd}VERSION" branch to "master".
@@ -104,8 +104,8 @@ OPTIONS
 	Override the default tempdir.
 
 
-<archive/branch>::
-	Archive/branch identifier in a format that `tla log` understands.
+<archive>/<branch>::
+	<archive>/<branch> identifier in a format that `tla log` understands.
 
 
 GIT
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 38e5257b2a..8a6addcf72 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -361,7 +361,7 @@ These options can be used to modify 'git p4 submit' behavior.
 	p4/master.  See the "Sync options" section above for more
 	information.
 
---commit <sha1>|<sha1..sha1>::
+--commit (<sha1>|<sha1>..<sha1>)::
     Submit only the specified commit or range of commits, instead of the full
     list of changes that are in the current Git branch.
 
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 8d162b56c5..f2f996cbe1 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -8,7 +8,7 @@ git-web--browse - Git helper script to launch a web browser
 SYNOPSIS
 --------
 [verse]
-'git web{litdd}browse' [<options>] <url|file>...
+'git web{litdd}browse' [<options>] (<URL>|<file>)...
 
 DESCRIPTION
 -----------
-- 
2.33.1

