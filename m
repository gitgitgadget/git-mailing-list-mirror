Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069332;
	b=aE3OP3YT85wCG/4UF012VcC7wHiiRyrilsfts35jm+myCujSym96mpW/c+YT4BJPmJ/D
	 dKtiTR6FkUGM8gTsLHDskz8TRjzNL5EuZGj55vqsRBTYpNBaD8/8MTaFCbiakZjG6cUa9
	 PIQpRfYfQ843IVJpQeLWQDlQXzbU2QXyVDVk9ZtIlHk0w0/luYy+K5bBZc+r3WRBk7u3U
	 iV0wNTFEDd9cIKm718v4lta0d8qfM6HCrREbZEBUZGPJV4p1xqXtJj4b16jET7agoAKEG
	 xLHZ4PZ9WiaW4G8YIKNvm7YfkH8G5TA3xTdPhF4ovFBnp3Vl3oWM2GVMdAsBmMuIdWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mqp/gnrHfR1movneQoeJlH8Co1+N3aonEVQQEmHA9Jo=;
	b=laFpjFuHCk+RiQELnfCbpKu2Dlqnbg3fySVi279XDyDDVEilgrTdTf0KhRKi+Ha4DjFa
	 +C2N3+gyWwmkQI2Jc+tlJSMA0NOAUjK5UmhCx4jqCVpjMXSeRgXtp7gfYIM1BiWKZbZh7
	 UtjR7j45gkx8d6VYlrEw4WxNEi5ZiZ6u5P4hb1WHBXqEHBINLsgSZHogGGPDObB6DcUeO
	 ksT3C0x0jAoxLe5QEjIAhH4nT2vo/tl5WiwDNknSDPNxZjL4k9Q2EPnuWvYLulbRioWPd
	 zuYdxNb50d9KtJFs0SQder9aoeCMeE5thDJiQ5bpLdEz9C+aAwkM9gapEhPYw/inflQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxLAwbyU;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF160A261E
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDDF160A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxLAwbyU
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490f38e9688so421999f8f.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069330; x=1795674130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mqp/gnrHfR1movneQoeJlH8Co1+N3aonEVQQEmHA9Jo=;
        b=gxLAwbyUs3zbL+0+au87aUQ9rf610WZLBQLL1UgySxUhfk/OQeXJ7pAZiynHLupi63
         Y4fO4XLWv/IcQCBVidvDBMN+Y+uJGxk6BU4V3OaFSAyaQ6+APIgXw0SqjmEb5ziGCRyF
         eTA63Cn97D9ST/r61ZA2pQTOwvbUfGK/0BStz8vc32vaQ8Ji+BNYWfgsFFytEVHpyB+4
         D0VyjmJeDNLtvkW+xXPhsSw6nJu+ui0eu/G+JlcXXwTQ4OjHp3El9LBGln8oa9JVcEre
         w472+sNjxb4p6mYpRputAl3/W0WgKSsBimxeCWMdGFU7DiOBv4VgDlaZ1gwSbGJ0k6of
         Suvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069330; x=1795674130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mqp/gnrHfR1movneQoeJlH8Co1+N3aonEVQQEmHA9Jo=;
        b=uYGneYlOtv6JW7xsDEAeQy+O/BvYYsgPyNDUpbN9KmR8g+G+R3Yg1n/TOGtB0M8umb
         neUmqfjiPJ88htnBhOcOfgNDdH/Lyu9TeiYQLkkZkP0aUeoc+wsNDHQnVFv1o3H2hHco
         SW5TNFc1YeDYHGTVRYkrfkpqaj7uSfLEvlcCG+UEip5lKYJh1rZDqjWIE0RYBxSAmQvb
         tF1BQFB39TVBL8j56/Kuw/EZNROjSyFPApVSrWKTwJEOtaNdWa1BaZ9wy1QpHpw0q/g7
         B5ZxRMiYU7/2IdvSlr3HhG3d338l5NLHak1Vup8yhljeCn0zCJDoY4xnZi2ePAVuV5hC
         Yz8w==
X-Gm-Message-State: APuU4Z9N2B/bIaf9cEdzMgQZZGuEYUMcVQTX8lpmHl1Z06XEjl3vU+Q4
	Ln7z3HPWFCrCke8oEsBov81A9XjD0vbhavhVM/5FqrzEgiF2z2rvWq+RFHu3Ng==
X-Gm-Gg: AZFdTZc3ntP+q11DC65fW0i6ChBAtgRF614mxhR4l8TX5Jy4CCdic32RDwHnBGI3mTx
	qPCaWUfp/R3Im8qK8tCV41k8TmUFH77YceF/btfOb53jnyurJT1NVlnSVI9lFMUGt3zgO6LHUUh
	TVtccuReNGo+hNUhS7oBY+u1WFUEh2hyew9MglK4tFMB3ZirOJLMEZcTYk7tI+49zq54aDjE+8t
	NZuWvkysPeCIkK8qaTkqB+qX8WSWVSz3B56Xkb5dYs2UpS8UPcPZ0+Hj9gNou5Epi2U8zyu5BE6
	jGy+yCA4uroA7ddeU1Sfm8LA6+GWBGuleBWdKfyarqVxvpQjzt7fgE8GIHdjcBO2Du9c947Epie
	0VrcciPfqws+A/GHKeKizHOHYjdM4M2VS+i5g3Fis1Z7h60czFNjTABdf5xqcuzE97haq5q74k2
	aVsgC/J/m/dmMAg3/mQ7gK5L+TyJBlK2CmXAK5k4yWGBHWtPD+pE6QaXEKVsSJgtTHfuN2/G6ZN
	DTALdc6Csp3mcTGwBtLxq4jHOam4ZbjMQBP1mEZpNkD9nZ1CJypwrPgKOacBD/vgF3IXmx7Ctqx
	1PMEplk8KqODyeJ7Z67/ynruFj1cx/3lEZeby7u//iqlO7HlQO3m1E0/z8ohLcs=
X-Received: by 2002:a05:6000:29c6:b0:4a7:9630:7b36 with SMTP id ffacd0b85a97d-4aa55bfda9amr217191f8f.21.1795069330361;
        Wed, 18 Nov 2026 22:22:10 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c406sm8508413f8f.14.2026.11.18.22.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:22:09 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/5] cat-file: use size_t for the length passed to batch_write()
Date: Thu, 19 Nov 2026 07:21:49 +0100
Message-ID: <99bf45c606c9b89fe93118f525d3fcbbf25fcb38.1795069177.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795069177.git.gitter.spiros@gmail.com>
References: <cover.1794914210.git.gitter.spiros@gmail.com> <cover.1795069177.git.gitter.spiros@gmail.com>
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

batch_write() takes the length of the data as an "int", but its callers
pass the size of whole objects, a size_t. On all platforms, an object
between 2GiB and 4GiB gets a negative length, which fwrite() and
write_or_die() see as an enormous size_t: "git cat-file --batch" writes
memory past the end of the object to stdout until it dies with "write
error: Bad address". Larger objects are truncated instead. Blobs are
affected only with --filters or --textconv, as they are otherwise
streamed.

Both callees take a size_t, so just change the parameter type.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8870a210ec..c846fe3116 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -425,7 +425,7 @@ static void expand_format(struct strbuf *sb, const char *start,
 	}
 }
 
-static void batch_write(struct batch_options *opt, const void *data, int len)
+static void batch_write(struct batch_options *opt, const void *data, size_t len)
 {
 	if (opt->buffer_output) {
 		if (fwrite(data, 1, len, stdout) != len)
-- 
2.53.0

