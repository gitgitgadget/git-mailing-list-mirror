Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4C3002D6
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563525; cv=none; b=Td1UCRZXrUCUEDiFalkFg3+FWXA4ZUMOOBi07Kyp5SXzY2Z+ReDrYsurlbD1VE9Q+zX18R2FdahfVgTO74oobhkiQnJ6voADEyf0nKKD4v+dNrXYDwP062qUI2IGwgQyQjQF7V2QDwOIf01iIfUOrXwhqPvKgWmPyq0UShgEhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563525; c=relaxed/simple;
	bh=a+4TwsxHBEblygWcypEHNoSwBvwgL2tg4JPm6t/ht2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7uwsuFDN8dcOGdA756+pa2dhNkOChOsjqefRKhrQbcbMbuntDAgzOEY/Ng44jxQUrwX2iLclWx9oP4fblh+VEKFugXr4C/DzZGa2Tj1dZySp8VnjcXLZKbFafxSjDQN9nJC0jCYS9z7GkErZUrBL6+CLTO0MYmFMzqXLAvX6mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHEnQ9BG; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHEnQ9BG"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b472842981fso4262366b.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563521; x=1761168321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjXLffEfXT+gmLQpqEubUETgswes520pE9D7QD98cE4=;
        b=NHEnQ9BGgXYaeBr89s9gShif7FtwPtp8alL1vgqG/DvCYRlKs8VkG0QUmhO0BiIhCj
         DDCaGeccS4oeNBbSj0EedJ0tUqQUfrrBqn2uaoD5trmDw2kp2DUAGCDpw6fd8b4dl+nw
         sWTdF3/WS0d9kLjmcDmSOKUN3MsncGGSxH05Sh5seXabBwyk4s4iIK8HiSpR9Zpz7ppt
         13UBi05VW3X184F/ZfcOZ5yNPPbFUPVslOEt/joGSf0Wp4QkUTbJwceD2gYyXUpz+tDq
         zR44PV8rf4r4+oOAjzZJhkHz4MfvaI4BAa68y2w9ZItG649Dml0Pemo9ZIPXDf4E5lrf
         /32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563521; x=1761168321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjXLffEfXT+gmLQpqEubUETgswes520pE9D7QD98cE4=;
        b=ipylEDd9utZERutLXHbMialz9DAT1pMd8T9wurI/hBvRpl6cjhh0VjlMRdNXSchMDZ
         gH+G21KbDzsokn5HX1KwHY8u0xsBFbvwHR3Rj71uF9twWI/PbvjB7HkvFRGG+/m3SIBU
         EIjrrhOmQ8vb6EYLxVd8GEKPtb8Z4MyJkOTv9aFCHzrE9dydkZWx+AxruD/qfZ0X1gB/
         hGwnt+qv9+cMKFFFv+kmt0oABkxgI0FhV7EFODpTS3ys31vYiicyKEc3VUm/5RDWun3j
         v6CVLEAaXgycvV7+hN8qxnhbHLWcLOn/aPNz5ar8FvaexCLlqOHCD7m9cVOVUHTuxrHR
         LrkQ==
X-Gm-Message-State: AOJu0YzvDs/1KR791ZyLU7ieNWZdAglVriaRFWlTj0c0hnIprxZ3bgv+
	59hg2NdjfU69cdrfB9ESVIOn0X3B6qqjyotpc/GdkhMwjSs1gdLKjyNjQxO+cByf
X-Gm-Gg: ASbGncvSRBK1BXz3z8CcE8rulkMLADHjo5HAh5JAsbQcCu+TbGv+SI+9TNFuRlUQvKG
	FMkwAt5CD+AXhxHImNV0Ld32vZi5IJM3wypU7XF44x/WmtDGWpnBITHc98uCXKhtIJN7urMlBNN
	BBnqAjjC9t/T9RNnS/yDF4JmCpWlKGyM7m1a/0AGEd3TgSv1dZShJZmBwrDSKExHqPszTF8uTt+
	uHu6QuomDOItRUPLwrgHcPlW9L5S3S3Rw7ElHigEoZ/3UEv2r7oZQh0pU/YwXH4jLUXItbBSGBc
	4beBAMIcqQtWmzFwaJhMso2jZTwWHZCIFW0g97jqXI3nusNyZmLz4OxTxqr6+dccPWBVxyFy/G2
	z+CgDYGqro9CYgBTSIyzx9hnVFypzh/wrV433l1j7DaLoKqB82keAv4oe9PwjHeNnCVzfs/EHNq
	c8vZq7AAlI
