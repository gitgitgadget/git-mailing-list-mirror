Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553904;
	b=lcsQ7MfdWk1LuDbEDXPHnNDKrtsStyAr+SVe38Uyqq5NknFCxuiKwLvjDojkdm89Mw6S
	 a5a0H8HuIWpaRnixXtmhJQ4AfhOnc/8x3LFKhjfU/MmLwHMxxUSKgqIFEuBzYvdgsdz8k
	 5eUs+cPX5oeb5dVjrKTzXFiQrTOmvYHgv+pAe/oIfXYSG+F9kjAuvCo2ZQ/jUuaARFTDF
	 uGx0c+2i1/jamNWORTteeFjIWOzPJrTzI/q55cN+ZIfH+nZsV82htIXe28uKFoXt+IXTB
	 KFDpfyV31R0ovKZeYncVWnBgoFy05TogRtwlE+y5E69cBtqRVKLEohUkyPxtL0VpLaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nih6pj9XYVvcqU+lkCgkFLkUTn9oIJwgZOvHC/KVdy8=;
	b=Retaud2hQ37g68HltY4RWebA9w4O7l7Nr1OP3qLIiwYHbxosHdR31jDuyIhLZ5y5VeSm
	 QreAtfm7XW46Xx2Mrc+iR1YZGHaniBimXrHJVt7jNWEInrWVWdQGaL+ydMeCraC+r97mJ
	 StkR9G+rQk07vpN/LEBGRCsMmqCSH477yvJFc0NEkuWIKTqTTu5SSFLUdQdokKJ+7A6ui
	 oEMVY2gNjqHHtswz+icclkX33uQPjg7Gg30TIkVIH7jPfgiQrF1U4OiTO6x2794rRecwA
	 icsk9DDXl8iOZHTB4Y+r/IWfoHjLKH1o5vpcRXdJDG8eJBO+2ySKq6MgU5kgX2a7T0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D4awuFwv;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A4C606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 17:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9A4C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D4awuFwv
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e47347279so1276995f8f.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 09:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793553902; x=1794158702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nih6pj9XYVvcqU+lkCgkFLkUTn9oIJwgZOvHC/KVdy8=;
        b=D4awuFwvmp03W1wIFZuFAwvPx9Z1NDQI/5T0CCZEoiCUip9vC6ICnBRSiwonb8mqXT
         HQ0k34BAXHacmTOYlcXxK/AhPFy0bwYqFGvDkpuq887hNAq+m+MpjoqE/3qyERf44z7M
         tlPhh0t3PjTBD7OBAdoqpVn2PSt4znLIHZPthIinHRJNPGKMAbUJEgsBVqK3vbQ248GB
         m8CZvwcOlwBkverh2cU3dZxqDRjQVzU4kuhyO3wqegk8qgETuatRWhszmNedTimA8FvM
         c/UDfW3Murzk6BzUsmRZ6XWcA1rlagvS7FatODf7XB1wPWbUg9dJyyULQUSWKc0yzXsp
         tPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793553902; x=1794158702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nih6pj9XYVvcqU+lkCgkFLkUTn9oIJwgZOvHC/KVdy8=;
        b=e4D9G1kCFL2Dtm1lX6IGW34prVXULWgck1tq1lUzyXBLhb5beyZZiCwUqVi57MNz+v
         SmTA26QdQk0kpFsCHTqz0vAvWCgvLIcqSteHS1o89gMSzKMA0uc+6d5me46KrjhO0uac
         BajQT4iGZOhegqRaBoh/Q+6yyZsRu9fo7GEO/d4r6TGS8GZmMGFFU0Cr9Sl1h4hkaGbm
         36v4OgCGCRw8Y20pqHeJIQ+TtGCm47CDiGNt/E+P49ETLvZX33GAEqjkRG3dWp4P2zWc
         nQGy8F/pleAEFfqDq6bmkiYt4MrawALiEsvoxB+j9AJAriVML/tVuunqGs6CU6ts2TEn
         SpPA==
X-Gm-Message-State: APuU4Z/U4phVimLeZQ3Lz1q/dh2tOTZ8dmqRlKh7x1D51MWO5nqFB7kC
	jepvWulAflt830cIdSkEIrTF7wSJAaam+Oy4BUkNEG9wqfqXxWc64FJDfzaX8gmS
