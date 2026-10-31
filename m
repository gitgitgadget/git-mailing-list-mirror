Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441807;
	b=zGttQqBGMMbciWzGTGPYO0qC7Qz37lN+D3TE6dDu3uuJ8Nz/lJgcXBIlNRbZfzqt5MbT
	 6exYflHV41rF4lqm68d6kVZ8yb547GTUWM7FDKeX5QWi6+4mV652bYFBx6PgqQ0qECmmu
	 KHESyjXslecNJcoKuwa6h/qUJnF/ixegqkXC0C8F9Q+kRrs73SQpMSOQ0s9vCJELu0nPs
	 ZtIcrgz4eZAyzz6ZqVqVfI9AxPNINUiTD086uuJg7NmTOUhylPfMUNFfDHlNcvMoxqwyG
	 /0T01dtA2x2BK0bV8GndgLXikzw+2QMAbl1IFrJMfQz7KtCzKstqqA4zAMqU9+7v1UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DuKfUpkPfjQuMEeRzGlFTR7PrW9NU9nH4sZfFpBqbnk=;
	b=QghTYhP3mRprn1DEEsx+AUgon79CWWw8pbWJ2aYsQO2BETVwUOL89lnIiLE65plqzBJf
	 mgwm0W2E8TaYKpbslf9g2hN/DupwXEGKUBgefURyu/BdKhtC3CCADNAuOTtcKPWPn6zoZ
	 msyzjlY9F0v+6M60Re5KGJP6p144SR5qGqfzXVsHgxlAiTHCD6qaLZbkCTBALQXI0d/9w
	 GfKonh8fcOTK/88qxv44rfv0bEWVVaScJcD3hwalgWY6ZZnUe+KF91bNpeh/n2KJuQ7Nu
	 Npv+t8aGOe6ghkAtP980+03Sx9YzNaMZSnetpXVVMc4lj3xdZ5MH/Dspccz+7a0WxlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ns5OEyjI;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24B606A31C
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE24B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ns5OEyjI
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e00eee27dso746737f8f.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793441805; x=1794046605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DuKfUpkPfjQuMEeRzGlFTR7PrW9NU9nH4sZfFpBqbnk=;
        b=ns5OEyjI5fX+dMAVKnzW3MGq2Bknf4WMFN4LAHvYOPq/xxr9yOkl6ZTh8Pl47uHUKx
         sVBzh5Obcw4bwaOKuqhiVjB+e3IvGz1iPuYcC4yPWwxu1U5boGEXoYUEUOtyyG/cxZ59
         MCC1qJj4THrKFx7J0AdC+j9Y4xb21eA60h2HV7V2Z3TJQHsTEGq1DU0wiMGZBJv53YvZ
         +xb3J8mmzjsEfIHKOYob4w4oVhg9PC5KciPRb76yLnXa40AThUYyw9ewewjg6Vxu38fk
         8HBD69p+bN6JIpBc7s9LCVYjh0+eW5GoWYLgjwfe+TXv0GFwaXtuGcqvw1fbLXzWldph
         SlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793441805; x=1794046605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DuKfUpkPfjQuMEeRzGlFTR7PrW9NU9nH4sZfFpBqbnk=;
        b=nMsJb3ffxcYohlVxnpM+M0Yp/ZCgdSfhRyY5tahUhbllOpLILEytY/vla9F4wsbO6i
         tlZ99h7D+Upys0BrHzJHsGvdULkOmyT/kle602xDdArxjW9NMtHQM1nusPbfL8Nwhutl
         e2wI/6GP0RMUD+9HWEfG3R+mGacBgel9+9D3N1cnZss0cPx5+GBajO2FVcwLzgBxLB5o
         bnWWrwrAJZrraLzOVPz6+JGXOPkgb+NUTS1VZfWrNVxgam/D2J/gghV6g3nnmYP+gwYX
         FLLSy3841nT0ONjzteh2e2o66rc+gFMBReJwa9zmR5oPiceAtx7WLEMKLnAZigpXBOVv
         ilCA==
X-Gm-Message-State: AFq9FYJoH/WKToc1+bixCgpaYt7OOhCgBzJ/EKF0YgpKmnLG0wvbTG6o
	/fdMhkt2UbSwyeu49g+tuJ+xSjYQkCnhis06FY5JxH4L0yQqQOMSyjDg/hcn8rJD
