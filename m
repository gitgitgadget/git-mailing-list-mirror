Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D226B974
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421358; cv=none; b=PlrTHZnOb7wt0dB+BkqYSzw75V+4/o3COE8qztcnVq8taDelz07mWCv08GxtymwrvlcXlkje0KPXCnvebirJzZq+LOPoIuvNz0oq3fXxzjbEY82dTiounJhjLuu2odn5t31Cjy8oW+HNJ3Pu8l7GqsOoLz2CCBnz2PGNPIWsudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421358; c=relaxed/simple;
	bh=Nlm++1KiCZCXT5dgbr6Oe5b1bmspXF8bS1+6xxhXw68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcmpxMfP5qXbnYrydu/EmB70cmppOSi3/IIiPxkoKbWkd51efLkZDqXyr/Mvfan8N9/tS4pKUnhgLUsda39VLgqgYvPSFNK0pyvgF3kcyMMtAt2Sx3ZQ8J8PnBBFEDgPBaXGNoq59Xw6++7qLIgHHkkxMrMRpRGqbD6sZG+4Umc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=r/RIS0v6; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="r/RIS0v6"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id G071uFdJgJGekG07PuP0ha; Fri, 16 May 2025 19:49:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747421355; bh=o0vY75iDGt+AggeSpcydxiff6NNtYfMkG9FjdDjalyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r/RIS0v6cVW4wATFVDEsPhH7xv72+cAgqvFeY8EXbgFFwCcRs6DZe2ERGsvRDjLQ8
	 1nBzmYCypcOEyzDJV8/zfi0zgvcOxmkicHG7NiLeU1b5kTdrPz+DyGwnFnqLt+ZEuU
	 y9vTBaFXJcSIuR1onrjUKOUgb4mgW0sIj5MLpnvvMhahirQxwBejQMNd9EpHvHnN+c
	 35UGAPSpGBRmWTDXEHOGd5qELz9NcptdXCR4zxIbB25FxyoZLbTJejtxIDbFd4Dl16
	 bIw436HmrPBh6bIFSeiZVWT45o8qxRfeW51C1PA/pfpddFsww4RmxDxGB02C9FiFuk
	 XqtRTMDudWw6g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FoOm/Hrq c=1 sm=1 tr=0 ts=682788ab
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
Subject: [PATCH v3 2/5] meson: correct install location of YAML.pm
Date: Fri, 16 May 2025 19:48:40 +0100
Message-ID: <20250516184843.1524925-3-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
References: <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKTGokma13EPvLbb4lyh4OcS1NRRotzh9fglWKNHH+UkzDMhPSWnUZlxHkBPANAD4Se4F1+agIp4VsBg0n8WsY3UfxpXyh9JtK4+H96Sb99nUHCFue48
 N+v/p8NvZlicvfz2WaX5v0o39pHFJNad8UDTdDpkc9OMtgXomPpX6a+XeHfJGWLIUz8gnTBuyDsHa+HVYfZO1f6XL8lGb53SfTM=

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