X-Gm-Gg: AYBFou3WB71wSaVLvKs3iSGhIBhkPTPxX7hHB1PoOkh938k+//vypgouMKw2KdNBmOU
	f03rVRGnvPItGLOzuBOgeEqlsik1FadqR9pFkR7L2oBUJY9ZvyZHap2KCzrAvFS9cK2aBvkfRvs
	A5idrcwgFXEvvOyc3rtyXDvQOPEpP/FDWCWyrqoyezQf6S8x9meSrfHs7tYdODmSHpm3XngxC6M
	4QNLkMXgcm2Y+DOQL0pbPrQ42OWKXF+OIHDNJVuy3XwC3IB+0oEVo/7K3/hsGnOEYYsGRG2QPmo
	Dj5O4A00Z05CtO1u+7ZlU728jKPPqfJdX/d19EvHE44p3wg6vd7wUhPwXz4kL0SvJDN77BAaiuq
	x4FkBHcnntiqkCIkFXivHefYeYuLmAWGkslHEMaqSc5c2VVhmBWwtchD//vwskgXH/6hD0/WHQk
	Dj40AH+kMu+9UQTrAqGujsgJhaACSWQhudg2dM0DJVedi1JTi2u4IMQ+L6D7KjRdaLGXM2pzc+D
	+/QwcCAT0FNtGf/FE8Ff9lzsQ0+LB62Utz/nsEkW6jNG3XeGZ8Ytyz4t7QiikwOIeaK5FcLaynZ
	FA6zkD1y/YqL4n3i+6dRU+96hA68ePePoONMWxVtvbd6th8GsimLf4zDRYMJc68=
X-Received: by 2002:a05:6000:4a16:b0:48d:f9dd:e3df with SMTP id ffacd0b85a97d-48e6e2fab79mr19146856f8f.18.1793553901991;
        Sun, 01 Nov 2026 09:25:01 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7815fsm15499584f8f.22.2026.11.01.09.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:25:01 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Jialong Wang <jerrywang183@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] apply: reject binary hunks whose size does not fit in an int
Date: Sun,  1 Nov 2026 18:24:56 +0100
Message-ID: <20261101172457.399774-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
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

In parse_binary_hunk(), the declared size of a binary hunk ("literal N"
or "delta N") is read into an "unsigned long" and then stored in
struct fragment.size, which is an "int".

Reject binary hunks whose declared size does not fit in an "int",
treating them as corrupt patches before allocation and inflation, just
as done for other malformed hunks.

Add a test with a hunk that declares a size of 3000000000. It runs
"git apply" with GIT_ALLOC_LIMIT set, so that without this fix the
oversized allocation dies instead of the patch being reported as
corrupt, and the test fails.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 apply.c                 |  4 ++++
 t/t4103-apply-binary.sh | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/apply.c b/apply.c
index a0b7119c63..731955ad09 100644
--- a/apply.c
+++ b/apply.c
@@ -2115,6 +2115,10 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
 		size -= llen;
 	}
 
+	/* frag->size is an int */
+	if (origlen > INT_MAX)
+		goto corrupt;
+
 	CALLOC_ARRAY(frag, 1);
 	frag->patch = inflate_it(data, hunk_size, origlen);
 	frag->free_patch = 1;
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index bdd4ccf9e3..70d01aa1ab 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -199,4 +199,19 @@ test_expect_success 'reject unrecognized binary diff' '
 	EOF
 	test_cmp expect err
 '
+
+test_expect_success 'reject binary diff with size exceeding INT_MAX' '
+	cat >patch.big <<-\EOF &&
+	diff --git a/f b/f
+	new file mode 100644
+	index 0000000..7898192
+	GIT binary patch
+	literal 3000000000
+	HcmV<n00001
+
+	EOF
+	test_must_fail env GIT_ALLOC_LIMIT=1m git apply patch.big 2>err &&
+	test_grep "error: corrupt binary patch" err
+'
+
 test_done

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
prerequisite-patch-id: 7adb31b4c9809dff36602bd05e0798d21a72e629
prerequisite-patch-id: 3f37dc40500ff000618807bfa583bd31990716c2
prerequisite-patch-id: 0b6bd0f4812d2f3dc805049c69a4ac25b708cc5c
-- 
2.53.0

