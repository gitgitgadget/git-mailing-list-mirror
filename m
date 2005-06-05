From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH-CAREFUL/RENAME] rename git-rpush and git-rpull to
 git-ssh-push and git-ssh-pull
Date: Sun, 05 Jun 2005 15:41:05 -0700
Message-ID: <7vmzq4zata.fsf@assigned-by-dhcp.cox.net>
References: <7vk6l9flzr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.21.0506050132590.30848-100000@iabervon.org>
	<7vfyvxb89m.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051427280.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 00:38:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df3kx-0003Pn-3V
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 00:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVFEWln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 18:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVFEWln
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 18:41:43 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:62849 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261626AbVFEWlc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 18:41:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605224104.QUQZ16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 18:41:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506051427280.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 5 Jun 2005 14:31:08 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> However, I've now made "git-apply" fully functional, and as far as I can 
LT> tell, it would happily eat this patch. However, it so happens that your 
LT> patch conflicts with the other patches sent yesterday, so it won't.

Here is a rebase.  To apply with git-apply, you need the "Yes,
sir" patch to grok "rename from/to".

------------
In preparation for 1.0 release, this makes the command names
consistent with others in git-*-pull family.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/Documentation/git-rpull.txt b/Documentation/git-ssh-pull.txt
similarity index 90%
rename from Documentation/git-rpull.txt
rename to Documentation/git-ssh-pull.txt
--- a/Documentation/git-rpull.txt
+++ b/Documentation/git-ssh-pull.txt
@@ -1,21 +1,21 @@
-git-rpull(1)
-============
+git-ssh-pull(1)
+===============
 v0.1, May 2005
 
 NAME
 ----
-git-rpull - Pulls from a remote repository over ssh connection
+git-ssh-pull - Pulls from a remote repository over ssh connection
 
 
 
 SYNOPSIS
 --------
-'git-rpull' [-c] [-t] [-a] [-d] [-v] [--recover] commit-id url
+'git-ssh-pull' [-c] [-t] [-a] [-d] [-v] [--recover] commit-id url
 
 DESCRIPTION
 -----------
-Pulls from a remote repository over ssh connection, invoking git-rpush on
-the other end.
+Pulls from a remote repository over ssh connection, invoking git-ssh-push
+on the other end.
 
 OPTIONS
 -------
diff --git a/Documentation/git-rpush.txt b/Documentation/git-ssh-push.txt
similarity index 71%
rename from Documentation/git-rpush.txt
rename to Documentation/git-ssh-push.txt
--- a/Documentation/git-rpush.txt
+++ b/Documentation/git-ssh-push.txt
@@ -1,19 +1,19 @@
-git-rpush(1)
-============
+git-ssh-push(1)
+===============
 v0.1, May 2005
 
 NAME
 ----
-git-rpush - Helper "server-side" program used by git-rpull
+git-ssh-push - Helper "server-side" program used by git-ssh-pull
 
 
 SYNOPSIS
 --------
-'git-rpush'
+'git-ssh-push'
 
 DESCRIPTION
 -----------
