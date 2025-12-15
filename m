Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03671328244
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765832217; cv=none; b=RyARS0xVCbBaZHtNoeGAjOojnKme906YQpoOW/54xWWtEbmZXU8WkTQ2ydH+Gm/KGXKQKUAwJccXZ/+nmwJG8G/Y8gVe0akUpQRLjtm0z6ebUarww4H1dl/6mHSTy6iSGK4qwhX8G3M97WrEvZ7ki+x3A0CGU54Vy62UV90hjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765832217; c=relaxed/simple;
	bh=oS2cnP5WKtyPhMj72GxAYGZYHJLflFitWc1K9uhM/gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwjEs3m8RDSfcmxUzd5WhkYhY0KcZ1AHAfin9U2J13sl2EqUAmNhtnIJaTZDHGsCvHOzjPaCsmuEYzyUtYVm86s1B6x56vkUgtbom+R5iWMoRK49N0O/hvVwNg9Zl1KAOcOSw5CT2tVSFdygLHXRSjAJBKXDvYbQTkPpFsX5h90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsrmGFDH; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsrmGFDH"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6575e760f06so1174183eaf.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765832214; x=1766437014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA3c6iVecawI9SRWntuvW4RXSAR7B3a8KDc5Ccgq0BI=;
        b=KsrmGFDHcgh3b3jmyh3OyinF45ry3zMc3t2MNbPZ9u6DxReRHrZFWzFeRgBNNAB+40
         K1IJBne/L2f3RgE0orvNeQIDX3OYt9Qp3C9l2six2Hjd5LNbIWReC8WKooCobNbDxH86
         mYVt/O0RtEJcfWnewY05O028dwqT1JpRMtUzy4YXxgoLYV3BiDnRODCM+sAjwWoKcEkT
         gGpF3Zmn+j04pQCiWiCmAt84yT6JwN7Wn1nonzgeJPFZSpwncl6592Va1MfifIC0QmPF
         8v6NuQLbnCpZyXZSEl8PbapLNNlDZEc0G7DYhsQXfN65k8EYsnownCNZVmRHzgf/WzXw
         hQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765832214; x=1766437014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RA3c6iVecawI9SRWntuvW4RXSAR7B3a8KDc5Ccgq0BI=;
        b=kTx95m+stfcX6BQ4tlsxVHXeRFLk3ceMXmYtW6e9eQ+FbjYb5ul0/6+Vl0S7s4HLn9
         VCh7mX16tOhwFqW5htKTuEh/4u4zzAPTNhmh518HWSgZ2SJlE23GAJxy7Og0Akia7IVr
         jYhGIZncA9yY9S8q9eku+envoJLv4QCSb4GDGwE6616hpipevDkXryMPuLVp7+vqGI86
         2yqJA7pc2ePKqbEvtFedRYbBeD+ysPLb1hRAqOK6V1cWRi6v6FttD0RArRgir4P6hUIW
         uL9OXShkGkuYM26U2XoaJ7bQNRlArlc3QxiHA8rXxU+dPo4UFAo798FeqTSFQAQq4WIm
         U4rQ==
X-Gm-Message-State: AOJu0YzQuheAUhyiXjun2gTExsKO7qAYsupVqi+Oekl13rXaHNp449N2
	J5Vyr6EahlW8HOeqbLC8Z8WZFyT3SXPlDCVS9/yTdTV7Fq6tHDj76iiYoJ9JyA==
X-Gm-Gg: AY/fxX5N6sfnh5quExvlC8pZ3Wf/NsvqIWcTrIYgKEvOsTPO7mfQnW1iIsm2YPrM6/v
	SDtMjDG3IE+Z5SIBoFWbWvEPpr5nuf4uqaOIhVNFdlyNXwlO/1H9xEJpVqttk4dghnwkz+ILJyi
	L+CvjgmDXcUr359thCNGVSzcCrFa0mtkZRFBrG29y38pNljftt/wMygKCXGjwnAJNGFMrFdXdDp
	3bGOk0gnHG5O7P/TeWDnrNg857NbblGKdOiEpxX2Tl25LbjkgtS89xUVAvuT+mE02zvRoRBn8b1
	jzdO+uYsl4kCe0HRFKuBO8FmeCxKaapGKeTK5lqxvAXVsQNLD81pRwDCnTeteqrMm6reIknBFMq
	RvQ8ylatDwaWrohvSB/iyA0rBQ6y/BrJ0WCPT4tU5YUTEMTqyAuZIdORiCVuSogfEUWqEHoouvy
	RMvdpd9W+K6Zw9jMGNSxw=
X-Google-Smtp-Source: AGHT+IFJ4wpUronk1PlXKQNgKeMKlgeX9Hj7xErkN9Emkq7dOZ75/nQ7AywWYTFAWKtORym6E5zjAQ==
X-Received: by 2002:a05:6820:1989:b0:659:9a49:8e3a with SMTP id 006d021491bc7-65b4517dbf0mr4967781eaf.10.1765832214620;
        Mon, 15 Dec 2025 12:56:54 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360f0f4fsm8778898eaf.14.2025.12.15.12.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:56:54 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/7] strbuf: split out logic to humanise byte values
