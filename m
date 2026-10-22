Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664918;
	b=IAEXmqiVlWxcQp10bjZ63B7vWYipfayiyZKPVywCZYh1nMKUyHgkxgRFvbNOtAGhcmSS
	 iN/HgR4dDZqe5m8zhws0ueYFzpdHH5J5rPqW1CXvnNcH5PYKs/uAPWc6aEN6DkjWvCZVG
	 T+3bOdjlS7iVnF6357ituD53swviqNbGfoqbcycKamwIvPFivXbMWupdpRcCP7IWRlhh0
	 P1LbvF5Y+rBqx4EPtaYl/dcQmurWYYZG5gqkcz43nDW+zjU3HPx3pLnkTNhMCHHWHpCqS
	 Vugz3WtPQ5Revq8/vrgL4IRUe7FqX/qTJLyV4T9Nxzy6KLuo3ARwpPHLbUyheGhBxfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3zaHX45SkEH8fQoNGzdxA7sOfEJJos1LXSVcnAJyy2Y=;
	b=zEdWK3Tyefbhwi1R3ziFLLwDKNr8GnXBJKb2+o15ukpuhdPApO3x0d17Px695gtUqFxX
	 YCdhZUheXvGPSmhgkbm0RV92kuFNeA5hfjp/zMgohiibz0R/E4pRU6BgkwOeI+KA+N+Oq
	 VYeVBLqUH9/AJ7pyHOzUUuXh5WgJf2oYVoPPRMKrDhoN+BdCWmMdZVGs9itULpd+lVb9E
	 VEfdBSlco9jMcXpjC92yTaphYrDs2cyWddFeHqEp3busOkHwjAM3Ga3zAbRHP/90Mwavr
	 MvHOZjYMyWLKxZlxvlLC3HxSk8ZWDCWgcPxMI3RXnfuwRI1WvmZGLTIoiFHXrj3SGpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MRE2YM52;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D98606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10D98606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MRE2YM52
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso1093566f8f.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664916; x=1793269716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3zaHX45SkEH8fQoNGzdxA7sOfEJJos1LXSVcnAJyy2Y=;
        b=MRE2YM523+kMtFlfQ7Wqua3CxHrqUaRTerxbGu8OSW6uBxo/v7wl7JYVTwmQ+bGsO+
         Sb59+nv6uJ9o/kvvpLUg8stfW3cdDKDEmrJ+fKlf26/JKqBxbTVKqZgDND7U5A6o9r1V
         qPD5G3j2fFwTegtdEAMtopcOzb1Ldff2rEuJ6NyKtwB5ByxOu7eWOOS01sM0uk7t+yGN
         36oQwR5IocnLLd0OaohGLIbtPr+/RVpIF5HTG6zASOJb1xMp0bM4Ptc0WdANpK44KBJZ
         Liurf1sz1vlyYnefXb6QLojeSBE/wTUswj4aEwSb8irM2gS4Q6YXtqySyPxH4XLCYw0U
         PHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664916; x=1793269716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3zaHX45SkEH8fQoNGzdxA7sOfEJJos1LXSVcnAJyy2Y=;
        b=LUZxRBFVKPWGt66mA9vErTIKcnaRygys0jP48RPufT0wtW4SSt7g89nhJNyNea/Agk
         K04TDxKzEy/Jk80YqvM+UY+e+W2mpdDq6iRA89uhSBJddzqNlo2jovuUNJNCK07p7pB5
         YnvhYviu/QZE7a4z19nTx+qPk34lszSm8iTqmRsQyOlUkRpbjUHoznMbz3qDZ1hCi+Ec
         dHe6gpHatb5SZD6Eh7BIH58qz1OJf2yQPSyVu2GsUJQkrI5zkIVAe+ZNWZNbKoJa44Z9
         6NHYY4cQWz3+b1KRZNpQ3Mj4yrMwLIFOtap+njPhxqLhQA1AGyPlQ9A2KhkhuoWf8FSU
         aU5Q==
X-Gm-Message-State: AFq9FYJMdn1ND5Ympb+3M0M4XXVAURkmqyHmg2fyJpABSuOtL04qrzXc
	LQO67GNBc/CJCYNkO/KwI20S45+oCOK38R9jgPqrBBbXDbY0c83rmr0z
X-Gm-Gg: AYBFou1akuppEexkqQYmDnQSNut6hq+ztkHVVOYmX9aaG87vwXt8GBKOfMztuJOwytZ
	tmkECPBNo9epXvQhY85uTNBixBqehTsVHBul7yb/QIZ1fZdbcPLCd0JbTSRTHcdTBNjecCT7ncp
	kNRduwvosen+rA3rFBtjlA6wws3BK+8rjMbcgo/40AxXLSsBFZqVlEUG+egOAJsBWfbuSUOAmgp
	IqJyjFa0yHim3vAsaX4GXssQTPz9p51KWVmrlom7GXjn446r4l5h8zLP3pFk+THARIjkCBui6SL
	0qhh2FAOlk/D9KeDgt50hujNlYD9kjRRzlnjs0SpJILIw7diuqOXLoQRCRbiI/m4bH05vvgCnfg
	GOdFYRvi69bZu8lfk68hxqdIrkL1pKMJn89ZarUqO/OCp1vfj1MRtWHjfcMK1i1IvwS3ci0fNiy
	/5F/y2HgxlohkRQPVg9LhhYOG/nW3KoslClLPsvsYZFusO+kKKw2Th9ehPX0xAIc22QA901oQ4V
	R+/etm8FHPwXy0F/oWfWjUsTfVh+b4BrBuy8grmf6Op6zc+gbF4k25n+RONkKTvd/mb2DmGVVJA
	ypxl
X-Received: by 2002:a05:6000:4a0e:b0:48b:f93:3b87 with SMTP id ffacd0b85a97d-48e264c117emr9327551f8f.30.1792664916089;
        Thu, 22 Oct 2026 03:28:36 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0b1sm11789537f8f.9.2026.10.22.03.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:28:35 -0700 (PDT)
From: kerylefondji7@gmail.com
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com
Subject: Re: [PATCH v4] archive-zip: refactor 'path too long' error
Date: Thu, 22 Oct 2026 11:28:30 +0100
Message-ID: <20261022102831.656-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqmrs92y4c.fsf@gitster.g>
References: <xmqqmrs92y4c.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

Just following up on this v4 patch to check if any further changes
are needed.

If the patch looks good as is, please let me know if it would be
okay for me to start working on another microproject in the meantime.

Thanks,

Keryle
