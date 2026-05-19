Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FAE21ABBB
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205115; cv=none; b=WPqwWQ06EC6MsJJ7xKgujfWZv/lx5QImc7apdSsQhHzipP5XVBzJk+PWoc13qHEK6Bxc/18qhGfsUNjzfUJ0obmQ7zLQ9jj1GPm9jfTI+BlHjES8v0oBHGUCs1fFvlrpogzA2/OybcOYrmxRb8VMgmcjeqGXEIx8mIYb4wvtZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205115; c=relaxed/simple;
	bh=WPaFQ2F3Md5e68+MK0kPlSturoUMslXA4Z+mAiBfYaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jew+l8ZrG53ZnsjdksvA3StN8+DvUrCFHuNihXdnAZPe7bAAmectdhon++owZZZYL7R74lNOnqhvRA1n8mBFOpqA8XvLFx/KOIvYu2gGkTzQIGiU1hgHST32cEmTQkYD0Di3JfvBxgGG+/M2mj0bnNnDw2RCeezwclXg+7OVP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrrPCCSA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrrPCCSA"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so7342860a12.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205111; x=1779809911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDV1xtuSot4Kn/A2k+Z4aL1m93ccahderiCRswGVM28=;
        b=ZrrPCCSAJmUeoPCuXO3P6hzsF0KhCr2KR6h4B7B4Ecse3Ec0BujSqSltn/XLoWAuXf
         NhQahUljxnYeBmVjuGrtXgH+F1eKQiCJuLW/21TMcvjweN8bWVhmsYFsdWPaEP/ND3oX
         zUkRoxul919FKRY/7XpnvXfS4GMdbfD/Vf0NQpdBYi06FrU0bsg70jumYQ4b9SQpXDAt
         fRLRxTQlXuQZVRuGLL8UFVmiTfK+tx25sQcmBapUyuxy80APUMVd6UEw639hJ5UAoovX
         KAh0CIwh+aQt8EAXNvPhHx/4FcWEaIty0zvhw0GhVjbhMnq77DNI3rkCIDPlMNFcX2Vc
         MbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205111; x=1779809911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDV1xtuSot4Kn/A2k+Z4aL1m93ccahderiCRswGVM28=;
        b=fiwWLCdtObzHod86nyLPgrMGFQMyruSdgLv1xUXvw6MknGqfhnVFTGTPFRg82ryTOh
         RxckKYKna+8bq6KQZkhv+5cevNAPCor+9D1sLBMGILzmgn0F+BgBVWcuu6RFv7Un8tbP
         85zlpMURackcAWFmCdrTr9lT6qfgJfvq0JyL7KJU7bymR2/qpPOCDVvXjnlIz1Ixm8wK
         4/EA01kXtpSAOUYJZy20xExeMh8p2FlhKgHUAQQiGsCERZ1qK1OI0Onlv1tSB+cqWUQD
         yNFa/pVgHIkdIC0igUNvjsRBzs53b1eWKxaIKIluU8MTAvZne4qQqTXq4Vt83gMgHgXt
         QDqQ==
X-Gm-Message-State: AOJu0Yyw9Lv5R2iep7ptc7bLPENyLeG4oLvCfELSCTmdK7iTARa54l42
	ORozepYkWqmTgjHKpyHVJXYRjqgJ/BrxkKywnTlWVN18y67S9BCQfwk2sTqi+Q==
X-Gm-Gg: Acq92OElvmjkRUwSSwwQu/TBrD60STXJnIVdJhwgVVfJiVy2sChBjPs10cczWUPWKc8
	q9aiPvRMrZs/d1bBMbvfWdf3zCEkmmQ1378QmaJgDYFFVyPiqqy25wKaHYKHelkx1sFlfm9cB2I
	lwqLz6DS+Y9KmGtJSgTH4Af+llupGzlAUyzGukDxOGwUZCm9lyPkwWnNqXUnPnwXlGZzju3StIy
	aFeA4uCHx7AYHQqjosV/i7I4PQOgo6RaBeMyO6o95aY9Aulx8p7P2M3wF7YCJkXPLwn+KFxhmZT
	kclKE5WAQNnKSpdN30Pz30rBmCQWf3ykKi4BC40LhkHMD3jvgYZ9Uob1BdMvF5LEHAovtrhfG32
	MUJSoOG53+VnfUcyUt6DL/zCdTUr6ZlJ6VOQKpoAA63tfOtsPyDnkn3doGtADvaOr76gHmj3kJD
	hCqXAkcziw48Y39K4L2Nr/3RWqTsNh3ukGj0MxsQzFCXmQLzh19eYN5h+dTq3yARq+2Hk5UG6BI
	5buJdrkctrtVkmfTr5BbnpISzVgypI70Mb+aU5z8yUhW9hJZU1pCfjW7nad
X-Received: by 2002:a17:906:418a:10b0:bd8:f7f5:269f with SMTP id a640c23a62f3a-bd8f7f56a2cmr301058766b.6.1779205111329;
        Tue, 19 May 2026 08:38:31 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd7bbae7a93sm281403766b.22.2026.05.19.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:38:30 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/8] urlmatch: add url_normalize_pattern() helper
Date: Tue, 19 May 2026 17:38:03 +0200
Message-ID: <20260519153808.494105-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.136.g92075d88d8
In-Reply-To: <20260519153808.494105-1-christian.couder@gmail.com>
References: <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260519153808.494105-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we will need to normalize a URL glob pattern
(which may contain '*' in the host portion) and extract its component
offsets (host, path, etc.) for separate matching. Let's export a
dedicated helper function url_normalize_pattern() for that purpose.

It works like url_normalize(), but passes allow_globs=true to the
internal url_normalize_1(), so that '*' characters in the host are
accepted rather than rejected.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 urlmatch.c |  5 +++++
 urlmatch.h | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/urlmatch.c b/urlmatch.c
index 989bc7eb8b..7e734e2660 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -440,6 +440,11 @@ char *url_normalize(const char *url, struct url_info *out_info)
 	return url_normalize_1(url, out_info, false);
 }
 
+char *url_normalize_pattern(const char *url, struct url_info *out_info)
+{
+	return url_normalize_1(url, out_info, true);
+}
+
 static size_t url_match_prefix(const char *url,
 			       const char *url_prefix,
 			       size_t url_prefix_len)
diff --git a/urlmatch.h b/urlmatch.h
index 5ba85cea13..32c5067f9b 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -36,6 +36,18 @@ struct url_info {
 
 char *url_normalize(const char *, struct url_info *);
 
+/*
+ * Like url_normalize(), but also allows '*' glob characters in the host
+ * portion. Use this when normalizing URL patterns from user configuration.
+ *
+ * Note that '*' is a valid path character per RFC 3986 (as a sub-delim),
+ * so glob patterns using '*' in the path are also accepted.
+ *
+ * Returns a newly allocated normalized string and fills out_info if
+ * non-NULL, or NULL if the pattern is invalid.
+ */
+char *url_normalize_pattern(const char *url, struct url_info *out_info);
+
 struct urlmatch_item {
 	size_t hostmatch_len;
 	size_t pathmatch_len;
-- 
2.54.0.134.gbbe8e27878.dirty

