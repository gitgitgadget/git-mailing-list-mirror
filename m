Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD0BA27
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 01:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749346017; cv=none; b=q0j3xnFrtJfZrzbSRVueiY5Jge9hWL1OkbRHH4TCYd1WIzCoj5qjDIKDQAC+cFyywElVk2uKNYUa0LSTZo5hFwhpx+IO0PwCFZPoMU20FJnf6+VYvahQnilcE5Rg4rV2c0WQQ0My7YNgOWr5Xdh6iP28TusSJ1wV5UfJk/SnBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749346017; c=relaxed/simple;
	bh=emiyNXo/eEDoO/dFrkO0ITcNn9PFHZ6FzDAViC4Pl1E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rnS4yoqjx0IkvA5OfEBV/ypJLcUTNv1dg53OC9x9yXLyFn5GwYUZkctDE5LSchxqcw+pDv8cS2VTwdr/qehMje9m2BflVKF84Vla1qArqTb/hIHyKs02e6Q7MyBA7LTS7RULgWfHABJgJ5tj5LrqgnaiGV9Eh3Tiv7lBRCt7qlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=C7+BRYUd; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="C7+BRYUd"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bFHTV31xVz8PbP
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 21:26:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
	:from:to:subject:message-id:mime-version:content-type; s=
	default; bh=emiyNXo/eEDoO/dFrkO0ITcNn9PFHZ6FzDAViC4Pl1E=; b=C7+B
	RYUdMq7Hylgq4Z/osB9zywJJlzX6CWQPkAR3DmR3ytEYRQ0lJQzcIJEiwY0zzxOD
	7LX8of9ZpKelMjrgPJwwgwRhIJS+UJTutVxAF0z8SRcyrF4AWKquXqQXdB72w+in
	+Wpi9Pv1E2yx07ysFgZjt+R+Pxcaf1sZ8wLgxZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=default; b=
	Q2dd43h0G8XH3zF6INB5vwaoI2V9U6Hv3+quRU3GoqLGtjaSWh07ldMjfbeoMITA
	TX3Qs9zRVEYlECbsDDvgb0ERX2uAPFNUCLxadXm/buRjwSfxJ3qTlFtECsYFmFRt
	0rj6FNn2D7FAFDgqGjpVHgjvQbAfE4QLTpfuVaCG4IM=
Received: from humpty.home.comstyle.com (unknown [IPv6:2001:470:b050:3:44e5:774d:1e76:8624])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bFHTV27Ppz8PbN
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 21:26:54 -0400 (EDT)
Date: Sat, 7 Jun 2025 21:26:52 -0400
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
Subject: [PATCH] config.mak.uname: update settings for Solaris 10 and 11
Message-ID: <aETm3O-FE7EpyoE5@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Solaris 10 and newer has strtoumax().

Solaris 11 and newer has mkdtemp(), memmem(), and strcasestr().

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 config.mak.uname | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 3e26bb074a..b1c5c4d5e8 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -190,9 +190,6 @@ ifeq ($(uname_S),SunOS)
 	SHELL_PATH = /bin/bash
 	SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
 	HAVE_ALLOCA_H = YesPlease
-	NO_STRCASESTR = YesPlease
-	NO_MEMMEM = YesPlease
-	NO_MKDTEMP = YesPlease
 	NO_REGEX = YesPlease
 	NO_MSGFMT_EXTENDED_OPTIONS = YesPlease
 	HAVE_DEV_TTY = YesPlease
@@ -202,7 +199,10 @@ ifeq ($(uname_S),SunOS)
 		NO_IPV6 = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
 		NO_UNSETENV = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_MEMMEM = YesPlease
 		NO_SETENV = YesPlease
+		NO_STRCASESTR = YesPlease
 		NO_STRLCPY = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
@@ -212,23 +212,45 @@ ifeq ($(uname_S),SunOS)
 		NO_IPV6 = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
 		NO_UNSETENV = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_MEMMEM = YesPlease
 		NO_SETENV = YesPlease
+		NO_STRCASESTR = YesPlease
 		NO_STRLCPY = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
         endif
         ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_MEMMEM = YesPlease
 		NO_SETENV = YesPlease
+		NO_STRCASESTR = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
         endif
         ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_MEMMEM = YesPlease
 		NO_SETENV = YesPlease
+		NO_STRCASESTR = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
         endif
+        ifeq ($(uname_R),5.10)
+		NO_UNSETENV = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_MEMMEM = YesPlease
+		NO_SETENV = YesPlease
+		NO_STRCASESTR = YesPlease
+		GIT_TEST_CMP = cmp
+        endif
+        ifeq ($(uname_R),5.11)
+		NO_UNSETENV = YesPlease
+		NO_SETENV = YesPlease
+		GIT_TEST_CMP = cmp
+        endif
 	INSTALL = /usr/ucb/install
 	TAR = gtar
 	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
-- 
2.49.0

