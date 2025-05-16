Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CB27A458
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421352; cv=none; b=Ib0SlCjl2zyxuen38i+bQ9T29loV99DOg/YEe0htG4TU/BU0pE55/KCsuWReJ0sZEj7J9akf4QNHa4uVJ0bZNv20zrdU+cIAsiEFShKAJnCnm8oEIggbwbDaQ7jclNJi/HTm1EM4vKE4/22JTDwrShkubwF4MLrwkrjA3WTOngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421352; c=relaxed/simple;
	bh=gmFGQw1mcmth4Z0nnxkYXvSQ6/8e6Nb6UAm7twxFQBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDKcgRnkOCce5p8953SBvwnRlEzx6kjteBJv3/2hcPKA+kaAGIE233gY3hud70vyRcR/Tero7BawcQp/nJZkrP8x31QvIe5ARiFi7HY/oK0XGkvpRc3ob5b5GWYHHXK/DTUk53BfQt8CqL7U71mO9xR+K8UhvfBcGOZerEfBrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=mjKGf0YP; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="mjKGf0YP"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id G071uFdJgJGekG07IuP0hS; Fri, 16 May 2025 19:49:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747421349; bh=EflTBtQKQCN6CudoxInC3Deon4tIbE4m1viFKdR7HIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mjKGf0YPQG+bpwLvYeGIGPpnDkoFyoaPee+Dm1p28qKb2SmfBKTPSPfZKNXk5LB18
	 o+8jUdwKLP0v5+sJuzm8eGrTP+LIlJOTH+QjyywaJIUnykDwMZo9IP6Vj+s5mXwiRH
	 +E/X4rYFCMu6lX6XYB4QMz7fum2BtBsI0rv9V9Qy38qz6/tj797VhxvPtwqsnT+F9T
	 LOoBZrV2q0bKI9qkFMmkkjUXTe/PBc/bvgZv6A2D7F3m1h+ewzwYUezSayn9s8OS/P
	 7tXwRf9/zVfj9L8h4BSjYMupwj0WnnduYHxyo0Lmf/WCDp9XSjxTETEj6dzc5zoFLi
	 UU2dSWOasJAng==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FoOm/Hrq c=1 sm=1 tr=0 ts=682788a5
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
Subject: [PATCH v3 1/5] meson.build: quote the GITWEBDIR build configuration
Date: Fri, 16 May 2025 19:48:39 +0100
Message-ID: <20250516184843.1524925-2-ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfEQ/jt1gyqu6rE1KJWU3O8GsDi1L0x/LOO/qciyuf59c1U4xDtXMfLhCiqXA0RlpfBURntoKHqsNekAovqnwaMSBk0E51dlvG8hsD2eX771OyrEWL1e5
 OUZsdI3IxBSUUEPuGOaZmzIBYo9m++l7EUE1fTCghlAXSuvvyJGzhMXntvJ7fQZ5OS66dqqz9pdiRykFMKZv0a8r0j7Q9DhIKYo=

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

