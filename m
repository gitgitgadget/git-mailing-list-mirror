Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248310E5
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 04:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749703010; cv=none; b=tcBb1opNbF97SnHAsCe/1hmc5OA3Ns82jgns1D4QI/Ahw7HnGWYb6dqbG0XNZOMv5beqzmnRZMXODYw6DM38qc+917vIV4/YE+crmr/tDqsgjr6uXD2fB8atT42a+jnqN2fezUbXlmjG1Ep+BHuvdZKR3dRwaYxsWmIY0o11yA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749703010; c=relaxed/simple;
	bh=Rn8OwGH8iDmPsK5NwbTuXtwHkhyEeZU6nX8vlSXPYvU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=od0o7u3NVKSH5LGXmeTb1qR9tFuRhCVbKnnQOOmV4thcBHc08nplwcylboL30EyMgLc5k4ORj8YZhXhPaihM/ASHwdgXUTSDNY6A6Xlmf8yP5JprPUYGrdxn77JIPPfJScAkbWB0HaxbVWqHD3afwc+mPKKaJm3JxatsGb86V+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=g7A20xPi; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="g7A20xPi"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bHqVl4hL0z8PbP
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 00:36:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
	:from:to:subject:message-id:mime-version:content-type; s=
	default; bh=Rn8OwGH8iDmPsK5NwbTuXtwHkhyEeZU6nX8vlSXPYvU=; b=g7A2
	0xPiE48CpM5+VJk7nqpiD61FctcFbRKmV/7wsC/3SqVxP/xOO484nVHpTqS1uI9W
	/2K39w9sP2I7vzAfrsr9XW7ueuEYMpcVJJZNX1SnfECuB9r0Q1PvN7Fm3HiMv7cg
	tJX9192RwwShHGuZ/bNU6Q2OBU3WNNIKZ8UMpgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=default; b=
	LZD5QO7qWqS8gXRQZKu/1AbHzMceWiqqsOzdmOiqf+kB8MS9YzWrgnC6Ql5ep9+x
	4B2iwDxKhD//vRvD0+PsZ67/PiFphSKxq4Rf0gphYbNVOVQIy0Cnhd7CT+eToOpJ
	8Ojl17bOv8ln1nv7BNfT6sDmguMRBj7QmuXjWx23TNU=
Received: from humpty.home.comstyle.com (unknown [IPv6:2001:470:b050:3:4f0d:db46:2c79:2a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bHqVl2ky7z8PbN
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 00:36:47 -0400 (EDT)
Date: Thu, 12 Jun 2025 00:36:46 -0400
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
Subject: [PATCH v2] config.mak.uname: update settings for FreeBSD
Message-ID: <aEpZXqTOForaZzbf@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From bdeb596fa6a99c4059df52bbdaed08268100c43e Mon Sep 17 00:00:00 2001
From: Brad Smith <brad@comstyle.com>
Date: Mon, 9 Jun 2025 14:27:39 -0400
Subject: [PATCH] config.mak.uname: update settings for FreeBSD

FreeBSD 6.0 has memmem().

With making 6.0 the minimum version drop bits for supporting
FreeBSD 4.x.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 config.mak.uname | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index b1c5c4d5e8..da592eeaa0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -302,16 +302,10 @@ ifeq ($(uname_S),FreeBSD)
         ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
 		OLD_ICONV = YesPlease
         endif
-	NO_MEMMEM = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	USE_ST_TIMESPEC = YesPlease
-        ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
-		PTHREAD_LIBS = -pthread
-		NO_UINTMAX_T = YesPlease
-		NO_STRTOUMAX = YesPlease
-        endif
 	PYTHON_PATH = /usr/local/bin/python
 	PERL_PATH = /usr/local/bin/perl
 	HAVE_PATHS_H = YesPlease
-- 
2.49.0

