Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C9286D72
	for <git@vger.kernel.org>; Mon, 19 May 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672143; cv=none; b=AnW4R5CEHDH4GBfbnowCKna5qk7CgDoeoClNtvyvLWbINhcYzuLIiAKYANw3R5+ElK/VhKLnE78zxLSZfVVQVaUQBqlgdGobEXGWXsuvf8oiJ4MaiEQX9QjV1DMX5hRZhsTyl7tI2G+mrL9qHw2j0s9yFQNsXSgDgsHIQqgzt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672143; c=relaxed/simple;
	bh=gmFGQw1mcmth4Z0nnxkYXvSQ6/8e6Nb6UAm7twxFQBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIPEUZjEOE1L9X14eYW6rPNLoz92jYw0oWb8xUe2wXYYacZ+oZgDLPH8ucJTpPRNc6V8AFO11SMGxKvCNenUZ6vaQIXEiqhvzBLX7Z1hhsoxMVyXvQ3CFAsZYEgrJeAOc8PBygg5EQa+qI6RH6zO6VnXBRsI4kjJPsHlfntJ59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=PCO+vFgk; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="PCO+vFgk"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id H3J4um35fEe7cH3JKuD0Av; Mon, 19 May 2025 17:25:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747671954; bh=EflTBtQKQCN6CudoxInC3Deon4tIbE4m1viFKdR7HIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PCO+vFgk7VBIKYqc9eqbVqPx3QEZpst3qxcOajGFLC96THim8rYIyRQcwvMQMlANJ
	 u/craR2J2sTEn1+Wcy8XR8/9oRU6rBjETpAJqBo7udwCtbbR2ll8dmW4vOkDeKCmaj
	 /NIRsD2x3GBjkkcAMy3W3UmMtVG/EvFRfFbnZC86pF8MgT0JH5br7faAdvoW5GZryI
	 y1SPs+hcHeDiKvTUvANy1MVCyNZIK9aqdmKVkbeTES1WMySJjuflF28+K+hjrIztZJ
	 QewAJG8i8QKugvXOgLqgTJNF9/0Tvn7Q+cst5uF07vyo7pRTdHKDDSvNq6o3iayNtc
	 r5IJI99jbYQRg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=BeN70at2 c=1 sm=1 tr=0 ts=682b5b92
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=oRn2WdJ2UU4WTRKwjYsA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v4 1/5] meson.build: quote the GITWEBDIR build configuration
Date: Mon, 19 May 2025 17:25:19 +0100
Message-ID: <20250519162523.1001478-2-ramsay@ramsayjones.plus.com>
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

