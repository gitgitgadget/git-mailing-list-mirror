Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276242;
	b=lAvwggD4HC/mqTBbWwh16horux+ujb6+EHm+alWDoy/iha06WuIAwG8vi0Ui8KGkSYqA
	 r41zm3cFd8k0fCCxsNl7JNuXgQIrQIS/in5O5T98+V1kKH9DjRawh0vADZaD2iecfDXB3
	 sSQZxmUvGiYXERqyLd6dNDFOukaDpgEISnjynhmxF37kK8LKhy8+/4TUbxKV0dmDwZObV
	 x6gvFIq3KTdLoc+bG5CDsPDVYfh9yvUr2uV9S4tE4vYTzyWxAodkmSFKmrvq51XYda/Z7
	 cuYMEViXVySdNErysvR1b4xDeXsxxQSFkjAkGNxHzDr41vdIZVGza0I0bh3IWkST90Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DCcTmh5Nk1uvigD9WvQ/kkCRzHbLBTzE5GrHjtoaT0w=;
	b=LaodDCTHjGo5tYKpO17SdQ0voCh3TsQd0ecPpzwE9mDCt+y9TSjnno39ya08rESwKA9M
	 eXBTkXRaKd5COWt7g8LihEC6IXkXPRrkj+GkI0iEHb0swMIkIVAGydk4RX3C81JpEE4zX
	 yOS+DwNMyZ1FHS/1uFXHcuvWig24I0wwBTmSfKz43y6ndHG0xl5d4Ys/kgzyNK7bwQC4D
	 ZgkjSIqQOSD+DqeKM1SGi2NO6o/h7eDLyVd6fssUyRZUozkYv/PBl5zLAEDws8lnRiXrB
	 /Z3lpB9IsLXv17g6XKbcOvmrPh3xgxKIgyquqW1yvuhrN+pYPUm91fX10Z/aytICu/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qEAjFX3Z;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064F606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2064F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qEAjFX3Z
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d05d51553so13923745e9.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793276240; x=1793881040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DCcTmh5Nk1uvigD9WvQ/kkCRzHbLBTzE5GrHjtoaT0w=;
        b=qEAjFX3ZxBFApB2nj0/9hq5qQwm5Hy+tUP9/DRQxvY+2qRmkIp241E4E9yQviW/U79
         U6k3E9FP38gJOCQNpGWfPnWhSsZou+6a7wtT5/w0mpYz/ONQ46X0SKHKuKhsi3P3fOwO
         IYcOgr/UvauaCYBlCnUakdZq5tlw9LYhLkl0b0WJTSj5/tzlUOEXAC+k3h7fjtukc/YD
         661OteK04g0cnYWt6ABQ18sJAdXiGMDI82j2zZZEkqGnnM6nG0xe3VCXpC5mgP6/Meb0
         YNess54LdX8eSxvct03+XctehVGDNj9S4LOz/1cRWK7CYtEFpGNyjenTSogjvdud7S9h
         sr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793276240; x=1793881040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DCcTmh5Nk1uvigD9WvQ/kkCRzHbLBTzE5GrHjtoaT0w=;
        b=PPKCeVm+fWZ+Ee2aRU2hQglqbkifRilPhDXZylt7XLMn7GXAd3w5X29/iVKFBm5PoH
         25BMfGlGmkicT1ciYVUvOHLiuFlWmAdTO3Xm72f87fsJqTo6Rq22uvMzN2CTh/pFGYCK
         xWzVHM42rXOTo8YqKxh0baSCJlBA5yP5gXZbtKyt2xrDghWA9voYqMjeJxMCodlv/f6N
         volIGXruk82qdDCmGHRF44pDomYNJef6Ke62XMu4/UqYdzYCO6IAHUISq7TAQdzV9vQr
         B8etm1R4GNfhYVPN2CFVjQ/XwCIOlHU50JOTWKiIWgd5mZY5W/wmkP2oCo3VVdKGIhVe
         Nukg==
X-Gm-Message-State: AFq9FYIHi/UYqe5CXW7nPeJseVlwxbk8SvvtlgGSfgz3J8wAKYs23Ivk
	LVhz5sjFsBIflnRbZ4PDyGgQZijDMsSk9GrpAM0fHWiNLyHuZCSvJKK6sTGi2K7W4w==
