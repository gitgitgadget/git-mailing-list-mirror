From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 12/12] Add Python support library for remote helpers
Date: Wed, 18 Nov 2009 02:42:32 +0100
Message-ID: <1258508552-20752-13-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-5-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-6-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-7-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-8-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-9-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-10-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-11-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-12-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Johan Herland <johan@herland.net>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:44:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZas-0000vW-PB
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756853AbZKRBnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbZKRBnr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:47 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:40644 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838AbZKRBnl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:41 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so682791fxm.21
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Kjv9hvfi9A59I46L17movEMRZXU1v2tEER6b02Dx+UY=;
        b=IjspEVzFpunWdKXgSTVis9wE1/lHH+9AiNk49PQ5NF3lEOQt/fGpKhlUTVlw/wIA++
         oiteDlRTgsCtAXjRJTz7+WF+o3T4eVtjuZdFo7clyzNbOZYaFO2JkHzz4zCDhGW+8uts
         rN5zMutBQ5CmVGlrNzxZc2KQdQZ7bP60u08/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AaneCpZKYagWcey1+iW/9yE6imp/lIsMq0V6k12+NhOYwCmTbGey4PxoryJDfiuYt9
         k53k/2KxVQqunsLYIsU1cX89FXpnDVwCQNYutkNBvMGWPgnQMjWAec6vkf4zpp1CmmKV
         hQlx0Adel6rAeYysZP0ioML7G4L8GXR3SYc8Y=
Received: by 10.216.89.206 with SMTP id c56mr1287047wef.123.1258508626122;
        Tue, 17 Nov 2009 17:43:46 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:45 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-12-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133132>

This patch introduces parts of a Python package called
"git_remote_helpers" containing the building blocks for
remote helpers written in Python.

No actual remote helpers are part of this patch, this patch only
includes the common basics needed to start writing such helpers.

The patch includes the necessary Makefile additions to build and
install the git_remote_helpers Python package along with the rest of
Git.

This patch is based on Johan Herland's git_remote_cvs patch and
has been improved by the following contributions:
- David Aguilar: Lots of Python coding style fixes
- David Aguilar: DESTDIR support in Makefile

Cc: David Aguilar <davvid@gmail.com>
Cc: Johan Herland <johan@herland.net>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Unchanged.

 Makefile                           |   38 ++
 git_remote_helpers/.gitignore      |    2 +
 git_remote_helpers/Makefile        |   35 ++
 git_remote_helpers/__init__.py     |   16 +
 git_remote_helpers/git/git.py      |  678 ++++++++++++++++++++++++++++++++++++
 git_remote_helpers/setup.py        |   17 +
 git_remote_helpers/util.py         |  194 ++++++++++
 t/test-lib.sh                      |    9 +
 8 files changed, 989 insertions(+), 0 deletions(-)
 create mode 100644 git_remote_helpers/.gitignore
 create mode 100644 git_remote_helpers/Makefile
 create mode 100644 git_remote_helpers/__init__.py
 create mode 100644 git_remote_helpers/git/__init__.py
 create mode 100644 git_remote_helpers/git/git.py
 create mode 100644 git_remote_helpers/setup.py
 create mode 100644 git_remote_helpers/util.py

diff --git a/Makefile b/Makefile
index ed027df..9c8fa67 100644
--- a/Makefile
+++ b/Makefile
@@ -1406,6 +1406,9 @@ endif
 ifndef NO_PERL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 endif
+ifndef NO_PYTHON
+	$(QUIET_SUBDIR0)git_remote_helpers $(QUIET_SUBDIR1) PYTHON_PATH='$(PYTHON_PATH_SQ)' prefix='$(prefix_SQ)' all
+endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
 
 please_set_SHELL_PATH_to_a_more_modern_shell:
@@ -1524,6 +1527,35 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 	mv $@+ $@
 endif # NO_PERL
 
