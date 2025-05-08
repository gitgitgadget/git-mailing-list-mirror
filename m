Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34178F32
	for <git@vger.kernel.org>; Thu,  8 May 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722927; cv=none; b=dmObF5BqcivlztGfF2bGuuSpEmqgv+IucL3YKj+PBUcHMIrIzzEcR3vKs2yWk+f7aI/8GC4nwjcfTHr4vl7tPhWy1aERjAAIGJC6iRUM2HQLnBeNdhfn4UtujlO6xZss5LC271Wl3VUj8gJq+N9JLzuJgz2ydPOhn2IGhTbssBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722927; c=relaxed/simple;
	bh=gmFGQw1mcmth4Z0nnxkYXvSQ6/8e6Nb6UAm7twxFQBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKTqC1R/H0CdVJ6BwsLzG4VhT94O+rSqHDTSr8c7v9fLZ3P3xu5Omue0cf72aLhTTwz4ZRs6AWmUWOOAaea/9mk55cyRo6MV2mpc2L8ZGMNUnT9zOntXyLY74ObpE21yjrNJBFtdh3aom9acGHpiwBm5gmkoQRBjPrP7FxDj6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=WEt31IIc; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="WEt31IIc"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id D4MzuXnvmeYyCD4NOuuAgt; Thu, 08 May 2025 17:45:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1746722740; bh=EflTBtQKQCN6CudoxInC3Deon4tIbE4m1viFKdR7HIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WEt31IIcnq8I2EV++KlgCMbdQSGD8xQL0QLbV/rkcXsqnDiM1tEa+VGPU4KR5XMSx
	 roQDEAREUfphuGTvu++01F74dSEqTmfeiRV1ng/PuZ0Ddc2xyE/QFolXQI5bdmQ9IS
	 rpsc3DUkk11Pan4dNDOrnePUTiwGgbXlopGYmXe7tScKC+2p7J6TAEw1LNQxOiIKyI
	 bN5YTM+zgCHankmq1rZQd4aGTJw+6US3gRGMHZOFOo0SsxKUf9YkldprSSJWO8FaSJ
	 zHTBzqNpVrW4PYW2X/h80wgzkGzJdo4mjA/EaPV1dgqe78H06Te5n+X2rJGxS7J4Fw
	 rt81P5bJT9kwA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ac7Cngot c=1 sm=1 tr=0 ts=681cdfb4
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
Subject: [PATCH 1/5] meson.build: quote the GITWEBDIR build configuration
Date: Thu,  8 May 2025 17:44:35 +0100
Message-ID: <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfC8X7EZL6LpRFZtpUxctpkdR1CTJ6dvy5MeL10wocZMuUwKv5+D10bDPlNbWiQwIXJxyKNg3JFyyd2yLQ4y27PSIfx0zQIS0jmvQEbBnAfxE1OgI5Edv
 MBS1dHtDLLu9Y8I9RU/8XlTJCNnx68xvQT7JeleWRw81BBZ6rzVkhFJw30o+1MphOSfcwzXSnEmGkqYyTADYlJKVbRlOwxkOrrw=

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

