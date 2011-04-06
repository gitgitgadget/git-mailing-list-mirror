From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.4.4
Date: Wed, 06 Apr 2011 12:59:24 -0700
Message-ID: <7vk4f7i21v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 21:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Yt5-0004mO-TO
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 21:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749Ab1DFT7b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 15:59:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756738Ab1DFT7a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 15:59:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A322F47DD;
	Wed,  6 Apr 2011 16:01:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=mJ52j7tgWlyYzq/v88Kn1c5ji
	ik=; b=eRG8PCm60MooEo/yzEmsjXtz/tKekMHQU/08oyN/osC3ouNPP+Vv4YLZs
	C0TsPtWT2qnnC1THvmtGYv96KFNzImZTaD3ey14Krb0Rhs+Phob+e4i3ENDFYBMS
	haAp8jKQIkStEjszMbLM0J+qLCjP8thSxacxDF9vx8GBK5JtrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=EAz7xQyMpubUyLykj59
	zUz1jJnKU9oA1m1zSdjwSp6b7jipdQaAHVf/sWFZtZDFekAjoGZ/NTgRlvIKESDD
	szkQtFrfm14LDeicGzDf6+96zKijxJqKAmnryR2ZdvHAxICWNAYic6TlmYve3z+U
	T8oY750xXRTQe/gSf/GsMyI0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9009347DC;
	Wed,  6 Apr 2011 16:01:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A6A6947DB; Wed,  6 Apr 2011
 16:01:20 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A53B7642-6088-11E0-8D54-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171011>

The latest maintenance release Git 1.7.4.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.4.4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.4.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.4.4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.4.4-1.fc13.$arch.rpm	(RPM)

Git v1.7.4.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.4.3
--------------------

 * Compilation of sha1_file.c on BSD platforms were broken due to our
   recent use of getrlimit() without including <sys/resource.h>.

 * "git config" did not diagnose incorrect configuration variable names=
=2E

 * "git format-patch" did not wrap a long subject line that resulted fr=
om
   rfc2047 encoding.

 * "git instaweb" should work better again with plackup.

 * "git log --max-count=3D4 -Sfoobar" now shows 4 commits that changes =
the
   number of occurrences of string "foobar"; it used to scan only for 4
   commits and then emitted only matching ones.

 * "git log --first-parent --boundary $c^..$c" segfaulted on a merge.

 * "git pull" into an empty branch should have behaved as if
   fast-forwarding from emptiness to the version being pulled, with
   the usual protection against overwriting untracked files.

 * "git submodule" that is run while a merge in the superproject is in
   conflicted state tried to process each conflicted submodule up to
   three times.

 * "git status" spent all the effort to notice racily-clean index entri=
es
   but didn't update the index file to help later operations go faster =
in
   some cases.

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.4.3 are as follows:

Jakub Narebski (2):
      git-instaweb: Change how gitweb.psgi is made runnable as standalo=
ne app
      gitweb: Fix parsing of negative fractional timezones in JavaScrip=
t

Jeff King (4):
      strbuf: add fixed-length version of add_wrapped_text
      format-patch: wrap long header lines
      format-patch: rfc2047-encode newlines in headers
      pull: do not clobber untracked files on initial pull

Jonathan Nieder (1):
      compat: add missing #include <sys/resource.h>

Junio C Hamano (6):
      list-objects.c: don't add an unparsed NULL as a pending tree
      Rename core.abbrevlength back to core.abbrev
      diff/status: refactor opportunistic index update
      update $GIT_INDEX_FILE when there are racily clean entries
      Start preparing for 1.7.4.4
      Git 1.7.4.4

Libor Pechacek (2):
      Sanity-check config variable names
      Disallow empty section and variable names

Linus Torvalds (1):
      Make the default abbrev length configurable

Matthieu Moy (1):
      log: fix --max-count when used together with -S or -G

Michael J Gruber (2):
      git-log.txt,rev-list-options.txt: -n/--max-count is commit limiti=
ng
      git-log.txt,rev-list-options.txt: put option blocks in proper ord=
er

Nicolas Morey-Chaisemartin (1):
      submodule: process conflicting submodules only once

SZEDER G=C3=A1bor (1):
      Documentation: trivial grammar fix in core.worktree description
