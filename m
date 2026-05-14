Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C592275848
	for <git@vger.kernel.org>; Thu, 14 May 2026 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773598; cv=none; b=WQn7w+BPm43GmOVd9evbI6YO+CgtWwBrzLa1mqlTDT33YYACgu6UVuzTLsA6LU0tSs1rJrGtfCTMejGSdssjJHOCfiUKzf0fNtSoe59rC8ab1akoGa4ERAfYlyddsghYqevjOXROJDq1zIoJALELacfrybYsPePgTLo9VYw4g2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773598; c=relaxed/simple;
	bh=5R9FEOlJ2I99wuMOxohQZh8JPmoEa1iWdKrRFdD1bv8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rANEmehZoqH/UQOQIuDW42rUighK9qkNPrMut7IJ+OdIxExPWAII+3LCzvpECOA2Gy5OpxukmO1iXH2QuN3h1yZqm5LtmXfhMbytndtbqMb7CXA2qtTpdxtbHEJpPMR2MYo1rLt7OnIiurDx1DHILL6W2OjGY/int+cVo4iJ1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE1Lj/lO; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE1Lj/lO"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-90caad2e944so382248385a.2
        for <git@vger.kernel.org>; Thu, 14 May 2026 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778773596; x=1779378396; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ix15tTuEkjkCwaD372/Zcf8YqzVQOAKxfsIwL8CjXc=;
        b=SE1Lj/lOH2EBCNs/yWWGM3RKeY8v/QvUEe9iE02vHpeQarw7HVAWjfbDLtciiklVN5
         +pcVeS9n3sQIybagMW4189o0hpVWR8cobaEXXUDwlSlc+jSOaBgEXit/VBqUl8waj2Fz
         /v99FCRRXzbZWSfXPYKLDgEbIw2krKotqd+CV6MA0WMkrWM5elO9tGpf+EAEopxqGdvX
         w1LjlxkvzRKE8Jon0n8zL38ToOqe16gJ5eZQUJ6rog8Lh3ocHBjQAz2Dg6gUo16lOxDm
         3tcTOoLpwcpCfi2g9P0P2gLKY/j2JEWPVppApziv6ZnnLFWQETevAlbJr2ihACbx5iBY
         n7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778773596; x=1779378396;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ix15tTuEkjkCwaD372/Zcf8YqzVQOAKxfsIwL8CjXc=;
        b=M5imLdNxGLRTy5LwbS+YKdHS7K1rOs1rvy/Ryp8w10b73Ze+CFFBOB65jaxPZLboa5
         EdKbJJUn8tMnW8IooFyaJfh/o8+rIy0JcEJbimFpU7cpEmPhVXN2jgJL4gWMc5EnaUi9
         99ROwj8dhneGkAaJsZzEI+zaqULX1e1SAyn3qQ/pHQbMqlzM9zn0sJHMJ5AZRVjRDjLC
         Wc1zx/ypCIKSmfnKiWtYkreRisFhU29HngTYnxwv41Zdf9nslyAbBZ+IEvhhpqyO9Qf/
         LsGYjqKYpUvgFeHT+B9uCE/CgOK9naF9dkaQVQaKnJ0Qjoe5iWf9GFP/BNpmnbmBZxZt
         AEKQ==
X-Gm-Message-State: AOJu0YxSXkNL2MIuZIwcDNPmIS1CMvaGg+RGkg928p9N/QlmkmiY+wpf
	i0oRhVh2651cPKFaB03nUAy26nssuPzN366lI1/PGN/ZkOnLfPHr2WY0TkZDRA==
