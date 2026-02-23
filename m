Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC1035B633
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841259; cv=none; b=a2Od0yG0IdafOi77ZssqlC1/c6QZ9bPQPikU1VqNCGb4Hrrn/zMlIwEe4VEK2hc4U9mlvpsmqISnB/wJ/lz81T5WoIceXZnX/DDhSqqOet8ghiQlL6X9se4t2l90OParNeLWWDJvBF1dG3fffWq3AVHU/6RPFq7zU59CQMtcIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841259; c=relaxed/simple;
	bh=ozHSpYy1j0Sw9Osk4aDDcZrsmDMZw1Vx6TZ/5gzZM6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qWs06xzhv1aXZNXNLhOOxE/qd3f7RYwzSWE0PXhC+wiNhLosfRIKAOot4bN9izFsUqF0RpFoyWh9GXZj0qDG8I21/gh33qCAXT9B7nNDGQHOOXY6xrbagXtRkaaj0oU0aFUrxfGViGI5MlU8qTDhxF0Wtl8/LI0cwFRs7jEpEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTEPlqUb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTEPlqUb"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354c6619a07so1598289a91.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 02:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771841257; x=1772446057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrI/FyWk5xf/ADYExGInVgj3qwlJXs9zaSPD2d8RNF4=;
        b=fTEPlqUbVKrXl5T+7P8950c4BVbKSms8wViabEwKVUhb6nx+bgxkg2My9JEWX0ZhBT
         5Oa8CHjzGR68MLf+1yw3baPLo6HbeDX+cMwZKovJqbkXDJ5mKEPeRgDJj2LyoVJo8ZmT
         JO7sCxgUHNYxz0STqO9shRyDqNDAPpLbQMnnygbswfxPZ9VqsWS8jXVvU2diPJmqLf0h
         zt+VshTCyaFgUoTVtkb74+0CC4rBbbRHWF2ZcD0JXydtokg3uTlTPrvcx/rs9P/0pMWA
         Fu7gemvRinGGatFuZg2svyqLXlJi3E2sXHvxLao78njhBIauTEeQ7Kouc3vwlBC6FQaO
         6Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841257; x=1772446057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrI/FyWk5xf/ADYExGInVgj3qwlJXs9zaSPD2d8RNF4=;
        b=K2DDLDQyTL/Su7xVfMVtn+KulezK3h/ylraT3oeZeVDsZqt5JKIXsUJZvDIHXrREEE
         +pPqs0/iR900LsgXsdYN1HhS24JUaRizZ3fwMHFyA9taft56asEdpHFmDFf17WkS+FC3
         N0YF3e9s6LbY1W95mjpxxPMSPo/XhyMjNJgrgkVflftd/1PGwF51AjT964AeE8fQfBur
         tRTRBL5Ux/fe3ifzvflIzcOgbeac8leyYcIkfJ/D8RykXgDD3z5hFNMSu0ey8pEfvY1O
         SeXr02dx8j9/1KcXMBlKenFL/NBUbo2vXaZH9mASzDjR300HXDbY7lwF5+A6HYzf1Dxk
         do6Q==
X-Gm-Message-State: AOJu0YyKqFqZVO/utzGNt5dMMM55phtiIuKrfL5fRHIRMWNn+sLkHfMY
	rYq6qad8mZkoq9AQd2kcrkUNmh5ncC/xX86FM38irEjbkdneISUUAqkxiIQbaCiH988=
X-Gm-Gg: ATEYQzyTxlVTALyPT28kulsxHsIbPQwRPmbCpGBp0LsRuYeFKeVVjb21Ng1ySR6+IZF
	p+fqBNflUMPF0w8bRWInzWqsj6w5RMqmwx/9Xwccj84METUYC43qO/Amy5Tfy8K/J2mTVsbEqzp
	KHODZ9HVlX/DtKIpZwJBGnvcy6ezmPyRVdCq67AqNWjbz6pT2bs1HXlNaCE8Zkxuz13lVC8aeQA
	LOx1o46YrETPI+yPvV5YAlaw3CFn1daYi84LZKurJr8UvjI2dc12MUp2ZvbRK3Nixsl6+hRas31
	wCHJVQj7GIz3WXgcMAUg9ezeKU90epnC6u9U+9Zb+/vOUqVOjdF8zyHv4K/91xKdCcHcBoAs4eo
	3P3Mc3UgsXEEvwZGQ6nAkR2JOsg/5S4Z6lA6LjskNZrGWJancoNOzmN5MorZ0tVZcNWTTjNaZKA
	Wq3+SaQjbJv3NDf8kaMdM1Kv/nMY1eru4yIjR2
X-Received: by 2002:a17:90b:52cf:b0:356:1edc:b31 with SMTP id 98e67ed59e1d1-358ae8a590bmr6779206a91.20.1771841257038;
        Mon, 23 Feb 2026 02:07:37 -0800 (PST)
Received: from 192.168.2.102 ([120.235.196.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af71fd04sm6299565a91.7.2026.02.23.02.07.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Feb 2026 02:07:36 -0800 (PST)
From: cuiweixie <cuiweixie@gmail.com>
To: git@vger.kernel.org
Cc: cuiweixie <cuiweixie@gmail.com>
Subject: [PATCH] fetch: fix wrong evaluation order in URL trailing-slash trimming
Date: Mon, 23 Feb 2026 18:07:28 +0800
Message-Id: <20260223100728.79928-1-cuiweixie@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if i == -1, url[i] will be UB.

Signed-off-by: cuiweixie <cuiweixie@gmail.com>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a3bc7e9380..306138c6e5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -722,7 +722,7 @@ static void display_state_init(struct display_state *display_state, struct ref *
 		display_state->url = xstrdup("foreign");
 
 	display_state->url_len = strlen(display_state->url);
-	for (i = display_state->url_len - 1; display_state->url[i] == '/' && 0 <= i; i--)
+	for (i = display_state->url_len - 1; 0 <= i && display_state->url[i] == '/'; i--)
 		;
 	display_state->url_len = i + 1;
 	if (4 < i && !strncmp(".git", display_state->url + i - 3, 4))
-- 
2.39.5 (Apple Git-154)

