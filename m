Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B553D648F
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033940; cv=none; b=VeiJTyZhgG6YxELe78V6k1gts9M/+gfFRwUehB2Y6H85he0tiFkbrLjtPaKwrOrKj4c+ctLBmR4yse4+3/E/FmIKz2OyAQ0V+84cLjBaD0va3Jl/Wk8J5YLDAmKW/w8Vo1rnH1pM8VJe8CzQRvtBu1IE0H7Lo2DnhHI0gMAnr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033940; c=relaxed/simple;
	bh=UjjOaOCmmzEs/2VE4NwZDK0kgttlSfiExqx0xnunL/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWXBrz2G0PghNPcZeYqe0VUr79X/0Gr93rXmOsPXUlUaQWlYVJpzmyH/z50O5igDe5CLCBuRcAOsOjyfZe2J96zEdtc0ZFg2pRoQw3ub8V5YfYmT/iq4cSVVaDtJrwOOaLTRAtbBQqyRlMEHuRE1XO4GdD0K+W0lwJfaTs6WVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkAAva20; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkAAva20"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adc1d9ec56so9441835ad.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772033938; x=1772638738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjjOaOCmmzEs/2VE4NwZDK0kgttlSfiExqx0xnunL/s=;
        b=ZkAAva20Jn3fRxVfMqMwd4yTyTowQaMdMGz5LX30tTcyd8JWKvG1T5Xv/09Gps6m60
         wCYtKsoKzbbNkRfpvNXHBbkQALi4rUOHwJlOP7m0eFU4EMcLqPirZrALxbXPnlbazhpZ
         LDczzZDgi7N0pA37qmPhpohm3WgWLvVbHGugNx/RCqVSYQbrR7zq4+Pn6UWroJ5ofHuC
         OW8v5Sq06Lx91iwQvTVrD3rFhWbIaHFE+tRlK4QIFOU1KYmOR5SF32gudQ2UqOsu/V1q
         QWkmossWDlADARWEkiaxbzlwJ4ih8cRd1wY7ZRX2RQ6W7CaXB6PDLtUNjGj/DU/82vS2
         +6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033938; x=1772638738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjjOaOCmmzEs/2VE4NwZDK0kgttlSfiExqx0xnunL/s=;
        b=jjGP3FK5vkK7fxYpOMM3U2QsEPfR+vjSfuwkENs9KQb1iq5pwcHJeW8IP8bYUz7bMr
         Th9F+0HLNxxfbx5mbfNQblodhzyIiMPxQmg3fFWF2VrJhLxTFDNLDfnsN7pWj0xKW4/F
         +EPeYGdzeCkhC8a11+0H3QrSfVIny2immB3hDFxYmy+Q2RYT1ABWdUDIdsaVGJfp5RIF
         ONrwSp6ZQdY7tVaWI1T9qC2IhnH+hkVX/9F2XVHNZUeaK1eTat+CzVvvDcBArMH6xiiQ
         1jARxEDPrOooKiF4FuJJPM74skzFCeYqBEghmDcWUXzbyPwOAEd8jiB7CeCOTQdaa+wt
         VRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHHexsuP+8XSQ0pzTkv19jkRTiNOdFoqwD0l3311g4mgIdCdxP/o83AyOICCq+XAu2vms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Cj5KRAKeEm2fuMUtMukyCyMbAE5tUl12K+CozCyeXcU3KqOb
	uqfoRXx0sTXPiKqWj7By9b8SixIUjgB7hVlVn3PwV4aqfzN4G9La4/7U
X-Gm-Gg: ATEYQzy9nxjjXC8FdofCCelimnCrHxVgcMMbr9JeV/mM2bvDiTTdrxYXjDQEIWqnD0D
	7BPvc/ZGZbteg0RkRkR67wZzW5sYgvw1f7kmHDQ2gwesQt3ppUCdzr8wRS3mGdGh4+c9roQ+CNB
	8wXKOfdP2hini88vYSSUpWUDesNhbGna6808Ig9ZhGa7lO8VTH/mvbFQ6LoVpw9374XAZWxG28C
	Xd2SjfRpLFtEAFRsyDWRUGD8mInt6b06hcA45y0BUWPEekB3MDsMlmqcGQKg/MhB1iabkb/DPyG
	qLaVIpc+FDtqgzW2NFySOf8zRynQ1EXzP71sDwXz4PiyePT5RVciZsZU27UUMTBKQpRyFTIWLlI
	YiV7cwwB1UF47F88whee1PwLKfmrkNJrs0yk/yO3y0enkkZCvX8pXa96wj/Vmj22a9kaog8Itd0
	v+u+pV8mEcdzkluqE6KgGRpiPhBHV4XxlxYiPTRSkjr48P3JquJwxcUyAB5Gigj+Mxuhp1Oecd0
	BPEKrAgdh6cqXBBaDL91K+JIliObNskzX6h4lxUx/37Lzi3LNQ+q45GEXQoVkr17v7EvV+YiEQs
	c1k9MEo=
X-Received: by 2002:a17:903:1210:b0:2aa:f9d7:68a8 with SMTP id d9443c01a7336-2ad74511d60mr141466475ad.28.1772033938372;
        Wed, 25 Feb 2026 07:38:58 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1975:95cb:38f7:a991:455:152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e350cbsm144321365ad.18.2026.02.25.07.38.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 07:38:57 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: lucasseikioshiro@gmail.com
Cc: ayu.chandekar@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jayatheerthkulkarni2005@gmail.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com,
	valusoutrik@gmail.com
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to show all fields
Date: Wed, 25 Feb 2026 21:08:50 +0530
Message-ID: <20260225153850.9124-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <4463000C-DB1D-4DBD-A474-95BF1003D36E@gmail.com>
References: <4463000C-DB1D-4DBD-A474-95BF1003D36E@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Indeed, I also think that the entire "What is Git" and "Git Internals"
> chapters are worth reading by those who want to contribute to Git.

Yeah, that was my bad ... I should have read that before doing anything.
