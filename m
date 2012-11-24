From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 04/14] Rename git-remote-testgit to git-remote-testpy
Date: Sat, 24 Nov 2012 04:17:04 +0100
Message-ID: <1353727034-24698-5-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Fq-0001zJ-KK
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab2KXDRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:17:44 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab2KXDRm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:17:42 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wDzBg1AL7T8qUjb6v2hMOhM48L3DKs9lz+64B4LbCMc=;
        b=tEGOOZFUUaJfEGaOdLMECWwacQ4GaB475o/weumXzFZ91f5by5Ws7+xT7VqsvF2FIT
         TqrVE3DuSu3NjAc41lYhpfX7m9nJSLFtXHY5Qi/RB252Ol9McRaDRjWEJWlTvkvH8bbi
         yaQmJ+3D7fgdYyWCzzChaR4/7O2CWxB0oOCqBP7YyBKdNQIo21tATR5+mqcgrzlrIunj
         5J2kiVJWEFDC0+V01S99tzdeXSy+UyIg5EvM+og6XrSBSOxGpcSB5hqvNt3pYV41qWl/
         405fwSdBuGKvd0O7g9N4PK28QoJzb4Bl5wSlWNdL9/ErQAhc2HvgoVJ9zAN3CSII2aRA
         nhEQ==
Received: by 10.204.149.85 with SMTP id s21mr1671870bkv.37.1353727061225;
        Fri, 23 Nov 2012 19:17:41 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id k3sm5468345bku.13.2012.11.23.19.17.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:17:40 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210289>

This script is not really exercising the remote-helper functionality,
but more the python framework for remote helpers that live in
git_remote_helpers.

It's also not a good example of how to write remote-helpers, unless you
are planning to use python, and even then you might not want to use this
framework.

So let's use a more appropriate name: git-remote-testpy.

A patch that replaces git-remote-testgit with a simpler version is on
the way.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore                |   2 +-
 Makefile                  |   2 +-
 git-remote-testgit.py     | 272 ----------------------------------------------
 git-remote-testpy.py      | 272 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t5800-remote-helpers.sh | 148 -------------------------
 t/t5800-remote-testpy.sh  | 148 +++++++++++++++++++++++++
 6 files changed, 422 insertions(+), 422 deletions(-)
 delete mode 100644 git-remote-testgit.py
 create mode 100644 git-remote-testpy.py
 delete mode 100755 t/t5800-remote-helpers.sh
 create mode 100755 t/t5800-remote-testpy.sh

diff --git a/.gitignore b/.gitignore
index a188a82..48d1bbb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -124,7 +124,7 @@
 /git-remote-ftps
 /git-remote-fd
 /git-remote-ext
-/git-remote-testgit
+/git-remote-testpy
 /git-repack
 /git-replace
 /git-repo-config
