Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0E450917
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837865; cv=none; b=phfnM2uZ1Cv+U0hTSCk42Gskhp1GVmo0K0Xxfvj/DWVHepuBLGq+FKeZdisXEWs9/2rt9y6nqYs/+cFxm2XC+p2zfSI18TmLMsGl+0onxAGJQvLB0ZOF2mR/8ErHwLYbuf8BAdUV/uJAQj1Ox6sP6GgdRNOigiH8aXri+bIo5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837865; c=relaxed/simple;
	bh=Xgg/kxvRgsjSsF4d1du9BngLU5+zfgsgbRAzZZWAJUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n29qvkho1YYVlaOb+8VZgPmdZqLgpjDbQRyjIc7AsAUK5a/c8AUh8sW0T9D8y1WGLwJkjQjmn/fGmeQ/dOFDELBkgkf5xJ711EyWxmbbt/ZgdxoepRGhmO8fPLbiqTbBRZop/ktxl3ZCuEyRn4aFDX1h28wvNf5JjJIXICnscco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rex+g9lZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rex+g9lZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b966dd74so17041605e9.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837863; x=1786442663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wmgtJ37Mn9YjhYRRh3RWpGP8JCuHEWpDFg6b55gAGmQ=;
        b=rex+g9lZUn29QLyDMnd1N9EAkP9ZaZIZgfmqPML9XzOMDfpBWwg4K9CytCGS5ybkwY
         iaI/Xg39wyPVstPOuaBPl4LMkJO5pBnz4A6/Gka1P7+6BNFA5Mi9U8OaZVWumPDhldNF
         DrkGvuWIBenxKl5kfwywMch4ydcgS79IDIaNd6O6U5FSwWkqN3dRcAM7Um4Iokfjdf0K
         vBZDrTZsWwAKxCkZyRqOdSouM/zWIcn594FONsoQed1JV1V6nfkX8z3OvaWkj7Y0pAQD
         l6lLXT9k9uzw7n+sc/ZGE9ABKNzGMEFanmzmaRQiT6AZF8DdFKX53bcG+SakmqOUdJ0c
         PyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837863; x=1786442663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wmgtJ37Mn9YjhYRRh3RWpGP8JCuHEWpDFg6b55gAGmQ=;
        b=F6C7tFDohT7F9FHpv5CR+yoLFM/cHD7lbv2XybE0C/M5bi2fWCPGQ7DvufxIvNnliV
         zJf/43skHJtevyg6ilcjWN/SocOHM+2egdQSLUVuDAQIwFF+f1Ln+6DtxBP59Y4vnuUi
         dmWYbw6JT+RkgQvvUVDGutygn3yZtIJX++d+im67Vq8/EqeaZa7aoRLzitju87M2pBpE
         t2xJnofP/tcgH8IsPgudZ6A7h2MV78gbVAEe/K8HV0BSc+vS7gvNhURN8GBgCdwPeJGC
         75U2UZjMHaN+BxRsJI/0MEKs7ttHl+/+0mRJLXEx8sD1W7pEIiiBF0NPJNQAD3RHCZXE
         8QOw==
X-Gm-Message-State: AOJu0YxP+U+n40tEMsjBoZL57eC5sMjNJ+YcpC47wcnhoNRovWu29O6P
	gspJJaid1cNV/h2+DeqBMLiWSlp4NkX3yG3W/t0xwcchxcDXdWDYG5lbP2+EAA==
