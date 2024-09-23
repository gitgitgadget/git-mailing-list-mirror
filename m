Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09E17557;
	Mon, 23 Sep 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727125364; cv=none; b=InX3/1O/2nYbXTLpPNhGR+Z3UAws0x+fcDSW2G9/zPxNpkCHxcBGcjMT5Rl0ooXwghqinJa6+lFj90rC+HBww1K+tMqvlw5s1PDpWP5xRR+yW1N0rgKGim0HLHKhcj5ntXmrG6VqwzUQ/Rxz6KGV3cbf9oH9vtc2wufNcrwvYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727125364; c=relaxed/simple;
	bh=l4iD7D/tfPRGB6CIvAqPoSF/ci9xUyyP29Lp8M0o7pI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LPYx9Bd2SfQJt6bMyBdicOstOtziZzfQzM+2O2flUGTlGYhe5/UI1CRF8Fz11RUDLowupYBxBRd3iWQwGJyOdcxORq7xiuNRDiWabLrri8jI5qFKQ3CG4GUXCu+ea7eovZxR2gdwhrEdwEOWEyg4mawtZCx/dWmcK72pdV1MEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wXqVD1Z9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wXqVD1Z9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FDFF2AD99;
	Mon, 23 Sep 2024 17:02:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=l4iD7D/tfPRGB6CIvAqPoSF/c
	i9xUyyP29Lp8M0o7pI=; b=wXqVD1Z9/bmpLo7D1rY71gOpsaGZtBHUGxVB2E3oa
	KzoH6SUIm/GkXN2hDrv2BJmem4AAGK5PLVYMvO+v/U6w9Oh6Ck1qmYF4sRjrGU7a
	BDTChtFMRr4gtclm99OV4oncEl8suGut41Qez9D0RIcNn6DPMPZIEH1WXcg+sB+W
	FI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 37E0B2AD98;
	Mon, 23 Sep 2024 17:02:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 871432AD97;
	Mon, 23 Sep 2024 17:02:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.46.2
Date: Mon, 23 Sep 2024 14:02:39 -0700
Message-ID: <xmqqa5fyytg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2B800A18-79EF-11EF-98E9-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The latest maintenance release Git v2.46.2 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.46.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------
Git 2.46.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This release is primarily to merge changes to unbreak the 32-bit
GitHub actions jobs we use for CI testing, so that we can release
real fixes for the 2.46.x track after they pass CI.

It also reverts the "git patch-id" change that went into 2.46.1,
as it seems to have got a regression reported (I haven't verified,
but it is better to keep a known breakage than adding an unintended
regression).

Other than that, a handful of minor bugfixes are included.

 * In a few corner cases "git diff --exit-code" failed to report
   "changes" (e.g., renamed without any content change), which has
   been corrected.

 * Cygwin does have /dev/tty support that is needed by things like
   single-key input mode.

 * The interpret-trailers command failed to recognise the end of the
   message when the commit log ends in an incomplete line.

----------------------------------------------------------------

Changes since v2.46.1 are as follows:

Brian Lyles (1):
      interpret-trailers: handle message without trailing newline

Jeff King (4):
      ci: drop run-docker scripts
      ci: unify ubuntu and ubuntu32 dependencies
      ci: use more recent linux32 image
      ci: use regular action versions for linux32 job

Junio C Hamano (5):
      doc: remote.*.skip{DefaultUpdate,FetchAll} stops prefetch
      ci: remove 'Upload failed tests' directories' step from linux32 job=
s
      Revert "Merge branch 'jc/patch-id' into maint-2.46"
      Start preparing for Git 2.46.2
      Git 2.46.2

Martin =C3=85gren (2):
      t1517: add missing LIBCURL prereq
      t0211: add missing LIBCURL prereq

Patrick Steinhardt (1):
      ci: add Ubuntu 16.04 job to GitLab CI

Ramsay Jones (1):
      config.mak.uname: add HAVE_DEV_TTY to cygwin config section

Ren=C3=A9 Scharfe (2):
      diff: report copies and renames as changes in run_diff_cmd()
      diff: report dirty submodules as changes in builtin_diff()

