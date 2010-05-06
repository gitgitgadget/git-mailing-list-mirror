From: Andreas Hartmetz <ahartmetz@gmail.com>
Subject: git branch documentation improvements
Date: Fri, 7 May 2010 00:24:40 +0200
Message-ID: <201005070024.41172.ahartmetz@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oG04LZosau37c10"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 00:25:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA9VA-0002mV-MA
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123Ab0EFWYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:24:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57935 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0EFWYp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:24:45 -0400
Received: by fxm10 with SMTP id 10so374954fxm.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 15:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:message-id;
        bh=NmmriGfI37MJwufy0yNZxjNWtDMVIf+OED7aTLa1Fog=;
        b=HWxT2H3pOTuC4Kwp/KIhga35p3LIEzT7hbVWX1j9JNCLM3CNY5fz04hXuHoC5uB+mS
         0Qf8PSE3ZlvhmCJFQWwvwK5lMJj0qwkBkhy8UrswvaAYlDX66ppwmZZhuZ8e2EdIuGp2
         diEfS78YoF2mj3CrEiAjeXf6mBiZkpcfgEcb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :message-id;
        b=s5EPhpYSezdLCXyjFlwvGo4DDdx/vt9A6i7ALBH3wYSVN+MNAxS0QwMDCsJUJo1usz
         Lph4BbKJMinipR0ZPs8bmBbk6XkdfvJqa9JeearEYIUsTYuIsA0fS8zCvvhhR/9apYda
         juIQW00HnvdkuzntotJjOOMz3bS0DVLl7Ysew=
Received: by 10.223.99.156 with SMTP id u28mr7085197fan.53.1273184682852;
        Thu, 06 May 2010 15:24:42 -0700 (PDT)
Received: from rechenplan.localnet (brln-4dbc244b.pool.mediaWays.net [77.188.36.75])
        by mx.google.com with ESMTPS id 19sm3004445fkr.9.2010.05.06.15.24.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 15:24:42 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.33-02063303-generic; KDE/4.4.75; x86_64; svn-1121149; 2010-04-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146502>

--Boundary-00=_oG04LZosau37c10
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello all,

Today I read the git branch documentation and noticed a few things, mostly 
style and consistency related, that could easily be improved, so I did just 
that.
Please consider merging the attached patch if it looks good, or tell me what 
you don't like about it.
The most significant change is renaming <start-point> (or is it 
<startpoint>...) to <branch-head> because even I as a relative beginner know 
that a branch is defined by its (movable) head, and <start-point> *does* 
actually specify the new branch head if I'm not mistaken.

Cheers,
Andreas Hartmetz

--Boundary-00=_oG04LZosau37c10
Content-Type: text/x-patch;
  charset="UTF-8";
  name="git-branch-doc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git-branch-doc.diff"

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1940256..872bb3e 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,51 +11,50 @@ SYNOPSIS
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[-v [--abbrev=<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]]
-'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
+'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<branch-head>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 
 DESCRIPTION
 -----------
 
-With no arguments, existing branches are listed and the current branch will
-be highlighted with an asterisk.  Option `-r` causes the remote-tracking
-branches to be listed, and option `-a` shows both.
+With no arguments, local branches are listed and the current branch is
+highlighted with an asterisk.  Option `-r` lists remote-tracking
+branches, and option `-a` lists both.
 
-With `--contains`, shows only the branches that contain the named commit
+With `--contains`, show only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
 named commit).  With `--merged`, only branches merged into the named
 commit (i.e. the branches whose tip commits are reachable from the named
-commit) will be listed.  With `--no-merged` only branches not merged into
-the named commit will be listed.  If the <commit> argument is missing it
-defaults to 'HEAD' (i.e. the tip of the current branch).
+commit) are listed.  With `--no-merged` only branches not merged into
+the named commit are listed.  If the <commit> argument is missing it
+defaults to 'HEAD', the tip of the current branch.
 
-The command's second form creates a new branch head named <branchname>
-which points to the current 'HEAD', or <start-point> if given.
-
-Note that this will create the new branch, but it will not switch the
+The second form of the command creates a new branch head named <branchname>
+which points to the current 'HEAD', or <branch-head> if given.
+Note that this creates the new branch, but does not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
 new branch.
 
 When a local branch is started off a remote branch, git sets up the
 branch so that 'git pull' will appropriately merge from
 the remote branch. This behavior may be changed via the global
-`branch.autosetupmerge` configuration flag. That setting can be
-overridden by using the `--track` and `--no-track` options.
+`branch.autosetupmerge` configuration flag. You can override the
+flag using the `--track` and `--no-track` options.
 
-With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
+With the '-m' or '-M' command, <oldbranch> is renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
 <newbranch>, and a reflog entry is created to remember the branch
-renaming. If <newbranch> exists, -M must be used to force the rename
-to happen.
+renaming. If <newbranch> exists, -M can be used to forwe overwriting
+it.
 
-With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
-specify more than one branch for deletion.  If the branch currently
-has a reflog then the reflog will also be deleted.
+With the `-d` or `-D` command, `<branchname>` is deleted.  You may
+specify more than one branch to delete.  If the branch currently
+has a reflog, the reflog is also be deleted.
 
-Use -r together with -d to delete remote-tracking branches. Note, that it
+Use -r together with -d to delete remote-tracking branches. Note that it
 only makes sense to delete remote-tracking branches if they no longer exist
-in the remote repository or if 'git fetch' was configured not to fetch
+in the remote repository, or if 'git fetch' was configured not to fetch
 them again. See also the 'prune' subcommand of linkgit:git-remote[1] for a
 way to clean up all obsolete remote-tracking branches.
 
@@ -79,7 +78,7 @@ OPTIONS
 
 -f::
 --force::
-	Reset <branchname> to <startpoint> if <branchname> exists
+	Reset <branchname> to <branch-head> if <branchname> exists
 	already. Without `-f` 'git branch' refuses to change an existing branch.
 
 -m::
@@ -119,8 +118,8 @@ OPTIONS
 -t::
 --track::
 	When creating a new branch, set up configuration to mark the
-	start-point branch as "upstream" from the new branch. This
-	configuration will tell git to show the relationship between the
+	<branch-head> branch as "upstream" from the new branch. This
+	configuration tells git to show the relationship between the
 	two branches in `git status` and `git branch -v`. Furthermore,
 	it directs `git pull` without arguments to pull from the
 	upstream when the new branch is checked out.
@@ -133,13 +132,13 @@ start-point is either a local or remote branch.
 
 --no-track::
 	Do not set up "upstream" configuration, even if the
-	branch.autosetupmerge configuration variable is true.
+	branch.autosetupmerge configuration flag is true.
 
 --set-upstream::
 	If specified branch does not exist yet or if '--force' has been
 	given, acts exactly like '--track'. Otherwise sets up configuration
 	like '--track' would when creating the branch, except that where
-	branch points to is not changed.
+	<branchname> points to is not changed.
 
 --contains <commit>::
 	Only list branches which contain the specified commit.
@@ -158,7 +157,7 @@ start-point is either a local or remote branch.
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
 
-<start-point>::
+<branch-head>::
 	The new branch head will point to this commit.  It may be
 	given as a branch name, a commit-id, or a tag.  If this
 	option is omitted, the current HEAD will be used instead.

--Boundary-00=_oG04LZosau37c10--
