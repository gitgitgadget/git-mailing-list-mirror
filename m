Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC643229
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708238300; cv=none; b=npvn/KTq0E6I1s/moXPfPwK2M0Rps+HcDOTsvMmBUrz9U5PmrkcfHfh80afijO2e/33fK6KvJzKKxShFa4O8TVTUEb+vt4tVLk2xdD/yYTLHh+ATcpDufLwSXDdiQYhnyXOmDS//CgOagKpW8rwUnND6x83B6Sj6ajesT6FwvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708238300; c=relaxed/simple;
	bh=yHpT/0eCYxOGpTQ5GDoZWgD5CZaQvAIFGK4m3+H03ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmPIiv11Sm8UytJdWT1IvThisFVt9Z/HIFUfqOHmaSE/gDMkjmtA3lI+yoic65tzKGvmbOkOe6P+Vei9WCD+sSvCK9IBmOutvRsu6zuVkbWpBFBEO3nD1XqV/QvMgjbmZvvA1Jra2Pzjw1/WLsakGHxuWCf23kaGMU60FyKNAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68f56f26101so2682856d6.1
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 22:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708238297; x=1708843097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHpT/0eCYxOGpTQ5GDoZWgD5CZaQvAIFGK4m3+H03ro=;
        b=NUd0+XSV/QWHPLcMGsUkBfceRODy/u7RXtV4ELeya70lLYemX/V5yXyVEr+qZKm7sI
         AAMkD3EQSPlgfCjv/9PphQSt7JhL6f+2fAQUb65HUYlchwHs9JjVjf2MPDQcaqJsoY6P
         YeqW4EMRmNkaSDPrG6KdqWfDcXQDvFI8bLvhEKhIQvmC1jsetDenllUv+ucZhNoUfgRZ
         muDMvj758flN0T1cwoh368Z3Iuyp+igzAwMx8UjMtZohrTDQUBLutFeZwwefYprmVUCN
         yjYcIL0Uz5vpqd2MQg8CNgKYBOav2qpT75WRQsD9bjkEVJ5k5fz9tQ0Vokw9+PWK/ZA0
         1M9w==
X-Gm-Message-State: AOJu0Yzy7dYKF/I+xTZNaZF2uRKMvv6RbBZ0tYPAz4U5j+DOfedx02CL
	uASf5YHhga3EJ+VN0kZNANAFIhx2C1S24YA5PtFMDz6mGDHE4/qeqbNABuwX0gBqktajaIGvUkn
	ODVPwWlgpZHzH0AedCspdOz/Wsfo=
X-Google-Smtp-Source: AGHT+IGFCgBsVvo3ysPliET18d83pTMYjFgg9w4fwy2415PMbtBPwftktiGlsbUEknhaqwnYJJe6qqgybU1nYBmHxNg=
X-Received: by 2002:a05:6214:19c4:b0:68f:216f:566c with SMTP id
 j4-20020a05621419c400b0068f216f566cmr11275034qvc.13.1708238297409; Sat, 17
 Feb 2024 22:38:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 18 Feb 2024 01:38:06 -0500
Message-ID: <CAPig+cQ_SCBNc7-x=eTz+kMg0_bg4uc2SubbJpq=i7Ok_Y719Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] osxkeychain: bring in line with other credential helpers
To: Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Bo Anderson <mail@boanderson.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 6:35=E2=80=AFPM Bo Anderson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> git-credential-osxkeychain has largely fallen behind other external
> credential helpers in the features it supports, and hasn't received any
> functional changes since 2013. [...]
>
> osxkeychain also made use of macOS APIs that had been deprecated since 20=
14.
> Replacement API was able to be used without regressing the minimum suppor=
ted
> macOS established in 5747c8072b (contrib/credential: avoid fixed-size buf=
fer
> in osxkeychain, 2023-05-01).

Although I'm not familiar with the SecItem API nor with the Git
keychain API, I gave this series a readthrough and left a few minor
comments. Aside from a few very minor style nits, perhaps the only
substantive comment was that patch [1/4] could do a slightly better
job of protecting against future programmer error, but even that is
minor in that it doesn't impact the functionality actually implemented
by the patch, thus may not be worth a reroll.

Overall, despite not being familiar with the APIs in question,
everything I read in the patches made sense and was cleanly
implemented. Nicely done.
