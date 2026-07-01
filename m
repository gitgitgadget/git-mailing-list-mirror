Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA6480DEA
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908335; cv=none; b=k+0PnH/UUH0ogu/1Hyrhc/TnpNrDb51xjV47FbUlXoi+NehP7ufqEZdxMcZxTDBblc2PLGe2ysGciVjWMLK0d5ywMnoiYV0ytjHscURbE+jpJONk7TW7TGImGwm5zvVDyvRRACuWs8o2oYz8zwJmXF1QciUXA7d1ZOKsC0RgC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908335; c=relaxed/simple;
	bh=2Rc1WMYxK4jkQScE367Ltv4//O4qNpCXUfBsi7GsNeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKe+cfb/3eHcIc2d/0xPMz4hCqSdNKUJfpNR4TSFhJvfO4HBJV3Kh+Dxgs953vDtwDAggxocuVnPY3ofpNjAKF2Fr6RphExsP3AAXVOgCuheE90Vj1pcFOqdl4vsiQEOqnGyv2y8wPsbVF17RMolKu90xtegWm94UURlH6hXTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQp1iAJE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQp1iAJE"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso3438105e9.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908332; x=1783513132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itYZe/LulVvqcvmTmKahXhswsHgi4U/qhzWFD+LLzUw=;
        b=LQp1iAJE4Oo5+yLa1USiotc4wyx3J86I7ILAB4OihR98W12MPKNvy7EcdMdjkX2EqU
         3IehOL2YPluvpw58Sj8dQZkZnlu9YdztuorZMTJ6oLY5xqEaW7tEoycL/x0hi8nza354
         Kg/ywe/7/iftTjKK4ExbvT1moYAhJfGWumhQSBlIoU50mcIPKJtTTyKPui0M4r1vtr3w
         PMtGsAUtktSvm28YzfH514jReAEN8UBboK3jEJrqSrxw23BQhr6Bc5B2e9tjT/GpZlU8
         DbnHHvTxV6NGITXS0KLKEGXGqvjE/v5VrRONdFQ4YBr62cE9bfUJXG5ZjrlvrxLkOyEq
         KZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908332; x=1783513132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=itYZe/LulVvqcvmTmKahXhswsHgi4U/qhzWFD+LLzUw=;
        b=d8sMcqKQnQIBRCYaf3jvLWXYEkxrmyaq/VGw/L6N0JuvFfIn75zqPK3hp6C/F+M6wg
         xOKyNNC5DCTKLvDH+xWrPgSxjdzhI95/9MWbvRwSpWhQxBCwGRsUGcCNUpZFS0dvyVwZ
         zTeCwjb3BTqz8bBhhDz+vtXkDttiF6ERbz6d+aGlRVaeFJq7kJypG1MT5Pz2+bqY8g+b
         tsZPMkByhF2mNLl/l4xyNnoh/PrJ1s4rVWYCpgP4epQjyhfB7i07JYHCP5C7xYk/gsEQ
         VWpvc4S044U40EFmGBxDcrA90mj/DRg69+frMzrvGliqlXXoEX7e/7qv9QyJ8A1FnvKR
         GWUA==
X-Gm-Message-State: AOJu0YzXdpIi7lyC8VbzoZcK/gU8T/aSHzajHPFu5cU3gk+QWrCQx4rB
	T9w7pxAaLwsUdmCeyurkQ1AeW2r6OSTo8u8ZK+2yN57VVzhg6gc3EbC77AWJWXkH
X-Gm-Gg: AfdE7cnY4PBPHCxk5kCilp12Flw2+kGrp9t7em2J+iK1tDXUIkQnnh/jT57Mg+f0ksC
	XfQgMdtgQ+jdW7Xo9BtdBp4wW8dHmdyYN7ohZhFQnlDu9WkFoMdfKAvyHgINvOQ3qrfKzXUi4uo
	JZGeETf1/KRFZ+mbx5vpCnjRbpVoWq7dIXypsu9ovLGxuuiBDckFv3M2azIMbJ7eRrlZZC1Hyrk
	19KsExFhu4amxAHeoY4l8GzYSQqsrXQ8HopeUukSzdYf9p3wtEPnMiSLHc2qZpx+Lsd0Q2aiSx2
	U3/cX8cYFTk5GWOJDS/WncDtSVeElR5IA0KfZDsvaJr1oXsf3ZjqK/WvVD4I2Vt3slU1emRuMRC
	aD6zrciCpcVoErtjT5EJlfiB1o7uyAV0dN8hbzY2fTlyHnEMHWCGbeT4gZhkslgrh6syh7gbOi5
	J+J6POsuo+Zsj3mAt6QpeBQhaMKzORnLSTBX6ufq77cqCEqGgEFzXxXVitBUIQ1IFGHV/SYJm8H
	/dtO9pkMYCxUSqXcrH6QJ8RSkjXkumidWs/DKAz/+6yBbpXp2QvpEwbM3bSJUgrGYcYh6/OAZPT
	/squQo99Qv9GxWNSmlYkqNFdUAmMk5P70YVNKHtL5PwwzNn8NBJRsNC4ER78ShvtC6oD1jwhYK/
	BxQaA76fOqTCyDvVvYXiD
X-Received: by 2002:a05:600c:3f07:b0:492:4a56:690b with SMTP id 5b1f17b1804b1-493c2b9e2a0mr21141255e9.35.1782908332224;
        Wed, 01 Jul 2026 05:18:52 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.18.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:18:51 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v15 02/13] git-compat-util: add `strtoumax_szt()` with error handling
Date: Wed,  1 Jul 2026 14:18:36 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-2-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

We already have `strtoul_ui()` and similar functions that provide proper
error handling using `strtoul` from the standard library. However,
there isn't currently a variant that returns a `size_t`.

Using `strtoul` is unreliable because `size_`t is platform-dependent,
`unsigned long` could be too big to fit into a `size_t` or too small to
hold a `size_t`.

Use `strtoumax` which returns a `uintmax_t` guaranteed to be at least as
large as `size_t`, add a range check against `SIZE_MAX` to prevent
`size_t` overflow.

This variant is needed in a subsequent commit to enable returning a
`size_t` with proper error handling.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 git-compat-util.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8809776407..5ecce5bbd2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -975,6 +975,26 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 	return 0;
 }
 
+/*
+ * Convert a string to a size_t using the standard library's strtoumax, with
+ * additional error handling to ensure robustness.
+ */
+static inline int strtoumax_szt(char const *s, int base, size_t *result)
+{
+	uintmax_t uim;
+	char *p;
+
+	errno = 0;
+	/* negative values would be accepted by strtoul */
+	if (strchr(s, '-'))
+		return -1;
+	uim = strtoumax(s, &p, base);
+	if ((errno || *p || p == s) || uim > SIZE_MAX)
+		return -1;
+	*result = uim;
+	return 0;
+}
+
 static inline int strtol_i(char const *s, int base, int *result)
 {
 	long ul;

-- 
2.54.0
