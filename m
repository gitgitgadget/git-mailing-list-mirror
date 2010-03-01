From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.0.1
Date: Mon, 01 Mar 2010 01:08:27 -0800
Message-ID: <7vfx4kxvck.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 01 10:08:56 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Nm1cV-00038O-HU
	for glk-linux-kernel-3@lo.gmane.org; Mon, 01 Mar 2010 10:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021Ab0CAJIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 1 Mar 2010 04:08:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab0CAJIj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2010 04:08:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D14CC9D79A;
	Mon,  1 Mar 2010 04:08:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=k6CLAdPT5C/rDY9+v7VJot73l
	60=; b=See1DAlHwQsqwuz9q0uCBxTs/uBxJCocjjTjixWNqOqU5R26xj/QZqQMJ
	D3VhHk24BLwHj9PAJVPCcmoWjZ49WDn+AhHZxAkXQ1OK11z4+Tvo1xLhA+RsewEQ
	yaEWm9gWtcECPlHjX63Rr2nTYfdDPdHsXCEsFyTWYntkMrLRHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=RkYBUmCVyGb++WnT/ul
	1SamBQwkrEr2bxh7HctbwRnn7BzEQEjjl+/GpgIwQfKE0C+t1UsViNfDh1fXddoS
	pcdc7ZUGdSc1Xckqrq2OOXpDP3l5ov4HWjYapvZwMZrGWFAVbTyk1XB1JV+xPWqk
	VSoPmOSEr2XPlf6TY4LFL9Do=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DF979D798;
	Mon,  1 Mar 2010 04:08:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01FAF9D792; Mon,  1 Mar
 2010 04:08:28 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03A48C36-2512-11DF-AE2B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141308>

The latest maintenance release Git 1.7.0.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.0.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.0.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.0.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.0.1-1.fc11.$arch.rpm	(RPM)

Git v1.7.0.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.0
------------------

 * In a freshly created repository "rev-parse HEAD^0" complained that
   it is dangling symref, even though "rev-parse HEAD" didn't.

 * "git show :no-such-name" tried to access the index without bounds
   check, leading to a potential segfault.

 * Message from "git cherry-pick" was harder to read and use than neces=
sary
   when it stopped due to conflicting changes.

 * We referred to ".git/refs/" throughout the documentation when we
   meant to talk about abstract notion of "ref namespace".  Because
   people's repositories often have packed refs these days, this was
   confusing.

 * "git diff --output=3D/path/that/cannot/be/written" did not correctly
   error out.

 * "git grep -e -pattern-that-begin-with-dash paths..." could not be
   spelled as "git grep -- -pattern-that-begin-with-dash paths..." whic=
h
   would be a GNU way to use "--" as "end of options".

 * "git grep" compiled with threading support tried to access an
   uninitialized mutex on boxes with a single CPU.

 * "git stash pop -q --index" failed because the unnecessary --index
   option was propagated to "git stash drop" that is internally run at =
the
   end.

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.0 are as follows:

Bert Wesarg (2):
      Documentation: mention conflict marker size argument (%L) for mer=
ge driver
      rerere: fix memory leak if rerere images can't be read

Evan Powers (1):
      git-p4: fix bug in symlink handling

Jacob Helwig (1):
      Documentation: Fix indentation problem in git-commit(1)

Jeff King (9):
      accept "git grep -- pattern"
      cherry-pick: rewrap advice message
      cherry-pick: refactor commit parsing code
      cherry-pick: format help message as strbuf
      cherry-pick: show commit name instead of sha1
      cherry-pick: prettify the advice message
      dwim_ref: fix dangling symref warning
      docs: don't talk about $GIT_DIR/refs/ everywhere
      rm: fix bug in recursive subdirectory removal

Johannes Sixt (1):
      t3301-notes: insert a shbang line in ./fake_editor.sh

Jonathan Nieder (1):
      am: remove rebase-apply directory before gc

Junio C Hamano (6):
      Typofixes outside documentation area
      Start 1.7.0 maintenance track
      Fix use of mutex in threaded grep
      Prepare 1.7.0.1 release notes
      Update 1.7.0.1 release notes
      Git 1.7.0.1

Larry D'Anna (1):
      diff: make sure --output=3D/bad/path is caught

Mark Lodato (2):
      grep documentation: clarify what files match
      Remove reference to GREP_COLORS from documentation

Markus Heidelberg (1):
      sha1_name: fix segfault caused by invalid index access

Matt Kraai (1):
      commit: quote the user name in the example

Pete Harlan (1):
      Remove hyphen from "git-command" in two error messages

Ren=C3=A9 Scharfe (1):
      fix minor memory leak in get_tree_entry()

Stephen Boyd (1):
      Documentation: describe --thin more accurately

Thomas Rast (2):
      stash pop: remove 'apply' options during 'drop' invocation
      t1450: fix testcases that were wrongly expecting failure
