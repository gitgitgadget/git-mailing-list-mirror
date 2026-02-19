Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522B283FC5
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523706; cv=pass; b=TheNiAk/Z7YQ7snVWgnA0U8gnDiHBAkaQyGWxLlXqtgL+XzA2G2YMn0/cdNz99iE1tVDn0Dm3H9GN0pAWjzeNS5V/jO/xpmW1wO1T78ViM9IConga3jnel+VNj6yal+VwczZAoto5R3cMUcAmkhPkLWHgH6aieL4MUb1RJrkwd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523706; c=relaxed/simple;
	bh=SsfZEFPusHAD7JDC1CzEdPOJMp8ViulKgekJ4hCtkvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALftlGfqTCCCpCr2uXIqPRHY1vbTHCjbQXXxfz5LrPKuhbTR4HTGb5FZZfRzBhbkZWsGie1cLR6thDlR9K/wGhzxW9QE/HV+xyHL4+kwDkLUVVYpisJLZnvk5hXYYuiH8Il1BdkPhN2NcjOHv2zgRik3HqdbNUCvKMpfuXRi3BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zb2zzBWM; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb2zzBWM"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4638e6bb8a5so405081b6e.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:55:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771523704; cv=none;
        d=google.com; s=arc-20240605;
        b=Ii0fHnQ7rMp55CPOkDn9+OzX5LStVlaqW5HinXJenZwAzTo9DC+JesVxm48hQdp3Ou
         ZRzM+9o2S9hjYl2l6WmYJi+8+ksZPSnIdrNvmf4cAk62UtQRHBojYrcb/vyMgyAWjYr/
         qzUe9hqZKPJ3esrhNfozRTpNbKvFLvYekji1pFraqDVaRLk7imZ5XVWtQ2t5s81oAVmS
         S/lcG1vcqj7VWLPXZ4KZj5BRw8MQ52itg7nrZbQtWSlXAZWiluRcCXhNjEvP2XUhIQ32
         4R2MyXQX8vzRf/0TtFc845aEE5Xpu0QyVy736nSNPHv8YVT8D9zcgieGl3/ZRTDXW1NA
         Et1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SsfZEFPusHAD7JDC1CzEdPOJMp8ViulKgekJ4hCtkvE=;
        fh=69R1gKkii/hyzTyAaSkTD3WYY+LF0i5vS1N358Xbtbc=;
        b=fZM9biZ11G69I77ccd6N0jWrQKi6GCLX32W3Mw3xoSr6WxKc+wH5RuzYygubohFNSX
         K/9WfMcwk5okveOl1yajLbGfsaAgAgj61fyhbJTQNvmZXDKEaWZ/Ui5NSLPrcK2HDcwF
         EuSBrqFioSEVv748EvReDOy02DJrcc3V2o93bzU230UtQIFm7ix7R1QrjeHjyvxyLlMu
         ydRwAaZ8WrOG66ZsyvNf6ZojKnM0Dq0POVqAwtb5gKqHZwKoqUmr5aG0YBnzw0KZYVYG
         DoMBfCJPejQQaZhizrWZBCOu/hAmP1VKaFfg+4NqyYBF8CpLi6ayR5SAlnVHYSjVdafw
         FFFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771523704; x=1772128504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsfZEFPusHAD7JDC1CzEdPOJMp8ViulKgekJ4hCtkvE=;
        b=Zb2zzBWMilv4iA7YRLecrqTIPVSeeYK6sVKWfkyA51uRztYYrulOg8sf+wlPjpQX/w
         gKSemk0SeHkhwdae+zjVqaMu+WPthD0tWAWc/Q657ZFqxzvOO7wM27uhldBYz/tV2qSi
         5zF59p2XXXb4HvCtuJT5ukfian2ABggLYH2CA63jut9lHOC5VAO4RitqZL5x59ndNxOS
         W4nBIXkADsav5AYxaOcwvnv9+ldkhMK+wj7PKghaNfsQKUyYXnuLWw40n8RdrmTH0840
         EUXBBfK0HzyhI1UQKNkYWBVRJMCeQ2gr+1AmwfVfiQB2P8owc+O+TA0stQNsXp/SNzA2
         ED9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771523704; x=1772128504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SsfZEFPusHAD7JDC1CzEdPOJMp8ViulKgekJ4hCtkvE=;
        b=Eohn8AiWm1sUXtNbehQ4CnGnZRiMag8/zP8dRwYV4I3n30Xg6TLwm/+5pYHZPCPVrC
         gwQ1wj9BSqcd6vOKJTouDYbkPSfe1FlTEvu5aTGkoi523tIS7g4n/N9mCV2kQ6gAnitu
         KHmMokdGfgojEkg+rm/0CHf6KxFOaAcDXERSydcjTInKwcgtOGw1BSIGrpRQEtIzC39o
         CeHanZV/HQEcAk1SPtWm7BAxdZU6AolKcBqAE3dENglWf+CSbvQgRb1V9Qu9wYCfn3q8
         aG0tFMS7GrVcBzUl4CevfZG1U1iNE4QjJLTuI75iUXC2tKZzDzbMEIfRLmyHgnSN/mQm
         5yqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlgDwrKCgCaZ2dBeGwcJ+9VHNwxL4nZTnwFpwSCuwnJ16uPZhgFaybzZ/+mtbLzFxOTjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwK108sbJMoAt5BNMKrZI8uXMe48TOmipbsOXLgU9b4PiWiSFi
	MAxhtvmAcpEjESn98KODdkgQs4nItysnBZAS2wI6VB8gCUYZcgLKDAVJ5Kws6mBzeblMRX//W4V
	1zQCNGUkz/6H5mau4Q8Qd7kTFcngMC/qxGA==
