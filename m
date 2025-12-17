Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4877346A11
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994054; cv=none; b=LhfJ/wPi/8Y9o1roNn9inlUW0iudR9KJZhyYqqZT9T+UyToyQrGFkFDkWchhjRzHLrsIVWAPUszMQytsw8B//u/fyd/L6vf7yEWv8dZj5ZkpF+YVQBrJrv1KtZ9IKcUPTEjsbukZ4PqL4ZK2xJCGJtNQCISbvD7OqzHEVKXf2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994054; c=relaxed/simple;
	bh=7suO+1T27A8Y2GCBxwDJv7kbwRB69NaNiJnJ3F+1Gvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pN8gnflKm3a6XYrzVtyXXBJaAtJfeIelq++bnm6a7GfQX2CtsN1k5ghOTE81i1XrU4DkMTXPp1ImE5TQNiPusGFRCQHZuVd+aGE5wcSuykW184ynuDwJW40PRoyq6rkWZJRFhkgrEYHW+83NBnp5IX4dG4/XxbmrVzNMZ28wMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl6yeGxn; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl6yeGxn"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e7f68df436so651680fac.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 09:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765994050; x=1766598850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1B3yY9phpggNGMmspn7nQ+0SsszENxO/S+nWx84C40=;
        b=Tl6yeGxnj5pIaKN5cGfF8bxPjr2dIqKUGKGQ7dZ6mS/VnjY8f2StteJ2KByMcErnlY
         IJKEff/yKY6QyxrrqnBmu7iqpvdJPUo+V2dR449e48d2qmYil9/wdpij5yous/VwrYLR
         HGIiONO1LY3qK5g3p9q5FZKBCDfJnckDX1Er1QtWjl5lHfWhYrXPsIUqV/NkWwQ+g+zj
         Y1HHDvHjvkzqWk22RR/IFExUAfbUHe3XxG4Dh3EWAh2e6mXeWS9BpIYSscR6jmrz1ydP
         0lLpZkzkd3VVSmMYjSdnHKiVrOAU/YkMqBZdjMeCleOAqN71lK2qXC6E0u1Fqob9WuTT
         4a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994050; x=1766598850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1B3yY9phpggNGMmspn7nQ+0SsszENxO/S+nWx84C40=;
        b=sHTWDKAcZkeZ+BsXKmkFY6xkeSPIggKEmrAkyXmsWIHzpDPZn2C1HN4kF2rjENYqx4
         hCh8X1tW2neINSYxZ3R/BgObx2dKbyvHcHwXANB2458T6BO4L3V6Lu7/u7BUUYAkswHz
         wTS+zbBxU55rRUUt5/5EMtCD2c+NmVdZuBOQbG+vMXspZw6YY6u7l0Ry0LmS0t4TSeFS
         VK/RZiMhbUB8Q1DXNhEzS1i6M8Jc3ufkp7saWVs42Z8fs/nTajYj2oY209OlM+fp5cwV
         DYWLdrGRpMuDhqc0CINFOJMcEXmlD47e2RlsoZvOy7Vnpp9hHv09a1b3kLcs5QXUQASm
         iMqA==
X-Gm-Message-State: AOJu0YyePQzvVbEVEfNR5DgcrR8kAdL3zsU2Ui4JMByWRtgzTNsn3kqL
	RTb1WdlCPoecdjccwVSqQdlC3+UpoX36DLJ6AKVOP7qylMdOcywxujYzT65P+Q==
X-Gm-Gg: AY/fxX4tXqMeVlxTlgk0PWs3SiXLfCx/gveLrpgGhDGT5qoosam9HeJrJbek8hlOjoJ
	+hzTyrnX1Cz4KrZOMWoCFLx1D2pPv2EwfNi6r65Tx5aEfE+cTdaQ04bef+j29A4pU8O+rumRviC
	ATkjizX0m04sulLFbtygDTHnl9WsmeBeSgfjjR/I9Gidfc+hgpoj44/HGbfm3BRSgEWk8KrcxO6
	OHIGrlIxzjxxSV88RChNCQPrHHOK4wOnzfjNZypqv8QkUA/RePj/9kjEjC2wTSHuodH24QLfGTP
	SaOkl5yBwITng78U/cbdoorjZeCNs1CK+I3DtgG1f1tvJmYClReQ7FyKLv3m9lWxukd+Jr53VSf
	VTjSGNh73iUA3w+RrmtavZJHQ5E2UbgpjVxk7DCC2BLsSYojTWHbsJ1yJqHTaChWInxtIzlcfVO
	N3oClXNiXOelCoqAHhSRU=
