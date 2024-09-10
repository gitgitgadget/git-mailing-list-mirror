Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58B188CB4
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956093; cv=none; b=tDjUzZeWNyKzZzsxCCn4975DJ4XVH4mz+LOtV8RJ3jTB3+0T4SrfkzeNXGF9/nwTbNIl73YxE37hZtedC6elhkZq3pNrKzej2r5FacOsu7ToZbghfon+GDoA1U1TOLhpM+bnXDMmXgLbQDj/gAt5TU+LPR27LBAk6MPC+nE7o4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956093; c=relaxed/simple;
	bh=kL26Pd5UHk/6sBuNE2GopbMx4r94VIxI1WX6xvTT4Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZtGfPGWc5KJUljUnubTaRHPif7o5FnmKY+U+9qSsUyW5SCYWyYDRzwjOmX7I2gFAtQ744/1a/oNhA2S9pbM8l3pfpO2w2wonCS0QDhmynOOB0Atxz+ykanE5PMqguDUL12Em5H0568r8WLznExB3od/ntc1NUnd3ou9GdJa4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c354ee1eeeso3459966d6.2
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 01:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725956089; x=1726560889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV0tjgLuHzLVCdELgq/jH6l3q92zh/SkQJ6b3I4cddQ=;
        b=k2YblIA5HMTN/EWFP0LwBIsV62HN+ZKRELsDICCkBLtHsoz5pD0eefA+g/xHliddpN
         CwdmGBxTFfjoz1SDINDmvXU3H034rtF1WoMtXjwuqvcE4hB971ERVo4ImhmllmP+61M9
         NdWwToFqxtFJBlPWDMV1dPZM2RFkRSE/tKzrtcyVnfie5U30OGm77EryIDer432jmj80
         Oy7ZNHrQuvs8U2NVI32du1BKtVuB/LkhbULF79IqSdcyqaOSd2IhcuCPbf0gAmdSlK5T
         ZogLgUSrKMRR5CDiFWYKiXowrAwwcTXycuWzrYc3dhwgXzCAFd9IX9WM0KMRIfqcJAy+
         0u8w==
X-Forwarded-Encrypted: i=1; AJvYcCWmOyFv3vC/o4tLZiWHzHZbdc/DO5Yidmh2NgNID6SIa9PoqAl86+R9hKdGTvbFiKr4OM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95ATGkDSIDBnYX77oqyjAHKuYCaREi/KQpRh1qPOM3qavBmgf
	PUfmOdoZ1hRXw517QBuB1wIO+0CUyV3STaqgMQ42p7NStfg+TQBpXFafak01TrwZbmVSYM/UBC8
	5xhV95ft1h6A6eY3N94KcLTh6nls=
X-Google-Smtp-Source: AGHT+IGQGX0etiewtfoXNCVtsiWxESVo5pbdbfm1p6DgquhfDy3KRg+naO9o36qR88ysE18q0Rv9ab2MkeJIEPFTJDk=
X-Received: by 2002:a05:6214:b6e:b0:6c5:2516:ffbd with SMTP id
 6a1803df08f44-6c5285108f8mr77874356d6.4.1725956089165; Tue, 10 Sep 2024
 01:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240910041013.68948-1-ericsunshine@charter.net> <20240910041013.68948-4-ericsunshine@charter.net>
 <Zt_5zMiu4QRka5x3@pks.im>
In-Reply-To: <Zt_5zMiu4QRka5x3@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 10 Sep 2024 04:14:38 -0400
Message-ID: <CAPig+cQZhrG+0BJkDbmKY11jxSspod2Xp8tSQq-DGOO9qMbR_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] chainlint: reduce annotation noise-factor
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 3:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Tue, Sep 10, 2024 at 12:10:13AM -0400, Eric Sunshine wrote:
> > [...]
> > Later, chainlint learned to color its output when sent to a terminal.
> > Problem annotations are colored with a red background which stands out
> > well from surrounding text, thus easily draws the reader's attention.
> > Together with the preceding change which gave all problem annotations a
> > uniform "LINT:" prefix, the noisy "?!" decoration has become superfluou=
s
> > as a search "needle" so omit it when output is colored.
> >
> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> > ---
> > +     my ($erropen, $errclose) =3D -t 1 ? ("$c->{rev}$c->{red}", $c->{r=
eset}) : ('?!', '?!');
>
> I was first wondering why we didn't have to change our tests. But this
> seems to use either coloring or the `?!` decorations based on whether or
> not we output to a terminal. And as our tests output to a non-terminal
> they indeed see the old format, and as such they don't have to change.

Correct.

> One thing I don't like about this is that we now have different output
> depending on whether or not you happen to pipe output to e.g. less(1),
> which I do quite frequently. So I'd propose to just drop the markers
> unconditionally.

My knee-jerk reaction is that the "?!" decoration is still handy for
drawing the eye when scanning non-colored output visually (not using a
search feature), so I'm hesitant to drop it. However, on reflection,
I'm not sure I feel very strongly about it. What do others think?
