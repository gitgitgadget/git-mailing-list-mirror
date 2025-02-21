Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E91FBC86
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164718; cv=none; b=UU8ZbNIPrR1QHORymusvEIJb7pwS3xqaycPGK1u7DfZFVXTxFbuz2+k7G5fXKi983WuOyH/e5hwMnMvxPyhvm0WKESS+g8kzmPK3lHltqt65dtGvhNb7qp8uj98XltRkKZlhL1ExeL5qCfdDdM1bPk4zUDZlqp164Tr+J6hPTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164718; c=relaxed/simple;
	bh=jQf39Zuct+wR4JW6z6LITQkvpypWwxrl1DeWf6MugmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+pAP0mHsW+KIVJmr+62z2cqQw7a+n1mSPmLMPqeEJ9eSAr5UrIS4L/2MaVNz/7OdKBGUjUuue5s4UwDNhMCT45Bwu1ZlzIM/dSY00tYlElfvh0QJdO4CvDvDjjbAKR6XC1YY14xOGDRdFL0LObp6wMfyz/qGFnqKmTwB/YvnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccyP6WjS; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccyP6WjS"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471f686642cso22403981cf.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740164715; x=1740769515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjKdvZ0evTbbux/sZbbtdsfx2tL2kKqY33qgkar+st0=;
        b=ccyP6WjS+I4DnhzAk4RnEJelDUcXbkwWLfnFEpkVeivLFccwS2JjMdR8sRm0esTsUO
         ODJeDxyn+Y5lafX4CtIKEhtfsjnnQ+iFnjro4LKiMXeS216ZQAPF7Em1/OP485UWxqEy
         EPWe/DWAXe8vLYuqYWFyEZvNTHiPxUhJwuCeJL2jybnW5x1FWayeDJCde/8UBwso1/zd
         EMUtgWLrBDaKuMh6ORLyyY9HvGnL/8sMZY56dugQWhFwCIWj+B0SpKRwrN1zr72cmdqS
         1bCNFMJgQwNXMncZrvFLQDtXXuqu+bV7T7CGk7XtDA5u4cD5lJDbT6jpDD5Ee9qkXYfZ
         3/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164715; x=1740769515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjKdvZ0evTbbux/sZbbtdsfx2tL2kKqY33qgkar+st0=;
        b=UixGqOrfLzZgnDXrWAYls8e2Q1RDI/XjsEixjFP1T3R8hFULYopR6qT1XgRvchMygG
         8ZasJZfx+LyzHUl7kL/4hTlyEPYVLqBspxWvqBQO4uW1Fi6c5h5cxAobXjvZVzLYsV98
         0GG50wKr+Cyk2k9QVM1CxEZu7ocX5QWO0gzBlusV26MLNjfF6Wbtv38Rt47XQOB7Cczr
         UghtAtTnVhTXDAFj/8NZc4N/rwUl5fFuAQgbNAlB2NMSuw/1GF7H4hieNkk/bYlp/5Bw
         BWQrnea9cB3kbZO324avol3fYOrmTYTYdYcbR+P8b9fyAEr6S1TFUpAa/nbTKmyo8PdS
         jnEg==
X-Gm-Message-State: AOJu0Yza3a1G0JQjC86x+OtBJev5c4xJcnDPT13+WfQsREgyQSnwGkxi
	EepYfGBDvT15ntHnPmZPBkMWF8Lkng6KBUFPbE8FTizUIBmlQZtftREsS+S0zVQ=
X-Gm-Gg: ASbGncuIq/QgD79gACA2UF8IXMkeFEG5iA+f3wMelyyZcpXGTv1uKcLBy6GRGpM5wMa
	lMsRlJLWgLU18boGIZj1Zt89pFyDFY2rpqTRB9H1jS32wYyxR54R0TuXB5eK33Wpq5sLM7iL0bR
	TWYEOwaflYG6dv0oKtfKy5ePO5U/O+Yh9XEl8cINaaw1HE8i2EwwNkpLPtIndZaCYrhPpR0TdLv
	+TOpi3+eCoP11Lvdt2gnoZZ8loaDvTn5AOAtnFEwCZdO1bVtWIG7jQ6DJhD/eG3w/UWzJfXeU6e
	LRUtyq0RR3vrJl43Tq9fkHzmv088TTPsbuBs5VkahlTAOoKESzy8
X-Google-Smtp-Source: AGHT+IFrCdkkStz+TTNoPWfg6sTBNkZWtVk6i0Ha9Ppi9N4TsN3oigJhYlBcTN1Z8NaITwQLMsIsXQ==
X-Received: by 2002:a05:622a:4891:b0:472:dff:37f0 with SMTP id d75a77b69052e-4722491e991mr52792641cf.45.1740164715677;
        Fri, 21 Feb 2025 11:05:15 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720b1fe010sm32945661cf.60.2025.02.21.11.05.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 11:05:15 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v11 1/8] git-compat-util: add strtoul_ul() with error handling
Date: Fri, 21 Feb 2025 14:04:42 -0500
Message-ID: <20250221190451.12536-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221190451.12536-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already have strtoul_ui() and similar functions that provide proper
error handling using strtoul from the standard library. However,
there isn't currently a variant that returns an unsigned long.
This commit introduces strtoul_ul() to address this gap, enabling the
return of an unsigned long with proper error handling.
---
 git-compat-util.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e123288e8f..0e9a43351a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1353,6 +1353,26 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
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
+	if (errno || *p || p == s )
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 static inline int strtol_i(char const *s, int base, int *result)
 {
 	long ul;
-- 
2.48.1