-Helper "server-side" program used by git-rpull.
+Helper "server-side" program used by git-ssh-pull.
 
 
 Author
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -148,7 +148,7 @@ link:git-resolve-script.html[git-resolve
 link:git-tag-script.html[git-tag-script]::
 	An example script to create a tag object signed with GPG
 
-link:git-rpull.html[git-rpull]::
+link:git-ssh-pull.html[git-ssh-pull]::
 	Pulls from a remote repository over ssh connection
 
 Interogators:
@@ -156,8 +156,8 @@ Interogators:
 link:git-diff-helper.html[git-diff-helper]::
 	Generates patch format output for git-diff-*
 
-link:git-rpush.html[git-rpush]::
-	Helper "server-side" program used by git-rpull
+link:git-ssh-push.html[git-ssh-push]::
+	Helper "server-side" program used by git-ssh-pull
 
 
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -30,7 +30,7 @@ PROG=   git-update-cache git-diff-files 
 	git-checkout-cache git-diff-tree git-rev-tree git-ls-files \
 	git-check-files git-ls-tree git-merge-base git-merge-cache \
 	git-unpack-file git-export git-diff-cache git-convert-cache \
-	git-http-pull git-rpush git-rpull git-rev-list git-mktag \
+	git-http-pull git-ssh-push git-ssh-pull git-rev-list git-mktag \
 	git-diff-helper git-tar-tree git-local-pull git-write-blob \
 	git-get-tar-commit-id git-mkdelta git-apply git-stripspace
 
@@ -105,8 +105,8 @@ git-diff-cache: diff-cache.c
 git-convert-cache: convert-cache.c
 git-http-pull: http-pull.c pull.c
 git-local-pull: local-pull.c pull.c
-git-rpush: rsh.c
-git-rpull: rsh.c pull.c
+git-ssh-push: rsh.c
+git-ssh-pull: rsh.c pull.c
 git-rev-list: rev-list.c
 git-mktag: mktag.c
 git-diff-helper: diff-helper.c
diff --git a/rpull.c b/ssh-pull.c
similarity index 97%
rename from rpull.c
rename to ssh-pull.c
--- a/rpull.c
+++ b/ssh-pull.c
@@ -64,13 +64,13 @@ int main(int argc, char **argv)
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("git-rpull [-c] [-t] [-a] [-v] [-d] [--recover] commit-id url");
+		usage("git-ssh-pull [-c] [-t] [-a] [-v] [-d] [--recover] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
 	url = argv[arg + 1];
 
-	if (setup_connection(&fd_in, &fd_out, "git-rpush", url, arg, argv + 1))
+	if (setup_connection(&fd_in, &fd_out, "git-ssh-push", url, arg, argv + 1))
 		return 1;
 
 	if (get_version())
diff --git a/rpush.c b/ssh-push.c
similarity index 93%
rename from rpush.c
rename to ssh-push.c
--- a/rpush.c
+++ b/ssh-push.c
@@ -16,7 +16,7 @@ int serve_object(int fd_in, int fd_out) 
 	do {
 		size = read(fd_in, sha1 + posn, 20 - posn);
 		if (size < 0) {
-			perror("git-rpush: read ");
+			perror("git-ssh-push: read ");
 			return -1;
 		}
 		if (!size)
@@ -30,7 +30,7 @@ int serve_object(int fd_in, int fd_out) 
 	buf = map_sha1_file(sha1, &objsize);
 	
 	if (!buf) {
-		fprintf(stderr, "git-rpush: could not find %s\n", 
+		fprintf(stderr, "git-ssh-push: could not find %s\n", 
 			sha1_to_hex(sha1));
 		remote = -1;
 	}
@@ -45,9 +45,9 @@ int serve_object(int fd_in, int fd_out) 
 		size = write(fd_out, buf + posn, objsize - posn);
 		if (size <= 0) {
 			if (!size) {
-				fprintf(stderr, "git-rpush: write closed");
+				fprintf(stderr, "git-ssh-push: write closed");
 			} else {
-				perror("git-rpush: write ");
+				perror("git-ssh-push: write ");
 			}
 			return -1;
 		}
@@ -71,7 +71,7 @@ void service(int fd_in, int fd_out) {
 		retval = read(fd_in, &type, 1);
 		if (retval < 1) {
 			if (retval < 0)
-				perror("rpush: read ");
+				perror("git-ssh-push: read ");
 			return;
 		}
 		if (type == 'v' && serve_version(fd_in, fd_out))
@@ -91,12 +91,12 @@ int main(int argc, char **argv)
                 arg++;
         }
         if (argc < arg + 2) {
-		usage("git-rpush [-c] [-t] [-a] commit-id url");
+		usage("git-ssh-push [-c] [-t] [-a] commit-id url");
                 return 1;
         }
 	commit_id = argv[arg];
 	url = argv[arg + 1];
-	if (setup_connection(&fd_in, &fd_out, "git-rpull", url, arg, argv + 1))
+	if (setup_connection(&fd_in, &fd_out, "git-ssh-pull", url, arg, argv + 1))
 		return 1;
 
 	service(fd_in, fd_out);

