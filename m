From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.0.2
Date: Sun, 07 Mar 2010 14:29:03 -0800
Message-ID: <7vy6i3epg0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sun Mar 07 23:29:50 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1NoOyq-0004hD-FZ
	for glk-linux-kernel-3@lo.gmane.org; Sun, 07 Mar 2010 23:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032Ab0CGW3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 7 Mar 2010 17:29:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0CGW3Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2010 17:29:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07437A00F2;
	Sun,  7 Mar 2010 17:29:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=0FkzY+Z+G7hgRM3s1TJZ3AxYl
	xo=; b=dOLYkLcOOSVNsCZD62awMm0SbXT2uXuN+8Ueo5OqET+woEgZVkAWAsNv8
	7HAi15ggEwu84HYE6VQZdYpA2yyyXiR5wpBu7j/wL/SKl6332wJKqx1lln3pn1Lu
	PqIUQLa77zLt77dbasHEkTAdNQO3EX7uUSzabQtHq+w6VItS14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=fmErs0YI5kDeuMQ79Yy
	RnRvGvjBjRCiDbL/is/pkllZAlpHWou5f6KoVsvVqOp+i97+THuoc2ET9ElKKDdC
	zU/Vi54LS6G0hzQTPRWU1Oa+UXxwLYXsLhjM8yL3zHQeFO6EqsBmR//JKu2LtzLe
	DtuOq9l5IPbSFdgtfmdNUgIE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC0FEA00F1;
	Sun,  7 Mar 2010 17:29:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F051A00ED; Sun,  7 Mar
 2010 17:29:05 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9E439EC-2A38-11DF-8385-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141741>

The latest maintenance release Git 1.7.0.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.0.2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.0.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.0.2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.0.2-1.fc11.$arch.rpm	(RPM)

Git v1.7.0.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.0.1
--------------------

 * GIT_PAGER was not honored consistently by some scripted Porcelains, =
most
   notably "git am".

 * updating working tree files after telling git to add them to the
   index and while it is still working created garbage object files in
   the repository without diagnosing it as an error.

 * "git bisect -- pathspec..." did not diagnose an error condition prop=
erly when
   the simplification with given pathspec made the history empty.

 * "git rev-list --cherry-pick A...B" now has an obvious optimization w=
hen the
   histories haven't diverged (i.e. when one end is an ancestor of the =
other).

 * "git diff --quiet -w" did not work as expected.

 * "git fast-import" didn't work with a large input, as it lacked suppo=
rt
   for producing the pack index in v2 format.

 * "git imap-send" didn't use CRLF line endings over the imap protocol
   when storing its payload to the draft box, violating RFC 3501.

 * "git log --format=3D'%w(x,y,z)%b'" and friends that rewrap message
   has been optimized for utf-8 payload.

 * Error messages generated on the receiving end did not come back to "=
git
   push".

 * "git status" in 1.7.0 lacked the optimization we used to have in 1.6=
=2EX series
   to speed up scanning of large working tree.

 * "gitweb" did not diagnose parsing errors properly while reading tis =
configuration
   file.

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.0.1 are as follows:

Bert Wesarg (1):
      unset GREP_OPTIONS in test-lib.sh

Christian Couder (1):
      bisect: error out when passing bad path parameters

Dmitry Potapov (1):
      hash-object: don't use mmap() for small files

Erik Faye-Lund (1):
      run-command: support custom fd-set in async

Gabriel Filion (1):
      require_work_tree broken with NONGIT_OK

Hitoshi Mitake (1):
      git-imap-send: Convert LF to CRLF before storing patch to draft b=
ox

Jakub Narebski (2):
      gitweb: Die if there are parsing errors in config file
      gitweb: Fix project-specific feature override behavior

Jonathan Nieder (8):
      Fix 'git var' usage synopsis
      Make 'git var GIT_PAGER' always print the configured pager
      git.1: Clarify the behavior of the --paginate option
      git svn: Fix launching of pager
      am: Fix launching of pager
      tests: Add tests for automatic use of pager
      t7006-pager: if stdout is not a terminal, make a new one
      tests: Fix race condition in t7006-pager

Junio C Hamano (6):
      t6000lib: Fix permission
      lib-patch-mode.sh: Fix permission
      status: preload index to optimize lstat(2) calls
      Start preparing for 1.7.0.2
      Update draft release notes to 1.7.0.2
      Git 1.7.0.2

Larry D'Anna (2):
      git diff --quiet -w: check and report the status
      git-diff: add a test for git diff --quiet -w

Matthieu Moy (1):
      stash: suggest the correct command line for unknown options.

Michal Sojka (1):
      Remove extra '-' from git-am(1)

Nicolas Pitre (8):
      fast-import: start using struct pack_idx_entry
      fast-import: use sha1write() for pack data
      fast-import: use write_idx_file() instead of custom code
      fast-import: make default pack size unlimited
      fast-import: honor pack.indexversion and pack.packsizelimit confi=
g vars
      fast-import: use the diff_delta() max_delta_size argument
      sha1_file: don't malloc the whole compressed result when writing =
out objects
      sha1_file: be paranoid when creating loose objects

Ren=C3=A9 Scharfe (4):
      utf8.c: remove print_wrapped_text()
      utf8.c: remove print_spaces()
      utf8.c: remove strbuf_write()
      utf8.c: speculatively assume utf-8 in strbuf_add_wrapped_text()

Shawn O. Pearce (7):
      run-command: Allow stderr to be a caller supplied pipe
      send-pack: demultiplex a sideband stream with status data
      receive-pack: Refactor how capabilities are shown to the client
      receive-pack: Wrap status reports inside side-band-64k
      receive-pack: Send hook output over side band #2
      t5401: Use a bare repository for the remote peer
      receive-pack: Send internal errors over side-band #2

Stephen Boyd (1):
      t7406: Fix submodule init config tests

Sylvain Rabot (1):
      gitweb multiple project roots documentation

Tay Ray Chuan (1):
      transport: add got_remote_refs flag

Thomas Rast (1):
      cherry_pick_list: quit early if one side is empty
