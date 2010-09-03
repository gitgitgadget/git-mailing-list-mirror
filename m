From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.2.3
Date: Fri, 03 Sep 2010 15:07:45 -0700
Message-ID: <7vwrr2xyz2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 00:08:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OreQc-0001L5-UG
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 00:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446Ab0ICWH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 18:07:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab0ICWH4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 18:07:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A181BD3B21;
	Fri,  3 Sep 2010 18:07:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=66vValqcHphs5pbg5BBW5ZB5a
	yE=; b=Lw9NsMipq+PPOWCjXcUBoEpigLRLfpH5KM4uke+LIiptnxw/GVJQ9Q1IZ
	ZPa7CrulIAPw/cXTRyTuZD3KgXd+e9994WYeb6F6UjsPryfBDVucE2YSnASMeFVg
	8ox0SAgV+HriOg7FyLS3K1WBkqQkELcRY8buq+VOYbuzk1g1t0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=D/IkfNpMQXS9M81xFZF
	i6br01Gn/aKqIoDTMPIHy6vidxACvJjbVUjbEdumtCfH6Gm9ReClEdvlNwVn+723
	BYMpjrU+E6cluYjvqSMrG8k/2o9qxSqjQ/TXEHP3kVX242NXRnu+3c+Rp6TafN9H
	7Nk9K8R8FzBkvxzYqgQiPTJ4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A7C3D3B1F;
	Fri,  3 Sep 2010 18:07:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E204D3B1C; Fri,  3 Sep
 2010 18:07:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1C1CFAE-B7A7-11DF-8600-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155277>

The latest maintenance release Git 1.7.2.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.2.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.2.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.2.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.2.3-1.fc11.$arch.rpm	(RPM)

We will soon be preparing for 1.7.3 feature release but during the
pre-release freeze period for it, I expect one more maintenance updates
to the 1.7.2.X series.

Thanks everybody who contributed to this release to help making git les=
s
suck ;-)


Git v1.7.2.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.2.2
--------------------

 * When people try insane things such as delta-compressing 4GiB files, =
we
   threw an assertion failure.

 * "git archive" gave the full commit ID for "$Format:%h$".

 * "git fetch --tags" did not fetch tags when remote.<nick>.tagopt was =
set
   to --no-tags.  The command line option now overrides the configurati=
on
   setting.

 * "git for-each-ref --format=3D'%(objectname:short)'" has been complet=
ely
   broken for a long time.

 * "git gc" incorrectly pruned a rerere record that was created long
   time ago but still is actively and repeatedly used.

 * "git log --follow -M -p" was seriously broken in 1.7.2, reporting
   assertion failure.

 * Running "git log" with an incorrect option started pager nevertheles=
s,
   forcing the user to dismiss it.

 * "git rebase" did not work well when the user has diff.renames
   configuration variable set.

 * An earlier (and rather old) fix to "git rebase" against a rebased
   upstream broke a more normal, non rebased upstream case rather badly=
,
   attempting to re-apply patches that are already accepted upstream.

 * "git submodule sync" forgot to update the superproject's config file
   when submodule URL changed.

 * "git pack-refs --all --prune" did not remove a directory that has
   become empty.

----------------------------------------------------------------

Changes since v1.7.2.2 are as follows:

Brandon Casey (2):
      Makefile: link builtins residing in bin directory to main git bin=
ary too
      Makefile: make hard/symbolic links for non-builtins too

Daniel Johnson (1):
      fetch: allow command line --tags to override config

David Aguilar (1):
      submodule sync: Update "submodule.<name>.url"

Elijah Newren (3):
      t5520-pull: Add testcases showing spurious conflicts from git pul=
l --rebase
      pull --rebase: Avoid spurious conflicts and reapplying unnecessar=
y patches
      tree-walk: Correct bitrotted comment about tree_entry()

Greg Price (1):
      pack-refs: remove newly empty directories

Jay Soffian (1):
      for-each-ref: fix objectname:short bug

Jens Lehmann (1):
      t7403: add missing &&'s

Jonathan Nieder (12):
      t4150 (am): style fix
      t4150 (am): futureproof against failing tests
      t3400 (rebase): whitespace cleanup
      archive: abbreviate substituted commit ids again
      checkout, commit: remove confusing assignments to rev.abbrev
      examples/commit: use --abbrev for commit summary
      Documentation: flesh out =E2=80=9Cgit pull=E2=80=9D description
      core: Stop leaking ondisk_cache_entrys
      read-tree: stop leaking tree objects
      write-tree: Avoid leak when index refers to an invalid object
      t3302 (notes): Port to Solaris
      parse-options: clarify PARSE_OPT_NOARG description

Junio C Hamano (6):
      Teach "apply --index-info" to handle rename patches
      rebase: protect against diff.renames configuration
      diff --follow: do not waste cycles while recursing
      diff --follow: do call diffcore_std() as necessary
      Prepare for 1.7.2.3
      Git 1.7.2.3

Linus Torvalds (1):
      Fix 'git log' early pager startup error case

Mark Rada (1):
      Tell ignore file about generate files in /gitweb/static

Matthieu Moy (2):
      xmalloc: include size in the failure message
      t0003: add missing && at end of lines

Nicolas Pitre (1):
      fix >4GiB source delta assertion failure

Ralf Wildenhues (1):
      Typos in code comments, an error message, documentation

SZEDER G=C3=A1bor (2):
      mingw_utime(): handle NULL times parameter
      rerere: fix overeager gc

Thiago Farina (1):
      builtin/merge_recursive.c: Add an usage string and make use of it=
=2E

Thomas Rast (5):
      Documentation/git-reset: reorder modes for soft-mixed-hard progre=
ssion
      Documentation/reset: separate options by mode
      Documentation/reset: promote 'examples' one section up
      Documentation/reset: reorder examples to match description
      Documentation/reset: move "undo permanently" example behind "make=
 topic"

Ville Skytt=C3=A4 (1):
      Documentation: spelling fixes

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
      log: test for regression introduced in v1.7.2-rc0~103^2~2
