Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B623C4F3
	for <git@vger.kernel.org>; Sat,  9 May 2026 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291296; cv=none; b=HK+GjlBZrqcaRBA9ru/IuUGoG6K3GVlDz8I2x1agFZXjk2atbwZ1upKYPuttAkCeeVCFq/ovlu5WM8zwEP4J2NPJbL2kU5Bgu1sr7A0AfmcV202KwfbllZLx8ta2uQiWw0XYN6JzPhN1vFymLSLcf6KlpUlmIHnotqTX4sT9Dds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291296; c=relaxed/simple;
	bh=N1GO+lJLXc7ufw1raI4Ha/nRgWA11EPW07g7L9YP/VE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=n1oagsWwixAaNnzYmk2an9l9fsJztdaUE6kGf2HiE0IV/PUctyUiGgx0BOle8OilNS3UeS2ZO91oXUlaiyWxncFmZ1BjyRy3RTZm7TkTzR16dpxB2drqWxdiCGi29+1KkuLhRPjgkTCt1SmZm9ai8cd8FZ+YsptomZAJplQuIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im2MxMWL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im2MxMWL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50fb1ad3734so39446261cf.1
        for <git@vger.kernel.org>; Fri, 08 May 2026 18:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778291293; x=1778896093; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XCndM4x0Pi1lmGNpbP4k19MBxpKKEC9ZUfVw1ivVgVE=;
        b=Im2MxMWL8FdAFFptuVAOvQV3+V6Y+U2I7sgremT+sF8UehcHgx+7QLvz7bGQ0Qn56Z
         uP/ksGHBPWO+dUSylge/JAyo1rAar9KL9f+xccpV7ckz3BnzVUiyvdqHqJc8P/HxNjpb
         vTvQ7TLvUyzTLpGzRptnEK7ODVIu1I4FbxFMbDW56fY2ZHroAvos80ZN9o2Dz7M91eDd
         TjjJqBIguyXGoIvC+XJT7hPxZ4TT4Xd3er3U6JMEtPMBijINHZ+8x+Z6PnzipRzfQPD/
         P/ej/+xOwrIGVxhA0OhY/cJe1/fD5Hq6tiDmYuxtFXtycZqbURCOO1Zo4R6u3gl03ixC
         drxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778291293; x=1778896093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCndM4x0Pi1lmGNpbP4k19MBxpKKEC9ZUfVw1ivVgVE=;
        b=ZkokvFBI+m4yHWW3pF4JRZSV89rFYAtSitIGjiuFR/CTihyk3tA9JREQnIOgqplpYv
         Fq2Tu94NTTh4xG+hPwacdbnSXztUI2BIGpakEQhncO+jKYKDnisMKz2IKRrh1rj9r5gr
         84tUtcDI/X+te701L6cffMLJZMoGq4bNm1rOof/D6LgSXv5Wf0DlNkMME5l0NmsZgCz0
         /bWGfYmSWTGzpD62m5QFuqjZQgOrGpD1HVgQz6tmh+9k0nO197geXyC5tOGLDLULy5gG
         h2VVmGrTw00E6OToQIKGHA6pFTzQcJKNqyiTml+IOFwFnN8wgGB8PfEKqTx7mZyJ5JFO
         achw==
X-Gm-Message-State: AOJu0YzZYwsWJJVHIC1DPrZo0xWPIn1XSfgaFFrJ2q2fQUH7oDchsbdu
	RhM4LnE0MwpjZyKOhdh8/x8ZgD6jEe0bshojOJPJpmDH6KOfMAMA5i9kUerAkA==
X-Gm-Gg: AeBDiesWrv5y+ZgSTElVF8Bl+nyynO+slMpdmha9L1A4vfAB1RAq7GCp3YxGvO3gOo8
	TuZ3ye7+VdVhMsx6RJh2DmFQJmBOpTI1aAiitsXCeA6KLg18wkaamI0tJ79pHeIEcn0ebDzlaCF
	98IJ3tTLro+8sC24CFwhtjXRmMz7lOFXXROAUbOtBAK9lKJMDXPjlgsTkd6wxKXtDc305wqH628
	EFvAjG/j5nBVGdWv21RXO77RyYJ3itnTexlLzxMJ3N6Btq5awBKgYhv6lI3EPbzv0nHzqgTXMAI
	GXF7G9wCfoBYsGOaKDSS+AJOzB1UHTFUvQx6Ht/2yuoAPpJjO81MPt/UmlyAWfwHXmzlJgqTwYx
	13I3WX9cMK0oMNeB6fe7oz8PTtCBqh8uQizf2ggaD0M60sTGpcnmngr3IeBS4nO28PrQtu0ydeG
	KOD4+AZokL8CYGhLwvkROp3wAajA==
