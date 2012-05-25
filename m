From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.11.rc0
Date: Fri, 25 May 2012 13:54:18 -0700
Message-ID: <7vobpcq8w5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri May 25 22:54:38 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SY1Wv-0003Hw-Bo
	for glk-linux-kernel-3@plane.gmane.org; Fri, 25 May 2012 22:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758795Ab2EYUyX (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 25 May 2012 16:54:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755460Ab2EYUyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 May 2012 16:54:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B503688DE;
	Fri, 25 May 2012 16:54:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=qATub4IOrwlXddhXtx//EbD1BZM=; b=eM1yJBOrOquRANfLeppzAz5rfCP/
	p9GeNj0zmpGCDFS2oZo73035LfcHXsMScS7gjDBE3mk+mwQ+w/CF2BlcWlva+v0Z
	kwwB8uZ73/USG+kjgXoU7tkYN7elZLG6F/wBSeKCaQhUxEyLBgy7h8y5pitB92Kt
	DfO1DrMdaqDxCW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	rpO5+kh+Vjf49NyQov+O0hi0dj/QBvaampNctglbjRHnHJ5qgHrIzKZDIYfUycC/
	0mFB99y5UDkGqHKqrbtfTj1O9tZIHuyd2EWtN2fZTV1lsZisVqUv5YzOavyPkltz
	Qo98pg1PEJdaQuZbwQuT2UXjLQytGfsCj7B37TZpygU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD0A888DD;
	Fri, 25 May 2012 16:54:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3EFB88DC; Fri, 25 May 2012
 16:54:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC72C1B0-A6AB-11E1-8B32-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198524>

A release candidate Git 1.7.11.rc0 is now available for testing at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

8661e1ee946728c8b0d948982f9430634680bd34  git-1.7.11.rc0.tar.gz
2d09cfc9c1cae51864c1cb44670d23c7953c1825  git-htmldocs-1.7.11.rc0.tar.gz
62976ccf1f577917225811cd1facfdf88aa67195  git-manpages-1.7.11.rc0.tar.gz

Also the following public repositories all have a copy of the v1.7.11.rc0
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.7.11 Release Notes (draft)
=========================

Updates since v1.7.10
---------------------

UI, Workflows & Features

 * A new mode for push, "simple", which is a cross between "current"
   and "upstream", has been introduced. "git push" without any refspec
   will push the current branch out to the same name at the remote
   repository only when it is set to track the branch with the same
   name over there.  The plan is to make this mode the new default
   value when push.default is not configured.

 * A couple of commands learned the "--column" option to produce
   columnar output.

 * A third-party tool "git subtree" is distributed in contrib/

 * Error messages given when @{u} is used for a branch without its
   upstream configured have been clatified.

 * Even with "-q"uiet option, "checkout" used to report setting up
   tracking.  Also "branch" learned the "-q"uiet option to squelch
   informational message.

 * Your build platform may support hardlinks but you may prefer not to
   use them, e.g. when installing to DESTDIR to make a tarball and
   untarring on a filesystem that has poor support for hardlinks.
   There is a Makefile option NO_INSTALL_HARDLINKS for you.

 * The smart-http backend used to always override GIT_COMMITTER_*
   variables with REMOTE_USER and REMOTE_ADDR, but these variables are
   now preserved when set.

 * "git am" learned the "--include" option, which is an opposite of
   existing the "--exclude" option.

 * When "git am -3" needs to fall back to an application to a
   synthesized preimage followed by a 3-way merge, the paths that
   needed such treatment are now reported to the end user, so that the
   result in them can be eyeballed with extra care.

 * The output from "diff/log --stat" used to always allocate 4 columns
   to show the number of modified lines, but not anymore.

 * "git difftool" learned the "--dir-diff" option to spawn external
   diff tools that can compare two directory hierarchies at a time
   after populating two temporary directories, instead of running an
   instance of the external tool once per a file pair.

 * The "fmt-merge-msg" command learns to list the primary contributors
   involved in the side topic you are merging.

 * "git rebase" learned to optionally keep commits that do not
   introduce any change in the original history.

 * "git push --recurse-submodules" learned to optionally look into the
   histories of submodules bound to the superproject and push them
   out.

 * A 'snapshot' request to "gitweb" honors If-Modified-Since: header,
   based on the commit date.

 * "gitweb" learned to highlight the patch it outputs even more.

Foreign Interface

 * "git svn" used to die with unwanted SIGPIPE when talking with HTTP
   server that uses keep-alive.

 * "git svn" learned to use platform specific authentication
   providers, e.g. gnome-keyring, kwallet, etc.

 * "git p4" has been moved out of contrib/ area and has seen more work
   on importing labels as tags from (and exporting tags as labels to)
   p4.

Performance and Internal Implementation (please report possible regressions)

 * Bash completion script (in contrib/) have been cleaned up to make
   future work on it simpler.

 * An experimental "version 4" format of the index file has been
   introduced to reduce on-disk footprint and I/O overhead.

 * "git archive" learned to produce its output without reading the
   blob object it writes out in memory in its entirety.

 * "git index-pack" that runs when fetching or pushing objects to
   complete the packfile on the receiving end learned to use multiple
   threads to do its job when available.

 * The code to compute hash values for lines used by the internal diff
   engine was optimized on little-endian machines, using the same
   trick the kernel folks came up with.

 * "git apply" had some memory leaks plugged.

 * Setting up a revision traversal with many starting points was
   inefficient as these were placed in a date-order priority queue
   one-by-one.  Now they are collected in the queue unordered first,
   and sorted immediately before getting used.

 * More lower-level commands learned to use the streaming API to read
   from the object store without keeping everything in core.

 * Because "sh" on the user's PATH may be utterly broken on some
   systems, run-command API now uses SHELL_PATH, not /bin/sh, when
   spawning an external command (not applicable to Windows port).

 * The API to iterate over refs/ hierarchy has been tweaked to allow
   walking only a subset of it more efficiently.

Also contains minor documentation updates and code clean-ups.


Fixes since v1.7.10
-------------------

Unless otherwise noted, all the fixes since v1.7.10 in the maintenance
releases are contained in this release (see release notes to them for
details).

 * The progress indicator for a large "git checkout" was sent to
   stderr even if it is not a terminal.
   (merge e9fc64c ap/checkout-no-progress-for-non-tty later to maint).

 * A name taken from mailmap was copied into an internal buffer
   incorrectly and could overun the buffer if it is too long.
   (merge c9b4e9e jk/format-person-part-buffer-limit later to maint).

 * A malformed commit object that has a header line chomped in the
   middle could kill git with a NULL pointer dereference.
   (merge a9c7a8a jk/pretty-commit-header-incomplete-line later to maint).

 * An author/committer name that is a single character was mishandled
   as an invalid name by mistake.
   (merge d9955fd jk/ident-split-fix later to maint).

 * "git grep -e '$pattern'", unlike the case where the patterns are
   read from a file, did not treat individual lines in the given
   pattern argument as separate regular expressions as it should.
   (merge ec83061 rs/maint-grep-F later to maint).

 * "git diff --stat" used to fully count a binary file with modified
   execution bits whose contents is unmodified, which was not quite
   right.
