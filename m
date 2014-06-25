From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.0.1
Date: Wed, 25 Jun 2014 14:19:34 -0700
Message-ID: <xmqqegyc7k4j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Jun 25 23:30:33 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Wzulz-0005a2-7h
	for glk-linux-kernel-3@plane.gmane.org; Wed, 25 Jun 2014 23:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253AbaFYVaR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 25 Jun 2014 17:30:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62980 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866AbaFYVaN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2014 17:30:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FA6F21E24;
	Wed, 25 Jun 2014 17:30:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=meJ/d+tDisoV7PAm68MNKphmJ
	XM=; b=W8HbT2S3uZdV6beQbx0u6lPMbJ4VRh42Vddn0KBFOV0Xb3Xon/IMnDPQx
	1aUQ50NyRr1NPmj6HBN/B0Nge1O1ts+jmHVL+7NTMw1VXdkZs6oLX59eQBl4apCo
	roKLLcrxutjWLItwR27kVm6r3aQjLWR9QfRof7PmMUIuXCQuX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=SuQLrjn3JitNkx8xVbQ
	mIKysGlKsQoT+Od95C5ElYQh0iY9BQ9KnlDqAzgip68Ikx8O1GBAuLfa1oVsqiOA
	Y24NBO00ysVL0uZUB4cscloFoA1TAwmL4lyAy79Nj4vVo3aOBA6aDTpZegQnB4y0
	59NTUS5MbqkHgBle1EgPbT/k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F4FD21E23;
	Wed, 25 Jun 2014 17:30:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E633421E1B;
	Wed, 25 Jun 2014 17:29:59 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC7810EA-FCAF-11E3-BAD9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252466>

Git v2.0.1, the first maintenance release for Git v2.0, is now
available at the usual places.  This contains most of the fixes
already merged on the 'master' front in preparation for the v2.1
release.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.0.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v2.0.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * We used to unconditionally disable the pager in the pager process
   we spawn to feed out output, but that prevented people who want to
   run "less" within "less" from doing so.

 * Tools that read diagnostic output in our standard error stream do
   not want to see terminal control sequence (e.g. erase-to-eol).
   Detect them by checking if the standard error stream is connected
   to a tty.
 * Reworded the error message given upon a failure to open an existing
   loose object file due to e.g. permission issues; it was reported as
   the object being corrupt, but that is not quite true.

 * "git log -2master" is a common typo that shows two commits starting
   from whichever random branch that is not 'master' that happens to
   be checked out currently.

 * The "%<(10,trunc)%s" pretty format specifier in the log family of
   commands is used to truncate the string to a given length (e.g. 10
   in the example) with padding to column-align the output, but did
   not take into account that number of bytes and number of display
   columns are different.

 * The "mailmap.file" configuration option did not support the tilde
   expansion (i.e. ~user/path and ~/path).

 * The completion scripts (in contrib/) did not know about quite a few
   options that are common between "git merge" and "git pull", and a
   couple of options unique to "git merge".

 * "--ignore-space-change" option of "git apply" ignored the spaces
   at the beginning of line too aggressively, which is inconsistent
   with the option of the same name "diff" and "git diff" have.

 * "git blame" miscounted number of columns needed to show localized
   timestamps, resulting in jaggy left-side-edge of the source code
   lines in its output.

 * "git blame" assigned the blame to the copy in the working-tree if
   the repository is set to core.autocrlf=3Dinput and the file used CRL=
=46
   line endings.

 * "git commit --allow-empty-message -C $commit" did not work when the
   commit did not have any log message.

 * "git diff --find-copies-harder" sometimes pretended as if the mode
   bits have changed for paths that are marked with assume-unchanged
   bit.

 * "git format-patch" did not enforce the rule that the "--follow"
   option from the log/diff family of commands must be used with
   exactly one pathspec.

 * "git gc --auto" was recently changed to run in the background to
   give control back early to the end-user sitting in front of the
   terminal, but it forgot that housekeeping involving reflogs should
   be done without other processes competing for accesses to the refs.

 * "git grep -O" to show the lines that hit in the pager did not work
   well with case insensitive search.  We now spawn "less" with its
   "-I" option when it is used as the pager (which is the default).

 * We used to disable threaded "git index-pack" on platforms without
   thread-safe pread(); use a different workaround for such
   platforms to allow threaded "git index-pack".

 * The error reporting from "git index-pack" has been improved to
   distinguish missing objects from type errors.

 * "git mailinfo" used to read beyond the end of header string while
   parsing an incoming e-mail message to extract the patch.

 * On a case insensitive filesystem, merge-recursive incorrectly
   deleted the file that is to be renamed to a name that is the same
   except for case differences.

 * "git pack-objects" unnecessarily copied the previous contents when
   extending the hashtable, even though it will populate the table
   from scratch anyway.

 * "git rerere forget" did not work well when merge.conflictstyle
   was set to a non-default value.

 * "git remote rm" and "git remote prune" can involve removing many
   refs at once, which is not a very efficient thing to do when very
   many refs exist in the packed-refs file.

 * "git log --exclude=3D<glob> --all | git shortlog" worked as expected=
