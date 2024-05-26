Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ACC2F55
	for <git@vger.kernel.org>; Sun, 26 May 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716713070; cv=none; b=WOlpy1A5q691VHh1ds6BFnClWLrmHGjW0A1WnBmgGvNlX/exeQ5Z1HmKCIcz4nASVf5i88cUq3DNqZBN2J/xasJSKUFCGWf7vJGhCLEdJfF69c11kVIb1e6ytE7CHOW90zv5CbUD2OmmJlb10Vz3c1kkzsAH4jbFFJK1ytYyN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716713070; c=relaxed/simple;
	bh=epW9UjiDbOeUmRKwLtaINUJxhj6Jb8olRRtvqoZFBxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMXXQpKbFQHuAlQQ5nj+QEKwd479Z6vTFaXOQEjKsdkv6fP1Jv0RoVGj5PRBjCpiJep5awc5LGojrjqne7Dd/EAPWGzdxKmIj8oCIQf3p3zPGjPabFXKt4A9k3W04KOfNi+VAHRpIUKjFQLnK8DwJ/0AonA1bvJySucIEzCG6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e07k2xCS; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e07k2xCS"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f12171523eso4517031a34.1
        for <git@vger.kernel.org>; Sun, 26 May 2024 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716713068; x=1717317868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUhrkNRAuJu3g8+/fm4v0+mzx/XL0g21nKrmjzkwEKA=;
        b=e07k2xCSLBiDhdH9PU2Q9G2SPoAQnLop6FDF1Ed6CMi4AgJZLRp09bW0qx2UjVWo1G
         MuLgOBkxa1Bbu49senkXpAbfjYYtLHNb2T4p1H2C9xItHJTF+FYoRBsrI9b2er3VN86n
         7ySb4RDBTgd3E6t0ldxImelkvvt0Tb1oon6fUCi+fT7UpUyS/cCiDuSHwdq+DLWuc90Y
         5IbJbMtaFDi8vSd7vliPvcSEBd/O9SJjpb7u+e2IwZTOPzVz8chehTzoeQMJE6NBKxav
         miO+kTV4L7l+aBYfhBi1o2i/Iqq4xtd2A26sLLkhetwp12PevDTWoFK12jroniek3x3s
         AVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716713068; x=1717317868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUhrkNRAuJu3g8+/fm4v0+mzx/XL0g21nKrmjzkwEKA=;
        b=kjO855G43A4hKOvAEGl5Elit7DGcfuOnIkuzvxiCIma2zAcB5+JSTPvZHou52hM82e
         ChaeZNK3t+lfELSwjPAemJ1n4QPKTQpPP2MOrJxaSvdV75jhVUtfcxACfx/HNbpXw0Sk
         kRWzjBwPhR1qopIV9Qg2BSlTBbY2nQT47+SR5zhq7M0FMt3NfO0IL5nacpmVoGv16Vwf
         lr5E9Z2k7bRAC8NgAc6SaxWt4KNhLPfFYKQFVg944Z+a5Z/+4sEjEvhKMsx1RZHzw2qR
         sEZX/VWhFfz1V8iYjp96j4ZgQwuaZ5JOJGavShLl63hnKdHWkeKjMCcqfH/WGrdPECjf
         a1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBIa5hXj6xPtex5R86ZlEekpKRwbna8PAkR3Sk1oJFEtIZElSBT/rp1kEReraAXATXnM7NI/VJgIerPNG/T93Dgw7E
X-Gm-Message-State: AOJu0Yw9znyMLVyK0yQdmHhHbiqb3voWXuZVVG//cLiKLGfJzJEYyGsn
	npCW59EiJWlvtFWHGZLHB2LgT2yxUjlPd9isw7SqnnQRUlEzxI2u
X-Google-Smtp-Source: AGHT+IFAa3VvaA74orKhrJVritxjyvaYI7AU5lGPkmjoybzzGRSwWVlD9JLNk8zjFP/qrHR2y4Z2sg==
X-Received: by 2002:a05:6870:b629:b0:24f:d9de:3bed with SMTP id 586e51a60fabf-24fd9de3d03mr2781958fac.41.1716713068088;
        Sun, 26 May 2024 01:44:28 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcfe64a4sm3274488b3a.158.2024.05.26.01.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 01:44:27 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: shyamthakkar001@gmail.com
Cc: ach.lumap@gmail.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im
Subject: [PATCH v4 0/2] t/: port helper/test-{sha1, sha256} to unit-tests/t-hash
Date: Sun, 26 May 2024 14:13:43 +0530
Message-ID: <20240526084345.24138-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523235945.26833-1-shyamthakkar001@gmail.com>
References: <20240523235945.26833-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
- introduce new generic macros TEST_HASH_{STR, LITERAL} which accept
  both expected SHA-1 and expected SHA-256 for the same input, according
  to Patrick's feedback. A partial refactoring of check_hash_data() was 
  done for this.
- As a consequence to above, add a missing SHA-1 value for 'abc...xyz' 100000
  times, which was present for SHA-256
- improve the BUG statement

CI: https://github.com/spectre10/git/actions/runs/9241430375

Ghanshyam Thakkar (2):
  strbuf: introduce strbuf_addstrings() to repeatedly add a string
  t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash

 Makefile                    |  1 +
 builtin/submodule--helper.c |  4 +-
 json-writer.c               |  5 +--
 strbuf.c                    |  9 ++++
 strbuf.h                    |  5 +++
 t/t0015-hash.sh             | 56 ------------------------
 t/unit-tests/t-hash.c       | 86 +++++++++++++++++++++++++++++++++++++
 7 files changed, 103 insertions(+), 63 deletions(-)
 delete mode 100755 t/t0015-hash.sh
 create mode 100644 t/unit-tests/t-hash.c

Range-diff against v3:
1:  cd831fabf5 = 1:  cd831fabf5 strbuf: introduce strbuf_addstrings() to repeatedly add a string
2:  2c4471ce37 < -:  ---------- t/: port helper/test-sha1.c to unit-tests/t-hash.c
3:  68dcf388d8 < -:  ---------- t/: port helper/test-sha256.c to unit-tests/t-hash.c
-:  ---------- > 2:  ea7e171014 t/: migrate helper/test-{sha1, sha256} to unit-tests/t-hash
-- 
2.45.1

