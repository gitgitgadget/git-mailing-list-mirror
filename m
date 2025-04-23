Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5AA28CF79
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430009; cv=none; b=BlOqT1R2ztbL2f1yB+gGOm/5VZlSK5bwniTzJlK7kUiV/8WGVfDUlqToxtXVBScqpnpbAKbSiuB4dTa4wXDdsHuXjyPF8PRKQprjDWl8CQ47VsWoSWVF7Fh5SRDROafONnFkqGnsxABXFQ4NzP66kwHwNkj6l4X4N3J+C8GMHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430009; c=relaxed/simple;
	bh=JYHRRCtRXLFjsglCRSOld2D9tXkquWoFVUmJ9tpXJgI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ULR8qlRIllou63i4+vZK7GBrRBR79DVT7sTS+0cQe8aZp0dFZ440kWveNHyaSxX1+Y8nMtFccM7MiLtek2YQhwsdG6h6WIjNf6saAipTTskvEN9lRGxpdrz/ejsBuEh8fb+DqjbnGpi5b+44IgZJjkhy54JJfKc28leJzOY59ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGFFHBzS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGFFHBzS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-440685d6afcso1253755e9.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430006; x=1746034806; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jBDP5xBDuyTCtQuE7LRQKs3WGE6zDj7czIp7nW32bqg=;
        b=HGFFHBzSa5iBSrFsDUDOOnXMqpFacnBUQTWtC8e2QlEJh8FLb56zGa/Y3mo/6KDGcz
         lmYLmB3YHRabmDbI2lxrK4Vv3nXjY9Px5IvIIJMwHwsWL5p+HjO0OUe0IZCVoH9mXH+S
         JmuGlHh87LydIIeSbeGWIhN6h/8sMCZdzsK989kfJcgjce6qE5aWv5ezpPqoTrIBFAWf
         xNrKW2OeowpZ3gE987wkPbkjj8agJEsCpnE7BV69niy/spyQ7JoN0vAbuF86C+2T60rN
         cd3QCOpddXFJWacGWlreTVhV14Z6NfAcQLQ/yCWPbvMhygIfxkw1ukk3ywZXjQpuQRlC
         rzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430006; x=1746034806;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBDP5xBDuyTCtQuE7LRQKs3WGE6zDj7czIp7nW32bqg=;
        b=aDvgYiPnuwrr5HhpJS+1Ut7cUb4H7xCE9YhHM45EdMissOyMXbM1vz1r7ByPmnxYt7
         UE+NhuQ4fyLjp8L6MOvacUnNYx8TxkWN/mApIrX6PAhVKlG7G/Ipe1sR0mw1EniU/zMR
         bOEUFC+6P05yNVz0gERlqPGbXH28bYyNKjaRFHYVBk1jlyF1bzUyH8KxG1vxuHe2kprV
         GRnYdDxKci50eWnDO79Qzkt2f+g0nQvabeQ+mC5mZ7FqxUBy8yhccjgCeTwDa2vDvctV
         hzJh+jFH+68Bq25YtFfwd7ewKOfIfO+2M3Iun/8dltACE16TeoUicUa2hqxsvIMSKDyM
         cglg==
X-Gm-Message-State: AOJu0Yz7CBmk/JRelMFEtDDCFDmRYfOqr/L4DeakaK9AgrAibNIYhql0
	qRemlPwh6T8JuApW6MFM91gZUhBU1OfyGaXUXAZQNGr3/DwjuGmr4s9Pdw==
X-Gm-Gg: ASbGnctcK5aZWnkiFSECxzt35zf/l7NM9xD9+4+ZKKC/sUQG3p+vRkkkwJnPbCBNYCC
	+zVyx7Us/n5LCcRifEu5l75QBmsdMQiaS/3MgyLqpsauxKNJpp7ND4u3YQxGwCHiRhQzF6qZgfG
	siB5/bfoMSx2BdufipZCEopUo3PhAyzQ81I7N0vUE4cVxNipb74moHk34JFXQzXPzr0WjB8dASQ
	5UCOd9N6XemdVLeq1F8hMzfv4dQiShdxvQXM5Kfvq8/tuzcauPJmfeWaXmxcS6mRNSEPyTnGBP1
	7G1Dk6hUEA4mC3lbqHEvvurTAVzfYeKii6HsI2i6sA==
X-Google-Smtp-Source: AGHT+IEVjrNxEHf+CVpl7gxSOuWOMbvmVeClNklEo7UK0RUc59la2cY8ht52T7N/2X+1zxlukQb2EA==
X-Received: by 2002:a05:600c:3d86:b0:43d:762:e0c4 with SMTP id 5b1f17b1804b1-4406ac103bdmr158981875e9.27.1745430005374;
        Wed, 23 Apr 2025 10:40:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092dbf7bbsm32464005e9.35.2025.04.23.10.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:40:04 -0700 (PDT)
Message-Id: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 17:40:01 +0000
Subject: [PATCH 0/3] Fix REF_DELTA chain bug in 'git index-pack'
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
Cc: gitster@pobox.com,
    peff@peff.net,
    Derrick Stolee <stolee@gmail.com>

When fetching content from a remote, 'git index-pack' processes the packfile
content, storing a packfile appropriate for on-disk storage and a pack-index
helping to perform random-access into that packfile. To help with
compression, the packfile sent over the wire can use REF_DELTAs in addition
to OFS_DELTAs to refer to objects that are already known to exist in the
client's repository. REF_DELTAs can also refer to objects within the
packfile, though this is not typically done.

Because this inter-pack REF_DELTA is not a typical data shape, a latent bug
has been waiting that causes 'git index-pack' to die() even on legitimate
packfile content that it could resolve.

This series resolves this problem while also creating a test helper for
constructing packfiles with specific objects represented in specific types
of deltas and in a given order. This should make it easier to create test
cases like this in the future instead of updating t/lib-pack.sh through
other means.

Thanks, -Stolee

Derrick Stolee (3):
  test-tool: add pack-deltas helper
  t5309: create failing test for 'git index-pack'
  index-pack: allow revisiting REF_DELTA chains

 Makefile                     |   1 +
 builtin/index-pack.c         |  58 ++++++++-------
 t/helper/meson.build         |   1 +
 t/helper/test-pack-deltas.c  | 140 +++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t5309-pack-delta-cycles.sh |  36 ++++++++-
 7 files changed, 210 insertions(+), 28 deletions(-)
 create mode 100644 t/helper/test-pack-deltas.c


base-commit: 4bbb303af69990ccd05fe3a2eb58a1ce036f8220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1906%2Fderrickstolee%2Findex-pack-ref-deltas-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1906/derrickstolee/index-pack-ref-deltas-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1906
-- 
gitgitgadget