Date: Mon, 15 Dec 2025 14:56:34 -0600
Message-ID: <20251215205639.2700270-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251215205639.2700270-1-jltobler@gmail.com>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a subsequent commit, byte size values displayed in table output for
the git-repo(1) "structure" subcommand will be shown in a more
human-readable format with the appropriate unit prefixes. For this
usecase, the downscaled values and unit prefixes must be handled
separately to ensure proper column alignment.

Split out logic from strbuf_humanise() to downscale byte values and
determine the corresponding unit prefix into a separate humanise_bytes()
function that provides seperate value and unit strings.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 strbuf.c | 69 ++++++++++++++++++++++++++++----------------------------
 strbuf.h | 14 ++++++++++++
 2 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 6c3851a7f8..bb8e98872f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -836,47 +836,48 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
 }
 
-static void strbuf_humanise(struct strbuf *buf, off_t bytes,
-				 int humanise_rate)
+void humanise_bytes(off_t bytes, char **value, const char **unit,
+		    unsigned flags)
 {
+	int humanise_rate = flags & HUMANISE_RATE;
+
 	if (bytes > 1 << 30) {
-		strbuf_addf(buf,
-				humanise_rate == 0 ?
-					/* TRANSLATORS: IEC 80000-13:2008 gibibyte */
-					_("%u.%2.2u GiB") :
-					/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second */
-					_("%u.%2.2u GiB/s"),
-			    (unsigned)(bytes >> 30),
-			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(bytes >> 30),
+				 (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
+		/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second and gibibyte */
+		*unit = humanise_rate ? _("GiB/s") : _("GiB");
 	} else if (bytes > 1 << 20) {
-		unsigned x = bytes + 5243;  /* for rounding */
-		strbuf_addf(buf,
-				humanise_rate == 0 ?
-					/* TRANSLATORS: IEC 80000-13:2008 mebibyte */
-					_("%u.%2.2u MiB") :
-					/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second */
-					_("%u.%2.2u MiB/s"),
-			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
+		unsigned x = bytes + 5243; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), x >> 20,
+				 ((x & ((1 << 20) - 1)) * 100) >> 20);
+		/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second and mebibyte */
+		*unit = humanise_rate ? _("MiB/s") : _("MiB");
 	} else if (bytes > 1 << 10) {
-		unsigned x = bytes + 5;  /* for rounding */
-		strbuf_addf(buf,
-				humanise_rate == 0 ?
-					/* TRANSLATORS: IEC 80000-13:2008 kibibyte */
-					_("%u.%2.2u KiB") :
-					/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second */
-					_("%u.%2.2u KiB/s"),
-			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
+		unsigned x = bytes + 5; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), x >> 10,
+				 ((x & ((1 << 10) - 1)) * 100) >> 10);
+		/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second and kibibyte */
+		*unit = humanise_rate ? _("KiB/s") : _("KiB");
 	} else {
-		strbuf_addf(buf,
-				humanise_rate == 0 ?
-					/* TRANSLATORS: IEC 80000-13:2008 byte */
-					Q_("%u byte", "%u bytes", bytes) :
-					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
-					Q_("%u byte/s", "%u bytes/s", bytes),
-				(unsigned)bytes);
+		*value = xstrfmt(_("%u"), (unsigned)bytes);
+		*unit = humanise_rate ?
+			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
+			       Q_("byte/s", "bytes/s", bytes) :
+			       /* TRANSLATORS: IEC 80000-13:2008 byte */
+			       Q_("byte", "bytes", bytes);
 	}
 }
 
+static void strbuf_humanise(struct strbuf *buf, off_t bytes, unsigned flags)
+{
+	char *value;
+	const char *unit;
+
+	humanise_bytes(bytes, &value, &unit, flags);
+	strbuf_addf(buf, _("%s %s"), value, unit);
+	free(value);
+}
+
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	strbuf_humanise(buf, bytes, 0);
@@ -884,7 +885,7 @@ void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 
 void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
 {
-	strbuf_humanise(buf, bytes, 1);
+	strbuf_humanise(buf, bytes, HUMANISE_RATE);
 }
 
 int printf_ln(const char *fmt, ...)
diff --git a/strbuf.h b/strbuf.h
index a580ac6084..4426163e7e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,6 +367,20 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
  */
 void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
 
+enum humanise_flags {
+	/*
+	 * Use rate based unit prefixes for humanised values.
+	 */
+	HUMANISE_RATE = (1 << 0),
+};
+
+/**
+ * Converts the given byte size into a downscaled human-readable value and
+ * corresponding unit prefix as two separate strings.
+ */
+void humanise_bytes(off_t bytes, char **value, const char **unit,
+		    unsigned flags);
+
 /**
  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
  * 3.50 MiB).
-- 
2.52.0.209.ge85ae279b0

