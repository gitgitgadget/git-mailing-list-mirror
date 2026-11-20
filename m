Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176178;
	b=eEPSQAr1ux0a8OSkfeeiDL4GfrMr7CqmefpcozU1Q7FhIi+yIHwc8vDkvyZPyTyw80Og
	 qHp59kzDoRpsqQxMSpSBO2AMbAKVg9J2JT3gXwJ3uVb1VMKUeG6HJv/fMvUlJYWmA3DIE
	 Fwpo+SuDiZCPAr06C+6mr6MYwwkC7e6HZ7MQRNUOFsr3IDhsXVDDCePgSNkiF9okQfeSn
	 y/ZY0TePETmBXcyxHmwU6rUhHJKhUpVHWQKiB+LeW/5147kaUg0erS2VIIcB4tgNp8RT+
	 hyN7hKRJo0hitS7tmGZLFy8kzCSF0R6W53HCCtXj2AgZZR1bvxJujM76z61UH9RMLLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176178;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ceSsqCiXo4+R5DobelLKYBpkTcC3lkRwdnfepLxkqrU=;
	b=phKBMlCedZwEgxSqkXQpHRDAFdJMdiVEq0823xfB/7cIn61Y+tyfd3w68Fl/W571WJIa
	 kd7SrxG74GASF2b3Y7bBTIRlKy6E3gA47QkA1B4oW6JLAuUkeEWbyJZXkZOJZWCztZyCY
	 LShwGtPC1PJY4ibL1LxWsDRcchgAy7ywYbYIsGTNKoAR76RsGOyLSRFN3POUH9+/SjP9j
	 CgHyGn9Ap9MzGDATil5z3bsEShrNPmP8m/tIkmcWQaJQ1d/7WuebGv3WM5BbI/7H/fiSD
	 5TASRsgkNMXEonXQ2zfHJVDy5C/SVd1xyLQ1Xoz9EdRgpXEp8NVPW+mi7wfTb2Gow9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=otEqUS8o;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OxeHRIMY;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9A606A326
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB9A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=otEqUS8o;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OxeHRIMY
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A1371400248
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Nov 2026 07:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795176176;
	 x=1795262576; bh=ceSsqCiXo4+R5DobelLKYBpkTcC3lkRwdnfepLxkqrU=; b=
	otEqUS8o+4WMEfWkTdmGQKibk6ctFv0iFfz+coC7vt5wKRJSIiTdkO6XAho4jCtf
	tprHV0T6/wboACvfL7EZQ22Oj/8AILKcdyyD3lYuVncOEMWsyaqn4kl0FnZLyOmY
	aCZhWnAb9FBHaZGJg3rcg24xAwSSZByAST1BCJL/bKkixZffIuODaKUgqE/Ar2lM
	P31nNr8vxKswB1DGhQL4tCEKJ0ZUXRgUymT/2Yg+K03QXLqrIyvO04nVbbDwkkfV
	39BLmwrPtUXjSrRNnTAgj3MMILvuuWOky5hNtbitFR1CHfriZMAZfP+exqbGFV1+
	XL7BaPqx+hapVDQUJPuyQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795176176; x=
	1795262576; bh=ceSsqCiXo4+R5DobelLKYBpkTcC3lkRwdnfepLxkqrU=; b=O
	xeHRIMY93ilt9Mr2jNjlmVqQwwYo6872DmLXoyqTZYlG8oHNWKb2zOffynWbymQ4
	muJPUmYXWFyzku3odkYZHYT3h1gBdIfkzJGxqcU64fEe5FbMcX0zCCPQVYDxRoNL
	tbqEOJceayZurj17A6139sHhaeuHSkfiouIYpUX1d78jtmWOz6c7COC4/1IKO6XW
	6YU3jcNeAu6aZOfC5BgVVcyRNSWnceuS+q+f1OhEP9wJ/jeJcrgmyCw8+pVqtS5R
	CpzK46UR2vAzYvvoR0MZHQJBU2K1T1/RWpjQWljC9875il7t7UBxFB7y3Ed4BQ+A
	dXdkwxxlfFq46WSw/nAmQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795176176; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:W8keRDRkoTLyZHj5EJEuv5grzPjKKebhphs/ntaCxG1PBrv
	uvjr1MsLIUB7tFwNt76TmQxvYCkNgWjEYXPtzEMf553/+jZwNXkZJLtzoek7rmqL
	WIAQ1OkL3Xew1Grs3a3syCU6xhhj95C4Kt+/pnZTs1GyYJJEiEoL6VXATb4dP/IF
	QawcIuOif9a8AJsqTR5tYIrJPwNmeHxrhnnPnfU8ITdM9ffTuJ8gZClZ+m9Lcz5C
	IPEK/+3QKOkj0z2sijlJCZ+JAEhZSKDRjvrGIFDxfEnPqyE+YdXS6k/iB9hFQWb0
	e1jz4WShmyPuhS3didHEx1PNI9AvDsobZ4XiIIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:X5cvQ6UwFOzk2CRl3+/0DEL066eENemVnRgTlXXGY+c=:UTHwyTWCCKM4P9Ohy+LhB0Z4nJuyJuK3P+SuWV03X4o=;
