Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51D3C26
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753749557; cv=none; b=NrvAhyIPtafVtesucTQs9UpBauoVmZTg3LZogUebU833x9JulrVC+qUqQXJg3+/44eoNgFBMJqvWdL49QSDiTaRnAtaX1NXNMvqP+p5YoUwhcnYfBsSODZAUD+EGjpNb2HAJQNiUXZhqqStzA66Pmr3y4/F2lSz5ni0hiRxgaDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753749557; c=relaxed/simple;
	bh=ShEAd4O9Bf+KxLXVlnRbhclzKc00s1LD/dB1FGrjMUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBlvOJPRGX/YZa/0F5C0csHbdbG9F9v5QQni/72NbYKAdp/W7FseQcvO26CSbWzUwVRFiLcBKq7o3lk95FsGtJQh9LT+IPH7vTOOAYhOXPpv3/IHIJgQupXN/w1MB/i47YDU6VkxVnPU8GnIAa0yXWQWUnYG4elLdaFV6+KEVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7072e900fdeso1928896d6.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 17:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753749554; x=1754354354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OyJAIZo96JAflFkZ4Xp6FA8A6a6z4hfbQeAZMebOBI=;
        b=D3RoHL8Q8UjJ3tZBIilIpJl1d4w4dt9XAg1Efgfy32rDv66BEiWSyDG1qhrLeMKB8/
         u8Zp4fw9bbvgeWhyjHynLUGZ8gCsaW/F1qEPqTkSsOSDlLE+iYOGniQoz+aqWMHYz+Gj
         1IA5IRKrovIqnRnAnASXRAKRTmGR4iyuhYfYyl8nxPpgLbJzWVAOLWYNpQ5u62nRo9we
         QskGJ2aQdbm3WJyoTr7VZWb5OPTmSkfYHi7nZWKVmjGJyIHf3aKHU7LVbggPkh8/nnbI
         AJy01aesmDIHnLR+4OldrE57QFBEf2CDQ9Ln4Y3aJHDb/lak6oUvn22fl6FX8ZoUOYFZ
         Gzig==
X-Forwarded-Encrypted: i=1; AJvYcCVaNiQ7HzhM20/Rmm9+ViH1iBMotu7e5tpeJrcGRVNErkR24mJnDl3tai2cSNggFDkWvMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/R8tP/j/+K/rGNMjF2c0aK1qgMFRd/s9G+CLXLviBKOSO9JS
	mTFpcfG5g+xMULNMqplZAHPJGrlFhRdX72+TXyPbLtjOdvN9qUUhtJpbKgpXo+Q8s0n5I0Ya1Lm
	O+BaWHiIz1pBOl+HlTzHOzU0NYYZYa3E=
X-Gm-Gg: ASbGncuNdVSM4gwaGqLDdG3fvGBZUI9Q2AcUoWTd9wfN4yrl4R/mG9SrnRulLmgMbze
	X372WtE2IWV58NJFZ6SfhMNM9OGDcmfhGAsIawwt92/5fFyGIeEfJ2CIcqRgSpLtD/33cN0J+b2
	Jwsq5IQ6LN9YqjTbpFlZ5QKjrN3G3UN/dwzSFLfXlf7wZBFpK4St3+x0V1neL0494lZzF0GtRlI
	xa/qdj3h+x7lCZrGIoSleWI6CHbMFEpdF3NTBE=
X-Google-Smtp-Source: AGHT+IFoXpiAvYo17DqvsjQFj0pzd0fQWxeezCy3+P/7Ri/gSs8by3GvSW9xVu7BPknj5vqitCS2UcYX4Y9L24LIVM8=
X-Received: by 2002:ad4:55cf:0:b0:707:4969:bee1 with SMTP id
 6a1803df08f44-7074969bfe7mr26677856d6.5.1753749554031; Mon, 28 Jul 2025
 17:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPig+cQn7c5+k06yHOD2jxYTGnny7is=fbo4tOw26eD+4zX-Jw@mail.gmail.com>
 <CF7744F0-394B-415D-BECC-9D7CD477B78C@gmail.com> <CAPig+cSUnejuxYHvk3hzb_nM6bdEPydBsKgD2FkOX5sfQ2FUAA@mail.gmail.com>
In-Reply-To: <CAPig+cSUnejuxYHvk3hzb_nM6bdEPydBsKgD2FkOX5sfQ2FUAA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 28 Jul 2025 20:39:02 -0400
X-Gm-Features: Ac12FXz30LRv38B8Bl7NRbbdnqPyeii9CB0MYxcYkqQwQ9ZvXZw2v2H6Dx1GPY4
Message-ID: <CAPig+cQEg+ysR9JmHU57tqbgG+9679yprQ=V89WEup+Ra2Ma-w@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 5/5] repo: add the --format flag
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	oswald.buddenhagen@gmx.de, ps@pks.im, karthik.188@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com, 
	jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 8:27=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> Taking the above into consideration, the recommendation for Lucas
> would, therefore, be:
>
>     printf "%s\0" $expected_value >expected &&

Of course, I accidentally forgot the quotes around the variable
expansion. I should have said:

    printf "%s\0" "$expected_value" >expected &&
