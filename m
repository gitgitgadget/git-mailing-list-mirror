Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A67DA95
	for <git@vger.kernel.org>; Tue, 13 May 2025 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164084; cv=none; b=smQR1MhXSLWKTxrkYiJPCK1kGWiobUFOS2ChvvkJj4fmAXP1CUPqaGqvc4uC2bEzzCeaC92cP6by/yo1i7GcrMN1L7azGn5MLi5ujJuryFgdODGZT+AQMleAFeNec9ZkczBTRrJ5gWb2N2V5uybyxz76cd5b2y/cSnZlTJT2VZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164084; c=relaxed/simple;
	bh=Nlm++1KiCZCXT5dgbr6Oe5b1bmspXF8bS1+6xxhXw68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMCu8YVM25agV5j2i048dlmKm8mjAH15cZtSXkE380jeUFOTQeRec+F00t3rn03HOA3qImI236FMzLJqhpySa1RiuObAFjlxHYA0+n1hm0llBlCqOKsdPJreLW0DH2P4g0zm4NWGt2YyACPdoxCF1mIofYtfw9FmuX8z6GspAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Ut+jw62D; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Ut+jw62D"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id Ev8Rub969aTZGEv8uuZHrw; Tue, 13 May 2025 20:18:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747163901; bh=o0vY75iDGt+AggeSpcydxiff6NNtYfMkG9FjdDjalyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ut+jw62DRph0OGfb1qcFO+P2Nm9eI1uTbJHCGCpvw/VnrAl5z1tm6tPEh9rdpnQxP
	 4TugU3O/hV8h0Tqqwed8WgUkuxdEf6Wt48I+WBBRzVkK24+j0cWjfmhspvib1PeUpe
	 GE2JmN1DErp5vMHQaCgWwOuTYc8psyR2x8McuJbQyNte+rly0gKeWSuHX4fY/+F1F4
	 WQ196OpIw2x3dBqIFdr8M2gDJr7ryRZAVy6noIU0FkNIfGu1TowvBujJlKRMcR8UXS
	 UAVzjX6QnqLeexZwieWWGJNGniYNiq0cGdNLapLYgCAChQEyNJwBrATi4+Tag7uzLy
	 gQLgY8YW1otPw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9ne0vni c=1 sm=1 tr=0 ts=68239afd
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=K09ICo3nOkC_At7xrYwA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: 'GIT Mailing-list ' <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v2 2/5] meson: correct install location of YAML.pm
Date: Tue, 13 May 2025 20:17:23 +0100
Message-ID: <20250513191739.1513460-3-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLfqxb/Idk1yl0L0OVEgCq1eVw1OF2d1qFdMONSR/KPC0oWGEANjyqdnAzD6RVEZ7Iye92hMTNcE6vMHEbXUuDTav9xVO2GlaBWgTpnXSOqm/WmKNTp0
 OACBZHgtiHgBEbqNjtuZi9jtx1cNS04OPLAzWXKA5vHDk7vlzB7e6SMY4yirxB7xIT+dgNKYTPo4vjIURrf5n01llnZdu86Gpm8=

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

