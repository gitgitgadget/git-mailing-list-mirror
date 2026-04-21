Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120258BE9
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776749636; cv=none; b=bJgDAldghyqolUtVREvBZk+Yrq2OtB5A55MYqj23riFvbqT2lawNTQMbz8l6lE90yQmNrjtAE2ktbdGxLS5LdezCbmg8Tp9p10PSgSZWAsllqyT0B+iakE/EbIdRDB8k/rNuvpUfvrjn4xViLGy/J0ftrEAWrBsk+ghYukwU4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776749636; c=relaxed/simple;
	bh=g3Bw6xv45WzdGWp0/N6CN7wklH7YOe6XmceEeIWZml0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIGDNUlWUatNyNgBw4KkWWYx+Z11NcYLPG2sk4svUwkIXs60WamziW7g0XpoljqaNquH9Rn+qXxIjeGw7T0klreX+rLcvhzm3RwDukIE9mr3K8DtScRIi3B+80+lO6V32ftFepWez5SQBTXyt/j5esLvtUM8UMxU/GV/XXGmqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYh+no8W; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYh+no8W"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso2375792a91.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 22:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776749634; x=1777354434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG/dh2dLSMbY2FpOkhA/96oNa8ylzmXt5xiXdc8BlP0=;
        b=GYh+no8WrasopBjkVqULEfF4t9UDJjoNVHShq1d3sz7UJn6gt9nPRVE4+aM1Mi1Lxz
         JpPsmV5q23XvAj58hjW+Q7TKUzI8o9v2D7vB0mT/1TUO+gJauq8CE8VUV3QLsksAOc5a
         2l27eCzx2KWvcWfPmDnLK281FYn7jh3Dik56gADYKjmWQbltO5kqCnYOHahab9VkXHop
         SIpgcapNHRrmbPb//rcb3ay0Ski8j2ryp5mqZOmXh9kk1cJRFcf+z5ltYuWCcI9wN4Fj
         9RzKRu+ZgTV3LXoxL48oallgzidX71Wb9KuBXui0QAu/ZXxrHwhik+IydkrVHv+SolkC
         E7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776749634; x=1777354434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cG/dh2dLSMbY2FpOkhA/96oNa8ylzmXt5xiXdc8BlP0=;
        b=hjx4t6WwcbF32D8AB1qnB6bEusbpAtVtwxXgR14EV9NJAoz0sJsMcgO7f9rAZfTBnt
         vdbca3dsq2sj46MTrRdq6WKdWnvZGf6YBhwtp8DEwWuvhV4cmNtNBXoXdXs8umboRm1z
         cnVrOa2J9ghJVzYzIHyoiUDzK9AcOEEKydm6gVPMmVy5rjzI7RaFXyPAkuCjhRgybhgN
         cmTgBQ0EOZMHhSXYQGqBp2BH2yp0JsqCvYEU2i1UiGImIQhiJ2gbPcrnJXYpGkqL64DE
         I++npO7gwqBvPHb263FL6oEzsZiePtpGN2NasqfRmCOtaljD/oyUJCH9khzoILGBKN1G
         51OQ==
X-Gm-Message-State: AOJu0Yw/L5aBWyjuL3QUxFRa1XNDeI26lWJF/Dwcj0AfMuTZBm0eOWnL
	rOndnOemF8jrz5mHIY6P/Fvlf6rkQ/SfszU4VRB/6/H6f6QJb3JU6D5SMhVIcw==
X-Gm-Gg: AeBDieuwqrFcVAJ8+Go5cq40joCSEiapFZrfYcaI+6px6kMurEEXg+IZViYMMsGiyNN
	1V6UeEcORACLUyogEOsb8Q4WjrlmeeTnKDvsvT449hzIXMgV7PpB10ull5skK6ifdg6nXlKIeX+
	EELaOlscrTDJhr0uOM4NS+ASbnZY5jYC6DwB+0AVnlhlUgvjSYRyA/gctdua4Hl2uQGP65PMNHW
	pDZ0r7LKTdgScv4LmksWj6a/Z+/EXCuPbZthwAZzkTckyZ/+V8qxKXi/LAMtATy7EFCXj2m1aEk
	J5pGACJWWaPjXvGaPe0OKW4db3bz4zgDXSoQDeWGI3xZkDaaf0huoc1XkWJiu7wxYlhQfKb8m61
	hCjUbAVRxCTj3MFI569EozOKSLjaSPNInfk7mSag0MeNSXLrCsO8nqFNIPHNYwjgVIjm2tD0+8c
	+Zu1aTRN42RFPajo7CezmAXmYM5EkWB2wHOx5t3BlZWU9iiZutzFY7zU0fYKWa1ILdHJ9Iz7gbX
	7GF0fHQtQy7YXpplElGZuqQVDPU9Ai9kHiL9ceWdVO36upOl9ujvRO8xzHMK8OdOVZh
X-Received: by 2002:a17:90b:3c52:b0:35f:b50e:defc with SMTP id 98e67ed59e1d1-36140473f07mr17704914a91.16.1776749634026;
        Mon, 20 Apr 2026 22:33:54 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:c0a5:e9e6:3079:1553:266:991])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fa91d31sm6454484a91.2.2026.04.20.22.33.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Apr 2026 22:33:53 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	abdobngad@gmail.com,
	bence@ferdinandy.com,
	john.a.passaro@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2 1/3] t7004: drop hardcoded tag count for state verification
Date: Tue, 21 Apr 2026 11:03:32 +0530
Message-ID: <20260421053334.5414-2-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260421053334.5414-1-r.siddharth.shrimali@gmail.com>
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
 <20260421053334.5414-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'trying to create a tag with a non-valid name should fail',
checked that exactly one tag existed in the repository before and after
attempting to create invalid tags.

As pointed out by Junio, this makes the test brittle by relying on a
specific global tag count. If future tests are added or removed before
this test, the expected state changes and this test would break for
completely unrelated reasons.

Modernize the test by taking a snapshot of the existing tags before the
failure attempts and comparing it to a snapshot taken after.
This provides a "belt-and-suspenders" approach: we verify that
'git tag' both exits with the expected error code and leaves the
repository state untouched, without being brittle to the specific
number of tags present.

This replaces the hardcoded 'test_line_count = 1' checks with 'test_cmp'
to ensure the tag list remains identical.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t7004-tag.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index faf7d97fc4..77a7a9777d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -191,15 +191,14 @@ test_expect_success 'trying to create a tag with the name of one existing should
 '
 
 test_expect_success 'trying to create a tag with a non-valid name should fail' '
-	git tag -l >actual &&
-	test_line_count = 1 actual &&
+	git tag -l >tags-before &&
 	test_must_fail git tag "" &&
 	test_must_fail git tag .othertag &&
 	test_must_fail git tag "other tag" &&
 	test_must_fail git tag "othertag^" &&
 	test_must_fail git tag "other~tag" &&
-	git tag -l >actual &&
-	test_line_count = 1 actual
+	git tag -l >tags-after &&
+	test_cmp tags-before tags-after
 '
 
 test_expect_success 'creating a tag using HEAD directly should succeed' '
-- 
2.51.2

