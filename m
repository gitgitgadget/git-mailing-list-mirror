From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.1.3
Date: Thu, 07 Feb 2013 16:13:30 -0800
Message-ID: <7vpq0b4q8l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 01:14:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3bba-0003Jy-Ve
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 01:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab3BHANh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2013 19:13:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51514 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab3BHANg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Feb 2013 19:13:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69073B8ED;
	Thu,  7 Feb 2013 19:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=FcFWjTAe2qLc2s/w8FJn/e1IP
	xE=; b=x5e6v9epbCrva+cWSw/6cHWq6j8fm7MIRWbi3vnCAYXS++jAGB0nNZ/Ua
	479PEtL+sJy1icU+jS38NafpjBucEzmpgRlnwZ7p9PRfl7eG/X0YC5DnZ6exvEI4
	YxZu8a/aL1n1nyXXXEtaUA/zP/tymOrVndkgpaZNtg8dfLGYmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=tPHI3Xi/nnqL7IJiRlC
	Y+vst8vrY9SMiHjkA9WWK2VGyMhKKoUUowol8TA6xDPN6xKTf9ikv4VkixMQrk9k
	rQ7RN6Tr6LKAFo61t+tm2gSnyybKjP0jar/PmnRGAtwk41zAqJt57NQuXwoZlgOt
	qnstq0Tdm2duXyCOUqWHgoSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CB70B8EA;
	Thu,  7 Feb 2013 19:13:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BD21B8DF; Thu,  7 Feb 2013
 19:13:32 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F77629C-7184-11E2-A204-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215739>

The latest maintenance release Git v1.8.1.3 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

29ed9047263f9835726200226451339276641779  git-1.8.1.3.tar.gz
6b1e57bde2f2b0a86532390c15bfa7b181c50db2  git-htmldocs-1.8.1.3.tar.gz
12aaa8a0428e64d194665379ab0335d786728930  git-manpages-1.8.1.3.tar.gz

Also the following public repositories all have a copy of the v1.8.1.3
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git 1.8.1.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

=46ixes since v1.8.1.2
--------------------

 * The attribute mechanism didn't allow limiting attributes to be
   applied to only a single directory itself with "path/" like the
   exclude mechanism does.  The fix for this in 1.8.1.2 had
   performance degradations.

 * Command line completion code was inadvertently made incompatible wit=
h
   older versions of bash by using a newer array notation.

 * Scripts to test bash completion was inherently flaky as it was
   affected by whatever random things the user may have on $PATH.

 * A fix was added to the build procedure to work around buggy
   versions of ccache broke the auto-generation of dependencies, which
   unfortunately is still relevant because some people use ancient
   distros.

 * We used to stuff "user@" and then append what we read from
   /etc/mailname to come up with a default e-mail ident, but a bug
   lost the "user@" part.

 * "git am" did not parse datestamp correctly from Hg generated patch,
   when it is run in a locale outside C (or en).

 * Attempt to "branch --edit-description" an existing branch, while
   being on a detached HEAD, errored out.

 * "git cherry-pick" did not replay a root commit to an unborn branch.

 * We forgot to close the file descriptor reading from "gpg" output,
   killing "git log --show-signature" on a long history.

 * "git rebase --preserve-merges" lost empty merges in recent versions
   of Git.

 * Rebasing the history of superproject with change in the submodule
   has been broken since v1.7.12.

 * A failure to push due to non-ff while on an unborn branch
   dereferenced a NULL pointer when showing an error message.

Also contains various documentation fixes.

----------------------------------------------------------------

Changes since v1.8.1.2 are as follows:

Brandon Casey (3):
      git-completion.bash: replace zsh notation that breaks bash 3.X
      git-p4.py: support Python 2.5
      git-p4.py: support Python 2.4

Dmitry V. Levin (1):
      am: invoke perl's strftime in C locale

=46raser Tweedale (1):
      push: fix segfault when HEAD points nowhere

John Keeping (1):
      git-cvsimport.txt: cvsps-2 is deprecated

Jonathan Nieder (2):
      ident: do not drop username when reading from /etc/mailname
      Makefile: explicitly set target name for autogenerated dependenci=
es

Junio C Hamano (17):
      Which merge_file() function do you mean?
      merge-tree: lose unused "flags" from merge_list
      merge-tree: lose unused "resolve_directories"
      merge-tree: add comments to clarify what these functions are doin=
g
      merge-tree: fix d/f conflicts
      Documentation: update "howto maintain git"
      howto/maintain: mark titles for asciidoc
      help: include <common-cmds.h> only in one file
      t9902: protect test from stray build artifacts
      howto/maintain: document "### match next" convention in jch/pu br=
anch
      README: update stale and/or incorrect information
      INSTALL: git-p4 does not support Python 3
      git-am: record full index line in the patch used while rebasing
      apply: simplify build_fake_ancestor()
      apply: diagnose incomplete submodule object name better
      Start preparing for 1.8.1.3
      Git 1.8.1.3

Martin von Zweigbergk (2):
      tests: move test_cmp_rev to test-lib-functions
      learn to pick/revert into unborn branch

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
      attr: fix off-by-one directory component length calculation
      test-lib.sh: unfilter GIT_PERF_*
      attr: avoid calling find_basename() twice per path
      branch: no detached HEAD check when editing another branch's desc=
ription

Phil Hord (1):
      rebase --preserve-merges: keep all merge commits including empty =
ones

Ramsay Allan Jones (1):
      Makefile: Replace merge-file.h with merge-blobs.h in LIB_H

Stephen Boyd (1):
      gpg: close stderr once finished with it in verify_signed_buffer()

Torsten B=C3=B6gershausen (3):
      t0050: known breakage vanished in merge (case change)
      t0050: honor CASE_INSENSITIVE_FS in add (with different case)
      t0050: Use TAB for indentation
