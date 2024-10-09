Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F717CA0B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474592; cv=none; b=ReIAzx2weTLoTlBwKJ+czJ7hW8hrhHcYhffIkgpSLW7HTUGM5fIOKOlDFouCpHRuz2DzIoOUz6nBiueS1LTzjkXvhEl0OnzZmgZkLGTO63heyVFuo1xu7cCZDQkAuPrZIAa94U9rmqFvy2B1+Z550QkRuWv0gmqcQajK5wvUP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474592; c=relaxed/simple;
	bh=IILCdqy6AEUv0k1Mx337OMrGCi5edaniqQkZp+pXLEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QGd9brtvLEDPU0WjbNcmuxaxP0aeecvky+eM7X3a3AvsTSmGf4J25oGERF4WA9oejicObXWQI6u7LUF1u9vBGgeQvGyUos3jE1DSJiddxYJlJQgh9lFViOPJ1Ipb0six8eQ6eZqxOFwrsaVb9QDauI5OTup9IusAYec1BL5G4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCTgPXhP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCTgPXhP"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99388e3009so554514666b.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474589; x=1729079389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/pRwiPiPM4zPteB/9zuLooh2x0QhJzsa2/pZlWnXQg=;
        b=MCTgPXhPbDrcEcEGGmcHLTDSSR6jSCR9Cc6zuhmeEuLRMDLFUkrCGAA72IeWKZT64s
         fL/oO22d9nXAVHQAk+g7Nu3NObhZlWJKHTUn6HpTyIu3QR4FvJfmacpRXwCQzjvVdkxF
         loF/2An4GD2GVxTEH0sycPQ5F0mRy85nUYLXqyhKrgeG+FpVHjRNvBlfp6q5Ixdxbi+N
         A9dRgSFBE4ZTbaa84rEu/TkrPq9Q/b0EbuqooA3shMxdMziTXyIxItClk3MBs/ltWxVD
         nCRereCw+0kbyryvigWT/bYvHBFY27BCbcR4TdsCXRdTt/3uqKYU/NrIAC5x2WA1P0Ec
         zlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474589; x=1729079389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/pRwiPiPM4zPteB/9zuLooh2x0QhJzsa2/pZlWnXQg=;
        b=ZRa2lroET3yKkKNQBuk9vL+QWAKShLngLGu/U1A1E1h0wQkUO3/49XkqaY/LTffaLh
         jnyUH6qBJoh/VaMkryirGjnEndQl8iXgtVcz+1lBBGxbe5yelsAb+OkVJDAADIYRMDdQ
         cULtaN81QgflFBH1yEAaTRsy3yMfzoWhMVBzTR1UTzmsHtkAVNJ69jkszorHqY/HRWyH
         uH+XgtiylbWSXopyTOS2z5G3WHHFj0Xbng7qvlmHTfctPYwQg0V4N3NOCyp1Tx3K/wD0
         v56OMiM8wk7HGA85sxiNfsiNvVRCuH8157G9NCdKM3xiFbEvz4TahjSOGJ8IQbihGKH2
         L+VQ==
X-Gm-Message-State: AOJu0YxJ8YV4YlIOce+jhMJdm+rbmeOyRkQqvL/CZGx6vWPe1akVQlBS
	HOo+p934W3cS/hV0QORRvlkagy59v5EWwcU/wQLlQYFMDrRzowdEZ6+LUQHk
X-Google-Smtp-Source: AGHT+IH/5JZ0z2mTNV4y+rgoSLGHpJygvtc4KkK/vvuJWg6GGkXehqx8cHjBrksyHajbknAPkxsIUA==
X-Received: by 2002:a17:907:9801:b0:a8b:6ee7:ba28 with SMTP id a640c23a62f3a-a998d114862mr183412366b.1.1728474588813;
        Wed, 09 Oct 2024 04:49:48 -0700 (PDT)
Received: from void.void ([141.226.169.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a4ff9f7sm595800566b.26.2024.10.09.04.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:49:48 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 1/7] compat: fix typos
Date: Wed,  9 Oct 2024 14:49:34 +0300
Message-Id: <20241009114940.520486-2-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009114940.520486-1-algonell@gmail.com>
References: <20241009114940.520486-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 compat/fsmonitor/fsm-listen-win32.c | 4 ++--
 compat/regex/regexec.c              | 2 +-
 compat/simple-ipc/ipc-unix-socket.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 80e092b511..9a6efc9bea 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -431,9 +431,9 @@ static int recv_rdcw_watch(struct one_watch *watch)
 	 * but I observed ERROR_ACCESS_DENIED (0x05) errors during
 	 * testing.
 	 *
-	 * Note that we only get notificaiton events for events
+	 * Note that we only get notification events for events
 	 * *within* the directory, not *on* the directory itself.
-	 * (These might be properies of the parent directory, for
+	 * (These might be properties of the parent directory, for
 	 * example).
 	 *
 	 * NEEDSWORK: We might try to check for the deleted directory
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index e92be5741d..15ab2d1d40 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -292,7 +292,7 @@ compat_symbol (libc, __compat_regexec, regexec, GLIBC_2_0);
    concerned.
 
    If REGS is not NULL, and BUFP->no_sub is not set, the offsets of the match
-   and all groups is stroed in REGS.  (For the "_2" variants, the offsets are
+   and all groups is stored in REGS.  (For the "_2" variants, the offsets are
    computed relative to the concatenation, not relative to the individual
    strings.)
 
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 57d919c6b4..7db3b2a897 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -713,7 +713,7 @@ static int accept_thread__wait_for_connection(
  * Block SIGPIPE in this thread for the life of the thread.  This
  * avoids any stray SIGPIPE signals when closing pipe fds under
  * extremely heavy loads (such as when the fifo queue is full and we
- * drop incomming connections).
+ * drop incoming connections).
  */
 static void *accept_thread_proc(void *_accept_thread_data)
 {
-- 
2.39.5

