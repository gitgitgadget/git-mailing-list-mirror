Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230ADB672
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739690979; cv=none; b=rdPe1rEjqFpQA9cCzA/+7OkjZ2CzriWDbBjDb3x0iRSuC4B0lCr7JkqjZRVq4rrw5kgr51kDzfGLCy8jz2ENQiuOKpscmuKCcoonQNDvRUtmNYSM1OGvNc9wNZ+pFJTghxwepFTq6E3zbWFlmlhE2lPHrsijimt5IHdlWNjstMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739690979; c=relaxed/simple;
	bh=vKr/pg3yMzpA+MxhU/qoGWvQSbkPnEJ/Uk6JR12KSPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUNp14PcFW31B41cYRZHRe7G9/WxnVXCLz+7BYBTF1UIIPEV7uRZbx9ublMagRIW7mGoHFN2pHRNDP2z1xCSQBnW+Rl2MaRkMwcsBtKtWPAHsD+QCu6fiza8E12+qoe34y4dNtCsr/p4OO97VOD+ikjl8reay3uNJFD0tGqDqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTXjLQPF; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTXjLQPF"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso4163589a91.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 23:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739690977; x=1740295777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kdamt3MdkWJuJX+63qimZmQoqWXUypM3yC0R5oiycuo=;
        b=YTXjLQPFe0D2xbyjpXisebmIooLoohoa+UKgVoITKuWcYHJb0wFYkcF0LWfPu0ONwL
         jAwAgGrY1FnOIqgWYdOt1ByJPn4WykXSSDjWPSjO+9sIOzNqJIL8TLRwAmAnH3Fb51XP
         POKGlJxwTKCTViu+zysCkEPuxUqruQ5l7AewUpHTavvDo85zSNsf5KjXuLEWjkxb5uEf
         T5snpDkwdZABSqJXwF1YNAWLuCqoUJ43cJlIl8p1EqH0eNbz+bMroak4oQCthIQZW2Nk
         MWGGtaViXP9Z4eOFdXFojqZ9w0/LA/eO0mA4tYz56ouZuqXUlrEsnJCQFItMm2QjTv1x
         Oheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739690977; x=1740295777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kdamt3MdkWJuJX+63qimZmQoqWXUypM3yC0R5oiycuo=;
        b=RJ+PS+femTFqBpIclTvT61rWR1Bwq4TS2mvS6cPLKviboLyW7Nfp8XY2p1hA95gCBr
         evTKz8cRpmSgTEEY/lX+ooA5jqrCVSx+9+uY/QcrI2qWwUpu7twySpHvj3ixBlh/JFrU
         fs2CZyS5tg+L5C+tHN36ZxaDZgmaURMYQ7mkKJFInNLuK7m7IFq7b/gx75L6ML0Zj2Ex
         qveqcwol/833reXnZrH3qfwNguowJmLFfdfcmgNMNyJVpfSUKU4wh4ioFg5j6JvlUHGs
         jbgh2CXWwqa77bEUmqmTeEs9av6mjjdoAIMNsDaqmTk0r8mAz0wXSuXSoZn1HX6+imS6
         A1wg==
X-Gm-Message-State: AOJu0YyRR7jGr+4eGxwtsIKJkFAGWMhEeB9ZqJFFjxCCrw6vf+tZ2wLk
	QAcA8UsI3ASXsbCPt0Q3h2Z5ls7Bbuus1dKxO3Y1DgG6cmftT0ST
X-Gm-Gg: ASbGnct0C1g3pZcB0kPcei8Wo6lDuVrb4y6OQVKYzdh6rFcQyWlNc/xDPkexYnrRc9M
	RXvVbFK2gkMx5ry1JWlKHzMAEJgoGIF4ia0fe+YxUKfvrA1Loyn0IuMmrjF4Ip3NMxjWbv0Nevt
	/WyNtOJj3sHfbeipibwUiokuFfazEsvOFjxqztZkvvvKhn0/6byNsi456hmp+KMD4Ppw1zG6Vho
	xIeV7EwLxqEHf8dAW4hTdmWBdey4b9u9QA7G+hKuSzJXqEJQghkghwGioreACESH63FT92CKHYX
	T+TT3VQNWqeU9Bl+JuoTjDV8Fi7qMXY4+c0r7UCbSdrSCoYSZ9cvxmHtlFdYayEKgrK3yqVYLS3
	hrANdBqvQo9n6IwSMq3t1AGqZmGrOJ3btsA==
X-Google-Smtp-Source: AGHT+IFfv8VZOSzzR6eB/3R+aznwgf96apAXumTFO2XcpypaIbpVSmjUWyX4MtVajEh6cFZJCtisug==
X-Received: by 2002:a17:90b:1d90:b0:2fa:b84:b320 with SMTP id 98e67ed59e1d1-2fc41045081mr8644533a91.24.1739690977383;
        Sat, 15 Feb 2025 23:29:37 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-18-166-75-244.ap-east-1.compute.amazonaws.com. [18.166.75.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc327a9d68sm4483243a91.1.2025.02.15.23.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 23:29:36 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com
Subject: [PATCH v3 4/6] apply: cast some ptrdiff_t's to size_t's
Date: Sun, 16 Feb 2025 07:28:41 +0000
Message-ID: <20250216072843.72385-5-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216072843.72385-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250216072843.72385-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several -Wsign-comparison warnings in "apply.c", complaining
about us comparing ptrdiff_t's with size_t's.

Fix these warnings by typecasting from ptrdiff_t to size_t. As to why
the casts is safe,

  - in function `date_len`, `date` is the starting address of a date at
  the end of the `line` and is guaranteed to be larger than (or equal
  to) `line`

  - in function `git_header_name`, `cp` is guaranteed to be larger than
  (or equal to) `second`, so `line + len` is greater than (or equal to)
  `cp` since we already treat `line + len - second` as a size_t

  - in function `git_header_name`, we are iterating `name` using
  `second`, so `second` is guaranteed to be greater than (or equal to)
  `name`

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index ac3e599bdf..c554a52f28 100644
--- a/apply.c
+++ b/apply.c
@@ -540,7 +540,7 @@ static size_t date_len(const char *line, size_t len)
 	    !isdigit(*p++) || !isdigit(*p++))	/* Not a date. */
 		return 0;
 
-	if (date - line >= strlen("19") &&
+	if ((size_t) (date - line) >= strlen("19") &&
 	    isdigit(date[-1]) && isdigit(date[-2]))	/* 4-digit year */
 		date -= strlen("19");
 
@@ -1207,7 +1207,7 @@ static char *git_header_name(int p_value,
 		cp = skip_tree_prefix(p_value, second, line + llen - second);
 		if (!cp)
 			goto free_and_fail1;
-		if (line + llen - cp != first.len ||
+		if ((size_t) (line + llen - cp) != first.len ||
 		    memcmp(first.buf, cp, first.len))
 			goto free_and_fail1;
 		return strbuf_detach(&first, NULL);
@@ -1240,7 +1240,7 @@ static char *git_header_name(int p_value,
 				goto free_and_fail2;
 
 			len = sp.buf + sp.len - np;
-			if (len < second - name &&
+			if (len < (size_t) (second - name) &&
 			    !strncmp(np, name, len) &&
 			    isspace(name[len])) {
 				/* Good */
-- 
2.43.0

