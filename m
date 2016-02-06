From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.7.1
Date: Fri, 05 Feb 2016 16:08:05 -0800
Message-ID: <xmqqd1sabt0a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 01:08:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRqQf-00030A-Nd
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 01:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbcBFAI2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 19:08:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750761AbcBFAII convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 19:08:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C2B5D42F35;
	Fri,  5 Feb 2016 19:08:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=4CYEDkMD+LxVg+39xfp7SpWlV
	bc=; b=BLQyo1EG3+sR4qHmyWjB/AdolaCyOocpTLvb1EeKWzWN8fMQQHNbpaI4a
	zXqD/llk3zVB0eDo848te/NFefRoLStIsLgJNoAmIhJEdU9CwFbUuvV6KcKjnlWS
	RnnV+0thizaajyBvHTeeZA3r2SrJK9Wmm+1DQteJr/CTqv+EBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=BYP0jrS+pa7hel9L2Hv
	9cXCrUZIZbqpF+rx57WQyldVY/6GNOeniiTHSOU5x+qQMnFEo90hC64tc+F+axuc
	fLgDVY0wCpmRMfutIsLzxzs9vjPF8wct/XnM8jA6NWLrqtX9lOBHpa0Ee9EJ49ZO
	poAF/ZPpHz35AMydro9WgsGc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA3F642F32;
	Fri,  5 Feb 2016 19:08:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E25042F31;
	Fri,  5 Feb 2016 19:08:07 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B2FCFE92-CC65-11E5-A283-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285657>

The latest maintenance release Git v2.7.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.7.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.7.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.7
----------------

 * An earlier change in 2.5.x-era broke users' hooks and aliases by
   exporting GIT_WORK_TREE to point at the root of the working tree,
   interfering when they tried to use a different working tree without
   setting GIT_WORK_TREE environment themselves.

 * The "exclude_list" structure has the usual "alloc, nr" pair of
   fields to be used by ALLOC_GROW(), but clear_exclude_list() forgot
   to reset 'alloc' to 0 when it cleared 'nr' to discard the managed
   array.

 * "git send-email" was confused by escaped quotes stored in the alias
   files saved by "mutt", which has been corrected.

 * A few unportable C construct have been spotted by clang compiler
   and have been fixed.

 * The documentation has been updated to hint the connection between
   the '--signoff' option and DCO.

 * "git reflog" incorrectly assumed that all objects that used to be
   at the tip of a ref must be commits, which caused it to segfault.

 * The ignore mechanism saw a few regressions around untracked file
   listing and sparse checkout selection areas in 2.7.0; the change
   that is responsible for the regression has been reverted.

 * Some codepaths used fopen(3) when opening a fixed path in $GIT_DIR
   (e.g. COMMIT_EDITMSG) that is meant to be left after the command is
   done.  This however did not work well if the repository is set to
   be shared with core.sharedRepository and the umask of the previous
   user is tighter.  They have been made to work better by calling
   unlink(2) and retrying after fopen(3) fails with EPERM.

 * Asking gitweb for a nonexistent commit left a warning in the server
   log.

 * "git rebase", unlike all other callers of "gc --auto", did not
   ignore the exit code from "gc --auto".

 * Many codepaths that run "gc --auto" before exiting kept packfiles
   mapped and left the file descriptors to them open, which was not
   friendly to systems that cannot remove files that are open.  They
   now close the packs before doing so.

 * A recent optimization to filter-branch in v2.7.0 introduced a
   regression when --prune-empty filter is used, which has been
   corrected.

 * The description for SANITY prerequisite the test suite uses has
   been clarified both in the comment and in the implementation.

 * "git tag" started listing a tag "foo" as "tags/foo" when a branch
   named "foo" exists in the same repository; remove this unnecessary
   disambiguation, which is a regression introduced in v2.7.0.

 * The way "git svn" uses auth parameter was broken by Subversion
   1.9.0 and later.

 * The "split" subcommand of "git subtree" (in contrib/) incorrectly
   skipped merges when it shouldn't, which was corrected.

 * A few options of "git diff" did not work well when the command was
   run from a subdirectory.

 * dirname() emulation has been added, as Msys2 lacks it.

 * The underlying machinery used by "ls-files -o" and other commands
   have been taught not to create empty submodule ref cache for a
   directory that is not a submodule.  This removes a ton of wasted
   CPU cycles.

 * Drop a few old "todo" items by deciding that the change one of them
   suggests is not such a good idea, and doing the change the other
   one suggested to do.

 * Documentation for "git fetch --depth" has been updated for clarity.

 * The command line completion learned a handful of additional options
   and command specific syntax.

