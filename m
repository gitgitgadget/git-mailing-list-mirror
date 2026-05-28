Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA22FF15B
	for <git@vger.kernel.org>; Thu, 28 May 2026 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937025; cv=none; b=UZvf0Ix89Qe9x0MXO0I+oi4QbdRGwvQDnwzkRPrm+HNmK+PQTLthDHAOFYFb1+3bl5jqktuwIx+R484WDXwLpqrZeWXXR5CX884/e1od4bAbZKgBJIFl7ya8Le0Nctx3IHGAiBIcJXmxChR3v1IZAzNazw7tNVxI2vl00d6Cfhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937025; c=relaxed/simple;
	bh=5R9FEOlJ2I99wuMOxohQZh8JPmoEa1iWdKrRFdD1bv8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=STdBA1IG9J/e/2xagfi0QkC3yJWlPtCMHftUDM6RUzQoSntb8oYqOya/NF8qYSBwTKkOP6DILjf5HKPW5qCJ2jtWKjpbgrRPxgBYH1kKklRmeCg+aQI6eHutkWSgzWlMmGBdVm+eYfSV9O8jeRRtFdv1ocfIucUXDJZrHpC01o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5NFYVw2; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5NFYVw2"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e614fdb42so96191591cf.3
        for <git@vger.kernel.org>; Wed, 27 May 2026 19:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779937021; x=1780541821; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ix15tTuEkjkCwaD372/Zcf8YqzVQOAKxfsIwL8CjXc=;
        b=M5NFYVw2ChvqZxgxmAfslRWlg6GA5DgAFIjZGd0hydvfsCjJuZm5mkAUzO+En/Z0wh
         3D5GqFYVB0Y/G+UiyKV225TJWkM0YDzngEMF2G3iesSAe0yYZHTNEfHbpdaP6DWFOG1i
         44Nn/kYSYYYTr+OHITlEjpb8vviLGPU2SGkUsfEPxddObTpFnDDGTEM8djdn/EjL/qAd
         K4UUva3E/NSVRqUyY9E70JivsCIsZq+tyx9ANjv6Vt0Os9k2F1QBbOdC/9uy91xKWQmQ
         M5740bfqtq/ckL0PM1o6nYabDGu1Pq/YvwmST45oX0SIPJSeTJRQhppVPAw3woVxWzxD
         fc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779937021; x=1780541821;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ix15tTuEkjkCwaD372/Zcf8YqzVQOAKxfsIwL8CjXc=;
        b=OnNHUu1vai3KZrJoizazbe0yFi28iV9aG7DES5fPR3/sICuvgzhhT88sXhKMqJFLPc
         b+/LBxeXsx53lrgwxp4kQr/Xf6ih8IKOJmBa2Cpq94fLFDz4Ei2VEufo5dhy5RyQ2Gar
         aQAUhKrJzyDTYO54D9U2tcbNOlt8n4tBPuezdy35xRBGQpvYjdXH5Rxzat7EeicVcBR6
         hlLzWiYYcVu9S/VSoamZT3nAeLbrdIY5K+iXNReE8RoIsUcZURcbGvn+1N7hRlN3FdUa
         Rq4G3QJuXNCYhOjYPYBb0lZyyPTk94YbrtHMhlTibGYW7SPw2ZJZYcp3joWgLGms1drX
         q9vQ==
X-Gm-Message-State: AOJu0YxxqBKNTCFbfDuKySk0Nsqb7wLzIriGxZzHpU55iWhCGjrTZwzY
	TYTrfyM7STqnS0zWXrxX9jiJQw8YoZrYscqicIxdh5l5yFX5ii+G0c8G6fw7Sg==
X-Gm-Gg: Acq92OFOe/JCuHp8yaWQkVWBq7dSDTsQhs/M/0ExLFUJbPjy5lnZ2UKLC9pY+STCC6d
	bJuVZUCTf/SmjGPZbzCB8V+OWL9TRz9Z64Av9NRQdh0n71r7PYmVd47OnbYgoE1qryY50k4mF2N
	eCB/KLn7DxudAWvgR//PMydGEnvI+IODf3KnRKasH1IYE1PQOIZtB1eLbzxSWGekkh+ZWV31KdZ
	l7Ia9dQyaqMoBZSSH3Q9udXpi7+p3HVMin3ufkAc6OONVM2uO06lckSuORH3cel+ds1cs0v0Sv6
	C0Q+bJ5irjXWs946r8G0EFDCAs2Bn4QONow+Mr+7xfmn+c4jhtNzQ6iz0Zfe+d/hS79JQV8fRUd
	YH7/8XG7ZPd6YtKiC81D5C1GujV+9w5/67l/wm8YT+BD30kT+tA5OfdbdctijEEpqEXyPjtTsXB
	zvH2LW2IO0gQ3XdUYy4nV6Rfsq4lIeVjFdn6QY
X-Received: by 2002:ac8:6906:0:b0:515:189c:e0f8 with SMTP id d75a77b69052e-516d432f6cfmr330272611cf.17.1779937020915;
        Wed, 27 May 2026 19:57:00 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.66])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706adc446sm59358801cf.15.2026.05.27.19.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:57:00 -0700 (PDT)
Message-Id: <5c01ec3cadce441cfa48e0499a62e57aa4cc619e.1779937016.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.v3.git.git.1779937016.gitgitgadget@gmail.com>
References: <pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
	<pull.2300.v3.git.git.1779937016.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 02:56:55 +0000
Subject: [PATCH v3 2/3] daemon: fix IPv6 address truncation in ip2str()
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

