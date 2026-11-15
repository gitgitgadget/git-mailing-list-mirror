Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794740613;
	b=jbV1Qc0i0BfU5XPQXUokhHPx3UZ0pVNiZVoesXIT7bZ1vO7SNLAqxrHFXxnZCpY8lQHZ
	 90FPZttm5bjErvOE1dEd+HbQhl+3U1XkevKGUt7sjQrsL5jYAbNrBFRsUTYf7SqnolbR0
	 oSDJU29ohG/xihzbOp/Nyo0bh/XH8Hng6D+g8ckD1DVx3F6Yu9v0m9OR7ULlIVcOKW/nH
	 Aa+IuCm7e+mPJ6GBWs6TZCfrLxOklV7WDcTpPnmSci12tgANbYighX8qfM6DXHHmkHHXM
	 l3j2TkgOxrVKiwCYEO5qjAgXKlbwdTr4NwgD1v+1We52HZww2uT2LRQCOTc4yRK00WQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794740613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VXjFcb+gUR3wUrpIEg5NN8dw9mSIXwVzsfeqBZivDdM=;
	b=3aKOOzt0ui1NZA12EEz71alP5AGSUR6sYuZHsIB8sx/f9HzPX9o1yYhrR+AsOwiYh1o2
	 AlpmG3y4/zzXfHwz6nQ1RFPZAbjuv3cKyRGxcgZgxDFabnYMNS8BlOIW5aDfeE9loB1e9
	 JK1rCfxldkdu6Ce2HqLtmsG+GM+ogEAVAHlpuArDDjPyT1TQjLGdFNZU9PcRYBHzqhIxq
	 SY8mn4MyraawaKQPO5r3agbfpXhFPoPRI8deU3WRv3d55hF9HAzSwX8ttHhNTx2GBnxkl
	 Z4AxCcGZRaQMlpHjqxgT/L3kSLY9b29/coJStTkqT20hZkzStdLd69oIACW82W5W23w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OyPO4pyJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7B606A31D
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 11:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E7B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OyPO4pyJ
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4a76f63b243so3329712fac.0
        for <git@vger.kernel.org>; Sun, 15 Nov 2026 03:03:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794740612; cv=none;
        d=google.com; s=arc-20260327;
        b=ScgK2xunoTTFVk7gripAtADBVePkFmLfNpMze1q/0qlNrhvTi7ErLeygyfq0B0O0h3
         UH3ZcoT6n2xTdFEj9/HZgjSfV7CRoP4AqnWw9EKjMVvxnUHrM14J76p8A80S3kaCtFUk
         Mg0eyvNYgNeShetspFjeOLOStA3v4GZNN/oqBdHDKrYJo4iut9/kuTd91HPApiw+eItP
         wfbvtjKPo8spq9Wnx3y0yQaVoNkQXQEtLjc/cKMMe/9voMExmZfvy0goTfL2wiq/yOxq
         WKFxDQMhpnUZ8tFtPjx8p66zK+tBi231AqJ5VzikPe2htGtAJFKPdMlVlIuj8rfcRdzy
         3g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VXjFcb+gUR3wUrpIEg5NN8dw9mSIXwVzsfeqBZivDdM=;
        fh=K9CE7W8RKHaUdeZ+zU7lVZOU1wGfMhgY9zF3HcyW7i4=;
        b=kLE5rAzZ/4u9VsS2yKjQxnedlPha5S25XRenO8Tlb1Qz5wQS8Y4B/GoDX5/ieeQmPr
         EuY0JyP4ks64f1myB6y0F6p9YLCG4KYTc/RgEFuRfFVkqMHr0jwSDzIdY8lqLr7qJ+j1
         5cTKcjGvfCb6/Tdb47q7gG3kqGnLTgQTsvzTyWFjRtYJuvn8nUAET+W1XaxiOEeLnOTB
         T5Bb1mn6L0+Zu+6AUCO6J2rRTK5tsdRma7/UI+2NpclPUJUr4CpE9YPlBiV4gHq6IPtF
         4OpCyPcAMrTeUlDRSgVMQeZKX56XejkzXU7d88pjjOouvjn+8J72hxNLHm/zXQY+BbVE
         GodA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794740612; x=1795345412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXjFcb+gUR3wUrpIEg5NN8dw9mSIXwVzsfeqBZivDdM=;
        b=OyPO4pyJPdCa3sPNF4b6QNxoPwTCb0LUK17HFNuTCzueReoRXFSnA4pgJ3l+8oJtnk
         ibTt0AXqF8zGIEDCu1jyn7/WHjT1CWw0LTpRsJLAFBDj6XB856jYTxbHuDbsA8eJp6Oq
         nGMesiW7tpO+c2P30QeJY97Tncrd3YJYb2W8LNhLSH6F9feEEhZ5fkkITdWRF+WHlLSb
         2XYHR1sLmF6+E/zqdqDCEVXLe9b1XDoFc0xpfJ0p82XfJExuK0b/cXrOsPxpRcs05t7G
         v0eSUpzya3N4D6TT3Y79g1UXz99jCcc9Zw8cfqtBm1dWN7KIMtf4tC4gPsDKIre1h3WF
         2qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794740612; x=1795345412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXjFcb+gUR3wUrpIEg5NN8dw9mSIXwVzsfeqBZivDdM=;
        b=gd5gmL8vIO5wYKZA69kWJlMgzDDd7hHBy+MEPmSNSANSfoGOSzKS8XBA71y7awBLmU
         0VuFV5HlyEuAcWPHTf2NupnxV4MU/Xkp/O2GtCj3HM3EehXWW+Zllk3oC5yMe7j+CXJb
         jKl4x05dPAOqp2Nfc7ZwkY2TKGNne2LUaum2u1DJJRVxEknh49kXbRP97ysA8sHCyrO8
         lcS7OyeizeehKN8WLFNqPUVdMeLNZF2gpBdxT1MTMN6031Rkv7jzPnBLMg/1U/n4ITuA
         3Pmp2WfSz1OtdyCsGImbN6hBrtLARY3AG9VpnMb0bqQ9bebX1xEU4bENaDGBaESTCZLH
         eRIQ==
