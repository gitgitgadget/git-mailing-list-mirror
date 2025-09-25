Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24E2ECD32
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842979; cv=none; b=JwT9xoqJtAQkROnQLTQLjbdSugjAi+qeCCXNnanyjm5yTG/WeGERtn/PPJ/3XK6x3zgFn/MEKCUlntqCMZwRNIlVtbQLXan7oF1GP0eCju8qc/nXgOnmYVBaEbZbTwDY6v6YVlJLZmE/A+oUL98LPk1xB7Ej7v7Cv1WfAf6XjHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842979; c=relaxed/simple;
	bh=/1SnD3WYBHp1TwPoq1VIuriILgy4qstGvpGLP8cKBOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzoQQLez//OAUVzvo1LlXJkjhNVddPQVQgEPMXy2qDk5WdpMLRctmLMHp6H7aPdhlVMLsvdNg0vgWqv4tP91eTJLlqbCzo6zG80b9uqVbPfUiCUaiRT+2leKy9M0C3zFbpelwjXPQoYdlru77Ng9cj40uKhKRw/wVQP8nlhpi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OricjEOF; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OricjEOF"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-79d36a6298dso648486a34.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842977; x=1759447777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY2YdpRXIoSdDtOeSL1Fzj0grP/ivSC2SYohVHa3Vss=;
        b=OricjEOFUCKiOfDsOaKEtXx157gMO916vxpV+qkOO6nNqn+egruSPo/bnBdjfHQSoI
         K8DwwXryzCossi7eKf7cMzQfQU1mzEnXvAHn17zcTpOPMJGBmOIxFhdCITxf3XrWn80T
         fhSlxjaFGYs3qwBYYpz+Ivf2SGW8k/GI4d7wNXnEN/2cdNowlFHMgmYkoxyhdbvwBIX6
         xOdQS641ozvmxAwXhnqTRBV0/Py19wfUEDm5wiwtR0GOo2luw7kXtHND+Tg9c7UfKD6o
         lMMiu1XTRYyGJbnfpOVsdebLvhOBfCyAgynk8mw+VjpetlqUl8NuT5tDqAQcrpdMj3Lj
         wHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842977; x=1759447777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY2YdpRXIoSdDtOeSL1Fzj0grP/ivSC2SYohVHa3Vss=;
        b=OedhH6cCWgCfs5zxOTP615OU7iI3DORnr5bLcXh+Nn6jXzeIUw9iW9kX2wG2AP54F/
         PobwZz4sQnU9OhAkLKiPbPBmRNIGDrsaLZ5KAECMtLpYgD/DxJ5p1qricjQHVn6YWd9S
         gbjz2OV9G6WPhhl61XB38HgpycYlojt21X/4tbNLuoIQjSm32P8M+szaoNWs3a7UNXZH
         vHxGFPTo8j404q3BbmMORdjP/dAdWsMYowI/ZEjbZPFrhYdlCs62P6Tq91TrvUF0eIMJ
         UBgQBTA77Ns8McKEbE1jf4VbuUPeYWwjq3c+QrBABndtz5GED0PDJ3OCwUZt2iJ6sfZa
         ZkFA==
X-Gm-Message-State: AOJu0Yw5DzuZmrAyVJOK+B2KZHJfDtyZ6dyo3hF5CEtf3hNncana1GZg
	H2ivxBodzMYRHx7js77+uct1DZjg8iN70LXFFxC+Ml8Fx2QnmgxkKY8NQmuPJA==
X-Gm-Gg: ASbGncvaU1BCxDHDYUHKRPJ3DrLqqc4psV6oAAkCnNFSudGeCtelkf0Hu6Qpe9ADkrY
	eq1ex4+ST2wHb7IfSX4q9TBo7ppjBqXTVarzmXOxGbgL9bgMiUQWEBOZJTzn5Kiwh/RmyIXenS8
	qI1RkWsNAWktJiOXjaSkqDAHd2QLYzKcLMjcpIM0nspVv9sxQ9CPFLs0VTCEPdY/Pii9+r2bbJQ
	mNxTnEsJCh04mJVgSpWiQWI9PgoGMyqbFodVL/CmZTSMB8M81RfTPaHlX+SqwlaEbfZJZun4aeU
	tYtRNanM19FPd9+gJNSJUmo/uMhhR5rmfsF/TdENkToSWqkaOMNs0KZSYQCOOWjnTsnwUrKbKnL
	qzOF0nbo4StEvIQDokC3RyrhFdbVejBYk96Spt2XaVA==
X-Google-Smtp-Source: AGHT+IF/PL/wyIX/6LDiGef4ltx/Tk/yOaNNu8gtmpueI2zSUVkNu/+DeG0lcKJ/pgD6TQ9/rfhcaQ==
X-Received: by 2002:a05:6830:6996:b0:746:d861:a1f1 with SMTP id 46e09a7af769-7a04a2fc0f7mr2533780a34.22.1758842976474;
        Thu, 25 Sep 2025 16:29:36 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7a2402e5d70sm674273a34.36.2025.09.25.16.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:29:36 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/7] ref-filter: allow NULL filter pattern
Date: Thu, 25 Sep 2025 18:29:23 -0500
Message-ID: <20250925232928.3846-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250925232928.3846-1-jltobler@gmail.com>
References: <20250924212426.2930029-1-jltobler@gmail.com>
 <20250925232928.3846-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up `struct ref_filter` for filter_refs(), the
`name_patterns` field must point to an array of pattern strings even if
no patterns are required. To improve this interface, treat a NULL
`name_patterns` field the same as when it points to an empty array.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 ref-filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 520d2539c9..2cb5a166d6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2664,7 +2664,7 @@ static int match_name_as_path(const char **pattern, const char *refname,
 /* Return 1 if the refname matches one of the patterns, otherwise 0. */
 static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 {
-	if (!*filter->name_patterns)
+	if (!filter->name_patterns || !*filter->name_patterns)
 		return 1; /* No pattern always matches */
 	if (filter->match_as_path)
 		return match_name_as_path(filter->name_patterns, refname,
@@ -2751,7 +2751,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
 
-	if (!filter->name_patterns[0]) {
+	if (!filter->name_patterns || !filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
 		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
-- 
2.51.0.193.g4975ec3473b

