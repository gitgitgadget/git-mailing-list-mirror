Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8DD3C09F3
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958180; cv=none; b=avJ//mjmdtJNgIdq1YILf6P7J45apT351E3GSwTuFhV91FhbcJ17qF/mBpZ8qcq9rKPOUD2Lc1ScA2GyuKTVZjlGr59GlnuHhBi2nC4hgkPMP1me8/NUOBsZ3rSnSkU1TKUWD2EcpNwZoRh2AoCFn55DwhuKy1pzW1PL2k4ozpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958180; c=relaxed/simple;
	bh=cFXNKNYw71Rn9ZRHcgdO+jLz0pELEzVs3t76QmllJi0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=koGW9Xl99JoUjizO62QuO43BM6clsd3nia3gWTK98InUw/RbVhXuoXTKgcTRw8oGaZC0FxWht25FjEON/RqlYuuOW0UhG5iFKg6wzivbeh4eiPZm5NTtqfSSkXe0e7VrVllrNGXXdiH6BFOMZwmu9se18P9Ry9Eh2XA4aUGHiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0SNeGho; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0SNeGho"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53391786e55so62723861cf.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 23:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791958177; x=1792562977; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lbQCb63PadE4+aeoDz7GGpgl/A70TDfkB7DLDZWlVwA=;
        b=a0SNeGholAdvzpPmLdy0Ep+SWCMXcinQn8lT9bo7r79EieeS6B9DVU0dpNmGt/SdFI
         6YZYtBexpV6X6Ir0p9HzXYzxSL9H/H+6CtrKxcjf2+PLwAzK920PoZuPNLX3hJKFtjUL
         H8B2WSWTOkwaoIGJorLw2jvviSrBnTixhl6UV0/IvVMXLdq7Q2q3bAmUdfTdFGjsugIw
         4336SxtrhW/i50/rBaoXeAqO/OA5mIl/cuinUFJRomWjejReLZyS6dD4khS41iB3OYGP
         7LqEW3YgqzvmUAh5tTvaqb04E8hfJpRuuXWkesDjOjrSX0VYhPIheDcZr3q3gCXY9VuQ
         fLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791958177; x=1792562977;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbQCb63PadE4+aeoDz7GGpgl/A70TDfkB7DLDZWlVwA=;
        b=vg60SZ1x9IWR36seq6n3KwwrJ+IU9VsJE69mGhtn6aeCC1ImlpAXSPjRposbcKLnc3
         dg2vAHS3p9tqfNeuK2NngEYVsNt5TAb8oJkC4VuaKghgRjHuRA1AZjUxQ6uwiPXNHCkw
         7MmmME2DDlBPoywcKe4PNV4vFsHmEP8eL1INI4MhLn9kAvWuN0XTAviHu914l6Nj3BVG
         KoHU0ra7Wyw6xQIGuihJ89BMSVtFBxxlgEE5k9gHaXiHvSddHDMldwLvnT055nHWG9tc
         JiCFPrMXcJcUb4dkcX2TFAzMdhEKnwHLPXBGC/tjoYtkpYqDG+W8kEHg/6HlSXNjzWfQ
         vMGw==
X-Gm-Message-State: AFq9FYKw8xu3JD3PtoLzAt7BgAW2QXSBAgDsPAEiE/gtwW23HvmFjgOY
	9dhqBmJhM92tjOXdbhnMgyaf+lDFBvpZVVwC0XwC4BGxQB9UvDV4b45HhoDYxg==
X-Gm-Gg: AYBFou34nxwc25yKttxC6eSa/9KLqHP6iRT3EqNjvD/UGMyOpypVcMxQGRJE2cxROWB
	gZd7bulrzz+j6qXqcLag1PU7MjThkeht8ik1koWJaeOJTl6I4H1cUX7kfNkBCGhK0c21pazdiGE
	/u4VBZ2k/CJr+yGS0n+9M2t1hCs+OVgefqJ+XFEbGHD8gyggEu4PbGZXMqzidDsXec4cf492pQj
	QT0qb8O2oqWqiq93elIgsl44FVNTd3QCQswyDuVQEqmFsCWKrMZ3840fK7VhsSs4fsBrdOmA24c
	9BjPNdSsIB4u1LMfuppJtETUNBBIUPCGBflamJVNUyVGJ0U9ufdevZzG70sqYN+Hz09wBdNGhnM
	bLh3RyxcW8G03mW7mnUpoKTiG04Z6f6mxX8miziJoPoIcbaFgPY3Jk1TFPUgQ5jwAygy1nzEE6j
	gg59YhSQCqvCEiNBP1mCc0OLYn/W3pnZ1AT5uttk01W9NnX5FS5HJdhQOH2sKGL7pcjAQcIy3sF
	89t7wqQ55o=