X-Gm-Message-State: APuU4Z89tjNPD/FgUKvUF1U5lbByaNy2uj5qoVMy6bUjr7Olivb6tERn
	VgSfHF4lB29HjGhx1k0EdQDgzSlTIizoGGeMOq3ZpexjCDZhBGidXqjxqxXJRave7V55bqhlaFd
	DvZE0CB/hv77VmMTALT4hSAOfrq5VeyY=
X-Gm-Gg: AYBFou2FP2ztkSaLy0Alrf6BCBuIYxEBZR7Mk2WF9f7yGDfwO1fNLtPnHtX1mdKyW3Q
	VhLSX5nlQ5WQ4flfFZ0SW0DuIKcBwiySyLypaHJ7Ats9hKK/25SK96zt4HPXt06VMKU8oZQsUsJ
	AceW8e6g8Yd9RuYpLYtPs6KbaPK4pnlQ9Dzyvqv7IMgQQ3cnsr4/FNr9fa4hAt0mmCES4LOOgJ3
	R1DjJHvYPQA9xUxGHk34bJiYHARjJg21ysMnDda5p080fMtLz4r0t5ej3/gx2vFw/Z3YeNzuvrg
	vba9qOaW2xzgk0HCMFn9lQ+7kZoqRd1XUp/n1ddHjjYbgP0+TIXiKYZqtGYqevxE8/4Rg5yGchf
	Dn4UseHqDK8H6LyEsIiSkfS24VppjqsSoAshLuXIqQOlDHnHGNb3r8d4I0QON1FMYKd/xBbwNMx
	wdN4XiEQSurJ9jywtxyo7CMRxVQwNH0ZiUJ3fjz/7BsP579C3YlPPfHGPP1/bsAZpKggTJ77cAP
	JCu
X-Received: by 2002:a05:6808:c3d2:b0:550:6056:aa66 with SMTP id
 5614622812f47-56cd761c123mr6592310b6e.16.1794740612429; Sun, 15 Nov 2026
 03:03:32 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com> <89511e61-4646-45df-b5ac-b52c9424072e@gmail.com>
In-Reply-To: <89511e61-4646-45df-b5ac-b52c9424072e@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 15 Nov 2026 16:33:21 +0530
X-Gm-Features: AclHuK-ZMh99qqGtZD3IN1A_z6aEIXPl0FUqnek39jXkgBtvYJ2diaf1a2BAGhk
Message-ID: <CA+rGoLfJyuT7+W_eVPap_KSqy4EFG4Avp2=rL=hsLu0uXxem4w@mail.gmail.com>
Subject: Re: [GSoC Patch v9 0/5] repo: add path keys to repo info
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 4:03=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi K Jayatheerth
>
> On 14/11/2026 16:37, K Jayatheerth wrote:
> >
> > Changes since v8:
> >    - Dropped `path.hooks` and `path.cdup`.
> >    - Renamed `path.toplevel.*` to `path.workingtree.*` to align with th=
e
> >      standard "working tree" glossary term while avoiding hyphens in
> >      configuration variable names.
> >    - Renamed `path.superproject-root.*` to `path.superprojectworkingtre=
e.*`
> >      to provide a descriptive name for scripts while avoiding hyphens.
> >    - Renamed `path.git-prefix` to `path.prefix` to shorten it and avoid
> >      hyphens.
>
> The range-diff looks good. It is a shame we're still creating a new
> repository for each test when the majority of the tests could happily
> run in the repository that the test framework creates for us. No one
> else seems to mind that, even though it makes our test suite slower than
> it needs to be, so I'd be happy if this is merged as-is.
>
> Thanks
>
> Phillip


Whoops, apologies for missing that, I made a checklist for this
reroll, read your
note about the tests, and completely forgot to add it to the list :)

Also there are some newly arised questions about this in my mind:

- I am currently writing a follow-up series to consolidate the overlapping =
logic
between `repo` and `rev-parse`, and I plan to combine and clean up the test=
s
there as well.
- Three `path.*` keys were already merged in an earlier round, so updating =
those
tests would require a separate commit anyway.

That said, I'm open to feedback and happy to switch the tests in this
series to run in
a single repository if you think it's worth doing now.

Thank you,

- K Jayatheerth
