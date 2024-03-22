Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864D627FC
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145910; cv=none; b=Ge1W8FuW/0z8rfu/hMVRG6jfJTdyvLlBDN78EOspAbpwRXwYrpvUUOtZKQ5l3r9h2nRlmH9jhiQ4ns8qUeRIhD1Ek6BDPajtSGZ4DnPPo7jQAA7O4I1JQtO/kdodZW5Qu2HtZ81gd5DHWBB3fDBJXyUoFBh/Lphceri6xGdZY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145910; c=relaxed/simple;
	bh=veRiAdRtBsVInpfkVAzZqrQjJAVDel64f5U/RNKvBOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9DdckmMGQ+WLHnMQ6EzlXnkGOzG+R9B2xiUJWoKNBqj5yTTPmArBzShrNDreFV9UdlIqbKppxzXggmx2w1NoWlJmll5T+TpbzmslRyo2WPTRc689xfuMsHKKGwOTgQQ6qZFCsQlSC4Q2LboFgMR4OXrd68oEvqXUmV7QV6rNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=gEGMmwcE; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="gEGMmwcE"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 967D360385;
	Fri, 22 Mar 2024 23:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711145900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=08nEv9eP5CDymrnz7VaUDxAh+42HnUGVWWTHQTmfoEg=;
	b=gEGMmwcE53WTlIqbAaou/Z07X1GLqKoTYBlbPRdxqexaSCkS7IbIIpTziQOeTBbPgXbhT3
	eCUl4KH4QxnfZU07yYoe13eRkBs6qgQjAjTi3tWZHFBTNpgQV1NfEChGhYIlFM0CXtaFf9
	GZlvRQwxNpwl15oa54XQpqNL1QdQ/MBPdMxYHF/cI88V9yzhU00YicoKSnEpBoa7z0nvIP
	hFVSn9s9kobSzBdZGMN+Xnj6ZUcAjccwcXUVGCmtG6NgWfGrc2lh9ecPAviizjozrx/Enx
	iKRsJpi7KV7YOa4v5uwKxxo0UdxPZ2RuvODdMyvoX8Ojri73Dn5ApYHgKYTahA==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>,
	Hans Jerry Illikainen <hji@dyntopia.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] editorconfig: add Makefiles to "text files"
Date: Fri, 22 Mar 2024 23:17:58 +0100
Message-ID: <20240322221813.13019-1-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Makefile and makefile fragments use the same indent style than the
rest of the code (with some inconsistencies).

Add them to the relevant .editorconfig section to make life easier for
editors and reviewers.

Signed-off-by: Max Gautier <mg@max.gautier.name>
---
 .editorconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.editorconfig b/.editorconfig
index f9d819623d..15d6cbeab1 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -4,7 +4,7 @@ insert_final_newline = true
 
 # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
 # them in sync.
-[*.{c,h,sh,perl,pl,pm,txt}]
+[{*.{c,h,sh,perl,pl,pm,txt},config.mak.*,Makefile}]
 indent_style = tab
 tab_width = 8
 
-- 
2.44.0

