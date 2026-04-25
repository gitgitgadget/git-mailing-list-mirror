Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA3829A309
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157650; cv=none; b=Z/n/eGrd4dH5mLv+ldKYSfj6qI+BsjOgChYAyXU5drhZ4ClfKEvwndiWzO4TV8DC0osnNxBWw4Ok31GPKGIuwGtaWYWGIpm5Mwfra7MIcB6YTNqF7N4FS9eSZI17fajEYLxAhBNfL+aEcTOBVqmABtpM2gD3bYSmjf24tgtv5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157650; c=relaxed/simple;
	bh=6K1fsNDAnEOB3jgekCCsA+Sy+KtEsdwV1y3gcIS5WzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ip1EXghN89fQ733k0gN7r2CLgcJaQHlqwCfyALMj2LmIlXtFyezFJJvGsZuod5GJU+3I5hy2LlAgooF3555F8pl3oj8ypSqUGRXcbWURzvoF67JE8mdb41aiRfpsEwIExBw2C1taGrHF6BLByPi69hnajISVDrcL00WUJnKKzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coTEU9Dd; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coTEU9Dd"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a62a049c1fso6222726e87.3
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777157647; x=1777762447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq9oeSPRwR9l95k7AHmOWuoKG8qUMfGs1sXAy0GtVOE=;
        b=coTEU9DdP0fyBy4flC8KaJP7mKvSa0Aaxm6XIQ7FnRgcEZBLsQozciqlR028Pq7ZMm
         yQH6pZAkp0RGQZWI3amfvBvXQ9Bug55OmGRdPXIsGTL8iczHuCOw+WTKCNjXJ9G7gqmY
         g1QVdn/ZEu3SkoOMm5+mWWO3A37hiZpVhaSVPqDB7xZTWNeXEU3n5jZKsVwRTMvvcloH
         bcDOVGF0EYfnXN/5qaJ85p1ulumASGI3S49vECDgk+Ql3ZnunC0FHtOovf6XLnlLJc9Q
         WhMaJ0i6JX4pgNMsKSZD7pqumrJzLYfgRHOXm+0FRu9Flw4nCk2d5KqOom4hUQBlb+HZ
         +a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157647; x=1777762447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zq9oeSPRwR9l95k7AHmOWuoKG8qUMfGs1sXAy0GtVOE=;
        b=WrknaCbo/6AIO7X69wq0CCMQn42t/4bBUATt596xScQP6sk2XTjNrFHLjbVsDwRWiF
         d5Zj5aZyEq3ajhoVoLrnCeur7r5QQblqBb/dk3s8H6y4Lzo3i+aSxjATQSeB3mA0ozqs
         oq4UX36HROGKhvnQibt4bSmicGUp9O4LoF4BB07aB5s0xrQsbyAGP5riVhFuBolk7Fd3
         q3fBEImcRQjdBIPTaBNC0KQ93XT2ZWSm4o5cVDoqaESNvkqVsjyG0QF9PQovFgQlYgNw
         4WoTLP4DXm1INXoWsfHGALrbqglL2Hvxhke2Igh+VZL5Qg1N9ivIR8LqBdO8/mD9JzIZ
         9Ibg==
X-Gm-Message-State: AOJu0YwXMf6RAKi+sMphNXoR2bNGZNQLhEA+lpeAwFgZ8sPmDSDFskeS
	QR/GbS2sGR1Zsr3PQD9d65iPc+RaJDOTYcySmZAWIlsLo/ubZp4UoaZW
X-Gm-Gg: AeBDiesIE2YRQQgvLiCbFBDWXmQ8kzdlRECp0+VOmTcG1sVRXC1C4To6TcjUnWhQQp7
	1Se2UguP0iHHaUKPM8dxfzJTTs9L/iABlSfHDtC1jUOCxHU/KBYAh9LTx+vl/JnYj2KGhVWRiTC
	r1umCt13XzL0+XetxWzCHp0Y/f7iVU+gW2sp2WShya9W/AhIuzvHQzV5suVyZk/LtQhlIlddVcU
	Nj9fcP7mGcfEHV0UaET1R9ok7P7B8nCQL0hyzxiCpDuvxbbCZc6QqxpxanN/yn3je8vxhaXAB5c
	NMzYTKYSu7sT2JAB7rcJHAgFDMUbZWHHRHV7vFH2MnaL0jolKgcxzcacP8pJmz8Uews/Y7a2hvw
	4kCYsadCPlqrNOPB/CX+bMH2CrRaei+zaeFPKi4mN2dD62vKaFH+gD7zBlFut3Wom9xQN/lNAaC
	tl2ddLZDWXQYRVq+EF4SMpX60RrOWKJ6h5epSCWp7rnokFJlIQqbpHT4IXaDMmYvFfjq2q8wNiu
	4MJmyNQuwRfJcSq9D42EA4WLSc=
X-Received: by 2002:a05:6512:1594:b0:5a2:bb45:7f21 with SMTP id 2adb3069b0e04-5a4172f6573mr11444534e87.28.1777157647148;
        Sat, 25 Apr 2026 15:54:07 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187ebe31sm6927795e87.75.2026.04.25.15.54.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Apr 2026 15:54:06 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: gh
Date: Sun, 26 Apr 2026 00:54:05 +0200
Message-ID: <20260425225405.7915-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <E5737766-2A41-46A6-A3FD-530CAC5076F4@gmail.com>
References: <E5737766-2A41-46A6-A3FD-530CAC5076F4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Isn’t that exactly what
> 
>     git fetch origin main
> 
> does? (Might need to expand the refspec.)

Very good point, I will update it!


Harald
