From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.9.2
Date: Wed, 09 Apr 2014 14:59:12 -0700
Message-ID: <xmqqd2gqyxjj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 00:01:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WY0YF-0005L6-Hm
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 00:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbaDIV7p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2014 17:59:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934367AbaDIV7n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2014 17:59:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9E9E7BECD;
	Wed,  9 Apr 2014 17:59:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=fu168aAI9bw1+AvWC5kVj5IlW
	u4=; b=YBU+V720XV6liL87WDNor7arJKiLccjAsQ2sFLTprnvxkbxtKf7ph3UKh
	SQUGs2gadeWBJ0EdX5LxKxxlHqbaCq+PTI2vbG1FUryQdbSshxFxKEuqw6elOdC2
	uPFNs6+YQVdun0nBV3KTttWau30HUBrBIWTJ6zyBHUMFZP8LAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=lF6qCAksB1Css0H9bWG
	OTQ98xB3W5ghoy/Gyas6cJN/6PvWm289pCkaRf1RZqKivTh2biSdodHjuJJsXQOb
	Xz9I+8i5oEJ9HPAsHVWO8qxN5sPpLQeFDqlmwzzztUXoIdpj7lXRhyLQeC9EP0LK
	VbGh5ZfrDIAtSF3tpFm3gVQA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B41617BECC;
	Wed,  9 Apr 2014 17:59:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7E117BE90;
	Wed,  9 Apr 2014 17:59:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3020A820-C032-11E3-84CA-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245999>

The latest maintenance release Git v1.9.2 is now available at
the usual places.

The release tarballs are found at:

    http://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the v1.9.2
tag and the maint branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

The http://code.google.com/p/git-core/downloads/ site no longer
accepts new tarballs for download; while the older release tarballs
are still there, this one (and future ones) will not be.


Git v1.9.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v1.9.1
------------------

 * Documentation and in-code comments had many instances of mistaken
   use of "nor", which have been corrected.

 * "git fetch --prune", when the right-hand-side of multiple fetch
   refspecs overlap (e.g. storing "refs/heads/*" to
   "refs/remotes/origin/*", while storing "refs/frotz/*" to
   "refs/remotes/origin/fr/*"), aggressively thought that lack of
   "refs/heads/fr/otz" on the origin site meant we should remove
   "refs/remotes/origin/fr/otz" from us, without checking their
   "refs/frotz/otz" first.

   Note that such a configuration is inherently unsafe (think what
   should happen when "refs/heads/fr/otz" does appear on the origin
   site), but that is not a reason not to be extra careful.

 * "git update-ref --stdin" did not fail a request to create a ref
   when the ref already existed.

 * "git diff --no-index -Mq a b" fell into an infinite loop.

 * When it is not necessary to edit a commit log message (e.g. "git
   commit -m" is given a message without specifying "-e"), we used to
   disable the spawning of the editor by overriding GIT_EDITOR, but
   this means all the uses of the editor, other than to edit the
   commit log message, are also affected.

 * "git status --porcelain --branch" showed its output with labels
   "ahead/behind/gone" translated to the user's locale.

 * "git mv" that moves a submodule forgot to adjust the array that
   uses to keep track of which submodules were to be moved to update
   its configuration.

 * Length limit for the pathname used when removing a path in a deep
   subdirectory has been removed to avoid buffer overflows.

 * The test helper lib-terminal always run an actual test_expect_*
   when included, which screwed up with the use of skil-all that may
   have to be done later.

 * "git index-pack" used a wrong variable to name the keep-file in an
   error message when the file cannot be written or closed.

 * "rebase -i" produced a broken insn sheet when the title of a commit
   happened to contain '\n' (or ended with '\c') due to a careless use
   of 'echo'.

 * There were a few instances of 'git-foo' remaining in the
   documentation that should have been spelled 'git foo'.

 * Serving objects from a shallow repository needs to write a
   new file to hold the temporary shallow boundaries but it was not
   cleaned when we exit due to die() or a signal.

 * When "git stash pop" stops after failing to apply the stash
   (e.g. due to conflicting changes), the stash is not dropped. State
   that explicitly in the output to let the users know.

 * The labels in "git status" output that describe the nature of
   conflicts (e.g. "both deleted") were limited to 20 bytes, which was
   too short for some l10n (e.g. fr).

----------------------------------------------------------------

Changes since v1.9.1 are as follows:

Aman Gupta (1):
      update-ref: fail create operation over stdin if ref already exist=
s

Benoit Pierre (7):
      merge hook tests: fix missing '&&' in test
      merge hook tests: use 'test_must_fail' instead of '!'
      test patch hunk editing with "commit -p -m"
      commit: fix patch hunk editing with "commit -p -m"
      merge: fix GIT_EDITOR override for commit hook
      merge hook tests: fix and update tests
      run-command: mark run_hook_with_custom_index as deprecated

Carlos Mart=C3=ADn Nieto (2):
      fetch: add a failing test for prunning with overlapping refspecs
      fetch: handle overlaping refspecs on --prune

Jeff King (6):
      shallow: use stat_validity to check for up-to-date file
      shallow: automatically clean up shallow tempfiles
      t/lib-terminal: make TTY a lazy prerequisite
      shallow: verify shallow file after taking lock
      date: recognize bogus FreeBSD gmtime output
      t4212: loosen far-in-future test for AIX

John Keeping (1):
      builtin/mv: fix out of bounds write

Jonathan Nieder (2):
      wt-status: extract the code to compute width for labels
      wt-status: i18n of section labels

Junio C Hamano (8):
      stash pop: mention we did not drop the stash upon failing to appl=
y
      wt-status: make full label string to be subject to l10n
      wt-status: lift the artificual "at least 20 columns" floor
      index-pack: report error using the correct variable
      diff-no-index: correctly diagnose error return from diff_opt_pars=
e()
      Start preparing for 1.9.1
      Update draft release notes to 1.9.2
      Git 1.9.2

Justin Lebar (4):
      Documentation: fix misuses of "nor"
      contrib: fix misuses of "nor"
      comments: fix misuses of "nor"
      code and test: fix misuses of "nor"

Matthieu Moy (1):
      status: disable translation when --porcelain is used

Michael Haggerty (2):
      checkout_entry(): use the strbuf throughout the function
      entry.c: fix possible buffer overflow in remove_subtree()

Ramkumar Ramachandra (1):
      Documentation/merge-strategies: avoid hyphenated commands

Thomas Ackermann (1):
      doc/http-backend: missing accent grave in literal mark-up

Uwe Storbeck (2):
      rebase -i: do not "echo" random user-supplied strings
      test-lib.sh: do not "echo" caller-supplied strings

brian m. carlson (1):
      mv: prevent mismatched data when ignoring errors.
