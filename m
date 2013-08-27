From: "Daniele Procida" <daniele@vurt.org>
Subject: PATCH/RFC man git remote, use of <remote> vs <name>
Date: Tue, 27 Aug 2013 15:10:08 +0100
Message-ID: <20130827141008.578740119@smtpauth.cf.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: Daniele <daniele@vurt.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 27 16:37:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEKOU-00056k-8I
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 16:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414Ab3H0OhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 10:37:12 -0400
Received: from smtpout1.cf.ac.uk ([131.251.137.125]:54970 "EHLO
	smtpout1.cf.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3H0OhL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 10:37:11 -0400
X-Greylist: delayed 1608 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2013 10:37:11 EDT
Received: from smtpauth.cf.ac.uk ([131.251.248.19])
	by smtpout1.cf.ac.uk with esmtp (Exim 4.77)
	(envelope-from <procida@Cardiff.ac.uk>)
	id 1VEJyO-0007iJ-GA; Tue, 27 Aug 2013 15:10:20 +0100
Received: from [10.121.64.22]
	by smtpauth.cf.ac.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <sagdp6@smtpauth.cf.ac.uk>)
	id 1VEJyO-0003su-82; Tue, 27 Aug 2013 15:10:20 +0100
X-Mailer: CTM PowerMail version 6.1.5 build 4654 English (intel)
 <http://www.ctmdev.com>
X-Virus-Scanned: Cardiff University Virus Scanner
X-Virus-Scanned: Cardiff University Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233092>

I noticed that <http://jk.gs/git-remote.html> mostly refers to remotes as "<name>", but in one case as "<remote>".

"<remote>" is clearer than "<name>", and also follows the pattern of "<url>", "<branch>" and so on.

Here follows a patch in which the usage is made consistent, as "<remote>" rather than "<name>".

I hope the format is OK.

Thanks,

Daniele

>From 3b9d6847286b70b9ee1711af5b9cf3dd7a91c2cc Mon Sep 17 00:00:00 2001
From: Daniele Procida <daniele@vurt.org>
Date: Tue, 27 Aug 2013 13:08:37 +0100
Subject: [PATCH] made git man remote more consistent

---
 Documentation/git-remote.txt | 56 ++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 9c3e3bf..12cdf04 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,16 +10,16 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <remote> <url>
 'git remote rename' <old> <new>
-'git remote remove' <name>
-'git remote set-head' <name> (-a | -d | <branch>)
-'git remote set-branches' [--add] <name> <branch>...
-'git remote set-url' [--push] <name> <newurl> [<oldurl>]
-'git remote set-url --add' [--push] <name> <newurl>
-'git remote set-url --delete' [--push] <name> <url>
-'git remote' [-v | --verbose] 'show' [-n] <name>...
-'git remote prune' [-n | --dry-run] <name>...
+'git remote remove' <remote>
+'git remote set-head' <remote> (-a | -d | <branch>)
+'git remote set-branches' [--add] <remote> <branch>...
+'git remote set-url' [--push] <remote> <newurl> [<oldurl>]
+'git remote set-url --add' [--push] <remote> <newurl>
+'git remote set-url --delete' [--push] <remote> <url>
+'git remote' [-v | --verbose] 'show' [-n] <remote>...
+'git remote prune' [-n | --dry-run] <remote>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
 
 DESCRIPTION
@@ -45,26 +45,26 @@ subcommands are available to perform operations on the remotes.
 
 'add'::
 
-Adds a remote named <name> for the repository at
-<url>.  The command `git fetch <name>` can then be used to create and
-update remote-tracking branches <name>/<branch>.
+Adds a remote named <remote> for the repository at
+<url>.  The command `git fetch <remote>` can then be used to create and
+update remote-tracking branches <remote>/<branch>.
 +
-With `-f` option, `git fetch <name>` is run immediately after
+With `-f` option, `git fetch <remote>` is run immediately after
 the remote information is set up.
 +
