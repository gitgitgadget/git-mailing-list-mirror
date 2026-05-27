Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570E1A6813
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890927; cv=none; b=gcPc/crelSQ5h8NfL5RF3Z/Ox36hliyL5KzWNpqMKh18+VSCDzWMNYpyGiSLiQ21Omhpg4KEDj/flKpu1f5T61pQyxP/BCKFMZW41k/gR2nHPd4+yW4Ve9GKsiwOI8TxIGNKBCU34N+lVXcKy/3WSyJw05zg8y8xHu2X94en15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890927; c=relaxed/simple;
	bh=EFFOYrQL/HMvqw5uOdbrEzrEojwroRwtEUbCC/uhd10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkXqjOt2KZRVDqGB56LX41CRbR+bCKIfL7j48+tVtn1F9CkQLk++OoEoqRfR4yfo51UKG7jGlfoNIMAVBQVN1Wv2yVll0Te80TxyovUNe3jSBDkcM3wWu/3FOfihNEJcQ0APXyRj+biToGg6aKv5XY0QrXm+fWvJEMyTqyHhKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r95EezHJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r95EezHJ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd8d0e4e341so1679800366b.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890924; x=1780495724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6hh9q527b51iO6SbQAf73XYSFmXa59KvCeATLikT2Q=;
        b=r95EezHJu9Xt3bIYCIUz3eMg91V85Vk5kOnVN2OZQRpIfyyxod3NbQC9tTWQg9EWli
         U6Q4CjmGdT3LqiLH6IbBLo8C337I15tB0+yVaOZo0CdYr5IRp3liXv8jyRAs8ge/8k+J
         v5NAMKEH2sdqsajLGyjkGympUqWfOAm/g8NhyRkM4Asbqovzh0kiM1yV1Iks8jeRn9TD
         mIhoeErdK0+c8QxNCLKFSiHRRmvZJVmXeYAgybd8qlp2u3H7I9SZWOTjf6RWvNeRZfWt
         BdCknu98bBhxB6pDA7ysvxjf9dCAu6Qm7LlfAgsKeKeik7p3T5T0AcAGB1rWHwAbW+er
         BUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890924; x=1780495724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v6hh9q527b51iO6SbQAf73XYSFmXa59KvCeATLikT2Q=;
        b=EUJ1pUwdDok/BgtfntZzA8OK1VJjBzoRZ3qvzfjPN7pchPDLQ9+KsnLZnoEK4/MbgI
         GEMVUHfQSn+XfIU4ItyG/4UZA5srHko4XjHRu3ursipjxu3KbqdGEX4sYp0MsSFyh0CY
         BipnynkzUf/Qv9sit6IxOvSS+lQgI+lTGqaFkOCvSlyqz0i3+GCFZZ5WsGBeHwR17UV3
         8nULxVVQHbLc+n7XtMR2U5PJg2FjPUeYcRSLGZHlLiiu0K8nXXaIZBov2/roxfzcIPsI
         7hFr0JPyUn4choSKNXdoKfKkLM8jK//2Sh4h0HgS6mo7iLxMLPqS6s3g6hbAIxLAkZhE
         gEYA==
X-Gm-Message-State: AOJu0Yw1VI7RbpOQO+t2KJw9bK0zDz7vztnQfh9b4x889h1DDA6o0s2p
	v4wmhKHSbwyZa7+1jfAWvFVlcd8Itlz39oDYF4pSne6RVtUwKOCEZ7sOqjDlZQ==
X-Gm-Gg: Acq92OH+6+es6HdHY4ByWnekU7rcLM8oNmDEQyQB+foeGhgHn5UGN2Y9hSYnuPyFFnN
	iMuoGXrz1B6hFjpaT2BRb09x1gn6pDoexrn1Wz9cJ0ZGU9bXYIVR4AcldfSn0Xtc3TolN8N4ZGG
	7nojyyDnAQY8hC8cfIVUi36//KEmkHe3ltXxh7IJI4UwAmEOrlvZBmphH6Y00+x1S6+tnj351vM
	YxFjOMYgmXMHPgEiNvKFKZVeKANlhk9xsKRzu16rj0FwDnGjAuUrGzF3Gtcpk2fUFefYykDRLQw
	TZuTJgl8ES/z5ZOOJK0qCTJx+G7Xg5G4HkEnMz/hj4FO+P9Uh+ocT9viClRwkWx3HZ/6gWRoFwx
	6UHPv7Xrx3zjOPybDnYR9T8XPo5T35xeiihtLw0n3xNpugAjJNO73F56hGKymTT1PJQM5tiGHUZ
	emKQfGIhm0czD6dRzuhjxxY2WGA374o+nEaXfwvDC+uIyRmWpBHLI/IQ6Q2qSfsVLoxsSrrA72S
	6Ja7fL5YkpPOUe5NXWO2gcRoKHlbhXqn7Uh4qG53rr1od0POCmUCyMj5bWI
X-Received: by 2002:a17:907:1c02:b0:be2:cf3b:acb0 with SMTP id a640c23a62f3a-be2cf4aef94mr480677266b.12.1779890924419;
        Wed, 27 May 2026 07:08:44 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be1ca138bc7sm268122366b.41.2026.05.27.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:08:43 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/8] urlmatch: add url_normalize_pattern() helper
Date: Wed, 27 May 2026 16:08:15 +0200
Message-ID: <20260527140820.1438165-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.275.g96c817d129.dirty
In-Reply-To: <20260527140820.1438165-1-christian.couder@gmail.com>
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com>
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
index b2d88a5289..20bc2d009c 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -441,6 +441,11 @@ char *url_normalize(const char *url, struct url_info *out_info)
 	return url_normalize_1(url, out_info, false);
 }
 
+char *url_normalize_pattern(const char *url, struct url_info *out_info)
+{
+	return url_normalize_1(url, out_info, true);
+}
+
 char *url_parse(const char *url_orig, struct url_info *out_info)
 {
 	struct strbuf url;
diff --git a/urlmatch.h b/urlmatch.h
index 6b3ce42858..db1a335e72 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -37,6 +37,18 @@ struct url_info {
 char *url_normalize(const char *, struct url_info *);
 char *url_parse(const char *, struct url_info *);
 
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
2.54.0.275.g96c817d129.dirty

