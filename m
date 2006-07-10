From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix more typos, primarily in the code
Date: Mon, 10 Jul 2006 01:50:18 -0400
Message-ID: <20060710055018.30184.3359.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Jul 10 07:50:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzof5-00029X-4o
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 07:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWGJFuX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 01:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWGJFuX
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 01:50:23 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:24987 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751336AbWGJFuV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 01:50:21 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fzoey-0004GG-8Z
	for git@vger.kernel.org; Mon, 10 Jul 2006 01:50:20 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1Fzoew-0007qx-UB
	for git@vger.kernel.org; Mon, 10 Jul 2006 01:50:18 -0400
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23592>

From: Pavel Roskin <proski@gnu.org>

The only visible change is that git-blame doesn't understand
"--compability" anymore, but it does accept "--compatibility" instead,
which is already documented.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Documentation/git-name-rev.txt   |    2 +-
 blame.c                          |   20 ++++++++++----------
 builtin-apply.c                  |    4 ++--
 builtin-diff.c                   |    2 +-
 builtin-grep.c                   |    2 +-
 builtin-help.c                   |    2 +-
 builtin-push.c                   |    2 +-
 builtin-rm.c                     |    2 +-
 combine-diff.c                   |    2 +-
 compat/subprocess.py             |    6 +++---
 contrib/colordiff/colordiff.perl |    2 +-
 contrib/git-svn/git-svn.perl     |    2 +-
 diff-delta.c                     |    6 +++---
 fetch-clone.c                    |    4 ++--
 git-am.sh                        |    2 +-
 git-applypatch.sh                |    2 +-
 git-archimport.perl              |    8 ++++----
 git-commit.sh                    |    2 +-
 git-cvsexportcommit.perl         |    4 ++--
 git-instaweb.sh                  |    2 +-
 git-merge-one-file.sh            |    2 +-
 git-merge-recursive.py           |    2 +-
 git-push.sh                      |    2 +-
 git-quiltimport.sh               |    2 +-
 git-send-email.perl              |    2 +-
 name-rev.c                       |    2 +-
 pack-objects.c                   |    4 ++--
 ppc/sha1ppc.S                    |    2 +-
 sha1_file.c                      |    2 +-
 t/t5700-clone-reference.sh       |    2 +-
 t/t5710-info-alternate.sh        |    2 +-
 t/t6002-rev-list-bisect.sh       |    2 +-
 t/t6021-merge-criss-cross.sh     |    2 +-
 xdiff/xdiffi.c                   |    6 +++---
 34 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 39a1434..43f8c25 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -26,7 +26,7 @@ OPTIONS
 	List all commits reachable from all refs
 
 --stdin::
-	Read from stdin, append "(<rev_name>)" to all sha1's of name'able
+	Read from stdin, append "(<rev_name>)" to all sha1's of nameable
 	commits, and pass to stdout
 
 EXAMPLE
diff --git a/blame.c b/blame.c
index c86e2fd..0a06026 100644
--- a/blame.c
+++ b/blame.c
@@ -21,11 +21,11 @@ #include "xdiff-interface.h"
 #define DEBUG 0
 
 static const char blame_usage[] = "[-c] [-l] [-t] [-S <revs-file>] [--] file [commit]\n"
-	"  -c, --compability Use the same output mode as git-annotate (Default: off)\n"
-	"  -l, --long        Show long commit SHA1 (Default: off)\n"
-	"  -t, --time        Show raw timestamp (Default: off)\n"
-	"  -S, --revs-file   Use revisions from revs-file instead of calling git-rev-list\n"
-	"  -h, --help        This message";
+	"  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
+	"  -l, --long          Show long commit SHA1 (Default: off)\n"
+	"  -t, --time          Show raw timestamp (Default: off)\n"
+	"  -S, --revs-file     Use revisions from revs-file instead of calling git-rev-list\n"
+	"  -h, --help          This message";
 
 static struct commit **blame_lines;
 static int num_blame_lines;
@@ -747,7 +747,7 @@ int main(int argc, const char **argv)
 	const char *filename = NULL, *commit = NULL;
 	char filename_buf[256];
 	int sha1_len = 8;
-	int compability = 0;
+	int compatibility = 0;
 	int show_raw_time = 0;
 	int options = 1;
 	struct commit* start_commit;