-With `--tags` option, `git fetch <name>` imports every tag from the
+With `--tags` option, `git fetch <remote>` imports every tag from the
 remote repository.
 +
-With `--no-tags` option, `git fetch <name>` does not import tags from
+With `--no-tags` option, `git fetch <remote>` does not import tags from
 the remote repository.
 +
 With `-t <branch>` option, instead of the default glob
 refspec for the remote to track all branches under
-the `refs/remotes/<name>/` namespace, a refspec to track only `<branch>`
+the `refs/remotes/<remote>/` namespace, a refspec to track only `<branch>`
 is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
-With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
+With `-m <master>` option, a symbolic-ref `refs/remotes/<remote>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
 When a fetch mirror is created with `--mirror=fetch`, the refs will not
@@ -88,29 +88,29 @@ the configuration file format.
 'remove'::
 'rm'::
 
-Remove the remote named <name>. All remote-tracking branches and
+Remove the remote named <remote>. All remote-tracking branches and
 configuration settings for the remote are removed.
 
 'set-head'::
 
 Sets or deletes the default branch (i.e. the target of the
-symbolic-ref `refs/remotes/<name>/HEAD`) for
+symbolic-ref `refs/remotes/<remote>/HEAD`) for
 the named remote. Having a default branch for a remote is not required,
 but allows the name of the remote to be specified in lieu of a specific
 branch. For example, if the default branch for `origin` is set to
 `master`, then `origin` may be specified wherever you would normally
 specify `origin/master`.
 +
-With `-d`, the symbolic ref `refs/remotes/<name>/HEAD` is deleted.
+With `-d`, the symbolic ref `refs/remotes/<remote>/HEAD` is deleted.
 +
 With `-a`, the remote is queried to determine its `HEAD`, then the
-symbolic-ref `refs/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
+symbolic-ref `refs/remotes/<remote>/HEAD` is set to the same branch. e.g., if the remote
 `HEAD` is pointed at `next`, "`git remote set-head origin -a`" will set
 the symbolic-ref `refs/remotes/origin/HEAD` to `refs/remotes/origin/next`. This will
 only work if `refs/remotes/origin/next` already exists; if not it must be
 fetched first.
 +
-Use `<branch>` to set the symbolic-ref `refs/remotes/<name>/HEAD` explicitly. e.g., "git
+Use `<branch>` to set the symbolic-ref `refs/remotes/<remote>/HEAD` explicitly. e.g., "git
 remote set-head origin master" will set the symbolic-ref `refs/remotes/origin/HEAD` to
 `refs/remotes/origin/master`. This will only work if
 `refs/remotes/origin/master` already exists; if not it must be fetched first.
@@ -144,17 +144,17 @@ error.
 
 'show'::
 
-Gives some information about the remote <name>.
+Gives some information about the remote <remote>.
 +
 With `-n` option, the remote heads are not queried first with
-`git ls-remote <name>`; cached information is used instead.
+`git ls-remote <remote>`; cached information is used instead.
 
 'prune'::
 
-Deletes all stale remote-tracking branches under <name>.
+Deletes all stale remote-tracking branches under <remote>.
 These stale branches have already been removed from the remote repository
-referenced by <name>, but are still locally available in
-"remotes/<name>".
+referenced by <remote>, but are still locally available in
+"remotes/<remote>".
 +
 With `--dry-run` option, report what branches will be pruned, but do not
 actually prune them.
@@ -165,7 +165,7 @@ Fetch updates for a named set of remotes in the repository as defined by
 remotes.<group>.  If a named group is not specified on the command line,
 the configuration parameter remotes.default will be used; if
 remotes.default is not defined, all remotes which do not have the
-configuration parameter remote.<name>.skipDefaultUpdate set to true will
+configuration parameter remote.<remote>.skipDefaultUpdate set to true will
 be updated.  (See linkgit:git-config[1]).
 +
 With `--prune` option, prune all the remotes that are updated.
-- 
1.8.4
