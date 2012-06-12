From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.11-rc3
Date: Tue, 12 Jun 2012 10:35:08 -0700
Message-ID: <7v8vfsjuwj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jun 12 19:35:43 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SeV0A-0000dk-5I
	for glk-linux-kernel-3@plane.gmane.org; Tue, 12 Jun 2012 19:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab2FLRf1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 12 Jun 2012 13:35:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab2FLRfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jun 2012 13:35:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F27F9FE9;
	Tue, 12 Jun 2012 13:35:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=z
	8Rh+cmx69AiPzybNyeSGwLjw8A=; b=cBNbms8ZhzQ2wmd9mbWuHhssjZfSgkoPR
	DxXi5PwzArfcLTpeLzDlPE4TmMptu+Iz/xTZrprzqCZIDJnihf3c2s4MmQu3pEFN
	+/b4OVcahAXwfgWQOlyd3aeQig0rqtC4try0+D62m1Wkv1JEYGw+IPat13XkBAhs
	Xxv+u2d8nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=H2+klsOZENVvL58t4nHLugvOf+waJ+X3/P56DbNPoY27M5v7yj4jJbN2
	VyIwmxnqypCDCcxxtU51FSXHyvi3MOmq0/yF+4Ypn+aYecqQJmUntn9UffqKzXF4
	Awe0W+veKkGIOeYw1RPi1tgnySiIlq+C5fDu2KtwS3lnaTpoIUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85B969FE8;
	Tue, 12 Jun 2012 13:35:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 904F49FE7; Tue, 12 Jun 2012
 13:35:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F50A1E2C-B4B4-11E1-A601-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199817>

A release candidate Git v1.7.11-rc3 is now available for testing at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

9011f5e13e0d405c96f6446c61f3d5ba2a4803a3  git-1.7.11.rc3.tar.gz
5bcedd47ee6a0292287139cb74bec4ba21eccd3f  git-htmldocs-1.7.11.rc3.tar.gz
c6ab0608eca71a71d9354c7c533c37554fc9003c  git-manpages-1.7.11.rc3.tar.gz

Also the following public repositories all have a copy of the v1.7.11-rc3
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

 * A remote helper that acts as a proxy and caches ssl session for the
   https:// transport is added to the contrib/ area.

 * Error messages given when @{u} is used for a branch without its
   upstream configured have been clarified.

 * Even with the "-q"uiet option, "checkout" used to report setting up
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

 * When "git am -3" needs to fall back to an application of the patch
   to a synthesized preimage followed by a 3-way merge, the paths that
   needed such treatment are now reported to the end user, so that the
   result in them can be eyeballed with extra care.

 * The output from "diff/log --stat" used to always allocate 4 columns
   to show the number of modified lines, but not anymore.

 * "git difftool" learned the "--dir-diff" option to spawn external
   diff tools that can compare two directory hierarchies at a time
   after populating two temporary directories, instead of running an
   instance of the external tool once per a file pair.

 * The "fmt-merge-msg" command learned to list the primary contributors
   involved in the side topic you are merging in a comment in the merge
   commit template.

 * "git rebase" learned to optionally keep commits that do not
   introduce any change in the original history.

 * "git push --recurse-submodules" learned to optionally look into the
   histories of submodules bound to the superproject and push them
   out.

 * A 'snapshot' request to "gitweb" honors If-Modified-Since: header,
   based on the commit date.

 * "gitweb" learned to highlight the patch it outputs even more.

Foreign Interface

 * "git svn" used to die with unwanted SIGPIPE when talking with an HTTP
   server that uses keep-alive.

 * "git svn" learned to use platform specific authentication
   providers, e.g. gnome-keyring, kwallet, etc.

 * "git p4" has been moved out of the contrib/ area and has seen more
   work on importing labels as tags from (and exporting tags as labels
   to) p4.

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

 * The weighting parameters to suggestion command name typo have been
   tweaked, so that "git tags" will suggest "tag?" and not "stage?".

 * Because "sh" on the user's PATH may be utterly broken on some
   systems, run-command API now uses SHELL_PATH, not /bin/sh, when
   spawning an external command (not applicable to Windows port).

 * The API to iterate over the refs/ hierarchy has been tweaked to
   allow walking only a subset of it more efficiently.

Also contains minor documentation updates and code clean-ups.


Fixes since v1.7.10
-------------------

Unless otherwise noted, all the fixes since v1.7.10 in the maintenance
releases are contained in this release (see release notes to them for
details).

 * "git fast-export" did not give a readable error message when the
   same mark erroneously appeared twice in the --import-marks input.
   (merge 43bc230 js/maint-fast-export-mark-error later to maint).

 * "git rebase -p" used to pay attention to rebase.autosquash which
    was wrong.  "git rebase -p -i" should, but "git rebase -p" by
    itself should not.
   (cherry-pick 8a6dae1 vr/rebase-autosquash-does-not-imply-i later to maint).

 * "git submodule init" used to report "registered for path ..."
   even for submodules that were registered earlier.
   (cherry-pick c1c259e jl/submodule-report-new-path-once later to maint).

 * "git diff --stat" used to fully count a binary file with modified
   execution bits whose contents is unmodified, which was not quite
   right.

----------------------------------------------------------------

Changes since v1.7.11-rc2 are as follows:

Jeff King (1):
      docs: fix cross-directory linkgit references

Jiang Xin (2):
      l10n: Update git.pot (27 new, 1 removed messages)
      l10n: zh_CN.po: translate 27 new messages

Johannes Schindelin (1):
      fast-export: report SHA-1 instead of gibberish when marks exist already

Jonathan Nieder (3):
      git-svn: make Git::SVN::Editor a separate file
      git-svn: make Git::SVN::RA a separate file
      git-svn: use YAML format for mergeinfo cache when possible

Junio C Hamano (2):
      fmt-merge-msg: make attribution into comment lines
      Git 1.7.11-rc3

Matthieu Moy (1):
      api-credential.txt: document that helpers field is filled-in automatically

Ralf Thielow (1):
      l10n: de.po: translate 27 new messages

Tran Ngoc Quan (1):
      l10n: Update  po/vi.po to v1.7.11.rc2.2.gb694fbb
