Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845772;
	b=dU7/+BL51ydPePbFvTG5YRADcDkk+PwU0n7dy+mnJzXg3+bSEVjqr9c0AUsb1f0W2q5u
	 2W6LEQp9SIyNgzoq+4ikpe44nrVnK8oBFdMJthMgyYLvFCzM09TuC9Fllm5fuDpCdf6j6
	 TN2eoT3Fmz1BKbWwxJB+eQvVH8RGHgvQatC6Zc1yYXl+r6iOHp0PkKUTPxFPgVlXeNmsH
	 VNGmM7J1aN/vivGmwiQkRZODJRh/lmMkmHlZ3usk5u7HVJ9OYkZ69bFs96N8EeEYDe6TV
	 QLHRx4A5d5ClptlUP8TMcLjEJeJKnkrxT7fsXVlirFnODGLa6sqOXEXyPEU7JfmAL1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YHIiapQzwX3IToJnjp7/4eE8nyfQjitCzeyBHML76l4=;
	b=kOGy4JYel9rlP2n6+7iTqLyemu+QfIgy/zjAgHL8XIOgqvMyJHvF+DvgUR9ki73Nf0Ul
	 Ew7NzMxZI63VBoFxEP0Zr1N+/mG3S2f0X+tNx9artvvMjaLFDgTmDw75V6XH8ZBI3d27L
	 dZmtJ1S6v20s2KODjAcIMcriuJV/eglwxkTjJEzbqGdhGH/WCo+6adgl1hMmdR/FiWc99
	 femI4/S6siQAfhhn4Q7p4BUieken2l6Bly62yKTNeEgVfN7gbB/o5xyKNVYzNPqGrzmYO
	 8uEX2DSWNPkw/cLj0pgoUOT31cFbEMQvwcvW7CT29wiPQys3APsJ+dcaQvr2oEDJVMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=O7wBJoJ5;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E3606A337
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A94E3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=O7wBJoJ5
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-86288992de5so3220066a34.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1794845771; x=1795450571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YHIiapQzwX3IToJnjp7/4eE8nyfQjitCzeyBHML76l4=;
        b=O7wBJoJ5PXA0/Ek3JjUxq8vHbwLPjj3lLwOBbynE8dOgbQmvmE7THB+n2y5O6SS0M8
         PjflSO4LbHF/+KcoHLv5immCQBrlelPTuHSNmXbvRr6cMi9rmCs0RglWViY/xlbpOrND
         cTVKssRV8gGq+0DncS50mEdi4AP/HZJgUcOq4ySU1lhgrqgBU4nBH0GD2fNPLyseeXYH
         R4qAW0YnShQ7TcxU1vo8Um/Ps9RS4CxWZgoMJMSLf00au/pPw3wkQLNsYWmpGlJZEfgu
         Z+ux+GP6To6++lrRu/vQEbeDXxcQa7MW7dc6QsnR7Jdk4yjtu6pBQBM3LZgCTtnKg/+U
         OyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845771; x=1795450571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YHIiapQzwX3IToJnjp7/4eE8nyfQjitCzeyBHML76l4=;
        b=zrSGjjbVbWTBKyExMNRfGlZM/5bO9KT8khTZQNsN9ayJ4GQ6T2CD5LovoMOKH8OQy6
         DUhn/yk2sdMb+vDsuXBh3ncS65BVPf2r199bF4KTsQsEg9mpqMJUrQXPWENmAbgeEsfR
         hbCd6bx7Tvff45o8qhzvXZyv9C0rp6hk0/FbkfR3dVAg56Sy46QQaVC3ugQjJI9zWH0L
         ML5SlqKnEf4OtdEbPogpeypjL7Do/QRcysLA50BATnznoaUxGM9+7reilQLv43j4hidY
         23PdtsM59XXchr7AH2YFlP2cAK87qoprLhOdx/C1y2idjv9WmWoT33AC5mBw8zXd2BiD
         SyZg==
