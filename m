From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.12-rc2
Date: Tue, 07 Aug 2012 11:40:40 -0700
Message-ID: <7vzk66v93r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Aug 07 20:41:09 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SyoiJ-0001bd-GB
	for glk-linux-kernel-3@plane.gmane.org; Tue, 07 Aug 2012 20:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152Ab2HGSkt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 7 Aug 2012 14:40:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390Ab2HGSko convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Aug 2012 14:40:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29E18963F;
	Tue,  7 Aug 2012 14:40:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=qGiB0C61HUkVRUy54WmQRqXgi
	pw=; b=biTpPGu8PnKhHYsivcbMfv6LWVXvy/TqHhCOXRBwTRoNbnq61XgIvc9FN
	7BGP1vIfk6ZIaz9407N9iZMTJuLMBKLHIvnIlFJO0G3gOoZaV29CfniYNrGVwYvS
	XQj+njDV+y4adygCBDhYCvR2XB7cu7rDAWyRg/5J/0CJdT3kUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=NicDgHREsD23bF0Xc9s
	Onp9QTrudAwSF8+kCtvFYzm+jAjyTik0wC7CxSWjr69FEHyb9kx83T/uUGCv3U6M
	bl1dzR4plS8bv+iCbNrnNzET38Huh/H3AXOQxAsHHZEARAXFRz/S7HF8eXQaeRhX
	5ZPkrmuYJpUX2/FDJj8C8ip4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 172F1963E;
	Tue,  7 Aug 2012 14:40:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14EF5963D; Tue,  7 Aug 2012
 14:40:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 641EC566-E0BF-11E1-8300-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203034>

A release candidate Git v1.7.12-rc2 is now available for testing
at the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

f05297c883b958d04c00a7aba8f234261efd8844  git-1.7.12.rc2.tar.gz
931259a22e9d126c5c48deea0cbfeef246f93058  git-htmldocs-1.7.12.rc2.tar.g=
z
2262b31399f519b166f045f6aa63c8ec7e4ee515  git-manpages-1.7.12.rc2.tar.g=
z

Also the following public repositories all have a copy of the v1.7.12-r=
c2
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.12 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Updates since v1.7.11
---------------------

UI, Workflows & Features

 * Git can be told to normalize pathnames it read from readdir(3) and
   all arguments it got from the command line into precomposed UTF-8
   (assuming that they come as decomposed UTF-8), in order to work
   around issues on Mac OS.

   I think there still are other places that need conversion
   (e.g. paths that are read from stdin for some commands), but this
   should be a good first step in the right direction.

 * Per-user $HOME/.gitconfig file can optionally be stored in
   $HOME/.config/git/config instead, which is in line with XDG.

 * The value of core.attributesfile and core.excludesfile default to
   $HOME/.config/git/attributes and $HOME/.config/git/ignore respective=
ly
   when these files exist.

 * Logic to disambiguate abbreviated object names have been taught to
   take advantage of object types that are expected in the context,
   e.g. XXXXXX in the "git describe" output v1.2.3-gXXXXXX must be a
   commit object, not a blob nor a tree.  This will help us prolong
   the lifetime of abbreviated object names.

 * "git apply" learned to wiggle the base version and perform three-way
   merge when a patch does not exactly apply to the version you have.

 * Scripted Porcelain writers now have access to the credential API via
   the "git credential" plumbing command.

 * "git help" used to always default to "man" format even on platforms
   where "man" viewer is not widely available.

 * "git clone --local $path" started its life as an experiment to
   optionally use link/copy when cloning a repository on the disk, but
   we didn't deprecate it after we made the option a no-op to always
   use the optimization.  The command learned "--no-local" option to
   turn this off, as a more explicit alternative over use of file://
   URL.

 * "git fetch" and friends used to say "remote side hung up
   unexpectedly" when they failed to get response they expect from the
   other side, but one common reason why they don't get expected
   response is that the remote repository does not exist or cannot be
   read. The error message in this case was updated to give better
   hints to the user.

 * "git help -w $cmd" can show HTML version of documentation for
   "git-$cmd" by setting help.htmlpath to somewhere other than the
   default location where the build procedure installs them locally;
   the variable can even point at a http:// URL.

 * "git rebase [-i] --root $tip" can now be used to rewrite all the
   history leading to "$tip" down to the root commit.

 * "git rebase -i" learned "-x <cmd>" to insert "exec <cmd>" after
   each commit in the resulting history.

 * "git status" gives finer classification to various states of paths
   in conflicted state and offer advice messages in its output.

 * "git submodule" learned to deal with nested submodule structure
   where a module is contained within a module whose origin is
   specified as a relative URL to its superproject's origin.

 * A rather heavy-ish "git completion" script has been split to create
   a separate "git prompting" script, to help lazy-autoloading of the
   completion part while making prompting part always available.

 * "gitweb" pays attention to various forms of credits that are
   similar to "Signed-off-by:" lines in the commit objects and
   highlights them accordingly.