Also includes a handful of documentation and test updates.

----------------------------------------------------------------

Changes since v2.7.0 are as follows:

Changwoo Ryu (1):
      l10n: ko.po: Add Korean translation

Dave Ware (1):
      contrib/subtree: fix "subtree split" skipped-merge bug

David A. Wheeler (1):
      Expand documentation describing --signoff

Dennis Kaarsemaker (1):
      reflog-walk: don't segfault on non-commit sha1's in the reflog

Eric Wong (3):
      git-send-email: do not double-escape quotes from mutt
      for-each-ref: document `creatordate` and `creator` fields
      git-svn: fix auth parameter handling on SVN 1.9.0+

Jeff King (8):
      avoid shifting signed integers 31 bits
      bswap: add NO_UNALIGNED_LOADS define
      rebase: ignore failures from "gc --auto"
      filter-branch: resolve $commit^{tree} in no-index case
      clean: make is_git_repository a public function
      resolve_gitlink_ref: ignore non-repository paths
      t6300: use test_atom for some un-modern tests
      tag: do not show ambiguous tag names as "tags/foo"

Johannes Schindelin (11):
      commit: allow editing the commit message even in shared repos
      Handle more file writes correctly in shared repos
      Refactor skipping DOS drive prefixes
      compat/basename: make basename() conform to POSIX
      compat/basename.c: provide a dirname() compatibility function
      t0060: verify that basename() and dirname() work as expected
      fetch: release pack files before garbage-collecting
      am: release pack files before garbage-collecting
      merge: release pack files before garbage-collecting
      receive-pack: release pack files before garbage-collecting
      t0060: loosen overly strict expectations

Johannes Sixt (1):
      mingw: avoid linking to the C library's isalpha()

John Keeping (1):
      completion: add missing git-rebase options

Junio C Hamano (2):
      test-lib: clarify and tighten SANITY
      Git 2.7.1

Lars Vogel (1):
      git-add doc: do not say working directory when you mean working t=
ree

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
      Revert "setup: set env $GIT_WORK_TREE when work tree is set, like=
 $GIT_DIR"
      dir.c: clean the entire struct in clear_exclude_list()
      Revert "dir.c: don't exclude whole dir prematurely if neg pattern=
 may match"
      diff-no-index: do not take a redundant prefix argument
      diff: make -O and --output work in subdirectory

Paul Wagland (2):
      completion: complete show-branch "--date-order"
      completion: update completion arguments for stash

SZEDER G=C3=A1bor (1):
      t6050-replace: make failing editor test more robust

Sebastian Schuberth (3):
      docs: clarify that passing --depth to git-clone implies --single-=
branch
      docs: say "commits" in the --depth option wording for git-clone
      docs: clarify that --depth for git-fetch works with newly initial=
ized repos

Stephen P. Smith (4):
      user-manual: remove temporary branch entry from todo list
      glossary: define the term shallow clone
      user-manual: add section documenting shallow clones
      user-manual: add addition gitweb information

Thomas Braun (1):
      completion: complete "diff --word-diff-regex=3D"

=C3=98yvind A. Holm (1):
      gitweb: squelch "uninitialized value" warning
