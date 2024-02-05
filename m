Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB03589C
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150341; cv=none; b=Pa/jZ/HdhjapSyxl/4t1ZtnMmlIvuAW5FhK+PE1idHMQJiwe34K107nWpewofa8GXNPmCgnywxFozNI1qbQNP9YHTMzKMNRwPeYsjr95Z+dJVMTlkBlqYm7nFam0UDYFpsjdBwWbdLaAQmOoljuRQRnl4cPfsMjBdqKawxOBpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150341; c=relaxed/simple;
	bh=wsZYCGUQCzOMvJ6fVad0yiJuHpoCzQ0xHg4CEF+2mzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nj9mJ9GsjhRP2ujrhjUZQzIKnsT+TNvot0qBcC5FqZkjyqcpj9M9Vy0T1nd4aotsJA2iTuhzhgrjQS4K/TN82idYSgvNIT9Nw+Ft7XAsu38yh5Q9HlYjSehHy+EN8IqlX0GGyDnOuCK3PTkSZBHUH7IXqnv7R5UNkpC6jlMiHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rk+2i2Qt; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk+2i2Qt"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-40fb94d42e4so36952575e9.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 08:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707150337; x=1707755137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WhG8PWCDHcFskMTiSkMCGUzOpdaXB+qbuOwrNk86mk=;
        b=Rk+2i2Qt8ljoUsdoXuGfmbvCOtM/jj3EM+4M0HuT9tH7CNKKkZNtzwODP7wa7sO+Xp
         xGzKf0Mh4IpDz7T7nfh2nzFs4IsRkih7kq3QiIHg5qVUjQsHK4oQxDU3FRJlgd3j2m1G
         RtiAY4W6bxHGcs4+Pc6sVNelKW2ENVKwItLyyQ4gyxJqMCDteH9ZYYKA/AVBlcyLfHbL
         rphmWFpOHlht6WiNDUJZQnbU6bIkZBWhQCNDEXUIzkeOmd1JvmLrui5O19VLTxeaUiPL
         JsHP1Z9jzlP3NnouRWPSaXcmPqrRMrYGkY4ZjjzfMvqDQuPGCdhsVbh7uB35vPUJYE2K
         EwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150337; x=1707755137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WhG8PWCDHcFskMTiSkMCGUzOpdaXB+qbuOwrNk86mk=;
        b=V65oettlkfFzh3yywwlbeUIuPO3junKgSiDkUaUYs/vqx1GXqC53p6QSJfr5h2EPgb
         JOb7VIgV/7n8hkwpXSXsD8/QupxHKygsOST+oVorHWHfEA3IwWk6nt/xCnoDc/NUMpVw
         cHOqtSO9FydYViGVPJE35xdTuApOxs+a6fpIpQT9AEkRCwcDAD8daQfpTNTXjeFuIk+l
         0MPkepBhu4Hi+KkTmSuqa8Ilvb1eVOmBdVHPqPWTRr6lBDCQDGULtPp9F/ItLP+PHX4N
         a9c1cgTf6ZQ7/JWV/EJmCG9b10oJKoi/2qyJ33qFlexHFhK/pYIlThLbpXY32F9mkvKQ
         ZryA==
X-Gm-Message-State: AOJu0YyuL9+IQjlUsQMGeaIaS6ZTqCf2Bx4uNRbaZxneqiQ6cM6j0yhl
	8FYOWM5kpLsJxN62LGJ7csrE29pc6DRDdVoJUqQ/XJwgtg2h6OaU639RyDhPRrk=
X-Google-Smtp-Source: AGHT+IFDyErCsIe92DFRYejM40QovWan+z8HKzUh2ZZIhmzD4u1OklAf3nxU24Ikxdx23Ebo1AEG1w==
X-Received: by 2002:a05:600c:5842:b0:40f:d301:fa81 with SMTP id ka2-20020a05600c584200b0040fd301fa81mr224251wmb.20.1707150337385;
        Mon, 05 Feb 2024 08:25:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWs39kKIJO+hBIleBcnkZC7ZSGeKd8NAAqY41UAKteED1S6QEtBUeAB8scTdW4w97BrtgCtlNWdnhOHL9Jo6kjnA8qJ+ouVReHIDCXY/QQeFmPVNhFKUzr8NLdMyQ==
Received: from localhost.localdomain ([129.0.78.143])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c1c8f00b0040eea5dc778sm2326904wms.1.2024.02.05.08.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:25:37 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [Outreachy][PATCH 1/2] date: refactor 64 bit prereq code into reusable functions
Date: Mon,  5 Feb 2024 17:25:05 +0100
Message-ID: <20240205162506.1835-1-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit we are going to port code from
"t/helper/test-date.c" and "t/t0006-date.sh" to a new
"t/unit-tests/t-date.c" file using the recently added unit test
framework.

We cannot fully port all the code from "t/helper/test-date.c" though, as
the test-tool date helper is still used by a number of "t/*.sh" tests.
The TIME_IS_64BIT and TIME_T_IS_64BIT prereqs are especially used by
"t5000-tar-tree.sh", "t5318-commit-graph.sh" and
"t5328-commit-graph-64bit-time.sh" while checking those prereqs will be
required in the new "t/unit-tests/t-date.c" file too.

To avoid duplicating in both "t/helper/test-date.c" and
"t/unit-tests/t-date.c" the small amount of code checking these prereqs,
let's move it into inline functions in "date.h".

The names of these new inline functions contain "TIME_IS_64BIT" or
"TIME_T_IS_64BIT" as it will simplify the macros we will use when
we will port code to "t/unit-tests/t-date.c" in a following commit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 date.h               | 6 ++++++
 t/helper/test-date.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/date.h b/date.h
index 6136212a19..fb70490a51 100644
--- a/date.h
+++ b/date.h
@@ -70,4 +70,10 @@ void datestamp(struct strbuf *out);
 timestamp_t approxidate_careful(const char *, int *);
 int date_overflows(timestamp_t date);
 time_t tm_to_time_t(const struct tm *tm);
+static inline int check_prereq_TIME_IS_64BIT(void) {
+	return sizeof(timestamp_t) == 8;
+}
+static inline int check_prereq_TIME_T_IS_64BIT(void) {
+	return sizeof(time_t) == 8;
+}
 #endif
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 0683d46574..be0b8679c3 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -126,9 +126,9 @@ int cmd__date(int argc UNUSED, const char **argv)
 	else if (!strcmp(*argv, "getnanos"))
 		getnanos(argv+1);
 	else if (!strcmp(*argv, "is64bit"))
-		return sizeof(timestamp_t) == 8 ? 0 : 1;
+		return !check_prereq_TIME_IS_64BIT();
 	else if (!strcmp(*argv, "time_t-is64bit"))
-		return sizeof(time_t) == 8 ? 0 : 1;
+		return !check_prereq_TIME_T_IS_64BIT();
 	else
 		usage(usage_msg);
 	return 0;
--
2.43.0.windows.1