X-Received: by 2002:ac8:7d89:0:b0:50d:ed23:78d4 with SMTP id d75a77b69052e-51475b12e44mr130695701cf.5.1778291292114;
        Fri, 08 May 2026 18:48:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.95.102])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5149f5a6484sm8799091cf.1.2026.05.08.18.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:48:10 -0700 (PDT)
Message-Id: <pull.2299.git.git.1778291290159.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 May 2026 01:48:10 +0000
Subject: [PATCH] daemon: fix network address handling bugs
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

Fix three related issues in daemon.c's network address handling:

lookup_hostname() calls getaddrinfo() with AF_UNSPEC hints, so it may
return IPv6 results. However, the code unconditionally casts ai_addr to
sockaddr_in and passes AF_INET to inet_ntop(). On IPv6-only hosts, this
reads from the wrong struct offset, producing garbage IP addresses. Fix
by checking ai_family and handling both AF_INET and AF_INET6.

ip2str() passes the sockaddr struct size (ai_addrlen) as the output
buffer size argument to inet_ntop(). For IPv6, sizeof(sockaddr_in6) is
28 bytes but INET6_ADDRSTRLEN is 46, so long IPv6 addresses are silently
truncated. Fix by passing sizeof(ip) instead, and drop the now-unused
len parameter.

execute() logs "Connection from %s:%s" using REMOTE_ADDR and
REMOTE_PORT environment variables, but only checks REMOTE_ADDR for NULL.
If REMOTE_PORT is unset, NULL is passed to printf's %s, which is
undefined behavior. Fix by using a fallback string.

Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
---
    daemon: fix network address handling bugs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2299%2FSebTardif%2Ffix%2Fdaemon-ipv6-and-null-port-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2299/SebTardif/fix/daemon-ipv6-and-null-port-v1
Pull-Request: https://github.com/git/git/pull/2299

 daemon.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/daemon.c b/daemon.c
index 0a7b1aae44..84a5e38f92 100644
--- a/daemon.c
+++ b/daemon.c
@@ -674,10 +674,17 @@ static void lookup_hostname(struct hostinfo *hi)
 
 		gai = getaddrinfo(hi->hostname.buf, NULL, &hints, &ai);
 		if (!gai) {
-			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
-
-			inet_ntop(AF_INET, &sin_addr->sin_addr,
-				  addrbuf, sizeof(addrbuf));
+			if (ai->ai_family == AF_INET) {
+				struct sockaddr_in *sa =
+					(struct sockaddr_in *)ai->ai_addr;
+				inet_ntop(AF_INET, &sa->sin_addr,
+					  addrbuf, sizeof(addrbuf));
+			} else if (ai->ai_family == AF_INET6) {
+				struct sockaddr_in6 *sa6 =
+					(struct sockaddr_in6 *)ai->ai_addr;
+				inet_ntop(AF_INET6, &sa6->sin6_addr,
+					  addrbuf, sizeof(addrbuf));
+			}
 			strbuf_addstr(&hi->ip_address, addrbuf);
 
 			if (ai->ai_canonname)
@@ -742,7 +749,7 @@ static int execute(void)
 	struct strvec env = STRVEC_INIT;
 
 	if (addr)
-		loginfo("Connection from %s:%s", addr, port);
+		loginfo("Connection from %s:%s", addr, port ? port : "?");
 
 	set_keep_alive(0);
 	alarm(init_timeout ? init_timeout : timeout);
@@ -936,7 +943,7 @@ struct socketlist {
 	size_t alloc;
 };
 
-static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
+static const char *ip2str(int family, struct sockaddr *sin)
 {
 #ifdef NO_IPV6
 	static char ip[INET_ADDRSTRLEN];
@@ -947,11 +954,11 @@ static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
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
@@ -1008,14 +1015,14 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 
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
@@ -1069,7 +1076,7 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 
 	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
 		logerror("Could not bind to %s: %s",
-			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
+			 ip2str(AF_INET, (struct sockaddr *)&sin),
 			 strerror(errno));
 		close(sockfd);
 		return 0;
@@ -1077,7 +1084,7 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 
 	if (listen(sockfd, 5) < 0) {
 		logerror("Could not listen to %s: %s",
-			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
+			 ip2str(AF_INET, (struct sockaddr *)&sin),
 			 strerror(errno));
 		close(sockfd);
 		return 0;

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
