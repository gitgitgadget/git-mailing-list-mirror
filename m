Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070649;
	b=DKN3edGu3eEOlBLGroQ/MLfafOSvbpPOtE3vF2FeQ0hl4FVMPDsZylH5m8DKsSt3Cy7s
	 TXbRFnpOym9FWEOe10F3Gdo6+qLscEMAFAx61cRxpjCTQRQsPo52SG3HzBIydxwpW2BUL
	 7jDIWinHcLIctg0rUxfKblb65f/x6ZOUXLzdY9orutxPT+HEGfzdEgz+7j1EaugI6rZjO
	 /tdibEN4xVi32X0u+CVVzqvd0bT7JtbIV2FuJqf6uDg/6Uyyw4lZ750ryRxmS+0qX2ijx
	 miMjkEZDLr+9XRyezV160wgt1QV7cyR2Y6oapSphcwj2+Umih00v8AUe5mbd7E+1LEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GP2KLBkHvz3KfewLFkARetMC82DJRA9yT4ZkXH1RrHc=;
	b=I6VlUq7WkHNSigmNAnRNTDjVoD++IIGTpHNYgS3y8RbszX1S+X00vUtV7xh13h9trotJ
	 IMp0blrCEj/NhzoIrxIRR2DmDyPzktvZovZNfNX7K+3SE/bFiaSwvtBpBc4eoSTUAJKGH
	 8Cs4hE4chKbEkc+SmgchBWW+VOh1LxsSvhPfSpESq96kH2d9xXqJl0rEruPl7hlIF3xLu
	 2J6n6FvgbDmptoncmDgjzwHPYrEu9XRx3EI8HFS7oLlZsaNHjIcThLsGgVnE57AtvkDGw
	 puU2r3Y4FWFn2FZE2tQWmZLSuxcmbmS4u6gYelVV7X2bwL7GKBC7765nPoOonaK45ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e7vzgkCk;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD360A2604
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74AD360A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e7vzgkCk
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso4632055e9.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795070647; x=1795675447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GP2KLBkHvz3KfewLFkARetMC82DJRA9yT4ZkXH1RrHc=;
        b=e7vzgkCkRvISsVH6AUkNOsb3+rHo0wrrhRlGATe5GRaMsj0sSbNTW3IKPb8deqB6fn
         1s9AYtWA77WFkURySIlnR7TW86XkBVTPTLVxqBy6BSvaeJ9Txf7Z1wxyvczfCqVip20L
         YpxGXKdAHbyGopNOww8EceoflN0XgKGGIqS+drlfHqJ1YE7LZf+IIwpCuMTatLZpW/5u
         f1UFm1HaN5dcPENgQrmRDaS4I9CjqIvSmMZsO1IY/YJSm158UcuoWb/f+LyBEhFsJIJw
         RG+KrECsgRutY73RymOAHgxWud1JMKucDuC6EdHAcXldqJUtXeG+WggrsEwqcLYMQh95
         vcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070647; x=1795675447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GP2KLBkHvz3KfewLFkARetMC82DJRA9yT4ZkXH1RrHc=;
        b=kLX3CM1c8Px22mqi2WjmUsUIiS1kkd7hSEOQJxgdq5FYqXIzhZyipsKqwNsORN0+qN
         YUtMPV5iwPiLVFkfbImCHSC/q0CckepBaHGZS7cJs4TMSWkUPk59B/LaG8JDSvSlTd4H
         T+9F45DR/NxE8EC3Bj5/p40hWdpoAhMLApqAFaBU5+qivi4sydOr95dFqIIzeyzxWaNd
         PyuMbhOO4usA2M0bSu/OkCT3m9F6wTT5B6Kujcd2kf/Tk+3RUyQBuzHBs/fW61H4pf2K
         2TOWpF5Bk+rhjHqybvOcThSe7Eakuc2ndFwpKLppwAtUO5zdbVOtA+hmWKD+zwzngiTW
         TxuA==
X-Gm-Message-State: APuU4Z/S8kUI2zgGBrEbMKAZmcAJWxZAq2aFkf85lc6GqsqZFYO5lF6L
	NbLCzAotl9cHOGpBYGrMGDI0JCiyLKq12FH0cL0CgGdOEKjq89htwJFX3Gl1Gg==