=46oreign Interface

 * "mediawiki" remote helper (in contrib/) learned to handle file
   attachments.

 * "git p4" now uses "Jobs:" and "p4 move" when appropriate.

 * vcs-svn has been updated to clean-up compilation, lift 32-bit
   limitations, etc.


Performance, Internal Implementation, etc. (please report possible regr=
essions)

 * Some tests showed false failures caused by a bug in ecryptofs.

 * We no longer use AsciiDoc7 syntax in our documentation and favor a
   more modern style.

 * "git am --rebasing" codepath was taught to grab authorship, log
   message and the patch text directly out of existing commits.  This
   will help rebasing commits that have confusing "diff" output in
   their log messages.

 * "git index-pack" and "git pack-objects" use streaming API to read
   from the object store to avoid having to hold a large blob object
   in-core while they are doing their thing.

 * Code to match paths with exclude patterns learned to avoid calling
   fnmatch() by comparing fixed leading substring literally when
   possible.

 * "git log -n 1 -- rarely-touched-path" was spending unnecessary
   cycles after showing the first change to find the next one, only to
   discard it.

 * "git svn" got a large-looking code reorganization at the last
   minute before the code freeze.

Also contains minor documentation updates and code clean-ups.


=46ixes since v1.7.11
-------------------

Unless otherwise noted, all the fixes since v1.7.11 in the maintenance
releases are contained in this release (see release notes to them for
details).

 * "git grep" stopped spawning an external "grep" long time ago, but a
   duplicated test to check internal and external "grep" was left
   behind.
   (merge 4ca9453 rj/maint-grep-remove-redundant-test later to maint).

 * The code to avoid mistaken attempt to add the object directory
   itself as its own alternate could read beyond end of a string while
   comparison.
   (merge cb2912c hv/link-alt-odb-entry later to maint).

 * "git submodule add" was confused when the superproject did not have
   its repository in its usual place in the working tree and GIT_DIR
   and GIT_WORK_TREE was used to access it.

 * "git commit --amend" let the user edit the log message and then died
   when the human-readable committer name was given insufficiently by
   getpwent(3).

----------------------------------------------------------------

Changes since v1.7.12-rc1 are as follows:

Jiang Xin (11):
      i18n: New keywords for xgettext extraction from sh
      i18n: rebase: mark messages for translation
      i18n: Rewrite gettext messages start with dash
      rebase: remove obsolete and unused LONG_USAGE which breaks xgette=
xt
      i18n: am: mark more strings for translation
      Remove dead code which contains bad gettext block
      i18n: merge-recursive: mark strings for translation
      l10n: Update git.pot (4 new, 3 removed messages)
      l10n: zh_CN.po: translate 4 new messages
      l10n: Update git.pot (76 new, 4 removed messages)
      l10n: zh_CN.po: translate 76 new messages

Johannes Sixt (1):
      Makefile: use overridable $(FIND) instead of hard-coded 'find'

Junio C Hamano (3):
      Prepare for 1.7.11.5
      Drop 1.7.11.x items from 1.7.12 release notes
      Git 1.7.12-rc2

Matthieu Moy (1):
      git-remote-mediawiki: replace TODO-list in comment by appropriate=
 link

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      i18n: leave \n out of translated diffstat

Ralf Thielow (3):
      l10n: de.po: translate 4 new messages
      git-rebase.sh: fix typo in an error message
      merge-recursive: separate message for common ancestors

Tran Ngoc Quan (2):
      l10n: vi.po: translate 4 new messages
      l10n: vi.po update to follow POT in 3b613

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec (1):
      doc: A few minor copy edits.