diff --git a/Makefile b/Makefile
index f69979e..e18ee48 100644
--- a/Makefile
+++ b/Makefile
@@ -470,7 +470,7 @@ SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
-SCRIPT_PYTHON += git-remote-testgit.py
+SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
diff --git a/git-remote-testgit.py b/git-remote-testgit.py
deleted file mode 100644
index ade797b..0000000
--- a/git-remote-testgit.py
+++ /dev/null
@@ -1,272 +0,0 @@
-#!/usr/bin/env python
-
-# This command is a simple remote-helper, that is used both as a
-# testcase for the remote-helper functionality, and as an example to
-# show remote-helper authors one possible implementation.
-#
-# This is a Git <-> Git importer/exporter, that simply uses git
-# fast-import and git fast-export to consume and produce fast-import
-# streams.
-#
-# To understand better the way things work, one can activate debug
-# traces by setting (to any value) the environment variables
-# GIT_TRANSPORT_HELPER_DEBUG and GIT_DEBUG_TESTGIT, to see messages
-# from the transport-helper side, or from this example remote-helper.
-
-# hashlib is only available in python >= 2.5
-try:
-    import hashlib
-    _digest = hashlib.sha1
-except ImportError:
-    import sha
-    _digest = sha.new
-import sys
-import os
-import time
-sys.path.insert(0, os.getenv("GITPYTHONLIB","."))
-
-from git_remote_helpers.util import die, debug, warn
-from git_remote_helpers.git.repo import GitRepo
-from git_remote_helpers.git.exporter import GitExporter
-from git_remote_helpers.git.importer import GitImporter
-from git_remote_helpers.git.non_local import NonLocalGit
-
-def get_repo(alias, url):
-    """Returns a git repository object initialized for usage.
-    """
-
-    repo = GitRepo(url)
-    repo.get_revs()
-    repo.get_head()
-
-    hasher = _digest()
-    hasher.update(repo.path)
-    repo.hash = hasher.hexdigest()
-
-    repo.get_base_path = lambda base: os.path.join(
-        base, 'info', 'fast-import', repo.hash)
-
-    prefix = 'refs/testgit/%s/' % alias
-    debug("prefix: '%s'", prefix)
-
-    repo.gitdir = os.environ["GIT_DIR"]
-    repo.alias = alias
-    repo.prefix = prefix
-
-    repo.exporter = GitExporter(repo)
-    repo.importer = GitImporter(repo)
-    repo.non_local = NonLocalGit(repo)
-
-    return repo
-
-
-def local_repo(repo, path):
-    """Returns a git repository object initalized for usage.
-    """
-
-    local = GitRepo(path)
-
-    local.non_local = None
-    local.gitdir = repo.gitdir
-    local.alias = repo.alias
-    local.prefix = repo.prefix
-    local.hash = repo.hash
-    local.get_base_path = repo.get_base_path
-    local.exporter = GitExporter(local)
-    local.importer = GitImporter(local)
-
-    return local
-
-
-def do_capabilities(repo, args):
-    """Prints the supported capabilities.
-    """
-
-    print "import"
-    print "export"
-    print "refspec refs/heads/*:%s*" % repo.prefix
-
-    dirname = repo.get_base_path(repo.gitdir)
-
-    if not os.path.exists(dirname):
-        os.makedirs(dirname)
-
-    path = os.path.join(dirname, 'git.marks')
-
-    print "*export-marks %s" % path
-    if os.path.exists(path):
-        print "*import-marks %s" % path
-
-    print # end capabilities
-
-
-def do_list(repo, args):
-    """Lists all known references.
-
-    Bug: This will always set the remote head to master for non-local
-    repositories, since we have no way of determining what the remote
-    head is at clone time.
-    """
-
-    for ref in repo.revs:
-        debug("? refs/heads/%s", ref)
-        print "? refs/heads/%s" % ref
-
-    if repo.head:
-        debug("@refs/heads/%s HEAD" % repo.head)
-        print "@refs/heads/%s HEAD" % repo.head
-    else:
-        debug("@refs/heads/master HEAD")
-        print "@refs/heads/master HEAD"
-
-    print # end list
-
-
-def update_local_repo(repo):
-    """Updates (or clones) a local repo.
-    """
-
-    if repo.local:
-        return repo
-
-    path = repo.non_local.clone(repo.gitdir)
-    repo.non_local.update(repo.gitdir)
-    repo = local_repo(repo, path)
-    return repo
-
-
-def do_import(repo, args):
-    """Exports a fast-import stream from testgit for git to import.
-    """
-
-    if len(args) != 1:
-        die("Import needs exactly one ref")
-
-    if not repo.gitdir:
-        die("Need gitdir to import")
-
-    ref = args[0]
-    refs = [ref]
-
-    while True:
-        line = sys.stdin.readline()
-        if line == '\n':
-            break
-        if not line.startswith('import '):
-            die("Expected import line.")
-
-        # strip of leading 'import '
-        ref = line[7:].strip()
-        refs.append(ref)
-
-    repo = update_local_repo(repo)
-    repo.exporter.export_repo(repo.gitdir, refs)
-
-    print "done"
-
-
-def do_export(repo, args):
-    """Imports a fast-import stream from git to testgit.
-    """
-
-    if not repo.gitdir:
-        die("Need gitdir to export")
-
-    update_local_repo(repo)
-    changed = repo.importer.do_import(repo.gitdir)
-
-    if not repo.local:
-        repo.non_local.push(repo.gitdir)
-
-    for ref in changed:
-        print "ok %s" % ref
-    print
-
-
-COMMANDS = {
-    'capabilities': do_capabilities,
-    'list': do_list,
-    'import': do_import,
-    'export': do_export,
-}
-
-
-def sanitize(value):
-    """Cleans up the url.
-    """
-
-    if value.startswith('testgit::'):
-        value = value[9:]
-
-    return value
-
-
-def read_one_line(repo):
-    """Reads and processes one command.
-    """
-
-    sleepy = os.environ.get("GIT_REMOTE_TESTGIT_SLEEPY")
-    if sleepy:
-        debug("Sleeping %d sec before readline" % int(sleepy))
-        time.sleep(int(sleepy))
-
-    line = sys.stdin.readline()
-
-    cmdline = line
-
-    if not cmdline:
-        warn("Unexpected EOF")
-        return False
-
-    cmdline = cmdline.strip().split()
-    if not cmdline:
-        # Blank line means we're about to quit
-        return False
-
-    cmd = cmdline.pop(0)
-    debug("Got command '%s' with args '%s'", cmd, ' '.join(cmdline))
-
-    if cmd not in COMMANDS:
-        die("Unknown command, %s", cmd)
-
-    func = COMMANDS[cmd]
-    func(repo, cmdline)
-    sys.stdout.flush()
-
-    return True
-
-
-def main(args):
-    """Starts a new remote helper for the specified repository.
-    """
-
-    if len(args) != 3:
-        die("Expecting exactly three arguments.")
-        sys.exit(1)
-
-    if os.getenv("GIT_DEBUG_TESTGIT"):
-        import git_remote_helpers.util
-        git_remote_helpers.util.DEBUG = True
-
-    alias = sanitize(args[1])
-    url = sanitize(args[2])
-
-    if not alias.isalnum():
-        warn("non-alnum alias '%s'", alias)
-        alias = "tmp"
-
-    args[1] = alias
-    args[2] = url
-
-    repo = get_repo(alias, url)
-
-    debug("Got arguments %s", args[1:])
-
-    more = True
-
-    sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)
-    while (more):
-        more = read_one_line(repo)
-
-if __name__ == '__main__':
-    sys.exit(main(sys.argv))
diff --git a/git-remote-testpy.py b/git-remote-testpy.py
new file mode 100644
index 0000000..ade797b
--- /dev/null
+++ b/git-remote-testpy.py
@@ -0,0 +1,272 @@
+#!/usr/bin/env python
+
+# This command is a simple remote-helper, that is used both as a
+# testcase for the remote-helper functionality, and as an example to
+# show remote-helper authors one possible implementation.
+#
+# This is a Git <-> Git importer/exporter, that simply uses git
+# fast-import and git fast-export to consume and produce fast-import
+# streams.
+#
+# To understand better the way things work, one can activate debug
+# traces by setting (to any value) the environment variables
+# GIT_TRANSPORT_HELPER_DEBUG and GIT_DEBUG_TESTGIT, to see messages
+# from the transport-helper side, or from this example remote-helper.
+
+# hashlib is only available in python >= 2.5
+try:
+    import hashlib
+    _digest = hashlib.sha1
+except ImportError:
+    import sha
+    _digest = sha.new
+import sys
+import os
+import time
+sys.path.insert(0, os.getenv("GITPYTHONLIB","."))
+
+from git_remote_helpers.util import die, debug, warn
+from git_remote_helpers.git.repo import GitRepo
+from git_remote_helpers.git.exporter import GitExporter
+from git_remote_helpers.git.importer import GitImporter
+from git_remote_helpers.git.non_local import NonLocalGit
+
+def get_repo(alias, url):
+    """Returns a git repository object initialized for usage.
+    """
+
+    repo = GitRepo(url)
+    repo.get_revs()
+    repo.get_head()
+
+    hasher = _digest()
+    hasher.update(repo.path)
+    repo.hash = hasher.hexdigest()
+
+    repo.get_base_path = lambda base: os.path.join(
+        base, 'info', 'fast-import', repo.hash)
+
+    prefix = 'refs/testgit/%s/' % alias
+    debug("prefix: '%s'", prefix)
+
+    repo.gitdir = os.environ["GIT_DIR"]
+    repo.alias = alias
+    repo.prefix = prefix
+
+    repo.exporter = GitExporter(repo)
+    repo.importer = GitImporter(repo)
+    repo.non_local = NonLocalGit(repo)
+
+    return repo
+
+
+def local_repo(repo, path):
+    """Returns a git repository object initalized for usage.
+    """
+
+    local = GitRepo(path)
+
+    local.non_local = None
+    local.gitdir = repo.gitdir
+    local.alias = repo.alias
+    local.prefix = repo.prefix
+    local.hash = repo.hash
+    local.get_base_path = repo.get_base_path
+    local.exporter = GitExporter(local)
+    local.importer = GitImporter(local)
+
+    return local
+
+
+def do_capabilities(repo, args):
+    """Prints the supported capabilities.
+    """
+
+    print "import"
+    print "export"
+    print "refspec refs/heads/*:%s*" % repo.prefix
+
+    dirname = repo.get_base_path(repo.gitdir)
+
+    if not os.path.exists(dirname):
+        os.makedirs(dirname)
+
+    path = os.path.join(dirname, 'git.marks')
+
+    print "*export-marks %s" % path
+    if os.path.exists(path):
+        print "*import-marks %s" % path
+
+    print # end capabilities
+
+
+def do_list(repo, args):
+    """Lists all known references.
+
+    Bug: This will always set the remote head to master for non-local
+    repositories, since we have no way of determining what the remote
+    head is at clone time.
+    """
+
+    for ref in repo.revs:
+        debug("? refs/heads/%s", ref)
+        print "? refs/heads/%s" % ref
+
+    if repo.head:
+        debug("@refs/heads/%s HEAD" % repo.head)
+        print "@refs/heads/%s HEAD" % repo.head
+    else:
+        debug("@refs/heads/master HEAD")
+        print "@refs/heads/master HEAD"
+
+    print # end list
+
+
+def update_local_repo(repo):
+    """Updates (or clones) a local repo.
+    """
+
+    if repo.local:
+        return repo
+
+    path = repo.non_local.clone(repo.gitdir)
+    repo.non_local.update(repo.gitdir)
+    repo = local_repo(repo, path)
+    return repo
+
+
+def do_import(repo, args):
+    """Exports a fast-import stream from testgit for git to import.
+    """
+
+    if len(args) != 1:
+        die("Import needs exactly one ref")
+
+    if not repo.gitdir:
+        die("Need gitdir to import")
+
+    ref = args[0]
+    refs = [ref]
+
+    while True:
+        line = sys.stdin.readline()
+        if line == '\n':
+            break
+        if not line.startswith('import '):
+            die("Expected import line.")
+
+        # strip of leading 'import '
+        ref = line[7:].strip()
+        refs.append(ref)
+
+    repo = update_local_repo(repo)
+    repo.exporter.export_repo(repo.gitdir, refs)
+
+    print "done"
+
+
+def do_export(repo, args):
+    """Imports a fast-import stream from git to testgit.
+    """
+
+    if not repo.gitdir:
+        die("Need gitdir to export")
+
+    update_local_repo(repo)
+    changed = repo.importer.do_import(repo.gitdir)
+
+    if not repo.local:
+        repo.non_local.push(repo.gitdir)
+
+    for ref in changed:
+        print "ok %s" % ref
+    print
+
+
+COMMANDS = {
+    'capabilities': do_capabilities,
+    'list': do_list,
+    'import': do_import,
+    'export': do_export,
+}
+
+
+def sanitize(value):
+    """Cleans up the url.
+    """
+
+    if value.startswith('testgit::'):
+        value = value[9:]
+
+    return value
+
+
+def read_one_line(repo):
+    """Reads and processes one command.
+    """
+
+    sleepy = os.environ.get("GIT_REMOTE_TESTGIT_SLEEPY")
+    if sleepy:
+        debug("Sleeping %d sec before readline" % int(sleepy))
+        time.sleep(int(sleepy))
+
+    line = sys.stdin.readline()
+
+    cmdline = line
+
+    if not cmdline:
+        warn("Unexpected EOF")
+        return False
+
+    cmdline = cmdline.strip().split()
+    if not cmdline:
+        # Blank line means we're about to quit
+        return False
+
+    cmd = cmdline.pop(0)
+    debug("Got command '%s' with args '%s'", cmd, ' '.join(cmdline))
+
+    if cmd not in COMMANDS:
+        die("Unknown command, %s", cmd)
+
+    func = COMMANDS[cmd]
+    func(repo, cmdline)
+    sys.stdout.flush()
+
+    return True
+
+
+def main(args):
+    """Starts a new remote helper for the specified repository.
+    """
+
+    if len(args) != 3:
+        die("Expecting exactly three arguments.")
+        sys.exit(1)
+
+    if os.getenv("GIT_DEBUG_TESTGIT"):
+        import git_remote_helpers.util
+        git_remote_helpers.util.DEBUG = True
+
+    alias = sanitize(args[1])
+    url = sanitize(args[2])
+
+    if not alias.isalnum():
+        warn("non-alnum alias '%s'", alias)
+        alias = "tmp"
+
+    args[1] = alias
+    args[2] = url
+
+    repo = get_repo(alias, url)
+
+    debug("Got arguments %s", args[1:])
+
+    more = True
+
+    sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)
+    while (more):
+        more = read_one_line(repo)
+
+if __name__ == '__main__':
+    sys.exit(main(sys.argv))
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
deleted file mode 100755
index d46fa40..0000000
--- a/t/t5800-remote-helpers.sh
+++ /dev/null
@@ -1,148 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2010 Sverre Rabbelier
-#
-
-test_description='Test remote-helper import and export commands'
-
-. ./test-lib.sh
-
-if ! test_have_prereq PYTHON ; then
-	skip_all='skipping remote-testgit tests, python not available'
-	test_done
-fi
-
-"$PYTHON_PATH" -c '
-import sys
-if sys.hexversion < 0x02040000:
-    sys.exit(1)
-' || {
-	skip_all='skipping remote-testgit tests, python version < 2.4'
-	test_done
-}
-
-compare_refs() {
-	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
-	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
-	test_cmp expect actual
-}
-
-test_expect_success 'setup repository' '
-	git init --bare server/.git &&
-	git clone server public &&
-	(cd public &&
-	 echo content >file &&
-	 git add file &&
-	 git commit -m one &&
-	 git push origin master)
-'
-
-test_expect_success 'cloning from local repo' '
-	git clone "testgit::${PWD}/server" localclone &&
-	test_cmp public/file localclone/file
-'
-
-test_expect_success 'cloning from remote repo' '
-	git clone "testgit::file://${PWD}/server" clone &&
-	test_cmp public/file clone/file
-'
-
-test_expect_success 'create new commit on remote' '
-	(cd public &&
-	 echo content >>file &&
-	 git commit -a -m two &&
-	 git push)
-'
-
-test_expect_success 'pulling from local repo' '
-	(cd localclone && git pull) &&
-	test_cmp public/file localclone/file
-'
-
-test_expect_success 'pulling from remote remote' '
-	(cd clone && git pull) &&
-	test_cmp public/file clone/file
-'
-
-test_expect_success 'pushing to local repo' '
-	(cd localclone &&
-	echo content >>file &&
-	git commit -a -m three &&
-	git push) &&
-	compare_refs localclone HEAD server HEAD
-'
-
-# Generally, skip this test.  It demonstrates a now-fixed race in
-# git-remote-testgit, but is too slow to leave in for general use.
-: test_expect_success 'racily pushing to local repo' '
-	test_when_finished "rm -rf server2 localclone2" &&
-	cp -R server server2 &&
-	git clone "testgit::${PWD}/server2" localclone2 &&
-	(cd localclone2 &&
-	echo content >>file &&
-	git commit -a -m three &&
-	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
-	compare_refs localclone2 HEAD server2 HEAD
-'
-
-test_expect_success 'synch with changes from localclone' '
-	(cd clone &&
-	 git pull)
-'
-
-test_expect_success 'pushing remote local repo' '
-	(cd clone &&
-	echo content >>file &&
-	git commit -a -m four &&
-	git push) &&
-	compare_refs clone HEAD server HEAD
-'
-
-test_expect_success 'fetch new branch' '
-	(cd public &&
-	 git checkout -b new &&
-	 echo content >>file &&
-	 git commit -a -m five &&
-	 git push origin new
-	) &&
-	(cd localclone &&
-	 git fetch origin new
-	) &&
-	compare_refs public HEAD localclone FETCH_HEAD
-'
-
-test_expect_success 'fetch multiple branches' '
-	(cd localclone &&
-	 git fetch
-	) &&
-	compare_refs server master localclone refs/remotes/origin/master &&
-	compare_refs server new localclone refs/remotes/origin/new
-'
-
-test_expect_success 'push when remote has extra refs' '
-	(cd clone &&
-	 echo content >>file &&
-	 git commit -a -m six &&
-	 git push
-	) &&
-	compare_refs clone master server master
-'
-
-test_expect_success 'push new branch by name' '
-	(cd clone &&
-	 git checkout -b new-name  &&
-	 echo content >>file &&
-	 git commit -a -m seven &&
-	 git push origin new-name
-	) &&
-	compare_refs clone HEAD server refs/heads/new-name
-'
-
-test_expect_failure 'push new branch with old:new refspec' '
-	(cd clone &&
-	 git push origin new-name:new-refspec
-	) &&
-	compare_refs clone HEAD server refs/heads/new-refspec
-'
-
-test_done
diff --git a/t/t5800-remote-testpy.sh b/t/t5800-remote-testpy.sh
new file mode 100755
index 0000000..6750961
--- /dev/null
+++ b/t/t5800-remote-testpy.sh
@@ -0,0 +1,148 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Sverre Rabbelier
+#
+
+test_description='Test python remote-helper framework'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON ; then
+	skip_all='skipping python remote-helper tests, python not available'
+	test_done
+fi
+
+"$PYTHON_PATH" -c '
+import sys
+if sys.hexversion < 0x02040000:
+    sys.exit(1)
+' || {
+	skip_all='skipping python remote-helper tests, python version < 2.4'
+	test_done
+}
+
+compare_refs() {
+	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
+	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup repository' '
+	git init --bare server/.git &&
+	git clone server public &&
+	(cd public &&
+	 echo content >file &&
+	 git add file &&
+	 git commit -m one &&
+	 git push origin master)
+'
+
+test_expect_success 'cloning from local repo' '
+	git clone "testpy::${PWD}/server" localclone &&
+	test_cmp public/file localclone/file
+'
+
+test_expect_success 'cloning from remote repo' '
+	git clone "testpy::file://${PWD}/server" clone &&
+	test_cmp public/file clone/file
+'
+
+test_expect_success 'create new commit on remote' '
+	(cd public &&
+	 echo content >>file &&
+	 git commit -a -m two &&
+	 git push)
+'
+
+test_expect_success 'pulling from local repo' '
+	(cd localclone && git pull) &&
+	test_cmp public/file localclone/file
+'
+
+test_expect_success 'pulling from remote remote' '
+	(cd clone && git pull) &&
+	test_cmp public/file clone/file
+'
+
+test_expect_success 'pushing to local repo' '
+	(cd localclone &&
+	echo content >>file &&
+	git commit -a -m three &&
+	git push) &&
+	compare_refs localclone HEAD server HEAD
+'
+
+# Generally, skip this test.  It demonstrates a now-fixed race in
+# git-remote-testpy, but is too slow to leave in for general use.
+: test_expect_success 'racily pushing to local repo' '
+	test_when_finished "rm -rf server2 localclone2" &&
+	cp -R server server2 &&
+	git clone "testpy::${PWD}/server2" localclone2 &&
+	(cd localclone2 &&
+	echo content >>file &&
+	git commit -a -m three &&
+	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
+	compare_refs localclone2 HEAD server2 HEAD
+'
+
+test_expect_success 'synch with changes from localclone' '
+	(cd clone &&
+	 git pull)
+'
+
+test_expect_success 'pushing remote local repo' '
+	(cd clone &&
+	echo content >>file &&
+	git commit -a -m four &&
+	git push) &&
+	compare_refs clone HEAD server HEAD
+'
+
+test_expect_success 'fetch new branch' '
+	(cd public &&
+	 git checkout -b new &&
+	 echo content >>file &&
+	 git commit -a -m five &&
+	 git push origin new
+	) &&
+	(cd localclone &&
+	 git fetch origin new
+	) &&
+	compare_refs public HEAD localclone FETCH_HEAD
+'
+
+test_expect_success 'fetch multiple branches' '
+	(cd localclone &&
+	 git fetch
+	) &&
+	compare_refs server master localclone refs/remotes/origin/master &&
+	compare_refs server new localclone refs/remotes/origin/new
+'
+
+test_expect_success 'push when remote has extra refs' '
+	(cd clone &&
+	 echo content >>file &&
+	 git commit -a -m six &&
+	 git push
+	) &&
+	compare_refs clone master server master
+'
+
+test_expect_success 'push new branch by name' '
+	(cd clone &&
+	 git checkout -b new-name  &&
+	 echo content >>file &&
+	 git commit -a -m seven &&
+	 git push origin new-name
+	) &&
+	compare_refs clone HEAD server refs/heads/new-name
+'
+
+test_expect_failure 'push new branch with old:new refspec' '
+	(cd clone &&
+	 git push origin new-name:new-refspec
+	) &&
+	compare_refs clone HEAD server refs/heads/new-refspec
+'
+
+test_done
-- 
1.8.0
