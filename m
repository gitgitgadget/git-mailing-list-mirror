Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C03B52E9
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768429658; cv=none; b=SSXtqAV9qQzcdmTcgu7wissfHfoFlEMpJK0z4/WkEruY5HIMTy63EYNphN+iINN6ILQDZ/uctpsk3Q49q7L6VYhxUvfk5O4M4VvI1WJSuuZrIq06n5DtTUNycFOk2gIRzvf9REnvyxNXVjGAnDfb3QQOeJyAbKWEbsjsGpgdOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768429658; c=relaxed/simple;
	bh=3QZHud8lICuqqoj+qi58nth0sjUAN9QGH/Pd79Pxu3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vAGQ/x4ZjVZ5muf9gnbLgy0mqIBw2aGtCWP1sBsNGfnadwWWUVlCBX+Aps5dh4/wEJw8SK96k4LF5TrLJBs4t5tjp4nkANv1JNeMk0qamAkDbdwHUqS7vlWwqLgQy0sbvSHc4PrdJnxcllK2qOy4HQnd9h4yyiZxk41pRIG73KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ussddkpx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ussddkpx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8765b80a52so62799366b.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768429641; x=1769034441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud5yIQDpTUgRpdgfWG6omhduTaANvBJ8d9TLlBDoUwE=;
        b=UssddkpxGjG86uCrjeOxkZ6xsaE/7U0h9iRR6u1KhUk2xatk+1fCzTeEm4Bq7SENI+
         CcCXVROD/9uhSnx+gDjIaATjGR82EzK1VlNknLXX2zNi8z/8P5cLWajdzXfVGynslxrV
         5KN7ce9RSiYra7r0oLoy7jL0ZA967PuD6fEBN0KauL6vfR2WkwUr++iiFRczcb0mi2KR
         QBiaR/eT5VgcGIjz77lrMCHzWr+lL4cLBKoR46rISgWn1+w35XRtxtdVWLmKKihw4RCn
         G0HyedS9ABR9EagG3aFkOOoIFog4KBV8kcchEJkS2p/r5FErayxLZTDcBDKI9siobQuN
         3XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768429641; x=1769034441;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ud5yIQDpTUgRpdgfWG6omhduTaANvBJ8d9TLlBDoUwE=;
        b=GiLtO/6GemdI088MlNPtnjc8A7Y6h3JPVuOKosgUhjY6zqy0/BFgLGQ+8gLXyI1mBp
         4j9bBpqUUHiPoOsFVi6W+TLTJPX/hpZQNFgKVb+E1dnMbolbzypR9Q+LvWSnATYh/avq
         heBHpp98+9ZiT4DPvL44PxefVptYp3GOSWNmqBR6pq84uU4clzRe2ns3crqHZw+Al/oo
         T3bRmU598tPK4bFDBsDTELRNuNXebpeUHj70X0BA7MoT9+Rt0r38mZzc0MclithLBRwx
         +kS8QwvzCH7qjkjy4+j3GsCd4QvrJr+bqql/9J/m156vIgTFXyMayTfcaCvtX84nVeFn
         +I1g==
X-Gm-Message-State: AOJu0YzQdicozkwWxeF8ov+dTcgKXUQx/gbqTPexRGr9iKqA9ELohdbl
	1eAMwu+li1Q/jX+sYyucxDoxSgDx/3CLui0fBiiGpBWZSXM2VtePON/cL4SQAZBJ
X-Gm-Gg: AY/fxX4panZltdnvYxfdBh7Ug65GFnFgzYE/sUdZ+JixSJj6i2gHU+tYrQ5FuBLIfxm
	Ef7Im/62fZed2KKVAjbz183pZlqiQZ6DqM8K0lM0gPvq8YwzWZiQQKpif5gNs013+JYegadgkKh
	wBYpqbpVlcQiI+9Bv7ZwYzRptsP12CKSGSyn1+MAv0/DBzDkkEBRcW7gnUhXWYtmhVpghDnHVEn
	DGtHXaRmYe1xKKMxIVB2CpDZt/YY9aht0UR+fFSmvyTLIpnl+K7ozCi0tzBGqEikIXuwYfxUzgi
	C9m+xwg/IZns+N0P5VYhZF/TjpYwSLwy3u12CZMMdrNiwAWT+9qfynGJ2cYkfbMZzOcjsvvjvvI
	jvkNRnGxJKLpYLNSjDpvmeQh9+WemuqfH8luPQVAHPBi37he1UY8SYRSLPBcdTXgC93APXWFtTE
	Zh5I6GKAFYvRwCXuqvXlkP
X-Received: by 2002:a17:907:9692:b0:b87:1839:25fe with SMTP id a640c23a62f3a-b87677e5e03mr311073266b.54.1768429640930;
        Wed, 14 Jan 2026 14:27:20 -0800 (PST)
Received: from lorenzo-VM ([84.33.162.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870813a9efsm1163397166b.38.2026.01.14.14.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:27:20 -0800 (PST)
Date: Wed, 14 Jan 2026 23:27:18 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 1/1] diff: improve scaling of filenames in diffstat to
 handle UTF-8 chars
Message-ID: <aWgYRkv-YsuekdR_@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The `show_stats()` function tries to scale the filenames in the diffstat to
ensure they don't exceed the given `name-width`. It does so by calculating
the "display width" of the characters to be dropped, but then advances the
filename pointer by that number of bytes.

However, the "display width" of a character is not always equal to its byte
count. The result is that sometimes, when displaying UTF-8 characters,
filenames exceed the given `name-width`, and frequently the bytes of the
UTF-8 characters are truncated.

The following is an example of the issue, where the 2 files are "HelloHi" and
"Hello你好", and `name-width=6`:

    ...oHi | 0
    ...<BD><A0>好 | 0

Make the filename pointer move by the actual number of bytes of the
characters to drop from the filename, rather than their display width, using
the `utf8_width()` function.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 diff.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index a68ddd2168..271ace5728 100644
--- a/diff.c
+++ b/diff.c
@@ -2859,17 +2859,10 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			char *slash;
 			prefix = "...";
 			len -= 3;
-			/*
-			 * NEEDSWORK: (name_len - len) counts the display
-			 * width, which would be shorter than the byte
-			 * length of the corresponding substring.
-			 * Advancing "name" by that number of bytes does
-			 * *NOT* skip over that many columns, so it is
-			 * very likely that chomping the pathname at the
-			 * slash we will find starting from "name" will
-			 * leave the resulting string still too long.
-			 */
-			name += name_len - len;
+
+			while (name_len > len)
+				name_len -= utf8_width((const char**)&name, NULL);
+
 			slash = strchr(name, '/');
 			if (slash)
 				name = slash;
-- 
2.43.0

