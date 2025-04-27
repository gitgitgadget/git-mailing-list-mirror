Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4851C695
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745780066; cv=none; b=AzMg0U2cuWu0IpeccatYUa0q30q9ss9MvK6D9m2Yt8bX1EddWwUj5LuY+TMOl/ceJTlIEFfAdu610q6ajcEcPsvRne8Z59ECgdyYYOlaEHD1NxYEf9/vSjRo6Kh7+6Qi03d1t8vQKSomas9YqjifxLjM1lY5cy5xo0cwBuHmZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745780066; c=relaxed/simple;
	bh=J1IZcjQBKkjKenXLN0zqcvhZ+eoJ/RszsAg0Y58Vc1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgyjuwZWTfmhPC7WWikmkmjx9QzKeMzgd8QiVpo+LGoYnOk1GIl0RcTUaMkD1gS9bhyR5pGprWkwMKrGu0ogGJ8H2d5R2NJ3Lwsd9nzat9r8l55qXDzcGZ9biFxzat4ZSQJrDm1MEY4qns8xmsiR/Bn5UikThDauCA5BsErtGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBE9rjq2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBE9rjq2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a064a3e143so2006225f8f.3
        for <git@vger.kernel.org>; Sun, 27 Apr 2025 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745780063; x=1746384863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzXrahzCNxpq5YQ8aptJYONNm+2OqVRew+xzPgDmZE8=;
        b=SBE9rjq2TVnEY4SeRabhyJh9kwNaVQYqEYg5VaxbMwtleriuQqXJ4tRhhRWseeTWWe
         lseBraaql/M91tUBVufGW30GgrWWKuNap2emOWVXtiLlhvNjARZEhwfW2IWKD9gndyVF
         SrEnU+q7ZxGjLmTnJPC1APQz5UbaGm7wUKFyA6z0wwtQjFVgUmOj+zYEJz3fFNUp7KmN
         URTjJWVAXT+/4blGUo+d/Rkt76N/0qHZkr0xcZGlWDKF7xXwk9x9DiBXcLHx3Pzk+C6q
         ZrHSjt557PoTrdM9jd0iPAC9iOjRrUl34zk9WxscsR1aN+l9Uv7i7O2m3AKyYZvupgUH
         nM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745780063; x=1746384863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzXrahzCNxpq5YQ8aptJYONNm+2OqVRew+xzPgDmZE8=;
        b=Il32rRxolFjL52c5kseFGVvNqU8K5sB3e89KY30FVLMzfYdHEFbC2xS3LIEc+NL3Qa
         C2dopLcAVR/v2SkbtkhurUHFzNGp8OeMG/0yrFlAbCkW5RLYKX9Gi5/O9L9uM8lyZWcx
         rW+fD4IFAwa8d1wvh5k8RkXRNbcks4osiB4tAachXDxxg1Bae8rFtP7h3A+m+92HxLcL
         TcE5Aqf2veVLC4aKcId8C9iGpZmDuDTCYpDl2vCt+hYRn9Y2RSd3N1v5tyzQ43V3TIbG
         AnVcXhbU85i4pMEz68iyWApJYeek+rcIcgJr+UW4vACYvtW0HQGa/1Wveq47Chwybllk
         uXjQ==
X-Gm-Message-State: AOJu0YyZLABErm+XSGE0IZaLXEbHCjR9tfkd5yceTxNQ4D3YhMTd06p1
	aQlVkJuesVrcZoCsyhXXtRvQtsrzeq0i04eQfkxcFSFCZPebHl2dWn7JiGj7uvX8zg==
X-Gm-Gg: ASbGncv4aqFBqyAjwuqCmO6ATdS91Su0B2tlQvTEBgfL4jv2X+cOi5rYIVCGAbABlQH
	HzneqHrVJp/KSGZRDttZpfQo2UlRSOvET0cf+VjqX8lEoVybRi6deqJPxmV8o2GdTGnaZqxrwN2
	0ewDpOCeEso7KycfkrP0ieBoWkqNmjNln1Bp8K1eEovroE/WKnqZMXdRSeMpu71jmo/wh8Nq7AM
	up3wbwdF4gdP1wBsb0+VE9hUurEbKmEr/LoU+5+F95SUpquyhpbmkVcAWHekO1uM2UarAI6qVl+
	ybG8hTPl5JFPV0F7OPEyjSsSiXnh/TG0vSDCDEIMa3FZtj0=
