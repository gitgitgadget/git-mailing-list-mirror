Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE73C3428
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913693; cv=none; b=HAQuj6b67j34291ib4VvfcrmA/PoqlgNwjEfpyGjniVD+lVRKgE/6wjG3sIEnPrHtxIRrYFFfRJMk+yZ+lBnn9Wp3Zqzd00Wrn3QlTa0AxGnRIN5kEVPDVC1H1hXU2zOUeDbpfe1+Fxc4PfxedH754Qm9TtKDtK1UjgzMH0Yw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913693; c=relaxed/simple;
	bh=72KoS7n6SkojYKkphsBYe1y8/1uuEfon+4SacLDqLZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bkf5pjec+TF2qbFnIt2vwMfdsJIvbonV9j03SBf3mT//UBRiwVp1PASXMiu1lw//ZRi+ASpRp/dCpb1QxcSMP38JhoMUV4+koN9C+7cfnCkRUUB6UXSdrS/w6OueMnwkCNrGA74DKw87XVCj4jeeapQKoS90h7tivWPbTuOuSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah0ujraD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah0ujraD"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-46019b190b6so3108534f8f.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913691; x=1781518491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOexMmL+q+mSVKaMKAdHMW0v+MToBCMv1CIvNcnR1Ic=;
        b=ah0ujraDSDP/BwbDM85wI+wlfA6VoBq2m9QZuhKDRY+n6g00xoOP7LOuPK3+WZnA0k
         TzGz2lMOmXLnaCjalRYOaL46txUtceoXaAXeRmMtoJccv1qRgHd3H65/nO3H7u5iBCH/
         et+fpqtvEIXVQ/yHTEXpsBSYs7pEcRgNJXhonBB443uLPhJ0DX/RMZWZkwFpM67K52do
         KhAPHQfJzeEjw8sJ5yZB7zvUCmKAuSm2hUkIY3xSvSubpHMEI19dmw4xVyvB7kmmg0n0
         Hwm8GToNAC0oo1VdrrtBzoXrzM7k9/vJ49lSOhIHzxoWcCA9AnyBZVGOO8KAJFlKKHAC
         NQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913691; x=1781518491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YOexMmL+q+mSVKaMKAdHMW0v+MToBCMv1CIvNcnR1Ic=;
        b=QBu/Dz/XbImxKy6C+ApfxxJxx3lrkLrpi5iWfJ4ydxHEmFW6/RGiHNTMkJkHBm2q7P
         oIrp1kuEQWXDEBkr3+HOR/vBrpaPnGxDv4dd4URr4DIaPPvqsKiHWgLV6rRT7l/9qF9Y
         P8tASbcAAPnozkACYczzR8NR12fey2XMDl3Vtv4UKThUWuR7VHdbUtfp++RHp+GOOO1c
         JwfW5EG/CwZmzbOhJtKEyYjaUZejBGQ1k7lrSyNY1AXk9qtiHg2Jb+RsHnZxJ7DhfN+J
         8cj1YRrKaCw34MbTTyYryUNjVSveQnf/AKN72srCL2HaA2sjhZj8bLzs5u+/CYb4PE3+
         U3Ug==
X-Forwarded-Encrypted: i=1; AFNElJ8Qj9+BMuKhbKvfUdfYoTq/Cx/KTVT6hUEydKAAmDrjQWAmZoh42CpZIMWkpoRQGrJplCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX75dbo2TuG1KoIEWpJFfvJUCIIHd/uRZ+TaO5iRmR5bYlDwRP
	O56TDxX7h4isKh+1CjKbD0EOzOuAjiDbulJNLr9DUcz4UqF1Eb5/N6bA
X-Gm-Gg: Acq92OGPM/q2JnPPVGBYO3xIUQCvEc0JZZMMhamswZV9ywMEeeBJ6P3jzrtTdEyM6f6
	Qt2rBpN+je3g2ENmEPRYHn8GA4fY//MMhme4o0DKhYKj23ygDF/ni5aOP6/0bsbMmFiuJo35ez0
	/KqTAAfX5XWmQUuqseT6HDWHDDot3UsiELQDeNr4YvGLc2yZ9VY65DekvNHPwqRnwIw3GWv1N6G
	GZem3WcAomlbIcDbsjX7MOT4HQGBGqbqwjJ8n3OHTWCgW/hdsx3spG82sgMY/wchjkEadSmAn7R
	g/cIzgztdAGQsW0TZm0PTSsNl0RvH7QiCHqwIt8rZc5V80i8OK11RpjUeEKhzh2ZJdC54991hnj
	9wzlK7JD0zjiyjUapctyZTQ5WYuWXPQv4tNaHfpxL8pbLLgjya7bnKGZAJfgUJLqBo5gcuvsVB8
	qvhOmDclsxOELZY+JUW4Y3aSQjVUeRNvnUbACzlcs7M+lk8/Eb1W+7vdeGqAeBj4SF02UvTMt5C
	H7BAwC17HlwApXK3+7dA6NP9Y1dcLODQoJGnvxf3uz156gE2aySTp0zQMpP6OGCJO0dO+SokNIH
	19e9iw/B8CQmAN/zW/cFQtR3kY8yjdI8ieIrB68hRRs+PpanxVp57JGzUreqSfdm4w==
X-Received: by 2002:adf:e906:0:b0:43d:77f4:7145 with SMTP id ffacd0b85a97d-46030506818mr17275509f8f.19.1780913690939;
        Mon, 08 Jun 2026 03:14:50 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.14.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:14:50 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: eric.peijian@gmail.com
Cc: calvinwan@google.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v12 02/12] git-compat-util: add strtoul_ul() with error handling
Date: Mon,  8 Jun 2026 12:14:25 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-2-5338b766e658@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

We already have strtoul_ui() and similar functions that provide proper
error handling using strtoul from the standard library. However,
there isn't currently a variant that returns an unsigned long.

This variant is needed in a subsequent commit.

Add  strtoul_ul() to address this gap, enabling the
return of an unsigned long with proper error handling.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 git-compat-util.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8809776407..4bf569f35c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -975,6 +975,26 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 	return 0;
 }
 
+/*
+ * Convert a string to an unsigned long using the standard library's strtoul,
+ * with additional error handling to ensure robustness.
+ */
+static inline int strtoul_ul(char const *s, int base, unsigned long *result)
+{
+	unsigned long ul;
+	char *p;
+
+	errno = 0;
+	/* negative values would be accepted by strtoul */
+	if (strchr(s, '-'))
+		return -1;
+	ul = strtoul(s, &p, base);
+	if (errno || *p || p == s)
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 static inline int strtol_i(char const *s, int base, int *result)
 {
 	long ul;

-- 
2.54.0
