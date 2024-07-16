Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822F56B8C
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116657; cv=none; b=SXKgFe/2Hhyz6WitR7oMvpPvGZ786V+FkJ3vXRiMz01n0eu0H4kPFQ7J83M3yZ9qA1IsBgVAcL0XAtagrs8FyQZfE6ROZHQapJAXn8LUc0anE1grwwcs0O3TCs9Xqh/wZPlYKY65/92zKDSzESIW/RAjskAjTRRk/yIG/QfLAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116657; c=relaxed/simple;
	bh=IgIIT/Q+92maXWSGW4HNii5lovH69ajT7VA9jl4PXCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usByNM2UODPRPg/XhRq9xeKL4r41tLSQR/ZRaN4yei0RqQZFdh3zSfbH4szQGhvDLb48XDAx+vBrNEyNcfm0ay0nFtNy/HSGQboEVJZCKK1xCmS0iIslUJKO+im6+Gwm0toUHjTsrR/0DBHeggIBqW/9gDkd4TPK+koINiQBRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lbcei8z+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbcei8z+"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7163489149eso3764335a12.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721116655; x=1721721455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6g2kOezj5z15y+8p9idCvMvv+eNDfhCRM2vSzksoOYs=;
        b=Lbcei8z+slpYHUEvuVhHoPooDBFoZx+NgeyyNbRhatp2wB3i07Y4ncPcsqbh3bGIed
         UhUp1FlIuilJGMTMmyrg3+MRovkzLYzJJbx6w5FqVPlSKNB2KWgaq/ZZ5oksNXU9l2zW
         Xa+S2zA8dnR+qx+NFuVg4Nz1s1qlQtpzmGJx2PagIYeqqfqnQBFd3ExzRp831KA71Txp
         rO7iNOL7AlYMhs01D1YJjmzS9pUrQTqjfgQx6KP9OS7nFbHuzUvZbsn1YAvHe2WfZO4Q
         ywd3S/tIBjq1S0WRzTU6SfZl/UAPnYKLi1xEGgIvEXKWrP2Z0pzdrVI8E2Zfekj4nsdl
         jlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721116655; x=1721721455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6g2kOezj5z15y+8p9idCvMvv+eNDfhCRM2vSzksoOYs=;
        b=tEDXfWATsDUGW4Xdxp7nlAqO34WHjGJaQp+5+FE4ztBdKCzrrepSpI+zamVtCMuxyi
         5+pdkRmbDp+oCQ9G3mbIgQMAspzoEeGxgK3uYQhadIX0BNebKD6z4rzl+2Ae4m7Ua+LT
         cicwMN3DxaL/+3tStD+tScDFNc0XQ799buapzBUPEXZN4apkLXjyBqqMSKfw97++IDjt
         N0zL31MyKzEDjQwgd+JDU1VvoFY5i+/FnBQrSpORNI7/3inMvudcPgzvzOggsHbrukeC
         D/d4Qpr2EVreX0W9n0gnCLhCPRaYE5f7hzs1lmCMB41DVuPGtiTeDqu4fvtSwWgN+HDT
         ngrg==
X-Gm-Message-State: AOJu0YwxrhF+CDOMvQVw8NHsk9RJfAheEhm19f8lkh8YRIyqGqR6Gd6W
	IZI3ibt4xiCZ2MleRV349EJtlBFM5++PSilyGghf+CHaUKFtdYyDTk9lox7r
X-Google-Smtp-Source: AGHT+IHGUDaaUGrEE2AXOJAr5ORzGxK3D2+Z12DS4pun5JBMC60w2FgTCNXcTYWOPtmXEtHfuDTkJg==
X-Received: by 2002:a05:6a21:501:b0:1c0:e612:296d with SMTP id adf61e73a8af0-1c3f12b9ef7mr1318077637.54.1721116654837;
        Tue, 16 Jul 2024 00:57:34 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.176])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fc0bc3a599sm53691435ad.232.2024.07.16.00.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:57:34 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 5/5] t-reftable-tree: improve the test for infix_walk()
Date: Tue, 16 Jul 2024 13:18:17 +0530
Message-ID: <20240716075641.4264-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240716075641.4264-1-chandrapratap3519@gmail.com>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup for infix_walk(), the following
properties of an infix traversal of a tree remain untested:
- every node of the tree must be visited
- every node must be visited exactly once
In fact, only the property 'traversal in increasing order' is tested.
Modify test_infix_walk() to check for all the properties above.

This can be achieved by storing the nodes' keys linearly, in a nullified
buffer, as we visit them and then checking the input keys against this
buffer in increasing order. By checking that the element just after
the last input key is 'NULL' in the output buffer, we ensure that
every node is traversed exactly once.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-tree.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index e04e555509..b3d4008e5c 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -15,15 +15,14 @@ static int t_compare(const void *a, const void *b)
 }
 
 struct curry {
-	void *last;
+	void **arr;
+	size_t len;
 };
 
-static void check_increasing(void *arg, void *key)
+static void store(void *arg, void *key)
 {
 	struct curry *c = arg;
-	if (c->last)
-		check_int(t_compare(c->last, key), <, 0);
-	c->last = key;
+	c->arr[c->len++] = key;
 }
 
 static void t_tree_search(void)
@@ -51,15 +50,24 @@ static void t_infix_walk(void)
 {
 	struct tree_node *root = NULL;
 	void *values[11] = { 0 };
-	struct curry c = { 0 };
+	void *out[11] = { 0 };
+	struct curry c = {
+		.arr = (void **) &out,
+	};
 	size_t i = 1;
+	size_t count = 0;
 
 	do {
 		tree_search(values + i, &root, &t_compare, 1);
 		i = (i * 7) % 11;
+		count++;
 	} while (i != 1);
 
-	infix_walk(root, &check_increasing, &c);
+	infix_walk(root, &store, &c);
+	for (i = 1; i < ARRAY_SIZE(values); i++)
+		check_pointer_eq(values + i, out[i - 1]);
+	check(!out[i - 1]);
+	check_int(c.len, ==, count);
 	tree_free(root);
 }
 
-- 
2.45.GIT

