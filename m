From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.11-rc2
Date: Thu, 07 Jun 2012 13:33:54 -0700
Message-ID: <7vd35ag8ul.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Jun 07 22:34:08 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ScjP8-0002Dc-Ug
	for glk-linux-kernel-3@plane.gmane.org; Thu, 07 Jun 2012 22:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660Ab2FGUd7 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 7 Jun 2012 16:33:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828Ab2FGUd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jun 2012 16:33:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6AC88D9B;
	Thu,  7 Jun 2012 16:33:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=o
	m1pzhUo0WFg3/EFzA7B6wHBTLg=; b=E829+BJZwEiahq5pTyw3ldxO9AF629b15
	nowbDpTJXOR25Qv575WZU7oZ+iqMkWsacNfy8uv4LvjOf8jgSCBSygX07zmGNMxA
	0UlPeEmtUwCauWf/3sgxZqG/zR+vlw1NXEvTPxL5d6dcJR8xGChbZRdu+Yzl7tDH
	HJ6F6G1scI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=AZfo/PJwNOzzeW62NU2M7DAF8fxx2saebObV4RqBJBOr6ClHaswvOw0T
	davZDLc+p4pfhBxRv/kJoOtD1PfVTKKWJdHDwNiOHuLvRrdTKP0Im+nPR2GOlhOV
	hSMSiEvAcSVqZ9GLMSkyo6WAlXd1UlmdFm0ZyJeXfg37gnkM/ig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E3288D9A;
	Thu,  7 Jun 2012 16:33:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F08F48D99; Thu,  7 Jun 2012
 16:33:55 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A671D10-B0E0-11E1-A8F2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199446>

A release candidate Git v1.7.11-rc2 is now available for testing
at the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

654b72f2018d20cdf11ab768aaef162ecb2b2399  git-1.7.11.rc2.tar.gz
8e1fd52585938a77bea52288dac86d5a9e218f2c  git-htmldocs-1.7.11.rc2.tar.gz
958464c1e4a1901ac7c3a7a435636ccf8620ff1a  git-manpages-1.7.11.rc2.tar.gz

Also the following public repositories all have a copy of the v1.7.11-rc2
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

Changes since v1.7.11-rc1 are as follows:

Colby Ranger (1):
      Add persistent-https to contrib

Jiang Xin (2):
      l10n: Update git.pot (5 new, 3 removed messages)
      l10n: zh_CN.po: translate 2 new, 3 fuzzy messages

Junio C Hamano (3):
      git-svn: platform auth providers are working only on 1.6.15 or newer
      doc: fix xref link from api docs to manual pages
      Git 1.7.11-rc2

Matthieu Moy (3):
      api-credentials.txt: show the big picture first
      api-credentials.txt: mention credential.helper explicitly
      api-credentials.txt: add "see also" section

Ralf Thielow (4):
      l10n: de.po: translate 265 new messages
      l10n: de.po: translate 41 new messages
      l10n: de.po: translate 2 new, 3 fuzzy messages
      l10n: de.po: add additional newline

Ramkumar Ramachandra (1):
      t3510 (cherry-pick-sequence): add missing '&&'

Tran Ngoc Quan (1):
      l10n: Update translation for Vietnamese
