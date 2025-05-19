Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14988280A39
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664008; cv=none; b=m8WbuMGsO5NxIo1Ky3L2uP4UrE1Pb2m9jLKiSVt+sgDzInpR2ENEcE3Z9hBq7DVhwlrzTPzGUrh2cXdRQLm7kfr9ztyyhDwC7ugzmajaXrE2am/8MV9ShLBk49NTZBCVgDktY19VWDY57tIr4AU0dE3dhO+Th8FRS5LiGAzOEZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664008; c=relaxed/simple;
	bh=H6E0GSvSGKVfx/AYD2i1KH0dQ0g/69FHNBj7SDFR8Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GutTq47PypRZNOtWDDl0tG4oBgx2OzhjgXnd8ie6eIznbT1jNSjQzsQqD01iRANkKmlLeUdZGiWhLt9sNoSTyCMYdqJ404DKjW+Y/3tFhOEvSNwQYrRsMxxvfja7uV8mnRajpctO9JWx2I05uE4V26vD2ErlRT982ObnuDR4kWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mijayGZq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mijayGZq"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a0ac853894so3883354f8f.3
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664005; x=1748268805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YBEVPSsc0SYGHZ8fDXaDuexIOXjp/6tjvj/fGN2TMg=;
        b=mijayGZqd83as1Z+IySUUmlNPmDZISl6N86kb6inIS4Sh7LRHz6etuAKgr97d3r5Qq
         Kzs06Ru08l0eKYE2dqUCC35FBrRCgkun6aJN8wNmu0kkyk/XMRlLC5TVqtzTKrDiwKao
         /YrnQIW58M7L4cPofMDGfhSymoPggdCdFMGuw4zyxG1t5gnHC4bMpUzgBgu6a7tmia1z
         G9009JKYUI6h6k5omW4MFeuvSfV9q2hF+z2jCUI3+PW/Qm20Kp8tnmvWskJJe/jIqBdj
         w1+TKgClhYzBXbwso7FaQXiThLcBZ3bD+Yb/M7QN1O15lPmlBFkz47ud+CiuX2kk5hKe
         cmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664005; x=1748268805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YBEVPSsc0SYGHZ8fDXaDuexIOXjp/6tjvj/fGN2TMg=;
        b=XLXxX80F84Z0AIcz6rZ5XwccnX/J5QO1IRMR6yoQklYer9OcN4rmlOGN3kgcrJCOZn
         Uo8EQ+OK9WDnFYYacnFYbesgAk9DcAPnnGZ5oVWcDVZmn+r0uA6YH4KLfO9sEEk0c1V3
         Yf7ectJrsx1Vml0zZZzx7MS5DB9zctDAAkeVL8MdzLewxbmpKWfwVJO8i93eYv6MvAqa
         7Tk9RAz8NI7rPcG5ohW6bosvMYitl5YeSB5x/RcgI6qFGGxYg3C0QVqrxJkoBpr974kq
         NIlVYo2aX0s+EaRdfBCE9IAImd2hgFXolO1ipIUG1Trnvwl/cr2oJ29XWa+CYI0xHlpm
         r/cA==
X-Gm-Message-State: AOJu0YxTdGbT6k3fa8lD6Oii5Vr9KQhrqinjXQbN9KF6WUZsO59RSKFI
	wPm3c9PVzdV/NfXPcQYWamZJk0JtjlSgtsRBUIv6TcdjBYyxF/hnapGm1GmAXVny
X-Gm-Gg: ASbGncsoJpVfbHuMwAoEkZyStz5iE82c6zHmwhdvjYeKmu25bn+i4qfjDnnW9Afw+Vv
	H6535yH9/d1+PyDqFtPHMilEz5DEVTy87seVpKbLd/cYde/dMv3aP5j1YDno72g16JzHI+OwzDD
	uQuoCSpsZGvKU0QEzjuXwPe4zr7Zc1LsQtufGTaoWKVzCYOdF5oeFLzedN2+xAS3B05nUz0DtnT
	+kHrEt/xnwkxyIdjmzPnhDbqQlCyaBoktCDkeMCPSmEbzc1JdbsN+0RigdFXhVYcYr3wkJ4wuiI
	PzxkHJzUFbEcjUfBuva+veq053Gb0uHzC8HyRoXZU6nstWXAFa2nH4I9dPkLeVYEHbGLElxmam8
	ipOCMcIVrlNeMch8Kk+fEmnzKi3cZvWNLDF4F
X-Google-Smtp-Source: AGHT+IEEKITHnX0DMuDSVoxxynK69NOjHbojhONWfVdI8HwoXydRqg8Gm3KJsRp7Dks4CJ4PUbFrBg==
X-Received: by 2002:a05:6000:2012:b0:3a3:5933:a0f9 with SMTP id ffacd0b85a97d-3a35c821e4fmr11442444f8f.8.1747664004810;
        Mon, 19 May 2025 07:13:24 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fa3e2ce5sm160372405e9.13.2025.05.19.07.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:13:23 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/5] promisor-remote: use string constants for 'name' and 'url' too
Date: Mon, 19 May 2025 16:12:59 +0200
Message-ID: <20250519141259.3061550-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.596.g707f6eb7a2.dirty
In-Reply-To: <20250519141259.3061550-1-christian.couder@gmail.com>
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit started to define `promisor_field_filter` and
`promisor_field_token`, and used them instead of the
"partialCloneFilter" and "token" string literals.

Let's do the same for "name" and "url" to avoid repeating them
several times and for consistency with the other fields.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 8ac1c99bed..201d767b74 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -314,6 +314,12 @@ static int allow_unsanitized(char ch)
 	return ch > 32 && ch < 127;
 }
 
+/*
+ * All the fields used in "promisor-remote" protocol capability,
+ * including the mandatory "name" and "url" ones.
+ */
+static const char promisor_field_name[] = "name";
+static const char promisor_field_url[] = "url";
 static const char promisor_field_filter[] = "partialCloneFilter";
 static const char promisor_field_token[] = "token";
 
@@ -510,9 +516,9 @@ char *promisor_remote_info(struct repository *repo)
 		if (p != config_info)
 			strbuf_addch(&sb, ';');
 
-		strbuf_addstr(&sb, "name=");
+		strbuf_addf(&sb, "%s=", promisor_field_name);
 		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
-		strbuf_addstr(&sb, ",url=");
+		strbuf_addf(&sb, ",%s=", promisor_field_url);
 		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
 
 		if (p->filter) {
@@ -661,9 +667,9 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
 		*p = '\0';
 		value = url_percent_decode(p + 1);
 
-		if (!strcmp(elem, "name"))
+		if (!strcmp(elem, promisor_field_name))
 			info->name = value;
-		else if (!strcmp(elem, "url"))
+		else if (!strcmp(elem, promisor_field_url))
 			info->url = value;
 		else if (!strcasecmp(elem, promisor_field_filter))
 			info->filter = value;
-- 
2.49.0.596.g707f6eb7a2.dirty

