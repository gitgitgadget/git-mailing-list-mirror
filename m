Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90E1DF273
	for <git@vger.kernel.org>; Mon, 19 May 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672145; cv=none; b=MWwWDETQXToyV2k5SKr2f7FgooUpYQNE9dAvpwoCDvzwvtsJW5PI3dt7AyavzHMhva4MNMtoiGa3+e2fVZE52yKn5IzRWoXBklhU91dvAu1IqRAgWonX4/2w22PW8ya6dRYjtr2sMTy4VRTSug0BiN+rnhhugWPE2ynsrgNZPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672145; c=relaxed/simple;
	bh=Nlm++1KiCZCXT5dgbr6Oe5b1bmspXF8bS1+6xxhXw68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yi8WJupMb6+B16wzXwgfo3ha7MgEy2lDoXqxeJwaHwGJoLhhRGPDYjzrEWRyqj9glF4fXpXRPNw+kLbdRbHi7fwlE4YkDyANvAKoaXZrSdmeaN+UdXqMyoDzLGSirWybJZgb86B+WZ0V/jeu8ADdLTml8qANNrye3VVXZyJG/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=qAp1KOUA; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="qAp1KOUA"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id H3J4um35fEe7cH3JQuD0B8; Mon, 19 May 2025 17:26:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747671961; bh=o0vY75iDGt+AggeSpcydxiff6NNtYfMkG9FjdDjalyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qAp1KOUAPEksTj1qUe6t0CBg7g0Qm+FkxJBiUmptuqTi7cPPZzmmoxO6ZcoQz9xgI
	 yl21Z45UHvYBWgX2d4C2+T56Toy+jicdmH9mTYtVezvimAqNkhvEwZme8S7avX3QRz
	 v30b+itojZzASyh9mSGhQKDCa1T3XGL1UABx0jh6iRqwvQ/5Knoyx3AY+gupFYT3Co
	 pQJu5FJhO1/I4NpgA3DruZIZk2D50Z+S9SvUgSPjXcZ6S0SGc4e6BGHW/WzaJa1Ub9
	 21+MFf7ebao9l164849/X+wjqstsKv0rMkv02mRRDOl3zgUYSGzKe1sDD3Akp/9JK0
	 Z+lPqAKbi/p0Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=BeN70at2 c=1 sm=1 tr=0 ts=682b5b99
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=K09ICo3nOkC_At7xrYwA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v4 2/5] meson: correct install location of YAML.pm
Date: Mon, 19 May 2025 17:25:20 +0100
Message-ID: <20250519162523.1001478-3-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
References: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
 <20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfA8k/+m0q75USO6Lxmr1F+Kk6HxmW74hh+c8mSVurJnrdm47e32SikVC9LVzfg9/CmxLqbvOMKSA4CmSXtnGw9zMXdy3uGffepMlnJ/nm9Rn1elWm0zN
 qnwWWFVA85dBdP3AWbI4BaZeBrTkatgGV+70SxFaAnvyJpm4rh9qBg13bt6yB38/N2rCMrIapZB3kM63MagIizFWa2LAbROit5c=

When executing an 'meson install' the YAML.pm file is incorrectly
placed in the <prefix>/share/perl5/Git/SVN directory. The YAML.pm
file should be placed in a 'Memoize' subdirectory instead. In order
to correct the location, update the 'install_dir' of the relevant
target in the 'perl/Git/SVN/Memoize/meson.build' file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 perl/Git/SVN/Memoize/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Memoize/meson.build b/perl/Git/SVN/Memoize/meson.build
index 233ec670d7..8c2e80d2d2 100644
--- a/perl/Git/SVN/Memoize/meson.build
+++ b/perl/Git/SVN/Memoize/meson.build
@@ -3,6 +3,6 @@ test_dependencies += custom_target(
   output: 'YAML.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/Git/SVN',
+  install_dir: get_option('datadir') / 'perl5/Git/SVN/Memoize',
   depends: [git_version_file],
 )
-- 
2.49.0