X-Google-Smtp-Source: AGHT+IGto4B0GtEp7SJ+4d1JFc/nhRTRHhfjBRXtuqwuq7OE3h4b/OaLyPDY/IK3BLK33Fa/46qTnQ==
X-Received: by 2002:a17:907:9702:b0:b49:96e4:1845 with SMTP id a640c23a62f3a-b50ac2cf386mr3286266866b.41.1760563521030;
        Wed, 15 Oct 2025 14:25:21 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:980b:e8aa:7473:ef22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdaa082sm315854766b.50.2025.10.15.14.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:25:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 15 Oct 2025 23:25:09 +0200
Subject: [PATCH 4/4] t/pack-refs-tests: move the 'test_done' to callees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-refs-code-cleanup-v1-4-550fdd8a3b41@gmail.com>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
In-Reply-To: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=a+4TwsxHBEblygWcypEHNoSwBvwgL2tg4JPm6t/ht2s=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjwETv1Rlnu7kQZ/zjfwuQWWm+CsbtT2lk70
 bD8avVuEzUpSIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo8BE7AAoJED7VnySO
 Rox/n3sL/277ODdAaYM8e+yp89PKvenswLTlNllmfjnGY/Qn6nXoTC/D1DTx0gGf205GHyznfGK
 BI8FynoP8JbbS5Q/3JnKpIhr0K63RN6X9kChrU+EkpbP7h/bml7juC6WfD2u0Pn+wdlyoX37PRT
 2RVddG4RUuow8V2GdVJeOMbiO2JSQLACHRW8/Ys58N1c5rYnX0LxCan3yNjLYyZJ1ayrRBzyK8G
 7VLIMvI9LqnPlIX61+SSWnNv8KNWCoTOaZl7Ca/ApoV+tE9GYcquXIJ2ZaN+syeZPr0Cr6t5Yny
 7I17XjJA7zbLLBOl453qy3Df9a96HEIvR8NoXCaueTaMnZbpHUTNE08WT8ahHM9Vu63O6NWxw1i
 Kbg6QUaRnfYHhjv5j01yO/22l3NEjgpyBTJi0VgzrE3bajV5zDYGsbvIWlIUiJl3uegEE7it8/K
 QMbk6xCUDOdeoKOElYBZ/nyRYJMioGxrwv9H0uMuM7KYKI3v2012JbfRMU3jM3GFt9TfoyhUl/7
 Fk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In ac0bad0af4 (t0601: refactor tests to be shareable, 2025-09-19), we
refactored 't/t0601-reffiles-pack-refs.sh' to move all of the tests to
't/pack-refs-tests.sh', which became a common test suite which was also
used by 't/t1463-refs-optimize.sh'.

This also moved the 'test_done' directive to 't/pack-refs-tests.sh'.
Which inhibits additional tests from being added to either of the tests.
Let's move the directive out to both the tests, so that we can add
additional specific tests to them. Also the test flow logic shouldn't be
part of tests which can be embedded in other test scripts.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/pack-refs-tests.sh          | 2 --
 t/t0601-reffiles-pack-refs.sh | 2 ++
 t/t1463-refs-optimize.sh      | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 095823d915..81086c3690 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -459,5 +459,3 @@ test_expect_success 'pack-refs does not store invalid peeled tag value' '
 		test_grep ! "^\^" .git/packed-refs
 	)
 '
-
-test_done
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index 12cf5d1dcb..3c706978ef 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -18,3 +18,5 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/pack-refs-tests.sh
+
+test_done
diff --git a/t/t1463-refs-optimize.sh b/t/t1463-refs-optimize.sh
index c11c905d79..9afe3c1ed7 100755
--- a/t/t1463-refs-optimize.sh
+++ b/t/t1463-refs-optimize.sh
@@ -15,3 +15,5 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 
 pack_refs='refs optimize'
 . "$TEST_DIRECTORY"/pack-refs-tests.sh
+
+test_done

-- 
2.51.0

