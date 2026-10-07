Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C44A3D42
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381053; cv=none; b=hew31ToPMEyebnX71+BRYCXFWyJLspA2OUxf3fe0ElT2/skxBkfbhS8q5PINZSz5nnK2eS6qucxk7+4tZZWH9jTztyf34cgPswC2vDDB3ypiaubxBzn6eonV92qLqXER8qTo/Dq1a+pM+ydkUl9G8oEilmJR/GlX6ZxLn+JuaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381053; c=relaxed/simple;
	bh=yyW/XpoK1+ASjTESOjCZdLNED+7WXkWK1K8Ktw+pL7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pc7H0MEyGww6SmvCJbpRS+sIGkdJOYwbZHrGamzM7zVnenGRK7gXVsOz75XK3cz/iw/Ywc1su5BoTQ1s9UxmyTs+H6Gom7Ttr1LznnuOxW6c+N+VZq8YaM8OQEnGWUKJrN2gHn6dO9/TRtdeex7zcCi5d9kbLCYi/hecQB3HMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8g3mGqw; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8g3mGqw"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc7cc8aafe6so894885a12.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791381039; x=1791985839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2OR4eJd6Ik98Orbm3IaQ3hDAdYJfexIczNM7A/0XHXY=;
        b=U8g3mGqwcopc+lMEYgfOVFhDsSF+hjqLlvJFwyzdoZoUq5kGievpXI6cHZySj/MIvO
         74itkDZfncdNDBgxaJLfBJ16cUeufp2Wtkqa3P788YgDg030JAkBMdqko0sOjloN+RGb
         teBYG+FwHqEEU57thw9+YXZFOfT81RH2dYzVhTJe8hPn7dxRTcgeA09dD9vZ0KiwQiQ2
         nEOYmcRxrh5gvs3NWrLaVSFrRe2uMlnzUVXX1ZB2Fyduf8z8o8UgI/VIAdtKC81xgcd2
         3s3ieyAf6h4pLFIFSKpWDnllJ+ZQ1k9j+dmk8RFaDybDTxgDZfNVzAvYZMVa4v8mxZKo
         MYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791381039; x=1791985839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2OR4eJd6Ik98Orbm3IaQ3hDAdYJfexIczNM7A/0XHXY=;
        b=gMmivndUVY6m+F4M9P0a4c+7jmkueDLVso/rXndfSQkooiB6iBHYPBojr4+t/hF5Vm
         ZR1ThYHMcOiO/BQs4vOLMNophYHqvC4TxVts/UxVJgoofkgAo9a+s3YBMPasguKc3Ufp
         73uA4yfuLfs6dEK5ksF4Pqzu9CVD3Bf+nI5E0Tbh2xAjGMlC+n7wZs9mxGp4/13BXScl
         ny7zvYPQIf6p+X4uvjG7oqBMvxVwfg6J+hAN6tsKFdIH57NNU0/21i8Mp+RHxhH2deG7
         ymzA0BiH3ZkfLiiMxF2MYJmPff7mZUoY3hwcMdhQVjo85bxbu3ChRy6a23fY5muyXaUq
         3Yzg==
X-Gm-Message-State: AFq9FYKHETFy+dzwOGtPLLS/EFMB664RAUczKsQECPX4vLbJpAmdwCm0
	6kN78kaeBibTqIoHeFcDvMi8c4coGo4AbHSMKRRWGHbSZHTqwEFAQaPjra5vyutG
X-Gm-Gg: AYBFou0ZKwqlrj8bXPVM0J/oRuKD1G4GRbgChMswxYqum6lmhaLVTOkhY2O+QULv1oL
	ZvBAJQ6aKAlnSSWlS9x/x38v5TP4elUOOGDV8fEzTLmQUs4LKdaYkI2NjFZjcSGpo3DYsxlyLZP
	rEUHxnohf+8gwvV+CUw1oDuUGjQ6X8SsH6if7INQA8eH1dcNJ6MKP7K8lm9CgiSDMPxLgvoN9TY
	1ViqUcFRTb0ddBtJM6ITQJbKRbeX99Iud6Sd6thDMLUPcHwI5jcZYdnOEPhxVOOemJES41zmvHY
	SWukDTVPX6AkWf6xJxL6ltMYLQU3VmckQpXwp1l1GoTTVApoMIK1G+iOSZRJpJwr+uXfqwGu6Mh
	yMgv+l6CW1jtBriJMLhKefuXCA+c3Hy9QHLCSaFyyodi08VOlw81S+RIzZCXbvAftIdhpikywO9
	qEwNT7jRatR82yKB3F+nXeQK9eGtmMcI4jTOm+TwwHQ3aTgVjz7diJFNHL3vfhLxGkbfDi+kSN1
	GvTc9Q=
X-Received: by 2002:a17:90b:6c5:b0:3a8:e1e:338f with SMTP id 98e67ed59e1d1-3a8a1b04031mr1895984a91.38.1791381039255;
        Wed, 07 Oct 2026 06:50:39 -0700 (PDT)
Received: from archlinux ([2409:40f4:314a:a1e2:9855:ada9:1db7:a1fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533abe0asm10577916a91.1.2026.10.07.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:50:36 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v2 0/3] mergesort: move tests to Clar and retire the helper
Date: Wed,  7 Oct 2026 19:20:22 +0530
Message-ID: <cover.1791365181.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007034205.32619-1-dilsheddilu123@gmail.com>
References: <20261007034205.32619-1-dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Patrick,

Thanks for the review. I followed up on the larger cleanup you mentioned.
The sorting tests now run in Clar, and I have removed the old benchmark
and its helper. This also removes the unused generate subcommand.

The new suite keeps all 1,680 cases from the old certification test and
adds checks for empty and small lists using both sort macros. It checks
sorting order, stability and list length. Cleanup frees the backing
arrays directly, so a failed assertion does not need to walk list links.

Changes since v1:

* Patch 1 is unchanged.
* Patch 2 moves the tests to Clar and removes the unused generate and
  test commands. The sort command remains available for the benchmark.
* Patch 3 removes p0071 and the remaining sort helper, along with their
  build and command registrations.

I kept the leak fix first so it can still be applied on its own if you
would prefer to keep the broader cleanup for a separate series.

The Make and Meson unit tests pass, and the mergesort unit suite also
passes with LeakSanitizer enabled. The production sorting implementation
is unchanged.

Muhammed Dilshad A (3):
  test-mergesort: plug memory leaks in sort_stdin()
  mergesort: move sorting tests to the unit-test framework
  t: retire the sorting benchmark and mergesort helper

 Makefile                   |   2 +-
 t/helper/meson.build       |   1 -
 t/helper/test-mergesort.c  | 408 -------------------------------------
 t/helper/test-tool.c       |   1 -
 t/helper/test-tool.h       |   1 -
 t/meson.build              |   3 +-
 t/perf/p0071-sort.sh       |  52 -----
 t/t0071-sort.sh            |  11 -
 t/unit-tests/u-mergesort.c | 369 +++++++++++++++++++++++++++++++++
 9 files changed, 371 insertions(+), 477 deletions(-)
 delete mode 100644 t/helper/test-mergesort.c
 delete mode 100755 t/perf/p0071-sort.sh
 delete mode 100755 t/t0071-sort.sh
 create mode 100644 t/unit-tests/u-mergesort.c


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.55.0