X-Forwarded-Encrypted: i=1; AL+hErHcrLzYdMdastAE6d1nvTuGHsHxSdW8UiQX7HSOD5Sbv89zhDOJ4y25zoOk1f5kOrtZcB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NDJkWkfv5M1QVr4fxkhRmNO1n04flAvJPfBC/DVRqk0VNRXY6
	AcmTxcz7C4yXbEGu8TL1l3KDnuKfNe9dxqzCn4AMUr3OqH5M89gZG5pFX1Dso0gPCBZQIY9w6bP
	zERsi6W69ziifIlUCruBKF4m9FykdJq285B4F4Nev2nELdMbbbFWx5RsLwpMkNRwobJTDujW8jF
	SLiKLONUL9TF+X+PQPL9k8P7KvN2J/Jcs=
X-Gm-Gg: AYBFou38usD+msnQUUA0+nQbHJ6s9llcpP8Fqw65y7ZCmrwKFZfcOAh1b2/+kxMuSa6
	mKI41gCZIpCQ06PwcvV4qWAFynBVDtWoYF/ERpKD8spdNrzNm9nTaMb5VYQaBJVYy99MnpRYs1S
	B+tVgteHRVntXMOvYvXZiGOPl9fhtI6SAMNPrh5jsO5J5GugT+PQZrmYTCiFHDQ58sQ6A1pEBgV
	iyIl0UH3bc7zjQgCrpUtaJv7z+HAQzIZ1KACE7OoXh8mA7mbF23QP5s3g1afus5jAtpddgrsM5W
	bH8g8Ds95YX5jF+zGal2soZmaKdlT/XLdvGSXcNGgNd3tkuIAJzDcKZJvi/HCkbJQG46jllCEjx
	NFFQbyxguhKXVBNpmmk4v5nsTrfx3rX72uOJo1PNqUUufJk5fDAUTaLqYK9X66em3ozrnQ9MAKl
	ANfMgrQGWG3cBhunygp+G8aretFvOr92qhai+QG/j4RnOYDg5L/SBZsUN+hwoYip1SvOplv8MMe
	07TVTRv+CF1Xu6jZ/z0/B3bLJvUskhhzHrP0CSkNFyq8LRCvkERxqvOJkNQwVe5TLiJFEi56LLJ
	PavY03ZvdR8qebhp7x/YfN78sqD6Dm2F+zqKeAo+znIhU20joyVMV+Il7oegoXc1Mzeu4hpxFSF
	Q4xXGsEUWSbeb3J7DY1hTsInhrBesoa7/6WFz0jXvMk40vt6BLtay0mJZfBCJVv/vNPWvAAnHsa
	OEXMVULtUbtQ4cxurH2bPhkEvXgSuprUuAaTXo3Zz3daz4cLmQITvFbBiyj/GHXvf0+1tUkvYz8
	FGG0VoBs1PbDQi2aq9BRQY2MNAnRktJ5yhicmtPKmqv5c1QGmu/+Q==
X-Received: by 2002:a05:6830:34aa:b0:862:a9cc:75cb with SMTP id 46e09a7af769-862a9cc79e8mr5333761a34.34.1794845770564;
        Mon, 16 Nov 2026 08:16:10 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862d68aac75sm1048955a34.23.2026.11.16.08.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:16:07 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: haraldnordgren@gmail.com,
	git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v7 4/4] branch: let --delete-integrated find branches merged onto changed files
Date: Mon, 16 Nov 2026 11:16:03 -0500
Message-ID: <20261116161603.57379-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <4b5485584e218e6136835c02a4e9b01ef9a5c574.1794662670.git.gitgitgadget@gmail.com>
References: <4b5485584e218e6136835c02a4e9b01ef9a5c574.1794662670.git.gitgitgadget@gmail.com>
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

Hi Harald

On v6 you asked me to send my tests over. The new test in v7,
"--delete-integrated keeps branches whose changes did not land",
covers the same three cases I had: a branch that never landed, a
branch with only part of its change upstream, and a branch whose
change conflicts with upstream. So there is no need for mine.

I built v7 and ran t3200 with my four tests added on top. All 209
tests pass. v7 reads the index once in find_landed_commits(), and
the commit message now says where the attributes come from, so all
three of my points are addressed.

Tested-by: Jasper Mayone <me@jaspermayone.com>

Thanks
Jasper