X-Gm-Gg: AYBFou2h+RUjdBZoL7UUTTHANWJsaXaShGLhrQNfL7dMqBjtb8AiIDmtjm2yp5sj5Km
	ckqQbKo1QkHZFyjV14uku9MvaDQeaTZuFGjNMryHMdg5p0FxZeIZ0FATMB8AWi3EwFV2GKMi4Kl
	FCCSV+2AURNT9NUc41fimkXy+TdYlMSv7LwgjKsu+w6wyaLU3gz1GBoksCTURSnBfO6zg5F1Yv0
	BuajKVdMCUeC3khVHQVuU1L8IKOxfScSdeWcU2bVhRGt4imknvUJA8zfCa99/JOMRrLPSiPXY8j
	sAbHDxWPUGqU6YR0Abwvtr1AphYUxq/26xGstU3CJzoB15baxYKDKbMa8tp6Lh7/dA3BrmlzTFc
	jZq9RLFFW4QCMl4o21rkdIRhg4HbKkcwyIy7STkLa4hFDLduou5nFT1dagTFxuyr3se6o7o4rHy
	ugU2Emo0FQejRslOqP3Jh98AkAjtKUaQ7ulERDkMj4KuIs2CbXaW2nX+2EFA8hJxJ3EFHBCMqzj
	Pq8t6UYwyoSJrj+2tbm/KBPOriUuHjP6LZ+xHQdFMZcOIlKd/L/4jurB5wPJ/rMtfdUVUttfZrm
	c75C81syLBzDs5EpfEPz/BRD3nykotHoxlp7JBTo6Fhb0HOV13IeeSA=
X-Received: by 2002:a05:600c:3b11:b0:4a2:267:25b3 with SMTP id 5b1f17b1804b1-4a967ba8d1bmr119415565e9.35.1793276240126;
        Thu, 29 Oct 2026 05:17:20 -0700 (PDT)
Received: from localhost.localdomain ([129.0.78.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92e104d8csm72205175e9.0.2026.10.29.05.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:17:19 -0700 (PDT)
From: Fien Dora <fiendora5@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [Outreachy PATCH v3] t1402: test --no-allow-onelevel option precedence
Date: Thu, 29 Oct 2026 13:17:15 +0100
Message-ID: <20261029121715.3845-1-fiendora5@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261027145451.8617-1-fiendora5@gmail.com>
References: <20261027145451.8617-1-fiendora5@gmail.com>
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

Unlike most Git commands that use the parse_options() API,
check-ref-format relies on a handcrafted loop to parse command-line
options. Although the --no- prefix is commonly used to negate options
in Git, the precedence of --allow-onelevel and --no-allow-onelevel
is not explicitly covered by the existing tests.

Add regression tests for both orders of --allow-onelevel and
--no-allow-onelevel to verify that the last option takes precedence.
The tests confirm that --no-allow-onelevel overrides a preceding
--allow-onelevel, and that --allow-onelevel similarly overrides a
preceding --no-allow-onelevel.

To improve Git's command-line argument parsing, I plan to
explore converting check-ref-format's handcrafted parser to
parse_options() API in a separate patch series. These tests
establish the current option-precedence behavior that the
conversion would need to preserve.

Signed-off-by: Fien Dora <fiendora5@gmail.com>
---

Changes since v2:
- Clarify that converting check-ref-format to parse_options()
  is work I plan to explore in a separate patch series, not
  an existing Git development plan.
- No changes to the tests.

 t/t1402-check-ref-format.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 9dd64662b2..6036df0210 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -74,6 +74,8 @@ invalid_ref 'heads/foo*/bar*' --refspec-pattern
 ref='foo'
 invalid_ref "$ref"
 valid_ref "$ref" --allow-onelevel
+invalid_ref "$ref" '--allow-onelevel --no-allow-onelevel'
+valid_ref "$ref" '--no-allow-onelevel --allow-onelevel'
 invalid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
 invalid_ref "$ref" --normalize
-- 
2.50.1 (Apple Git-155)