X-Gm-Gg: AYBFou0baApW1Xdc0+xcz0P337tDVU54uGBEFiCqciAYlbaXQ8ywZpJiv431QQpSBg7
	+dK3BPw+9AFunCmTT8hSSOAbF7q0mmksc8woICJR9TDV2+AMsiTP5ik1dY1C7LkZxxmUcvArDWP
	dli6LGf76F2jMumJWyDqA8d19mH0lNf9mac+DxE297XRddMqYNRBhyKK+P0wVrUfiNjrHtAUUim
	v5ZOo1ofWiV/VgRzVxfiFJZuFQDBlsQ/LQ7ynnp7R7r/wCePj7cleObKpBLymCUpnq2osIjESN0
	HJ3NKRxomoFDF/cprv48NzS2ha5bxRny+oGHo+tJwYq+VdYwbGkDYALK36T1xIhUuHyqFv6g38A
	Kz+LvAQyhTdtIzLmMxYxZgZe8OE4xXk+IudlIQK26B2NrK+16AkkUYsODHOoQ4eCqaSOjZvXTBT
	K24P+dQ24303GmvClRYxNk9EgUPS4RluE1VHiDXmkGNlIXxiL2Db8tw0Y6x/kWU3a84HgwKIIdJ
	CvsbAhzEzSu3VApkwVjRMBIgHmS6I1+IG++3BNZQty3QpChMMyyI3SRNMMciGqJcpmXs+iYdYHp
	HCsRVJ1TTYKEMhy+KgLtH6zbs5Y24O+Nsr3Fghp2mKlwE4T176Q612LN8sdTQOUf
X-Received: by 2002:a05:600c:19c8:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4bb860f621fmr4314315e9.2.1795070647454;
        Wed, 18 Nov 2026 22:44:07 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85372d15sm15172955e9.14.2026.11.18.22.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:44:06 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] diffcore-delta: use size_t for the buffer size and span counts
Date: Thu, 19 Nov 2026 07:43:55 +0100
Message-ID: <621d98669e4b7e0e8fa1e947dd208ae9f57873ff.1795070117.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795070117.git.gitter.spiros@gmail.com>
References: <cover.1794909894.git.gitter.spiros@gmail.com> <cover.1795070117.git.gitter.spiros@gmail.com>
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

hash_chars() takes the size of the buffer as an "unsigned int", so for
a file of 4GiB or more only a prefix is hashed. The similarity score is
computed against the full size, so true renames are missed, which also
affects "git log --follow" and merges.

The count kept for each span hash is an "unsigned int" as well, and it
adds up the bytes of all spans with that hash. With repetitive content
most spans share a hash, so a file of 4GiB or more can wrap it, and a
count that wraps to 0 makes its entry look empty.

Use size_t for both. The hash value can stay an "unsigned int", as it
is below HASHBASE. A hash table has at most 2^17 entries, so making
them larger costs at most 1MiB more per file.

With a 16-bit size or count, "git diff --cached -M" reports "D a" and
"A b" instead of "R099 a b", for a rename of a random file and of a
64KiB file of zeros respectively. No test, as it would need a file of
4GiB or more.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 diffcore-delta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 2b7db39983..f109208866 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -37,7 +37,7 @@
 
 struct spanhash {
 	unsigned int hashval;
-	unsigned int cnt;
+	size_t cnt;
 };
 struct spanhash_top {
 	int alloc_log2;
@@ -127,7 +127,7 @@ static struct spanhash_top *hash_chars(struct repository *r,
 	unsigned int accum1, accum2, hashval;
 	struct spanhash_top *hash;
 	unsigned char *buf = one->data;
-	unsigned int sz = one->size;
+	size_t sz = one->size;
 	int is_text = !diff_filespec_is_binary(r, one);
 
 	i = INITIAL_HASH_SIZE;
@@ -198,7 +198,7 @@ int diffcore_count_changes(struct repository *r,
 	s = src_count->data;
 	d = dst_count->data;
 	for (;;) {
-		unsigned dst_cnt, src_cnt;
+		size_t dst_cnt, src_cnt;
 		if (!s->cnt)
 			break; /* we checked all in src */
 		while (d->cnt) {
-- 
2.53.0

