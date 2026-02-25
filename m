Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0B2ED154
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044637; cv=none; b=OmcYos4CPyUC5xXOoG62PIX5khDZZg4oTCvXU0rexAaBGfIYTb9p1EKu3GFYHSmgzBRSx/Ck0T1xjQ+rXquO6kEOMeGuiHn98qGcvAGozN9rFteiDLrSnAEwKALAhWqYWSPHs10t7nw6bUMBfPbskJBSw735LQwACfolWnxTH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044637; c=relaxed/simple;
	bh=R4xLmtH6+DybdKTENzhtIDpW+SbNROj9N0i9qF/fNhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EC5thd6BI0MBcvokdQ6Ve6EqOtIPoeW1g136zxfKnNT1sFsL/n7MHYiyyiXqwxcnEkMPAwAEQbl6yyJEJwqs8PGf/+lM3aCdCQyK2P5c1wZytCXrOSKTqG38AfzFJt2bPAGeFfCaP5Kv9uSAkhwrS2bBcrJr5QlcacRl/GZP1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv9VTs05; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv9VTs05"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56a8dce7235so19607e0c.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044635; x=1772649435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USG858bWCVmFbTvR8ssqa4Qoe03huPrAf9GVMzB5U2Q=;
        b=Lv9VTs05PKMeEUTP76NvW9MZIXza08LVr23y71gkjoBhGVTON3b8zcouLBxXxPtZMt
         pePmqn5U20vqVTwCwLY4b5ll+IuvlwWTA6oTPHRHw65IPO/R3eBPjn4QUkqWe1JwYizM
         gy65Vj9gidyjEJpMnMFlrDn8eceZm99+MctXqZfF7aYBl2rKb0YduKbscHYog9lARqsu
         Yi34u7Ax3TKEQ0qF7njahfDA8z789DuHULYx32FpSrHT1c40veFURsJdez/DbPl2j0yy
         dqV7OYv9ZyIGFRcyi5ClpS6Aaf8bv+DUdv5+X1e9PWV6VqM8gY2r67AqwcQmp9S/FBcW
         XO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044635; x=1772649435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USG858bWCVmFbTvR8ssqa4Qoe03huPrAf9GVMzB5U2Q=;
        b=uI0h9/QkgU9LvPnqCMKg4EFgOQNJ8hFNZMnFyDr1QmjoZ6la//xd9FYNfh6LJ1Ka4G
         qG+NX/ei8N9oNt1NKFL7fmMcx2Jh3hlTZQLg5wW0MHP8xv8tuGoL8JVVW4Q5CyRiHfdX
         bO07w6hI0aP1ynZWdOUTseWSyup/0T3p2YZqWhR0w7TN9FEHcqwKeH4i89vwaRB3hWia
         60Vpq3/Jp7CQwtPxQwYIkr8naCXXPKTIjhpUfI57XyduVfNFoY8DtqFPjjwkfsJXat3C
         WXC1wq9Tp2ky+sk5tx0lrOzSSy8JDyArkIp7P2HQt44vZ3jLu4Ez0xKfd5j+8I/Kmg6Z
         l67w==
X-Gm-Message-State: AOJu0YxmPTI6u3dbfmKzsHYcbhklIsIDMmwGGggEL+gztL4C7I7h00U7
	v4wbL0O/IkkRVlxxPvoSYZ0lHbEPMSy+VXTYmxvf4YAQ+Co2yknIe+wiiN564Q==
X-Gm-Gg: ATEYQzym+Ub+qjWJfLfpCPmjUJA5igcgtIlcLXQ8Un4lv0IJZict8P5/Qht3Q9SkQ22
	k1JffnTSQhjKimiZJQiAFLG9Pnwiu1UxWrg6bfBKlB/0bXHho7EftHSIgk2yRKCEcC74j3ogsef
	tYOfU5Hb0Czw52JZBLZaonAq/RSZj6TDMOHyzREMPIiAiX8OWa1/NjWVks8wkX4dI/W/KHC9VVt
	Js8UA5PlQHD6pTwGpiGNoH69o6itVmkoCHakYyKTg40RvnOiZymu08THBOKKmIgv4B03cj5qpC7
	uh7rEceb7Snx1j3KXic/WbppI1EwQ14bVAd/doPFWfNvzK0oeCe0/XNVC+zbPWsySTKc0fpT5pg
	ngZCa5ahto8FlU7FKEo1gFRzSSCoJSuWgGfo2on7fSPwDiW7J8I1hlt6fFeyv7m4qpXQO5WWHX9
	gMtudwqaxesZ4brUPAnNa4juiQ9AAE451HkbsERxlvFCLYduSAg2uLIv/HJYwm
X-Received: by 2002:a05:6102:b11:b0:5ee:a12d:55b7 with SMTP id ada2fe7eead31-5ff140f7030mr737014137.29.1772044634711;
        Wed, 25 Feb 2026 10:37:14 -0800 (PST)
Received: from localhost.localdomain ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da89e129esm13457485241.5.2026.02.25.10.37.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 10:37:14 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 6/8] t1901: adjust nul format output instead of expected value
Date: Wed, 25 Feb 2026 13:32:15 -0300
Message-ID: <20260225183559.79303-7-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225183559.79303-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260225183559.79303-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'keyvalue and nul format', as it description says, test both
`keyvalue` and `nul` format. These formats are similar, differing only in
their field separator (= in the former, LF in the latter) and their
record separator (LF in the former, NUL in the latter). This way, both
formats can be tested using the same expected output and only replacing
the separators in one of the output formats.

However, it is not desirable to have a NUL character in the files
compared by test_cmp because, if that assetion fails, diff will consider
them binary files and won't display the differences properly.

Adjust the output of `git repo structure --format=nul` in t1901, matching the
--format=keyvalue ones. Compare this output against the same value expected
from --format=keyvalue, without using files with NUL characters in
test_cmp.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 t/t1901-repo-structure.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index a6f2591d9a..a67b38ab17 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -145,18 +145,18 @@ test_expect_success SHA1 'lines and nul format' '
 		test_cmp expect out &&
 		test_line_count = 0 err &&
 
-		# Replace key and value delimiters for nul format.
-		tr "\n=" "\0\n" <expect >expect_nul &&
 		git repo structure --format=nul >out 2>err &&
+		tr "\012\000" "=\012" <out >actual &&
 
-		test_cmp expect_nul out &&
+		test_cmp expect actual &&
 		test_line_count = 0 err &&
 
 		# "-z", as a synonym to "--format=nul", participates in the
 		# usual "last one wins" rule.
 		git repo structure --format=table -z >out 2>err &&
+		tr "\012\000" "=\012" <out >actual &&
 
-		test_cmp expect_nul out &&
+		test_cmp expect actual &&
 		test_line_count = 0 err
 	)
 '
-- 
2.50.1 (Apple Git-155)

