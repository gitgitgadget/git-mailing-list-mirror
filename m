Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BAF21B9C9
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483027; cv=none; b=nJNLV6WSXc1FLpJ4QQEEsB5cH+A8Siw6jWZkSJZP/wUs6kFAD06Tvl0IPmpg0yy5Ob97Ajx4iEVIAqNp2wrF/neU9Zp7lK2U7zT3nvx+HLfrMgoscmQfrl28wWp3qaKjVtAMcDtv8rF04UHiXuoHzpo4V1Bhw9K3fj4q4kYQ7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483027; c=relaxed/simple;
	bh=qVY9KEjsQUo2lTPSAE3Dkn4VwEgRiN9xkiVi/oY220c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GF3Nx0UzvAhtOqSEWcg4KZjTLO/CJRcMmASIzoHUCAvfU4Qfe8zrWLg0MIkIP27ruEbsE/ld1Dy1Uot6NUOPslRMfROoWc2E/MndALRZnKDoAndtL3j53HX1BYTeNvIJoS5L/mTP08TeVXaEKwkH/cIG236pGaKpBn/zDB1Dv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5rIFGbz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5rIFGbz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so5611115e9.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 05:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768483023; x=1769087823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+GF/iFqmYang1B2wfsbj5ao19GLWJjp5y5RKrWvoD8=;
        b=V5rIFGbzXe4Ih9NYvVp3FqSxXh+n5GxqXkLFqPJ/BfufNBpxKCqcKauEWGCiOhDzEb
         t/cdi1QxI9TuvX4xi/YHY+9/q4xAeGUOTbJ4QCgApbBPZUm3aEcYn3ig+Q1keOnxkuad
         XLqz7xT4vWclzAa0l6Znc30xpw8f8+XAPo6y7HPNx69U8t0heUidtj7yT86d987tArgU
         dD2mUHO+rLN3kyUwWtl8CsEuqO277D3YTQYR59WrdxKBxEPm81VNq48rOtEgXizqpsdk
         BUw9dIYHwjDPKq4X26MMktcNAHLkhq80MPCz9z0WLg4pP74SmfwIZ3u89W2MRYucADIf
         uGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768483023; x=1769087823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+GF/iFqmYang1B2wfsbj5ao19GLWJjp5y5RKrWvoD8=;
        b=LpOLd7p9PwLABgUvkDDaf55iC43ZaPAH5AUBcFbhPib38aR+Dh8mL/IusVfytYlaMM
         QjP85gHkTm8LzskIJrW8KSd8SZD2rn92l6cxjIWanhVmeMW+qUz/fHLDZATn+wE93PmB
         aEzcOsln9fH9/oLxnqYqZtGXes8/KpEV4a3Q1gwuIhVuryIyx81qPEsSZgBMGHM2VWvV
         vY3t0mPDNEEvBQZ5S4gHoMHOSGgqewz7jILuPv5thfUQPgNitQZq8xRBrOfmpdQY54H3
         ofpzBA2/jwhupfCrBNGvqUNSS/QN+5FfHewvOzxzgdxGb4alzFhg5gUOVbnG5T3cNaWj
         Twsg==
X-Gm-Message-State: AOJu0Yw7xSRBOdluVbfltDp5mnZtaDvPWPrEon7D1tbeu0YkQU0XjGuT
	8QzkIlMOEDniXaJ5Jl42AZbgawoVW35eIF+/7oSVtQM2N12I7qoHepTcOqwyJA41
X-Gm-Gg: AY/fxX4k5IX/md/bEQ1kg7vWhN3vvUY2nPrV2y2TLZhVjV92gozJb7Fd0JijoNGnWW8
	xLOXWMWz5rEB6IQTzocGOP8PD8pZtZM0TO2hoV4z4ThE0qIT/vmVoX0Ge5Huo7T9pWakuEzznn8
	OYP3UuUe9LsW3PUqRJ3vOPZnYAiw9BbvGJHe1rFgIqr/Yuc+VpgYu6/YT8RCi3GoiCjWK/t+hgv
	bviHqvoIwoB6plD9h2G2vE4MrIIe05key8gE1QBT2skbkkZZpE2fAQx5KqA9KH4e8XHjDuMSdfE
	VVhGx3w0/Sqh0u8EFOqC9w+0kwOaCRZ4l1lpO31qU7u8QXgmQxhvIsUV7+2DPQ7ir4ThJ3Psvui
	hE2oduj1MFg39JRM2EFfAxEtE91tXDy+NvRi3eGufs1TdE0Qes69ty4B6VUtG82nXMdrKbYwt91
	nO/+Y85X1edQMgAfsllLXsyBfWed6IoUuHyP1yvHUw
X-Received: by 2002:a05:600c:548c:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47ee3371876mr82080485e9.17.1768483022708;
        Thu, 15 Jan 2026 05:17:02 -0800 (PST)
Received: from localhost.localdomain ([105.113.70.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428f1ba7sm49882495e9.15.2026.01.15.05.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 05:17:02 -0800 (PST)
From: Seyi Kufoiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH 0/1] oidmap: make entry cleanup explicit in oidmap_clear
Date: Thu, 15 Jan 2026 14:16:33 +0100
Message-ID: <20260115131634.51968-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch improves the clarity and safety of oidmap cleanup by
making entry destruction explicit in oidmap_clear().

Previously, oidmap_clear() implicitly relied on callers to understand
how and when stored entries were freed. This change introduces an
explicit cleanup path, making ownership and lifecycle of oidmap entries
clearer and less error-prone.

In addition to the implementation change, unit tests are added to
exercise the cleanup semantics and verify correct behavior during map
teardown.

Thanks,
Seyi

Seyi Kufoiji (1):
  oidmap: make entry cleanup explicit in oidmap_clear

 oidmap.c                | 23 ++++++++++++++++++++---
 oidmap.h                | 15 +++++++++++++++
 t/unit-tests/u-oidmap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)

-- 
2.43.0