X-Gm-Gg: AYBFou2mQn6DixO4gb9wz38ogs5V047h1k/6XlgFctZHGYyHLXbXe8dEc24gbPHEEhe
	SZXh5Nzovoo2DS0zO3j+ZW6wbtzHVPk7Oh/d+HBhWQNxXe3uBLmN6/RJOI6mE5rVlml8u+9ULLM
	g7s0Zo1ihr/EXkRcM+Ti8pm45cnbZZyUbWj1IAFxm3NBugMdBhS6GwwKcRo6jo299LI6uMuXCB5
	2DDKC5TMOGxaRQ/nN/0Ab22t+roGM6d1S1vCTARxAktJnOn/t2nbJMy21JzJ+Akqu5U7J4BZzRO
	uH5tymAJTFR7nqeRsPk9bpPZHtU4vshm/A6yjliuxJAYEGEbO+AKync4HVAj70R2AIiQhXarQnF
	ZnMGacNnRldhgNI4Biki18HwQ2obxosqmE6FMPZ80+6oTtw/V8fT/irKYptS0Oh0jb8PZezGrT3
	2KdP8CPklb/GAvSkUULYd1IwUHF3EycJ6baj60PjAhYBHz7XEuCFiMRES3fmQg83En3xmGSe1aS
	Rw+WHvjio/OrkObZWQ+CWY7PBPpJ8xTSNxPF8a55rkTJFUmJWFQO6mjJnRhCGlX893ZRoGJRHK0
	rkpRWgapbYm/d+svUHXbw61O7VEC9ZqIRtMw+MC/SKNr8VhWt3UudoulCb4dtfsX
X-Received: by 2002:a05:600c:871a:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4ac18d68babmr93072195e9.29.1793441805129;
        Sat, 31 Oct 2026 03:16:45 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm127220015e9.6.2026.10.31.03.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:16:44 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] convert: use size_t for text statistics and ident counts
Date: Sat, 31 Oct 2026 11:16:35 +0100
Message-ID: <153463b531b03e942247c0f6f9b3d89b8e55ac7c.1793439137.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793439137.git.gitter.spiros@gmail.com>
References: <cover.1793352943.git.gitter.spiros@gmail.com> <cover.1793439137.git.gitter.spiros@gmail.com>
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

gather_stats() and count_ident() use "unsigned" and "int" counters to
count characters and markers in buffers whose sizes are measured in
size_t. On platforms where size_t can exceed 32 bits, large inputs can
overflow these counters.

For example, a file with exactly 2^32 lone LFs wraps lonelf back
to zero, causing will_convert_lf_to_crlf() to miss the conversion.

Switch the counters to size_t and check the size hint for overflow.

Triggering this requires processing over 4GiB of input, so no test
is added.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 convert.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index ca5594cab0..34fb4ce685 100644
--- a/convert.c
+++ b/convert.c
@@ -36,10 +36,10 @@
 
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
-	unsigned nul, lonecr, lonelf, crlf;
+	size_t nul, lonecr, lonelf, crlf;
 
 	/* These are just approximations! */
-	unsigned printable, nonprintable;
+	size_t printable, nonprintable;
 };
 
 static void gather_stats(const char *buf, size_t size, struct text_stat *stats)
@@ -1077,12 +1077,12 @@ static int read_convert_config(const char *var, const char *value,
 	return 0;
 }
 
-static int count_ident(const char *cp, size_t size)
+static size_t count_ident(const char *cp, size_t size)
 {
 	/*
 	 * "$Id: 0000000000000000000000000000000000000000 $" <=> "$Id$"
 	 */
-	int cnt = 0;
+	size_t cnt = 0;
 	char ch;
 
 	while (size) {
@@ -1170,7 +1170,7 @@ static int ident_to_worktree(const char *src, size_t len,
 	struct object_id oid;
 	char *to_free = NULL;
 	const char *dollar, *spc;
-	int cnt;
+	size_t cnt;
 
 	if (!ident)
 		return 0;
@@ -1184,7 +1184,7 @@ static int ident_to_worktree(const char *src, size_t len,
 		to_free = strbuf_detach(buf, NULL);
 	hash_object_file(the_hash_algo, src, len, OBJ_BLOB, &oid);
 
-	strbuf_grow(buf, len + cnt * (the_hash_algo->hexsz + 3));
+	strbuf_grow(buf, st_add(len, st_mult(cnt, the_hash_algo->hexsz + 3)));
 	for (;;) {
 		/* step 1: run to the next '$' */
 		dollar = memchr(src, '$', len);
-- 
2.53.0

