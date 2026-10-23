Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740398;
	b=UTOpQd/VF5pvhyVxTtVbhmWZI1Ji4Dw0ADpIvC9SzAOa/sLSW7lMweD3K3BzqA1FuNAk
	 530KNksa7k/LMaVsX+4wxJiT11bIW76XAr4YKePfH4PiZx0g6pYcpptqab/PbJl6rXGag
	 vYcayPzZxnANxTcamhq5K3STS0zhxxV7LAqNJ2UyT6a9+xeU23AC2nclkXRQsIdV5NO7s
	 MZ/GQp96B6+fXvYNgWaxOEujNd5bT0cszvMdj4xAoQRNL7+pL7YKIhZdpa10rHYo9jgug
	 2nNSg3V0q3OqzsU3P98dcSjY7gK6HBXAyA9rzLp0u38XyA0pGfKqGU2s+qxdwBbFz+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z1qgCZbhvFch6UnvjHpuT6WErWPuWQRZDUI56rGGsrA=;
	b=WMmwB4foeb4Y8PiXEsqpqmLKS2kWHfCj+ZheE34ikG4Ws0phLbIskyEr54bjca6qb8Kk
	 f3ALPgzMB9mO0QG0ZARZqnJXRwj3zz2ykIgX2aAb/HzY2hKPjZXiUG9eqIofaFs4SZmXj
	 6vWaKpSJlGgkP/vf9Hfx+pgya+DGn1Ukg7uGcba6vFtfuudH32TA0dua1ggU5SWNS5LQc
	 6t/6CGIazgOs0RX99lxc+JhuOdSSgY9XL7ufRxF4KGbbC5zgXbsdP3Nnh2LoXbR7J+OgP
	 CczBfJK5hbh4ozdEFa6Ii0CR4SrziHS9ZgSG7PTgX4x7bDwoFpyOBBJ0bcrrgixvR5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OjcOGyRt;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE960A2615
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9AE960A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OjcOGyRt
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso440384f8f.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740396; x=1793345196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1qgCZbhvFch6UnvjHpuT6WErWPuWQRZDUI56rGGsrA=;
        b=OjcOGyRt2JImCPn3rGTwr6grVYuqnvNL+pQzDV2CNOxC4j1kgQVYBoCnRMDNGDl2Gc
         0nND+FEUrieC8F6Ea4BOfslhuNvuK9Kli0GkMTAixQQr6k8dRzV9AL3F3b/pEnOk6z6x
         vX5dc0BwLOr6H/QbhW1IXfvQY637QAsauBv+rO19L91UBRpDPwEQrc3ukJnoWOFZgO16
         dCxnw5ct1hBFZo62QkTspO8Qi/Nlhv0WEAhupUCWfSyPuizm8SBSfu7jpc8Nl5BYSaf8
         j4BDrH1zOgbLsSxOHZzo5tYQiDFaSVlTLVhwf0qUppklHG1u13yZPtByTB1+8PDLWEbH
         jCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740396; x=1793345196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1qgCZbhvFch6UnvjHpuT6WErWPuWQRZDUI56rGGsrA=;
        b=JW2in/gDP2ml6bcGnxEX+El5TKbEQArS0ZGMgTlKYecYJGlth6TdPeNhpyuf1yxy1c
         8W6AMo2qFgPcXe18B5tDDZE2HtyisrBKS4dhA0vR48wHJVx6e25TsIsM2qPReZs1QDL2
         PxNNQbsoX0o+YXJuh2FbqvtzMJ0VOKgHLlvSZzkIsMlOhHpdOABg8xH9XuC3/Gm//C5b
         bns2BSjINz69BEjozeX6dFLHAj9z+66td6C6y90mKZwIRLglw3NeudOyjmFj1MAh4q/5
         WGAz/dunnJRdpBxXPfvzkGHltCkykll3FxdB2c6Atc1Klx8LWVyT/VQlRIVyP5Er2MxC
         d5UQ==
X-Gm-Message-State: AFq9FYJqE0Na1mjXBVHrcdeXUoOj8AxYPMkUeXumQ2UOA8kA7r15P+Hf
	8vI21BJJ8vmiHtOTEvEpYma9cDlx1/ikCEagVisqb8fHwv2Cpo/8o90I0VZswA==
X-Gm-Gg: AYBFou2ji/dhQIl0zDX/lRRAsGSmpdFFakDX3rEkyW3GbYDbN5XdJ+sP+dtU0Q+QYVj
	KX3i71QOfsZEz+EdbERkEnCnbZAGwxqHLSlS7QrjUnxxCxEK4X+vWQDkNfzjbiMYTzIwAJOtArH
	b86QLpwE3Xn2zdc0dVsSc2fxwB2GdB24e6SeIjOJUKPyNKQAW1Ve1lDR+j1T6G7SQfcnxNkP8fq
	nozECD7+1fBVO0ZBNjD40KQ4otpQ4ThA+TcGXYC6iTunVcE15iLDvnqxc+5QpRW9waawD+up4S/
	7CUgEEHsmN/XSF21u42p+5YaPU4HADJt1Vt+3+3vN2gNp7ysFZmgmr65YkHCLUoqkvtSLtSWafK
	3UWPg32LLcPYpFaxLr2aSUf5lOmgIWn4HB4uKorJbmh2tHCn56ezbq51AnlH6iEKAouFJ8UY2Hn
	3X/xmPeGviH4qsNO8TnLGF6XKrCqBvN0NyhAtuA0vaBrKgTevAeF8V6fN06hSwCm2vnv44TqIwH
	LTnjzMbrLSPV0VlcWlNGZuLGy+ZU4lS2cogowsNFuDTvsEgOmMtcAisurSlSsBMJcBMZ7hUqiIc
	VVai3c8QDuIk5ZGwgWGNxom7onRMkIfXuNoj4ZubC8Hgj6v0dBXXcO3DvSvLnMTznMUFDclp3YH
	43kVKs9WhBS3i4wwXfVUAOfJNwXuZqFvJaznbCDgJs3kxqrnNGcBaVpTrd5zDJP1mhw==
