From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 02/10] Replace "remote tracking" with "remote-tracking"
Date: Tue,  2 Nov 2010 16:31:20 +0100
Message-ID: <1288711888-21528-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 02 16:38:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDIwn-000857-UA
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 16:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab0KBPif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 11:38:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53173 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966Ab0KBPib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 11:38:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oA2FGfZq006330
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Nov 2010 16:16:41 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIpo-00025X-IT; Tue, 02 Nov 2010 16:31:40 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIpo-0005c5-GR; Tue, 02 Nov 2010 16:31:40 +0100
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Nov 2010 16:16:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA2FGfZq006330
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1289315804.09485@qEu53mvuYARi2FdjYxFv7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160536>

"remote-tracking" branch makes it explicit that the branch is "tracking a
remote", as opposed to "remote, and tracking something".

See discussion in e.g.
http://mid.gmane.org/8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com
for more details.

This patch is a straightforward application of

  perl -pi -e 's/remote tracking branch/remote-tracking branch/'

except in the RelNotes directory.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt           |    2 +-
 Documentation/fetch-options.txt    |    2 +-
 Documentation/git-log.txt          |    2 +-
 Documentation/git-pull.txt         |    2 +-
 Documentation/git-remote.txt       |    4 ++--
 Documentation/gittutorial.txt      |    2 +-
 Documentation/rev-list-options.txt |    2 +-
 Documentation/user-manual.txt      |    2 +-
 builtin/checkout.c                 |    2 +-
 t/t5513-fetch-track.sh             |    2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 538ebb5..e625d6a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -708,7 +708,7 @@ color.diff.<slot>::
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
 	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote tracking branches, tags, stash and HEAD, respectively.
+	branches, remote-tracking branches, tags, stash and HEAD, respectively.
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 470ac31..a435c23 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -36,7 +36,7 @@ ifndef::git-pull[]
 
 -p::
 --prune::
-	After fetching, remove any remote tracking branches which
+	After fetching, remove any remote-tracking branches which
 	no longer exist	on the remote.
 endif::git-pull[]
 
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 6d40f00..ff41784 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -116,7 +116,7 @@ git log --follow builtin-rev-list.c::
 git log --branches --not --remotes=origin::
 
 	Shows all commits that are in any of local branches but not in
-	any of remote tracking branches for 'origin' (what you have that
+	any of remote-tracking branches for 'origin' (what you have that
 	origin doesn't).
 
 git log master --not --remotes=*/master::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c50f7dc..33e8438 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -26,7 +26,7 @@ With `--rebase`, it runs 'git rebase' instead of 'git merge'.
 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
 arbitrary remote ref (for example, the name of a tag) or even
-a collection of refs with corresponding remote tracking branches
+a collection of refs with corresponding remote-tracking branches
 (e.g., refs/heads/*:refs/remotes/origin/*), but usually it is
 the name of a branch in the remote repository.
 
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 0d28feb..5e4989d 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -75,7 +75,7 @@ was passed.
 
 'rename'::
 
-Rename the remote named <old> to <new>. All remote tracking branches and
+Rename the remote named <old> to <new>. All remote-tracking branches and
 configuration settings for the remote are updated.
 +
 In case <old> and <new> are the same, and <old> is a file under
@@ -84,7 +84,7 @@ the configuration file format.
 
 'rm'::
 
-Remove the remote named <name>. All remote tracking branches and
+Remove the remote named <name>. All remote-tracking branches and
 configuration settings for the remote are removed.
 
 'set-head'::
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 1c16066..f1f4086 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -385,7 +385,7 @@ alice$ git fetch bob
 
 Unlike the longhand form, when Alice fetches from Bob using a
 remote repository shorthand set up with 'git remote', what was
-fetched is stored in a remote tracking branch, in this case
+fetched is stored in a remote-tracking branch, in this case
 `bob/master`.  So after this:
 
 -------------------------------------
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7a42567..7a1b164 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -264,7 +264,7 @@ endif::git-rev-list[]
 
 	Pretend as if all the refs in `refs/remotes` are listed
 	on the command line as '<commit>'. If '<pattern>' is given, limit
-	remote tracking branches to ones matching given shell glob.
+	remote-tracking branches to ones matching given shell glob.
 	If pattern lacks '?', '*', or '[', '/*' at the end is implied.
 
 --glob=<glob-pattern>::
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fc56da6..d5505e8 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1700,7 +1700,7 @@ may wish to check the original repository for updates and merge them
 into your own work.
 
 We have already seen <<Updating-a-repository-With-git-fetch,how to
-keep remote tracking branches up to date>> with linkgit:git-fetch[1],
+keep remote-tracking branches up to date>> with linkgit:git-fetch[1],
 and how to merge two branches.  So you can merge in changes from the
 original repository's master branch with:
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9240faf..9a934af 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -786,7 +786,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 *   With no paths, if <something> is _not_ a commit, no -t nor -b
 	 *   was given, and there is a tracking branch whose name is
 	 *   <something> in one and only one remote, then this is a short-hand
-	 *   to fork local <something> from that remote tracking branch.
+	 *   to fork local <something> from that remote-tracking branch.
 	 *
 	 *   Otherwise <something> shall not be ambiguous.
 	 *   - If it's *only* a reference, treat it like case (1).
diff --git a/t/t5513-fetch-track.sh b/t/t5513-fetch-track.sh
index 9e74862..65d1e05 100755
--- a/t/t5513-fetch-track.sh
+++ b/t/t5513-fetch-track.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='fetch follows remote tracking branches correctly'
+test_description='fetch follows remote-tracking branches correctly'
 
 . ./test-lib.sh
 
-- 
1.7.3.2.183.g2e7b0