X-Gm-Gg: AR+sD10JykLNyP2TLOMNmwc7F9OnZWO1RTU5WDPe9RtNabWuyMAivN6kd2CRxHvDnkI
	OnDjOBB85D8KvlWdhHjCCWgbecKm/Oer5zMTvASNJjp5/kWZ1fdRIZFQ59c2Ydi3b807sQCDCKi
	czM4FappsvMI1jQG0NcmYLAfUalAKskVSfGFyonmZmPt3poyHBtgEiwZ7D4WAH4+j6nvzC40Eih
	4dAiF6sflQEWO4dYZazaPo6i/QUGKF+3I/1ILYbGwXyPgl1dJD1DxacSP0o53ky9QYyYX2kDu2N
	I1RQpb2FXTLnWTsNYv7GebxhERRPod06gaQ8Krs3XjCavsIp3nfn3zx3eSW7dwMsZcst3prt8L6
	7EPWvr1BTwz/wKayFlC84qDPkc85N3uppI8tqA+2tP1n29qg35nreYKI6shD9pCrkYlPoC+0ypY
	NPFhMSqN7B6pQvCK3rjF1SPfY7QawJdZ0jh/q+Xv5p4PpRmYqqAk021FZILuRflGJb4s8CItCkK
	LINHatG+xIFpFik8lfNzBFQjripr+m6g2/iQMghoLFRiA2KSbJ3VZI/lKNALLgYjI67smwCPWYh
X-Received: by 2002:a05:600c:4444:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-4980c645e1amr294413845e9.7.1785837862662;
        Tue, 04 Aug 2026 03:04:22 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:22 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 03/12] api-parse-options.adoc: document hidden and OPT_*_F option macros
Date: Tue,  4 Aug 2026 12:03:46 +0200
Message-ID: <20260804100355.1299498-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "Documentation/technical/api-parse-options.adoc", the list of option
macros does not mention the `OPT_*_F()` macro variants that take a
trailing `flags` argument, nor the `OPT_HIDDEN_GROUP()` and
`OPT_HIDDEN_BOOL()` convenience macros.

Now that a previous commit documents the per-option flags, let's
document these macros too:

  - Add a paragraph explaining the `OPT_*_F` convention and how it
    relates to the per-option flags.

  - Document `OPT_HIDDEN_GROUP()`, introduced in a previous commit,
    right after `OPT_GROUP()`.

  - Document `OPT_HIDDEN_BOOL()` right after `OPT_BOOL()`.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/technical/api-parse-options.adoc | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index fb4580e755..0e10327d07 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -213,6 +213,13 @@ Macros
 
 There are some macros to easily define options:
 
+Many of the macros below have an `_F` variant (for example `OPT_BOOL_F`,
+`OPT_STRING_F`, `OPT_INTEGER_F`, `OPT_SET_INT_F`, `OPT_BIT_F` and
+`OPT_CALLBACK_F`) that takes an additional trailing `flags` argument.
+That argument is the bitwise-or of the per-option flags described in the
+"Option flags" section above; the non-`_F` macros are simply defined
+with `flags` set to `0`.
+
 `OPT__ABBREV(&int_var)`::
 	Add `--abbrev[=<n>]`.
 
@@ -236,10 +243,21 @@ There are some macros to easily define options:
 	describes the group or an empty string.
 	Start the description with an upper-case letter.
 
+`OPT_HIDDEN_GROUP(description)`::
+	Like `OPT_GROUP()`, but the group header carries
+	`PARSE_OPT_HIDDEN`, so it is only shown by `--help-all` and not
+	by `-h`. Use it to label a group that contains only hidden
+	options, which would otherwise show an empty header under `-h`.
+
 `OPT_BOOL(short, long, &int_var, description)`::
 	Introduce a boolean option. `int_var` is set to one with
 	`--option` and set to zero with `--no-option`.
 
+`OPT_HIDDEN_BOOL(short, long, &int_var, description)`::
+	Like `OPT_BOOL()`, but the option carries `PARSE_OPT_HIDDEN`,
+	so it is hidden from `-h` while still being shown by
+	`--help-all`.
+
 `OPT_COUNTUP(short, long, &int_var, description)`::
 	Introduce a count-up option.
 	Each use of `--option` increments `int_var`, starting from zero
-- 
2.55.0.492.g44bba30fd7.dirty

