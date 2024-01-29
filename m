Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32076054
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562256; cv=none; b=YR5K4YdJ4U88KsUcldVQoMDyZ2pG5oZ4vSz1AA/f+c6ISfPfoVHjXMDuHyTuNwyhQ9Xh+D08nLBse8X7WsBQ7iFnIVhcq8JrXdRtl2+fDS5r1NXY/hfQxFHDsg7dxf+CEn6Nlvp20ALCGgozdSuF0M+bfz9v2W8Nve0m9u44qUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562256; c=relaxed/simple;
	bh=kh5+iwMb0f+7NZ72X05o/MEsqViZARcLigvYWk299jQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RTtkuUPNXhGvn/juhmBvJw27RZsPq3OQitWOjSDxRWfaMVnOAUiHFWvD0z2jSsQOI3NOq62JDUUoFUNGzaB4JpVk3XjB6p7Uby1cbfI2vqHes+jVeXaSod+pRRk7lbvuDmr/jOYsMm26/60XVBqi/mNLxXODMjtpyocT85L9Mjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLybPSB/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLybPSB/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so11343465e9.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706562252; x=1707167052; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNXdXOImve9RF18ZlC8b864P2ykUXbZ4D83l1zIVg1g=;
        b=KLybPSB/5aOd332UNHyd13tHqQzITxm6xQNS/NEaNrRWhUKGr1yxWfCWDD2dlacMbS
         OLFkeJ4BxH4O13WAddfKBr4MkMQ3htbNtgWAIwwQegga2baj1ujdshQM1dUM4BZZygrn
         xEWCtxlX+wtUSmXazOrtQwJu5NVil4IG+LWizOkB6ltsSFHr89xCrdbLENmh0ln4IVdE
         GdiMbzCqskFugIXjsWvb8seFs7sy5Mix8vkHhpHfSfATo5G4m7jF1jDywRbHclpyiUER
         jVThUV8UOLrhY9m+nt9g89Xggk/NcaLFIGi72SVj40YUaAKh8N3D7pW6ZZCElJD4K/M7
         8z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562252; x=1707167052;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eNXdXOImve9RF18ZlC8b864P2ykUXbZ4D83l1zIVg1g=;
        b=B3TwnNVVrPcRNUjm+5UHX9/MfMqu6e09gcfzT76WJy+3afa931uxQL0AqqVwp4sxmB
         xKGh+h57WxY8ebhq/J+ZXF+tBvjJm+7H2GJ+UJ7P26Jpj0TjzRNeudmuH1wNXbOwDo6s
         Zir5x/UsPYyyVB1dIFBWkC69SRgcjHOa+Pj4XU7eynHEydqN501kO0g++gUE15iO2QZr
         PfCAKoTWZM4e/58/VlszA4O2BZm5QjlCpqPBFECs4Shd48u8tTY1XMS8Cynjr8s1lT+H
         m3eP2Ju3oMFt8Yq008myDnvM2G3vn/lXRVjEyi2WmcGzScMCX8azmqeE45DJkpTOFCmN
         KcVg==
X-Gm-Message-State: AOJu0YzcOcs7ygVB97p0/rNAL2z+Lqt43UOcoD4xz4FRKpCMk6O2U6UX
	d/X1nGt2HO+kKVBk2in7ewsUwqNxdU28nD7QictuohPP2kLBFmqnp5yFdDnG
X-Google-Smtp-Source: AGHT+IEsdIByrmaJS2ZAwc86BKhQnekpRlI5F7GknTK/dI+BSfW2LvSVYS9GcUxRRkPKj+fsL/1cFQ==
X-Received: by 2002:a05:600c:5492:b0:40e:a44c:bff4 with SMTP id iv18-20020a05600c549200b0040ea44cbff4mr5760137wmb.28.1706562252423;
        Mon, 29 Jan 2024 13:04:12 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6244000000b0033ae4a3b285sm6589647wrv.36.2024.01.29.13.04.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 13:04:11 -0800 (PST)
Message-ID: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
Date: Mon, 29 Jan 2024 22:04:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH 0/4] mark tests as leak-free
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The tests: t0080, t5332 and t6113 can be annotated as leak-free.

I used:
  $ make SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true test

Rubén Justo (4):
  t0080: mark as leak-free
  t5332: mark as leak-free
  t6113: mark as leak-free
  test-lib: check for TEST_PASSES_SANITIZE_LEAK

 t/t0080-unit-test-output.sh        | 1 +
 t/t5332-multi-pack-reuse.sh        | 1 +
 t/t6113-rev-list-bitmap-filters.sh | 3 ++-
 t/test-lib.sh                      | 5 +++++
 4 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.43.0
