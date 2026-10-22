Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792666939;
	b=BUNNoSePAMhtnZwvKEdjGdTTW+NKp0o2vbx6U0qsb2hr5Vd269tQvRpWUBUlQszEPa60
	 ZDFVpdHyZ85VYNe/TsE1fHkYJ+l2heoJkuxpA2vg/lK4CkFYvt2MD6Y2T2nAhHCv2sf9/
	 8aU/MVw13ogJsvYxJYpHx1VBpN0bcjXLvq+f6QFNMT2ZXAzhVnvClKUrlpOYWsdq383Ir
	 j5nKdkPUlqMTIAYT58phX+b4HYyr8nhaEPPQz0OfLsaldO3OxKv9XGTHOfjJRbeH2CHPC
	 8xn2P+zSLuoCj0YaAAxGq4iewb4K3N9Z/JfGfF8q7bEaccTVrzGqpTaHQFVOfR1qHag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=6FSaX+LF/Q2PB1KL0yWe6rrGdksUwWu6c9jbCFFJLx0=;
	b=tUeobcyWjABGrOOQcPyJjTXROfI4sgUw9dwNP+UKJ7nbaVBBBblZNwb7on3Ea+gGt9ZA
	 uPYMpC4LyzTB6jKgb9lHl7oLrl/huKVMZAjkX9oPy0qqarMX0bFNFJYvzahcciTuUr38h
	 7Xp+L8Bo5QNbXgmH1Trk6POucKVUJjlTryh9dDuubJF6+uQ4Htkbjqx9clKNHvLC7Pf8a
	 2xMhGe8NpMZ8oRerixBa0zOqW8WEYXhhjl3pZD1SFFDFvXesi+9tcEiUJFt+5ZXvGzu2+
	 GLUIfqqq8hlplJ9Xj5hNPfuFo0rn6z+pK/dpnV1P9PxuV4gcY+TEYNNPrdbeTXQounw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZJCalG9r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D95606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D95606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZJCalG9r
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso13784726d6.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 04:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792666938; cv=none;
        d=google.com; s=arc-20260327;
        b=Q8LYzX/Jd0T+iv2aBM1Yx6mtRLCi0pc2aayiwxtl8HLcvJ+EbqQ011XDtuh9R5mTn6
         QC3TPCa2ltAThlOrOw1twf38qoWHCvHJk9lptB462AV+LRSID56ZDvKDTEAlZN/5nXJH
         OjmG3ISqMrJpt2ZVK1FnK/+Y8lyRRD1sc43nyT7smvzeFCsSjVTVY5rJNGNzp2O2sxvJ
         Zn6UBvcpkYLs0W5p8qgeu3yLVVv7ZKzHU1QeDGgiklXBzldpTdN/dfMSF5VkVtxkwfe8
         2LZM3jfI3PhkDVW15qXOhyJFLW2Qnu4k/m3xcb7GEEiLLouan7vy47gc4FGsZRRRDmlO
         Tirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6FSaX+LF/Q2PB1KL0yWe6rrGdksUwWu6c9jbCFFJLx0=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Y2YM1hXZ72+YRWSx3paR6IMOyk4N5/nOZjNZl2lIFgNC1zsRvV8ZvzL5u/YgwD0Wa+
         Skk9FNL6dJSAq5A97WY/oJaTZu9qRfoAaG5V6oKhmNKow1r8XjsyPnbopiO0WBkb4ATd
         pZGcUc3MeZ06TxpVGLD2Y97CtklnHz48UbH7UqXoZktpM8gW1wYOpokZ4AfoayL6A1Zi
         vs7lqm1EOD0QVnve6tkVkDzcw50xBqjGJ/P60dVq/N9Xja1ZoSUK/R+V8NYIRow/s0zg
         KhaWPG1XrJisuMwaDUBRXcqLfy+Ujc7/WJrZBzVdGp4zuyReuPfNUjgHN+ahe5CriLOR
         W4Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792666938; x=1793271738; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6FSaX+LF/Q2PB1KL0yWe6rrGdksUwWu6c9jbCFFJLx0=;
        b=ZJCalG9rWuY3YltYDTM5AmDyjKf9YKpWkLzGDbOWVnODZ54EFkVSH9oet2TC9UmOEC
         DZMh3Sin5RGTVV9GPwGELaSPWgNFRiXKZUWnkzcVaX24ZB99IULerfCPgIb3MTklruKt
         3cmePqsf8PIQyRPQLN6ZA8utDO02K3cvi/zVybi3pbDKwfm1+vvmCM0nh7b3esb6/iJo
         m755lzhJ6Tt+5ejQUZv1gvZqYWdfug9lbN/tIGV3zIEeeldHh7L9jr6nmD/2Du1Lo9q8
         5uPg6WRRHhoyP/e0Vdfn5Y8RihboBFp5Gt+1xw3EfnQ2qoDXeyW6ggUWvkaCbDbXY56O
         fQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666938; x=1793271738;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FSaX+LF/Q2PB1KL0yWe6rrGdksUwWu6c9jbCFFJLx0=;
        b=aNnd3WP+fHu8o3QtzMc0Y8/4A8xYEixIbkJdsVe/b47QxYS5dTTgIrLTEcZofay8DR
         ashCCEmJ4hz+3hNhnMpuSlXtdWbeXMJ8CfILVwVvUtPe1569unMW/su0hjO5rTsGnY8u
         e0YXBDoYvUnUhyYwW9YmnmiBATkIw52qfor9IDwOgeXMkWzYi7dv/OtFr0P6y3ZnZbxy
         rpA5rKWI87GC0cYu/HMj+R5zzKLQyUvNWJNiDnfbSGUeNuvAEZi1EF5E0YcuuXyquSa+
         bBFYm5w1RLGcKx36uDsSOA66KOHRrAJEngxdVkJmZ04I/x5Z+Oyg8g0xclvkj2bMpf5O
         FyQw==