X-Google-Smtp-Source: AGHT+IFm4Ln6/XvuAQlDp7FwWuPBvqJ5xT29fR9Ka+vSyeLOIlQuLbe6sSCtn4o73/5KB1zKaEYbfg==
X-Received: by 2002:a05:6000:2911:b0:390:f2f1:2a17 with SMTP id ffacd0b85a97d-3a074f4868fmr7469382f8f.53.1745780062742;
        Sun, 27 Apr 2025 11:54:22 -0700 (PDT)
Received: from localhost.localdomain ([105.113.116.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cc74sm9150175f8f.11.2025.04.27.11.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 11:54:22 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 0/9] t/unit-tests: convert unit-tests to use clar
Date: Sun, 27 Apr 2025 19:53:42 +0100
Message-ID: <20250427185351.82520-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series marks the final batch of our existing unit test
files transitioned to the Clar testing framework. It covers all the
reftable-related test files, and is part of our ongoing effort to
standardize our testing framework to enhance its maintainability.

Thanks
Seyi

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>

Seyi Kuforiji (9):
  t/unit-tests: adapt lib-reftable{c,h} helper functions to clar
  t/unit-tests: convert reftable basics test to use clar test framework
  t/unit-tests: convert reftable block test to use clar
  t/unit-tests: convert reftable merged test to use clar
  t/unit-tests: convert reftable pq test to use clar
  t/unit-tests: convert reftable reader test to use clar
  t/unit-tests: convert reftable readwrite test to use clar
  t/unit-tests: convert reftable record test to use clar
  t/unit-tests: convert reftable stack test to use clar

 Makefile                            |   20 +-
 t/meson.build                       |   21 +-
 t/unit-tests/lib-reftable.c         |   26 +-
 t/unit-tests/lib-reftable.h         |    6 +-
 t/unit-tests/t-reftable-basics.c    |  219 ----
 t/unit-tests/t-reftable-block.c     |  383 -------
 t/unit-tests/t-reftable-merged.c    |  546 ----------
 t/unit-tests/t-reftable-pq.c        |  161 ---
 t/unit-tests/t-reftable-reader.c    |   96 --
 t/unit-tests/t-reftable-readwrite.c |  985 ------------------
 t/unit-tests/t-reftable-record.c    |  585 -----------
 t/unit-tests/t-reftable-stack.c     | 1451 ---------------------------
 t/unit-tests/u-reftable-basics.c    |  195 ++++
 t/unit-tests/u-reftable-block.c     |  373 +++++++
 t/unit-tests/u-reftable-merged.c    |  515 ++++++++++
 t/unit-tests/u-reftable-pq.c        |  152 +++
 t/unit-tests/u-reftable-reader.c    |   78 ++
 t/unit-tests/u-reftable-readwrite.c |  870 ++++++++++++++++
 t/unit-tests/u-reftable-record.c    |  565 +++++++++++
 t/unit-tests/u-reftable-stack.c     | 1247 +++++++++++++++++++++++
 20 files changed, 4031 insertions(+), 4463 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-basics.c
 delete mode 100644 t/unit-tests/t-reftable-block.c
 delete mode 100644 t/unit-tests/t-reftable-merged.c
 delete mode 100644 t/unit-tests/t-reftable-pq.c
 delete mode 100644 t/unit-tests/t-reftable-reader.c
 delete mode 100644 t/unit-tests/t-reftable-readwrite.c
 delete mode 100644 t/unit-tests/t-reftable-record.c
 delete mode 100644 t/unit-tests/t-reftable-stack.c
 create mode 100644 t/unit-tests/u-reftable-basics.c
 create mode 100644 t/unit-tests/u-reftable-block.c
 create mode 100644 t/unit-tests/u-reftable-merged.c
 create mode 100644 t/unit-tests/u-reftable-pq.c
 create mode 100644 t/unit-tests/u-reftable-reader.c
 create mode 100644 t/unit-tests/u-reftable-readwrite.c
 create mode 100644 t/unit-tests/u-reftable-record.c
 create mode 100644 t/unit-tests/u-reftable-stack.c

-- 
2.43.0