@@ -774,8 +774,8 @@ int main(int argc, const char **argv)
 				sha1_len = 40;
 				continue;
 			} else if(!strcmp(argv[i], "-c") ||
-				  !strcmp(argv[i], "--compability")) {
-				compability = 1;
+				  !strcmp(argv[i], "--compatibility")) {
+				compatibility = 1;
 				continue;
 			} else if(!strcmp(argv[i], "-t") ||
 				  !strcmp(argv[i], "--time")) {
@@ -784,7 +784,7 @@ int main(int argc, const char **argv)
 			} else if(!strcmp(argv[i], "-S")) {
 				if (i + 1 < argc &&
 				    !read_ancestry(argv[i + 1], &sha1_p)) {
-					compability = 1;
+					compatibility = 1;
 					i++;
 					continue;
 				}
@@ -884,7 +884,7 @@ int main(int argc, const char **argv)
 		u = c->util;
 		get_commit_info(c, &ci);
 		fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
-		if(compability) {
+		if(compatibility) {
 			printf("\t(%10s\t%10s\t%d)", ci.author,
 			       format_time(ci.author_time, ci.author_tz,
 					   show_raw_time),
diff --git a/builtin-apply.c b/builtin-apply.c
index c3af489..1e5b846 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -765,7 +765,7 @@ static int find_header(char *line, unsig
 			continue;
 
 		/*
-		 * Make sure we don't find any unconnected patch fragmants.
+		 * Make sure we don't find any unconnected patch fragments.
 		 * That's a sign that we didn't find a header, and that a
 		 * patch has become corrupted/broken up.
 		 */
@@ -990,7 +990,7 @@ static int parse_binary(char *buffer, un
 	 * so one line can fit up to 13 groups that would decode
 	 * to 52 bytes max.  The length byte 'A'-'Z' corresponds
 	 * to 1-26 bytes, and 'a'-'z' corresponds to 27-52 bytes.
-	 * The end of binary is signalled with an empty line.
+	 * The end of binary is signaled with an empty line.
 	 */
 	int llen, used;
 	struct fragment *fragment;
diff --git a/builtin-diff.c b/builtin-diff.c
index d520c7c..527952f 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -176,7 +176,7 @@ static int builtin_diff_tree(struct rev_
 		usage(builtin_diff_usage);
 
 	/* We saw two trees, ent[0] and ent[1].
-	 * if ent[1] is unintesting, they are swapped
+	 * if ent[1] is uninteresting, they are swapped
 	 */
 	if (ent[1].item->flags & UNINTERESTING)
 		swap = 1;
diff --git a/builtin-grep.c b/builtin-grep.c
index 6973c66..0399393 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -686,7 +686,7 @@ int cmd_grep(int argc, const char **argv
 	 * pattern, but then what follows it must be zero or more
 	 * valid refs up to the -- (if exists), and then existing
 	 * paths.  If there is an explicit pattern, then the first
-	 * unrecocnized non option is the beginning of the refs list
+	 * unrecognized non option is the beginning of the refs list
 	 * that continues up to the -- (if exists), and then paths.
 	 */
 
diff --git a/builtin-help.c b/builtin-help.c
index 7470faa..335fe5f 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -12,7 +12,7 @@ #include "common-cmds.h"
 static const char git_usage[] =
 	"Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
 
-/* most gui terms set COLUMNS (although some don't export it) */
+/* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
 	char *col_string = getenv("COLUMNS");
diff --git a/builtin-push.c b/builtin-push.c
index 66b9407..a8fac88 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -104,7 +104,7 @@ static int get_remotes_uri(const char *r
 			if (n < MAX_URI)
 				uri[n++] = strdup(s);
 			else
-				error("more than %d URL's specified, ignoreing the rest", MAX_URI);
+				error("more than %d URL's specified, ignoring the rest", MAX_URI);
 		}
 		else if (is_refspec && !has_explicit_refspec)
 			add_refspec(strdup(s));
diff --git a/builtin-rm.c b/builtin-rm.c
index 875d825..5deb811 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -129,7 +129,7 @@ int cmd_rm(int argc, const char **argv, 
 	 * workspace. If we fail to remove the first one, we
 	 * abort the "git rm" (but once we've successfully removed
 	 * any file at all, we'll go ahead and commit to it all:
-	 * by then we've already committed ourself and can't fail
+	 * by then we've already committed ourselves and can't fail
 	 * in the middle)
 	 */
 	if (force) {
diff --git a/combine-diff.c b/combine-diff.c
index caffb92..1bc1484 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -320,7 +320,7 @@ static int give_context(struct sline *sl
 	unsigned long i;
 
 	/* Two groups of interesting lines may have a short gap of
-	 * unintersting lines.  Connect such groups to give them a
+	 * uninteresting lines.  Connect such groups to give them a
 	 * bit of context.
 	 *
 	 * We first start from what the interesting() function says,
diff --git a/compat/subprocess.py b/compat/subprocess.py
index bbd26c7..6474eab 100644
--- a/compat/subprocess.py
+++ b/compat/subprocess.py
@@ -568,7 +568,7 @@ class Popen(object):
         # Windows methods
         #
         def _get_handles(self, stdin, stdout, stderr):
-            """Construct and return tupel with IO objects:
+            """Construct and return tuple with IO objects:
             p2cread, p2cwrite, c2pread, c2pwrite, errread, errwrite
             """
             if stdin == None and stdout == None and stderr == None:
@@ -635,7 +635,7 @@ class Popen(object):
 
 
         def _find_w9xpopen(self):
-            """Find and return absolut path to w9xpopen.exe"""
+            """Find and return absolute path to w9xpopen.exe"""
             w9xpopen = os.path.join(os.path.dirname(GetModuleFileName(0)),
                                     "w9xpopen.exe")
             if not os.path.exists(w9xpopen):
@@ -812,7 +812,7 @@ class Popen(object):
         # POSIX methods
         #
         def _get_handles(self, stdin, stdout, stderr):
-            """Construct and return tupel with IO objects:
+            """Construct and return tuple with IO objects:
             p2cread, p2cwrite, c2pread, c2pwrite, errread, errwrite
             """
             p2cread, p2cwrite = None, None
diff --git a/contrib/colordiff/colordiff.perl b/contrib/colordiff/colordiff.perl
index 5789cfb..9566a76 100755
--- a/contrib/colordiff/colordiff.perl
+++ b/contrib/colordiff/colordiff.perl
@@ -110,7 +110,7 @@ foreach $config_file (@config_files) {
     }
 }
 
-# colordiff specfic options here.  Need to pre-declare if using variables
+# colordiff specific options here.  Need to pre-declare if using variables
 GetOptions(
     "no-banner" => sub { $show_banner = 0 },
     "plain-text=s" => \&set_color,
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 8bc4188..754806a 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -2429,7 +2429,7 @@ sub extract_metadata {
 							\s([a-f\d\-]+)$/x);
 	if (!$rev || !$uuid || !$url) {
 		# some of the original repositories I made had
-		# indentifiers like this:
+		# identifiers like this:
 		($rev, $uuid) = ($id =~/^git-svn-id:\s(\d+)\@([a-f\d\-]+)/);
 	}
 	return ($url, $rev, $uuid);
diff --git a/diff-delta.c b/diff-delta.c
index 8b9172a..7da9205 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -148,7 +148,7 @@ struct delta_index * create_delta_index(
 		return NULL;
 
 	/* Determine index hash size.  Note that indexing skips the
-	   first byte to allow for optimizing the rabin polynomial
+	   first byte to allow for optimizing the Rabin's polynomial
 	   initialization in create_delta(). */
 	entries = (bufsize - 1)  / RABIN_WINDOW;
 	hsize = entries / 4;
@@ -205,7 +205,7 @@ struct delta_index * create_delta_index(
 
 	/*
 	 * Determine a limit on the number of entries in the same hash
-	 * bucket.  This guard us against patological data sets causing
+	 * bucket.  This guards us against pathological data sets causing
 	 * really bad hash distribution with most entries in the same hash
 	 * bucket that would bring us to O(m*n) computing costs (m and n
 	 * corresponding to reference and target buffer sizes).
@@ -240,7 +240,7 @@ void free_delta_index(struct delta_index
 
 /*
  * The maximum size for any opcode sequence, including the initial header
- * plus rabin window plus biggest copy.
+ * plus Rabin window plus biggest copy.
  */
 #define MAX_OP_SIZE	(5 + 5 + 1 + RABIN_WINDOW + 7)
 
diff --git a/fetch-clone.c b/fetch-clone.c
index c16b0c4..81d1371 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -198,8 +198,8 @@ #define NR_AVERAGE (4)
 
 /*
  * A "binary msec" is a power-of-two-msec, aka 1/1024th of a second.
- * Keeing the time in that format means that "bytes / msecs" means
- * is the same as kB/s (modulo rounding).
+ * Keeping the time in that format means that "bytes / msecs" means
+ * the same as kB/s (modulo rounding).
  *
  * 1000512 is a magic number (usecs in a second, rounded up by half
  * of 1024, to make "rounding" come out right ;)
diff --git a/git-am.sh b/git-am.sh
index 679045a..db9a20a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -77,7 +77,7 @@ fall_back_3way () {
     # This is not so wrong.  Depending on which base we picked,
     # orig_tree may be wildly different from ours, but his_tree
     # has the same set of wildly different changes in parts the
-    # patch did not touch, so resolve ends up cancelling them,
+    # patch did not touch, so resolve ends up canceling them,
     # saying that we reverted all those changes.
 
     git-merge-resolve $orig_tree -- HEAD $his_tree || {
diff --git a/git-applypatch.sh b/git-applypatch.sh
index e4b0947..8df2aee 100755
--- a/git-applypatch.sh
+++ b/git-applypatch.sh
@@ -182,7 +182,7 @@ git-apply --index "$PATCHFILE" || {
 	# This is not so wrong.  Depending on which base we picked,
 	# orig_tree may be wildly different from ours, but his_tree
 	# has the same set of wildly different changes in parts the
-	# patch did not touch, so resolve ends up cancelling them,
+	# patch did not touch, so resolve ends up canceling them,
 	# saying that we reverted all those changes.
 
 	if git-merge-resolve $orig_tree -- HEAD $his_tree
diff --git a/git-archimport.perl b/git-archimport.perl
index 740bc1f..ada60ec 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -14,7 +14,7 @@ #
 
 Imports a project from one or more Arch repositories. It will follow branches
 and repositories within the namespaces defined by the <archive/branch>
-parameters suppplied. If it cannot find the remote branch a merge comes from
+parameters supplied. If it cannot find the remote branch a merge comes from
 it will just import it as a regular commit. If it can find it, it will mark it 
 as a merge whenever possible.
 
@@ -88,7 +88,7 @@ usage if $opt_h;
 # $arch_branches:
 # values associated with keys:
 #   =1 - Arch version / git 'branch' detected via abrowse on a limit
-#   >1 - Arch version / git 'branch' of an auxilliary branch we've merged
+#   >1 - Arch version / git 'branch' of an auxiliary branch we've merged
 my %arch_branches = map { $_ => 1 } @ARGV;
 
 $ENV{'TMPDIR'} = $opt_t if $opt_t; # $ENV{TMPDIR} will affect tempdir() calls:
@@ -667,7 +667,7 @@ sub apply_cset {
     if (`find $tmp/changeset/patches -type f -name '*.patch'`) {
         # this can be sped up considerably by doing
         #    (find | xargs cat) | patch
-        # but that cna get mucked up by patches
+        # but that can get mucked up by patches
         # with missing trailing newlines or the standard 
         # 'missing newline' flag in the patch - possibly
         # produced with an old/buggy diff.
@@ -1026,7 +1026,7 @@ sub commitid2pset {
 }
 
 
-# an alterative to `command` that allows input to be passed as an array
+# an alternative to `command` that allows input to be passed as an array
 # to work around shell problems with weird characters in arguments
 sub safe_pipe_capture {
     my @output;
diff --git a/git-commit.sh b/git-commit.sh
index 08d786d..351d13c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -599,7 +599,7 @@ then
 	GIT_AUTHOR_EMAIL=`expr "z$force_author" : '.*\(<.*\)'` &&
 	test '' != "$GIT_AUTHOR_NAME" &&
 	test '' != "$GIT_AUTHOR_EMAIL" ||
-	die "malformatted --author parameter"
+	die "malformed --author parameter"
 	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
 elif test '' != "$use_commit"
 then
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 5dcb2f9..5d13a54 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -179,7 +179,7 @@ my @bfiles = grep(m/^Binary/, safe_pipe_
 @bfiles = map { chomp } @bfiles;
 foreach my $f (@bfiles) {
     # check that the file in cvs matches the "old" file
-    # extract the file to $tmpdir and comparre with cmp
+    # extract the file to $tmpdir and compare with cmp
     my $tree = safe_pipe_capture('git-rev-parse', "$parent^{tree}");
     chomp $tree;
     my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
@@ -273,7 +273,7 @@ sub cleanupcvs {
     }
 }
 
-# An alterative to `command` that allows input to be passed as an array
+# An alternative to `command` that allows input to be passed as an array
 # to work around shell problems with weird characters in arguments
 # if the exec returns non-zero we die
 sub safe_pipe_capture {
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 69aef3c..63b18b9 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -25,7 +25,7 @@ conf=$GIT_DIR/gitweb/httpd.conf
 
 # Defaults:
 
-# if installed, it doens't need further configuration (module_path)
+# if installed, it doesn't need further configuration (module_path)
 test -z "$httpd" && httpd='lighttpd -f'
 
 # probably the most popular browser among gitweb users
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 5619409..fba4b0c 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -8,7 +8,7 @@ #   $1 - original file SHA1 (or empty)
 #   $2 - file in branch1 SHA1 (or empty)
 #   $3 - file in branch2 SHA1 (or empty)
 #   $4 - pathname in repository
-#   $5 - orignal file mode (or empty)
+#   $5 - original file mode (or empty)
 #   $6 - file in branch1 mode (or empty)
 #   $7 - file in branch2 mode (or empty)
 #
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index ce8a31f..4039435 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -47,7 +47,7 @@ # ---------------------------------
 
 def merge(h1, h2, branch1Name, branch2Name, graph, callDepth=0, ancestor=None):
     '''Merge the commits h1 and h2, return the resulting virtual
-    commit object and a flag indicating the cleaness of the merge.'''
+    commit object and a flag indicating the cleanness of the merge.'''
     assert(isinstance(h1, Commit) and isinstance(h2, Commit))
 
     global outputIndent
diff --git a/git-push.sh b/git-push.sh
index f10cadb..21775fc 100755
--- a/git-push.sh
+++ b/git-push.sh
@@ -63,7 +63,7 @@ esac
 shift ;# away the initial 'x'
 
 # $# is now 0 if there was no explicit refspec on the command line
-# and there was no defalt refspec to push from remotes/ file.
+# and there was no default refspec to push from remotes/ file.
 # we will let git-send-pack to do its "matching refs" thing.
 
 case "$remote" in
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 86b51ab..364baff 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -49,7 +49,7 @@ if [ -n "$quilt_author" ] ; then
 	quilt_author_email=$(expr "z$quilt_author" : '.*<\([^>]*\)') &&
 	test '' != "$quilt_author_name" &&
 	test '' != "$quilt_author_email" ||
-	die "malformatted --author parameter"
+	die "malformed --author parameter"
 fi
 
 # Quilt patch directory
diff --git a/git-send-email.perl b/git-send-email.perl
index c9c1975..d7f5dce 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -361,7 +361,7 @@ Options:
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
 
-  --suppress-from Supress sending emails to yourself if your address
+  --suppress-from Suppress sending emails to yourself if your address
                   appears in a From: line.
 
    --quiet	Make git-send-email less verbose.  One line per email should be
diff --git a/name-rev.c b/name-rev.c
index 6a23f2d..083d067 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -5,7 +5,7 @@ #include "tag.h"
 #include "refs.h"
 
 static const char name_rev_usage[] =
-	"git-name-rev [--tags] ( --all | --stdin | commitish [commitish...] )\n";
+	"git-name-rev [--tags] ( --all | --stdin | committish [committish...] )\n";
 
 typedef struct rev_name {
 	const char *tip_name;
diff --git a/pack-objects.c b/pack-objects.c
index b486ea5..04a48b9 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -28,7 +28,7 @@ struct object_entry {
 	struct object_entry *delta;	/* delta base object */
 	struct packed_git *in_pack; 	/* already in pack */
 	unsigned int in_pack_offset;
-	struct object_entry *delta_child; /* delitified objects who bases me */
+	struct object_entry *delta_child; /* deltified objects who bases me */
 	struct object_entry *delta_sibling; /* other deltified objects who
 					     * uses the same base as me
 					     */
@@ -39,7 +39,7 @@ struct object_entry {
 };
 
 /*
- * Objects we are going to pack are colected in objects array (dynamically
+ * Objects we are going to pack are collected in objects array (dynamically
  * expanded).  nr_objects & nr_alloc controls this array.  They are stored
  * in the order we see -- typically rev-list --objects order that gives us
  * nice "minimum seek" order.
diff --git a/ppc/sha1ppc.S b/ppc/sha1ppc.S
index f591d98..140cb53 100644
--- a/ppc/sha1ppc.S
+++ b/ppc/sha1ppc.S
@@ -62,7 +62,7 @@ #define W(t)	((t)%16+11)
  * computation of W[t+4].
  *
  * The first 16 rounds use W values loaded directly from memory, while the
- * remianing 64 use values computed from those first 16.  We preload
+ * remaining 64 use values computed from those first 16.  We preload
  * 4 values before starting, so there are three kinds of rounds:
  * - The first 12 (all f0) also load the W values from memory.
  * - The next 64 compute W(i+4) in parallel. 8*f0, 20*f1, 20*f2, 16*f1.
diff --git a/sha1_file.c b/sha1_file.c
index bc35808..f7bb3a1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1660,7 +1660,7 @@ int has_sha1_file(const unsigned char *s
 
 /*
  * reads from fd as long as possible into a supplied buffer of size bytes.
- * If neccessary the buffer's size is increased using realloc()
+ * If necessary the buffer's size is increased using realloc()
  *
  * returns 0 if anything went fine and -1 otherwise
  *
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 916ee15..dd9caad 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -31,7 +31,7 @@ test_expect_success 'cloning with refere
 
 cd "$base_dir"
 
-test_expect_success 'existance of info/alternates' \
+test_expect_success 'existence of info/alternates' \
 'test `wc -l <C/.git/objects/info/alternates` = 2'
 
 cd "$base_dir"
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 097d037..2e1b48a 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -81,7 +81,7 @@ test_valid_repo"
 
 cd "$base_dir"
 
-test_expect_failure 'that info/alternates is neccessary' \
+test_expect_failure 'that info/alternates is necessary' \
 'cd C &&
 rm .git/objects/info/alternates &&
 test_valid_repo'
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index 693de9b..650cd68 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -154,7 +154,7 @@ test_sequence()
 	test_bisection_diff 0 $_bisect_option u5 ^U
 	
 #
-# the following illustrate's Linus' binary bug blatt idea. 
+# the following illustrates Linus' binary bug blatt idea. 
 #
 # assume the bug is actually at l3, but you don't know that - all you know is that l3 is broken
 # and it wasn't broken before
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
index 2623813..8f7366d 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -4,7 +4,7 @@ # Copyright (c) 2005 Fredrik Kuivinen
 #
 
 # See http://marc.theaimsgroup.com/?l=git&m=111463358500362&w=2 for a
-# nice decription of what this is about.
+# nice description of what this is about.
 
 
 test_description='Test criss-cross merge'
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index ed7ad20..d76e76a 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -84,7 +84,7 @@ static long xdl_split(unsigned long cons
 		 * We need to extent the diagonal "domain" by one. If the next
 		 * values exits the box boundaries we need to change it in the
 		 * opposite direction because (max - min) must be a power of two.
-		 * Also we initialize the extenal K value to -1 so that we can
+		 * Also we initialize the external K value to -1 so that we can
 		 * avoid extra conditions check inside the core loop.
 		 */
 		if (fmin > dmin)
@@ -119,7 +119,7 @@ static long xdl_split(unsigned long cons
 		 * We need to extent the diagonal "domain" by one. If the next
 		 * values exits the box boundaries we need to change it in the
 		 * opposite direction because (max - min) must be a power of two.
-		 * Also we initialize the extenal K value to -1 so that we can
+		 * Also we initialize the external K value to -1 so that we can
 		 * avoid extra conditions check inside the core loop.
 		 */
 		if (bmin > dmin)
@@ -405,7 +405,7 @@ static int xdl_change_compact(xdfile_t *
 	/*
 	 * This is the same of what GNU diff does. Move back and forward
 	 * change groups for a consistent and pretty diff output. This also
-	 * helps in finding joineable change groups and reduce the diff size.
+	 * helps in finding joinable change groups and reduce the diff size.
 	 */
 	for (ix = ixo = 0;;) {
 		/*
