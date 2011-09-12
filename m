From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.7.rc1
Date: Mon, 12 Sep 2011 13:17:40 -0700
Message-ID: <7v1uvl7bx7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 22:18:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Cx7-0000Pp-QM
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 22:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab1ILURo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 16:17:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53858 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754552Ab1ILURm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 16:17:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47E5A588F;
	Mon, 12 Sep 2011 16:17:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=3Mp7oJlEyvf4Kf3bRSrWczswfkY=; b=BwzoCTEQ9hnPhiP/prY5txzAWJOm
	XlyMdNAZrD7Fk6oCJSZ+gp8pF+RzYkJT+/p0+xTD/5dpnA9C7Vs7CmdXsJXWHpA/
	P9CDOL99752KvaTUdYkcAKQI58X4HneesmC2NzeyOnmSY+DI8B7VCu5gPzdCtuMO
	aJ/9t0YhcdUlZVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	vvT40tx7cDzaukv5jOSYlimyLI0zuiDPMyuxN5QmadeKVBYvO7hIchso1qbOPZ99
	YKMbwnmPYPOpGIGrA5prMXFCzqKaiLsENNxL+GPBwQjvbFMkbWI2dnslLECuK1Bw
	kZD4csGmA+QX27zeGmr3woFawQLsvVzhQM92yIdX9ag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E55C588E;
	Mon, 12 Sep 2011 16:17:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88FB3588C; Mon, 12 Sep 2011
 16:17:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 447B1986-DD7C-11E0-972C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181238>

A release candidate Git 1.7.7.rc1 is available but unfortunately not at
the usual places. Even so (rather, exactly because it is in unusual
places, so we are likely to have smaller number of casual observers who
grab and build them), please test it to help us make the upcoming release
as solid as we could.

A release candidate tarball is found at:

    http://code.google.com/p/git-core/downloads/list
  
and its SHA-1 checksum is:

80dfcce410d2f36ffed4c8b48c8c896a45159e41  git-1.7.7.rc1.tar.gz

Also the following public repositories all have a copy of the v1.7.7-rc1
tag and the master branch that the tag points at:

	url = git://repo.or.cz/alt-git.git
	url = https://code.google.com/p/git-core/
	url = git://git.sourceforge.jp/gitroot/git-core/git.git
	url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
	url = https://github.com/gitster/git

Git v1.7.7 Release Notes (draft)
========================