,
   but "git shortlog --exclude=3D<glob> --all", which is supposed to be
   identical to the above pipeline, was not accepted at the command
   line argument parser level.

 * The autostash mode of "git rebase -i" did not restore the dirty
   working tree state if the user aborted the interactive rebase by
   emptying the insn sheet.

 * "git show -s" (i.e. show log message only) used to incorrectly emit
   an extra blank line after a merge commit.

 * "git status", even though it is a read-only operation, tries to
   update the index with refreshed lstat(2) info to optimize future
   accesses to the working tree opportunistically, but this could
   race with a "read-write" operation that modify the index while it
   is running.  Detect such a race and avoid overwriting the index.

 * "git status" (and "git commit") behaved as if changes in a modified
   submodule are not there if submodule.*.ignore configuration is set,
   which was misleading.  The configuration is only to unclutter diff
   output during the course of development, and should not to hide
   changes in the "status" output to cause the users forget to commit
   them.

 * The mode to run tests with HTTP server tests disabled was broken.

----------------------------------------------------------------

Changes since v2.0.0 are as follows:

Alexey Shumkin (5):
      t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outp=
uts
      t4041, t4205, t6006, t7102: don't hardcode tested encoding value
      t4205 (log-pretty-format): use `tformat` rather than `format`
      t4205, t6006: add tests that fail with i18n.logOutputEncoding set
      pretty.c: format string with truncate respects logOutputEncoding

David Turner (2):
      merge-recursive.c: fix case-changing merge bug
      mv: allow renaming to fix case on case insensitive filesystems

=46elipe Contreras (1):
      rerere: fix for merge.conflictstyle

Jacek Konieczny (1):
      pull: do not abuse 'break' inside a shell 'case'

Jeff King (7):
      commit: do not complain of empty messages from -C
      index-pack: distinguish missing objects from type errors
      run_diff_files: do not look at uninitialized stat data
      open_sha1_file: report "most interesting" errno
      move "--follow needs one pathspec" rule to diff_setup_done
      t5537: re-drop http tests
      update-index: fix segfault with missing --cacheinfo argument

Jens Lehmann (2):
      status/commit: show staged submodules regardless of ignore config
      commit -m: commit staged submodules regardless of ignore config

Jens Lindstr=C3=B6m (3):
      remote rm: delete remote configuration as the last
      remote: repack packed-refs once when deleting multiple refs
      remote prune: optimize "dangling symref" check/warning

Jiang Xin (2):
      blame: fix broken time_buf paddings in relative timestamp
      blame: dynamic blame_date_width for different locales

Johannes Schindelin (1):
      git grep -O -i: if the pager is 'less', pass the '-I' option

John Keeping (2):
      completion: add a note that merge options are shared
      completion: add missing options for git-merge

Junio C Hamano (5):
      apply --ignore-space-change: lines with and without leading white=
spaces do not match
      Git 1.9.4
      shortlog: allow --exclude=3D<glob> to be passed
      revision: parse "git log -<count>" more carefully
      Git 2.0.1

J=C3=B6rn Engel (1):
      pager: do allow spawning pager recursively

Matthieu Moy (1):
      rebase -i: test "Nothing to do" case with autostash

Max Kirillov (1):
      git-show: fix 'git show -s' to not add extra terminator after mer=
ge commit

Michael Naumov (1):
      sideband.c: do not use ANSI control sequence on non-terminal

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      index-pack: work around thread-unsafe pread()
      gc --auto: do not lock refs in the background

Nick Alcock (1):
      t5538: move http push tests out to t5542

Ramkumar Ramachandra (1):
      rebase -i: handle "Nothing to do" case with autostash

Ren=C3=A9 Scharfe (2):
      mailinfo: use strcmp() for string comparison
      pack-objects: use free()+xcalloc() instead of xrealloc()+memset()

Yiannis Marangos (2):
      wrapper.c: add xpread() similar to xread()
      read-cache.c: verify index file before we opportunistically updat=
e it

brian m. carlson (1):
      blame: correctly handle files regardless of autocrlf

=C3=98ystein Walle (1):
      config: respect '~' and '~user' in mailmap.file
