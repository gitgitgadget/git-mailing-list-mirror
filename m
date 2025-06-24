Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB092C3265
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774129; cv=none; b=s9HpOx8kqKNxg0zR2f9HqFS6owKqfnFdFwccMNhZmc3wIqqeQtPXtNcV4guGB7cANeO6VYWlrNiH7Yk+SnkoukubSq74KS3oarka6BRU6+Z2+77S9XuShbp0mKOe/1TY2PIj1cLKcOd0BK9sTr9juCQzQA7R/F6DqTTdq2uGIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774129; c=relaxed/simple;
	bh=qLck1AfSdM/vz+8aGAPUXinXpPIjOyZMePopQ6/qitw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=fYcEUPEW5UdsMVq9zzZL8frmMYz1HZLG16Hkku3T7f6wLdCt4HQwM2xNOT+T2FoDe9xJA659BKGWJmRBb8GtgT2bD1CD9ZqmL39ZwKAMcuIFQF+B6cuPkaASFK8ZOCzZhthKruWxi0pTbgCgQkjyQ/RD0IX4t8fVktrdCrziopY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+mnambm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+mnambm"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so4215294f8f.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750774126; x=1751378926; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClZIZ43LI/oQFaOOgwkhcNw8y38PDc8c/fiB2gEff7A=;
        b=G+mnambmAzLm9YIe47pXK1cXwib/51V8xBJMaBjP/r0cvYRhE2xG3QF1eO0CkptD8C
         uOuUQLUxCqylrhKYWhPPqHcCo7CO/6EuvD5xQofoI5Q3sBQ6sXBY6wedMpPElZKupurd
         UDoZ/L7BcWUAf74/AjYM6WzUHhtfUL/IZmr4zIFhRO3vH5LKA1lQ4VWNl8xeG0mGIRXC
         BGiFpiFeOBdwJYyH89eFESyZRzortoC1PbsT1IjdlL6kDQF54DaBzuvg//wKm30Kj2w5
         yvu6sGIH7OukQIytLmQ8iXl1IJ2RBFd90VT0O8ddkg7jS3jmPAWw69CZklsmAS0/dzXO
         mjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750774126; x=1751378926;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClZIZ43LI/oQFaOOgwkhcNw8y38PDc8c/fiB2gEff7A=;
        b=YMdbX/KIqmLbrepCkkcq1zRj9gVl7yHOBo2jNkWyLvoBIRI53fQngO8u/PNrAUm4zj
         bwKnxHw+1DYk8nsnLF6ZpyH2igDuRDN1P8kIWuT2kRAoGb5+XX5VVTHr7juY1ZITQv6A
         LgVCdsmwItYKhUbUBM5ughIGfWzevilJ0rDcup3kPcuK6YXtrqezy9ssmSdzAbDwQz8N
         aj1C6PTH5IOejTTp1WRhNpPZgugFtWCg0eUyfivzgr7dBMAyyuUa6VsoVnvIbRPQ142j
         e36FInLmKp3A9kV+B1eJJt8+4ro+cG1cOfDaxgtPLeSFXlcUjXoy4g/jWMpQIGiwtP9E
         i7Nw==
X-Gm-Message-State: AOJu0YyWD1oCH/6/CvZp+KeE27hyvPjyqB54Kp+N5Sfs43V28DAR+vmA
	G1Mtl8cDwel9VDeJ6dRKBgNVBdHECrstem5nc3eBmAhWe1ZsK1gaYWrIDtk7Lg==
X-Gm-Gg: ASbGncvSYyyij74UPdI7y8SUGvDZ5+5KDJy5ZOdrB4s2MlmHrkgDBdrKo7JSPgTvWoG
	ZFhoULXACxOjAVg7v6xITvF1b0ufTW8YkWwC16/1aN5swcplEb9YZegXXZMSGjDRLmyu3wSVkI7
	MwoMyNsnp3noZhsAQ7xf3KU6py+16bxJSDBImjJYoVv2ZaLyhbPf2XqMGAHW/8+K4svlGXAwrfW
	t3yeVZg2isXqzTXnEVOH7YeKCTWHW3As9wHbw5YIOb4C+4qtNdSBY7FRKUHKDOJZXh2o9cMnVrV
	FQxzBlb3ZGQsuAIWn9RTwUwETdp106nHgKTtuYUS6k98MfSKUhzuJY74Gudpx+E=
X-Google-Smtp-Source: AGHT+IE+fcrXJTMRToSrFX3aSEc8aTqh/C9spLiI1YOgwEqsBd94WQpAYsMA+9dYhRfyCllIjY4pLQ==
X-Received: by 2002:a05:6000:1acc:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3a6e720de4emr3056990f8f.24.1750774125255;
        Tue, 24 Jun 2025 07:08:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45369eae840sm116729185e9.38.2025.06.24.07.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:08:44 -0700 (PDT)
Message-Id: <2e8c4643a60e354d24bda9bf364e1b34ce1c45ae.1750774122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Jun 2025 14:08:41 +0000
Subject: [PATCH 2/3] daemon: use sigaction() to install child_handler()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

In a future change, the flags used for processing SIGCHLD will need to
be updated, which is only possible by using sigaction().

Replace the call, which hs the added benefit of using BSD semantics
reliably and therefore not needing the rearming call.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd5789..d870ad2f63c1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -917,9 +917,7 @@ static void child_handler(int signo UNUSED)
 	/*
 	 * Otherwise empty handler because systemcalls will get interrupted
 	 * upon signal receipt
-	 * SysV needs the handler to be rearmed
 	 */
-	signal(SIGCHLD, child_handler);
 }
 
 static int set_reuse_addr(int sockfd)
@@ -1121,6 +1119,7 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 static int service_loop(struct socketlist *socklist)
 {
 	struct pollfd *pfd;
+	struct sigaction sa;
 
 	CALLOC_ARRAY(pfd, socklist->nr);
 
@@ -1129,7 +1128,10 @@ static int service_loop(struct socketlist *socklist)
 		pfd[i].events = POLLIN;
 	}
 
-	signal(SIGCHLD, child_handler);
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
+	sa.sa_handler = child_handler;
+	sigaction(SIGCHLD, &sa, NULL);
 
 	for (;;) {
 		check_dead_children();
-- 
gitgitgadget

