From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.11.rc1
Date: Sun, 03 Jun 2012 16:46:13 -0700
Message-ID: <7v1ulwvsz1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Jun 04 02:09:11 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SbKr7-0006ZL-14
	for glk-linux-kernel-3@plane.gmane.org; Mon, 04 Jun 2012 02:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab2FDAIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 3 Jun 2012 20:08:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754498Ab2FDAIx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jun 2012 20:08:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72FC88414;
	Sun,  3 Jun 2012 20:08:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=DN+bAPJ5CFGVD7kEjOFidx6Kl
	c8=; b=iQR97GsVLcoaS0LhuPK0q4BgzFmchBes456Xjg1+wfdvS+9gJv/kCrfrU
	EjJX1mAPi7lxcVMlDRFq4xzGv+Jlilsa/9WNA+Ab4q8Zv1pALujYFOZ8Q+Kb1Dim
	aTrz4lxV2p1na2lIL1T5VJfMLrq/aVjs2UqHbw6mLTiSg+RIC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Zre0W/gkY2FLt5AShtn
	4k1D2zpEjXj9cM3jfnB5Lwijz5Nbkm1O0bqR+8t86gEFsqczwbL97KrOnCyaY3P3
	ofg4U7CwIHuSp+PhEOiRmnfC6Y/Fpi6sNyY5uCM1+0fs9Im97q8bC6AuVjkm/jPb
	jTWGrKbxebPp+3fJ6FslCink=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 699E28413;
	Sun,  3 Jun 2012 20:08:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F9758411; Sun,  3 Jun 2012
 20:08:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 772AE536-ADD9-11E1-92CD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199115>

A release candidate Git v1.7.11-rc1 is now available for testing at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

c5805f67a1c21922f5fe7456dae9fb9b8c4b9a16  git-1.7.11.rc1.tar.gz
379bc711136df07ae64da4f14a90a3837f3e248c  git-htmldocs-1.7.11.rc1.tar.g=
z
5ba3bc8dd9fcf775a2364a5b73bb84600cc903af  git-manpages-1.7.11.rc1.tar.g=
z

Also the following public repositories all have a copy of the v1.7.11-r=
c1
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.11 Release Notes (draft)
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

=46oreign Interface

 * "git svn" used to die with unwanted SIGPIPE when talking with HTTP
   server that uses keep-alive.

 * "git svn" learned to use platform specific authentication
   providers, e.g. gnome-keyring, kwallet, etc.

 * "git p4" has been moved out of contrib/ area and has seen more work
   on importing labels as tags from (and exporting tags as labels to)
   p4.

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

 * The API to iterate over refs/ hierarchy has been tweaked to allow
   walking only a subset of it more efficiently.

Also contains minor documentation updates and code clean-ups.


=46ixes since v1.7.10
-------------------

Unless otherwise noted, all the fixes since v1.7.10 in the maintenance
releases are contained in this release (see release notes to them for
details).

 * "git rebase -p" used to pay attention to rebase.autosquash which
    was wrong.  "git rebase -p -i" should, but "git rebase -p" by
    itself should not.
   (cherry-pick 8a6dae1 vr/rebase-autosquash-does-not-imply-i later to =
maint).

 * "git submodule init" used to report "registered for path ..."
   even for submodules that were registered earlier.
   (cherry-pick c1c259e jl/submodule-report-new-path-once later to main=
t).

 * "git diff --stat" used to fully count a binary file with modified
   execution bits whose contents is unmodified, which was not quite
   right.

----------------------------------------------------------------

Changes since v1.7.11-rc0 are as follows:

Erik Faye-Lund (2):
      rebase: report invalid commit correctly
      Makefile: add missing GIT-VERSION-FILE dependency

Jeff King (30):
      ident: split setup_ident into separate functions
      http-push: do not access git_default_email directly
      fmt-merge-msg: don't use static buffer in record_person
      move identity config parsing to ident.c
      move git_default_* variables to ident.c
      ident: trim trailing newline from /etc/mailname
      format-patch: use default email for generating message ids
      fmt_ident: drop IDENT_WARN_ON_NO_NAME code
      ident: don't write fallback username into git_default_name
      drop length limitations on gecos-derived names and emails
      ident: report passwd errors with a more friendly message
      ident: use full dns names to generate email addresses
      ident: use a dynamic strbuf in fmt_ident
      ident: trim whitespace from default name/email
      format-patch: refactor get_patch_filename
      fetch-pack: sort incoming heads
      fetch-pack: avoid quadratic behavior in remove_duplicates
      add sorting infrastructure for list refs
      fetch-pack: sort the list of incoming refs
      fetch-pack: avoid quadratic loop in filter_refs
      fetch-pack: sort incoming heads list earlier
      ident: reword empty ident error message
      ident: refactor NO_DATE flag in fmt_ident
      ident: let callers omit name with fmt_indent
      format-patch: use GIT_COMMITTER_EMAIL in message ids
      ident: rename IDENT_ERROR_ON_NO_NAME to IDENT_STRICT
      ident: reject bogus email addresses with IDENT_STRICT
      format-patch: do not use bogus email addresses in message ids
      t5701: modernize style
      INSTALL: update asciidoc recommendation

Jens Lehmann (1):
      submodules: print "registered for path" message only once

Jiang Xin (5):
      l10n: Update git.pot (41 new messages)
      l10n: zh.CN.po: update by msgmerge git.pot
      l10n: zh_CN.po: translate 323 new messages
      l10n: Set nplurals of zh_CN.po from 1 to 2
      i18n: apply: split to fix a partial i18n message

Jonathan Nieder (3):
      git-svn: move Git::SVN::Prompt into its own file
      git-svn: rename SVN::Git::* packages to Git::SVN::*
      git-svn: make Git::SVN::Fetcher a separate file

Junio C Hamano (6):
      refs: do not create ref_entry when searching
      cherry-pick: regression fix for empty commits
      Start preparing for 1.7.10.4
      Update draft release notes to 1.7.11
      Git 1.7.10.4
      Git 1.7.11-rc1

Marco Paolone (1):
      l10n: New it.po file with 504 translations

Matthieu Moy (1):
      Reduce cost of deletion in levenstein distance (4 -> 3)

Michael Haggerty (5):
      free_ref_entry(): do not trigger reading of loose refs
      cmd_fetch_pack(): declare dest to be const
      cmd_fetch_pack(): handle non-option arguments outside of the loop
      cmd_fetch_pack(): combine the loop termination conditions
      cmd_fetch_pack(): respect constness of argv parameter

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      pack-objects, streaming: turn "xx >=3D big_file_threshold" to "..=
 > .."
      pack-objects: refactor write_object() into helper functions

Peter Krefting (1):
      Update Swedish translation (728t0f0u)

Ren=C3=A9 Scharfe (3):
      refs: convert parameter of search_ref_dir() to length-limited str=
ing
      refs: convert parameter of create_dir_entry() to length-limited s=
tring
      refs: use strings directly in find_containing_dir()

Tran Ngoc Quan (2):
      Init translation for Vietnamese
      First release translation for Vietnamese

Vincent van Ravesteijn (1):
      Do not autosquash in case of an implied interactive rebase

Vitor Antunes (3):
      git-p4: Test changelists touching two branches
      git-p4: Verify detection of "empty" branch creation
      git-p4: Clean up branch test cases
