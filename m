From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/2] Unify usage strings declaration
Date: Fri, 29 Jul 2005 11:01:26 +0200
Message-ID: <20050729090126.GN24895@pasky.ji.cz>
References: <20050729085819.GL24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 11:02:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyQkW-0004dj-Fk
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 11:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVG2JBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 05:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVG2JBf
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 05:01:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57868 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262209AbVG2JB3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 05:01:29 -0400
Received: (qmail 10039 invoked by uid 2001); 29 Jul 2005 09:01:26 -0000
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20050729085819.GL24895@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

All usage strings are now declared as static const char [].

This is carried over from my old git-pb branch.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit 1e02de8f49a8fca696b3cb363545fad3c98fd662
tree feee1ccdea90d33fae2bf41621a876c5aa2ecfe5
parent 83b1762040b111b4736d108cd91b8a9d75aad3a9
author Petr Baudis <pasky@suse.cz> Sat, 23 Jul 2005 00:30:06 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Sat, 23 Jul 2005 00:30:06 +0200

 checkout-cache.c |    2 +-
 commit-tree.c    |    2 +-
 diff-cache.c     |    2 +-
 diff-files.c     |    2 +-
 diff-helper.c    |    2 +-
 diff-stages.c    |    2 +-
 diff-tree.c      |    2 +-
 hash-object.c    |    2 +-
 local-pull.c     |    2 +-
 ls-files.c       |    2 +-
 ls-tree.c        |    2 +-
 read-tree.c      |    2 +-
 ssh-push.c       |    2 +-
 tar-tree.c       |    2 +-
 test-delta.c     |    2 +-
 var.c            |    2 +-
 verify-pack.c    |    2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/checkout-cache.c b/checkout-cache.c
--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -75,7 +75,7 @@ static int checkout_all(void)
 	return 0;
 }
 
-static const char *checkout_cache_usage =
+static const char checkout_cache_usage[] =
 "git-checkout-cache [-u] [-q] [-a] [-f] [-n] [--prefix=<string>] [--] <file>...";
 
 int main(int argc, char **argv)
diff --git a/commit-tree.c b/commit-tree.c
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -64,7 +64,7 @@ static void check_valid(unsigned char *s
 #define MAXPARENT (16)
 static unsigned char parent_sha1[MAXPARENT][20];
 
-static char *commit_tree_usage = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
+static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
 
 static int new_parent(int idx)
 {
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -163,7 +163,7 @@ static void mark_merge_entries(void)
 	}
 }
 
-static char *diff_cache_usage =
+static const char diff_cache_usage[] =
 "git-diff-cache [-m] [--cached] "
 "[<common diff options>] <tree-ish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -6,7 +6,7 @@
 #include "cache.h"
 #include "diff.h"
 
-static const char *diff_files_usage =
+static const char diff_files_usage[] =
 "git-diff-files [-q] "
 "[<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -20,7 +20,7 @@ static void flush_them(int ac, const cha
 	diff_flush(DIFF_FORMAT_PATCH, '\n');
 }
 
-static const char *diff_helper_usage =
+static const char diff_helper_usage[] =
 "git-diff-helper [-z] [-O<orderfile>] [-S<string>] [--pickaxe-all] [<path>...]";
 
 int main(int ac, const char **av) {
diff --git a/diff-stages.c b/diff-stages.c
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -17,7 +17,7 @@ static int diff_break_opt = -1;
 static const char *orderfile = NULL;
 static const char *diff_filter = NULL;
 
-static char *diff_stages_usage =
+static const char diff_stages_usage[] =
 "git-diff-stages [<common diff options>] <stage1> <stage2> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -395,7 +395,7 @@ static int diff_tree_stdin(char *line)
 	return diff_tree_commit(commit, line);
 }
 
