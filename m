Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296239;
	b=z6uC/Uul2GDu1tnScmN9f9P2O7Ijtpdn5W1cp3eVbJn2z3zeRRQQnPm3lA4Et6hXWK/A
	 J+norsk/K8WTfdfJf91u8yaTSp+r83HcI7bmuc2WjAymSVmzGf7Hop6zFp7VBawM6F/0l
	 Yd9G6xWrD58TElAcqnp08yWh8kIFv8CFQ3Xu0+gaB+9hZHBJSnhWpKw7OJ10m80sIbHjE
	 k+Uh7YUu/r+2GjS0ok5E/qKOLJb3LBGK30+eY7KZGS3oJVAIUyi+Aop0DzzpdOAmy6n6Q
	 QzXuwDkv0GrsCPGrYfSZLz6PjaYjvFMsnTxz6iadRgDDrlkLlGXB1fBrjprUzHFqgCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=/gfvyYztMNMcuWo19mp9PGU0KAO9W0nIWcv6rMLkPmA=;
	b=LnQJf8btnS6KRwP4p75uLG0WiTCW/L3ooXc4eY/jVvkcX7f7oUVHvi/NJt6mDF/9Z8UR
	 Z0ajnzHrtsG2LwGbJeY1OYPy0CCisyyGYpF2D0ZjcwBNXHfd/M4obsIYlF8bRT/6t8j10
	 vCH3nRCXMyB2LetHpGXaJ8FRVdIAAAGOrNnJhDfQ317CtOUh2NK/+0gGPWFkTfncdgzdQ
	 s9jPW+ahkjOQeXm5t4Ul6xVZ/tv8BwJERxNKzGiQvoYJ2C20ZmvGH8hYIKTaoWBfipR4S
	 u5EWVWNaUAo4JFL9zLuLXCWfPd7yUoA5Dk+/ewKIPX1iUjVqUxh/Rvt223vuMLUiUaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PEGIfQLY;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCCE60A2615
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BCCE60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PEGIfQLY
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4ad60ec5eaaso1415547fac.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296238; x=1794901038; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/gfvyYztMNMcuWo19mp9PGU0KAO9W0nIWcv6rMLkPmA=;
        b=PEGIfQLYsiWvDnnBa8bhBdzk4JJC8VI+Yua3Psit6LZydREi8YjbQOXs5WRzvu2vzi
         IyG1qXACfSieXv7w+aetW1A57UAT6wCVrYCcwpWxIt8PfcIyPn/vXrNZlb4xyZ59ZZQw
         YPtOQde8Af0ooRS4dYO8pw2WpY7M3xpblSHzSiT5SgnGBsDGBLHs89m+DYG89/yoY7SE
         6T8hNplufU1ds4F4l7mmh3khnbgnJVRjhSy6M+oXFgHe9poV75Ex//tvYjVDxWb0m5YK
         Uctk0ML8cd5BCyIvkfg/9laOWc7yT305ZCqadFcdjh+AQ4BvBAytqXYCZg5gG+AHayvA
         W6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296238; x=1794901038;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gfvyYztMNMcuWo19mp9PGU0KAO9W0nIWcv6rMLkPmA=;
        b=T+trFk8Gye5ygChSxVTVTsQEXqYIonq9XhtASCnTetL9yIGe2k680UdKEnCbu8D1zw
         BuSC4JuFuaYZXccwXOg4FzVYaZds+GWsnlbEP9kSPxmSgCUZo+UjAt4sUB8Xe10zQ8l1
         g9wKNe3hCB/3aTgsrF23MnKTSzb/Yqkn+LmhaxJuKLz8TxW4fsX3Ps3v55i8kHnMAGFF
         AFoak+3FdmAPYaPrFIkqtSAJbRLQaEaVT1ulKaYc91hEnUCrB9dmy/P0y5R6njod0F9Z
         NlKnqe1ZgrUeb4wSlmJMctPRUkKrecxbpw2mt3q7MpkeYcT4MzyjYyMr/TiSiO/RAIkU
         DFfw==
