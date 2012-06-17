From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.11
Date: Sun, 17 Jun 2012 15:24:22 -0700
Message-ID: <7v62ap60h5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Jun 18 00:24:42 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SgNth-000380-5s
	for glk-linux-kernel-3@plane.gmane.org; Mon, 18 Jun 2012 00:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757854Ab2FQWYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 17 Jun 2012 18:24:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328Ab2FQWYZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jun 2012 18:24:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C70DB993F;
	Sun, 17 Jun 2012 18:24:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=5HjhAWyRSx+yb8b3YMFbg2msu
	xE=; b=sgVgcHvuAiEDCLvernHYR4CUJpy9ICI5McxQR1MyOU7JDTfdmsxJKi/5Z
	lCv5MtWcxXZRxeEuQf5viHqNmfvkqWD19UJ47WOCe6kScHzi02Y6dfn+4HK2ab4j
	7o+YVlIqJNOQRPrWxC42z5Cla5UMnANmkfy+hZnZBbDi9GySkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ec9O+OtIzH45P73hP5w
	KdwMXr8x2ExSdSGE+7A91gZ2I2YcbVEkbHDQ/JfRKRq6uQKQfGbwtIiL8bO2Zy3h
	e6wlSuJ/SidZJlYgBWgm6PWc5mh3a7bFeRA8FCIK4NOrZZuydV5JSw7kA1wu8gnT
	25NKpbffzwaDFlVxGDeWh+Go=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5501993E;
	Sun, 17 Jun 2012 18:24:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB6D3993D; Sun, 17 Jun 2012
 18:24:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 311DFDB0-B8CB-11E1-B454-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200136>

The latest feature release Git v1.7.11 is now available at the
usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

15abe2c5b6b7cf9b738e3fb57ab9234ae02a1e61  git-1.7.11.tar.gz
34d7fb39e7c5e290ca041ffca3cb1fb4256f6fb3  git-htmldocs-1.7.11.tar.gz
9f963243dfdbf5d77049e5fbb1e8e571effa4285  git-manpages-1.7.11.tar.gz

Also the following public repositories all have a copy of the v1.7.11
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.11 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

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

=46oreign Interface

 * "git svn" used to die with unwanted SIGPIPE when talking with an HTT=
P
   server that uses keep-alive.

 * "git svn" learned to use platform specific authentication
   providers, e.g. gnome-keyring, kwallet, etc.

 * "git p4" has been moved out of the contrib/ area and has seen more
   work on importing labels as tags from (and exporting tags as labels
   to) p4.

Performance and Internal Implementation (please report possible regress=
ions)

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


=46ixes since v1.7.10
-------------------

Unless otherwise noted, all the fixes since v1.7.10 in the maintenance
releases are contained in this release (see release notes to them for
details).

 * "git submodule init" used to report "registered for path ..."
   even for submodules that were registered earlier.
   (cherry-pick c1c259e jl/submodule-report-new-path-once later to main=
t).

 * "git diff --stat" used to fully count a binary file with modified
   execution bits whose contents is unmodified, which was not quite
   right.

----------------------------------------------------------------

Changes since v1.7.11-rc3 are as follows:

Alexander Strasser (1):
      diff: Only count lines in show_shortstats

Jonathan Nieder (2):
      perl/Makefile.PL: warn about duplicate module list in perl/Makefi=
le
      perl/Makefile: install Git::SVN::* when NO_PERL_MAKEMAKER=3Dyes, =
too

Junio C Hamano (2):
      Git 1.7.10.5
      Git 1.7.11

Marco Paolone (1):
      l10n: it.po: translate 212 new messages

Ramsay Allan Jones (1):
      gitweb: Skip 'modification times' tests when no date parser avail=
able

SZEDER G=C3=A1bor (2):
      completion: put main git and gitk completion functions back into =
git namespace
      completion: remove credential helpers from porcelain commands

Vincent van Ravesteijn (1):
      Do not autosquash in case of an implied interactive rebase
