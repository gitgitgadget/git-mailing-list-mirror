Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915554;
	b=jiRnE7Ck6ZD/xIPsmIoiC4x9AitrgmvIIrqam0BOF2ujljOvSAT54rKu170UPkWYTRTR
	 FwDml5ARo9I3+YUTF4AHlMACp0nP181UkBDIeiahT02y8M6hvPbDoYxl5XGmGe6euuOA/
	 qva4wpJ6urZzsQKn6pGGX0kZNJ5p1hMMUx2A66gb8uuYRgi5bUQ1CxaAJ5aIbeWU7bua7
	 MaO5m+ezLBsNTfBCaRAeZkbWBtiuoRiYcXbYo5o/1ux5FAfz6mWnNpBUDTlPox8QeYEL0
	 GwzjQxFyfbhcPd3U76ysvhFY43LWvmNNuRyVoGwyyGaQTyCvbmwJV13aY76FY1spQ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aeZlgdld8Mlenh+df9G4lQ3t/qfooZFG5zrAZBl7IVQ=;
	b=tHUPQVJkx7ZL1k+4lEJ+CcO7Kf7ctwYHRtgK8BgsnWqVZMcZY+k8FaOCbgIdSY7QKRCQ
	 NLttawKX/YKlq0gdRY1MM+Auyyq1lNtshQ1exgvaaIpqxPyZxwD0Pn8ttbwRv8hwfXAQB
	 5wbKvzS3JkvcmpZ2x9dws6l0y+UyzcIeNebujOo6SI1mE6yhsbZre4MSNMsWDvsen6Q7t
	 UdZz9v1/90jlLZe5zpinARFuUSaoYEmIOAq4JiNpj+cabIW1ZHoMKBhnUadBgQOrXrIC6
	 FDtBBNPUz8y9c+nFjUAfKUojUS0qvHAwWJqkt3BwmTjoW4x2wf142Kcj7n4YfMcywHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wvSg1Aiy;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE2606A331
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 11:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46DE2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wvSg1Aiy
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so29765555e9.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 03:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794915552; x=1795520352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aeZlgdld8Mlenh+df9G4lQ3t/qfooZFG5zrAZBl7IVQ=;
        b=wvSg1Aiy5kBt5JXy6Me8/DxgifHBIG9zvwMYCE7sR9eehlWeABV2AHyW/ss44fkj3m
         19kyY0ictu2hlwAUHc57cKwM7L+qSeonC17i63MebMCEn8l0tKnFtbyfxIEgHcOskhUD
         hfeBudA+bPGhDpnuqAODWcwii3wr3Hx8/oG7KMH9BtCiAeXLzZNAPB1LZEe1Ty0dtGXn
         4n/EgweY3GiNwRbyljV3NRb14BZHfmnL5mOjTbxo8yyay3I6SVZc/NIxkep6CSpwH2B6
         fAKnI373WvpJSlLj3DrpkcZFwWMkVKEDFgDenRrvtkm22IawAf9Pmr8aEU6Y8IlD5iZa
         41fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915552; x=1795520352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aeZlgdld8Mlenh+df9G4lQ3t/qfooZFG5zrAZBl7IVQ=;
        b=EkWTQ9DAeVIoXcrs4tcXs4cmdwIuC96AG8d8YHEffnaMHa7HQyOjW0KlgSKku6LqwX
         jHIY9An/Wqk/KU+4zfLWO5GDyDH/zJ/bl9UT0rsb0t7EJKj5MggZ3Mc6hzLeB4IgNwFd
         cFZ/xQcG4ORhq/TATt14xCDOqxg3B/KfW9bajRh2uGOp6F382oq4nmDuaIlsyyC1cwE6
         zPsp0CFi8rRLqRMlpk61hwuwlJuDRmphmT/9CuP8Atd9Y+vPC8oCwrZ+yfLsWkr/bwLZ
         +q13uA2dz9N5dTEwbk0iXeAErhG82HlWzqbGv3NDgPNMeBWDVDAMJldJRdvfadktev7M
         lzrA==
