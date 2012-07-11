From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.11.2
Date: Wed, 11 Jul 2012 15:15:12 -0700
Message-ID: <7v4npedjwv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Jul 12 00:15:29 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Sp5Bv-0007um-Hn
	for glk-linux-kernel-3@plane.gmane.org; Thu, 12 Jul 2012 00:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393Ab2GKWPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 11 Jul 2012 18:15:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282Ab2GKWPP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jul 2012 18:15:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 992F75323;
	Wed, 11 Jul 2012 18:15:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Y7zy++gKpI1g/BVCI8nB0HL8s
	lw=; b=sksesx64Q6TCqTbJOKbNQxxXoHy7kGlYj9LWt+Pa05zPMf/J2t4Fsy/lD
	yL/CXiCWRNXc+rtx8V91WFMckk7JNEckbKRSCgSi/RMNa/k5L+QOj+jnvMkGC8Xz
	8+hg2Eo9HtkFEHd/zbOfXHHunrMFy++G/7Q8F/WHq+zRcvlUtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=NSxllgg9atqWaXWFA/u
	H+M7YpTa6xjXKPm43zA4jY81pCJxre4Tu5oD+j7BR7sosjwPky2CIEsUVRcAxro7
	o6zdrk7Rq4YLu0VKa5tEW3s8ND+VfBu9mDcF+mdapeAyRa5h/NxAepG2hweblZHU
	T1IspOdjdWNU/QGJyZDjBteg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89B31531D;
	Wed, 11 Jul 2012 18:15:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D74445319; Wed, 11 Jul 2012
 18:15:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3282AC0-CBA5-11E1-AF94-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201341>

The latest maintenance release Git v1.7.11.2 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

f67b4f6c0277250411c6872ae7b8a872ae11d313  git-1.7.11.2.tar.gz
088996c301cca24360fd5e30ce66bfa26139fe95  git-htmldocs-1.7.11.2.tar.gz
78b46ca7b5037c61a58086879869dadeac9eea3e  git-manpages-1.7.11.2.tar.gz

Also the following public repositories all have a copy of the v1.7.11.2
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.11.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

=46ixes since v1.7.11.1
---------------------

 * On Cygwin, the platform pread(2) is not thread safe, just like our
   own compat/ emulation, and cannot be used in the index-pack
   program.  Makefile variable NO_THREAD_SAFE_PREAD can be defined to
   avoid use of this function in a threaded program.

 * "git add" allows adding a regular file to the path where a
   submodule used to exist, but "git update-index" does not allow an
   equivalent operation to Porcelain writers.

 * "git archive" incorrectly computed the header checksum; the symptom
   was observed only when using pathnames with hi-bit set.

 * "git blame" did not try to make sure that the abbreviated commit
   object names in its output are unique.

 * Running "git bundle verify" on a bundle that records a complete
   history said "it requires these 0 commits".

 * "git clone --single-branch" to clone a single branch did not limit
   the cloning to the specified branch.

 * "git diff --no-index" did not correctly handle relative paths and
   did not correctly give exit codes when run under "--quiet" option.

 * "git diff --no-index" did not work with pagers correctly.

 * "git diff COPYING HEAD:COPYING" gave a nonsense error message that
   claimed that the treeish HEAD did not have COPYING in it.

 * When "git log" gets "--simplify-merges/by-decoration" together with
   "--first-parent", the combination of these options makes the
   simplification logic to use in-core commit objects that haven't
   been examined for relevance, either producing incorrect result or
   taking too long to produce any output.  Teach the simplification
   logic to ignore commits that the first-parent traversal logic
   ignored when both are in effect to work around the issue.

 * "git ls-files --exclude=3Dt -i" did not consider anything under t/ a=
s
   excluded, as it did not pay attention to exclusion of leading paths
   while walking the index.  Other two users of excluded() are also
   updated.

 * "git request-pull $url dev" when the tip of "dev" branch was tagged
   with "ext4-for-linus" used the contents from the tag in the output
   but still asked the "dev" branch to be pulled, not the tag.

Also contains minor typofixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.11.1 are as follows:

Carlos Mart=C3=ADn Nieto (2):
      Documentation: --no-walk is no-op if range is specified
      git-cherry-pick.txt: clarify the use of revision range notation

Heiko Voigt (1):
      update-index: allow overwriting existing submodule index entries

Jeff King (3):
      fix pager.diff with diff --no-index
      do not run pager with diff --no-index --quiet
      diff: handle relative paths in no-index

Junio C Hamano (15):
      request-pull: really favor a matching tag
      ls-files -i: pay attention to exclusion of leading paths
      ls-files -i: micro-optimize path_excluded()
      tweak "bundle verify" of a complete history
      path_excluded(): update API to less cache-entry centric
      builtin/add.c: use path_excluded()
      unpack-trees.c: use path_excluded() in check_ok_to_remove()
      dir.c: make excluded() file scope static
      revision: "simplify" options imply topo-order sort
      revision: note the lack of free() in simplify_merges()
      archive: ustar header checksum is computed unsigned
      revision: ignore side parents while running simplify-merges
      index-pack: Disable threading on cygwin
      blame: compute abbreviation width that ensures uniqueness
      Git 1.7.11.2

Leila Muhtasib (1):
      Documentation: Fix misspellings

Matthieu Moy (2):
      sha1_name: do not trigger detailed diagnosis for file arguments
      verify_filename(): ask the caller to chose the kind of diagnosis

Micha=C5=82 G=C3=B3rny (1):
      git-submodule.sh: fix filename in comment.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      clone: fix ref selection in --single-branch --branch=3Dxxx

Peter Krefting (1):
      Update Swedish translation (1066t0f0u)

Thomas Badie (1):
      git-add--interactive.perl: Remove two unused variables

Tim Henigan (1):
      diff-no-index: exit(1) if 'diff --quiet <repo file> <external fil=
e>' finds changes
