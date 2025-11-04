Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948328BAAC
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250835; cv=none; b=SbskdKPPdTm2W0SyeNNvykMFNjgb/wjbYZu+RRw/nSELID/0Df0ObqyePSZYBhiao1rfTn+fPzgru0dl7O9o3nCHW6cAu2GVWkLGcq4v4OQLbQM0yXQhXf56MqOFtiZI0H8HWcicc0bACguMGdZxF72QsYf6XmMSDZELPM1ViBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250835; c=relaxed/simple;
	bh=l5EMKbUE24w/LbOAjsM/8s7EsexfZQRKOb65Vw0RSm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RAcfIYTPvgoycGtFmTDJS1TOjxcKCiaRH2koM2f4qYnIXLR2dSKS5hxjlFqJPmI0QS4cIrdj1Oy97gghp22ZK7rWA518IOjVmZH+2azyPUMvu+Urc8D+x3hoc5uR+Co3iwOCX4EjBQbceevtyUvYlHE75msaxIr52YQBAcphC7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K820B2KH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K820B2KH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475dae5d473so3887515e9.2
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 02:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762250829; x=1762855629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BgiQLjtiixDN1An9s718M0nBAgwO5GRoZxY0oYm72yk=;
        b=K820B2KHGHx/+IGvwSughbeUc87gw/gLpwMQohQs50/cX62x0n8HFinw0t0ABv+xuj
         BW8Cqyv6UpCvULHnOS5MMgbpVofJGHtDawYTratamaB05vTnNnsm3ULJJYLtPhimdFbB
         ameUf4hxdQxJtInB8s91gn/kK/prQ9XS8MsUp1Coh/iKzcCNZ2pmnK70ORCW4DwpmwOd
         XL6ZGu0Mr5tNZZXtfQEvI1qALggBsnv9mySWCvg6ThpPwwHrBXDWl/U+Cr/gWd0jfSVU
         P4uQGbzmFmPZK/5kEkVXBlJkJKOHES3WnzqX0+KHo0AAqV1zeS2hTsqDIPG/4T4WPS70
         CCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250829; x=1762855629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgiQLjtiixDN1An9s718M0nBAgwO5GRoZxY0oYm72yk=;
        b=j5zCzKkEBcccjg9xbyOziPnoAciSzzhaRoZnwpK1ajfdtFopJ2xwEFVvDxXrYPgYTL
         pA+t0TPJQDFPRrtnduB/3S7bcIgWuOnjKk+H7ZJawQfvJC6vg+//CPVZszuuC9dCQPvL
         RZgMbdKaeeDcMtidEA70jNAxBQL4BxEjWjMdLpHIvzTaafdun3fgLSX+2Jz9TEyQWoHB
         UOZ5kf8efWIEXOvXvoTWu17MrQsJbezdKYPkJWsjJTYjx2qEOil/nhPx7X6u39kfRQLx
         iMVSFe/xERWjtCHxuvg/cqL+UciBdYnYDyK/ZDAGu7MOBgSW5wm7MR40jgKE7Q5ygQBt
         fpcQ==
X-Gm-Message-State: AOJu0YyKHgr3WIl4KS5aNz/JlOfuFisfHiVDCUU1gZ+dulyhVDYgiBFz
	zY75cUN2B7NyFgJqkmCM1JomFR0VKT4HTd9xhcdRUxyV6NGIr1oqse3LOrSND8cp
X-Gm-Gg: ASbGnctrt3KXuKwCveask7AS3TAQkMcVNA/2X/+Z05eARxvAwQgrimY/D3VQ2ursfYy
	I2U7ORF3mdjGRhJdtBKknEcoIWmQ2zTGtXUtDirabAHNOOIbB1bC5rV8df4zl9rOg5snt7We3RI
	+QIUmgbJlxhY92op5l0x9xoWkp5R+vpq2YTHdNh9KKgsdyFoD/Eh8dyS6wVgvo7OpFBhQO4fzbQ
	vlMw9PoBGCK4fLYpqZnieVYBJzA6Mjnuw5txrJTtvWi8jyCpJe70FlCkIihmzisrgelVTS6tZok
	VvvDgMklX1yYYlV/dGUdbZ7nBXj8tsVOSTju2BBPTxRndVaa8Z+P5QBOSs5PRly875VHRBKftFZ
	aAhdaAUhSBuhfjHFxy87lKgGlKZFRnGb9+QvMRJvhxAxFOCfcfE7rXcV1rPJ1+x1worx6KzLG62
	HsmVwJXZZQJ6ZK3oc=
X-Google-Smtp-Source: AGHT+IHk2XhMr/uWcsuUoVjxrc0EZtYU2A+4FTr9CSvIV5xaOpKsRpurJ60q9aXHy6DBeyWFVBUChg==
X-Received: by 2002:a05:600c:3511:b0:477:a9e:859b with SMTP id 5b1f17b1804b1-4773089c496mr133196305e9.24.1762250828233;
        Tue, 04 Nov 2025 02:07:08 -0800 (PST)
Received: from QueenJ-PC ([105.113.64.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558b88f2sm13841735e9.2.2025.11.04.02.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:07:07 -0800 (PST)
From: Queen Ediri Jessa <qjessa662@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usman.akinyemi@outlook.com,
	QueenJcloud <qjessa662@gmail.com>
Subject: [PATCH v2] doc: clarify server behavior for invalid 'want' lines in HTTP protocol
Date: Tue,  4 Nov 2025 11:06:53 +0100
Message-ID: <20251104100653.2152-1-qjessa662@gmail.com>
X-Mailer: git-send-email 2.51.0.573.gb660e2dcb9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: QueenJcloud <qjessa662@gmail.com>


From: Queen Ediri Jessa <qjessa662@gmail.com>


Update the documentation to clearly describe how the server responds when a
client sends an invalid or malformed `want` line during the HTTP protocol
exchange. This improves understanding of Git’s behavior when handling
incorrect object requests and helps developers detect and handle such
protocol issues accurately.

Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>

Changes since v1:
- Rephrased the explanation to be more concise and aligned with reviewer
  feedback.
- Clarified that the server includes the offending object name in its error
  message.
- Adjusted tone to describe the expected behavior rather than prescribing
  implementation-specific messages.
- Improved readability and technical consistency of the section.
---
 Documentation/gitprotocol-http.adoc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitprotocol-http.adoc b/Documentation/gitprotocol-http.adoc
index d024010414..f3f48d3f35 100644
--- a/Documentation/gitprotocol-http.adoc
+++ b/Documentation/gitprotocol-http.adoc
@@ -443,7 +443,10 @@ If no "want" objects are received, send an error:
 TODO: Define error if no "want" lines are requested.
 
 If any "want" object is not reachable, send an error:
-TODO: Define error if an invalid "want" is requested.
+When a Git server receives an invalid or malformed `want` line, it
+responds with an error message that includes the offending object name.
+This clarifies the expected behavior for Git implementations and helps
+clients detect protocol issues accurately during fetch operations.
 
 Create an empty list, `s_common`.
 
-- 
2.51.0.573.gb660e2dcb9

