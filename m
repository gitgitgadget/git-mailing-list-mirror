Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB127702E
	for <git@vger.kernel.org>; Wed, 14 May 2025 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227982; cv=none; b=H/+TEpAiAnFdSJNiDw0cjUf5Kd3VgEn62KkIfcf4GJNzasQ6ABh2KoT+wPcpbOcNtnywoJ98BkytIymYEgftFmZF/3Orso6FZNW9LPj9KwlQ1LhCjf/HeHy2PgJMYeF8IKpNpWQECd5gilaAVEuPJfBRV0ylxYWBMiAeuopZz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227982; c=relaxed/simple;
	bh=vK/ELqvxiKeB9TOnsDxqC/Zctk38fYQeZ9JcR2n2bmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0mKMGfeGvY9xo030UUFz+8cb9vcYhhnNN8TQew1bGHsZeFFmslk07q0G1v+KLVua3UoTs4J+f38IAmuK6/dLGb+mLEJNiFrP25mP8x+UHdvQI2nMp3xOisWjqBXNEOonHmVoDKxefZQEE/nLnZvYdiy4V2bbGbaaYpOQ9NxXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2V74bSu; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2V74bSu"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f548a4ea4dso67905486d6.1
        for <git@vger.kernel.org>; Wed, 14 May 2025 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747227979; x=1747832779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frd9JtgpXdpHPrmd8EnqZXHEuyE0vezdx0cN0cKuNvs=;
        b=P2V74bSuUi0vfa7+VtADcpRG19Vr0T0uRmWHGCkzbJobuDTqzqbfMkCu8Ekbf+GMER
         oycs1+0AcXZnRrBk1YzBesQfrqRN6keDatif2FiWqkkCxstxREAlEGabd20H3UhRg8GZ
         peUTnZPS71N4MenbG8pewCjLDC3q+aLrJdUd0/vCKc7DzBifI+elDtW3uY3yP48IGjZT
         IgR3ZfRtZvHty605io4l8fl+kLEOEjAKqHgFAzTdWEUzoBRAut1zNQQN/wAt0nAVL9Xe
         z0Zxf0qR+KxCysWKGGlaWnkKAhKwu4HylrbxjdqN83FHiwqbdfwDwpRGr+mujC/8tchT
         0UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747227979; x=1747832779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frd9JtgpXdpHPrmd8EnqZXHEuyE0vezdx0cN0cKuNvs=;
        b=qNoVn9s1Er4qGIXofBT+tkX8HC+Ef5ZuRH1hLGTxrrGGnf4BIGlKS+MmGiH29/P9B4
         lCP8CDVj7wNV33sQbmpQ57QbIYiLOw2aBUpIe7G1aFg3aZbPVNmk3daGS7V1kS9eRMZQ
         uQk3YRFHAGll9PTyUQoU3rTWNdaIA+m99EpUvTslGMofBw4wN+0pcznBtb4hiDtJiGMO
         g8fBryjmkXifrRmsfrJjfxDUn3Mr5V6/Sl93aD/DYeP3ESLfn/P1IA/83tkGlhT/DGYW
         CmKi2SCdXDCyp1eIdPGImEE2tUeZYubKU4kcCmwWgYXRXrP4xF1+HKSnk5qEv447XHFa
         Vpbw==
X-Gm-Message-State: AOJu0Yza6fc6F/kHNWE1CYE7Pu4MdJkHQ9aRzssYuDV88j2tiZfRhXnN
	T4R+SNgzRAPUeNZsVuSl+IQsTCEi23qU9Ru3JmmhxQ7BptMEV+X5NSbhKPfiBnfgekQyrKxZ10C
	6TDc1qW9UsG2HygvvF1WcUdHobw4=
X-Gm-Gg: ASbGnctbkvMc8RV/w7lxx2VTCh3JHFYF6ekOsd7OnMBeEpAzEWJSIH07Jz4qrk5w6dF
	AhSXg+yaLwlkgrcRmqOv5+UJQNqpxQcsJav1bfx0XDDgHkHE9RRbV0Az7XqnZfm/oFtilxoWO2a
	iGJq2uPv8MtSDMe48gGpzItirBLin+B6PJXiA1YGQY4fob46ta6PF8W1hzaqW8T24jnJCmWKTXU
	wk=
X-Google-Smtp-Source: AGHT+IFMf24GPddJ0ZZ4IX5SnNhF7E5Fy1Tmz8IHL4QkYEWtWo+30ONWNuNTFVvROg12tNSZokESOhsAm7MCQsDDh38=
X-Received: by 2002:a05:6214:2623:b0:6f5:421b:623c with SMTP id
 6a1803df08f44-6f896e57a5dmr51585776d6.25.1747227979219; Wed, 14 May 2025
 06:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqr01si441.fsf@gitster.g> <CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
 <xmqqtt5ncq87.fsf@gitster.g>
In-Reply-To: <xmqqtt5ncq87.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 14 May 2025 18:36:08 +0530
X-Gm-Features: AX0GCFvXcM9JCTPJXjj0iHnem0wBvA9uiyUJFCuU-qOOkluqMlxX0_E5FmIjXTI
Message-ID: <CA+rGoLfcJ2r8S515msG5L-59=0nOBvdOX2TTn+-iaHw8v6Ndtw@mail.gmail.com>
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, levraiphilippeblain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 6:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> > git shortlog --no-merges --since=3D6.years -- Documentation/MyFirstCont=
ributi
> > on.adoc
>
> That would not work; due to mass rename, you'd need
>
>   $ git shortlog --no-merges -- Documentation/MyFirstContribution.{adoc,t=
xt}
>
> or perhaps
>
>   $ git log --no-merges --follow Documentation/MyFirstContribution.adoc |
>     git shortlog
>
> or something like that.
>

Oh I totally forgot the extension was changed to adoc
Thanks for pointing it out

As far as I see

Emily Shaffer (9)
Philippe Blain (5)

Have the two highest logs
I think Emily is not active in Git
So for now I will cc Philippe

Thank you,

-Jayatheerth