X-Gm-Message-State: APuU4Z+tNFy1VcySZOrpl7x3YZWKlYzU4NU3b622v+p89hshXhExQY/u
	k93Q7mRS9NM7CfRjfmqOk+iEJBqrHlTSkAlya8/hpj0yL6l1n3RaGR+1PEfywA==
X-Gm-Gg: AYBFou3gCX6jI7QZ97LCHNaOCXSyg3kNoU+LmPORiN//6tbP3FJipS7OMmPY3RGtZpD
	3ZzWk1hEmIkYeFLZlH0ldZ/MX4FzvDWriD1OlzCaNlYHd7Gr1DULWIcDbjaeqjv8rjFLNIJKDgE
	gv/8Xp8jEIHXz0E+5M3p29avT1l8+7dlL77frFoVW5/YoVP1mtUf+cHwDOw6LSpbl8YZkADuBZk
	+YkvpzCSh3M7ZBnu/krl0+sHLzoM6467EPKXqnk/KqNrzuk73BOUdjO8nvdRBy/ug1Vnx5/pEQW
	EVHqlCjxpbNenOObmnxARtq2eZiSlIZGlyhot5/K3kUC2jiP8Tg/kaQs5oYzkDAdguxZBXi9rGi
	q1jgpI1Cd0imxii07FuUisZ/PpmjZuzX033tZtgCt4OPqTnCHb7cck2NzEC3ArZ6HbJF4m5QUBk
	iCDBuGbUYYG2/4S3R2/WDyKubShegsh6PQ56WWjZg+4cez0MQzl67IkgwyLirdcYpLyfCD8lPRB
	TYpuxIRj7sYgP78tA1uluaLdmLuG412sTqtZHG5fKPnKjW+Yjquuhs4jaZ5xIy409istSidFOr/
	CHu1OTKdxODaWQqnbyhBVpl02vNInUGvq7WHy8TvAdoW248JPF6o79qIW/Vo0rQ=
X-Received: by 2002:a05:600c:3b91:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4bb55a3e29cmr318256885e9.7.1794915552516;
        Tue, 17 Nov 2026 03:39:12 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78420edasm93555925e9.9.2026.11.17.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:39:11 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 4/5] cat-file: use size_t for the length passed to batch_write()
Date: Tue, 17 Nov 2026 12:38:57 +0100
Message-ID: <5b61a1b08997d4d642e795ccb366e45f911bd982.1794914210.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794914210.git.gitter.spiros@gmail.com>
References: <cover.1793355390.git.gitter.spiros@gmail.com> <cover.1794914210.git.gitter.spiros@gmail.com>
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
pass the size of whole objects as returned by odb_read_object() or
filter_object(), which is a size_t. For an object between 2GiB and
4GiB the length wraps to a negative value, which fwrite() and
write_or_die() then see as an enormous size_t. We happily write the
object and then keep going past the end of the buffer, sending whatever
memory follows to stdout, until we hit an unmapped page and die with
"write error: Bad address". Objects of 4GiB and more are truncated
instead, which desynchronizes the --batch output.

This affects all platforms, not only those with a 32-bit "long". It can
be triggered with "--batch" on any non-blob object, or on blobs with
--filters or --textconv, as blobs are otherwise streamed. For example:

	blob=$(test-tool genzeros $((3 * 1024 * 1024 * 1024)) |
	       git hash-object -w --stdin) &&
	echo "$blob big" |
	git cat-file --batch="%(objectname) %(rest)" --filters >out

fails with "write error: Bad address"; with stdout going to /dev/null,
strace shows write() being called on addresses far beyond the end of the
3GiB buffer. There is no test, as it would need several GiB of memory
and disk.

Both fwrite() and write_or_die() take a size_t already, so just change
the parameter type.

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

