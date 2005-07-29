From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/2] Trivial tidyups
Date: Fri, 29 Jul 2005 11:00:45 +0200
Message-ID: <20050729090045.GM24895@pasky.ji.cz>
References: <20050729085819.GL24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 11:02:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyQkL-0004cl-M6
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 11:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVG2JBC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 05:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVG2JBC
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 05:01:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56332 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262530AbVG2JAu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 05:00:50 -0400
Received: (qmail 9965 invoked by uid 2001); 29 Jul 2005 09:00:45 -0000
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20050729085819.GL24895@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Simple whitespace-related tidyups ensuring style consistency.

This is carried over from my old git-pb branch.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit 83b1762040b111b4736d108cd91b8a9d75aad3a9
tree e07192546e9bd6a972e3945dd941fc7a29ec1a4b
parent d854f783af2a441827d66b4b70e9d0d9e3434b15
author Petr Baudis <pasky@suse.cz> Sat, 23 Jul 2005 00:21:48 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Sat, 23 Jul 2005 00:21:48 +0200

 Documentation/git-write-tree.txt |    3 +--
 git-merge-one-file-script        |    7 +++----
 write-tree.c                     |    4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -9,8 +9,7 @@ git-write-tree - Creates a tree from the
 
 SYNOPSIS
 --------
-'git-write-tree'
-		[--missing-ok]
+'git-write-tree' [--missing-ok]
 
 DESCRIPTION
 -----------
diff --git a/git-merge-one-file-script b/git-merge-one-file-script
--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
@@ -22,11 +22,10 @@ case "${1:-.}${2:-.}${3:-.}" in
 #
 "$1.." | "$1.$1" | "$1$1.")
 	echo "Removing $4"
-	if test -f "$4"
-	then
+	if test -f "$4"; then
 		rm -f -- "$4"
 	fi &&
-	exec git-update-cache --remove -- "$4"
+		exec git-update-cache --remove -- "$4"
 	;;
 
 #
@@ -62,7 +61,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 
 	# We reset the index to the first branch, making
 	# git-diff-file useful
-	git-update-cache --add --cacheinfo "$6" "$2" "$4" 
+	git-update-cache --add --cacheinfo "$6" "$2" "$4"
 		git-checkout-cache -u -f -- "$4" &&
 		merge "$4" "$orig" "$src2"
 	ret=$?
diff --git a/write-tree.c b/write-tree.c
--- a/write-tree.c
+++ b/write-tree.c
@@ -89,14 +89,14 @@ int main(int argc, char **argv)
 	int entries = read_cache();
 	unsigned char sha1[20];
 	
-	if (argc==2) {
+	if (argc == 2) {
 		if (!strcmp(argv[1], "--missing-ok"))
 			missing_ok = 1;
 		else
 			die("unknown option %s", argv[1]);
 	}
 	
-	if (argc>2)
+	if (argc > 2)
 		die("too many options");
 
 	if (entries < 0)
