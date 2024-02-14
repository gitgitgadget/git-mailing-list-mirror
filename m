Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E57AE72;
	Wed, 14 Feb 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930851; cv=none; b=FLZUxMii9lQjyCTASUpFb5o/UR2czEyvZFLz/KNcdvccM45XEQYUyn4SoKU1SKmOYswTOm+hsUGZoa3cvqcRRct87KnaSoDmqWOrYVKarqXhSZdRThPu07NSOEgq0go/uHPE7y0/LOf8c8Db93bDLtz7dxwYTr5dgwN0gUVAorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930851; c=relaxed/simple;
	bh=rtNqnQMrhTZoVIcurqvh/n552z2fKUMA1DuDPbo13Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q1bl4j2I+zM5+aKl8spxx51rdh6wXssWE72C/xb/u/+ea5jJPqz5W0eWMqBOIZ4IXqMnXkLfJlWV2TeJ/Px48MrSuQdl5WNncJGtDmoZp+gvimTih5XjenDDBqlvW0tHzoBXV1KSle/mfbU0ZrjEAQEA4ZQ3ZHP3EW7ryHO+Pug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PXUo5k7T; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PXUo5k7T"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D205C1D370E;
	Wed, 14 Feb 2024 12:14:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=rtNqnQMrhTZoVIcurqvh/n552
	z2fKUMA1DuDPbo13Yk=; b=PXUo5k7TZBmhJb6JeLAN9wUBia9bsfVsbWk97C25M
	K947zuLB7J0SreD74x8gLFkZKw+FyXMExGus2QmNlonijF2mDKRYS1tq1WGTIUYC
	F3Gw1XRQdMRkvlBhEq3ZZzfPGzie/zQm7MxAKPkJg1+TovyNwVRRJwpAQclPEwCL
	g0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B68591D370D;
	Wed, 14 Feb 2024 12:14:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C49991D370C;
	Wed, 14 Feb 2024 12:14:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.43.2
Date: Wed, 14 Feb 2024 09:14:06 -0800
Message-ID: <xmqqo7cjvuht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7672AF90-CB5C-11EE-935A-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The latest maintenance release Git v2.43.2 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.43.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.43.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Relative to Git 2.43.1, this release has two important fixes to allow
"git imap-send" to be built with NO_CURL defined, and to restore the
forced flushing behaviour when GIT_FLUSH=3D1 is set.  It also contains
other, unexciting, fixes that have already been merged to the 'master'
branch of the development towards the next major release.

Fixes since Git 2.43.1
----------------------

 * Update to a new feature recently added, "git show-ref --exists".

 * Rename detection logic ignored the final line of a file if it is an
   incomplete line.

 * "git diff --no-rename A B" did not disable rename detection but did
   not trigger an error from the command line parser.

 * "git diff --no-index file1 file2" segfaulted while invoking the
   external diff driver, which has been corrected.

 * Rewrite //-comments to /* comments */ in files whose comments
   prevalently use the latter.

 * A failed "git tag -s" did not necessarily result in an error
   depending on the crypto backend, which has been corrected.

 * "git stash" sometimes was silent even when it failed due to
   unwritable index file, which has been corrected.

 * Recent conversion to allow more than 0/1 in GIT_FLUSH broke the
   mechanism by flipping what yes/no means by mistake, which has been
   corrected.

Also contains documentation updates, code clean-ups and minor fixups.

----------------------------------------------------------------

Changes since v2.43.1 are as follows:

Elijah Newren (1):
      diffcore-delta: avoid ignoring final 'line' of file

James Touton (1):
      git-p4: use raw string literals for regular expressions

Jeff King (1):
      diff: handle NULL meta-info when spawning external diff

Johannes Schindelin (1):
      win32: special-case `ENOSPC` when writing to a pipe

Junio C Hamano (11):
      Docs: majordomo@vger.kernel.org has been decomissioned
      CoC: whitespace fix
      builtin/worktree: comment style fixes
      merge-ort.c: comment style fix
      reftable/pq_test: comment style fix
      tag: fix sign_buffer() call to create a signed tag
      bisect: document "terms" subcommand more fully
      bisect: document command line arguments for "bisect start"
      ssh signing: signal an error with a negative return value
      write-or-die: fix the polarity of GIT_FLUSH environment variable
      Git 2.43.2

Linus Arver (1):
      strvec: use correct member name in comments

Nikolay Borisov (1):
      rebase: fix documentation about used shell in -x

Nikolay Edigaryev (1):
      rev-list-options: fix off-by-one in '--filter=3Dblob:limit=3D<n>' e=
xplainer

Patrick Steinhardt (1):
      builtin/stash: report failure to write to index

Philippe Blain (2):
      imap-send: add missing "strbuf.h" include under NO_CURL
      .github/PULL_REQUEST_TEMPLATE.md: add a note about single-commit PR=
s

Ren=C3=A9 Scharfe (2):
      parse-options: fully disable option abbreviation with PARSE_OPT_KEE=
P_UNKNOWN
      parse-options: simplify positivation handling

Sam Delmerico (1):
      push: region_leave trace for negotiate_using_fetch

Taylor Blau (1):
      pack-bitmap: drop unused `reuse_objects`

Toon Claes (1):
      builtin/show-ref: treat directory as non-existing in --exists