X-Gm-Gg: Acq92OFu+Q9FwMY2nb9o0qMPktL06cXTFgA7CHplkKPz4IIhvJthXmxb463uNWpPw2I
	XLUXvIAAoGE1YNsdgISuBzku3hBeIfKtjDJM2UYIZDNfftSxJ0gc2V0XnfBsGkmlbA5fFqaWmrc
	326FNFG2H6x5ZYxbh1YI4ecaAwV3Tk04HoYpLkMnRN6nkR5ZafGNQxaXsMunNdlrFZUtFJpYqP7
	kjP0/VDZ6mWQ2d15pDVscmRWdgYf6olEe/GO0F3/QwLjwh8NTpryk+8J64EbiawixgX9P2n/2xq
	8gs8Kqs/P0IJHBHbObxTXiVefOeIra0Gs77eOaIgRLzeQ0oGvTl6Jwr9u6ffWgA/i3IkUEBnGPa
	0GUr+AuysxYbng1+yQ65B4JjEJHiPmwO2lUMkqbbNmduZ1gUhRcnaRATRc6HOKDjHpNp/ySvhcL
	JW4IFVuLDxHiL4z+YByYg79VjwiPQS
X-Received: by 2002:a05:620a:199a:b0:910:b2b9:19d9 with SMTP id af79cd13be357-911cd859e55mr19335585a.23.1778773596219;
        Thu, 14 May 2026 08:46:36 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.126.102])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba1825dcsm274677385a.2.2026.05.14.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:46:35 -0700 (PDT)
Message-Id: <5c01ec3cadce441cfa48e0499a62e57aa4cc619e.1778773592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 15:46:31 +0000
Subject: [PATCH 2/3] daemon: fix IPv6 address truncation in ip2str()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Sebastien Tardif <sebtardif@ncf.ca>,
    Sebastien Tardif <sebtardif@ncf.ca>

From: Sebastien Tardif <sebtardif@ncf.ca>

The sockaddr struct size (ai_addrlen) is passed as the output buffer
size to inet_ntop(). For IPv6, sizeof(sockaddr_in6) is 28 bytes but
INET6_ADDRSTRLEN is 46, so long IPv6 addresses are silently truncated.

Fix this by passing sizeof(ip) instead, which is the actual size of
the destination buffer. Drop the now-unused len parameter from
ip2str() and update all callers.

Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
---
 daemon.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/daemon.c b/daemon.c
index 80fa0226d8..103c08d868 100644
--- a/daemon.c
+++ b/daemon.c
@@ -947,7 +947,7 @@ struct socketlist {
 	size_t alloc;
 };
 
-static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
+static const char *ip2str(int family, struct sockaddr *sin)
 {
 #ifdef NO_IPV6
 	static char ip[INET_ADDRSTRLEN];
@@ -958,11 +958,11 @@ static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
 	switch (family) {
 #ifndef NO_IPV6
 	case AF_INET6:
-		inet_ntop(family, &((struct sockaddr_in6*)sin)->sin6_addr, ip, len);
+		inet_ntop(family, &((struct sockaddr_in6*)sin)->sin6_addr, ip, sizeof(ip));
 		break;
 #endif
 	case AF_INET:
-		inet_ntop(family, &((struct sockaddr_in*)sin)->sin_addr, ip, len);
+		inet_ntop(family, &((struct sockaddr_in*)sin)->sin_addr, ip, sizeof(ip));
 		break;
 	default:
 		xsnprintf(ip, sizeof(ip), "<unknown>");
@@ -1019,14 +1019,14 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 
 		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			logerror("Could not bind to %s: %s",
-				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
+				 ip2str(ai->ai_family, ai->ai_addr),
 				 strerror(errno));
 			close(sockfd);
 			continue;	/* not fatal */
 		}
 		if (listen(sockfd, 5) < 0) {
 			logerror("Could not listen to %s: %s",
-				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
+				 ip2str(ai->ai_family, ai->ai_addr),
 				 strerror(errno));
 			close(sockfd);
 			continue;	/* not fatal */
@@ -1080,7 +1080,7 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 
 	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
 		logerror("Could not bind to %s: %s",
-			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
+			 ip2str(AF_INET, (struct sockaddr *)&sin),
 			 strerror(errno));
 		close(sockfd);
 		return 0;
@@ -1088,7 +1088,7 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 
 	if (listen(sockfd, 5) < 0) {
 		logerror("Could not listen to %s: %s",
-			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
+			 ip2str(AF_INET, (struct sockaddr *)&sin),
 			 strerror(errno));
 		close(sockfd);
 		return 0;
-- 
gitgitgadget

