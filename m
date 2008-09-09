From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Start conforming code to "git subcmd" style part 2
Date: Tue, 9 Sep 2008 13:28:30 +0300
Message-ID: <20080909102830.GA9856@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Andreas Ericsson <ae@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 12:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd0Th-0002rk-GV
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 12:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbYIIK2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 06:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbYIIK2d
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 06:28:33 -0400
Received: from zakalwe.fi ([80.83.5.154]:48569 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbYIIK2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 06:28:32 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id CD3102BC68; Tue,  9 Sep 2008 13:28:30 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95370>

User notifications are presented as 'git cmd', and code comments
are presented as '"cmd"' or 'git's cmd', rather than 'git-cmd'.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 builtin-checkout-index.c |   14 +++++++-------
 builtin-commit-tree.c    |    2 +-
 builtin-fetch-pack.c     |    2 +-
 builtin-fetch.c          |    6 +++---
 builtin-http-fetch.c     |    4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 90f8523..55b7aaf 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -5,26 +5,26 @@
  *
  * Careful: order of argument flags does matter. For example,
  *
- *	git-checkout-index -a -f file.c
+ *	git checkout-index -a -f file.c
  *
  * Will first check out all files listed in the cache (but not
  * overwrite any old ones), and then force-checkout "file.c" a
  * second time (ie that one _will_ overwrite any old contents
  * with the same filename).
  *
- * Also, just doing "git-checkout-index" does nothing. You probably
- * meant "git-checkout-index -a". And if you want to force it, you
- * want "git-checkout-index -f -a".
+ * Also, just doing "git checkout-index" does nothing. You probably
+ * meant "git checkout-index -a". And if you want to force it, you
+ * want "git checkout-index -f -a".
  *
  * Intuitiveness is not the goal here. Repeatability is. The
  * reason for the "no arguments means no work" thing is that
  * from scripts you are supposed to be able to do things like
  *
- *	find . -name '*.h' -print0 | xargs -0 git-checkout-index -f --
+ *	find . -name '*.h' -print0 | xargs -0 git checkout-index -f --
  *
  * or:
  *
- *	find . -name '*.h' -print0 | git-checkout-index -f -z --stdin
+ *	find . -name '*.h' -print0 | git checkout-index -f -z --stdin
  *
  * which will force all existing *.h files to be replaced with
  * their cached copies. If an empty command line implied "all",
@@ -107,7 +107,7 @@ static int checkout_file(const char *name, int prefix_length)
 	}
 
 	if (!state.quiet) {
-		fprintf(stderr, "git-checkout-index: %s ", name);
+		fprintf(stderr, "git checkout-index: %s ", name);
 		if (!has_same_name)
 			fprintf(stderr, "is not in the cache");
 		else if (checkout_stage)
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 8a5ba4c..f2684bb 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -24,7 +24,7 @@ static void check_valid(unsigned char *sha1, enum object_type expect)
 		    typename(expect));
 }
 
-static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
+static const char commit_tree_usage[] = "git commit-tree <sha1> [-p <sha1>]* < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 459c6f0..4dfef29 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -750,7 +750,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (!ret && nr_heads) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
-		 * Otherwise, 'git-fetch remote no-such-ref' would
+		 * Otherwise, 'git fetch remote no-such-ref' would
 		 * silently succeed without issuing an error.
 		 */
 		for (i = 0; i < nr_heads; i++)
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 7eec4a0..ee93d3a 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -86,10 +86,10 @@ static void add_merge_config(struct ref **head,
 		/*
 		 * Not fetched to a tracking branch?  We need to fetch
 		 * it anyway to allow this branch's "branch.$name.merge"
-		 * to be honored by git-pull, but we do not have to
+		 * to be honored by 'git pull', but we do not have to
 		 * fail if branch.$name.merge is misconfigured to point
 		 * at a nonexisting branch.  If we were indeed called by
-		 * git-pull, it will notice the misconfiguration because
+		 * 'git pull', it will notice the misconfiguration because
 		 * there is no entry in the resulting FETCH_HEAD marked
 		 * for merging.
 		 */
@@ -396,7 +396,7 @@ static int store_updated_refs(const char *url, const char *remote_name,
  * The refs we are going to fetch are in to_fetch (nr_heads in
  * total).  If running
  *
- *  $ git-rev-list --objects to_fetch[0] to_fetch[1] ... --not --all
+ *  $ git rev-list --objects to_fetch[0] to_fetch[1] ... --not --all
  *
  * does not error out, that means everything reachable from the
  * refs we are going to fetch exists and is connected to some of
diff --git a/builtin-http-fetch.c b/builtin-http-fetch.c
index 3a06248..03f34d7 100644
--- a/builtin-http-fetch.c
+++ b/builtin-http-fetch.c
@@ -42,7 +42,7 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 		arg++;
 	}
 	if (argc < arg + 2 - commits_on_stdin) {
-		usage("git-http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url");
+		usage("git http-fetch [-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url");
 		return 1;
 	}
 	if (commits_on_stdin) {
@@ -75,7 +75,7 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 		fprintf(stderr,
 "Some loose object were found to be corrupt, but they might be just\n"
 "a false '404 Not Found' error message sent with incorrect HTTP\n"
-"status code.  Suggest running git-fsck.\n");
+"status code.  Suggest running 'git fsck'.\n");
 	}
 
 	walker_free(walker);
-- 
1.6.0.1
