Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10D1C5D76
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039305; cv=none; b=p4mtPSkG01FQvtsiQOppdTxqN1qDpU3q+RxWAzquKpaPkotJ9OSbnfALvL68PmLI0uG/W6NQdrqJYUxoMkFxxWviog6IltqIRuRpgxkzXr7+Ka0T2hz52xqUA7nNylpzNMfwMuZctC3p2yNjHzG7sI9owedaCze15koJWEp3XZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039305; c=relaxed/simple;
	bh=Ps6P/WrstRaN8FR460qL3+xLauO0UyMTgbGEzPfgxKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbX4PO2IfOi4m+2Izjj/hKlgtE4yMKf9Fci7oxZg3pgB6WSZl6b3kBEylJC63UelofbwWdxIjaLwi9xj9mz96G7rcBs0z6zJoNfTfUjXIqtp9dW7mixO/si3ABh6j7hHVbAFvyLoUErTk736T58hIKfXJDfWDTOU6ZtaCyDltCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TySzMEGP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TySzMEGP"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223cc017ef5so16418695ad.0
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 14:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039302; x=1741644102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ISVrHOku3ZEkZ7ArXkjFEEvaS+E2pBP5nUrdbNku/g=;
        b=TySzMEGPwUXg8IiAwWrKC70+OAgXhP6H7R9pknHtpEBK/mpgIsff8WEF72mf/VEM8F
         s72gEKgm+ugyK+rIqwgdmkccod2nP0/ulExN2ULx+a8HaUeBABS+lb+2YD2hBC7/yJaj
         G+QZqA8areLfz+1GVH8DBxa7QMU0FsLJb7IhIqp5WGkgWt5VHLjRcZcHYsDaigwZSDY/
         1EnTTvnZfzzy5k8J4/nagpQqKpo1s7HNONg8CORigvhQTlluitNwuylpLONwv1YmNuo1
         uPx532zzO4qj0gP3PNXOT0pw4DLGdxna4OODqnUlh24zOsHxsCQ0Opy/IeR8LKHTghVb
         NB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039302; x=1741644102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ISVrHOku3ZEkZ7ArXkjFEEvaS+E2pBP5nUrdbNku/g=;
        b=MUUu0CbnwocsGCRyFfccdMYwkcxOOoAYwiZd0Tgar5i43NtPSp5oYo0BjiAop9R6A5
         5IE3oeMbWjdYSud+JpyB51S5+XT4FERKIr3Aq6y5KtLGtBWNfyinRznuTeOYwr81fcpy
         UrpJ/mWzAa1XSM/ZvX/FDg9PmsewurjgtfLLBs6Hd1+0aljzKU3I/X9SwQgBKhKKiJry
         eLO+kKyM+/bw3rdK9OdFw9YhioDz+78gX7pcvP6iVE/MM/8tqRZ+3S+T+rtNk2BVtnbU
         Rrz+kWkaAqVXlYx+8HfOuIr05X31XEHzNGkH2Fxshr+ds95JH90aBwJih8GwUH+n7Fp5
         7yfA==
X-Gm-Message-State: AOJu0YzvXC3Hyw3kbiADw7h89sAqGoTAUhrCA5BE8KikAsaFNAXnCayv
	ObQcU6cVJFG2s8rGO6i96Qh3meK8V/mfLA6tiP8OSE9r5wA6FbTeGuPbjg==
X-Gm-Gg: ASbGnctQXyK6s09Q9Zw+tJ6JzrFjUSSUCmsotUQtLaxRr02D+TR38XuExmXr9dEIpK0
	Gjc4Aea0wMsv7RJNpKnnFYXqOaEFzdgZaKR6wtgeWGOWtj1P8YYTp5AWntPGzJbXqrszmrEcU4Y
	DHVhyBZtSQYIJbS1zqRUUN7xRmyzVJFrY4DWwU18Q2vA5Ltfc8ZLQ+UfGg2kFGYuoHEBS3OsSG8
	yrDlN2XQSB+ngusOu9JnfgW18slqmMc/aZNXYEQy9VsQv+emYcOlijSNK5huPb6/C1Oxpc2z+HJ
	ajEmNrFAodyTWUNNyf2+NZEBoqqzIu2HqEvEpsJMaO2UeFZAkYU06iQiRlOREApfUo+7BDjA2Ob
	O2MCvEnBR1w==
X-Google-Smtp-Source: AGHT+IEkLgNrf/5M6fiHkUzNiOJIirNlLy4X43lVMPc3DMlq4iB23h5uH0kEXcDlHFWRzmndQFPwMw==
X-Received: by 2002:a17:902:e5c7:b0:21f:4c65:6290 with SMTP id d9443c01a7336-22368fa5545mr244213915ad.1.1741039302415;
        Mon, 03 Mar 2025 14:01:42 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:283:5dd5:8e9e:2c56:864a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc7e1sm82746565ad.176.2025.03.03.14.01.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Mar 2025 14:01:42 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC][RFC PATCH 3/6] revision: add subject_extra_field to struct rev_info
Date: Mon,  3 Mar 2025 19:00:26 -0300
Message-Id: <20250303220029.10716-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the `struct rev_info` is responsible for holding information
about the prefix that is added at the beginning of the subject when
`format-patch` is called. This way, it makes sense that it also holds
the information of the extra prefix, if it is present.

Add a new field called `subject_extra_field` to `struct rev_info` and
use NULL as its default value.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 revision.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/revision.h b/revision.h
index 71e984c452..70927ef1fb 100644
--- a/revision.h
+++ b/revision.h
@@ -294,6 +294,7 @@ struct rev_info {
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
+	const char	*subject_extra_prefix;
 	int		patch_name_max;
 	int		no_inline;
 	int		show_log_size;
@@ -413,6 +414,7 @@ struct rev_info {
 	.expand_tabs_in_log = -1, \
 	.commit_format = CMIT_FMT_DEFAULT, \
 	.expand_tabs_in_log_default = 8, \
+        .subject_extra_prefix = NULL, \
 }
 
 /**
-- 
2.39.5 (Apple Git-154)

