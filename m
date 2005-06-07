From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] Add missing Documentation/*
Date: Tue, 7 Jun 2005 10:17:36 -0400
Message-ID: <20050607141736.GA2157@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 07 16:15:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfeqU-0006P3-42
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 16:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVFGOSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 10:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVFGOSH
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 10:18:07 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:40583 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261874AbVFGORm
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 10:17:42 -0400
Received: by timesys.com (Postfix, from userid 623)
	id 89544B2432; Tue,  7 Jun 2005 10:17:36 -0400 (EDT)
To: torvalds@osdl.org, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Id: e774aa5641ca2267e7aba7338da3f7e355b7fb78
tree e42cf7a8ae0e05eb383ad41bc43d6e7d1245441f
parent 63aff4fed94355889be98ad44371e29942ff70e4
author Jason McMullan <jason.mcmullan@gmail.com> 1118153523 -0400
committer Jason McMullan <jason.mcmullan@gmail.com> 1118153523 -0400

Add: Additional missing documentation


======== diff against 63aff4fed94355889be98ad44371e29942ff70e4 ========
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-apply.txt
@@ -0,0 +1,36 @@
+git-apply(1)
+============
+v0.1, May 2005
+
+NAME
+----
+git-apply - Apply a patch against the current index cache/working directory
+
+
+SYNOPSIS
+--------
+'git-apply' [--check] [--stat] [--show-file] <patch>
+
+DESCRIPTION
+-----------
+This applies patches on top of some (arbitrary) version of the SCM.
+
+NOTE! It does all its work in the index file, and only cares about
+the files in the working directory if you tell it to "merge" the
+patch apply.
+
+Even when merging it always takes the source from the index, and
+uses the working tree as a "branch" for a 3-way merge.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-commit-script.txt b/Documentation/git-commit-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-commit-script.txt
@@ -0,0 +1,29 @@
+git-commit-script(1)
+====================
+v0.1, May 2005
+
+NAME
+----
+git-commit-script - Commit working directory
+
+
+SYNOPSIS
+--------
+'git-commit-script' 
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-deltafy-script.txt b/Documentation/git-deltafy-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-deltafy-script.txt
@@ -0,0 +1,51 @@
+git-deltafy-script(1)
+=====================
+v0.1, May 2005
+
+NAME
+----
+git-deltafy-script - Convery repository into delta format
+
+
+SYNOPSIS
+--------
+'git-deltafy-script'
+
+DESCRIPTION
+-----------
+Script to deltafy an entire GIT repository based on the commit list.
+The most recent version of a file is the reference and previous versions
+are made delta against the best earlier version available. And so on for
+successive versions going back in time.  This way the increasing delta
+overhead is pushed towards older versions of any given file.
+
+The -d argument allows to provide a limit on the delta chain depth.
+If 0 is passed then everything is undeltafied.  Limiting the delta
+depth is meaningful for subsequent access performance to old revisions.
+A value of 16 might be a good compromize between performance and good
+space saving.  Current default is unbounded.
+
+The --max-behind=30 argument is passed to git-mkdelta so to keep
+combinations and memory usage bounded a bit.  If you have lots of memory
+and CPU power you may remove it (or set to 0) to let git-mkdelta find the
+best delta match regardless of the number of revisions for a given file.
+You can also make the value smaller to make it faster and less
+memory hungry.  A value of 5 ought to still give pretty good results.
+When set to 0 or ommitted then look behind is unbounded.  Note that
+git-mkdelta might die with a segmentation fault in that case if it
+runs out of memory.  Note that the GIT repository will still be consistent
+even if git-mkdelta dies unexpectedly.
+
+
+Author
+------
+Written by Nicolas Pitre <nico@cam.org>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-fetch-script.txt b/Documentation/git-fetch-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-fetch-script.txt
@@ -0,0 +1,29 @@
+git-fetch-script(1)
+===================
+v0.1, May 2005
+
+NAME
+----
+git-fetch-script - Fetch an object from a remote repository
+
+
+SYNOPSIS
+--------
+'git-fetch-script' <sha1>
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -0,0 +1,29 @@
+git-get-tar-commit-id(1)
+========================
+v0.1, May 2005
+
+NAME
+----
+git-get-tar-commit-id - Show the commit ID embedded in a git-tar-tree file.
+
+
+SYNOPSIS
+--------
+'git-get-tar-commit-id' <tar-file.tar>
+
+DESCRIPTION
+-----------
+This shows the commit ID embedded in a git-tar-tree generated file.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-log-script.txt b/Documentation/git-log-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-log-script.txt
@@ -0,0 +1,29 @@
+git-log-script(1)
+=================
+v0.1, May 2005
+
+NAME
+----
+git-log-script - Prettified version of git-rev-list
+
+
+SYNOPSIS
+--------
+'git-log-script' 
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-shortlog.txt
@@ -0,0 +1,29 @@
+git-shortlog(1)
+===============
+v0.1, May 2005
+
+NAME
+----
+git-status - Show status of working directory files
+
+
+SYNOPSIS
+--------
+'git-log-script' | 'git-shortlog' 
+
+DESCRIPTION
+-----------
+Summarize the output of 'git-log-script'
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-status-script.txt b/Documentation/git-status-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-status-script.txt
@@ -0,0 +1,29 @@
+git-status-script(1)
+====================
+v0.1, May 2005
+
+NAME
+----
+git-status-script - Show status of working directory files
+
+
+SYNOPSIS
+--------
+'git-status-script' 
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-stripspace.txt
@@ -0,0 +1,31 @@
+git-stripspace(1)
+=================
+v0.1, May 2005
+
+NAME
+----
+git-stripspace - Strip space from stdin
+
+
+SYNOPSIS
+--------
+'git-stripspace' <stream
+
+DESCRIPTION
+-----------
+Remove empty lines from the beginning and end.
+
+Turn multiple consecutive empty lines into just one empty line.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-whatchanged.txt
@@ -0,0 +1,29 @@
+git-whatchanged(1)
+==================
+v0.1, May 2005
+
+NAME
+----
+git-whatchanged - Find out what changed
+
+
+SYNOPSIS
+--------
+'git-whatchanged' 
+
+DESCRIPTION
+-----------
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
======== end ========