Updates since v1.7.6
--------------------

 * The scripting part of the codebase is getting prepared for i18n/l10n.

 * Interix, Cygwin and Minix ports got updated.

 * Various updates to git-p4 (in contrib/), fast-import, and git-svn.

 * Gitweb learned to read from /etc/gitweb-common.conf when it exists,
   before reading from gitweb_config.perl or from /etc/gitweb.conf
   (this last one is read only when per-repository gitweb_config.perl
   does not exist).

 * Various codepaths that invoked zlib deflate/inflate assumed that these
   functions can compress or uncompress more than 4GB data in one call on
   platforms with 64-bit long, which has been corrected.

 * Git now recognizes loose objects written by other implementations that
   use a non-standard window size for zlib deflation (e.g. Agit running on
   Android with 4kb window). We used to reject anything that was not
   deflated with 32kb window.

 * Interaction between the use of pager and coloring of the output has
   been improved, especially when a command that is not built-in was
   involved.

 * "git am" learned to pass the "--exclude=<path>" option through to underlying
   "git apply".

 * You can now feed many empty lines before feeding an mbox file to
   "git am".

 * "git archive" can be told to pass the output to gzip compression and
   produce "archive.tar.gz".

 * "git bisect" can be used in a bare repository (provided that the test
   you perform per each iteration does not need a working tree, of
   course).

 * The length of abbreviated object names in "git branch -v" output
   now honors the core.abbrev configuration variable.

 * "git check-attr" can take relative paths from the command line.

 * "git check-attr" learned an "--all" option to list the attributes for a
   given path.

 * "git checkout" (both the code to update the files upon checking out a
   different branch and the code to checkout a specific set of files) learned
   to stream the data from object store when possible, without having to
   read the entire contents of a file into memory first. An earlier round
   of this code that is not in any released version had a large leak but
   now it has been plugged.

 * "git clone" can now take a "--config key=value" option to set the
   repository configuration options that affect the initial checkout.

 * "git commit <paths>..." now lets you feed relative pathspecs that
   refer to outside your current subdirectory.

 * "git diff --stat" learned a --stat-count option to limit the output of
   a diffstat report.

 * "git diff" learned a "--histogram" option to use a different diff
   generation machinery stolen from jgit, which might give better
   performance.

 * "git diff" had a weird worst case behaviour that can be triggered
   when comparing files with potentially many places that could match.

 * "git fetch", "git push" and friends no longer show connection
   errors for addresses that couldn't be connected to when at least one
   address succeeds (this is arguably a regression but a deliberate
   one).

 * "git grep" learned "--break" and "--heading" options, to let users mimic
   the output format of "ack".

 * "git grep" learned a "-W" option that shows wider context using the same
   logic used by "git diff" to determine the hunk header.

 * Invoking the low-level "git http-fetch" without "-a" option (which
   git itself never did---normal users should not have to worry about
   this) is now deprecated.

 * The "--decorate" option to "git log" and its family learned to
   highlight grafted and replaced commits.

 * "git rebase master topci" no longer spews usage hints after giving
   the "fatal: no such branch: topci" error message.

 * The recursive merge strategy implementation got a fairly large
   fix for many corner cases that may rarely happen in real world
   projects (it has been verified that none of the 16000+ merges in
   the Linux kernel history back to v2.6.12 is affected with the
   corner case bugs this update fixes).

 * "git stash" learned an "--include-untracked option".

 * "git submodule update" used to stop at the first error updating a
   submodule; it now goes on to update other submodules that can be
   updated, and reports the ones with errors at the end.

 * "git push" can be told with the "--recurse-submodules=check" option to
   refuse pushing of the supermodule, if any of its submodules'
   commits hasn't been pushed out to their remotes.

 * "git upload-pack" and "git receive-pack" learned to pretend that only a
   subset of the refs exist in a repository. This may help a site to
   put many tiny repositories into one repository (this would not be
   useful for larger repositories as repacking would be problematic).

 * "git verify-pack" has been rewritten to use the "index-pack" machinery
   that is more efficient in reading objects in packfiles.

 * test scripts for gitweb tried to run even when CGI-related perl modules
   are not installed; they now exit early when the latter are unavailable.

Also contains various documentation updates and minor miscellaneous
changes.


Fixes since v1.7.6
------------------

Unless otherwise noted, all fixes in the 1.7.6.X maintenance track are
included in this release.

 * The error reporting logic of "git am" when the command is fed a file
   whose mail-storage format is unknown was fixed.
   (merge dff4b0e gb/maint-am-patch-format-error-message later to 'maint').

 * "git branch --set-upstream @{-1} foo" did not expand @{-1} correctly.
   (merge e9d4f74 mg/branch-set-upstream-previous later to 'maint').

 * "git branch -m" and "git checkout -b" incorrectly allowed the tip
   of the branch that is currently checked out updated.
   (merge 55c4a67 ci/forbid-unwanted-current-branch-update later to 'maint').

 * "git check-ref-format --print" used to parrot a candidate string that
   began with a slash (e.g. /refs/heads/master) without stripping it, to make
   the result a suitably normalized string the caller can append to "$GIT_DIR/".
   (merge f3738c1 mh/check-ref-format-print-normalize later to 'maint').

 * "git clone" failed to clone locally from a ".git" file that itself
   is not a directory but is a pointer to one.
   (merge 9b0ebc7 nd/maint-clone-gitdir later to 'maint').

 * "git clone" from a local repository that borrows from another
   object store using a relative path in its objects/info/alternates
   file did not adjust the alternates in the resulting repository.
   (merge e6baf4a1 jc/maint-clone-alternates later to 'maint').

 * "git describe --dirty" did not refresh the index before checking the
   state of the working tree files.
   (cherry-pick bb57148 ac/describe-dirty-refresh later to 'maint').

 * "git ls-files ../$path" that is run from a subdirectory reported errors
   incorrectly when there is no such path that matches the given pathspec.
   (merge 0f64bfa cb/maint-ls-files-error-report later to 'maint').