X-Google-Smtp-Source: AGHT+IHFJQQG02aXqkt9t880y8J8l0Xc1YmhiqprujcAoX1m4NTNCQnwW9l3geOIrzqNY6FxN6W9gg==
X-Received: by 2002:a05:6870:239d:b0:3e8:9bc9:f74 with SMTP id 586e51a60fabf-3fa168f9b59mr152087fac.9.1765994050003;
        Wed, 17 Dec 2025 09:54:10 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17f4b879sm20058fac.14.2025.12.17.09.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:54:09 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 2/7] strbuf: split out logic to humanise byte values
Date: Wed, 17 Dec 2025 11:53:59 -0600
Message-ID: <20251217175404.37963-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251217175404.37963-1-jltobler@gmail.com>
References: <20251216173842.3357832-1-jltobler@gmail.com>
 <20251217175404.37963-1-jltobler@gmail.com>
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
usecase, the downscaled values and unit strings must be handled
separately to ensure proper column alignment.

Split out logic from strbuf_humanise() to downscale byte values and
determine the corresponding unit prefix into a separate humanise_bytes()
function that provides seperate value and unit strings.

Note that the "byte" string in "t/helper/test-simple-ipc.c" is unmarked
for translation here so that it doesn't conflict with the newly defined
plural "byte/bytes" translation and instead uses it.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 strbuf.c                   | 74 ++++++++++++++++++++------------------
 strbuf.h                   | 14 ++++++++
 t/helper/test-simple-ipc.c |  7 +++-
 3 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 6c3851a7f8..349ee9727a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -836,47 +836,53 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
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
+		*value = xstrfmt("%u", (unsigned)bytes);
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
+
+	/*
+	 * TRANSLATORS: The first argument is the number string. The second
+	 * argument is the unit string (i.e. "12.34 MiB/s").
+	 */
+	strbuf_addf(buf, _("%s %s"), value, unit);
+	free(value);
+}
+
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	strbuf_humanise(buf, bytes, 0);
@@ -884,7 +890,7 @@ void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 
 void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
 {
-	strbuf_humanise(buf, bytes, 1);
+	strbuf_humanise(buf, bytes, HUMANISE_RATE);
 }
 
 int printf_ln(const char *fmt, ...)
diff --git a/strbuf.h b/strbuf.h
index a580ac6084..698b3cc4a5 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,6 +367,20 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
  */
 void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
 
+enum humanise_flags {
+	/*
+	 * Use rate based units for humanised values.
+	 */
+	HUMANISE_RATE = (1 << 0),
+};
+
+/**
+ * Converts the given byte size into a downscaled human-readable value and
+ * corresponding unit as two separate strings.
+ */
+void humanise_bytes(off_t bytes, char **value, const char **unit,
+		    unsigned flags);
+
 /**
  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
  * 3.50 MiB).
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 03cc5eea2c..442ad6b16f 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -603,7 +603,12 @@ int cmd__simple_ipc(int argc, const char **argv)
 		OPT_INTEGER(0, "bytecount", &cl_args.bytecount, N_("number of bytes")),
 		OPT_INTEGER(0, "batchsize", &cl_args.batchsize, N_("number of requests per thread")),
 
-		OPT_STRING(0, "byte", &bytevalue, N_("byte"), N_("ballast character")),
+		/*
+		 * The "byte" string here is not marked for translation and
+		 * instead relies on translation in strbuf.c:humanise_bytes() to
+		 * avoid conflict with the plural form.
+		 */
+		OPT_STRING(0, "byte", &bytevalue, "byte", N_("ballast character")),
 		OPT_STRING(0, "token", &cl_args.token, N_("token"), N_("command token to send to the server")),
 
 		OPT_END()
-- 
2.52.0.209.ge85ae279b0