X-Received: by 2002:a05:622a:4112:b0:535:1fa:ec98 with SMTP id d75a77b69052e-5359f486ad6mr249161111cf.7.1791958177528;
        Tue, 13 Oct 2026 23:09:37 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.149.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535c977c8fbsm70201671cf.9.2026.10.13.23.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:09:36 -0700 (PDT)
Message-Id: <3dcc3d97570ea7f96628d02941d7424f84f7bf39.1791958171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 06:09:30 +0000
Subject: [PATCH 4/5] git-compat-util: add `signed_mult_overflows` and
 `mult_overflows` macros
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`unsigned_mult_overflows()` does not cover signed arithmetic, but types
such as `time_t` can be signed or unsigned. Add signed and type-generic
guards so callers can check multiplication overflow in either case.

Overflow depends on the product type selected by C's usual arithmetic
conversions. Products equal to the signed minimum are representable and
must not be rejected.

Assisted-by: Claude Opus 4.6, GPT-6 and GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index afce8b85b8..077fa94873 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,9 +85,27 @@ struct strbuf;
 
 #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
 
+#if GIT_GNUC_PREREQ(3, 1)
+#define is_unsigned_type(a) ((__typeof__(a))-1 >= 0)
+#elif __STDC_VERSION__ >= 201112L
+#define is_unsigned_type(a) _Generic((a), \
+	unsigned char: 1, \
+	unsigned short: 1, \
+	unsigned int: 1, \
+	unsigned long: 1, \
+	unsigned long long: 1, \
+	_Bool: 1, \
+	char: (CHAR_MIN == 0), \
+	default: 0)
+#endif
+
 #define maximum_signed_value_of_type(a) \
     (INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
 
+/* Account for the extra negative value on two's-complement targets. */
+#define minimum_signed_value_of_type(a) \
+    (-maximum_signed_value_of_type(a) - (INTMAX_MIN < -INTMAX_MAX))
+
 #define maximum_unsigned_value_of_type(a) \
     (UINTMAX_MAX >> (bitsizeof(uintmax_t) - bitsizeof(a)))
 
@@ -111,6 +129,38 @@ struct strbuf;
 #define unsigned_mult_overflows(a, b) \
     ((a) && (b) > maximum_unsigned_value_of_type(a) / (a))
 
+/*
+ * Returns true if the multiplication of "a" and "b" will
+ * overflow or underflow a signed type. The types of "a" and "b"
+ * must match and must be signed. Note that this macro evaluates
+ * both "a" and "b" twice!
+ */
+#define signed_mult_overflows(a, b) \
+    (((a) > 0 && (b) > 0 && (a) > maximum_signed_value_of_type(a) / (b)) || \
+     ((a) < 0 && (b) < 0 && (a) < maximum_signed_value_of_type(a) / (b)) || \
+     ((a) > 0 && (b) < 0 && (b) < minimum_signed_value_of_type(a) / (a)) || \
+     ((a) < 0 && (b) > 0 && (a) < minimum_signed_value_of_type(b) / (b)))
+
+/*
+ * Returns true if the product of "a" and "b", after the usual arithmetic
+ * conversions, cannot be represented in the multiplication expression's
+ * type. The operands must be integers and may be evaluated more than once.
+ */
+#if GIT_GNUC_PREREQ(3, 1)
+#define mult_overflows(a, b) \
+    (is_unsigned_type((a) * (b)) \
+     ? unsigned_mult_overflows((__typeof__((a) * (b)))(a), \
+			       (__typeof__((a) * (b)))(b)) \
+     : signed_mult_overflows((__typeof__((a) * (b)))(a), \
+			     (__typeof__((a) * (b)))(b)))
+#else
+/*
+ * This implementation needs GNU `typeof` to convert both operands to the
+ * multiplication's type. Skip the check without that extension.
+ */
+#define mult_overflows(a, b) 0
+#endif
+
 /*
  * Returns true if the left shift of "a" by "shift" bits will
  * overflow. The type of "a" must be unsigned.
-- 
gitgitgadget

