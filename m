Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5E2045A3
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526867; cv=none; b=jnJ7rQxrovbk4j21tQHj0hvSx/A05OgaXWvRQLeaBfJLhvnAOGhTC1hZg3Nif4hpYrrfS6At9OODgW5zZhvu4FwC4ANG2AqbppQpOHRGI3bSBYHQDrqmlukTbXOX8t+/T7kzC2jF+j6dtLxn2rz9iId63r18UMeJcRLQmpK5q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526867; c=relaxed/simple;
	bh=3FwfntlLxHqrY9K7KsMuxfPvnXaY7FstBQ1+/hAcUmA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NS5rsPP7BdARKzZFHKnDscqaAKZ6KkCOggo1ZefePC6quJOUrnemCozd1leRx7e+/OlfTDLd/NdR1EM4DluWBaMzqhR7ndqPpqxfLqRDSpU9FOL8PfCtGKC6J5L/wlSwUPnXDi1KW4aWj/cw4KRJtQjwBjUVnmu4D3No2vNNZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEwcEC8k; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEwcEC8k"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso9394703a12.2
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743526864; x=1744131664; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNUTWK4nsyFiY0UvV48lxGo+Ul2lvtndJvE3uvF+6RM=;
        b=cEwcEC8keba5oIo6aTQNcuQgNXEtunfWWiW9JLI6TScLwS7QxJNu6qKTZQyCFAOWot
         IhxWKQ/+jFznSM+5cvJKjCWq8gI3JlZ8g4NUoMJbe1GhPmpY7SwsUJ1Gflpv+/e+IPUz
         7bseHVCJwU/4Cdf2xCwBz+6nNYfdkPk+DkeInmn9JxozqjCfHTNm4FVOXNSIz9jhmYF7
         geXUcUskrG4xL93RWDqRME2ELLfIjx2PDYg+lw6cqD6+C/hf0D72aQBgnLeSPZzQ3XVZ
         5HLXlmGlkvqw2XmACR4enCbrg0NtY0B35L7lDIFQEQQdFebU7UiUg9/rO3I/HauECwh2
         FGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526864; x=1744131664;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNUTWK4nsyFiY0UvV48lxGo+Ul2lvtndJvE3uvF+6RM=;
        b=AezmgR6FMCaJj4Y2dTfhbUEztkINq71giClM0fGTmth5ilzM7IxxcBnWsWU2V50Ofr
         JoEN9JWzugujGpdQmTl0N7JepL6P1ZCUFWL/i7HYCb3HUauPvPNKP8nrIyDU7K/+NMR7
         AIBblCzS99OkgWz5pUyo7BGypoIDrBaM/Fglheon5ESZnpSZ9ZhXKwVispGomfCmszJp
         2URONzCBNUghRbY04Egqqggyc4HLNK/zjFuv6DmNM8UE1JsfLUISpm/nFa2NLLA0r5C9
         6vEiW4quHV9wSn5du8pbjwtloMOXaQYRNHyBZ8vJRixRuVekZHpdKtVnh2ff594TIaPH
         aiCw==
X-Gm-Message-State: AOJu0YzoltloZ7ZI/aHZ8l0rL/3E7ruLGCjcWjuqxpmYarK/4JTXigMz
	0FOk8XL493JnzugRB0Mh9yHNcPfrGq3zx1j60B4lJ3xlf6mkJSZ9
X-Gm-Gg: ASbGncvCN1eUiUXknTCfcZ65i7+MUcyktG8b2hen4HudCP9i4+PKzp7E5RiN2VubsPa
	t3TCHEmLg0rqaWxkIyjhvc36NYPTIVsrCTOE0JrIKHhleHWODg5MOk3k23IDUvZ3GwleL9CNzff
	OM5mlOMM7oYJP1sdCOYCPqF6uaCHh5j/ToEWMRA+kHLSF/SqCcA8tkbjhchx1ir7uYHnpVioI6q
	iGMNhGnhw8kq0JyFeP2PmnILANcCofhReIhelP+eV0Patp3gr6bLeLNUIr8vMElRh4bxuE8mnoL
	unqV1haeZowB3sGj1tZN8weHXJS408TrHdbCbLRtdxdauXXz
X-Google-Smtp-Source: AGHT+IGJHRb2PsU6Y5NCzAAXcykNsL59ITAP7+3GzVCeA3rpWnlACINc9s8UWom7+LSuVF15jIgvwQ==
X-Received: by 2002:a17:907:97c9:b0:abf:fb78:673a with SMTP id a640c23a62f3a-ac738a3fb13mr1591838066b.29.1743526863543;
        Tue, 01 Apr 2025 10:01:03 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:90eb:ce:1988:2fde])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196dd46asm780219666b.160.2025.04.01.10.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 10:01:03 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/2] bundle: fix non-linear performance scaling with refs
