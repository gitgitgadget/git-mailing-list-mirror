Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E71B202C5C
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264527; cv=none; b=dXSIYjpRuT9pzzDwTOQ/2AxmpGpDpC3OaMx8nrC+dWzE+6fy9rfSq52+YcHDN9x8KQBoLZBs1f2EeXcerjxF+NF5/dz4rR0PSFArUGY06ryrRCyFo6uKbxczvbL1yCn36wtPzxaEgZnzkqCuLmb9mJ6xh/TVdfibgYLIHNXq1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264527; c=relaxed/simple;
	bh=iGR7GOUW6wrlrLbGSios1s2BcxfmeDfY8jzDhkhecw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqzocQJE3uFaiQgdKhSzi3438Ndxvr/UDowP15e4WgzP/HLo7BonYHHXdc3C1EofLIfSoQJ11MWl3ujg17ANQC19fG2hllcf2QA+Tf2vxstiomWQz+DeCp2W6By69TcLHUH6cuOhDkSCUpVGkxs9wIYIf27+aZ5v3IrR4qUO/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d58VPrbW; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d58VPrbW"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bee278c2aso3562291fa.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 04:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741264523; x=1741869323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGR7GOUW6wrlrLbGSios1s2BcxfmeDfY8jzDhkhecw4=;
        b=d58VPrbWYiMjEaMM/jrh8kNRjXNUE8UHtLZUEttxWHRxVbM3oqyWuPwSeSGDr6meNs
         O1J7rzpL+VdHRpa0pPA0y2eKVe7QFhYmylTUFQVOyw/navAXd70h6nNpwbBCYOi/TwHJ
         WKXfDbobNBtjdWViOsVJVf81jENkSP7ZMVfIaoUQZsnUHuDem7pzbDgq1ZJ/XFTl4MNF
         Dr4pVYDqL/ZnPr4QfNAzcZfrDBmyzrDtI/xiPTTTym5oiTqcl8sUQ26G5LYmzOJ0PNlD
         4oGq9w9UH6OwVbKubaJKA34XWUHsN2I4j6iSstcweBOk2TfhKf9sj4LhTepSQfwdvevB
         NDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741264523; x=1741869323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGR7GOUW6wrlrLbGSios1s2BcxfmeDfY8jzDhkhecw4=;
        b=M1pXPjOKxcE3yFeJyyFIWfiw5iih1qTCbuFOfnH1g241/UIPEQHE5C+kNX1lad5mGz
         bzphzkI0ZzdSGWk6cny0iPl10yjwNeNhbu0tldzHF4supHo8S13YhlzbBc4e9CGr7Wz5
         8Hp34MCMDbHxpRcZSd5SgCzC6GdaWd2Px6rKqY7CZZMawAmnwYGuk2lZPDkARaqWAflF
         yaul9gTG1xG3whobpoieCM7mN6CKsh7yYpvL92uBtb42VR91W2Q+9bJUsrOFtSIPmyx2
         Qr+K07izAGXQYfHxg69KkSm9G37O2iXD+71vXnMdVFocoRjwXeGxAyvY0sOPEX6n6iYV
         mYXw==
X-Gm-Message-State: AOJu0Yza3Bn4Bw1Ep+lCuHM22BWEZOW6OgNKRZO17mV6BYIJeZyRQGDJ
	IugPe8o5yTUch44zqx0XDoQoBJdFkz70uE2desqqurw4zANTXDsA/YTCDk02ogCNIzm9FoKnL0X
	Px92EoOBmLtyypG06AMj0ySmwh0Umvx+i
X-Gm-Gg: ASbGncsgbKrL4f3n6gh2Kry5GnyKnqT+M/z5eb5VZnLLiCYVtXQgf9TBFJRVBprhyal
	0KeLeczJS6n0bujRhdl6iIYu0X4al7kB8zvEZs6Y7EB3A5Nrbc20F/zvAMSY6mNzxBt9LC7JpVg
	ehQU44pqmCSMtkcEuZxfXNmXUWtQ==
X-Google-Smtp-Source: AGHT+IETNmP0r+ZUPoz/FkuYXR7VaYwpVtJgvUbPwEAW9eTVhw1cE3m1LmDXv2jF0/aatA4FDwyr2GEAdVvMDCi4jJE=
X-Received: by 2002:a2e:a17a:0:b0:309:22dc:6917 with SMTP id
 38308e7fff4ca-30be348c6fdmr10479951fa.19.1741264522884; Thu, 06 Mar 2025
 04:35:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMvj1+pyx2pphafmPwkZoeEnPsDcp3YZYjGSO1kMtdOOnJ=PYw@mail.gmail.com>
In-Reply-To: <CAMvj1+pyx2pphafmPwkZoeEnPsDcp3YZYjGSO1kMtdOOnJ=PYw@mail.gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Thu, 6 Mar 2025 18:05:11 +0530
X-Gm-Features: AQ5f1JrxS12u3oEn_gNY8Un76xynafxQlw8teHUCVvgsSkTc379-ACpz5O6eQ4o
Message-ID: <CAPhwyn03LbYexkk4YsaC6F2H_m6o73fU6aQ-c0urfdAsyEqPMg@mail.gmail.com>
Subject: Re: [GSoC] Introduction and get-send-email Microproject Plan
To: Yuting Zheng <05zyt30@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 17:14, Yuting Zheng <05zyt30@gmail.com> wrote:
>
> Hello everyone,
Hello Zheng!
welcome to the community.
>
> I'm Zheng Yuting (Daria; She/They), a first-time GSoC applicant with a
> background in Network Engineering. I'm preparing to work on the TODO task
> in git-send-email.perl as my initial microproject contribution.
Great!
>
> Current Status:
>
> I have searched the mailing list archives using keywords such as
> =E2=80=9Cgit-send-email=E2=80=9D and =E2=80=9Csend-email.=E2=80=9D Howeve=
r, due to my relative unfamiliarity
> with the subject, I=E2=80=99m concerned that I may have missed some relev=
ant
> information . Additionally, I=E2=80=99m seeking recommendations for more =
effective
> tools or methods to search mailing lists. For context, I=E2=80=99m curren=
tly using
> aerc as my TUI mail client.
Here are some of the public archives of the mailing list:
https://public-inbox.org/git/
https://lore.kernel.org/git/
>
> Requests:
>
> 1. Could you confirm if this task is still available for contribution?
I don=E2=80=99t think anyone is currently working on this task, so it shoul=
d
still be available. That
said, it=E2=80=99s always good to keep an eye on the mailing list in case
someone has expressed
interest.
>
> 2. Are there any recommended advanced search filters or dedicated archive
> tools that might improve the efficiency of searching mailing lists?
Here are some useful filters for searching:
https://lore.kernel.org/git/_/text/help/
>
> As a new contributor, I appreciate your guidance to ensure I'm building o=
n
> existing work appropriately. Thank you for your support!
>
> Best regards,
> Zheng Yuting (Daria)
>

Thanks
