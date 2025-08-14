Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2EA242909
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755214882; cv=none; b=YGTSuadhxX1zrU3zpbZ2SU6WlIdRn72EdegjHspvZyJRrYiW5JN7F1gQK0unHrBUAjfXJtqkEYmN4Y9yPsSoLLzYvvC6tQ1SKEfN84L+DaFk/y6r+I9bJkuK0b62/Nq8Fyn3ma/Jeo2+Cr4o8w2xSzYpqkf0xFM3B6HyPjk6PyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755214882; c=relaxed/simple;
	bh=vVJOfYfrjngSgv/N1H7Gi2s5cOrVC3IrZy/ZR5dBEFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsi5RBVOafWue18Slx6YeoyC36n/pZOqSM1H3XJRYfEo3sKk5cQSRtxcyXYL+O/xWgXJS3Bm0FFXIj8b8WwCAOje53ny9u2iOsVblCi9oYyS+7IhSgO7CRVLWODI04saEA0wuJpw/bs3SW5+D/S85MEjFzsgICpWnppitugUJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70a928f833dso4203156d6.2
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 16:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755214879; x=1755819679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEE6hivJNKOOnCXAp0J0F56ZFCzuQr49EBzvfhw9G60=;
        b=P62jGZf0ulHiY8QIdFDhcRN0hQpku5spVwjin6P4HErCgOYC5Yjw99bURVv5S1In0o
         y5o4Kjo16VzZwLXi+sUSnJbztnge/un3Re45vfgx3z9suK7r9Ml4HRvFYLOeKcIZ63Fo
         GtWbMfDiu56WafcrVE++09fd5blzhBsw1MuuJB8iOffw3QpZDb231IzvLSEQ/gMizale
         NCuy9L1DSYk2VS0vmbrik3h6A+qn8FvhQ/AHDV1J67/nWWr39xiZwc/sS0OOLA1UCxMK
         O2sUrlxvVcS8e4EEXffPD4C8WwoKrde6WF6dYunpJTbX4HBviMOTbLrjJBHnItqtZOgF
         IpwA==
X-Forwarded-Encrypted: i=1; AJvYcCUuChS9IqZq3a5jo8p65bm7jJMbR3hDovV0viKjOhWYKHZwuLQfEa9cW1S8x++yXo/cBaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxs1HCzAGQxRsRfG7a2H4ysS1VINTifmuCmSHo6tqNbPBMf5dp
	J/Vc/VkvK20pQbaIChXrt3qOJjF8iwgzgYopkn60I2Bd3INZPYFTsX1plpz6MIYngHaBFgr9mj7
	v4ydTGlxWnzvYkjagKmeooB/2eUDwjFU=
X-Gm-Gg: ASbGncveR3SYXiH4fJLBWgENm5nfuk+2qSY1K8vLhMQL4wrXYHep4+R0a2Vg3LZfL1q
	S/HQnWwGPozNmFjZ9SQrWMovub0elbWjjqzHt+o2fXBAhL1ArTWmMpScs5/cxXjggp0Ky/9E2vV
	xXmhrIGIlVD5d0cJeWhL0uwGnTzLcuMVuHC9w5hX3QoSENPkqCBxIQ/nJmTuc2fyEWjnVY7N8zS
	98SGFHGyZkOrV6OK9iIM0u+0wv/ezJozAZcxwQWq/KxTrkMWRptxrwFNH1z
X-Google-Smtp-Source: AGHT+IHQxnJ6UxDSfledxMJutL/5MWf4VZEY0NZsh2A9h46fq8Dsw7mBB+FM0D/TL6ytOAfJTl2mXEMv0Brlj624FUs=
X-Received: by 2002:a05:6214:e49:b0:709:d664:3cf5 with SMTP id
 6a1803df08f44-70af5b92dccmr39650336d6.3.1755214879052; Thu, 14 Aug 2025
 16:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com> <20250807150239.6987-4-lucasseikioshiro@gmail.com>
 <CAPig+cSBg6oQC4Y81ieH25-A9cHRTfbqC5i+22RSBcbyVo_qtA@mail.gmail.com>
 <BCCE25CF-8546-4320-AB44-9B729C3D6DE6@gmail.com> <CAPig+cTQdEDZduG_UmdHn1JNfj7iTw0=jwdkX+VPJ11Jo0jUGA@mail.gmail.com>
 <xmqqfrdt3feh.fsf@gitster.g> <1ABC1E05-BEE9-4E17-8C6C-8BB4127378BF@gmail.com>
In-Reply-To: <1ABC1E05-BEE9-4E17-8C6C-8BB4127378BF@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 14 Aug 2025 19:41:08 -0400
X-Gm-Features: Ac12FXwfYrXoouJg2HYzukIJysLW7ylLAUDKnint3MdEVeczP0yuZm31VFhdWAU
Message-ID: <CAPig+cSkAqJ23ESdFeUePAuAB=j0N+NsrdEiW4onQpU9Sbki_A@mail.gmail.com>
Subject: Re: [GSoC PATCH v9 3/5] repo: add the field layout.bare
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, oswald.buddenhagen@gmx.de, 
	ps@pks.im, karthik.188@gmail.com, ben.knoble@gmail.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:18=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> > I also care about future-proofing, though.  When Git is built with
> > WITH_BREAKING_CHANGES=3DYesPlease, this test would break as the
> > default reference backend will be reftable in that alternate world,
> > wouldn't it?
>
> To be honest, it wouldn't matter what are the keys selected for
> testing this behavior. I'm only using references.format because it
> was the first that I implemented. But given that, I can also change
> their order to something like:
>
> [1/5] repo: declare the repo command
> [2/5] repo: add the field layout.bare
> [3/5] repo: add the field layout.shallow
> [2/5] repo: add the field references.format
> [5/5] repo: add the --format flag
>
> This way, this tests could be placed in 3/5 and using layout.bare and
> layout.shallow as keys.

I don't have a strong preference since I think you already
future-proofed the test by using `--ref-format=3Dfiles` with the
git-init
invocation, but the above suggested patch order would work, as well,
and seems sufficiently reviewer-friendly.
