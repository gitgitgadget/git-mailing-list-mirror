Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41B20CCC3
	for <git@vger.kernel.org>; Thu,  8 May 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722932; cv=none; b=XhbYXVBd/NPmnI93CEqrQ1wIuYPP+wHGABC/f07BX29pyLR6v+o9SMuVXdtvoqZPXiXNShTkTuhJj3qzy9QFHA7tw8lDiasS8C6VjX53VZreEor+EIk0P4rrrY3iH8A4D8C8iUtg94B35CXbY45QRk7tKvE9ko2siTNEtr83Wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722932; c=relaxed/simple;
	bh=Nlm++1KiCZCXT5dgbr6Oe5b1bmspXF8bS1+6xxhXw68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpdCUrhjfqD5VcgFaazRDWpY+1TesacOhqUTuOiuTMrOdcuqPOZhOwH5W6Ogj8RfI9us9fydp8OWmFE9kRLDjpuGyBma/SqihQsdMsjU1zMCyMfv0Kt9TBg8hxEH3RABVd4VVFSClPbqB7Ane16HKqNSlXkAkQxYkM8z3FKTw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=AW0F7oG0; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="AW0F7oG0"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id D4MzuXnvmeYyCD4NZuuAh3; Thu, 08 May 2025 17:45:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1746722749; bh=o0vY75iDGt+AggeSpcydxiff6NNtYfMkG9FjdDjalyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AW0F7oG08xkQvefQ//MffM+wb76BWiRm0Br4EEQZXM09IuYPo8s01uSZvG3HrZRqr
	 6rtzRdJmCYfY5OCyuDTKo65IiUpKUMyTADhVrolP0sjVWBoSMxbCvYoTjMP3eOvo2H
	 UusmJTIJvlRT0rVMy3PQXQFBgdfHBGzlS4O5xyzQE1426AM7s2/doFbTUP79iEis+N
	 tWzfrNQ4cv0auaiDr9pxmPJRidxGkc6lSRW5nl7JjpOeWxdBEt76z3h0Guaw7deKYF
	 5/gucAELBzwA6/JxsZiCBwFE5L3kp2YT3vCktKf0y6yYHCRLwSbo3dqk5QIH0u1EbS
	 JoZciD95e8vgA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ac7Cngot c=1 sm=1 tr=0 ts=681cdfbd
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
Subject: [PATCH 2/5] meson: correct install location of YAML.pm
Date: Thu,  8 May 2025 17:44:36 +0100
Message-ID: <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLnM2YkNpEUvM+Jizp4A6zGHntwqDCpWWrqVpsClN+2s+VbJ0ejDxucnsNOkXV3ywMWsfJBB2GCfy1wLkEKELAA4AJEKspSd+JILKv77ugeNjHf9ZKiE
 GkHokWg2kKMaM359BbHrxO9JK5Av/C5fUvNvujv87ZI0y8ZtEJ+1J0PwfHSjk36+zkENwMGHlvxrfNr3bmrt6pdAypcLJicfIy0=

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

