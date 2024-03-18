Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9A224CC
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740399; cv=none; b=ul4/ojfTn0gCEU+5Mw3elk+GUeILQYM90xXsC6r0i2tBUPjiC3Oc3cZs9lTZz2LCOgjpzrcCf0fKD7hzaUtN4QDLxsT12bwlqYMBm1NXLlJ0ikbCZ5HXdwzeHU9IFlmGDimb7W+D+RfHf/KHFDcX6+FOimbiWao9EJ8kHCJT7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740399; c=relaxed/simple;
	bh=cf+k4oV46H9+/IWiEap8H2kgyQHhA5TWYyCajJUfkAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwwmVVILXWsUrjO12wUXwX3oLunBhJisLvXjMsLjCu2Wt8mE6AVW1/r+FVKf0Sm5YJrzLsvb+rtczwnG8cUmQi2eVZbOMLI6y9a402Y6dKDPb7Dle8mBNvczkD2KMoYLSwqxIJOh4RFN4KywDgPVZxn+/7T2YY4RWcnp8/7Y2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/p3RpZ0; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/p3RpZ0"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6928a5e2479so8752246d6.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 22:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710740396; x=1711345196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cmj/8TLjXfMaOAQ+ASOmBDGMQg02kgGWdwt8Lb/5H4Q=;
        b=L/p3RpZ0VYgsvXbOPVkgjcyv1aHEf0rOVGsBPUs1mjGlQimNSo1PyuGeKEpspU34zA
         3hxYBp97X1BfFdxTu4LD68yyrKUfoABbG745bullaE1E2ivkKNeREZi71ry8lU0a7MRZ
         wkC/iARoP8m071YNBqfFlU8ZxzWQpHwT56yAA//XrZyIIshuLwVJq9hUpuyqDBMkm6rE
         w1BIYq3l+KJD0tZG0r5tLPpiMJOx4XjIGpoRgPCybZu9uyJ/4XmkYTvHJ34ImjZkq1FK
         1zhWwDRNR0I067AW4fITuv2Zkp+ZwoaEAk+5XemxAPiIRlilNijoIHHJhirO7IE07UIw
         p8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710740396; x=1711345196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cmj/8TLjXfMaOAQ+ASOmBDGMQg02kgGWdwt8Lb/5H4Q=;
        b=IVZf2C4+t5PC3ygOu+sCBAMPeWjgUDcE014ZXdScSTSrTeQSgymOMSykA3Wb4+CEiB
         F6xyKk55IfVdhRVbWMBklc7V5RRtDFkBUPNhVqVtx0vEd1upHDsRRVI2eL+mfg4fnAaj
         nMipIy84tb4qnJYqkUy3KdmQ0IDfV3t6nkKOVbwYrVNGH51DwndXT0y/srf+4b1p5gTE
         9fGfqWSsIsYY8copeuEL61HhPGWBSVKX4ZPIrwUIz0gds7xROCn8WUb6CZ6vRS+zHodo
         kfya2BprPeRkBetKuExRbo4j+mPygwPmtUNVZQK3DESPlJiFaSi7eoP9tzw2w+8UMRZK
         i9/w==
X-Gm-Message-State: AOJu0YzdH6VhM0Ma5k+pMnUoLbuI5YKBFQ3cJTlTaWPSIImDXZeDOMt6
	jZSWTQnLgQI3N2qE0iNMNZhd9THLCDG01EXW1qe3dtqhyH8J2W1tZM51lFQt
X-Google-Smtp-Source: AGHT+IGW9cbeGa2UhI4xudfrEIyjIGKkqY7mf8aqknbMthET+pz0z0747nunc2A10OZhWPsm3l2/ew==
X-Received: by 2002:a0c:f64f:0:b0:691:84cf:fb1 with SMTP id s15-20020a0cf64f000000b0069184cf0fb1mr8422574qvm.49.1710740395918;
        Sun, 17 Mar 2024 22:39:55 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id jo26-20020a056214501a00b006961d023d2fsm792898qvb.17.2024.03.17.22.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 22:39:55 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	linusa@google.com
Subject: [PATCH v2 1/2] docs: correct trailer `key_value_separator` description
Date: Mon, 18 Mar 2024 00:38:01 -0500
Message-ID: <20240318053848.185201-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240316035612.752910-1-brianmlyles@gmail.com>
References: <20240316035612.752910-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The description for `key_value_separator` incorrectly states that this
separator is inserted between trailer lines, which appears likely to
have been incorrectly copied from `separator` when this option was
added.

Update the description to correctly indicate that it is a separator that
appears between the key and the value of each trailer.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
Changes since v1:
- Minor wording tweak
- Minor wrapping tweak

 Documentation/pretty-formats.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d38b4ab566..e1788cb07a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -330,8 +330,8 @@ multiple times, the last occurrence wins.
 ** 'keyonly[=<bool>]': only show the key part of the trailer.
 ** 'valueonly[=<bool>]': only show the value part of the trailer.
 ** 'key_value_separator=<sep>': specify a separator inserted between
-   trailer lines. When this option is not given each trailer key-value
-   pair is separated by ": ". Otherwise it shares the same semantics
+   the key and value of each trailer. When this option is not given each trailer
+   key-value pair is separated by ": ". Otherwise it shares the same semantics
    as 'separator=<sep>' above.
 
 NOTE: Some placeholders may depend on other options given to the
-- 
2.43.2

