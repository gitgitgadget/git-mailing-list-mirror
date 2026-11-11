Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437385;
	b=1P6F6DlPlJDsF5I2F5TCbgtiVEVUQWl+nCDbjiv7f4oXihpbvB5MYMD4KkrbXTSuUXUF
	 hlt6xGjyij9zyIAm+V4Wb39RhOnW0m/squf88mV1InkxtdfY2EWGLils6A4+hymRRoa+q
	 t7SyiP3LS/AX38LzsvWbenYbdHhkF9dEawPQMiXOR0YVJyyZ+yxAQrNEPx2L2wAQVyHqk
	 pEgATwUH3SOn0d9q1SifrHtQKISnN+CHkLJzxSSejyzOo+PxVVbPH/7NjTdSNudvbfBUo
	 5Wp5PtkrDN7STZkXS+Y4k7rjOqlPf4s8L71dJhnuikkd+9GXU0vLqfwNbJyR6Yi+hWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=/gfvyYztMNMcuWo19mp9PGU0KAO9W0nIWcv6rMLkPmA=;
	b=mSyj7hX6GwgIGi7j+exrGnK9CnaG8x6XM8NmNTQ2/1fvqIHQ5Um4XXV8prJL+R43eEQq
	 7mUZbnIs+gwOiQmHmEbFK84yge088bsK/UuA1aqiE4bYcJEDCgfMgLLmP8qZn/GdbwqdA
	 HBXRWBAptfV6fJ3OzxhR+pifGmYfzVG1vMREXcLZ6+y0hMwzGN+MQ6SwzkBkDA55lj3zN
	 59jRh9HVbiubLRQ32JMUYzp29coylCoHHxrt67d6bMTm7vau4Mwk4Y0EDInXHWeXWk84D
	 spSpSA1Xk9YNrfcJ5tvA8QA7BkjZhcf47N5KJSgzaVs9qwvFQE0balHhcVP83+dkjoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dCP7IE0W;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD2606A8BE
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04BD2606A8BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dCP7IE0W
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-843b6f8e2c7so3817460a34.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437384; x=1795042184; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/gfvyYztMNMcuWo19mp9PGU0KAO9W0nIWcv6rMLkPmA=;
        b=dCP7IE0WCDqdTD9cRpqla+5w7En2sHtfrOMYgDhvYoJNqdhlaraDCf7q1Q9Sjp8HoZ
         ysWgcJRiLDbxDuYfhSQnBbeHc8GQs/z/bQRHDhlb7wGwJjS6wlHvtkhwExoJ97PLhVVP
         sLcqHQPKqwbf1OxCbDP1th1E5lVjqoJLpDjtNcEA7GwUdUkJpCfKK3zhI/vKOf/jmahY
         mv6BSXch7W/f1gkY2eT1YjPjp7NAAaB526i6EDB40Sb3tIiQDAT7ZvKOdK23D3Cp2JKO
         lpORK1iThJNGlE6eCYenkfwmgE/y6V47wHyvtr0Y0Aj1KCa6EGhxqKklDAxyEYIkLxQz
         B6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437384; x=1795042184;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gfvyYztMNMcuWo19mp9PGU0KAO9W0nIWcv6rMLkPmA=;
        b=19QIGnLpv2IZ7Rd7y1VqguDnW6BVv/v5dW6d6Bek7R9enxukLR6ZUA8POyZIR+1OFk
         i26BXljBzVvPT0bilHRugX8Ccoh+IPtdFDhBpjTo4/TmrITCoyl4ADEu99/jGGpgZS0l
         07n7Po7PMnW6nTeC8QtGushi8JPUF90e3zwKhrunehliV28HtNEisZGdr2zVVg2Upbru
         K1HU0OlZC9j9p7MpTctZcfbwLIocq/YDL2LMgR7YPrLPa26zhwKt7c8eUXgywjAMmORj
         AZiBQ63JNe8314ymdVtrUkfOJ3WQqhJZOgqnLGolNNQeDy4azP/XS+GJFzs8aypLR/YS
         DVsg==
X-Gm-Message-State: APuU4Z9o0yI5o+jpzheldhGYqKj2HEEVglFzZGJ+eetw9z9XgyVQA+2P
	qSGlx/7bONm64cb7hOfgAMOmV+ScQ3iLln/wFmm2U73lpw4BxfzLeA3CtCxIuoye
X-Gm-Gg: AYBFou2O+wgJ92ghOEXMwjp7X2VgZyGWCgDcB0rxtMswTfOzf4abJ98bdAXJj1GXpu9
	zQn5oX21vKeEDvtW7lqlBQFtrsuxz5XR1h77EVUC5sCzhcWD8H9guaV4WiF8MnD9/9z/n4lRxZg
	UcC9LV2qP/WoSMlYgaCFMx8Vpp5MbB9qFki43jywsf/YoW5EkMGisSIG4pOi0p7+HHzB6ITUfGi
	GmknIjvhq42v5CWOpAB7o2Apcu6oXIe+A61K31wYsnzJl/tsHMDc/m14uufitoO+e7SXHF0Zrl1
	cE29QmjKd+sw1DLpqu/7wV+F/sBY0r7eX4mL50j8fxmEVBfSgtnBLpjejjskrCBuanhrhAkM4X5
	EjEaupVHZINx4HvhudLTEvpFspL7Zn99dV5BKIMrUSk11k38Y+T0tzw+yYLO+FFSsZge7jjFp+J
	5fTuQw9DCTSOi8ecjLS4QKrK2t4xT6lMYwLx7QDmnhulY6DThSqeMLEwn2//W/AzrfEc8byXIX/
	Xh/DrBpxUrH+1aKTls9m5e+rNi3R6bQEYffAh5tDlGfp5AS0rcSsQxIldBcVDZQTYOJ1awQIeN6
	SpsLRWNNGz1gARbm6bXeaD0L50xh58nSzrM=
X-Received: by 2002:a05:6830:2690:b0:81f:1790:6ad8 with SMTP id 46e09a7af769-860f2923223mr3988514a34.31.1794437383970;
        Wed, 11 Nov 2026 14:49:43 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb5f7ebsm5337310a34.7.2026.11.11.14.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:42 -0800 (PST)
Message-Id: <751fae34b2705a6bcc28a808d4e12989b1ea98d5.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:12 +0000
Subject: [PATCH v3 12/15] scalar: handle NULL value for scalar.repo
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