X-Gm-Message-State: AFq9FYKBPERE6gN4TG+2VhCYdVg/4fb0DrFfqmPtgHj+9VzFNT5nAsFD
	m5qS/9YXzyQ6acNFEIRMOSvzmgy1uONv2ggtCVlL8dQw0brrdieTOES+0/1VxlCMMxqtNMe2HWf
	jma+hNNlEVHxUd1YsxVuPxWjIL3r2JJNaLPimwvGmPlxN
X-Gm-Gg: AYBFou1cgZeprg9MiHhec0IBGnJkmyziTYWO6SvwuH/ibRuEOJXM1qGD0TTHsUpsYld
	MDPWs/F+Qli2Aw26hgz5D7AozwXQhGred6MXA7EqEufLziRSvky48nH1Z9xUnro/zlx4rwH22Ws
	m2ShZQS1HlaZ/N8UGiJmW1FzFokZ/GlWfdIWqIrZKE5xd/5fy7hP3APm2PGYwSzqi8ctyorv+rY
	wRXsrxZTxbprrGoXpGGLmzHLnPhWOgQtvHbc1KH58UIYLVC9YUEbjld4zpJE92qv7RBCIw/VuAR
	PXgMGLcQGEMCpkXw2LJETM+NO9QXOipI13YeZi6/FE/i9UYseuOzX2MA+3P7iGKcez2ujJNWHv3
	lVp3PKPTeF1zKWpcChbEEnViKwRMiZUtOtsK/T+RMho8u5r8MYAEaQmFWqIoyj5diYcGP0Do0de
	/x40VYuIm6aWMnXoqTzQw5cnaNq2o9Q53wuerbRpu65QlyAhd3Aw==
X-Received: by 2002:a05:6214:419c:b0:91b:5d3b:7abd with SMTP id
 6a1803df08f44-91c12f38f26mr80206396d6.57.1792666937695; Thu, 22 Oct 2026
 04:02:17 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Wasswa Edson <edsonwasswa54@gmail.com>
Date: Thu, 22 Oct 2026 14:02:04 +0300
X-Gm-Features: AclHuK_87Yi42x4MgqYDn5gasP8fxix6xYXtA0NKdb-9SNRedz3U7sYa_SwyV6I
Message-ID: <CA+ew3JtPJuVNC0PR_wY=8Wxp4-JpJ0wCPvm+a=BdJ33QaMpJMQ@mail.gmail.com>
Subject: [Outreachy PATCH] doc: clarify promisor remote fetch ordering
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From fe5f35b00eafa1eb2756178445d3e88c4e9d6787 Mon Sep 17 00:00:00 2001
From: Edson <edsonwasswa54@gmail.com>
Date: Thu, 22 Oct 2026 13:09:21 +0300
Subject: [PATCH] doc: clarify promisor remote fetch ordering

Signed-off-by: Edson <edsonwasswa54@gmail.com>
---
 Documentation/technical/partial-clone.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/technical/partial-clone.adoc
b/Documentation/technical/partial-clone.adoc
index 18718a3840..a1104930fb 100644
--- a/Documentation/technical/partial-clone.adoc
+++ b/Documentation/technical/partial-clone.adoc
@@ -196,6 +196,11 @@ filtered `git-fetch` commands from the central server.

 When fetching objects, promisor remotes are tried one after the other
 until all the objects have been fetched.
+When a server advertises promisor remotes via the protocol v2
+"promisor-remote" capability and the client accepts them (see
+linkgit:gitprotocol-v2[5]), those accepted remotes are tried first.
+After trying the accepted remotes, Git then tries the other configured
+promisor remotes as described below.

 Remotes that are considered "promisor" remotes are those specified by
 the following configuration variables:
--
2.53.0
