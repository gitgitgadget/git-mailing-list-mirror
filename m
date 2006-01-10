From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] stgit: typo fixes
Date: Tue, 10 Jan 2006 12:14:00 -0500
Message-ID: <1136913240.2444.1.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 18:14:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwN4p-000235-Bg
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 18:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWAJROU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 12:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWAJROU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 12:14:20 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:47009 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932283AbWAJROT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 12:14:19 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EwN2W-0000FV-30
	for git@vger.kernel.org; Tue, 10 Jan 2006 12:12:08 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1EwN4L-0003Ih-6d; Tue, 10 Jan 2006 12:14:01 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
X-Mailer: Evolution 2.5.4 (2.5.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14429>

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/gitmergeonefile.py b/gitmergeonefile.py
index 9344d33..2f327a3 100755
--- a/gitmergeonefile.py
+++ b/gitmergeonefile.py
@@ -121,7 +121,7 @@ def __conflict():
 #   $2 - file in branch1 SHA1 (or empty)
 #   $3 - file in branch2 SHA1 (or empty)
 #   $4 - pathname in repository
-#   $5 - orignal file mode (or empty)
+#   $5 - original file mode (or empty)
 #   $6 - file in branch1 mode (or empty)
 #   $7 - file in branch2 mode (or empty)
 #
@@ -140,7 +140,7 @@ __checkout_files()
 if orig_hash:
     # modified in both
     if file1_hash and file2_hash:
-        # if modes are the same (git-read-tree probably dealed with it)
+        # if modes are the same (git-read-tree probably dealt with it)
         if file1_hash == file2_hash:
             if os.system('git-update-index --cacheinfo %s %s %s'
                          % (file1_mode, file1_hash, path)) != 0:
@@ -242,8 +242,8 @@ else:
         __remove_files()
         sys.exit(os.system('git-checkout-index -u -f -- %s' % path))
 
-# Un-handled case
-print >> sys.stderr, 'Error: Un-handled merge conflict'
+# Unhandled case
+print >> sys.stderr, 'Error: Unhandled merge conflict'
 print >> sys.stderr, 'gitmergeonefile.py "%s" "%s" "%s" "%s" "%s" "%s" "%s"' \
       % tuple(sys.argv[1:8])
 __conflict()
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 8084cbd..88f1433 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -1,4 +1,4 @@
-"""Function/variables commmon to all the commands
+"""Function/variables common to all the commands
 """
 
 __copyright__ = """
@@ -92,7 +92,7 @@ def check_head_top_equal():
     if not crt_series.head_top_equal():
         raise CmdException, \
               'HEAD and top are not the same. You probably committed\n' \
-              '  changes to the tree ouside of StGIT. If you know what you\n' \
+              '  changes to the tree outside of StGIT. If you know what you\n' \
               '  are doing, use the "refresh -f" command'
 
 def check_conflicts():
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 6ccdcc9..87fd5da 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -28,7 +28,7 @@ usage = """%prog [options] [<file>]
 
 Create a new patch and apply the given GNU diff file (or the standard
 input). By default, the file name is used as the patch name but this
-can be overriden with the '--name' option. The patch can either be a
+can be overridden with the '--name' option. The patch can either be a
 normal file with the description at the top or it can have standard
 mail format, the Subject, From and Date headers being used for
 generating the patch information.
@@ -219,7 +219,7 @@ def func(parser, options, args):
     elif filename:
         patch = os.path.basename(filename)
     else:
-        raise CmdException, 'Unkown patch name'
+        raise CmdException, 'Unknown patch name'
 
     # the defaults
     message = author_name = author_email = author_date = committer_name = \
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index c01c799..e932cf0 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -28,7 +28,7 @@ usage = """%prog [options] [<patch@branc
 
 Import a patch from a different branch or a commit object into the
 current series. By default, the name of the imported patch is used as
-the name of the current patch. It can be overriden with the '--name'
+the name of the current patch. It can be overridden with the '--name'
 option. A commit object can be reverted with the '--reverse'
 option. The log and author information are those of the commit object."""
 
diff --git a/stgit/git.py b/stgit/git.py
index a7b1c3f..61436bb 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -274,7 +274,7 @@ def rev_parse(git_id):
         raise GitException, 'Unknown revision: %s' % git_id
 
 def branch_exists(branch):
-    """Existance check for the named branch
+    """Existence check for the named branch
     """
     for line in _output_lines(['git-rev-parse', '--symbolic', '--all']):
         if line.strip() == branch:


-- 
Regards,
Pavel Roskin
