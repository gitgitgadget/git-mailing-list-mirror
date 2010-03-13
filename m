From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 11/12] docs: use ... instead of * for multiplicity
Date: Fri, 12 Mar 2010 23:53:03 -0500
Message-ID: <1268455984-19061-12-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:54:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJMj-0007qX-It
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933691Ab0CMExp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:45 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:62083 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400Ab0CMExX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:23 -0500
Received: by qw-out-2122.google.com with SMTP id 9so447881qwb.37
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yRO/FUn0lh21DbZZMoBMN/FS2HUyEDZtLDyDndi/3S0=;
        b=PUVX7VrG5pTgjwKN9vnrqCJS5RQD3a1B7HgOepXanlCBeOjQimEIvbNAUCoAtQQKoi
         ACK2nBj+8kZHdwD22K/zVy9lxGivqloeqy4UJu1U3trCJCYVTCZOxGF8TPaaXc2hyzdV
         b3MoBg5njzUm79X3ZiOgPNeHUfl2XQkud3pJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aY3sXmgk0IgydGAy8N/Fgut+1exHbLZnC4+OSZmXV+vyJFY53eYYj4Nox+v4lB3dpj
         yt0A1TvLI8pnuqb98+ygVUgWJ9gynITL9Km7HSR7Ld0SSzaosahdK2qujjSeEcLJG3Of
         jDD6QCJ6MTiZ88bRBd5ROgYzvcLTCztKBM2Xs=
Received: by 10.224.56.75 with SMTP id x11mr3445476qag.155.1268456002571;
        Fri, 12 Mar 2010 20:53:22 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:22 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142084>

In the documentation and in usage messages, use [<foo>...] to denote
arguments that can occur zero or more times, rather than [<foo>]* or the
like.  The '...' should come inside the brackets if there is a single
word (e.g., "[<file>...]"), but outside the brackets if there is more
than one word (e.g. "[-p <commit>]...").

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
I don't like having to put the ellipses inside and outside the brackets, 
but I couldn't come up with anything that was more clear.  Leaving the 
star just for these cases is a worse alternative in my opinion, since 
then it would be even more of an oddball.

By the way, can anyone explain why git-pack-objects(1) has
	[--revs [--unpacked | --all]*]
and not the following?
	[--revs] [--unpacked] [--all]

 Documentation/git-checkout-index.txt |    2 +-
 Documentation/git-commit-tree.txt    |    2 +-
 Documentation/git-for-each-ref.txt   |    2 +-
 Documentation/git-fsck.txt           |    2 +-
 Documentation/git-ls-files.txt       |    2 +-
 Documentation/git-merge-index.txt    |    2 +-
 Documentation/git-mergetool.txt      |    2 +-
 Documentation/git-pack-objects.txt   |    2 +-
 Documentation/git-relink.txt         |    2 +-
 Documentation/git-update-index.txt   |    4 ++--
 Documentation/gitcli.txt             |    2 +-
 builtin/commit-tree.c                |    2 +-
 builtin/describe.c                   |    2 +-
 builtin/diff.c                       |    2 +-
 builtin/ls-files.c                   |    2 +-
 builtin/merge-index.c                |    2 +-
 builtin/pack-objects.c               |    2 +-
 17 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index d6aa6e1..0c0a9c1 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 		   [--stage=<number>|all]
 		   [--temp]
 		   [-z] [--stdin]
-		   [--] [<file>]\*
+		   [--] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 6188854..55f0390 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -8,7 +8,7 @@ git-commit-tree - Create a new commit object
 
 SYNOPSIS
 --------
