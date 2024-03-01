Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372B64B
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252093; cv=none; b=IDOTDV3xpVYLfsb7AzYpnhBDcK32cdXQZyXFTOJNELixMyhwDtOUfqXD3jTt4maRcqeIZcF2TKd7pv7taS6SlHOulRk1Ok9eFrbbinjddEeQMLl9gw6+HiIymrl39yc+WQa7kmqLcIgAj1fS2Gx1noq5jbOBwhPEEJhR7mxMhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252093; c=relaxed/simple;
	bh=drUD39xUc8WM+utEVxXTiU0Dg0IS66wVnv7Mt5VGK2A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QOaKYrlvh0c5k4gbMh9lvQq3sqRgjaly3Jo0DjeqXSqJs6/xPnj3DZqInmK/ZMtf7y0kxHVMtkzs+ALvRRSEFTcSi3aAlkThiceFgqd+0oBOluNUmgvATyBPCqaV3d9tMSv4Wmj6DkCpnGy3nWhBi2yLow3NZ+eGT64g3lIvUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMc0fcFa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMc0fcFa"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d61e39912so733699f8f.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252089; x=1709856889; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duyinlY0QkJJiADy/N5wKycwy0BLJrkHINGYsEMmQcA=;
        b=YMc0fcFa+Q8g5ZKvib+rx7g2oqHStJJEdgIbZfsARqRfOWZZBo8//ltQuSGxnu+2g8
         FS1EER8ucaYQxD25ltrkaGh4cyCtsyawpVCw6Nn4idYvIiHpnaFONE1YJMKdmdd0GzZ0
         +Gp8gA6/9bjeCTReMwPvSocxV5a4G/KnhbHNjT1PItq0eugm5l7AHWR6RYnSAIXTC0bY
         cAeCKOoLxKsk8lVw8PkTNaGfp41CmmQHthIMHV1U9JsZJNdNisgMi+krQYqWvGZNWQeC
         sCOiN37wq/nioEnCIk5fAK310+Iw2EOdqEbQDoXyBoS88G+VGsupmCdDbQphnJSDiYxQ
         SE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252089; x=1709856889;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duyinlY0QkJJiADy/N5wKycwy0BLJrkHINGYsEMmQcA=;
        b=lRNjcM+L0OdHSs6EIhGoRo2HKzo0RwpsvUpCC9DZ4tG9ZLWFO5cFBeSSepIzAu58/C
         htijGwRycsnr6DaZI1x0Kyqpq1FRTayyux7GxcZu6bdCMB6D9sVI4dQyBwgXu9q5nCEn
         7JtRPK+PdhGnpRDfdzQOCS8n63I57b2w/otAiC4UZy9npkbQro05Ygbmlo8I6+fCeK3u
         pCy04aKIS1t/XF7UEzAetrcebj6o/le4a+TzL/QR7SAe+/aIJXUFUxjr4ZHiv8Xz4YZU
         obMFf9AEDa0rlE77uXioOsyKLipmXnPnzOL+mPVn3EgPa6GK2TzZDmjt3JqJX+b6uLtQ
         rL9A==
X-Gm-Message-State: AOJu0YwTC9fgYfUKxQEw49d32X0Gfx/kM6wLcM4qb2BKCSVr6EwtG4z6
	bo/UED+SabDiP+TJ90Bo6Yb5hVo1HG3cgxgxIW/ST0qoua+HvJItBIEiv80N
X-Google-Smtp-Source: AGHT+IGSbqXB5Kx2WvpT4yL98u1nVkzlTem2mh8UiQKVa+RaRJZTJYVbCw9h4St0DDdWM1ckA/n6OA==
X-Received: by 2002:a05:6000:1110:b0:33d:754c:86cf with SMTP id z16-20020a056000111000b0033d754c86cfmr90019wrw.35.1709252089093;
        Thu, 29 Feb 2024 16:14:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba16-20020a0560001c1000b0033d9c7eb63csm3109966wrb.84.2024.02.29.16.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:14:48 -0800 (PST)
Message-ID: <fdccaca2ba0c92a3f2b33f6608182ab80507ec53.1709252086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 Mar 2024 00:14:39 +0000
Subject: [PATCH v6 2/9] shortlog: add test for de-duplicating folded trailers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

The shortlog builtin was taught to use the trailer iterator interface in
47beb37bc6 (shortlog: match commit trailers with --group, 2020-09-27).
The iterator always unfolds values and this has always been the case
since the time the iterator was first introduced in f0939a0eb1 (trailer:
add interface for iterating over commit trailers, 2020-09-27). Add a
comment line to remind readers of this behavior.

The fact that the iterator always unfolds values is important
(at least for shortlog) because unfolding allows it to recognize both
folded and unfolded versions of the same trailer for de-duplication.

Capture the existing behavior in a new test case to guard against
regressions in this area. This test case is based off of the existing
"shortlog de-duplicates trailers in a single commit" just above it. Now
if we were to remove the call to

    unfold_value(&iter->val);

inside the iterator, this new test case will break.

Signed-off-by: Linus Arver <linusa@google.com>
---
 t/t4201-shortlog.sh | 32 ++++++++++++++++++++++++++++++++
 trailer.c           |  1 +
 2 files changed, 33 insertions(+)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index d7382709fc1..f698d0c9ad2 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -312,6 +312,38 @@ test_expect_success 'shortlog de-duplicates trailers in a single commit' '
 	test_cmp expect actual
 '
 
+# Trailers that have unfolded (single line) and folded (multiline) values which
+# are otherwise identical are treated as the same trailer for de-duplication.
+test_expect_success 'shortlog de-duplicates trailers in a single commit (folded/unfolded values)' '
+	git commit --allow-empty -F - <<-\EOF &&
+	subject one
+
+	this message has two distinct values, plus a repeat (folded)
+
+	Repeated-trailer: Foo foo foo
+	Repeated-trailer: Bar
+	Repeated-trailer: Foo
+	  foo foo
+	EOF
+
+	git commit --allow-empty -F - <<-\EOF &&
+	subject two
+
+	similar to the previous, but without the second distinct value
+
+	Repeated-trailer: Foo foo foo
+	Repeated-trailer: Foo
+	  foo foo
+	EOF
+
+	cat >expect <<-\EOF &&
+	     2	Foo foo foo
+	     1	Bar
+	EOF
+	git shortlog -ns --group=trailer:repeated-trailer -2 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'shortlog can match multiple groups' '
 	git commit --allow-empty -F - <<-\EOF &&
 	subject one
diff --git a/trailer.c b/trailer.c
index e1d83390b66..f74915bd8cd 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1270,6 +1270,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 		strbuf_reset(&iter->val);
 		parse_trailer(&iter->key, &iter->val, NULL,
 			      trailer, separator_pos);
+		/* Always unfold values during iteration. */
 		unfold_value(&iter->val);
 		return 1;
 	}
-- 
gitgitgadget

