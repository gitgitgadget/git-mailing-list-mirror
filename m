Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BBA20A5C6
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295633; cv=none; b=qhTy5QX3Y8R01FZYYrVPQwax1uodt4G43r9WhvK2PTkc34bTorVYCmFfWNqe1YDgJKP06rilYmMPE9uCmv/+yNX/HzdH9VQfpQgyvpXbwnSYVlJoaqRhC++ECWWfL6Ic1lt8LIbEs2tfUYgGvZU5s9kHGusbpKYgWlTB3zLsHes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295633; c=relaxed/simple;
	bh=2u1IUGEt1lst84JwvtOyz3ClIUJfRs1x0VZYZBoH2jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpjRnGC2jQ1oC86AcF/FEXx5yZg+YtlHauTOHDclWkRCO44lFLjYAzNs0/S+kJ1FG/pbzsKvSVAH1AGcm9Imv9Qpz4gDFs5lKLQtB/faj9kQeDfV8qeCB5XzvYIpVnxRcYbpuBxolckDehVSc9cBF4XQlNdhTxhYkA68p1w5OrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neWOTbtC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neWOTbtC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso31117015e9.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742295629; x=1742900429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lUCPRnE/wxdQRspVOtQR39MTq//CJyA9np0Jqr+a1g=;
        b=neWOTbtCJ4Ti2lCMevQLdMjPiHhU7LJR+WB4A8MunNm1zfENIU7JqNvz0sVjRWEYpV
         fuDCL8f28HVoTzhiY20HRnAKLrhvI31xb9eeNpp0+gokwUp7U4hsTFyeA22/9ozS6/W3
         CChUyfwElwygP4XI2Wwn4SkWPnGREsg10HpAhsQJ16dc3KQPp8FEF2c8L18BoX60uiCQ
         w5Ok5qPHu1bGU4frKzMcsM1VMYpo7xt6ExQpZJh0XQHo7ERSJ3vXqcIyaMN9gBAY4plw
         CCEWcWlvua6qDLHpUpygM2VoMdG9wYjRZCafymVZFyiRNnYVc4NFf9qnlvlHQk5pW7NY
         0yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295629; x=1742900429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lUCPRnE/wxdQRspVOtQR39MTq//CJyA9np0Jqr+a1g=;
        b=etIhdVntJIOE4c1pK5wMZkL3uIP9VNW3/T17oMYTns2rEGfWMcX29AGpn8mw4Vqjay
         Yo5YWwWD+MXnqlaLWo5avmq+RaunUW8/WJS5KhfHcSdIEQ5aS3FKt/ESYQrEcOxAzmo3
         uxXWS2CN1fp1OT9jglFDw5IXLDyDA1cGDWC1QB2lqM0Z5wtQ1GMeLB2AiO8G1YuF75Mg
         VKQAH3Jm7S/jI1ZBOcuCwZ5dAet5oF11VQG0ysa7fFPWey9lv8m0NjAaZVmBJluyOF+j
         QuSGasfy8dgYkSMybbSy4smqAB68Z4P3jk8L8BZQqCiIS+LZ3xjYdtf2yBi4iZvt2d/1
         9oFA==
X-Gm-Message-State: AOJu0YypZduwmvvDvqJTl3Zc63EqYL5vK3N7BG0tyQX+b9Lsq4ZXAF+e
	Byie2Xi5j6fTQv74XCX0Qgka14PMaYup/LVqypd0TbohxC/6Pa6Lqj/Jcg==
X-Gm-Gg: ASbGncuPNFLwTXF0g9yUsAn/9DYoznDU+TlMMY+CmFPvKVSTnw2G7HK4qnPdvgA4mGY
	zzHa57hkBfwNT1PzKPpeJ/Ko2NWCvglAfrRhAzSVR+am/5Cd+0wes+5PnIjlIL0Mt0rYO5TMtQY
	T/l/CV7x/cIXk0yIibfylH7HY7u5hEgyC0895uWnznw1xxEaAWZ/r5sJ7B88oGlBfn/bRM9ned4
	KZ4F9yvQXHge5PGTWEwKeQFnSU2P7XHHZwBs81CQr7EOaL9wabcKj3qFFXxe7SvzLzh/yUfIGTk
	2fS264fN2omg6STk/G5lyCa8wYFVmcGOhvzca8gs1uIeLgj6fnT5mbf1giqAghm7pLT8mNVLoSM
	A1w==
X-Google-Smtp-Source: AGHT+IFctPWrXEktSOEOq6XutGq4fqGjp/OsH/XxV8dxIuvLIPFI/IEOv6I3SZCsAorFLWla6I5quQ==
X-Received: by 2002:a5d:64c2:0:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-397202a1acemr17276825f8f.37.1742295628776;
        Tue, 18 Mar 2025 04:00:28 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:f066:6e28:cef1:9d6a:ca5b:64d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60951sm131169515e9.26.2025.03.18.04.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:00:27 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 3/4] promisor-remote: fix possible issue when no URL is advertised
Date: Tue, 18 Mar 2025 12:00:07 +0100
Message-ID: <20250318110008.656695-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.4.g81387f61c3
In-Reply-To: <20250318110008.656695-1-christian.couder@gmail.com>
References: <20250314141203.2548803-1-christian.couder@gmail.com>
 <20250318110008.656695-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the 'KnownUrl' case, in should_accept_remote(), let's check that
`remote_url` is not NULL before we use strcmp() to compare it with
the local URL. This could avoid crashes if a server starts to not
advertise any URL in the future.

If `remote_url` is NULL, we should reject the URL. Let's also warn in
this case because we warn otherwise when a remote is rejected to try
to help diagnose things at the end of the function.

And while we are checking that remote_url is not NULL and warning if
it is, it makes sense to also help diagnose the case where remote_url
is empty.

Also while at it, let's spell "URL" with uppercase letters in all the
warnings.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index ba80240f12..0b7b1ec45a 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -409,10 +409,15 @@ static int should_accept_remote(enum accept_promisor accept,
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
 
+	if (!remote_url || !*remote_url) {
+		warning(_("no or empty URL advertised for remote '%s'"), remote_name);
+		return 0;
+	}
+
 	if (!strcmp(urls->v[i], remote_url))
 		return 1;
 
-	warning(_("known remote named '%s' but with url '%s' instead of '%s'"),
+	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, urls->v[i], remote_url);
 
 	return 0;
-- 
2.49.0.1.g12e6251c65

