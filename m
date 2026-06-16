Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E1258EE9
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581285; cv=pass; b=tPmRBmzkG438TOBUeFPwQtNBLqmuZ39kIfGC974g5g1SYcgFaWi9Tq00mmeKTUM1tHeytPCuKODhZavs785w2glvocjZlR38n+SvGrAlL+duYZ/zG9E96s+g7YY24JZRi0fjalSyT1qHM+r+SybHdvyBHew7jJcn5mY1QjOh2eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581285; c=relaxed/simple;
	bh=nIsXfHkcYny8m0p0INyktxuVZblDZ9KY6enFTZ6jtcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Bw41UqMKAndRkcOm8blCARP8Bxq0Rg9WLi2X0fuPJRjb46TRH6/PAYrL5k5xjtXr9a1bQlV7k6NOx2DoqqiMEL0UzdjVbJ5q+baUT6i8fSYHDvOU9FYWKjyFdyESaSfDys4xRJElS8Y4scwQOGuQ9KSB3vIvnLESL1GkUkQQ8Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oimRVwaN; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oimRVwaN"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa5be9ab1aso3735225e87.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 20:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781581282; cv=none;
        d=google.com; s=arc-20240605;
        b=e/vuBfWiSJog1kWLZWwS6WNZ2EwGouP/FsYCRY2E65x41zBWrp+7MYdWtKwPVt/zCq
         Q9jSX0sAwg2vXB01Cj2Z/oLnQuizeu1pVydiPDUR/bcy5IpMVndXHybXAdLnPwdgr793
         suclYZzoVE2Tj4vCrTM1szvV5lm0R9FoLsr0HSn0OmONW/P1W+qgwrvDMBYVy/oWX3Ng
         BFQHdo6vSjK0EFuQAOtGIUqwASPFMTNuskycZM9MtZ6kkeR/F+RRM25/y626cohKfV5O
         W/01D37phBJYX06/osGrB2Bt+MG8TQPExmP3/cXl7h3AYmryQeHn/kHofyEUzMnJ1hFR
         es3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=nIsXfHkcYny8m0p0INyktxuVZblDZ9KY6enFTZ6jtcc=;
        fh=DJHZ7itWveYVdfezJsKgr6XLEjDMbfeXEew73fqN9oM=;
        b=gUaAQ/IxLZk6V0yS3LxzIhruuh7fPGlLHrQT0+YTFJlA2aYdZwmTSsJM7xym08rA4w
         Gr1KAVrhjFA4TYXkzp1pwT/S9I0Lb1Wy3DwjPu1cJjNIAoSFxja/Ml5UHtUWLcEmdevH
         hm2WmKK4QVt4YG2EAJ81NfhyqhFLzqj9lby0sCKfUkVefTmozOHlTxltkD4PSUnjTBGp
         exEfIquZC4d2UNEwBZkFVUtrdL5r6h5mHkMGzdanCFcyVWO5KYj6c70GqqIwt78oO65x
         lavF5Jg3sWPOy7XapW/0bLGiWL1aRT4nCnbK/Aj1GVyw4G/kbQqAjKdCA4rWS0o4A7J7
         vV3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781581282; x=1782186082; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIsXfHkcYny8m0p0INyktxuVZblDZ9KY6enFTZ6jtcc=;
        b=oimRVwaNAF3/cfG177vus3+ODsgLdYhUKT8wNwP3hv9RMFUgLDFBZ3OsMxGxelrc9G
         yY6i+bD27r4k4NrNtHfiqPT8bRcYnxco5xPijiroq1zYAoFMng410cWlZOWpOPbweZg5
         Kgk3l+VN9B6ERTINpk/Ygs7jzyDzvkCpNu211evz8UDODzKih/L6hE1+VNaWdmAwbyhR
         kx13HzHxhtadUE4JtSB2wfpLRgEQUOoFgqZX6QWGVqM6BPp34UnsZR76IieyLZ3SDf8+
         r/DJeNGgKdUOJZU0P/+RzwYlr16Jts5tS+5dtkdcq5Qi5ymRELcBZXiekVmCCo0SZuS/
         nH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781581282; x=1782186082;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIsXfHkcYny8m0p0INyktxuVZblDZ9KY6enFTZ6jtcc=;
        b=VbAhqmaMW5h1YRDo34nZZxeebRDazOIPokPFRgyMiRZcY6v5AzO2JrQ0/FXqWOWwLq
         Kma+TCr2DXceOAqyKfQlf47s8zeprJzE1kOb2yr00HlDhME/Ox1aDWQx6DceOlE6CtGx
         Aie9AC6ogD94YaUb0lcjPG7xg9yNscgwude1YGm0QcBW/nd7k/V/FhpVDpLUcsLJJ0zz
         fqTiGaBWF6hwhouUORP39TVCMxUwIQRgxRedNMCtE14pZI7M1GgZBKVkePv2PWBuLv/o
         X5paT47gV9Tjg73eBc/+GUYrbAKdk890rpqkknzc16mIgZiK7xhyd3l9Gq3WHZzzyr1i
         9U1Q==
