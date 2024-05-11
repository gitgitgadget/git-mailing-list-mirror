Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382C02F26
	for <git@vger.kernel.org>; Sat, 11 May 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715428547; cv=none; b=K6KkYRUBGDrhNhBYM4N2bFB4ZXkp73vcvaaS7rcBzirFMjQXX6A/kmrmbgmeqaJOvDKlDjQKbVfjkiY0NPlvkwDz7kxABYOtfokM7JJglAKTDYc4T5kT3dWCOOjaXWg6bmtxsLckHwWs9Eh9UMsYFCRr25KoSmWIGqO0UlxwrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715428547; c=relaxed/simple;
	bh=pcZuHD41n8wMUSpqGxIwb6Ezbqeto+hrBe71Yd9ocKc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WnR3FNcJ2pzBoC7t/8rqA21DYjtHQQDIoj4FrUqd7uMow9nZTzM2K0Uv6DaUhXcmNHgHhOBMpEtjpU4hAUvjkR1s9ZTzbhbsi6PYvY0kCHOmVUgafIS3tKEwDsi+nxi/hAFqIWRi5JLUcU7tIBgiUNQFZyW+ZoXvnjqsQo31hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5KXQBam; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5KXQBam"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41fd5dc0508so17079575e9.0
        for <git@vger.kernel.org>; Sat, 11 May 2024 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715428544; x=1716033344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlQwntZlUo6eYkg9Pc/Bs0tLBe4FbJGRuW8Fz12Cfsg=;
        b=Y5KXQBamf29NH6NjI6G4NJ/Y2Y0/03NK/QV+rCz4FB4alC3fcdAs4WAlIcmOKjXusz
         eXfEzleD/EjqlneuVV//3wC1YTVnYkxjFGJZdWmnT4sVeEh8laYQYM4EiXEANQhO9Vzg
         KDfLDPoEYJRx6HVeaR78z0UVGT8pO1TaEjvXRkZYgkdBVQZUK0xLBoQpIZ8v7W9iXl0S
         nBu4/XCY+K3nwBNGAoKHRRz07wEU4DUm06Qxbt9kyfBIL2laql1utns4+SgAGq901W6O
         4/AHbIZYewJSfnJEhxPeJV/gN86q+j3pU/bZyyDyMIQcKwhkirxnemccp5sLAAcitHlQ
         iuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715428544; x=1716033344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlQwntZlUo6eYkg9Pc/Bs0tLBe4FbJGRuW8Fz12Cfsg=;
        b=bka5NTiDKdS6n94fvHiNeu4S5Zjpx90JoJ8mmrFFqsZIxnihdwnL9YZKhuBN/UOvVX
         G1uiDSkVrVsnxiAx+8kwtqzhl2wf/4jhqAp6n9Jkgfy1k3fUplDT14BpFxB5CUPitFUz
         PEWP4wVclMVyOPYL6Yqo29alB6bx8KOFmCTnUcU73d3YM9BCSKxlwGpoo2f+2Qdu6MBW
         B44TejFwgm5ZcgtXLwg/8wMWPtbTfSY8J+AoufwU6FkMk4iWo7XlMMb5GntTZzI4Lgig
         s7kgLzSlT7AT66a8w9ZVQcXzEaHtQzTS6R8SBlufHUfDhwvrebBYS0UQik6nGAUQQEd5
         HLLw==
X-Gm-Message-State: AOJu0YweVrL3b3KA+BwVtX2vtjhI37KgyGFoGwpF6RNxM+SzaxG2P92D
	3DltRPGAU0QTenI/udxeq/fVe6Rgo4dMtB7jIWiDWveoXCs7ebB7k1i8cA==
X-Google-Smtp-Source: AGHT+IEZZzGRn/Eic0PIHDQTjtzGoChBsYazgFMR6ryltBNKgP6FAgMQALSeWRQnChH48ZaY/Pk1fA==
X-Received: by 2002:a05:600c:138e:b0:41d:7c48:5558 with SMTP id 5b1f17b1804b1-41fea932047mr42400735e9.4.1715428543706;
        Sat, 11 May 2024 04:55:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce73f5sm97703035e9.21.2024.05.11.04.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 04:55:43 -0700 (PDT)
Message-Id: <pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
In-Reply-To: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 May 2024 11:55:40 +0000
Subject: [PATCH v2 0/2] osxkeychain: lock for exclusive execution
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
Cc: Bo Anderson <mail@boanderson.me>,
    Jeff King <peff@peff.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

Koji Nakamaru (2):
  osxkeychain: lock for exclusive execution
  osxkeychain: state[] seen=1 to skip unnecessary store operations

 .../osxkeychain/git-credential-osxkeychain.c       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)


base-commit: 0f3415f1f8478b05e64db11eb8aaa2915e48fef6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1729%2FKojiNakamaru%2Ffeature%2Fosxkeychian_exlock-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1729/KojiNakamaru/feature/osxkeychian_exlock-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1729

Range-diff vs v1:

 1:  309c17c78f3 = 1:  309c17c78f3 osxkeychain: lock for exclusive execution
 -:  ----------- > 2:  1f57718abff osxkeychain: state[] seen=1 to skip unnecessary store operations

-- 
gitgitgadget
