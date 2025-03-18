Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EFBEAC6
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295635; cv=none; b=lEBlqdG7yJ6Kxsz2ea/ND3grOACSBxZ0d9mL8bQQiMMwgomvNQ5OQ1MkklzuY5fY+/+llVBErPbiIM3GpPOmaZZtkbEKF89C5r6H0OImfwUzgdQhDaokDETdDPRijh/EqR6Zdolj7FdnLdNf+oH/pQIO6jxHZZGyEsVCHhGi6iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295635; c=relaxed/simple;
	bh=w3M4ISDar+rXjewOKd131a26EFvBdqzUIfjIXcUJa/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNsBo00EY0sAxPDmcQw9IL1+3QPUd58X7a42iAyGhwej6+g4GDyw3vR0iYtY+CZ2ZqLeDCds2GA/4psEcp5Malov2kb2eW0LV+rLu8BXNXitIwstbb6PxGu4Uw4/V83/zEwKGlHxaRm4/LerZY+lwAoLz6hdvK0rBG6rQ+msC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlP2AK+M; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlP2AK+M"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso14333965e9.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742295631; x=1742900431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHB385iXKCd+ql3Nr7n5at37tJpKwaIjwXrXrPw3NVE=;
        b=mlP2AK+MtT4GYl+UO08SwIIoylRaa0NBco9zNLoYSHuW5ePzwKz97S+oyaoAJ9kzmm
         yQkFwdv92nz/mgBrRoZQl+b163bX89y1b4W+RFwPGSpCr8M0yI0yr4e/JGFnCgP6SWpo
         UKoLQjFU0IrPynCayuQYsPAeJ2vM0uu9pzuNV63NCE36Hme3CL4W9JMM3ydzjC/DrcF7
         PArbWEWUo8/rLpWrAjRouBvWtbir95rV9ct9pjAoO1Mt1fq4qH20cssOVlfi/J+2UoPH
         WuzI2a8ERVaQgrFMjT+qyKIMZyZPbRm3Yp420jUavNoigI71N8OaLPoy/xLIagFCBJQQ
         oi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295631; x=1742900431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHB385iXKCd+ql3Nr7n5at37tJpKwaIjwXrXrPw3NVE=;
        b=YEgdn4en2GPu8o3k5+u92ceURByifTSc/LegtpYWgRQSncECgykkbZamH9cZVx+uBj
         P1QPOzKhJmrnkkyyuyUFbY4slu8+/NC10rYWlERSrl8zVGDkNCGIz5RA63NY/q4GHIyx
         lS3VCB8eSimj4z6pLq+ggVSUVwx0dFlzsQgUQlCP1PZY0fj5JL3MSBo3hOzweWDKnPGS
         pbxawWwf7SE9yaCiy3SNNQBkuZtakjkwC2bvZTBEFgCcw2J9L1u64nASoJMytPUMLj+U
         nkma82tCtR6mkKVHsYW44mAXWHKUN/x+nPaybNDITn3FLQht3RoIuDT4DI3kR/BsoP4s
         a8cA==
X-Gm-Message-State: AOJu0YxJiWzaw058+pkqWSAGMzwau7huoxXTL/now+gm3xQmGclr9NyR
	MKgGs9cVzm0ikufDQqCG7iZfaXH3ZXznvWIjSc3UXHxXbZkTywgwRDQ6wA==
X-Gm-Gg: ASbGncv+4dBrYvgFwqQ0N6JQGUQdKq58AZS25ezdIxpbGdNuSTv69f9dzFf/+Gwq+3f
	pscP3RBojLmXXveRNjwhgwJPthSA38Pe+JIz9cgLwE8QiNjmPSAvBBUIo9Xm3O4VxCJaiwPAtVo
	OLlL52/Bz1Kxpls+uRw3Mtq206XpxT/9qFH8Vhg1Q//0PAIZBeOO/NcmrQrJBAwmzoQluqag9f3
	Ol3ETVnwbtbY8480nxn8imkCLkRBa3tcM7VWj/779YpDmJ5f9JuuUamXUSTxhCXI5xTV+hF8HUq
	spHl5WWKBhmZQG+8EjQyEeWRcTCszjwU2qpM/zGU48nVBaev2r9aeOrkWybsDJwQ5oyW0clG6zB
	GLA==
X-Google-Smtp-Source: AGHT+IFkTQ0LVhAxZTLqFVJeOcNbTaKCfBgzju+pYQbVXDxKZQv3capdgzx+6ZacvHErhuNK9L0TpQ==
X-Received: by 2002:a05:600c:470c:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-43d3ba15bacmr13506785e9.28.1742295630547;
        Tue, 18 Mar 2025 04:00:30 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:f066:6e28:cef1:9d6a:ca5b:64d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60951sm131169515e9.26.2025.03.18.04.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:00:29 -0700 (PDT)
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
Subject: [PATCH v6 4/4] promisor-remote: compare remote names case sensitively
Date: Tue, 18 Mar 2025 12:00:08 +0100
Message-ID: <20250318110008.656695-5-christian.couder@gmail.com>
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

Because the "[remote "nick"] fetch = ..." configuration variables
have the nickname in the second part, the nicknames are case
sensitive, unlike the first and the third component (i.e.
"remote.origin.fetch" and "Remote.origin.FETCH" are the same thing,
but "remote.Origin.fetch" and "remote.origin.fetch" are different).

Let's follow the way Git works in general and compare the remote
names case sensitively when processing advertised remotes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc | 4 ++--
 promisor-remote.c                  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 9192acfd24..2638b01f83 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -26,5 +26,5 @@ promisor.acceptFromServer::
 	server will be accepted. By accepting a promisor remote, the
 	client agrees that the server might omit objects that are
 	lazily fetchable from this promisor remote from its responses
-	to "fetch" and "clone" requests from the client. See
-	linkgit:gitprotocol-v2[5].
+	to "fetch" and "clone" requests from the client. Name and URL
+	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
diff --git a/promisor-remote.c b/promisor-remote.c
index 0b7b1ec45a..5801ebfd9b 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -370,13 +370,13 @@ char *promisor_remote_info(struct repository *repo)
 
 /*
  * Find first index of 'nicks' where there is 'nick'. 'nick' is
- * compared case insensitively to the strings in 'nicks'. If not found
+ * compared case sensitively to the strings in 'nicks'. If not found
  * 'nicks->nr' is returned.
  */
 static size_t remote_nick_find(struct strvec *nicks, const char *nick)
 {
 	for (size_t i = 0; i < nicks->nr; i++)
-		if (!strcasecmp(nicks->v[i], nick))
+		if (!strcmp(nicks->v[i], nick))
 			return i;
 	return nicks->nr;
 }
-- 
2.49.0.1.g12e6251c65

