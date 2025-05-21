Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4284D28F925
	for <git@vger.kernel.org>; Wed, 21 May 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747854853; cv=none; b=dFWXuN5OrvGhhDJxTsD9rSYJfEzrMi2Pmiuq6lY0h/w4I2dtFYXozMA4zSCiq1rFgErMn3Hj8SFHfMTUX0psuSn8orU5b8fihICBStnMKqysmklFWg38OiM0en1X8ygwSvo5U8UDJ3/5G/GJjmxg8jK/wPwy+yOJXut27JUN9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747854853; c=relaxed/simple;
	bh=uH8cw5jUsWEa+TnbVhMXywHFZ4lItTU29zcBe0Bz1uU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fBwvLuswSkImDHzU3EOcN8xhtLvptLd0+IRsVmkBsN7u33Jluiu7F1B3oB4LRnUGqiMdBX18KkR6vM1f8dLsKBeP2QduGtPweCnihlWBUTN8jO8n8ivh2SOCjoCrwSOR1LZRA5eC8/otUCZGN6eOVw51EG9rU4TzcgYpFCa8e/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg2P092R; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg2P092R"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e75668006b9so7459777276.3
        for <git@vger.kernel.org>; Wed, 21 May 2025 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747854850; x=1748459650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVgeawBkBxiwWwcECtHxweMpgHX/Z73IOdtjiGTYpFg=;
        b=Kg2P092RTxl2m+rQspeRSOQ+zFXbrOgCNLoF/FvG1hNvZD0VkWowQ136+Bh75IbY1V
         SIS4kk4l/mjQomyk8tzAshu3LXU9j0mBrYQBL0wTysdZm1SX1pymW7EHnfo6SHNwtH3K
         643pClg8GNDjmi6TI8A9CMTBx2h39j5Xr/Enj6GbZNFEHs5h3WLwrC9Xc92bEVHp61sy
         eiiRwopqmbvx2BiaMT8ohhOrm92DrjnFzP1XSK1pG6qY5OuyizDFS0/SivXsDa4/eEPM
         Anko81ba+1pGf09qi+n6MXguNI2r49L/hS7Eu2RUw9LUQ+G7YQx/shGZHx+Dv9ADt4Ec
         +Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747854850; x=1748459650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVgeawBkBxiwWwcECtHxweMpgHX/Z73IOdtjiGTYpFg=;
        b=szr+XcC1iivhTPI+0yP+7trQHQV7iDEZZlC5NXm8Tssa1U+fQsxFGVUutsVi+bRXSe
         8/lmKPul8S97VjG4k5Tgo+FVNw8D/3USx8AnX9SMx0TAC2kxtb5tE0jSfwmV7+3fnc8k
         2jmeR2pQE+E5d5ALJbqIYRWME0wK18OpoYYjCaNTBB6ylA9Me+mq9I92kyzgMqTLoXaO
         UBeSkt06JhSJHzLFVlRw1r5A4dPhjivEoGvFYMhK8kUymlzaoHYnULY0z+3u7iSFKPhS
         KEB2q3UnHo0doFFkA+QEwis5XjYuiEXaqM0fr3k1iZvAiYOE7gOfKAUZ0a8H022rLPcI
         y0PA==
X-Gm-Message-State: AOJu0Yx3CyBI7afdGQJ6lqz5IzHil7bkxAZU59fDFiSA5XUhGx5h4RDm
	ymT1XNklABs4Po1iTkhsJXiTNZyhmb9zyUg4hz6pz4Enu+fiaJQbujD1GmlwWH2e
X-Gm-Gg: ASbGnct8j6M9aKJCtOrKBY5YTX5rzu0ADeJl70cBPwNlMVvMXtaClxsHM6GFzBTUpje
	ufTom1EAePA8TzcfzNZZ82O5MyksaY6HAd7hUsRTcIIn2hUbQ429QbBD3r6Fk61AzoH4mOhmKOD
	VsMrBF83lLKpfYtnRucH0hMQaCXrLqlFQOzHTSHOA7g9d2iobStm94lEmCUPGmWwzenysVPga8R
	9lD00RYJ12Whb62bhNmBCktqgVhH1rEjauvBgZBkquQUMjFWD7/kqUjcvgzhRjF7AKRp6wraIhR
	Pp+v2BRKzBNN3rFeYbW1z7GkwcNBxnZx7aNaniPsQeFUPGNU9mV8RlMf96jJflmTuwE4aYZPRk0
	zbtfd+fFIojA=
X-Google-Smtp-Source: AGHT+IGv0WJet+Og+RCvLrR1eshsXTOCWHklW3rdXYrEJm71ZcUwR4wjVNbW6mjdlI4tWc9zm83NXA==
X-Received: by 2002:a05:690c:6f85:b0:6f9:e609:6a4b with SMTP id 00721157ae682-70ca7b8a042mr305646907b3.23.1747854850438;
        Wed, 21 May 2025 12:14:10 -0700 (PDT)
Received: from octavuiPC.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca852db6fsm27415007b3.108.2025.05.21.12.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 12:14:10 -0700 (PDT)
From: Octavio Carneiro <ocarneiro1@gmail.com>
To: git@vger.kernel.org
Cc: ocarneiro1@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	newren@gmail.com
Subject: [Newcomer][PATCH] graph.c: change graph_line->width type to int to remove sign-compare warning 
Date: Wed, 21 May 2025 16:13:52 -0300
Message-Id: <20250521191352.30849-1-ocarneiro1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comparison between graph_line->width (of type size_t) and git_graph->width (of type int) causes -Wsign-compare to complain.

Looking at the git_graph struct definition, its size variables are int-typed.

Therefore, I changed the type of graph_line->width to also be a int, thus removing the warning trigger.

Signed-off-by: Octavio Carneiro <ocarneiro1@gmail.com>
---
 graph.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/graph.c b/graph.c
index 26f6fbf000..cb2221700e 100644
--- a/graph.c
+++ b/graph.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "config.h"
@@ -115,7 +113,7 @@ static const char *column_get_color_code(unsigned short color)
 
 struct graph_line {
 	struct strbuf *buf;
-	size_t width;
+	int width;
 };
 
 static inline void graph_line_addch(struct graph_line *line, int c)
-- 
2.34.1

