Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17AA15F330
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330121; cv=none; b=opnEngYET/2Brl9di6IJRMOe9J9zupCf3y2lvNhXp03jehEbTbvn3oZy+qwCuukJ1ZTNL7UnoTFHfBsrzLP+Trh0vfKZlQQpajIsk6j6yy+Ak1+wQOprOIShFR0/+AZN+GSh4HkJRBddoo7X94i8O1H1H2I83CDhQSSQeS0qdN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330121; c=relaxed/simple;
	bh=z1dxEXfiZ98bXykgNEmBkU40aeAXF1sYknwB0LdQsfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkxHcbKJmtp4Ym7gjaOW81px4f0N3G5JGqbnzGy/4Ui/Ga5FkZTGJXYko7ZeD1+v01QV27Mi/eIQTcAjFkSBEUePj9iWCH6ItJ3d2GeCR6xgEzA+a9uy4QPwJ1KwR859fNVLUdf8cVIhGKxRtN7SB0F+QQ6D6wuLEoH28s+d6+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4677fcf112aso2324991cf.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 05:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738330118; x=1738934918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1dxEXfiZ98bXykgNEmBkU40aeAXF1sYknwB0LdQsfU=;
        b=gW9eLbHAe/fGi6trJMBCKdQvj49Mdzhhfu2ynprFBvSadDEsrnz2TWzWEoDxk1ZIze
         lGvHgw/ZoBjATF9bBHalLcej9cImBnD/wLX7gOj/zdsor/kWcFI3i/9Y+aCiS2TBG4yy
         w5o4xlloDF1VhciJbESAUmyXLZORtPgidOBUHFwhsj8VyL+FtsM8WijopjwPCYE/20qm
         VmFaQ4Lg/UwjHFtHteigS92kHMRrBukBRXONVJewWCZhDwO5jIHu19NU14R2ksABamJq
         QndtxgmXJ55JfmARx9aOWjJgzv6kNRv5SLLhdjKkaT9b7HLWPcjzDJuHOSpsHNGkDgnt
         gRzA==
X-Forwarded-Encrypted: i=1; AJvYcCWnLAG72JnmI/gXOjZzYx5mpfV864Nh7euuUfAUyko33Kvwhf+LAdXhJO5jvA0FffNjPxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDn3zWlqdKm244CxTqYpRnwLf3XyCCZnpq/KizXVlLoY2YJSfU
	2K/4d0h9fs7Qbsk0/5MqJVQyyUHkxzzUS2yffBF1Yn6jnPsFqxPyE5o7BueIkFOkgFlFqkYVVgE
	ic9ZmnFQnX6SnMp7A6LS0Moj2cWg=
X-Gm-Gg: ASbGncsdMrU22cCrdwHekHyQ4dD4DWVULVWAQp07hSnWFrBr2IYF/lh/E1bvlOCOoL4
	b+nsLoLdUSSnNLI6HSdKj+yvtqnPdISDOvvcWZNnaIANUYL5m7w1Yct0tnsLBLQmVOuIIQkvgDQ
	5JMgPnmRDak0o+rpDZabgcpHCna25H3w==
X-Google-Smtp-Source: AGHT+IGeoYArBWKBtms5L3HkzJGx9Sj3dFcw87wzHYW5yfmDirYj1UnsYM0eC23KO/vJo+epHeQoHt5s+OBWE1xenQo=
X-Received: by 2002:a05:6214:20a5:b0:6d8:cd76:a44d with SMTP id
 6a1803df08f44-6e251ac2f2fmr37757446d6.0.1738330118678; Fri, 31 Jan 2025
 05:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1829.git.1731653548549.gitgitgadget@gmail.com>
 <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com> <CAPig+cRpKKpVHT8x6nOx1KNjWR=hywz-nHZga9fhiXMXD7KOSw@mail.gmail.com>
 <116C27A8-EF7B-42E1-9606-815FDA3CF94C@shopify.com> <CAPig+cSdbjzTmsBOmFnMxzYLGrUzY46=mkW9S+si2KxLhS623Q@mail.gmail.com>
 <F15C12AB-2238-4553-AFA5-18277B18CE5A@shopify.com> <CAPig+cTHfD1fK73+S3fqQ+Oz_VpBzap5=nFFE1bntSeaHLcu8g@mail.gmail.com>
 <CAPig+cRv9Z2mQ964PNgbbgk+ByGvC1EMNc6=-itD_7v6_4Pg+A@mail.gmail.com> <CAFLeGL5L=Pv4RH7-7Os+khewvtxHDTX+a4hmmORz=b_e-1FLoQ@mail.gmail.com>
In-Reply-To: <CAFLeGL5L=Pv4RH7-7Os+khewvtxHDTX+a4hmmORz=b_e-1FLoQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 31 Jan 2025 08:28:26 -0500
X-Gm-Features: AWEUYZn8JZnNV05C22N_bZynRjhIEepVG_3XskafnVO3kHWjtG97mMt8aYgyrA8
Message-ID: <CAPig+cQ0J+R5PqXAFOFo_R4a7cZe0zJoBhBGdf-QB20o=cKCjg@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: detect from secondary worktree if main
 worktree is bare
To: Olga Pilipenco <olga.pilipenco@shopify.com>
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 2:05=E2=80=AFAM Olga Pilipenco
<olga.pilipenco@shopify.com> wrote:
> On Thu, Jan 30, 2025 at 7:44=E2=80=AFAM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > Examining more closely, I see that your message was in fact multipart
> > MIME with an HTML portion which was using <blockquote> and whatnot,
> > which my (plain text) mailer stripped out, hence lost all formatting.
> > If you can configure your mailer to send plain text and use the normal
> > ">" markers, that would be generally helpful on this list.
>
> Ufff, my bad, sorry about that (should be plain text now).

Yup, looks good.

> I'm having trouble responding to my previous email and keeping that
> quoting format,
> so I'll not waste time on trying to fix that (please forgive me, everyone=
).
> Just want to let you know that I agree with your response, I'll adjust my=
 patch.
> Enough talking, let's get the code out!

Thanks.
