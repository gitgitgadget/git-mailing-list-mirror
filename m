From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.12.2
Date: Sun, 30 Sep 2012 01:38:12 -0700
Message-ID: <7vy5jrgb2j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sun Sep 30 10:38:41 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TIF2u-0001j8-FW
	for glk-linux-kernel-3@plane.gmane.org; Sun, 30 Sep 2012 10:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571Ab2I3Ii1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 30 Sep 2012 04:38:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab2I3IiQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Sep 2012 04:38:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AF0041EC;
	Sun, 30 Sep 2012 04:38:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=2wViw1PjCYFAz8pyAKc0vL/Yq
	S0=; b=Z1iMXz6167KjYKF3fSzd0k7Fe2szeYT9HU/EiPDEy5zAwKbDswn76df+S
	vmQPjRubwwuXo+FMQvv3VtltpbtQN2F8Ox4dM50wh87Hi2/i5lSgg4vJBmRn5B+n
	7ufcvfxymePEVv9fdsCEwwVynMdkSb+DGVft93wUbfMz+/7aYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=BG5upnvDijcfJylndaZ
	LyddwRCVLAGZj/kwqDytHJ8hnce34zfMFpoBptbktcDKEtaKpzK7EZ+7JoVDcMVn
	Qpj7oF2ZohISqag4vaQfrGrCEgZORMvkOJ2AsfKH0urc1ba6l1JOsYAH2jrC8bR5
	CD6Q9HbHhhqx1eRQVnKlIrxw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1928B41EB;
	Sun, 30 Sep 2012 04:38:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48CF341EA; Sun, 30 Sep 2012
 04:38:14 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CAA932C-0ADA-11E2-9BBD-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206685>

The latest maintenance release Git v1.7.12.2 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

277b759139ddb62c6935da37de8a483e2c234a97  git-1.7.12.2.tar.gz
5722156394c7478b2339a1d87aa894bc4d2f5d6b  git-htmldocs-1.7.12.2.tar.gz
8cf6fd255e83226b4abcdcd68dcf315c1995fd92  git-manpages-1.7.12.2.tar.gz

Also the following public repositories all have a copy of the v1.7.12.2
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git 1.7.12.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.12.1
---------------------

 * When "git am" is fed an input that has multiple "Content-type: ..."
   header, it did not grok charset=3D attribute correctly.

 * Even during a conflicted merge, "git blame $path" always meant to
   blame uncommitted changes to the "working tree" version; make it
   more useful by showing cleanly merged parts as coming from the other
   branch that is being merged.

 * "git blame MAKEFILE" run in a history that has "Makefile" but not
   "MAKEFILE" should say "No such file MAKEFILE in HEAD", but got
   confused on a case insensitive filesystem and failed to do so.

 * "git fetch --all", when passed "--no-tags", did not honor the
   "--no-tags" option while fetching from individual remotes (the same
   issue existed with "--tags", but combination "--all --tags" makes
   much less sense than "--all --no-tags").

 * "git log/diff/format-patch --stat" showed the "N line(s) added"
   comment in user's locale and caused careless submitters to send
   patches with such a line in them to projects whose project language
   is not their language, mildly irritating others. Localization to
   the line has been disabled for now.

 * "git log --all-match --grep=3DA --grep=3DB" ought to show commits th=
at
   mention both A and B, but when these three options are used with
   --author or --committer, it showed commits that mention either A or
   B (or both) instead.

 * The subcommand to remove the definition of a remote in "git remote"
   was named "rm" even though all other subcommands were spelled out.
   Introduce "git remote remove" to remove confusion, and keep "rm" as
   a backward compatible synonym.

Also contains a handful of documentation updates.

----------------------------------------------------------------

Changes since v1.7.12.1 are as follows:

Dan Johnson (1):
      fetch --all: pass --tags/--no-tags through to each remote

David Gould (1):
      run-command.c: fix broken list iteration in clear_child_for_clean=
up

=46elipe Contreras (1):
      completion: fix shell expansion of items

Jeff King (4):
      argv-array: add pop function
      argv-array: fix bogus cast when freeing array
      fetch: use argv_array instead of hand-building arrays
      Revert "completion: fix shell expansion of items"

Jens Lehmann (1):
      submodule: use argv_array instead of hand-building arrays

Jeremy White (1):
      Documentation: describe subject more precisely

Jonathan "Duke" Leto (1):
      Improve the description of GIT_PS1_SHOWUPSTREAM

Junio C Hamano (11):
      mailinfo: strip "RE: " prefix
      blame $path: avoid getting fooled by case insensitive filesystems
      blame: allow "blame file" in the middle of a conflicted merge
      grep: teach --debug option to dump the parse tree
      log --grep/--author: honor --all-match honored for multiple --gre=
p patterns
      log: document use of multiple commit limiting options
      grep.c: mark private file-scope symbols as static
      mailinfo: do not concatenate charset=3D attribute values from mim=
e headers
      grep.c: make two symbols really file-scope static this time
      Start preparation for 1.7.12.2
      Git 1.7.12.2

Michael J Gruber (6):
      grep: show --debug output only once
      t7810-grep: bring log --grep tests in common form
      t7810-grep: test multiple --grep with and without --all-match
      t7810-grep: test multiple --author with --all-match
      t7810-grep: test interaction of multiple --grep and --author opti=
ons
      t7810-grep: test --all-match with multiple --grep and --author op=
tions

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
      remote: prefer subcommand name 'remove' to 'rm'
      doc: move rev-list option -<n> from git-log.txt to rev-list-optio=
ns.txt
      Revert diffstat back to English

Ralf Thielow (1):
      l10n: de.po: correct translation of a 'rebase' message

Stefan Naewe (1):
      ls-remote: document the '--get-url' option

Stephen Boyd (1):
      Documentation: Document signature showing options

Thynson (2):
      l10n: Unify the translation for '(un)expected'
      l10n: Improve many translation for zh_CN