X-Gm-Message-State: AOJu0YzqEquP7rHohnef6K62w6xWIGKi8sXb51bItMo+wNT3qUPcKrtO
	vIwgd8fadhWLxPetgw0xZRFgaa8VEPdQOUMk4VgI5lbGqFJBAeWxzllS9j1BnRjsGnyNYvR/aav
	J0ZykyrTA9B8zCNSu4RJzu3ol2S/dwm2x0IWB
X-Gm-Gg: Acq92OGuO6OpzjpytTX1TgHPtgahePfQmqgGJfgzbCaCzNG7aMjAGU4Y0Vp+C5nV78h
	a+ljL4qKQyqyOx1bn3sIANHVez7LHFsRPavIvoz8lv//jXzw7DW0btXxpd+EaHduYvbmxvRntyL
	bYzVmnPn7IdOXjdz3mkgu2O8NtqLgGtKcIQrR7uF26fGyTgrnprYxI05mOXcY7fRMSRtvB6wGcT
	J90Sm7whVnhHNdTyMCAR269A3Ir6ZwNqxSFuAMRNLbluHCsxcT/woOPgdfksP/3Owo6pYROufxp
	Wy8GD321eMg5WzTjAP7Lo9FcBarSrN98VJT/cjDwlHhh7v4plPv9nIvRgnzvqxcl4pXSnY5MeIt
	bTsjfZF1OSfLW4kX+oOtMmsoRIw==
X-Received: by 2002:ac2:5683:0:b0:5ad:3035:9e5a with SMTP id
 2adb3069b0e04-5ad30dd92cfmr4344289e87.51.1781581282271; Mon, 15 Jun 2026
 20:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLee083Whzi3b9CP3Hxrq_cz58enN67ZQq5r0koczKeU1A@mail.gmail.com>
 <CA+rGoLeNzxaTrq50jE=at=0ecnZ5Diy+Q-0McG-R+XFTQ7oMow@mail.gmail.com>
In-Reply-To: <CA+rGoLeNzxaTrq50jE=at=0ecnZ5Diy+Q-0McG-R+XFTQ7oMow@mail.gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 16 Jun 2026 09:11:10 +0530
X-Gm-Features: AVVi8Cf2QRlXpvrqjIH76oscNrIK0R1TJYumNb4rwrwuzwBFE-DjEwNijXoJNpM
Message-ID: <CA+rGoLe+n314hrbKBSU61Hn=uVQN+OqOF5AVt2gPOityUUL_AA@mail.gmail.com>
Subject: Re: [GSoC] [Blog] week 3: Improving the new git repo command
To: GIT Mailing-list <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

My Week 3 GSoC blog is live!
https://jayatheerth.com/blogs/gsoc/week-3-next-steps

Feel free to give it a read and share any feedback ; )

Regards,
- K Jayatheerth
