Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863EC1FF7C1
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961540; cv=none; b=HkotMvtCzSN46+9i1pMY2vB5EpPiqjszhKmwSa9czf8ueGotWt2Uv+pdvp7sOehFVT0ZHf4DgjCfuS7dvvNKpSWr7KJ/gCtCMleaLof9G9QODHtGOVo4NaXu825bFJjV/0gyDbpT8nUIal9sQXEonjgGqJW7GRwd0ybcrwvqPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961540; c=relaxed/simple;
	bh=laHD08UXkC6NYfki+PUjtH9iHHnBNo9I9+zBDCsujXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+yfxQ7/QX7/9BG8eUx14bS6DcnVnxfkZbM0ZHV1Sae+s/t+2gCJ4ecjZuBOq26iDWtThyuzJzYb0/IfvyIST8QFw2w1cRgytSiakUzY/5/gcUmWjcmwwqMKT4YIL7v+fvoDVM0bSF9tgMJNhJLh9IYhsLfPmVqe19bkmhipBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix5eb+4s; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix5eb+4s"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so14375855e9.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741961535; x=1742566335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZTvsrkNonguMWqOl7a5ms4H1yEv81A5pDVLgjYd46A=;
        b=Ix5eb+4saOyJP2le0L8ylesHqnICLhtSCTgFi4N5I1zqJSOeRtL2jAy5gOjdevgDzE
         vdDMRm2uPTeE5eYtJzoH2wLs3M/gkepfHnJc0SieaLV8HGuleuLvY+7/uPCGWuOdMwU1
         w31kSETGEsepSWn2ynPM0eYeCW9NhL9mwFYAyyZ624lqM8Fc2I5ZBqBumAGZhwMl7vKr
         04eN96lmIRzZHBiAJXuyo8LklgeMD7FNw1EU+UIlSOyAB4yY/rei95lgzuUjxGFLpE4U
         2c1Pn1z9J8FxHiMsatq+a8c6kv7nYtyQPaW4+B6BFGEDGYbeZpqxiKFrK7zbcBdlwHS9
         WFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961535; x=1742566335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZTvsrkNonguMWqOl7a5ms4H1yEv81A5pDVLgjYd46A=;
        b=enbUOwjdJB1XnOjo8AToW5zGt6kzsiDE43145gROdN/SkgS5VisFYqQ7AbaOT1exDW
         TLsGTrRsqYZSlB933gan3tLCNFgQHCzQljPFsbES13qmM8aBZDB9I3sOY2e2y/GprXSw
         bpuGQzgigOr1Rr8OoYuqBxuggHVYJRZc2WIT9xFHIxeqXIBWz4e00FHB+57tq9tIUfa1
         QjJC8stdBf2Z+qMWLtN4K2qRxOBQL4N0Me5P1WLg8o8AFsDXHwT6p7iMNjxyobN+YINj
         zBoa7uwQ7p2gm+VBXkCoV9ctbBa1iPzQQzrmxOrutU27o9m6RkGnWUfaygDNNH+1mE7Q
         gmgA==
X-Gm-Message-State: AOJu0YyVnoNxJeYlkW2AHaiT06HN2sv8UA+yiaUTSLf0wuW2wrU7GX/Z
	Cj0npUq6uj+i+4xhYeIiDY8yOQKTOn1CO6W/Hu9TWbH+AekFRa/6r/kmKw==
X-Gm-Gg: ASbGnctnZVmFoFQ6TaUvHBUBp0KoOD99ubdhAZ4e8CXK3JpX2RWNqo5LZeA2+qR3wCk
	dfjPs9JBLTaciyjqO/UgqbnKWEkcd8IYYAgbv3i21qDsIPstq+U2SM6bOJZZ0grpCQMnesXZi1J
	HJEPTNMuGxFgOliQwrCttk7iP1pndk6zmK4xn5krv+bYWtvnLzpofLG4slPQ/yk39oPWjqv0Pbm
	NTGnLv5SEbDdFWAro017Mc4xnZ7qCFP7ApCgl2PsVmZGxZ/af8/d0J8wZfCu7b/+JyuCiNY7Ppy
	0OY67p6opIs6Sk4bFlPwHGPXT8Mhxn8FdAIzLRB2FUJWrrdG06NsaF1wvqpsl/wBasNbjbmN0N7
	dj2ZV/itp4ywSTX9llqUwQNtmkVc=
X-Google-Smtp-Source: AGHT+IGrZSs5jrje+NpHOPn9aVGdufWDoUc2qstNrTGwp75WOtS7ijpy4wVODrvXHX8ZVXJdpPavuw==
X-Received: by 2002:a05:600c:4f16:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-43d1f235e2bmr28804135e9.12.1741961535276;
        Fri, 14 Mar 2025 07:12:15 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe3a8cdsm8418255e9.2.2025.03.14.07.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:12:14 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 2/3] promisor-remote: fix possible issue when no URL is advertised
Date: Fri, 14 Mar 2025 15:12:02 +0100
Message-ID: <20250314141203.2548803-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2.36.ga8a9f9b33b
In-Reply-To: <20250314141203.2548803-1-christian.couder@gmail.com>
References: <20250313103859.817127-1-christian.couder@gmail.com>
 <20250314141203.2548803-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the 'KnownUrl' case, in should_accept_remote(), let's check that
`remote_url` is not NULL before we use strcmp() to compare it with
the local URL. This could avoid crashes if a server starts to not
advertise any URL in the future.

If `remote_url` is NULL, we should reject the URL. Let's also warn in
this case because we warn otherwise when a remote is rejected to try
to help diagnose things at the end of the function.

And while we are checking that remote_url is not NULL and warning if
it is, it makes sense to also help diagnose the case where remote_url
is empty.

Also while at it, let's spell "URL" with uppercase letters in all the
warnings.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index ba80240f12..0b7b1ec45a 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -409,10 +409,15 @@ static int should_accept_remote(enum accept_promisor accept,
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
 
+	if (!remote_url || !*remote_url) {
+		warning(_("no or empty URL advertised for remote '%s'"), remote_name);
+		return 0;
+	}
+
 	if (!strcmp(urls->v[i], remote_url))
 		return 1;
 
-	warning(_("known remote named '%s' but with url '%s' instead of '%s'"),
+	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
 		remote_name, urls->v[i], remote_url);
 
 	return 0;
-- 
2.49.0.rc2.1.gf94452eaa2