X-ME-Sender: <xms:8DYAa9cSq7JpoMVYg9eZ4orHpl9xe4KN1iS_cotBrMas-GdCVdLL5Q>
    <xme:8DYAayJEmDzuZGgq2c5M0A0iZnmsO32-t0pb_lUvkmq3YCZRmsvicsYS2YrWDBCs7
    HDkNRrlCFioB7MXArZAUaINJmwvfDTyAFzGM-3S2PzH5hLepPenHA>
X-ME-Received: <xmr:8DYAa8L5hWFIMhFxGfG_SMRszG58JMFT6TaH9CXYYNkIbzqcEQRvEeYYs3mntKIAR_savYw>
X-ME-Proxy-Cause: dmFkZTFKfMoyZ8OsQp9Wthl1HVhqbad1g1+0FOaTNrvwg/0Vd8GZUZgulm8uuAavm4txZm
    rO3CHbCoKwYYBbsY9QWAQ06x8eZrSeU0ua3vKZjzTEfsCFacma4xkKSA05wxdhhlOVlLsS
    ceKeJl0kUvaNeEYJ9RYdq8nkFwGnncNUCAN/DQ+m70/sQDBWWaiEw065fia2LIgNHUXYJQ
    9SR479uoFdaE+Y1cVkI7Ky/y56H5gBMNB5MYoU8ogwGsgTjsIoy/Q52Y+bAfZOXcP9bJwi
    aS3rRjTuRGQQz0YREwLmG9Ffr8hpmsvEZBGl8DenEqVkHuPRsEzB9OWIPoObsNzcc3ycVq
    Tv2LgHS5UAhNZbvKseWPs9ACeg9+lt6xUZKP80nwsCDLUMMcZpkEuMTrymnltQE/BXAi9A
    g/UGonh89w9jydCZ4ctXeeMtIyWQ7aDnQiRh7/ZGot0CQiJRfERMSrA3Eapep/iTHyJ/2N
    VreSIrLZRZvHIvvusPU/CWhKF+rO4nt2Wkcw2bof7p7QZFuYHZBT6hU7KmhAHWQoN+KYC0
    UQkZyPYRQlNsPCaFdoxUZQV9Rt+COK+2mU+JXm0HfGbjh9wYtBBEcP48FYEc3iBahI6+/9
    vJd82QYzC8eUmoCWRi09cl7edHTsSXdhadqHiRnAjDNFCDKWzVAifGzY5xPg
X-ME-Proxy: <xmx:8DYAa8Ekvcdbx8Vi3HM0QJ42_tDr3itLP-p8wSRTuN0zZcSDfgy6CQ>
    <xmx:8DYAa5kBn9scDbNzKcsM3Ki_MahxxywQQgSdo2irD2mTe_q7GCa9Lg>
    <xmx:8DYAaxIR2kbSXmlIROM1R24fGEEjKuyu3pIIU2eNZmtm30u_xvdb5A>
    <xmx:8DYAayZ6xn2ckWf1RaizupuErYx5EriG_1msebYgg4lBgxwy6HphXg>
    <xmx:8DYAa3MmuJoH9CEdZ3RAAjdXw-5lhaSSR5PS9AdVKk6cwJENeoJIf0S3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b32e99b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Nov 2026 12:02:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:02:33 +0100
Subject: [PATCH 6/6] packfile: skip closing packs marked as do-not-close
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-pks-packfile-global-statistics-v1-6-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When closing a packfile to maintain the maximum number of open packs we
completely ignore the `do_not_close` bit. That bit is only set by
git-fast-import(1), and as that command allocates its packs manually it
wouldn't add those packs to the list of all packfiles, and consequently
we won't ever try to close such a packfile via `close_one_pack()`. But
that feels like coincidence rather than proper design, and the result is
rather fragile.

Skip over packfiles marked as do-not-close to reduce the fragility. This
should not result in a user-visible change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 0d5647c74c8..86ef3a79d9c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -414,7 +414,8 @@ static int close_one_pack(void)
 	int accept_windows_inuse = 1;
 
 	for (e = all_packfiles.head; e; e = e->next) {
-		if (e->pack->pack_fd == -1)
+		if (e->pack->pack_fd == -1 ||
+		    e->pack->do_not_close)
 			continue;
 		find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
 	}

-- 
2.56.1.831.g720f3f5937.dirty