X-Gm-Message-State: APuU4Z9BupLBKZIXh8OU+1sngDCAsoJAatqUUmSpn1opzMol+EfvMCQq
	fqagmtkjeTs/Tz/J8ED6gcEl14COo4UOMmP99HuTAmDrs+mA5TBbCGU4biXdEln3
X-Gm-Gg: AYBFou2w86+xxdLaUnBMMxkgyVIUlQWOGEQpT+PZnIiGbLZqFOZPRumsfUxMqoM5jto
	TZFM1iLOo20HjL489on1URWnpVFHNTj6Ui1BINmYvQB50YS8VxEVa+mFDH+VynSC9Vp7Thj4Yj3
	AUCILp0Cag9KnEOzezf3pQzH+V2pnjWFZozGeJOCz3/NRuUloAXYsruw7UyAoCSXlSmETDIiEk2
	NVWpgxDEwW+nNSQaFtbZxkV3K4tgxnsVK8lXMidWjm+yxY5Ew9Tf821z4iKE4kJlbrkqo7WxDZy
	FLUkIowtRdExvJ41wmSkQzEKSsOik1c6xrghm4Nl4nLI94VyfAxhsY4MKPOSjaCkDOI897Fnjts
	zE5vC4AcyJlA8OT4uJuJio9TIPlJ7DMq2xIG3gZSxqPUGLu7C3/HYoeAiDHvgkC7sJT9kPF2l3d
	ojElJfV44CyUHRZoxiokB6CyX74t1uJwiOVC4T5vUpxlrW95whXJnYeK3YMxTu8hVaAYaVYcDr8
	xT5tpA5j92znng7UtGBuar1th5HLdbCcsT2qN05/4sjJ2rG9PFHyVT+h1qr5faTC3njJDd4jw+R
	xMaCZXaqvVqEBt/dg8mSbxg3ZFhEl2oSQOWgMBA9pXbk+5FP/W0Vay4p
X-Received: by 2002:a05:6870:f207:b0:4a6:d389:ea78 with SMTP id 586e51a60fabf-4ae2036a349mr829056fac.34.1794296238072;
        Mon, 09 Nov 2026 23:37:18 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fbc9c5sm1153768fac.9.2026.11.09.23.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:16 -0800 (PST)
Message-Id: <6219e9fd7f04045fd7529bb8c1bf1533c334756c.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:42 +0000
Subject: [PATCH v2 12/15] scalar: handle NULL value for scalar.repo
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A scalar.repo without a value makes "scalar reconfigure --all"
segfault: get_scalar_repos() passes the NULL value to
string_list_append(), which copies it with xstrdup().

Reject a missing value with config_error_nonbool(). This cannot break
a working setup, as "scalar register" always writes scalar.repo with
a path.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 scalar.c          | 5 ++++-
 t/t9210-scalar.sh | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/scalar.c b/scalar.c
index a80d8ee3ff..4fe4b2a647 100644
--- a/scalar.c
+++ b/scalar.c
@@ -652,8 +652,11 @@ static int get_scalar_repos(const char *key, const char *value,
 {
 	struct string_list *list = data;
 
-	if (!strcmp(key, "scalar.repo"))
+	if (!strcmp(key, "scalar.repo")) {
+		if (!value)
+			return config_error_nonbool(key);
 		string_list_append(list, value);
+	}
 
 	return 0;
 }
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index c8463d0ac4..137765d3b8 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -288,6 +288,11 @@ test_expect_success '`reconfigure -a` removes stale config entries' '
 	test_cmp expect scalar.repos
 '
 
+test_expect_success '`reconfigure -a` rejects scalar.repo without a value' '
+	test_must_fail scalar -c scalar.repo reconfigure -a 2>err &&
+	test_grep "missing value for .scalar.repo." err
+'
+
 test_expect_success 'scalar delete without enlistment shows a usage' '
 	test_expect_code 129 scalar delete
 '
-- 
gitgitgadget

