Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2BB8BF0
	for <git@vger.kernel.org>; Mon, 27 May 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801432; cv=none; b=B3SJnPrd5HcQzRQCNVGN/MaVh5KlKxlKMvmmxsf8SlXXKhP/DSAwF5VkZInBYkZMZsPKm8WOhQ2dGnXX4PDugHLa5oS7hUf5Gfoz5YkPEiM9jXDGOO8NEVsK29zbUEn4vVtawDIJi2qMq6i8qgnBqEQ3GRcs5N2E5YoFOT9/76I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801432; c=relaxed/simple;
	bh=EcO0fra+GRfxhqvM1fQAscc6ZAxBpkCtVVu8VsCeeqc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=QNB5H1vqLiWd/xj2FUnRSAi3lX1cgMxM+RcE37jewk5bbAmAvjmpiJtS5VsDP5k1Du7Rwz9WDEiJ8PJ7r+EuLadpRZT7YnhuU1mMhqsuTBsxwukteCnm0BzVy6tRgopC2Q/cEzj6x0gTs0rGY8mhJWz3e67jMBYIlOk5boCNTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlZs1M/0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlZs1M/0"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354e22bc14bso4337772f8f.1
        for <git@vger.kernel.org>; Mon, 27 May 2024 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716801428; x=1717406228; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zs5bjPY2bKZoe/SbBjMQx0T+BOQidEJMmmHjO6OT1+o=;
        b=BlZs1M/0HvsC4IOS7YDJwhdfcYejwfg3w0kRLOewE5eHGycyDXAqe5t7PaQRNoWlPI
         QQ2JeixwAzdaDs4Mxk6Tv0jXR7Av3Q6dCHo8crCeJ4STz7TKUc2hdwdzucUyesj4a4Fb
         W45slh6pHyzj/ZsDKfr0TLYsDwSYrFGo5VFTKeOL6HGcJfLN6id9JnQG5R5z1t3sn05e
         W0iuytDEQJSa36Z/9wEHShVNkYSeZrxkiK15nW47uB/iyTOzLDbgiHEW0vpnhOztWZug
         F37sgJ1Iajv6iWjG5akhu4rFtWessaCd2+BRUNAJU6j+TMqK+VomCVBr7xzgEbqMJN4G
         9Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716801428; x=1717406228;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zs5bjPY2bKZoe/SbBjMQx0T+BOQidEJMmmHjO6OT1+o=;
        b=dj7DtnK8KFSrGOsHkJGlq0hkDDvdOQbzUsDjjjWgTW+SHWJGo7WThfqd9A52B1wB6y
         0frj+jpSqvM6oT0tu6b1VuenR8MC3hkCTkrcm2gPybbHdSIstE0a9fGzhS8FDDwiUSXV
         40mE/1GbuLKQ+rq430wn4yUdnxhUH6VkBTkQR+UHO4np74CggZKlQKHa++fRY/utG2Ln
         FJl728GlLzUjuDfKtV6QM0QnNaLJWAJ8DP+rdovFN8BjEUhX0lXN9lIIQ9So1oiG8bTp
         EpoEImgIrCNPH+EhVMC1BRll2NprTcLVbOphCRH7fV66u7sz7r4clK9cRnCWge5mimOK
         TU6A==
X-Gm-Message-State: AOJu0YzB05GqsPmgMvC4UrYbIDdc8udBI/GbnbRQVmn6Fncyb/zweeng
	71zgeAvlXry32M7d+3I14ODBc+kulOrp26zVQSQolfXBRw2CZERS5vddDw==
X-Google-Smtp-Source: AGHT+IFawOlDUG+oNFIt8YNXZkBeyj8ga4c4AJ3G+LwTnTtK8A25H+1DwOSlpgW47duLkxuc8oi5Iw==
X-Received: by 2002:a05:6000:2a5:b0:359:b737:68c9 with SMTP id ffacd0b85a97d-359b7376aa9mr892046f8f.45.1716801428283;
        Mon, 27 May 2024 02:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7dbadsm8506135f8f.1.2024.05.27.02.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:17:07 -0700 (PDT)
Message-Id: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
From: "darcy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 May 2024 09:17:06 +0000
Subject: [PATCH] fix: prevent date underflow when using positive timezone
 offset
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: darcy <acednes@gmail.com>,
    darcy <acednes@gmail.com>

From: darcy <acednes@gmail.com>

Overriding the date of a commit to be `1970-01-01` with a large enough
timezone for the equivalent GMT time to before 1970 is no longer
accepted.

Example: `GIT_COMMITTER_DATE='1970-01-01T00:00:00+10' git commit` would
previously be accepted, only to unexpectedly fail in other parts of the
code, such as `git push`. The timestamp is now checked against postitive
timezone values.

Signed-off-by: darcy <acednes@gmail.com>
---
    fix: prevent date underflow when using positive timezone offset

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1726%2Fdxrcy%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1726/dxrcy/master-v1
Pull-Request: https://github.com/git/git/pull/1726

 date.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 7365a4ad24f..8388629f267 100644
--- a/date.c
+++ b/date.c
@@ -908,7 +908,7 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
 			match = match_alpha(date, &tm, offset);
 		else if (isdigit(c))
 			match = match_digit(date, &tm, offset, &tm_gmt);
-		else if ((c == '-' || c == '+') && isdigit(date[1]))
+		else if ((c == '-' || c == '+') && isdigit(date[1]) && tm.tm_hour != -1)
 			match = match_tz(date, offset);
 
 		if (!match) {
@@ -937,8 +937,13 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
 		}
 	}
 
-	if (!tm_gmt)
+	if (!tm_gmt) {
+		if (*offset > 0 && *offset * 60 > *timestamp) {
+			return -1;
+		}
 		*timestamp -= *offset * 60;
+	}
+
 	return 0; /* success */
 }
 

base-commit: b9cfe4845cb2562584837bc0101c0ab76490a239
-- 
gitgitgadget
