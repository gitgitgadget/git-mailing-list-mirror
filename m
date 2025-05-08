Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65478F32
	for <git@vger.kernel.org>; Thu,  8 May 2025 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722920; cv=none; b=f5lVOPIhOLT/YsoKsJdrW9BnjDm+drrGiLdG40Vpl9vAT4C/yf2gnRDLIw2j/uCN8qjbUbIxMy3mu/Hbs8cDRVtfE8UoucqFB40+NaTUJzXxIn21auFW+ygSira82xRLzZoVjeZfBPINwkl8QFA9RoloNmCzZUjZLiBvVYITZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722920; c=relaxed/simple;
	bh=4IOsWya/4PhiwIuXjcMvTNnXDX6axOwxtg0q0NSs3lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dF9euThuazckUMl2LGqIv0jyOEjnWrqM0emeD9tk4NUftD40TdoWHvKRKYiZ8klDNfQWRJHxWQm/GK7EWa7Rjhm7wXFCnyuGqzEtMOnIjknKL/HDMlRVZCayJByVHMygn8k8PpHbO94eUQzxSQiPegCwzRmOK/bVheOfkHI+NqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=oadPmGJ6; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="oadPmGJ6"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id D4MzuXnvmeYyCD4NBuuAga; Thu, 08 May 2025 17:45:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1746722729; bh=lYcKIFqxdzVn3hupKjoG0QLpcJ4BoM+WSxu5zlf76r0=;
	h=From:To:Cc:Subject:Date;
	b=oadPmGJ6EX1T6PAY5P0kB515UB3JcseHtfb5jaHtuwBQvbE971tvuZCNX8LFJ6OeM
	 1Nvgrx7TZ3O2p/8BJLBB8v2w0qGvvR2XyF0kIfdLBzJPoESBr01uCJQh1zPwyTym8s
	 umx9H9GPAi0wSAWeAjezGcyvAEjNhmtmAwYz+MwbuYdS4Semvl58Qirfib8Tee1yLJ
	 ST4cYXnCBr5pdV3I0C/KesdDRd49VZZKy5T6fgwAxYYkkJvoP+RTfI2ietRO5VQLv0
	 hXBWckmgv8vUD19NetJNq6dZl/8UV0bGDDo9dupryq+joarpl3ZF303SIJZ7EQ6rRS
	 7ZN5Ds3EZluTw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ac7Cngot c=1 sm=1 tr=0 ts=681cdfa9
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=fssLrGSdjCoCgucSFs8A:9
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH 0/5] miscellaneous build mods (part 2)
Date: Thu,  8 May 2025 17:44:34 +0100
Message-ID: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfH4DJy4yBNLwMDRrKPmahbtTK+vfYV/d6HehgZio10XoO+doiZen9XLWJQg6zhRQS5HHjGZwjZxvMRw0Ibpe7k4PrWlNgF/LUs3RdYiLBjzhiVDoTxuT
 KiBgTlD/hTEbfxjvamRTug865ivePYGembsyOktdxfITXdpJbMNpSkbSiOxyI7LR3Q5DQ4XfIBivVAmUvdqfDshKoaf4y5Yw5Qg=

This series (part 2) continues the miscellaneous changes to the make,
meson and autoconf build systems. I am sending this part a little
earlier than I expected, so there will now be a part 3!

The reason for the early posting is to try and avoid an regression in
the autoconf build system (see patch #5). Hopefully, we still have time
in this cycle to get patch #5 included.

This series is based on commit 6f84262c44 ("The eleventh batch", 2025-05-05)

I did a test merge to 'next'@629a3ecd64 without issue, but 'seen'@71cfd25022
had a small conflict with commit 1a2929c851 ("meson: allow customize perl
installation path", 2025-04-24) on the 'dd/meson-perl-custom-path' branch.
(I note that a new version of that patch was posted to the list today).

The fixup looks like:

    diff --cc perl/Git/SVN/Memoize/meson.build
    index 4c589b30c3,8c2e80d2d2..d6209dc3bf
    --- a/perl/Git/SVN/Memoize/meson.build
    +++ b/perl/Git/SVN/Memoize/meson.build
    @@@ -3,6 -3,6 +3,6 @@@ test_dependencies += custom_target
        output: 'YAML.pm',
        command: generate_perl_command,
        install: true,
    -   install_dir: perllibdir / 'Git/SVN',
     -  install_dir: get_option('datadir') / 'perl5/Git/SVN/Memoize',
    ++  install_dir: perllibdir / 'Git/SVN/Memoize',
        depends: [git_version_file],
      )

ATB,
Ramsay Jones


Ramsay Jones (5):
  meson.build: quote the GITWEBDIR build configuration
  meson: correct install location of YAML.pm
  meson: correct path to system config/attribute files
  meson.build: correct setting of GIT_EXEC_PATH
  configure.ac: upgrade to a compilation check for sysinfo

 configure.ac                     | 25 ++++++++++++++++++++++---
 meson.build                      | 28 +++++++++++++++++++++++-----
 meson_options.txt                |  4 ++--
 perl/Git/SVN/Memoize/meson.build |  2 +-
 4 files changed, 48 insertions(+), 11 deletions(-)

-- 
2.49.0

