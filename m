Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0155885
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722780707; cv=none; b=Dk+Bm9q303+l7FEUY2nBY46VRkaK7Hlidq0o3vR6GelFWshsspXWrsay0GlKsc9Kmqo7vENQpOC8WEgyEgHnr9SHlp0T/S2w1CDXM33KDLiztEK7TnCoNpuHV6MjG1Fumy5Yopj9JjP787ByeSidoFeEluMwMwXmuZmhaJpv13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722780707; c=relaxed/simple;
	bh=SDgoGoMHoqxXAnjiVK1r06rkyxLRua6etfW6MLTBRvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHRL7RYVqYQMreJoS5j4B3ROWOAuVnl1aBKiJIMzGYAoSKgLYndFkGUnjvUpe5es6Qttrie0Swtf0lkJ53m8myNuYzFLgR/EkHxOwHpMCEurHyYjcCkv8Hi5AY3ckcd8Oe8DvYlitnr1KIOD2O4FiDFY7Vhattq93NH9n4IvXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIKu4D+e; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIKu4D+e"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5ed6f51cfso4591244eaf.0
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722780704; x=1723385504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91UFm9QvBZlzVtdOiVwXWHHk/jsOEphDU/vi/gSo+Jc=;
        b=BIKu4D+ei56XI0LcLRNjnHbln/7/qpGkFJdnxENrHe1biYBTjpffrGQCg5Gt+t7eh2
         AfJUyGfaKmqU8BQkdTt/dZQF6AtAwoY6IX+Q+bM+2ixAnGtjU9eXrtn9/GHdq1+WDTcL
         YUNkgreHWASlY9IZASckA6TIcVHxksMQFsL+sy9MbLHpEw6oxbG3WvLNKxHBzVZYdGVi
         W63Xtt5fedVTN6eCEQN8gFlxSxINIxjQzpYajrld/9kEwP4CoBy3AjQh+nHw04j+u/XN
         KgnZJ4MlFZoGIIi1+daeBz4SxjcHNLjhaZKWiPSpEh3uqyS8OPs5A2H/xUcS4X6HGHQm
         /ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722780704; x=1723385504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91UFm9QvBZlzVtdOiVwXWHHk/jsOEphDU/vi/gSo+Jc=;
        b=rd+zen4ARSPhaaGlBMQsSL9urrF4dTKzYwGY7eAJeIrtlv8OiYFHGF6JTUtxkxo24j
         sZS0e/cnYYBcbtUT997BP4nfAr9gCsjfyaiT/mfwYvmoboqrdXWXo7u5oUSJcEWxqn3s
         lNaysv4mTXFyut5HZz6xCww/xOSBmbxb5JjY+bAEifbaHs7lcZpQN6WFuyH6NxaMbXLe
         DeHIFer1HWq0gQLSOVowkTmEmbaP3omRxan3TXnWp7ghKvuCXnpuYMI/RRSFZm9FTwMb
         x/WvxAlLIpe+2Vcvm5mucwqn89ns72GDTzdFByhl4FYvo+RwNhtIxoXAw0qxckFHeDLw
         devw==
X-Gm-Message-State: AOJu0Yy6qsfTXmQ7Y7vuNeQVqHnK9b4U9teW146ODju8TK1K8VUHzFgR
	PjQcszxeM2KIzpCGccBORxNAo2//898Nu9j9YW5T1qDks1qOJk8vIaNl/pEe
X-Google-Smtp-Source: AGHT+IEFCPnETHiVyYo1xjnvnwa3cXoTzOJJvyOV/o1wsl5N7tjwSwgm7tI8UnJMhfeG+BN1JcU5/g==
X-Received: by 2002:a05:6870:214:b0:25e:7a1:ea8f with SMTP id 586e51a60fabf-26891ee21d2mr11351519fac.47.1722780704404;
        Sun, 04 Aug 2024 07:11:44 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.183])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec269d2sm4125047b3a.17.2024.08.04.07.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 07:11:43 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 5/5] t-reftable-tree: improve the test for infix_walk()
Date: Sun,  4 Aug 2024 19:36:49 +0530
Message-ID: <20240804141105.4268-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240804141105.4268-1-chandrapratap3519@gmail.com>
References: <20240802121318.4583-1-chandrapratap3519@gmail.com>
 <20240804141105.4268-1-chandrapratap3519@gmail.com>
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
index 2220414a18..e7d774d774 100644
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
@@ -55,15 +54,24 @@ static void t_infix_walk(void)
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
 		tree_search(&values[i], &root, t_compare, 1);
 		i = (i * 7) % 11;
+		count++;
 	} while (i != 1);
 
-	infix_walk(root, &check_increasing, &c);
+	infix_walk(root, &store, &c);
+	for (i = 1; i < ARRAY_SIZE(values); i++)
+		check_pointer_eq(&values[i], out[i - 1]);
+	check(!out[i - 1]);
+	check_int(c.len, ==, count);
 	tree_free(root);
 }
 
-- 
2.45.GIT

