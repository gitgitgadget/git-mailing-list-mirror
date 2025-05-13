Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CB2BF971
	for <git@vger.kernel.org>; Tue, 13 May 2025 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164083; cv=none; b=kkRvb6OUED2dwRg1pUKlSq7R5eKKy3UwsRsZXkfRsgVjI4MPxg8X6oXWy5V/opFuYYcoIiJgMRDAx3KEbqW7dhjexq+WZ3V0mxTkm9SXYmbC/bAtKW/QMCbljM7vc8V+KOD+0nz6BEKJE4zT+myZLz1gZ2l6ClkrXRUdLIZ7ECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164083; c=relaxed/simple;
	bh=gmFGQw1mcmth4Z0nnxkYXvSQ6/8e6Nb6UAm7twxFQBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGuMl8OUKXrNi/4DVTWFAW219oeukjE5TEI9EbAKJxspplgxwRms4ZXJVNPKgMujXV5pDV9RYP/eYbKMdzjsNVtL3k13J9tcDtgfo9qNcaAQEZucOeujDR0cLZQXYaFIuPnxeQhTLk84vjoOHUIn5vjrpDAJvclVek+HdeYTka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=shsCTDqM; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="shsCTDqM"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id Ev8Rub969aTZGEv8muZHrp; Tue, 13 May 2025 20:18:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747163894; bh=EflTBtQKQCN6CudoxInC3Deon4tIbE4m1viFKdR7HIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=shsCTDqMatHvBB2qyd/E/D3xVe6/KhzFDedeh5uScHG6Jea5D4KqENIjC6y0oFfZ5
	 moYFFKYo6lDpkUf0rrPEmtXHEEQtUN77Zw/enzoWSnWHCD6HjTNAqyzoChv0wmfNxE
	 eQcCPJwxOjMoS00oy2iJzB3c10Hpsap2zooyIvFC5ivY5OYa94OfpaK+Uqee+Clptk
	 96cyS/fahfxi/D3tdn47PacONaTc0Z5M1zeN2fx9yJtyw/2UG+ew7KMyUvZwwmOw/4
	 1KlrxODX5Mv/U3XfHIlsxSONlEVbhzX7XvB5l3MJqsSdEzb5cULXp0YjkUZ19OkkPa
	 J9hds9+E+jDAA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9ne0vni c=1 sm=1 tr=0 ts=68239af6
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=oRn2WdJ2UU4WTRKwjYsA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: 'GIT Mailing-list ' <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v2 1/5] meson.build: quote the GITWEBDIR build configuration
Date: Tue, 13 May 2025 20:17:22 +0100
Message-ID: <20250513191739.1513460-2-ramsay@ramsayjones.plus.com>
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

The build configuration options with (non-empty) values, for example
filesystem paths potentially containing spaces, have been set using
the '.set_quoted()' method. However, the GITWEBDIR value has been
set using the '.set()' method instead. In order to correctly quote
the GITWEBDIR value, replace the '.set()' method with '.set_quoted()'.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 270ce933d0..48f31157a0 100644
--- a/meson.build
+++ b/meson.build
@@ -739,7 +739,7 @@ build_options_config.set('GIT_TEST_OPTS', '')
 build_options_config.set('GIT_TEST_PERL_FATAL_WARNINGS', '')
 build_options_config.set_quoted('GIT_TEST_UTF8_LOCALE', get_option('test_utf8_locale'))
 build_options_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
-build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
+build_options_config.set_quoted('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
 
 if get_option('sane_tool_path').length() != 0
   sane_tool_path = (host_machine.system() == 'windows' ? ';' : ':').join(get_option('sane_tool_path'))
-- 
2.49.0

