From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.0.3
Date: Sun, 04 Mar 2007 19:17:11 -0800
Message-ID: <7vlkic2xc8.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwt2ec32p.fsf@assigned-by-dhcp.cox.net>
	<7vabz0j7td.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752616AbXCEDRO@vger.kernel.org Mon Mar 05 04:18:10 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752616AbXCEDRO@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO3iA-0007oZ-49
	for glk-linux-kernel-3@gmane.org; Mon, 05 Mar 2007 04:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbXCEDRO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 4 Mar 2007 22:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbXCEDRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Mar 2007 22:17:14 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48957 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbXCEDRN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Mar 2007 22:17:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305031712.UWUH1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 4 Mar 2007 22:17:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WrHC1W0011kojtg0000000; Sun, 04 Mar 2007 22:17:12 -0500
In-Reply-To: <7vabz0j7td.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 27 Feb 2007 00:58:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41398>

The latest maintenance release GIT 1.5.0.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.0.3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.0.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.0.3.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.0.3-1.$arch.rpm	(RPM)

GIT v1.5.0.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.0.2
--------------------

* Bugfixes

  - 'git.el' honors the commit coding system from the configuration.

  - 'blameview' in contrib/ correctly digs deeper when a line is
    clicked.

  - 'http-push' correctly makes sure the remote side has leading
    path.  Earlier it started in the middle of the path, and
    incorrectly.

  - 'git-merge' did not exit with non-zero status when the
    working tree was dirty and cannot fast forward.  It does
    now.

  - 'cvsexportcommit' does not lose yet-to-be-used message file.

  - int-vs-size_t typefix when running combined diff on files
    over 2GB long.

  - 'git apply --whitespace=3Dstrip' should not touch unmodified
    lines.

  - 'git-mailinfo' choke when a logical header line was too long.

  - 'git show A..B' did not error out.  Negative ref ("not A" in
    this example) does not make sense for the purpose of the
    command, so now it errors out.

  - 'git fmt-merge-msg --file' without file parameter did not
    correctly error out.

  - 'git archimport' barfed upon encountering a commit without
    summary.

  - 'git index-pack' did not protect itself from getting a short
    read out of pread(2).

  - 'git http-push' had a few buffer overruns.

  - Build dependency fixes to rebuild fetch.o when other headers
    change.

* Documentation updates

  - user-manual updates.

  - Options to 'git remote add' were described insufficiently.

  - Configuration format.suffix was not documented.

  - Other formatting and spelling fixes.


----------------------------------------------------------------

Shortlog since v1.5.0.2
-----------------------

Alexandre Julliard (1):
      git.el: Set the default commit coding system from the repository =
config.

Aneesh Kumar K.V (1):
      blameview: Fix the browse behavior in blameview

Christian Schlotter (1):
      Documentation: Correct minor typo in git-add documentation.

Eygene Ryabinkin (2):
      http-push.c::lock_remote(): validate all remote refs.
      Another memory overrun in http-push.c

Gerrit Pape (2):
      git-cvsexportcommit: don't cleanup .msg if not yet committed to c=
vs.
      Fix quoting in update hook template

J. Bruce Fields (6):
      Documentation: mention module option to git-cvsimport
      user-manual: reset to ORIG_HEAD not HEAD to undo merge
      user-manual: ensure generated manual references stylesheet
      user-manual: insert earlier of mention content-addressable archit=
ecture
      user-manual: how to replace commits older than most recent
      user-manual: more detailed merge discussion

Jim Meyering (1):
      diff --cc: integer overflow given a 2GB-or-larger file

Johannes Schindelin (3):
      fetch.o depends on the headers, too.
      builtin-archive: use RUN_SETUP
      Document the config variable format.suffix

Junio C Hamano (5):
      git-apply: do not fix whitespaces on context lines.
      Documentation: git-remote add [-t <branch>] [-m <branch>] [-f] na=
me url
      Start preparing Release Notes for 1.5.0.3
      git-merge: fail correctly when we cannot fast forward.
      GIT 1.5.0.3

Linus Torvalds (2):
      mailinfo: do not get confused with logical lines that are too lon=
g.
      git-show: Reject native ref

Matthias Kestenholz (1):
      Fix git-gc usage note

Michael Coleman (2):
      Fix minor typos/grammar in user-manual.txt
      builtin-fmt-merge-msg: fix bugs in --file option

Michael Poole (1):
      Correct ordering in git-cvsimport's option documentation

Paolo Bonzini (1):
      git-archimport: support empty summaries, put summary on a single =
line.

Ramsay Allan Jones (5):
      Fix a "label defined but unreferenced" warning.
      Fix an "implicit function definition" warning.
      Fix some "comparison is always true/false" warnings.
      Fix a "pointer type missmatch" warning.
      Unset NO_C99_FORMAT on Cygwin.

Sergey Vlasov (3):
      Documentation/build-docdep.perl: Fix dependencies for included as=
ciidoc files
      Documentation/git-quiltimport.txt: Fix labeled list formatting
      Documentation/git-send-email.txt: Fix labeled list formatting

Shawn O. Pearce (1):
      index-pack: Loop over pread until data loading is complete.

Theodore Ts'o (1):
      Fix git-show man page formatting in the EXAMPLES section

Uwe Kleine-K=C3=B6nig (1):
      Include config.mak in doc/Makefile

Yasushi SHOJI (1):
      glossary: Add definitions for dangling and unreachable objects
