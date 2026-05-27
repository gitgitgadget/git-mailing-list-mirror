Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB247B401
	for <git@vger.kernel.org>; Wed, 27 May 2026 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905919; cv=none; b=G8MO7oNfSULyNM0Efn9nZx/ngOtxRSLYRirNvtpKqafd+3Hp3NZGfj0eGZosf53ARqUUI098IxqGyNSeBHvSFUquHiFY20Ac6osRCK2z993qhnvs3TZYrFyWuRwtthTyWy31jsjCcYR7h8R5IIr7szb2anUwI5HjoPvpeJZkhQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905919; c=relaxed/simple;
	bh=5R9FEOlJ2I99wuMOxohQZh8JPmoEa1iWdKrRFdD1bv8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fHYw3kwDgt56VZ/AE3GeqWhrDO7hy5te9mJdJ3MmHwFI3XjvAYkv9tjM5hD0x/lw+CUpmbJhPWPOxYTjvkhGKBz4z5iQnq1RS/SjwI9V32DxltSczE/cY1+UdvDCxVx8xdJ96kG8JbG6nlBWXQtgd4VtwTxQcXooYnctYgGqsJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMlDJF0i; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMlDJF0i"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1353c2f35cfso2377367c88.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779905917; x=1780510717; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ix15tTuEkjkCwaD372/Zcf8YqzVQOAKxfsIwL8CjXc=;
        b=JMlDJF0iTwuOGf06J/KCmxi5JLbIK1Cc8ArHTqtpKW6sy0yyPmENyb2r1qPJLTA8BQ
         lE3XhuELOyx+gHBmZkprY4x6d46J8qtta4xkcCGq9egt+m2MhfK4t4409LQMDomCCkLl
         YfwNhNBB0E7r+ImB9srLQjMu4jSeBVMn3d3d4VrjvertV1+7BfJqNR7hoosMazMqflV6
         d2PdqtZpveGr/RA3164uNLcuYjkbrhEgOcg4au8ADIaEWBxiGbViiwaDlzaPPEbFKxZE
         Hryc3Hhw3VullV/78s/ZAgWqOCttfWEsg5Y25wu5Dw3dvLrDpWnfj4hbdHx7eGMUH6Uz
         voeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905917; x=1780510717;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ix15tTuEkjkCwaD372/Zcf8YqzVQOAKxfsIwL8CjXc=;
        b=gg/yx6e/NxGrJ36rxUMSROAbd6hWXGtXhw89rLpb6xIFMIFGlH4qiAqUHIEuYaLOnv
         EIVgA/XBvo0doeev4j7wz87uHsJtZh/8mgnaU2IykSZBi81mMyqfd1pnqneg0vPSC+Ue
         JWniTaNAM+LPo+gHGlEivyv9GiExjwGJx5oApv1GfFTh1/M9cK25pKEQqCkEQtykfpb2
         2NMYZee2/nX1LqVSB7+YPdJsLgDCy5ymmSloDRTUvTQdzDVCUJi50TKvsdQwMy+xPxSV
         ZymYw1YOKmwBe25uDAqj0uLft7eXD01c4Bf2Z9F2ljGtojEBnzK4nKBazU7gVKTM1Ykg
         XK5w==
X-Gm-Message-State: AOJu0YwJTYsg1lYAO3aQ+ZOCluFW5dRtRRh5opkq67rcQ7wtFVTccHr6
	eR8fJkeNUuzG0cfwTML9RO0FKirSfAmz/jU98C7utXQHVrjWnq+DVALURnuMJr2I
X-Gm-Gg: Acq92OETkNn+Eq5Cugb+zApaqpIBFZI3ylHD7YAlFML6R7ISsbBp0WMwF/NrOwXu/MN
	VS3HHQ+RQr5ppvx/N6drxJOqdwDk0gsREi/aCREhO1hmS+HzztvsjdUfeSZL9ADpwDxdyKVDHMm
	rS/8XoEDTPJIpPSR+FRtuuiUo3JG62GVDUhXqVXTDKMAq5iHyML7rMw7AURZWZTTGJ1UBSfFcHf
	ZH2q3KblDg4b+/jCuVJzOFTTpM8y/Qofsthjn2AMen2SJZ5gujdflvuY5oMP737ZBv0XW2D1gQ+
	DJJpFBKfsqE3lF/nQdgwIyQZyY34jQ3/0IXWEC7zq0vRbk6JLmq/ZNf4Sl6yphoFYDk8UzuOaC5
	1+36+OgWHth9ehtwqBF0jGmymsFY2Wcty5ukjsouaiMHsi8MNZUMurIIf3NDvBtcTuBsvAkQjia
	LaLMHu25MlsM9nqlhYghZRye7i5TkxNoHY47PgxOA=
X-Received: by 2002:a05:7022:613:b0:134:feba:3fd with SMTP id a92af1059eb24-1365fd7ccb7mr11072540c88.37.1779905917217;
        Wed, 27 May 2026 11:18:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.212.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm10018762c88.7.2026.05.27.11.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:18:36 -0700 (PDT)
Message-Id: <5c01ec3cadce441cfa48e0499a62e57aa4cc619e.1779905911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
	<pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 May 2026 18:18:30 +0000
Subject: [PATCH v2 2/3] daemon: fix IPv6 address truncation in ip2str()
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Sebastien Tardif <sebtardif@ncf.ca>,
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

