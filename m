Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989794;
	b=REh40azkk8pab6pOYLWBnPOwMmpNiKb/iUVk+/7Ike1RFufcRkFu2ZYInJVnUQEtPJZQ
	 nZc8XWm86epP/0lvglTGpE+nAiB4NaCVGiqRVXmeJi18nhaTmidiNpnN0pFjyPPLbG4CI
	 HU4/DW7Kw1NP3DU3AieubG6fw8/39lvQchVnSpNpUs8KRNB4ZVid83sd0NyU7lkpXVdmj
	 Uhc1qK+d32/Y6mexwlNs9vvFT53V8q8GaV0MbS0BE2jnZxcK+9FOsqTBxtm52Eg1G7eBj
	 6npvGPhgHY2QRUrBiqqYtXiZGYoBPSkuqMbG36WhMmSXVhI2NKv//gXhxhxpD0ufO9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DKl8BQSI0VWIqmbz863aLPlWY42uJIyBEVZGNwZvjRg=;
	b=xz25Jh/yMXGQzZjln0incp2A7x8WmuQ3sOiS6CM9HtXkr45A8A6XgwMWwzEl2EpKYfhB
	 uVdOvhFZxAK/E3ALiJLDJS6cf6hruIG7rmVxQo/X22NXVBjU8avDrIN61lUNA0mGoWq19
	 UI3JWWLRxbBYlIL4p/2ubVJaCq6R2/wqKaTdIhlQH/6gnSfXqJUMWhd6gZG1tIe6MOzL6
	 1updCFBSJZnISn2o10UXftg93IH21H3Y3UTj/sYlQpavW1+yJQrHp/qcRFCkxzB78UsE3
	 qqqJQjkTmTwsBlGectxvh7I796l2eEp7F+fXyBbRUjALg/1vPTkbiyukSHB5KJhxxRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xuOHqJjg;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38869606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 18:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38869606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xuOHqJjg
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36f6295304dso989132eec.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989793; x=1794594593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKl8BQSI0VWIqmbz863aLPlWY42uJIyBEVZGNwZvjRg=;
        b=xuOHqJjg1ru2qjjzRykBVlrkQQ9G0GPxnU/RxZ9DurjghdisvhxwNX8FrIb3DoyBoc
         XbWmYk4N6lsvVK/cY5AUSTKR2DuZ6uBakGdjbYA8OULF7rogzSHyM5+6Ra+N24l239SM
         wLwR23CnZXY7saiD3tZPM1O2YabC3Cyb6qnHT5fWJa1yTwUBqgrr3sMPFo/VBWndRTvl
         AcBj5r9NXtM0MOEE/w9VGWKGkI1snTuHT4ua9MFcw0lP2cXv04TnKsmza5JAIhNeyqQn
         v58VwfJU4OD1ZjHuV0ce78Ix3PHR8AuT3Rgp+3+H3tCJUr5UJHG8B7Z78JcqmVf4zDki
         /1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989793; x=1794594593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKl8BQSI0VWIqmbz863aLPlWY42uJIyBEVZGNwZvjRg=;
        b=VjRZC/OEF0PMpPRkcoQloFqsIeaw062PTYGAO6d4Jabrjrb9SPXXMNioGCKs46AhcW
         h/eDITrjjreNIrr5ZXSVxCc7CB3gQKm/L5BFJVJd9gk61TmkgFgpajXUUd0rQ5JOg4TU
         asWtrRNA3NIcA/zgjFE8vCPioyx42v/6bIRiFVCCxhcUfufvUZuhBzsZ3qRmE3exX5zp
         2D+3UqKxiYX9Qq5J7cxNnvme9hJxHS3eIdLpFuWPXHaml+EDb9oVscBNeA/fLIrwoMmT
         X+zs+o18yKVPO2gVvEXxwxEhxn5m5BvrVy8pUY6VZkbLMeQrWd5v3fyK5c1lmuUuNL26
         wnUw==
X-Gm-Message-State: APuU4Z+STeGWbFPzbaS1O4XOF7ZACcRZdQ6dcj6wBA32utZirC4vyhKm
	8FdkADymszmuvPqRVGeRACxDF1BldOjzazQrDaZGfBJZjtuR/g9IwIm0pSl244lme10=
