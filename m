Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB532E6B8
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026944; cv=none; b=pIrQDGXpRcSNnAzUGU2hh5z44k2LopGmZDyebd+9EqSoMKFByf0Oqp+ID1Jlb70gHdb09wsoKJ8r3GLgU+YpijNLWYmEUS1EyV1uBt9cMSSWTnisj10t+iuDx8Ehb0CxJtxCddK4A0W6bz5/haqdaeFjCslTJ68vMyw9Btqe5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026944; c=relaxed/simple;
	bh=fyWf90dd5HOuDt+/NI71hs3xYsu3Ps4tS3Z5HOzBeXA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uKxunPNKJSh9TAc7wDuTsavizBw8c/5qcv6b1X6Pbv6WcM00Brnw3tCs5lZkAlT0olxhJsJJlIs04erpnCoVhP4pVz/yNhNdD/L59YUldjGnpaOzgHXQOkSA8XWNz5gg4ToYz2s8tEMjK/qjj2v3ArJrarbh7C7Hng5KhCVGkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUywulPp; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUywulPp"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506362ac5f7so14132211cf.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026942; x=1771631742; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKfqBW19NpYrea2ZkZpqvIBWs/ERs2mMTMBmd2jZ1qE=;
        b=kUywulPpIbD9tLzpSKogEsOI2xZg0PTeoSCqwHrhsPQ37YkFEhXIzVvAvXy/qBImrS
         hNdZ/qGfw8Yd11C7xFhu5Tgo7WVests2um1PB9GdXAmRKupOzhuAth3TAO220INGtkIN
         LOz//urXFXHtmxR88SJc/9jEIKTzFP03aa82un3PFvu4uOmyUXfkn1dqT/B1jcGO329D
         rC4Rba3k+j+SMsl5sFXT5X1GBQX9VtBMJb3hAjKNCw+QfeAYHLVi21//rzSmlp+Wipri
         TMDSixgEV26FU6gBHJJMA4LGAOQ94HwN80cai7wTm+5yDIRt/ZyCQlsM0ITUOpDEuE4V
         3REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026942; x=1771631742;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fKfqBW19NpYrea2ZkZpqvIBWs/ERs2mMTMBmd2jZ1qE=;
        b=RGuF9I67PUlSN6Ig+jQDArzXzZaVi1n0yhqj0yLUU0hEV8R5RGmRFGyidZ/Zze2jDN
         6ikPj/lhO8wq3qxSeZHGx1xlyPz5+pydI+7QbkfgyDY3qB2iCLJGtS/mDeRdjsXBi+Ly
         d6K4hh25LB6oSPQ9D4NmlPLqB7DqvI5iV0ZOsOZ5s7GMxRiMRAiveF7ZTWBjp4ux6slg
         GRCSzriNo50KNcAcT/o1gKTp2jQeU5mfqp3bOVkQF0HwTquLP44SzBwEix8jD2DMycXe
         N+yMalMK4vOAR9AZRVwMiPTAXT12EbljovbPYphYWFDncP8Ey7ufBaX/V3enOikl1yNd
         IVtg==
X-Gm-Message-State: AOJu0Yy82et1fqh0rLgZqsTebXdA6M3JfxcUMO4hS73hkMoffxfJVIjQ
	h6QI/DEvVBskuEpbn/ltkhEjIg8X+29aiBh7LEpBaVOvMsQnH0LgEMVyiPAPQBy9
X-Gm-Gg: AZuq6aIrdLAcQ5ut+Q0bqSAOu/zuUEogdFWe/TUggLm6QQTjd5bFMgXQX6VH+LJSK9A
	wQ9Vsyfg7EDhjohmLuvfb1RMntJt8XP3fiR9vR8V//6jfAykZfN4dwc8EA10Xp6rLjV6RlB3/9q
	OHlMmQRjwO6dTeZOgjiGnyFLDZVKqq5I+jidMtVuvFPxHLJuHSOXdlkzEemo066zR0N5d9/8OrR
	UEWemaEOd0HIUBGnf4Arcwj0LfAKgfuFyxlMu7FzNA5k+jahD+wI9wAAUBWX1aGlGrWppiZkpvs
	42LEwTebF5yClcqKbaxy6EpMz1i0lpqTIZH5EQZPalw7zJIjHQ24blidiuESUWwq8QN9kjftGEV
	wzmJvund0id6WbD1DdGyhX+tWVvZG9GTGpNpD3ti64rxpRo4ER8dE90uDp0H3TrzTW2kHvip4OV
	NCmG3I3lJpRavE/GqLC7u0XF9Y
X-Received: by 2002:ac8:5a4a:0:b0:505:e5ba:14ac with SMTP id d75a77b69052e-506b403778emr18221421cf.72.1771026942079;
        Fri, 13 Feb 2026 15:55:42 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdb5dcasm81972416d6.43.2026.02.13.15.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:41 -0800 (PST)
Message-Id: <ddf6131ac9283bfbf4ec9ec000606765d887e6ec.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:16 +0000
Subject: [PATCH v2 11/13] color: add color_parse_gently()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When parsing colors, a failed parse leads to an error message due to the
result returning error(). To allow for quiet parsing, create
color_parse_gently().

To accomplish this, convert the implementation of color_parse_mem() into
a static color_parse_mem_1() helper that adds a 'gently' parameter. The
color_parse_gently() method can then use this. Since it is a near
equivalent to color_parse(), move that method down in the file so they
can be nearby while also appearing after color_parse_mem_1().

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 color.c | 25 ++++++++++++++++++-------
 color.h |  1 +
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/color.c b/color.c
index 07ac8c9d40..ec8872d2dd 100644
--- a/color.c
+++ b/color.c
@@ -223,11 +223,6 @@ static int parse_attr(const char *name, size_t len)
 	return -1;
 }
 
-int color_parse(const char *value, char *dst)
-{
-	return color_parse_mem(value, strlen(value), dst);
-}
-
 /*
  * Write the ANSI color codes for "c" to "out"; the string should
  * already have the ANSI escape code in it. "out" should have enough
@@ -264,7 +259,8 @@ static int color_empty(const struct color *c)
 	return c->type <= COLOR_NORMAL;
 }
 
-int color_parse_mem(const char *value, int value_len, char *dst)
+static int color_parse_mem_1(const char *value, int value_len,
+			     char *dst, int gently)
 {
 	const char *ptr = value;
 	int len = value_len;
@@ -365,10 +361,25 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	OUT(0);
 	return 0;
 bad:
-	return error(_("invalid color value: %.*s"), value_len, value);
+	return gently ? -1 : error(_("invalid color value: %.*s"), value_len, value);
 #undef OUT
 }
 
+int color_parse_mem(const char *value, int value_len, char *dst)
+{
+	return color_parse_mem_1(value, value_len, dst, 0);
+}
+
+int color_parse(const char *value, char *dst)
+{
+	return color_parse_mem(value, strlen(value), dst);
+}
+
+int color_parse_gently(const char *value, char *dst)
+{
+	return color_parse_mem_1(value, strlen(value), dst, 1);
+}
+
 enum git_colorbool git_config_colorbool(const char *var, const char *value)
 {
 	if (value) {
diff --git a/color.h b/color.h
index 43e6c9ad09..30c783405d 100644
--- a/color.h
+++ b/color.h
@@ -118,6 +118,7 @@ bool want_color_fd(int fd, enum git_colorbool var);
  * terminal.
  */
 int color_parse(const char *value, char *dst);
+int color_parse_gently(const char *value, char *dst);
 int color_parse_mem(const char *value, int len, char *dst);
 
 /*
-- 
gitgitgadget