X-Received: by 2002:a5d:5889:0:b0:48d:f99d:a0d3 with SMTP id ffacd0b85a97d-48e385ba756mr1704484f8f.46.1792740396163;
        Fri, 23 Oct 2026 00:26:36 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:35 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 13/13] doc: move pack index v3 documentation
Date: Fri, 23 Oct 2026 09:25:58 +0200
Message-ID: <20261023072559.3204273-14-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
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

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Right now, we have our pack index v3 documentation in the hash function
transition document.  However, now that we've implemented pack index v3,
people will look for the index documentation in the normal place, so
copy it there.

We preserve it in the hash function transition document for
compatibility.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/gitformat-pack.adoc | 75 +++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/gitformat-pack.adoc b/Documentation/gitformat-pack.adoc
index 3416edceab..19afbc881e 100644
--- a/Documentation/gitformat-pack.adoc
+++ b/Documentation/gitformat-pack.adoc
@@ -318,6 +318,81 @@ Pack file entry: <+
 
     Index checksum of all of the above.
 
+== Version 3 pack-*.idx files have the format:
+
+  - A header appears at the beginning and consists of the following:
+    * The 4-byte pack index signature: '\377t0c'
+    * 4-byte version number: 3
+    * 4-byte length of the header section, including the signature and
+      version number
+    * 4-byte number of objects contained in the pack
+    * 4-byte number of object formats in this pack index: 1 or 2
+    * For each object format:
+      ** 4-byte format identifier (e.g., 'sha1' for SHA-1)
+      ** 4-byte length in bytes of shortened object names. This is the
+        shortest possible length needed to make names in the shortened
+        object name table unambiguous.
+      ** 8-byte integer, recording where tables relating to this format
+        are stored in this index file, as an offset from the beginning.
+    * 8-byte offset to the trailer from the beginning of this file.
+    * Zero or more additional key/value pairs (4-byte key, 4-byte
+      value). Only one key is supported: 'PSRC'. See the "Loose objects
+      and unreachable objects" section of the hash function transition
+      document (`Documentation/technical/hash-function-transition.adoc`)
+      for supported values and how this is used.  All other keys are reserved. Readers must ignore
+      unrecognized keys.
+  - Zero or more NUL bytes. This can optionally be used to improve the
+    alignment of the full object name table below.
+  - Tables for the first object format:
+    * A sorted table of shortened object names.  These are prefixes of
+      the names of all objects in this pack file, packed together
+      without offset values to reduce the cache footprint of the binary
+      search for a specific object name.
+
+    * A table of full object names in pack order. This allows resolving
+      a reference to "the nth object in the pack file" (from a
+      reachability bitmap or from the next table of another object
+      format) to its object name.
+
+    * A table of 4-byte values mapping object name order to pack order.
+      For an object in the table of sorted shortened object names, the
+      value at the corresponding index in this table is the index in the
+      previous table for that same object.
+      This can be used to look up the object in reachability bitmaps or
+      to look up its name in another object format.
+
+    * A table of 4-byte CRC32 values of the packed object data, in the
+      order that the objects appear in the pack file. This is to allow
+      compressed data to be copied directly from pack to pack during
+      repacking without undetected data corruption.
+
+    * A table of 4-byte offset values. The index of this table in pack order
+      indicates where that object can be found in the pack file. These are
+      usually 31-bit pack file offsets, but large offsets are encoded as
+      an index into the next table with the most significant bit set.
+
+    * A table of 8-byte offset entries (empty for pack files less than
+      2 GiB). Pack files are organized with heavily used objects toward
+      the front, so most object references should not need to refer to
+      this table.
+  - Zero or more NUL bytes.
+  - Tables for the second object format, with the same layout as above,
+    up to and not including the table of CRC32 values.
+  - Zero or more NUL bytes.
+  - The trailer consists of the following:
+    * A copy of the hash checksum at the end of the corresponding
+      packfile.
+
+    * Hash checksum of all of the above.
+
+Note that the two hashes at the end of the index file are in whatever the
+repository's main algorithm is.  In the usual case when there are multiple
+algorithms, the main algorithm will be SHA-256 and the compatibility algorithm
+will be SHA-1.  Git always writes the main algorithm first, but doesn't require this.
+
+All 4-byte numbers are in network order and must be 4-byte aligned in the file,
+so the NUL padding may be required in some cases.
+
 == pack-*.rev files have the format:
 
   - A 4-byte magic number '0x52494458' ('RIDX').
-- 
2.56.0.215.g47fdf2208c