X-Gm-Gg: AYBFou17wXQ1RaMP0SsMFwSDbyqZu71lviBnjppbsQSj1V6wiTbWbIMrYv1pQwOn9H0
	Hn4FYma1m5qPwsrCjWUSa2bc8TchaOJw2eERhIwXIp4gARanVm0JOXJvMHn03ftpomXQI4/9RJI
	/59Mm/NA7yYR8A6jtF4xYnlWlv4teJZ8Jkou5Pl4zXCJs+SXEKmRBCTuNQKar0e4L9RColG+QaR
	1ljDETE6tMs5tQa6mgV5U5GtdPv/6SkJNlJJtO18ZcpvwbQpK2EcGA6MCXfHYsdPNLQVL7qxlon
	vREI41I1keHmxGeHDPhrD/hdWRWVOtuVjCAvv/zVUbx5G/RAbh3i5lBmqvaYVf++qNCroQnyo82
	eowwJytDx/uSn4rlDThqG8qAXZGFHP8YHCidxTiSlsqWmjphjqQiBvsG9+rVBAIFgTpPk419FvV
	Eb4mk06MYpHLmGCT1Oyo8xvu2zCdUx+re3ewoU7rnxoefGHPk3Odrs0DdthL8/eu0AY2fDblHnF
	2ySCU4M0dKktFqdb31r77tw+OHZgV0V44mO7m5KT2PfB9R5Jke9o3H3cMY2x2bzcmxpv8WvGWbZ
	X8WQnUZ1Nsvr0Sxe9vttzfBM3vYdP6exrsQznSbpD5VvtLLroUoPIw3XMvL7VaGcAU8LZOaRFd8
	=
X-Received: by 2002:a05:7301:d196:b0:36f:be1f:1191 with SMTP id 5a478bee46e88-36fbe1f11efmr3868126eec.29.1793989793005;
        Fri, 06 Nov 2026 10:29:53 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faac86a96sm8565607eec.29.2026.11.06.10.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:29:52 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike Beaton <mjsbeaton@gmail.com>
Subject: [PATCH] dir: do not turn blank ignore-file lines into patterns
Date: Fri,  6 Nov 2026 18:29:45 +0000
Message-ID: <20261106182945.1316297-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <CAHzAAWSi9D1mRL=A5-9GxzqQwo9jJ=45Hmxj3hVAF=8wkNZLmg@mail.gmail.com>
References: <CAHzAAWSi9D1mRL=A5-9GxzqQwo9jJ=45Hmxj3hVAF=8wkNZLmg@mail.gmail.com>
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

A blank line in an ignore file matches nothing. But
add_patterns_from_buffer() only skips a line when it is completely
empty. A line that holds just a carriage return i.e a blank line in a
file with CRLF line endings or just spaces, is not empty at that
point. Once the carriage return and the trailing spaces are removed,
what is left is an empty pattern, which matches any path that ends in
a slash. "git check-ignore -v foo/" then names the blank line as the
pattern that ignores foo/. Skip the line when nothing is left of it
after trimming and add a test.

Reported-by: Mike Beaton <mjsbeaton@gmail.com>
Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 dir.c              | 3 ++-
 t/t0008-ignores.sh | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index d896e7be4b..5a8a28afef 100644
--- a/dir.c
+++ b/dir.c
@@ -1249,7 +1249,8 @@ int add_patterns_from_buffer(char *buf, size_t size,
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
 				trim_trailing_spaces(entry);
-				add_pattern(entry, base, baselen, pl, lineno);
+				if (*entry)
+					add_pattern(entry, base, baselen, pl, lineno);
 			}
 			lineno++;
 			entry = buf + i + 1;
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index ed95faf327..199abbcdf3 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -875,6 +875,13 @@ EOF
 	test_must_be_empty err
 '
 
+test_expect_success 'blank lines are not patterns' '
+	mkdir blank-dir &&
+	printf "\r\n   \n   \r\n" >blank-ignore &&
+	test_expect_code 1 git -c core.excludesfile=blank-ignore check-ignore blank-dir/ >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success !MINGW 'quoting allows trailing whitespace' '
 	rm -rf whitespace &&
 	mkdir whitespace &&
-- 
2.43.0

