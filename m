From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.2.4
Date: Sun, 19 Apr 2009 21:42:10 -0700
Message-ID: <7v4owklyvx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 06:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvlMN-0007ZY-Pi
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 06:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbZDTEmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 00:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbZDTEmV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 00:42:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbZDTEmT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 00:42:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E017107E4;
	Mon, 20 Apr 2009 00:42:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8A016107E0; Mon,
 20 Apr 2009 00:42:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A127A3A8-2D65-11DE-848E-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116934>

The latest maintenance release GIT 1.6.2.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.2.4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.2.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.2.4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.2.4-1.fc9.$arch.rpm	(RPM)

This contains bunch of fixes that have already been merged to the maste=
r
branch in preparation for 1.6.3.

----------------------------------------------------------------

GIT v1.6.2.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.2.3
--------------------

* The configuration parser had a buffer overflow while parsing an overl=
ong
  value.

* pruning reflog entries that are unreachable from the tip of the ref
  during "git reflog prune" (hence "git gc") was very inefficient.

* "git-add -p" lacked a way to say "q"uit to refuse staging any hunks f=
or
  the remaining paths.  You had to say "d" and then ^C.

* "git-checkout <tree-ish> <submodule>" did not update the index entry =
at
  the named path; it now does.

* "git-fast-export" choked when seeing a tag that does not point at com=
mit.

* "git init" segfaulted when given an overlong template location via
  the --template=3D option.

* "git-ls-tree" and "git-diff-tree" used a pathspec correctly when
  deciding to descend into a subdirectory but they did not match the
  individual paths correctly.  This caused pathspecs "abc/d ab" to matc=
h
  "abc/0" ("abc/d" made them decide to descend into the directory "abc/=
",
  and then "ab" incorrectly matched "abc/0" when it shouldn't).

* "git-merge-recursive" was broken when a submodule entry was involved =
in
  a criss-cross merge situation.

Many small documentation updates are included as well.

----------------------------------------------------------------

Changes since v1.6.2.3 are as follows:

Bj=C3=B6rn Steinbrink (1):
      tree_entry_interesting: a pathspec only matches at directory boun=
dary

Clemens Buchacher (3):
      add tests for merging with submodules
      update cache for conflicting submodule entries
      simplify output of conflicting merge

Erik Faye-Lund (4):
      test-suite: adding a test for fast-export with tag variants
      builtin-fast-export.c: turn error into warning
      builtin-fast-export.c: fix crash on tagged trees
      builtin-fast-export.c: handle nested tags

=46rank Lichtenheld (1):
      init: Do not segfault on big GIT_TEMPLATE_DIR environment variabl=
e

Jeff King (2):
      doc/gitattributes: clarify location of config text
      add-interactive: refactor mode hunk handling

Johan Herland (1):
      Update docs on behaviour of 'core.sharedRepository' and 'git init=
 --shared'

Johannes Schindelin (1):
      Fix 'git checkout <submodule>' to update the index

Johannes Sixt (1):
      t1301-shared-repo: fix forced modes test

Junio C Hamano (3):
      match_tree_entry(): a pathspec only matches at directory boundari=
es
      Describe fixes since 1.6.2.3
      GIT 1.6.2.4

Junio Hamano (1):
      Speed up reflog pruning of unreachable commits

Linus Torvalds (1):
      Clean up reflog unreachability pruning decision

Markus Heidelberg (2):
      doc/git-daemon: add missing arguments to options
      doc/git-daemon: add missing arguments to max-connections option

Matthieu Moy (2):
      git add -p: new "quit" command at the prompt.
      Update git-add.txt according to the new possibilities of 'git add=
 -p'.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      Makefile: remove {fetch,send}-pack from PROGRAMS as they are buil=
tins

Paul Bolle (1):
      imap-send: use correct configuration variable in documentation

Thomas Jarosch (1):
      Fix buffer overflow in config parser

Ulrich Windl (1):
      git-apply: fix option description