Date: Tue, 01 Apr 2025 19:00:55 +0200
Message-Id: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-0-6d23b2d96557@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMcb7GcC/x2O2wqDMBBEf0Xy3AVNbQn9ldKHbZzogt3Ixt4Q/
 72hj2eYw8zmCkxQ3KXZnOElRbJW6A6NixPrCJKhsvOtP7VH76kPgUYojFfRke5PHWYUess60YP
 1S4YEg8YaTlxIs9IsCjZaYClbLUXQuWfEgDambnB1bKmafP5Hrrd9/wHm9SVgmAAAAA==
X-Change-ID: 20250322-488-generating-bundles-with-many-references-has-non-linear-performance-64aec8e0cf1d
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=3FwfntlLxHqrY9K7KsMuxfPvnXaY7FstBQ1+/hAcUmA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfsG82MiYlHkr6U7bMAOCgwO7iO/hS9zUYPc
 0jQp/8VlpaeDokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn7BvNAAoJED7VnySO
 Rox/MjMMAJSLgqCzYRz9Z636pTxMBtudxFrxbqJjg6dv6P8jWTIXLaw6ib2DtuotGy3YlicP/hV
 LVCIhLAs+R2mdvJKGzVitcDaUfpLko730dWFEUiFnYbz9OqNKLaYt71Mk8Y9NGU76lORVUyF033
 yG3tCaupQmEeGSpS4EZEGASD8SmexMmBoPnZaB+19+enDEp2wBma3MaW9Uj/4/66zHd9KfA6+3K
 uYp0lD5p3XPCREWoAxetqw82AyTcOlsTKBufUYRJoekpwGKfIHQwKY92hFkHlZl69ObgKP7jQJv
 Vo0Qt3wl6BVlJWttGHRSBOHPrv4oFm/ZPXNLho91Wsgfo+zXEQCorblHLzWG4bmc2NmBU9VWqcE
 asRG3C8UWrhnEtOiC4mZQ97PgWAu3vmsabEtuMPCzxrn/WnvdI6lxqqMXzYeUHdEAIyG0LpFYZ7
 Lk6UbbH+QgEJK3leEdrDHTJ9odf0s6VPI+EQZNvlyPFVvmjrana0zhKTbNi97VMPr8+cWl08HU5
 oI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Hello, 

At GitLab, we noticed that bundle creation doesn't seem to scale linearly 
the number of references in a repository. The following benchmark demostrates
the issue:

Benchmark 1: bundle (refcount = 100)
  Time (mean ± σ):       4.4 ms ±   0.5 ms    [User: 1.8 ms, System: 2.4 ms]
  Range (min … max):     3.4 ms …   7.7 ms    434 runs

Benchmark 2: bundle (refcount = 1000)
  Time (mean ± σ):      16.5 ms ±   1.7 ms    [User: 9.6 ms, System: 7.2 ms]
  Range (min … max):    14.1 ms …  21.7 ms    176 runs

Benchmark 3: bundle (refcount = 10000)
  Time (mean ± σ):     220.6 ms ±   3.2 ms    [User: 171.6 ms, System: 55.7 ms]
  Range (min … max):   215.8 ms … 224.9 ms    13 runs

Benchmark 4: bundle (refcount = 100000)
  Time (mean ± σ):      9.622 s ±  0.063 s    [User: 9.143 s, System: 0.546 s]
  Range (min … max):    9.563 s …  9.738 s    10 runs

Summary
  bundle (refcount = 100) ran
    3.79 ± 0.61 times faster than bundle (refcount = 1000)
   50.63 ± 6.39 times faster than bundle (refcount = 10000)
 2207.95 ± 277.35 times faster than bundle (refcount = 100000)

Digging into this, the reason for this is because we check for duplicate refnames
added by the user. But this check uses an O(N^2) algorithm, which would not 
scale linearly with the number of refs.

The first commit in this small series adds a bunch of tests for this behavior,
while also discovering a missed edge case. The second commit introduces an 
alternative approach which uses an 'strset' to check for duplicates. The new
approach fixes the performance problems noticed while also fixing the earlier
missed edge case. Overall we see a 6x performance improvement with this series.

I found that there is a conflict with 'ps/object-wo-the-repository' in seen,
the resolution seems simple enough. Happy to support as needed.

---
 bundle.c               | 10 +++++++++-
 object.c               | 33 -------------------------------
 object.h               |  6 ------
 t/t6020-bundle-misc.sh | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 40 deletions(-)

Karthik Nayak (2):
      t6020: test for duplicate refnames in bundle creation
      bundle: fix non-linear performance scaling with refs
---



---

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250322-488-generating-bundles-with-many-references-has-non-linear-performance-64aec8e0cf1d

Thanks
- Karthik

