Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079850;
	b=soDOItMZ57c2i4LpD8O+43hUfjCSGFdB6PN994LIB/gH0cyWHh5UlmJxWQK2HtVBotnW
	 BlDzCKvZgHsFmY7dPcwdKq9rNH2R0MfYA+kQnRW+Yqd0ogg8vl1Ay0YYj1XgauvsqBJms
	 Odsz6usFP8sJPMj/n192/eR+djfWxDk5Joj/6YRMB9I3HFNzRNqZQIhkjdIZs6dGmY/ZP
	 5tD5OPjvAhaufiup7EIls4h5GhSKKM90R2/ZD5N7RqQ01NjCIT0L4l3gi6Xgy0VFbncml
	 JaQfZMwjZQwsYErZXQzdm9oxqANIA8FbwSdUOOgMOg/rxUlEupdIK3jIX+KOwDNx1hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079850;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/smNuqwdwzmyzQIz4FP6HocbgYGAnquBpJqolHYaXNE=;
	b=Jw/qqTZ3gDuOMP2AUGujI7Jd9oVRaAh9MzmFFjn1CDbwZ7c2MwMMK8Nv+D9VZVPfAZZx
	 /INXHojF490b8noACRddb4upkEkdhbqQGvMYCGSVvG/uQSiEFhnnC2IANVnPUaziaH1tn
	 DDJdrhRAkKRNQleF7q4MqAWoo3hTQjalWWEFx+FJJ4y9+sljKOpCw7rycAOXmDR4V9HQ0
	 HhH/vwbEczwh8O1J8er1L5xNbDDoHtxyzfhEsGBNZJdNnWgzNU9a5irYmZS0VNoqTr/w6
	 ZECKUxmqvcP+KZtF/2ZeKopsalAzc5C8tG/V0lefrF68kc+NMNIxHo8aU8WaBz46loQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=vdwaa.nl;
	spf=fail smtp.mailfrom=vdwaa.nl;
	dkim=pass header.d=kpnmail.nl header.i=@kpnmail.nl header.a=rsa-sha256 header.s=kpnmail01 header.b=GvyV76wL;
	arc=none smtp.remote-ip=195.121.94.186
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DD606A331
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 19:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D0DD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.a=rsa-sha256 header.s=kpnmail01 header.b=GvyV76wL
X-KPN-MessageId: b6b5ae3a-dae1-11f1-87e7-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b6b5ae3a-dae1-11f1-87e7-00505699b430;
	Sat, 07 Nov 2026 20:30:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=mime-version:message-id:date:subject:to:from;
	bh=/smNuqwdwzmyzQIz4FP6HocbgYGAnquBpJqolHYaXNE=;
	b=GvyV76wLRlA3E5vvTgC0PIXb9bRor9OG4wXEtgEammDrE4wEt9uYuwhZo88HmpxJNGkU61hFb8DbA
	 tFQg9rTCdlvi/4vF9H2R9G/ljJq4wqjdkuu0xQuATAYAepc6W82SKa6U+IDZ1KJ3ai0ziOP2Mcytek
	 9sN/WFB7M0m6L+Vk=
X-KPN-MID: 33|i/PtZ2RHeyqSjvvh2ezRnMC0nIcY5V5+P06d2Cv0FrUqy3JoH7A7hT5HpdVqaaI
 2y7W7eDe78N+dNvFfCwGdqoUgIJBbmIDqgxOHHJBSRQk=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|ADy6SLm5Jux4knA/AlKsYTCap1Vw1zXHaI7xvFEo0LaDjAPyPCGRinaVrCkIZpJ
 SiMqpvnQ+Gx5J21Um17UjSg==
Received: from natrium (77-171-66-179.fixed.kpn.net [77.171.66.179])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id b6a833d6-dae1-11f1-a6e0-00505699772e;
	Sat, 07 Nov 2026 20:30:39 +0100 (CET)
From: Jelle van der Waa <jelle@vdwaa.nl>
To: git@vger.kernel.org
Cc: Jelle van der Waa <jelle@vdwaa.nl>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 1/2] history: drop redundant strbuf_stripspace()
Date: Sat,  7 Nov 2026 20:30:18 +0100
Message-ID: <20261107193020.583215-2-jelle@vdwaa.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107193020.583215-1-jelle@vdwaa.nl>
References: <20261107193020.583215-1-jelle@vdwaa.nl>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cleanup_message() with COMMIT_MSG_CLEANUP_ALL already calls
strbuf_stripspace() with the same arguments.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
---
 builtin/history.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/history.c b/builtin/history.c
index 43ba76f5a1..cdb0d30784 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -94,7 +94,6 @@ static int fill_commit_message(struct repository *repo,
 		fprintf(stderr, _("Aborting commit as launching the editor failed.\n"));
 		return -1;
 	}
-	strbuf_stripspace(out, comment_line_str);
 
 	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
 
-- 
2.56.0

