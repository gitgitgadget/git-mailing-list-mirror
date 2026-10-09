Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524753B3C05
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558547; cv=none; b=IJg1l0VTuDALRH0YUn8lFOUvG5EKhHK8fR7KGSEYsUKPFx8wbAz0yKndEg3tXaPq2HMfkGXpt1xvcNkplWNb/YhnyTfd8Lj8jGDnzcASYFMFgMG1bNj4XLMNs7tzIxvNRD/nOgenplqgttd/iwU9HKnj11jmqzrfhoUPyd/oA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558547; c=relaxed/simple;
	bh=Hk6QxCJ2Xa0f9lYKhYcJTsPheVaUQvXwonhpFLazycI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvxQFfwVkvE5kdfLTgQIvPrECeBjIHhnWsS/c/+yZ9hzPIIoIusoglFB8aPj3BX7kBdvfo2G8nsu2N5bGMg7Y0M6QrepyGG2y+g0giql1NzxW8NuWe+ojV7D/Pe7ldEbl7jq7WiylAyXBM5uluiAlMPEzfUurZec/H809IuireE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOpMk7S9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOpMk7S9"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-88bc25fcd0eso5352704b3a.2
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791558546; x=1792163346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KRUIPiTfgsboY+ufL9KfQ9YtIWvSUlV+No50mTJjdhk=;
        b=aOpMk7S9/dAPAPqDAp6V+OeILQ/KU7/vU7FhS4ms1ePEk9hm6RmiFRNgwdkzZOiMNc
         wL2LPb6p7KJywbzGozZoaAUbKeefIai+YSnOkn1nEqmcmoudMmFohVKRWME2EkTBguPM
         Hm8UlFE681o/xOmt7oxB456YVKz4DcE2bwxDqzakJ3lBdIi3xKlYvQUfLCzsGrONPDmp
         7PuTNZ5Et0UsRqMsa6sXfZcdzk7jaFN8J6WjMqXJsCWGyOKeV/QSGzH1zuJOFdikFXKy
         jtBxy/b0A99lbNAXsAFBdN4WcvzKhanW2YTATOyouvrMQImJUqoytNB6qNGgvuW9a4PB
         mzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791558546; x=1792163346;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KRUIPiTfgsboY+ufL9KfQ9YtIWvSUlV+No50mTJjdhk=;
        b=dK6wVrEdk41E+HLYEkEt9hS3mO/UatKuoA/Wr5A4nAzh1v4z1vu+8+hBfTf71jwYK+
         QAMSbCCInLlUAeBxiXT/ksrle23IWyAQcSe8RP9idnx7sF6afUMBkg2mVKXczusq013M
         xgLeQqcTk4xjXT4nfaMrbztvd3hDueb1GGTcM08Nznw8/WJ6ohdKbu17UWisNJe7Oino
         IaQ2mL2AGu2XBYnKmUeN5Iku6OzjmDeH9dJCU4h+uVzXdlKBSET8HMxKE5HTFnVadBGM
         B3rT/kP9d+NOchmgdYQksaISV52T8Q8n5wjmeaTuzsF0VDGVhEJ19BndY5kcC9j/E9TO
         xnWg==
X-Gm-Message-State: AFuF++lHiB4HUFbD3XBOusIWidfgpo12ozAngsjjAN1uiqCUeOj8dv1N
	/LcHSS4CxWVFtC2FqoppE1woEcEVj7sS0Y9qWTf1XEArSloOG8SDEM9ga1Tlv2/P2fM=
X-Gm-Gg: AYBFou0CuKKHUWgvnM6WXqdx6E5i5rVaXVCO2xhgk1zRbh9hVrJWI3blXkDT6zWDBe0
	13oV+ek7YulEgMa7DB6AzTnOShdCats6MNmT5OzeR81bI5HFHNi1Vw5aCcPEzW1Oqg++pvflLvn
	jgkXwPBiV6bEzA397r1BOrlb5pjVUa7hDre2rJBMOsfxNiyAouYo3T3qZhPQaI3Qi2Weyuc3IVy
	jFAspmEPF/myqWSipd6FO9PCFpxKJr4sDHr78PDK+0EDbwAFnqqz77osDdtlHtaEemiscDiiBL0
	oxTjU646tVkqYjZJobG9v6x05imxTJYvJczki4E8+A3VuMne2US1s/kSRMG5rOVHzveJ+QilB80
	w4GRkE5QJgAetDgOd5xmX2mvXhT8rByNk4x+PhCK+9bqyr9v123KRZ3DTnbo3qSsUHKa87PeoZo
	GT1bQX54PSFgyjTpXV68Wg77DE1wffyfNu2q585MOz2W9KdFLMnYmAXcFqtn5ZX6sHsDc9jcFrC
	V4G1Q==
X-Received: by 2002:a05:6a21:4598:b0:3de:4c08:174 with SMTP id adf61e73a8af0-3e16be33e26mr1986202637.33.1791558545447;
        Fri, 09 Oct 2026 08:09:05 -0700 (PDT)
Received: from archlinux ([2409:40f4:3151:37e2:36ef:bf3c:7f30:217e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da03f449sm1113553a12.28.2026.10.09.08.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:09:04 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v3 0/4] mergesort: move tests to Clar and remove the helper
Date: Fri,  9 Oct 2026 20:38:46 +0530
Message-ID: <cover.1791556668.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791365181.git.dilsheddilu123@gmail.com>
References: <cover.1791365181.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the mergesort checks from the shell test and helper into Clar, where
the tests call the sort functions directly.

Simplify the old distribution/mode grid to direct tests for sorted,
reversed, equal-value and repeatable random input. Keep the checks for
sorted values, the original order of equal values, and list length. Add
empty and small-list cases and a check of the debug hooks separately.
The final tests cover fewer input combinations than the old certification
test.

Retire p0071, the benchmark used to compare sorting implementations.
This removes the last user of the mergesort helper, so remove that too.

The migration, simplification, additional tests and benchmark removal are
separate commits.

Changes since v2:

* Drop the leak-fix patch, since this series removes the helper.
* Simplify the test inputs and remove the distribution/mode tables.
* Put the additional tests in their own commit.
* Rewrite the commit messages to explain the changes more clearly.

Muhammed Dilshad A (4):
  mergesort: move sorting tests to Clar
  mergesort: simplify the unit tests
  mergesort: cover empty and small lists
  t: retire the sorting benchmark and mergesort helper

 Makefile                   |   2 +-
 t/helper/meson.build       |   1 -
 t/helper/test-mergesort.c  | 408 -------------------------------------
 t/helper/test-tool.c       |   1 -
 t/helper/test-tool.h       |   1 -
 t/meson.build              |   3 +-
 t/perf/p0071-sort.sh       |  52 -----
 t/t0071-sort.sh            |  11 -
 t/unit-tests/u-mergesort.c | 168 +++++++++++++++
 9 files changed, 170 insertions(+), 477 deletions(-)
 delete mode 100644 t/helper/test-mergesort.c
 delete mode 100755 t/perf/p0071-sort.sh
 delete mode 100755 t/t0071-sort.sh
 create mode 100644 t/unit-tests/u-mergesort.c


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.55.0

