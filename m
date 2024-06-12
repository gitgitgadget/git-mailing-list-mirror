Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997217837E
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197370; cv=none; b=N3UTrATqBkA4UzlMCW2VK3LIUwTDSQeRkIrKjB41Rm4kaMCsLG+3P0b2VGdE6ntQYUwtRZIMiTb9LBI7GeJgoFKDgGiAJN6LcN1MpJF3wSKboRJBAyr5yJSnddufKoLho5UKW8enWNEWjHN+QZ1H3f9jMukMJdw6aij8ptgeY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197370; c=relaxed/simple;
	bh=Vg8lr4/Bm+hHi8Pl4iOuphqxbznv+5JAh8YSrO08Rjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ydr+yyCdl77+el01NL3HiL7Wc76mv7U0oaWQY7Tq/Qt7RAVcwAyLCsxb5h+hQz+pVLYgubynqDPF8JK5h30zp3JekX0v7XSbeq/AVZRGfld0rr7zSrqYawMayNADp6W0PVcyitwrJOy76dOfMVjQemNEO9xRdCMFzI7Wm5a8Kc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/a9+BBn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/a9+BBn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4a0050b9aso56969555ad.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718197368; x=1718802168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4X3e3Z7MOsPGcx9grwDTf7tmbLprv2+NFWd/pBK21s=;
        b=I/a9+BBnGrwkJRVUq5bRw8Pc9+kivRji/Ikvi+WeYXGpouvzqhK22gh0KUiqYhxchr
         2KL/zghU75ik2nwxh2GxPnaHk0XTsM8A8iFp7ltQ93rJal2OMln3l/ca+41lOxATJxDw
         RJh2sROFnIA48ZXuwVViJbx4FVaANibG7DFCt9DdRdlRuOwnvckrB5MVOT2h0nKYXsEN
         a2t/OJT9liqx8VWF+SYgF0hHQviZJYx1EP+zhfILe30WNpJ2RH3tRMJs6S7HV8XcJtcw
         aFqdwngGqCi1Gt9kfbdsDSfeAR4NPdvS45/W88Fvsx91985HYBsmx42Cn9Y3KmAyHDls
         rAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197368; x=1718802168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4X3e3Z7MOsPGcx9grwDTf7tmbLprv2+NFWd/pBK21s=;
        b=iWleGhkt7HfJd3HRRNamXf3aZhXRPhyXxxAfuG5OY0gNDHx8uKf6uYqjWJrdo1TMSO
         R7e55CPF1dSX1RZ+UwdyOFa8R6QxB7Y/r+I/puRoo5VQlNpc5ZiUowy1qrL5VFBcxiBK
         9oJVbmghTFkpAdXk9Wiic64H251xXvbu5QIdV0OHlz46B8k9KanVNvXtApOTbs42r8to
         vU2LGLSiHSzLOGHGdWU6h0z4h/tgsZJFPPXZe2tKCBxwCbaJ260XiYaNpoI+/eiJYC+t
         dWC7eHEFnlK1rYGKY6IoLYiztWLnNeMP/czTGX+LXSULGN6t5teRKuVnVMiwFawJ8hCW
         g97g==
X-Gm-Message-State: AOJu0YwbNCy+7Yuza05XO7J+dChmbw52d3slmEVI6SKIx6A33JBFQGab
	40g5/gXSurXAlgHJStAQ4D4OFpRw+P0y3e2J9Rb1z/Tx0fbi/tAkKROHgKhuGio=
X-Google-Smtp-Source: AGHT+IHMMMjy2Us7AABHT8J+ZqNJqojT0Q0iE3d81UkFR1CudUiwfI3o53nid+2TzVgnjPGTaHKjsA==
X-Received: by 2002:a17:902:e842:b0:1f7:1e7a:e16f with SMTP id d9443c01a7336-1f83b6ece0amr20597455ad.52.1718197367487;
        Wed, 12 Jun 2024 06:02:47 -0700 (PDT)
Received: from Ubuntu.. ([106.206.196.39])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7fd25fsm123942325ad.280.2024.06.12.06.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:02:47 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/5] reftable: remove unnecessary curly braces in reftable/tree.c
Date: Wed, 12 Jun 2024 18:22:59 +0530
Message-ID: <20240612130217.8877-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240612130217.8877-1-chandrapratap3519@gmail.com>
References: <20240612055031.3607-1-chandrapratap3519@gmail.com>
 <20240612130217.8877-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Documentation/CodingGuidelines, single-line control-flow
statements must omit curly braces (except for some special cases).
Make reftable/tree.c adhere to this guideline.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/tree.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/reftable/tree.c b/reftable/tree.c
index 528f33ae38..5ffb2e0d69 100644
--- a/reftable/tree.c
+++ b/reftable/tree.c
@@ -39,25 +39,20 @@ struct tree_node *tree_search(void *key, struct tree_node **rootp,
 void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
 		void *arg)
 {
-	if (t->left) {
+	if (t->left)
 		infix_walk(t->left, action, arg);
-	}
 	action(arg, t->key);
-	if (t->right) {
+	if (t->right)
 		infix_walk(t->right, action, arg);
-	}
 }
 
 void tree_free(struct tree_node *t)
 {
-	if (!t) {
+	if (!t)
 		return;
-	}
-	if (t->left) {
+	if (t->left)
 		tree_free(t->left);
-	}
-	if (t->right) {
+	if (t->right)
 		tree_free(t->right);
-	}
 	reftable_free(t);
 }
-- 
2.45.2.404.g9eaef5822c

