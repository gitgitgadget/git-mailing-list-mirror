From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.3.4
Date: Wed, 29 Jul 2009 01:46:17 -0700
Message-ID: <7vhbwvx4fa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752961AbZG2Iqa@vger.kernel.org Wed Jul 29 10:46:47 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752961AbZG2Iqa@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4oA-0001k2-Gr
	for glk-linux-kernel-3@gmane.org; Wed, 29 Jul 2009 10:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbZG2Iqa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 29 Jul 2009 04:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbZG2Iqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jul 2009 04:46:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbZG2Iq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jul 2009 04:46:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8836318D1C;
	Wed, 29 Jul 2009 04:46:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2FA7A18D13; Wed,
 29 Jul 2009 04:46:19 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C155738-7C1C-11DE-827D-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124328>

The latest maintenance release GIT 1.6.3.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.3.4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.3.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.3.4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.3.4-1.fc9.$arch.rpm	(RPM)

This is primarily to flush accumulated fixes on the 'maint' branch
before going forward with 1.6.4 series.

GIT v1.6.3.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.3.3
--------------------

 * "git add --no-ignore-errors" did not override configured
   add.ignore-errors configuration.

 * "git apply --whitespace=3Dfix" did not fix trailing whitespace on an
   incomplete line.

 * "git branch" opened too many commit objects unnecessarily.

 * "git checkout -f $commit" with a path that is a file (or a symlink) =
in
   the work tree to a commit that has a directory at the path issued an
   unnecessary error message.

 * "git diff -c/--cc" was very inefficient in coalescing the removed li=
nes
   shared between parents.

 * "git diff -c/--cc" showed removed lines at the beginning of a file
   incorrectly.

 * "git remote show nickname" did not honor configured
   remote.nickname.uploadpack when inspecting the branches at the remot=
e.

 * "git request-pull" when talking to the terminal for a preview
   showed some of the output in the pager.

 * "git request-pull start nickname [end]" did not honor configured
   remote.nickname.uploadpack when it ran git-ls-remote against the rem=
ote
   repository to learn the current tip of branches.

Includes other documentation updates and minor fixes.

----------------------------------------------------------------

Changes since v1.6.3.3 are as follows:

Brandon Casey (2):
      refs.c: release file descriptor on error return
      sha1_name.c: avoid unnecessary strbuf_release

Chris Frey (1):
      git-remote: fix missing .uploadpack usage for show command

Clemens Buchacher (1):
      fetch: do not create ref from empty name

Giuseppe Bilotta (1):
      gitweb/README: fix AliasMatch in example

Johannes Sixt (2):
      t3700-add: add a POSIXPERM prerequisite to a new test
      Makefile: git.o depends on library headers

Junio C Hamano (9):
      request-pull: really disable pager
      checkout -f: deal with a D/F conflict entry correctly
      combine-diff.c: fix performance problem when folding common delet=
ed lines
      diff --cc: a lost line at the beginning of the file is shown inco=
rrectly
      do_one_ref(): null_sha1 check is not about broken ref
      SunOS grep does not understand -C<n> nor -e
      Fix severe breakage in "git-apply --whitespace=3Dfix"
      t8005: Nobody writes Russian in shift_jis
      GIT 1.6.3.4

Linus Torvalds (3):
      git branch: fix performance problem
      git branch: avoid unnecessary object lookups
      git branch: clean up detached branch handling

Matthias Andree (1):
      Fix export_marks() error handling.

Michal Marek (1):
      request-pull: really really disable pager

Miklos Vajna (1):
      git-submodule documentation: fix foreach example

Ren=C3=A9 Scharfe (1):
      attr: plug minor memory leak

Roel Kluin (1):
      fread does not return negative on error

SZEDER G=C3=A1bor (1):
      Trailing whitespace and no newline fix

Sitaram Chamarty (1):
      Documentation: update description of shell aliases

Stephen Boyd (2):
      add: allow configurations to be overriden by command line
      config.txt: document add.ignore-errors

Thadeu Lima de Souza Cascardo (1):
      Makes some cleanup/review in gittutorial

Thomas Rast (2):
      Test git archive --remote
      Test grep --and/--or/--not

Tom Grennan (1):
      request-pull: allow ls-remote to notice remote.$nickname.uploadpa=
ck
