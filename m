Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3AC18D
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 03:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698024; cv=none; b=NEk6wEsiNDeX09AiJLNMuIk6xrF1f4SmXPBya2YGsN0U3waxz5zlJKGk55bFninOf42AKKBhBQHvCgHcocYEAyt7spvlILPjZyAU1sZcVtiPE+D7cly/Ltzy0jNckSpuFFBPqmW70IcG/ED8vCecQxHUg4TJfAB+aeqCiSdxEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698024; c=relaxed/simple;
	bh=9GTyFyLsbr740hsziQW34QEeFWE3Ej2nA3GFqPS83Mw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UWbRka8R++w1QPDGaqupJ5Lm7CVZYyJbwsyAWlT8GzWgie9LYd8vd8WtgrZGR1inaFRCifb1H68ovn45ULOgMCm6Wd+9Z5op1+oWjpVo8ZO30LP6OS5ypmd0Pd5KGVAFm5nngixg3qMqXNMHMJeoDfUyLjYYj3YOOx/kCjdTcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=DisSfGFK; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="DisSfGFK"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bHnfl2Xqmz8PbP
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 23:13:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
	:from:to:subject:message-id:mime-version:content-type; s=
	default; bh=9GTyFyLsbr740hsziQW34QEeFWE3Ej2nA3GFqPS83Mw=; b=DisS
	fGFK7vbdtUxXTJQjujsnQ7hpf3hkP5GpbInCf5o9dfTW8mC+A1MVfD3CfIT0M0py
	DphsufH+dPxdEdDMUZsK8WOIhkBzthfNyZnPdTD8P6PW83ZFND+qRN6SdaKVx+jF
	lR/3AezdYojSKm7/hqcHqyT4rZ1ZDy0Ngc/FK/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=default; b=
	MKNyaLxNWsUTz0paR6KkjF0X57K1zMXdE0yR9HGd1cUCDzafyH0MYUSbfbyH2VAs
	SKv11HlGvo4YSD5lIx/2KKNZQAAanT7PO/FQLkk0IO71QDfWdyHL3ijePIerXrD6
	trz0AdIfvBZYQ8w/L29HeH1TFsktLAStcRFTf+27/Uk=
Received: from humpty.home.comstyle.com (unknown [IPv6:2001:470:b050:3:4f0d:db46:2c79:2a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bHnfl1ySJz8PbN
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 23:13:35 -0400 (EDT)
Date: Wed, 11 Jun 2025 23:13:33 -0400
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
Subject: [PATCH] config.mak.uname: update settings for FreeBSD
Message-ID: <aEpF3ZjNwkR8FssX@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FreeBSD 6.0 has memmem().

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

