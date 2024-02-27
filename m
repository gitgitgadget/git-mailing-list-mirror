Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EA8148308
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046603; cv=none; b=Imx5dApPP4zBVk3Px3mJZzclI+IyWrQHoguEKUc5R/bJIjzsl09G0QrB3rYGkRB/Fi/qPEHWZuH2s5z6QppH3Hpx4QrjaH2xYijPWfX5VUY4eCpS0IUSrEo7fHMMgTcBfoi+30+amdLro+vcst8nK7qsNc/jvXrY5dkSTv5JjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046603; c=relaxed/simple;
	bh=Mje2hWwfPchtJSad1nkosPCApdna/QPnT43z3Z4CJxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9Tm6G65CWxQbDM1JlK4bZMZqKcAdbRYcSXp6MToZ08mm+f2Mqzrp0T/sKQD+m8fLiQwxDEUckMoosl1VmjrGM+bqw3VHWyUtMdYS/J5MJqteYBZIt0i5CQ5yLHxa2YuRkXsQhBZCbdzTVv0uIdFMAcrJiRetutZku46MO+YQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUc4gwvI; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUc4gwvI"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e848fc6f6so15577341cf.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 07:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046600; x=1709651400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbYEKOjMd0n/174MA33Qo13M6pFhrlNqbXxEHbUQe2A=;
        b=MUc4gwvILOEgwB2p3vnBFwWpC90yo526x2xHTqm+WQec7qSOcGEGMz9nMq9SI8lEve
         ShqzSSX0+tKjpCrqlUkqaR7HviyB8AHTf0d/+0HxuVJe8jtDRnFyPBcLs4eWSK/CEaki
         1jgqknb0cju1q2oN1yuLlwlk8Bk3L/KxoXVu43Cs11/jnQZKKXcLxh2KR2EL+lPFZEKL
         3syIDrpq3VJZCnazr/fKHcrZXsqZhbqGDEUzhJiXlW8Mt8B2zsBHO+0ygxDqXBnEKmQ5
         HgDIfsIVS77H0hMvvewJG1h+JIDfgHIe+pPspXtLHQOliW+QnPCKPefuTNHb7ksG0I3M
         m5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046600; x=1709651400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbYEKOjMd0n/174MA33Qo13M6pFhrlNqbXxEHbUQe2A=;
        b=XegxvqWo/GyAZ/n6tvVkQAyMyfNEcOG/epdryZf6O/WDKESGdYNQRVkXkewu18iY/E
         A5hUbLTDIeA4La3WB7NaWRCliseV1ePD9WCSRqGNKNwjMn5WGYnUKLjFOQ4eH1nTrU+J
         p6JhrQwfb6/tYGnOaX/DQ2A9Pj+FacdNPxVBYiavFWJ4mLjvCgfkcDTSPmbgbafSBnhd
         froXRMH9Mo/GY8H7xQfFBV0ZQBEWVjVRX8y3k8s/1Rm4ScSw7UWwpQJpG2SZrb1rPPLo
         /0W5KSJ/Vi42b6ghy0J0691RtTrWTSpPkJ6eUZSJIZREvAiGnf1raB3rLk5xHnfx3br9
         CfPA==
X-Gm-Message-State: AOJu0Yy0EwZ5j86IYwls8YOW55dO/UF3pLs62lp8stfv/cLLQoihRclv
	g7PvdQaiOVrVi9q/ujzRxpi0OZL3Y5SyvnfBniP0DMVQrmGsT38Tl7Vc8NOZ
X-Google-Smtp-Source: AGHT+IH0JHNlPIaid8HoJ0+IMtNYHazsb/cCuKjyf5YP2hgPo3fR755c61OXFO9+t4ggk3Ll9VjNag==
X-Received: by 2002:a05:622a:cb:b0:42e:a69f:aa9f with SMTP id p11-20020a05622a00cb00b0042ea69faa9fmr492125qtw.65.1709046600484;
        Tue, 27 Feb 2024 07:10:00 -0800 (PST)
Received: from localhost.localdomain ([2607:fea8:3fa9:4200:ad2d:24a1:4eaf:e903])
        by smtp.gmail.com with ESMTPSA id t19-20020a05622a181300b0042e56fb8e0bsm3618149qtc.93.2024.02.27.07.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:10:00 -0800 (PST)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 3/3] builtin/unpack-objects.c: change xwrite to write_in_full avoid truncation.
Date: Tue, 27 Feb 2024 10:09:34 -0500
Message-ID: <20240227150934.7950-4-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240227150934.7950-1-randall.becker@nexbridge.ca>
References: <20240227150934.7950-1-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This change is required because some platforms do not support file writes of
arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
maximum single I/O size possible for the destination device if the supplied
len value exceeds the supported value. Replacing xwrite with write_in_full
corrects this problem. Future optimisations could remove the loop in favour
of just calling write_in_full.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 builtin/unpack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e0a701f2b3..6935c4574e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -680,7 +680,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 
 	/* Write the last part of the buffer to stdout */
 	while (len) {
-		int ret = xwrite(1, buffer + offset, len);
+		int ret = write_in_full(1, buffer + offset, len);
 		if (ret <= 0)
 			break;
 		len -= ret;
-- 
2.42.1

