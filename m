From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/6] Documentation: git-peek-remote.
Date: Sat, 23 Jul 2005 17:54:15 -0700
Message-ID: <7vek9pkoqw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 02:54:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwUl7-0004OU-8L
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 02:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVGXAyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 20:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVGXAyT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 20:54:19 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58499 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261796AbVGXAyR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 20:54:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724005412.XUWZ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 20:54:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add documentation for the git-peek-remote and link it from the
main index.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-peek-remote.txt |   53 +++++++++++++++++++++++++++++++++++++
 Documentation/git.txt             |    9 ++++--
 2 files changed, 59 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/git-peek-remote.txt

6ad3ff7ed542308b4fce951affde15ffc3fcf690
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-peek-remote.txt
@@ -0,0 +1,53 @@
+git-peek-remote(1)
+==================
+v0.1, July 2005
+
+NAME
+----
+git-peek-remote - Lists the references on a remote repository.
+
+
+SYNOPSIS
+--------
+'git-peek-remote' [--exec=<git-upload-pack>] [<host>:]<directory>
+
+DESCRIPTION
+-----------
+Lists the references the remote repository has, and optionally
+stores them in the local repository under the same name.
+
+OPTIONS
+-------
+--exec=<git-upload-pack>::
+	Use this to specify the path to 'git-upload-pack' on the
+	remote side, if is not found on your $PATH.
+	Installations of sshd ignores the user's environment
+	setup scripts for login shells (e.g. .bash_profile) and
+	your privately installed GIT may not be found on the system
+	default $PATH.  Another workaround suggested is to set
+	up your $PATH in ".bashrc", but this flag is for people
+	who do not want to pay the overhead for non-interactive
+	shells by having a lean .bashrc file (they set most of
+	the things up in .bash_profile).
+
+<host>::
+	A remote host that houses the repository.  When this
+	part is specified, 'git-upload-pack' is invoked via
+	ssh.
+
+<directory>::
+	The repository to sync from.
+
+
+Author
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+Documentation
+--------------
+Documentation by Junio C Hamano.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -131,12 +131,12 @@ link:git-clone-pack.html[git-clone-pack]
 	Clones a repository into the current repository (engine
 	for ssh and local transport)
 
-link:git-fetch-script.html[git-pull-script]::
-	Pull from a repote repository via various protocols
+link:git-fetch-script.html[git-fetch-script]::
+	Download from a remote repository via various protocols
 	(user interface).
 
 link:git-pull-script.html[git-pull-script]::
-	Fetch from and merge with a repote repository via
+	Fetch from and merge with a remote repository via
 	various protocols (user interface).
 
 link:git-http-pull.html[git-http-pull]::
@@ -160,6 +160,9 @@ link:git-clone-pack.html[git-clone-pack]
 link:git-fetch-pack.html[git-fetch-pack]::
 	Updates from a remote repository.
 
+link:git-peek-remote.html[git-peek-remote]::
+	Lists references on a remote repository using upload-pack protocol.
+
 link:git-upload-pack.html[git-upload-pack]::
 	Invoked by 'git-clone-pack' and 'git-fetch-pack' to push
 	what are asked for.