+ifndef NO_PYTHON
+$(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS
+$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
+		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
+		instlibdir` && \
+	sed -e '1{' \
+	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	    -e '}' \
+	    -e 's|^import sys.*|&; \\\
+	           import os; \\\
+	           sys.path[0] = os.environ.has_key("GITPYTHONLIB") and \\\
+	                         os.environ["GITPYTHONLIB"] or \\\
+	                         "@@INSTLIBDIR@@"|' \
+	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
+	    $@.py >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+else # NO_PYTHON
+$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
+	$(QUIET_GEN)$(RM) $@ $@+ && \
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
+	    unimplemented.sh >$@+ && \
+	chmod +x $@+ && \
+	mv $@+ $@
+endif # NO_PYTHON
+
 configure: configure.ac
 	$(QUIET_GEN)$(RM) $@ $<+ && \
 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -1748,6 +1780,9 @@ install: all
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 endif
+ifndef NO_PYTHON
+	$(MAKE) -C git_remote_helpers prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
+endif
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
 	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
@@ -1865,6 +1900,9 @@ ifndef NO_PERL
 	$(RM) gitweb/gitweb.cgi
 	$(MAKE) -C perl clean
 endif
+ifndef NO_PYTHON
+	$(MAKE) -C git_remote_helpers clean
+endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 ifndef NO_TCLTK
diff --git a/git_remote_helpers/.gitignore b/git_remote_helpers/.gitignore
new file mode 100644
index 0000000..2247d5f
--- /dev/null
+++ b/git_remote_helpers/.gitignore
@@ -0,0 +1,2 @@
+/build
+/dist
diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
new file mode 100644
index 0000000..c62dfd0
--- /dev/null
+++ b/git_remote_helpers/Makefile
@@ -0,0 +1,35 @@
+#
+# Makefile for the git_remote_helpers python support modules
+#
+pysetupfile:=setup.py
+
+# Shell quote (do not use $(call) to accommodate ancient setups);
+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+
+ifndef PYTHON_PATH
+	PYTHON_PATH = /usr/bin/python
+endif
+ifndef prefix
+	prefix = $(HOME)
+endif
+ifndef V
+	QUIET = @
+	QUIETSETUP = --quiet
+endif
+
+PYLIBDIR=$(shell $(PYTHON_PATH) -c \
+	 "import sys; \
+	 print 'lib/python%i.%i/site-packages' % sys.version_info[:2]")
+
+all: $(pysetupfile)
+	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
+
+install: $(pysetupfile)
+	$(PYTHON_PATH) $(pysetupfile) install --prefix $(DESTDIR_SQ)$(prefix)
+
+instlibdir: $(pysetupfile)
+	@echo "$(DESTDIR_SQ)$(prefix)/$(PYLIBDIR)"
+
+clean:
+	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
+	$(RM) *.pyo *.pyc
diff --git a/git_remote_helpers/__init__.py b/git_remote_helpers/__init__.py
new file mode 100644
index 0000000..00f69cb
--- /dev/null
+++ b/git_remote_helpers/__init__.py
@@ -0,0 +1,16 @@
+#!/usr/bin/env python
+
+"""Support library package for git remote helpers.
+
+Git remote helpers are helper commands that interfaces with a non-git
+repository to provide automatic import of non-git history into a Git
+repository.
+
+This package provides the support library needed by these helpers..
+The following modules are included:
+
+- git.git - Interaction with Git repositories
+
+- util - General utility functionality use by the other modules in
+         this package, and also used directly by the helpers.
+"""
diff --git a/git_remote_helpers/git/__init__.py b/git_remote_helpers/git/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/git_remote_helpers/git/git.py b/git_remote_helpers/git/git.py
new file mode 100644
index 0000000..a383e6c
--- /dev/null
+++ b/git_remote_helpers/git/git.py
@@ -0,0 +1,678 @@
+#!/usr/bin/env python
+
+"""Functionality for interacting with Git repositories.
+
+This module provides classes for interfacing with a Git repository.
+"""
+
+import os
+import re
+import time
+from binascii import hexlify
+from cStringIO import StringIO
+import unittest
+
+from git_remote_helpers.util import debug, error, die, start_command, run_command
+
+
+def get_git_dir ():
+    """Return the path to the GIT_DIR for this repo."""
+    args = ("git", "rev-parse", "--git-dir")
+    exit_code, output, errors = run_command(args)
+    if exit_code:
+        die("Failed to retrieve git dir")
+    assert not errors
+    return output.strip()
+
+
+def parse_git_config ():
+    """Return a dict containing the parsed version of 'git config -l'."""
+    exit_code, output, errors = run_command(("git", "config", "-z", "-l"))
+    if exit_code:
+        die("Failed to retrieve git configuration")
+    assert not errors
+    return dict([e.split('\n', 1) for e in output.split("\0") if e])
+
+
+def git_config_bool (value):
+    """Convert the given git config string value to True or False.
+
+    Raise ValueError if the given string was not recognized as a
+    boolean value.
+
+    """
+    norm_value = str(value).strip().lower()
+    if norm_value in ("true", "1", "yes", "on", ""):
+        return True
+    if norm_value in ("false", "0", "no", "off", "none"):
+        return False
+    raise ValueError("Failed to parse '%s' into a boolean value" % (value))
+
+
+def valid_git_ref (ref_name):
+    """Return True iff the given ref name is a valid git ref name."""
+    # The following is a reimplementation of the git check-ref-format
+    # command.  The rules were derived from the git check-ref-format(1)
+    # manual page.  This code should be replaced by a call to
+    # check_ref_format() in the git library, when such is available.
+    if ref_name.endswith('/') or \
+       ref_name.startswith('.') or \
+       ref_name.count('/.') or \
+       ref_name.count('..') or \
+       ref_name.endswith('.lock'):
+        return False
+    for c in ref_name:
+        if ord(c) < 0x20 or ord(c) == 0x7f or c in " ~^:?*[":
+            return False
+    return True
+
+
+class GitObjectFetcher(object):
+
+    """Provide parsed access to 'git cat-file --batch'.
+
+    This provides a read-only interface to the Git object database.
+
+    """
+
+    def __init__ (self):
+        """Initiate a 'git cat-file --batch' session."""
+        self.queue = []  # List of object names to be submitted
+        self.in_transit = None  # Object name currently in transit
+
+        # 'git cat-file --batch' produces binary output which is likely
+        # to be corrupted by the default "rU"-mode pipe opened by
+        # start_command.  (Mode == "rU" does universal new-line
+        # conversion, which mangles carriage returns.) Therefore, we
+        # open an explicitly binary-safe pipe for transferring the
+        # output from 'git cat-file --batch'.
+        pipe_r_fd, pipe_w_fd = os.pipe()
+        pipe_r = os.fdopen(pipe_r_fd, "rb")
+        pipe_w = os.fdopen(pipe_w_fd, "wb")
+        self.proc = start_command(("git", "cat-file", "--batch"),
+                                  stdout = pipe_w)
+        self.f = pipe_r
+
+    def __del__ (self):
+        """Verify completed communication with 'git cat-file --batch'."""
+        assert not self.queue
+        assert self.in_transit is None
+        self.proc.stdin.close()
+        assert self.proc.wait() == 0  # Zero exit code
+        assert self.f.read() == ""  # No remaining output
+
+    def _submit_next_object (self):
+        """Submit queue items to the 'git cat-file --batch' process.
+
+        If there are items in the queue, and there is currently no item
+        currently in 'transit', then pop the first item off the queue,
+        and submit it.
+
+        """
+        if self.queue and self.in_transit is None:
+            self.in_transit = self.queue.pop(0)
+            print >> self.proc.stdin, self.in_transit[0]
+
+    def push (self, obj, callback):
+        """Push the given object name onto the queue.
+
+        The given callback function will at some point in the future
+        be called exactly once with the following arguments:
+        - self - this GitObjectFetcher instance
+        - obj  - the object name provided to push()
+        - sha1 - the SHA1 of the object, if 'None' obj is missing
+        - t    - the type of the object (tag/commit/tree/blob)
+        - size - the size of the object in bytes
+        - data - the object contents
+
+        """
+        self.queue.append((obj, callback))
+        self._submit_next_object()  # (Re)start queue processing
+
+    def process_next_entry (self):
+        """Read the next entry off the queue and invoke callback."""
+        obj, cb = self.in_transit
+        self.in_transit = None
+        header = self.f.readline()
+        if header == "%s missing\n" % (obj):
+            cb(self, obj, None, None, None, None)
+            return
+        sha1, t, size = header.split(" ")
+        assert len(sha1) == 40
+        assert t in ("tag", "commit", "tree", "blob")
+        assert size.endswith("\n")
+        size = int(size.strip())
+        data = self.f.read(size)
+        assert self.f.read(1) == "\n"
+        cb(self, obj, sha1, t, size, data)
+        self._submit_next_object()
+
+    def process (self):
+        """Process the current queue until empty."""
+        while self.in_transit is not None:
+            self.process_next_entry()
+
+    # High-level convenience methods:
+
+    def get_sha1 (self, objspec):
+        """Return the SHA1 of the object specified by 'objspec'.
+
+        Return None if 'objspec' does not specify an existing object.
+
+        """
+        class _ObjHandler(object):
+            """Helper class for getting the returned SHA1."""
+            def __init__ (self, parser):
+                self.parser = parser
+                self.sha1 = None
+
+            def __call__ (self, parser, obj, sha1, t, size, data):
+                # FIXME: Many unused arguments. Could this be cheaper?
+                assert parser == self.parser
+                self.sha1 = sha1
+
+        handler = _ObjHandler(self)
+        self.push(objspec, handler)
+        self.process()
+        return handler.sha1
+
+    def open_obj (self, objspec):
+        """Return a file object wrapping the contents of a named object.
+
+        The caller is responsible for calling .close() on the returned
+        file object.
+
+        Raise KeyError if 'objspec' does not exist in the repo.
+
+        """
+        class _ObjHandler(object):
+            """Helper class for parsing the returned git object."""
+            def __init__ (self, parser):
+                """Set up helper."""
+                self.parser = parser
+                self.contents = StringIO()
+                self.err = None
+
+            def __call__ (self, parser, obj, sha1, t, size, data):
+                """Git object callback (see GitObjectFetcher documentation)."""
+                assert parser == self.parser
+                if not sha1:  # Missing object
+                    self.err = "Missing object '%s'" % obj
+                else:
+                    assert size == len(data)
+                    self.contents.write(data)
+
+        handler = _ObjHandler(self)
+        self.push(objspec, handler)
+        self.process()
+        if handler.err:
+            raise KeyError(handler.err)
+        handler.contents.seek(0)
+        return handler.contents
+
+    def walk_tree (self, tree_objspec, callback, prefix = ""):
+        """Recursively walk the given Git tree object.
+
+        Recursively walk all subtrees of the given tree object, and
+        invoke the given callback passing three arguments:
+        (path, mode, data) with the path, permission bits, and contents
+        of all the blobs found in the entire tree structure.
+
+        """
+        class _ObjHandler(object):
+            """Helper class for walking a git tree structure."""
+            def __init__ (self, parser, cb, path, mode = None):
+                """Set up helper."""
+                self.parser = parser
+                self.cb = cb
+                self.path = path
+                self.mode = mode
+                self.err = None
+
+            def parse_tree (self, treedata):
+                """Parse tree object data, yield tree entries.
+
+                Each tree entry is a 3-tuple (mode, sha1, path)
+
+                self.path is prepended to all paths yielded
+                from this method.
+
+                """
+                while treedata:
+                    mode = int(treedata[:6], 10)
+                    # Turn 100xxx into xxx
+                    if mode > 100000:
+                        mode -= 100000
+                    assert treedata[6] == " "
+                    i = treedata.find("\0", 7)
+                    assert i > 0
+                    path = treedata[7:i]
+                    sha1 = hexlify(treedata[i + 1: i + 21])
+                    yield (mode, sha1, self.path + path)
+                    treedata = treedata[i + 21:]
+
+            def __call__ (self, parser, obj, sha1, t, size, data):
+                """Git object callback (see GitObjectFetcher documentation)."""
+                assert parser == self.parser
+                if not sha1:  # Missing object
+                    self.err = "Missing object '%s'" % (obj)
+                    return
+                assert size == len(data)
+                if t == "tree":
+                    if self.path:
+                        self.path += "/"
+                    # Recurse into all blobs and subtrees
+                    for m, s, p in self.parse_tree(data):
+                        parser.push(s,
+                                    self.__class__(self.parser, self.cb, p, m))
+                elif t == "blob":
+                    self.cb(self.path, self.mode, data)
+                else:
+                    raise ValueError("Unknown object type '%s'" % (t))
+
+        self.push(tree_objspec, _ObjHandler(self, callback, prefix))
+        self.process()
+
+
+class GitRefMap(object):
+
+    """Map Git ref names to the Git object names they currently point to.
+
+    Behaves like a dictionary of Git ref names -> Git object names.
+
+    """
+
+    def __init__ (self, obj_fetcher):
+        """Create a new Git ref -> object map."""
+        self.obj_fetcher = obj_fetcher
+        self._cache = {}  # dict: refname -> objname
+
+    def _load (self, ref):
+        """Retrieve the object currently bound to the given ref.
+
+        The name of the object pointed to by the given ref is stored
+        into this mapping, and also returned.
+
+        """
+        if ref not in self._cache:
+            self._cache[ref] = self.obj_fetcher.get_sha1(ref)
+        return self._cache[ref]
+
+    def __contains__ (self, refname):
+        """Return True if the given refname is present in this cache."""
+        return bool(self._load(refname))
+
+    def __getitem__ (self, refname):
+        """Return the git object name pointed to by the given refname."""
+        commit = self._load(refname)
+        if commit is None:
+            raise KeyError("Unknown ref '%s'" % (refname))
+        return commit
+
+    def get (self, refname, default = None):
+        """Return the git object name pointed to by the given refname."""
+        commit = self._load(refname)
+        if commit is None:
+            return default
+        return commit
+
+
+class GitFICommit(object):
+
+    """Encapsulate the data in a Git fast-import commit command."""
+
+    SHA1RE = re.compile(r'^[0-9a-f]{40}$')
+
+    @classmethod
+    def parse_mode (cls, mode):
+        """Verify the given git file mode, and return it as a string."""
+        assert mode in (644, 755, 100644, 100755, 120000)
+        return "%i" % (mode)
+
+    @classmethod
+    def parse_objname (cls, objname):
+        """Return the given object name (or mark number) as a string."""
+        if isinstance(objname, int):  # Object name is a mark number
+            assert objname > 0
+            return ":%i" % (objname)
+
+        # No existence check is done, only checks for valid format
+        assert cls.SHA1RE.match(objname)  # Object name is valid SHA1
+        return objname
+
+    @classmethod
+    def quote_path (cls, path):
+        """Return a quoted version of the given path."""
+        path = path.replace("\\", "\\\\")
+        path = path.replace("\n", "\\n")
+        path = path.replace('"', '\\"')
+        return '"%s"' % (path)
+
+    @classmethod
+    def parse_path (cls, path):
+        """Verify that the given path is valid, and quote it, if needed."""
+        assert not isinstance(path, int)  # Cannot be a mark number
+
+        # These checks verify the rules on the fast-import man page
+        assert not path.count("//")
+        assert not path.endswith("/")
+        assert not path.startswith("/")
+        assert not path.count("/./")
+        assert not path.count("/../")
+        assert not path.endswith("/.")
+        assert not path.endswith("/..")
+        assert not path.startswith("./")
+        assert not path.startswith("../")
+
+        if path.count('"') + path.count('\n') + path.count('\\'):
+            return cls.quote_path(path)
+        return path
+
+    def __init__ (self, name, email, timestamp, timezone, message):
+        """Create a new Git fast-import commit, with the given metadata."""
+        self.name = name
+        self.email = email
+        self.timestamp = timestamp
+        self.timezone = timezone
+        self.message = message
+        self.pathops = []  # List of path operations in this commit
+
+    def modify (self, mode, blobname, path):
+        """Add a file modification to this Git fast-import commit."""
+        self.pathops.append(("M",
+                             self.parse_mode(mode),
+                             self.parse_objname(blobname),
+                             self.parse_path(path)))
+
+    def delete (self, path):
+        """Add a file deletion to this Git fast-import commit."""
+        self.pathops.append(("D", self.parse_path(path)))
+
+    def copy (self, path, newpath):
+        """Add a file copy to this Git fast-import commit."""
+        self.pathops.append(("C",
+                             self.parse_path(path),
+                             self.parse_path(newpath)))
+
+    def rename (self, path, newpath):
+        """Add a file rename to this Git fast-import commit."""
+        self.pathops.append(("R",
+                             self.parse_path(path),
+                             self.parse_path(newpath)))
+
+    def note (self, blobname, commit):
+        """Add a note object to this Git fast-import commit."""
+        self.pathops.append(("N",
+                             self.parse_objname(blobname),
+                             self.parse_objname(commit)))
+
+    def deleteall (self):
+        """Delete all files in this Git fast-import commit."""
+        self.pathops.append("deleteall")
+
+
+class TestGitFICommit(unittest.TestCase):
+
+    """GitFICommit selftests."""
+
+    def test_basic (self):
+        """GitFICommit basic selftests."""
+
+        def expect_fail (method, data):
+            """Verify that the method(data) raises an AssertionError."""
+            try:
+                method(data)
+            except AssertionError:
+                return
+            raise AssertionError("Failed test for invalid data '%s(%s)'" %
+                                 (method.__name__, repr(data)))
+
+    def test_parse_mode (self):
+        """GitFICommit.parse_mode() selftests."""
+        self.assertEqual(GitFICommit.parse_mode(644), "644")
+        self.assertEqual(GitFICommit.parse_mode(755), "755")
+        self.assertEqual(GitFICommit.parse_mode(100644), "100644")
+        self.assertEqual(GitFICommit.parse_mode(100755), "100755")
+        self.assertEqual(GitFICommit.parse_mode(120000), "120000")
+        self.assertRaises(AssertionError, GitFICommit.parse_mode, 0)
+        self.assertRaises(AssertionError, GitFICommit.parse_mode, 123)
+        self.assertRaises(AssertionError, GitFICommit.parse_mode, 600)
+        self.assertRaises(AssertionError, GitFICommit.parse_mode, "644")
+        self.assertRaises(AssertionError, GitFICommit.parse_mode, "abc")
+
+    def test_parse_objname (self):
+        """GitFICommit.parse_objname() selftests."""
+        self.assertEqual(GitFICommit.parse_objname(1), ":1")
+        self.assertRaises(AssertionError, GitFICommit.parse_objname, 0)
+        self.assertRaises(AssertionError, GitFICommit.parse_objname, -1)
+        self.assertEqual(GitFICommit.parse_objname("0123456789" * 4),
+                         "0123456789" * 4)
+        self.assertEqual(GitFICommit.parse_objname("2468abcdef" * 4),
+                         "2468abcdef" * 4)
+        self.assertRaises(AssertionError, GitFICommit.parse_objname,
+                          "abcdefghij" * 4)
+
+    def test_parse_path (self):
+        """GitFICommit.parse_path() selftests."""
+        self.assertEqual(GitFICommit.parse_path("foo/bar"), "foo/bar")
+        self.assertEqual(GitFICommit.parse_path("path/with\n and \" in it"),
+                         '"path/with\\n and \\" in it"')
+        self.assertRaises(AssertionError, GitFICommit.parse_path, 1)
+        self.assertRaises(AssertionError, GitFICommit.parse_path, 0)
+        self.assertRaises(AssertionError, GitFICommit.parse_path, -1)
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo//bar")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/bar/")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "/foo/bar")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/./bar")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/../bar")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/bar/.")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/bar/..")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "./foo/bar")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "../foo/bar")
+
+
+class GitFastImport(object):
+
+    """Encapsulate communication with git fast-import."""
+
+    def __init__ (self, f, obj_fetcher, last_mark = 0):
+        """Set up self to communicate with a fast-import process through f."""
+        self.f = f  # File object where fast-import stream is written
+        self.obj_fetcher = obj_fetcher  # GitObjectFetcher instance
+        self.next_mark = last_mark + 1  # Next mark number
+        self.refs = set()  # Keep track of the refnames we've seen
+
+    def comment (self, s):
+        """Write the given comment in the fast-import stream."""
+        assert "\n" not in s, "Malformed comment: '%s'" % (s)
+        self.f.write("# %s\n" % (s))
+
+    def commit (self, ref, commitdata):
+        """Make a commit on the given ref, with the given GitFICommit.
+
+        Return the mark number identifying this commit.
+
+        """
+        self.f.write("""\
+commit %(ref)s
+mark :%(mark)i
+committer %(name)s <%(email)s> %(timestamp)i %(timezone)s
+data %(msgLength)i
+%(msg)s
+""" % {
+    'ref': ref,
+    'mark': self.next_mark,
+    'name': commitdata.name,
+    'email': commitdata.email,
+    'timestamp': commitdata.timestamp,
+    'timezone': commitdata.timezone,
+    'msgLength': len(commitdata.message),
+    'msg': commitdata.message,
+})
+
+        if ref not in self.refs:
+            self.refs.add(ref)
+            parent = ref + "^0"
+            if self.obj_fetcher.get_sha1(parent):
+                self.f.write("from %s\n" % (parent))
+
+        for op in commitdata.pathops:
+            self.f.write(" ".join(op))
+            self.f.write("\n")
+        self.f.write("\n")
+        retval = self.next_mark
+        self.next_mark += 1
+        return retval
+
+    def blob (self, data):
+        """Import the given blob.
+
+        Return the mark number identifying this blob.
+
+        """
+        self.f.write("blob\nmark :%i\ndata %i\n%s\n" %
+                     (self.next_mark, len(data), data))
+        retval = self.next_mark
+        self.next_mark += 1
+        return retval
+
+    def reset (self, ref, objname):
+        """Reset the given ref to point at the given Git object."""
+        self.f.write("reset %s\nfrom %s\n\n" %
+                     (ref, GitFICommit.parse_objname(objname)))
+        if ref not in self.refs:
+            self.refs.add(ref)
+
+
+class GitNotes(object):
+
+    """Encapsulate access to Git notes.
+
+    Simulates a dictionary of object name (SHA1) -> Git note mappings.
+
+    """
+
+    def __init__ (self, notes_ref, obj_fetcher):
+        """Create a new Git notes interface, bound to the given notes ref."""
+        self.notes_ref = notes_ref
+        self.obj_fetcher = obj_fetcher  # Used to get objects from repo
+        self.imports = []  # list: (objname, note data blob name) tuples
+
+    def __del__ (self):
+        """Verify that self.commit_notes() was called before destruction."""
+        if self.imports:
+            error("Missing call to self.commit_notes().")
+            error("%i notes are not committed!", len(self.imports))
+
+    def _load (self, objname):
+        """Return the note data associated with the given git object.
+
+        The note data is returned in string form. If no note is found
+        for the given object, None is returned.
+
+        """
+        try:
+            f = self.obj_fetcher.open_obj("%s:%s" % (self.notes_ref, objname))
+            ret = f.read()
+            f.close()
+        except KeyError:
+            ret = None
+        return ret
+
+    def __getitem__ (self, objname):
+        """Return the note contents associated with the given object.
+
+        Raise KeyError if given object has no associated note.
+
+        """
+        blobdata = self._load(objname)
+        if blobdata is None:
+            raise KeyError("Object '%s' has no note" % (objname))
+        return blobdata
+
+    def get (self, objname, default = None):
+        """Return the note contents associated with the given object.
+
+        Return given default if given object has no associated note.
+
+        """
+        blobdata = self._load(objname)
+        if blobdata is None:
+            return default
+        return blobdata
+
+    def import_note (self, objname, data, gfi):
+        """Tell git fast-import to store data as a note for objname.
+
+        This method uses the given GitFastImport object to create a
+        blob containing the given note data.  Also an entry mapping the
+        given object name to the created blob is stored until
+        commit_notes() is called.
+
+        Note that this method only works if it is later followed by a
+        call to self.commit_notes() (which produces the note commit
+        that refers to the blob produced here).
+
+        """
+        if not data.endswith("\n"):
+            data += "\n"
+        gfi.comment("Importing note for object %s" % (objname))
+        mark = gfi.blob(data)
+        self.imports.append((objname, mark))
+
+    def commit_notes (self, gfi, author, message):
+        """Produce a git fast-import note commit for the imported notes.
+
+        This method uses the given GitFastImport object to create a
+        commit on the notes ref, introducing the notes previously
+        submitted to import_note().
+
+        """
+        if not self.imports:
+            return
+        commitdata = GitFICommit(author[0], author[1],
+                                 time.time(), "0000", message)
+        for objname, blobname in self.imports:
+            assert isinstance(objname, int) and objname > 0
+            assert isinstance(blobname, int) and blobname > 0
+            commitdata.note(blobname, objname)
+        gfi.commit(self.notes_ref, commitdata)
+        self.imports = []
+
+
+class GitCachedNotes(GitNotes):
+
+    """Encapsulate access to Git notes (cached version).
+
+    Only use this class if no caching is done at a higher level.
+
+    Simulates a dictionary of object name (SHA1) -> Git note mappings.
+
+    """
+
+    def __init__ (self, notes_ref, obj_fetcher):
+        """Set up a caching wrapper around GitNotes."""
+        GitNotes.__init__(self, notes_ref, obj_fetcher)
+        self._cache = {}  # Cache: object name -> note data
+
+    def __del__ (self):
+        """Verify that GitNotes' destructor is called."""
+        GitNotes.__del__(self)
+
+    def _load (self, objname):
+        """Extend GitNotes._load() with a local objname -> note cache."""
+        if objname not in self._cache:
+            self._cache[objname] = GitNotes._load(self, objname)
+        return self._cache[objname]
+
+    def import_note (self, objname, data, gfi):
+        """Extend GitNotes.import_note() with a local objname -> note cache."""
+        if not data.endswith("\n"):
+            data += "\n"
+        assert objname not in self._cache
+        self._cache[objname] = data
+        GitNotes.import_note(self, objname, data, gfi)
+
+
+if __name__ == '__main__':
+    unittest.main()
diff --git a/git_remote_helpers/setup.py b/git_remote_helpers/setup.py
new file mode 100644
index 0000000..4d434b6
--- /dev/null
+++ b/git_remote_helpers/setup.py
@@ -0,0 +1,17 @@
+#!/usr/bin/env python
+
+"""Distutils build/install script for the git_remote_helpers package."""
+
+from distutils.core import setup
+
+setup(
+    name = 'git_remote_helpers',
+    version = '0.1.0',
+    description = 'Git remote helper program for non-git repositories',
+    license = 'GPLv2',
+    author = 'The Git Community',
+    author_email = 'git@vger.kernel.org',
+    url = 'http://www.git-scm.com/',
+    package_dir = {'git_remote_helpers': ''},
+    packages = ['git_remote_helpers', 'git_remote_helpers.git'],
+)
diff --git a/git_remote_helpers/util.py b/git_remote_helpers/util.py
new file mode 100644
index 0000000..dce83e6
--- /dev/null
+++ b/git_remote_helpers/util.py
@@ -0,0 +1,194 @@
+#!/usr/bin/env python
+
+"""Misc. useful functionality used by the rest of this package.
+
+This module provides common functionality used by the other modules in
+this package.
+
+"""
+
+import sys
+import os
+import subprocess
+
+
+# Whether or not to show debug messages
+DEBUG = False
+
+def notify(msg, *args):
+    """Print a message to stderr."""
+    print >> sys.stderr, msg % args
+
+def debug (msg, *args):
+    """Print a debug message to stderr when DEBUG is enabled."""
+    if DEBUG:
+        print >> sys.stderr, msg % args
+
+def error (msg, *args):
+    """Print an error message to stderr."""
+    print >> sys.stderr, "ERROR:", msg % args
+
+def warn(msg, *args):
+    """Print a warning message to stderr."""
+    print >> sys.stderr, "warning:", msg % args
+
+def die (msg, *args):
+    """Print as error message to stderr and exit the program."""
+    error(msg, *args)
+    sys.exit(1)
+
+
+class ProgressIndicator(object):
+
+    """Simple progress indicator.
+
+    Displayed as a spinning character by default, but can be customized
+    by passing custom messages that overrides the spinning character.
+
+    """
+
+    States = ("|", "/", "-", "\\")
+
+    def __init__ (self, prefix = "", f = sys.stdout):
+        """Create a new ProgressIndicator, bound to the given file object."""
+        self.n = 0  # Simple progress counter
+        self.f = f  # Progress is written to this file object
+        self.prev_len = 0  # Length of previous msg (to be overwritten)
+        self.prefix = prefix  # Prefix prepended to each progress message
+        self.prefix_lens = [] # Stack of prefix string lengths
+
+    def pushprefix (self, prefix):
+        """Append the given prefix onto the prefix stack."""
+        self.prefix_lens.append(len(self.prefix))
+        self.prefix += prefix
+
+    def popprefix (self):
+        """Remove the last prefix from the prefix stack."""
+        prev_len = self.prefix_lens.pop()
+        self.prefix = self.prefix[:prev_len]
+
+    def __call__ (self, msg = None, lf = False):
+        """Indicate progress, possibly with a custom message."""
+        if msg is None:
+            msg = self.States[self.n % len(self.States)]
+        msg = self.prefix + msg
+        print >> self.f, "\r%-*s" % (self.prev_len, msg),
+        self.prev_len = len(msg.expandtabs())
+        if lf:
+            print >> self.f
+            self.prev_len = 0
+        self.n += 1
+
+    def finish (self, msg = "done", noprefix = False):
+        """Finalize progress indication with the given message."""
+        if noprefix:
+            self.prefix = ""
+        self(msg, True)
+
+
+def start_command (args, cwd = None, shell = False, add_env = None,
+                   stdin = subprocess.PIPE, stdout = subprocess.PIPE,
+                   stderr = subprocess.PIPE):
+    """Start the given command, and return a subprocess object.
+
+    This provides a simpler interface to the subprocess module.
+
+    """
+    env = None
+    if add_env is not None:
+        env = os.environ.copy()
+        env.update(add_env)
+    return subprocess.Popen(args, bufsize = 1, stdin = stdin, stdout = stdout,
+                            stderr = stderr, cwd = cwd, shell = shell,
+                            env = env, universal_newlines = True)
+
+
+def run_command (args, cwd = None, shell = False, add_env = None,
+                 flag_error = True):
+    """Run the given command to completion, and return its results.
+
+    This provides a simpler interface to the subprocess module.
+
+    The results are formatted as a 3-tuple: (exit_code, output, errors)
+
+    If flag_error is enabled, Error messages will be produced if the
+    subprocess terminated with a non-zero exit code and/or stderr
+    output.
+
+    The other arguments are passed on to start_command().
+
+    """
+    process = start_command(args, cwd, shell, add_env)
+    (output, errors) = process.communicate()
+    exit_code = process.returncode
+    if flag_error and errors:
+        error("'%s' returned errors:\n---\n%s---", " ".join(args), errors)
+    if flag_error and exit_code:
+        error("'%s' returned exit code %i", " ".join(args), exit_code)
+    return (exit_code, output, errors)
+
+
+def file_reader_method (missing_ok = False):
+    """Decorator for simplifying reading of files.
+
+    If missing_ok is True, a failure to open a file for reading will
+    not raise the usual IOError, but instead the wrapped method will be
+    called with f == None.  The method must in this case properly
+    handle f == None.
+
+    """
+    def _wrap (method):
+        """Teach given method to handle both filenames and file objects.
+
+        The given method must take a file object as its second argument
+        (the first argument being 'self', of course).  This decorator
+        will take a filename given as the second argument and promote
+        it to a file object.
+
+        """
+        def _wrapped_method (self, filename, *args, **kwargs):
+            if isinstance(filename, file):
+                f = filename
+            else:
+                try:
+                    f = open(filename, 'r')
+                except IOError:
+                    if missing_ok:
+                        f = None
+                    else:
+                        raise
+            try:
+                return method(self, f, *args, **kwargs)
+            finally:
+                if not isinstance(filename, file) and f:
+                    f.close()
+        return _wrapped_method
+    return _wrap
+
+
+def file_writer_method (method):
+    """Decorator for simplifying writing of files.
+
+    Enables the given method to handle both filenames and file objects.
+
+    The given method must take a file object as its second argument
+    (the first argument being 'self', of course).  This decorator will
+    take a filename given as the second argument and promote it to a
+    file object.
+
+    """
+    def _new_method (self, filename, *args, **kwargs):
+        if isinstance(filename, file):
+            f = filename
+        else:
+            # Make sure the containing directory exists
+            parent_dir = os.path.dirname(filename)
+            if not os.path.isdir(parent_dir):
+                os.makedirs(parent_dir)
+            f = open(filename, 'w')
+        try:
+            return method(self, f, *args, **kwargs)
+        finally:
+            if not isinstance(filename, file):
+                f.close()
+    return _new_method
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0b991db..6ed5b28 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -638,6 +638,15 @@ test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
+if test -z "$GIT_TEST_INSTALLED"
+then
+	GITPYTHONLIB="$(pwd)/../git_remote_helpers/build/lib"
+	export GITPYTHONLIB
+	test -d ../git_remote_helpers/build || {
+		error "You haven't built git_remote_helpers yet, have you?"
+	}
+fi
+
 if ! test -x ../test-chmtime; then
 	echo >&2 'You need to build test-chmtime:'
 	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
-- 
1.6.5.3.164.g07b0c