-'git commit-tree' <tree> [-p <parent commit>]\* < changelog
+'git commit-tree' <tree> [-p <parent commit>]... < changelog
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7e83288..993f79f 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
-		   [--sort=<key>]\* [--format=<format>] [<pattern>...]
+		   [--sort=<key>]... [--format=<format>] [<pattern>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 86f9b2b..38207a1 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
-	 [--[no-]full] [--strict] [--verbose] [--lost-found] [<object>*]
+	 [--[no-]full] [--strict] [--verbose] [--lost-found] [<object>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index ed63f21..cbd6661 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 		[--exclude-per-directory=<file>]
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree>]
-		[--full-name] [--abbrev] [--] [<file>]\*
+		[--full-name] [--abbrev] [--] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 4d266de..3716309 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -8,7 +8,7 @@ git-merge-index - Run a merge for files needing merging
 
 SYNOPSIS
 --------
-'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>\*)
+'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>...)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 55735fa..bd6b301 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -7,7 +7,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 
 SYNOPSIS
 --------
-'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>]...
+'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8ed09c0..a19aa4b 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=N] [--depth=N]
-	[--revs [--unpacked | --all]*] [--stdout | base-name]
+	[--revs [--unpacked | --all]...] [--stdout | base-name]
 	[--keep-true-parents] < object-list
 
 
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index 25ff8f9..362a5dc 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -7,7 +7,7 @@ git-relink - Hardlink common objects in local repositories
 
 SYNOPSIS
 --------
-'git relink' [--safe] <dir> [<dir>]\* <master_dir>
+'git relink' [--safe] <dir> [<dir>...] <master_dir>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 68dc187..2753d73 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git update-index'
 	     [--add] [--remove | --force-remove] [--replace]
 	     [--refresh] [-q] [--unmerged] [--ignore-missing]
-	     [--cacheinfo <mode> <object> <file>]\*
+	     [--cacheinfo <mode> <object> <file>]...
 	     [--chmod=(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
 	     [--skip-worktree | --no-skip-worktree]
@@ -21,7 +21,7 @@ SYNOPSIS
 	     [--info-only] [--index-info]
 	     [-z] [--stdin]
 	     [--verbose]
-	     [--] [<file>]\*
+	     [--] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index de0630f..eb51ffc 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -81,7 +81,7 @@ couple of magic command line options:
 +
 ---------------------------------------------
 $ git describe -h
-usage: git describe [options] <commit>*
+usage: git describe [options] <commit>...
 
     --contains            find the tag that comes after the commit
     --debug               debug search strategy on stderr
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 225e515..22ceff1 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -22,7 +22,7 @@ static void check_valid(unsigned char *sha1, enum object_type expect)
 		    typename(expect));
 }
 
-static const char commit_tree_usage[] = "git commit-tree <tree> [-p <commit>]* < changelog";
+static const char commit_tree_usage[] = "git commit-tree <tree> [-p <commit>]... < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
diff --git a/builtin/describe.c b/builtin/describe.c
index 4ece73f..2bba2ba 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -11,7 +11,7 @@
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
-	"git describe [options] <commit>*",
+	"git describe [options] <commit>...",
 	"git describe [options] --dirty",
 	NULL
 };
diff --git a/builtin/diff.c b/builtin/diff.c
index a716704..f73da93 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -21,7 +21,7 @@ struct blobinfo {
 };
 
 static const char builtin_diff_usage[] =
-"git diff [<options>] <rev>{0,2} [--] [<path>]*";
+"git diff [<options>] <rev>{0,2} [--] [<path>...]";
 
 static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6dc885d..c57c93e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -414,7 +414,7 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 }
 
 static const char * const ls_files_usage[] = {
-	"git ls-files [options] [<file>]*",
+	"git ls-files [options] [<file>...]",
 	NULL
 };
 
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 2c4cf5e..c683bbd 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -76,7 +76,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
+		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] <filename>...)");
 
 	read_cache();
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9780258..19d9f09 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -28,7 +28,7 @@ static const char pack_usage[] =
   "        [--max-pack-size=N] [--local] [--incremental]\n"
   "        [--window=N] [--window-memory=N] [--depth=N]\n"
   "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]\n"
-  "        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*]\n"
+  "        [--threads=N] [--non-empty] [--revs [--unpacked | --all]...]\n"
   "        [--reflog] [--stdout | base-name] [--include-tag]\n"
   "        [--keep-unreachable | --unpack-unreachable \n"
   "        [<ref-list | <object-list]";
-- 
1.7.0.2