X-Gm-Gg: AZuq6aKXyr4rpSwHtZPd65ISQYjcrJFsuVONrrXpynoKsR1b6/+Hv7Bzm1JO+yAfQ/V
	gO5cMLOcrooOJwgCCFgbo8XBxScRg916Gz7X86erW16WOaoNPi+C51fEmnjra0H9B7jpMNMZaRY
	8/b85w4Dd25Ws71iC/BpB0nlDxWu34gCBARNp6aEQb5r5w6K1Q2NKu4Yu5346zJW2+m0mx6klUq
	OG0zECR5A7Tr4hhoCfgtH+9gwKEyM5FRLl4D33Dta+KO1xL5qd118QprND6+QoRbijY1Ad+MGL9
	Y/nmFpRYfAGotrXKGjyhdE/1b2fCl7daoRWUci32mMrZRjKu84A=
X-Received: by 2002:a05:6820:627:b0:65c:f14f:91ca with SMTP id
 006d021491bc7-6785b1c1d59mr9499679eaf.49.1771523704199; Thu, 19 Feb 2026
 09:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
 <36c2713ceb305f17295c4e8b38dbf252dc641128.1771406115.git.gitgitgadget@gmail.com>
 <aZcr58Dd5JPngow9@pks.im>
In-Reply-To: <aZcr58Dd5JPngow9@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 19 Feb 2026 09:54:52 -0800
X-Gm-Features: AaiRm52Jp-ns1sOzq21k2DgA3i4F__rLnY-OgBW7rIXNKBJpfsTixyMlvBvA7rE
Message-ID: <CABPp-BFto4512vNeVs=OWpaqV4AH4NQ+_TAdSF3vDiuWMSGqQg@mail.gmail.com>
Subject: Re: [PATCH 3/5] merge-ort: replace the_hash_algo with opt->repo->hash_algo
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 7:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Feb 18, 2026 at 09:15:13AM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
>
> Nit: might make sense to have at least a oneliner here to explain what
> we're doing, even if the subject already says it all.

Fair enough; will do.