-static char *diff_tree_usage =
+static const char diff_tree_usage[] =
 "git-diff-tree [--stdin] [-m] [-s] [-v] [--pretty] [-t] "
 "[<common diff options>] <tree-ish> <tree-ish>"
 COMMON_DIFF_OPTIONS_HELP;
diff --git a/hash-object.c b/hash-object.c
--- a/hash-object.c
+++ b/hash-object.c
@@ -21,7 +21,7 @@ static void hash_object(const char *path
 	printf("%s\n", sha1_to_hex(sha1));
 }
 
-static const char *hash_object_usage =
+static const char hash_object_usage[] =
 "git-hash-object [-t <type>] [-w] <file>...";
 
 int main(int argc, char **argv)
diff --git a/local-pull.c b/local-pull.c
--- a/local-pull.c
+++ b/local-pull.c
@@ -101,7 +101,7 @@ int fetch_ref(char *ref, unsigned char *
 	return 0;
 }
 
-static const char *local_pull_usage = 
+static const char local_pull_usage[] =
 "git-local-pull [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [-l] [-s] [-n] commit-id path";
 
 /* 
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -285,7 +285,7 @@ static void show_files(void)
 	}
 }
 
-static const char *ls_files_usage =
+static const char ls_files_usage[] =
 	"git-ls-files [-z] [-t] (--[cached|deleted|others|stage|unmerged|killed])* "
 	"[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]";
 
diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -208,7 +208,7 @@ static int list(char **path)
 	return err;
 }
 
-static const char *ls_tree_usage =
+static const char ls_tree_usage[] =
 	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
 
 int main(int argc, char **argv)
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -510,7 +510,7 @@ static int read_cache_unmerged(void)
 	return deleted;
 }
 
-static char *read_tree_usage = "git-read-tree (<sha> | -m [-u] <sha1> [<sha2> [<sha3>]])";
+static const char read_tree_usage[] = "git-read-tree (<sha> | -m [-u] <sha1> [<sha2> [<sha3>]])";
 
 static struct cache_file cache_file;
 
diff --git a/ssh-push.c b/ssh-push.c
--- a/ssh-push.c
+++ b/ssh-push.c
@@ -96,7 +96,7 @@ static void service(int fd_in, int fd_ou
 	} while (1);
 }
 
-static const char *ssh_push_usage =
+static const char ssh_push_usage[] =
 	"git-ssh-push [-c] [-t] [-a] [-w ref] commit-id url";
 
 int main(int argc, char **argv)
diff --git a/tar-tree.c b/tar-tree.c
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -17,7 +17,7 @@
 #define EXT_HEADER_PATH		1
 #define EXT_HEADER_LINKPATH	2
 
-static const char *tar_tree_usage = "git-tar-tree <key> [basedir]";
+static const char tar_tree_usage[] = "git-tar-tree <key> [basedir]";
 
 static char block[BLOCKSIZE];
 static unsigned long offset;
diff --git a/test-delta.c b/test-delta.c
--- a/test-delta.c
+++ b/test-delta.c
@@ -17,7 +17,7 @@
 #include <sys/mman.h>
 #include "delta.h"
 
-static const char *usage =
+static const char usage[] =
 	"test-delta (-d|-p) <from_file> <data_file> <out_file>";
 
 int main(int argc, char *argv[])
diff --git a/var.c b/var.c
--- a/var.c
+++ b/var.c
@@ -8,7 +8,7 @@
 #include <errno.h>
 #include <string.h>
 
-static char *var_usage = "git-var [-l | <variable>]";
+static const char var_usage[] = "git-var [-l | <variable>]";
 
 struct git_var {
 	const char *name;
diff --git a/verify-pack.c b/verify-pack.c
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -27,7 +27,7 @@ static int verify_one_pack(char *arg, in
 	return verify_pack(g, verbose);
 }
 
-static const char *verify_pack_usage = "git-verify-pack [-v] <pack>...";
+static const char verify_pack_usage[] = "git-verify-pack [-v] <pack>...";
 
 int main(int ac, char **av)
 {
