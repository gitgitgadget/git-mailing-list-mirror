Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F546186E3D
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035855; cv=none; b=hzssex4GCe9Elwtr2NJQa5M5vaflSqjD0aAimjWYJH7CvVpJyRLDcka206C8FF/mIGvEg19UpW/iJpZztCU9Efg2Ye7HBZUlV0yimld0OHcSP8316InIgjh2FX1kt//omArPn+j1UZ+9caul0UjG3MOVYFQ0TUkS/eem/6cg+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035855; c=relaxed/simple;
	bh=c57a5FZo8oc1XwZXmAykTqE3C++vUFM1nNGdVk7APJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xgde8MRKdIk0NxDXp6SV4XOWfrQetAEuwvJNkDir9Bb1ilPNEDxpC1teZpM9PSfnCdPwbBYrGONYD3+BnMSHh59qtbW8j4YpPCAre2XZ3VnzOSDWGIQP8OHPFjh/fnUIY/q97EfiBwClSwgOXfrO8gF5+BGKzVFICjHFzLLHzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOEnVvXd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOEnVvXd"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36796aee597so2428307f8f.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721035852; x=1721640652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGFI5dxykS0Ye5JgwzTOfeSKS/2TqbyMZWuGeO3hO3Y=;
        b=QOEnVvXdZtp8zcmUKknrxBiaKIVmRORs2oz5+TTnh9K14o7YGFih1/Sir7hjtKmK16
         8oMlFm/kkaAMELVLSETULcXT1vzdoUS2NDbUNu06RSRSST4uFvS4id2TSCH+K/vifT4r
         xyVGN3ibN8uG6ZS7+sSm12D4Dd5mbqx8bfThHnT3Vbkpnp9K7L6tXzsn86bEjI7Tvc3a
         lzn9M2HQGKWsmfI27dKXE1xhnbsnqUaquDHwcLTKZdCzIXYNresFGP1DYVDQ7YyhI36e
         X0SmtICVHVBvkHMeFmkOVmRTjGba5IuyClvzK/L2zEhhm2mW9WQ21LPtcKQuibUcKGvT
         +vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721035852; x=1721640652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGFI5dxykS0Ye5JgwzTOfeSKS/2TqbyMZWuGeO3hO3Y=;
        b=KB6H4T7M6fhaqNhHO67UfnXOh+V9oJQxnGj09JnHHGdIxkt/XPIZRkiC2krWz6IUR9
         F8NNHD6ImmchgCectq5p4zLfcqx9VQR94iFhvzgUdWwfvz62MyFUlOuQT6yG2zlovt9W
         CtO5K/Q7dZsPP3mQTCoJ/O9zRJfD45kbGXhSz+wyli0snQfRJktnDyucVgCarv0UYwLz
         rk/GqmjQ7hSsQtPlL/AZMdwtiadmkPSyz1cqb24DElHn8UXsJ8rvx9eHT71tKDsfxTwv
         cIX++t0ybrtx/XigZ6eqqYDG0HvntzyFQOyoadhnjLPhL7jRpxh4gYCbzm5vvv4NfTrS
         ddFA==
X-Forwarded-Encrypted: i=1; AJvYcCU+cUZIXKxKyVt1j6pMqpBVFTb7YBv8qpMBj2KvslWL8iT/CnC/stpP063OgYx6SxsIfAUaeo1Dzkp/4wktBYKRC1GY
X-Gm-Message-State: AOJu0YyUmnOmg2M+CJQTJ0AWNsZwGqQmB/FNYhFHYojPbfHuz4vfaSYU
	0LE+gajZ49aPXxOZJB/6u9I2oFwl17F+O0UsH6k0pD/A7f83GlHG
X-Google-Smtp-Source: AGHT+IH0tE0D6QGATeJzRoOh+ZISeVGAlbUi6Avt4A/j2TN0v6mXW8BqPu5+mKKkJbiyo62FIoJJ8A==
X-Received: by 2002:a5d:564a:0:b0:367:8811:5e3c with SMTP id ffacd0b85a97d-367cea6b768mr11028660f8f.20.1721035851706;
        Mon, 15 Jul 2024 02:30:51 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1a3c:da7e:77ea:d1ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm5745208f8f.68.2024.07.15.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:30:51 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 2/8] clang-format: avoid spacing around bitfield colon
Date: Mon, 15 Jul 2024 11:30:41 +0200
Message-ID: <20240715093047.49321-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715093047.49321-1-karthik.188@gmail.com>
References: <20240713134518.773053-1-karthik.188@gmail.com>
 <20240715093047.49321-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spacing around colons is currently not standardized and as such we
have the following practices in our code base:
- Spacing around the colon `int bf : 1`: 146 instances
- No spacing around the colon `int bf:1`: 148 instances
- Spacing before the colon `int bf :1`: 6 instances
- Spacing after the colon `int bf: 1`: 12 instances

Let's formalize this by picking the most followed pattern and add the
corresponding style to '.clang-format'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.clang-format b/.clang-format
index 5e128519bf..803b274dd5 100644
--- a/.clang-format
+++ b/.clang-format
@@ -72,6 +72,10 @@ AlwaysBreakAfterReturnType: None
 BinPackArguments: true
 BinPackParameters: true
 
+# Add no space around the bit field
+# unsigned bf:2;
+BitFieldColonSpacing: None
+
 # Attach braces to surrounding context except break before braces on function
 # definitions.
 # void foo()
-- 
2.45.2

