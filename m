Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C181EF391
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404829; cv=none; b=hpJGRwZwxu4EiN/zkuniNO4Jg4Q1SyAnTs6CJlYXQ+mond6er2A5l82EmaD6zZfkW03GFDIGcA0jV6XGv8fJQONHXnnhjxTq8p3sU1j4e1TAxnJKg40/jWRMvF3yIPs6J56vGyhWklyD6OmrPEBeBt0zzhjvEs5MOVYOv0vQg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404829; c=relaxed/simple;
	bh=R7LzlCq4tWcsN/TCwybpDmz35fg/1rQWxc+WV3UMuE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n0s9Es+zJomqjukbwWdrlO6Y2P6THCGklQsuwDEpiWuECkygDNRePdo+bEb0wUjkj7xN1gYoD6RShkD2kPryjjC4XWQ/YKfjlC7GRc6UvAW/8SmDwK7Ox3hZZZ5YWHiqG4dOYdeAifsZcr2fUwdDe5JHUkSvlFMA8pYS3wEgqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+WDLZyX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+WDLZyX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224019ad9edso31533715ad.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742404826; x=1743009626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G5xOgvlvaICiEt5D5nECPnfHAK3kaAj0OSuIm0iz+c=;
        b=W+WDLZyXW39YFG8aiYdHbAnOaUKshUsu5jOqrBbFqCC4lk8pWsvL6ONdxUkqnndxuW
         JtOsOydig0iJ6WHyT07C5Vk4APzHiSjfNNHygxjcwF/jyMcsXH6zaxmp/ETPUvIN7/+P
         EBaFt4mdQqDcQNcWkEfrPeJOoRuDMCVISrL1bA54C7MSNuZf4hY0mNDBXzkmnX7fn3b2
         dirJih1tmQsEOFdMNQ981RwkiUn7ON1fsOpwrXYD19MJ0sYTyrgO4oCB3QRG6oNLqF1v
         6dFQKblZ2mqrMjkNArWO8aqTsRrEn2rk7HV73fZkhuJ5lcim/YQkvaJKYf8dKZzgF+Yz
         TKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404826; x=1743009626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G5xOgvlvaICiEt5D5nECPnfHAK3kaAj0OSuIm0iz+c=;
        b=kl642aaNpxVssnMpLAQJys8u4oR0j9WzJJ0qkjAcKZaQPNLqaWAFU7/InIi/ED67Ho
         5Q79FIJq6ntQSyItqCJrF3VJXlF8xxWGI9CUefgYrBqa2ZJbgweU1m32Y2J2W7H3KbAK
         tiCIro9HNCVrqiqpgdiCxQYvDVpPRc5ToXNvSnKhf/IfQtCdenJMKn3UZgDudOvZHJTy
         wJ+xHUoFlw3OwnR9sMgQ6v2OdFrBEtq/tQjLP/W1no5RsLkNtUe9cp+UMiAsbOWjp4V0
         wmMAamEDO/jRIuRmALC+b35pe7WR2pM/Ds1j3nUjTZfhFsYjX8qA2xWZdVxGkbhsS63Q
         hwNg==
X-Gm-Message-State: AOJu0Yy0xBk4vON2nIWjn+RiXgZVhEda+XjW218ROmMc/yWeIPHytsV5
	AnEkVQuaJaj/Gng58b4OisZySybsbx5S3+03EItOUex2D8SU/UVlNVvf4Q==
X-Gm-Gg: ASbGncuEet8CV7WjH9mep1oLgEDL9SA7kZyl9SCHCMujqgVroAEpKwz817IRH/gNN2B
	0r+uqa40YXpH07KsUQDpwkzG+7MJh+5XW5aZpzvZOuKd5VU20YY34CRA+ROlxFY6i/gDsdN4og4
	EnI05fPTXS7eVHN56HbHGNu1LB/LiF/HNDg3CwgGu0L5E4/rt8Iulx8g248uODCdtG6riF8XWV2
	PZ4kcCMdRSCJ79fpDT4WStY2hitGHXm/H3GrApuiNCS4dZ+RCQaY1uGbuio4mgDy2iTfjlTXrhr
	Spp2xDSUaRbhu1772owJA6XHRzgUkP3FEryiG6OywUBUKAsEcqZD8AsgwzPbHzXa76sfTjdgilU
	=
X-Google-Smtp-Source: AGHT+IFN+ENwHb+O967xc92hokf1tEuc/ymjaX+KwJDECLmo0OxgELSzeynnO8wzA5bW60qCm4/YOw==
X-Received: by 2002:a17:903:2301:b0:224:76f:9e44 with SMTP id d9443c01a7336-22649828e20mr41508795ad.8.1742404826373;
        Wed, 19 Mar 2025 10:20:26 -0700 (PDT)
Received: from localhost.localdomain ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd3c59sm117240305ad.218.2025.03.19.10.20.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 10:20:25 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH 1/2] userdiff: add builtin driver for gitconfig syntax
Date: Wed, 19 Mar 2025 14:20:15 -0300
Message-Id: <20250319172016.2115-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250319172016.2115-1-lucasseikioshiro@gmail.com>
References: <20250319172016.2115-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From Documentation/config.adoc:

"""
The file consists of sections and variables. A section begins with
the name of the section in square brackets and continues until the next
section begins. Section names are case-insensitive. Only alphanumeric
characters, `-` and `.` are allowed in section names. Each variable
must belong to some section, which means that there must be a section
header before the first setting of a variable.

[...]

Subsection names are case sensitive and can contain any characters except
newline and the null byte.

The variable names are case-insensitive, allow only alphanumeric characters
and `-`, and must start with an alphabetic character.
"""

Then, add a new builtin driver for gitconfig files, where:

- the funcname regular expression matches sections and subsections,
  i. e. the pattern [SECTION] or [SECTION "SUBSECTION"], where the
  section is composed by alphanumeric numbers, `-` and `.`, and
  subsection names may be composed by any characters;

- word_regex is more permissive, matching any word with one or more
  non-whitespace characters.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 userdiff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index 340c4eb4f7..5bbcc2b690 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -198,6 +198,10 @@ IPATTERN("fountain",
 	 "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
 	 /* -- */
 	 "[^ \t-]+"),
+PATTERNS("gitconfig",
+         "^\\[[a-zA-Z0-9]+\\]|\\[[a-zA-Z0-9]+[ \t]+\".+\"\\]$",
+         /* -- */
+         "[^ \t]+"),
 PATTERNS("golang",
 	 /* Functions */
 	 "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
-- 
2.39.5 (Apple Git-154)

