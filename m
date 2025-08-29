Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749782866
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429999; cv=none; b=SmZoSxWU8mJ19s1+P+YENeW3qLO70/bVvSazof1MSCulQyh25ZETY4NiOR6HFLajHIxmXviVGcT3cV2DX2rCAL5iYAJ8PnZI3E2FmYNLoCcQN2KjQzEKVwL7sCmrVcrW29gaotvG23raBNrTPvzMeZF0UrbeMLMnSsgLHjWHib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429999; c=relaxed/simple;
	bh=GFGtP4HYrj1b3GT4WA/fQBKaqDJ1A98t5UtiymCj3Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxXkXY6Up1invJkQ5JV3CXMGqdF38QqYslLjHXJ5mKpFwO/Su+Mn1Se0mdxhKLijpUyt+mJUJ5HTgEje/pQIWA8CyYFH0ADGW2tCXkckcBU2cKwkDiyopoixo9U7oHfzKzg8y8pH0SgxKrf9FykJyHZOXdQQxoaZC5Mr+/qKDNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj5VmD2i; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj5VmD2i"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-315bb486e6dso16384fac.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 18:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756429997; x=1757034797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJic7L1DL0GbAhgNjYBc9RMpmy0Bic6i8sVWuWRoxwk=;
        b=jj5VmD2iXCWNY2ugsegk0/4jf0Kivjs+VzEynogl32AKHBU4To7mscjw9oekoW0qtA
         qwGjyHYZOBmtf0m9NKubBGss2ng913jK2raisKXloDHiqTWTpZEwquzRuwMnSu11qwFd
         eFfS/qE2HorQxSdD9Ba/RbujUVYFk7+qmBbbxszMNIJZAFFUm3HHvSAgfdw7x/JbDh4M
         HxD9Tk9mFmyIncBvijk1Qo58rT7Ywkf0btlDQqh3+CzPA0XU3Fc/AeWzdk9PWOx1MLjt
         v9Rk8BYWsINC35ruMFgrSzasVbcVQFLpge50A3QcvtUz/BZm/QdBi14lkKw91N8f5oRX
         E33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429997; x=1757034797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJic7L1DL0GbAhgNjYBc9RMpmy0Bic6i8sVWuWRoxwk=;
        b=FXZVTLLJWXF8PBRSbyaFNTDjPKGOfUCMtGr9dK52qajQ1qYF2eqF+X8Z2rxna7CN2Z
         GUBekbowVFLJ+eAn8w3RauNMZ5SEvPcq8AqwE5dG7mSF/3cfVo/mChCu5kYZo10ywnd6
         SIfOD4p/y2ByfvC09+qd70S/9Ic+4hunCYNnDyJeBiOi+Htha2Lv+EqkJHkihxcz3sgB
         c0qY5qC3FyU+clRI7ZO5+HE9nf9ma61Lp8y35cTbWH45XmtJz4sb2ijcSVOsjiX/Bnzl
         /ct1wbWL5VM1Z1lldsfY7PrC0+5Zhi5i8LjFRaXHxrz0WLWZIGE2hoA2DiKWSdxwj0Qv
         S8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL9wpihRZOsUfFY3wceWKLW+2zYYySf1w/KaUvrJhzo0lJ4F3zNesVQc/qPrNQ3ktIgog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqg9dreSr+qeqQUlThPHlSw1UUJ7jNolVuLOj2cSY6LEs/Ul/T
	UlR4NxbfGpxAvbI13rmVyXOilSGi3f6GBffcFU3fjq0njfXBHjXMMF7y6TaOplFBrcaPGIaKhGn
	YjOgYX0lXJFrdxTuW1mXLVnpAx1B4f6M=
X-Gm-Gg: ASbGncsFwBYzzw9P7ReZmTv+8Ay5wybGwHki0n4DQaF88jIbU4zr2K3pqs+l8u2uzh+
	upXhB/ul5K5UJ9bBUAThyB9pFlMvMSlQ1DbPeX069w86U3SWru/jdd0Q7cOiTOyBahbqX5SRrvQ
	UkS7gc0a2pdK+XyTXlK/4tNM5ORk5I5cVV5F652E/lGlTAPiiwRInJlv+3cE+GsXz+D2aO+yW4I
	b5cCA==
X-Google-Smtp-Source: AGHT+IHHA5LFF/0pNrCMGcjE5ePMSChe/7b5PpYgPAx/cRr46t7LIdR1w75mfaO4BETPmA/P8XELWHUzx771+cksACc=
X-Received: by 2002:a05:6870:9c8d:b0:2c2:4090:9e8 with SMTP id
 586e51a60fabf-314dcbb8b8fmr11928928fac.22.1756429996677; Thu, 28 Aug 2025
 18:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728190520.10962-1-amonakov@ispras.ru> <xmqqa54oun5w.fsf@gitster.g>
 <43459416-ced2-d551-40e3-6db594ca4520@ispras.ru> <xmqqecsvqal6.fsf@gitster.g>
In-Reply-To: <xmqqecsvqal6.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Thu, 28 Aug 2025 18:13:07 -0700
X-Gm-Features: Ac12FXxRC-Lghh5ant420o-7EtEOlZ23VeNrB7VYRuWaHWmhOdw43Twng-HjpwY
Message-ID: <CA+P7+xqn6hbahTAbLcnDspz-LHFrkFVMq_o8on4Hmez9HUiNxQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] optimize string hashing in xdiff
To: Junio C Hamano <gitster@pobox.com>
Cc: Alexander Monakov <amonakov@ispras.ru>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Alexander Monakov <amonakov@ispras.ru> writes:
>
> >> Using xxhash() was merely a sample code path for technology
> >> demonstration, so the Rust adoption topic may want to pick a
> >> different code path to do its thing.
> >
> > My interest here is just speeding up xdiff in C, is that a welcome topi=
c?
>
> It seems that the (side) discussion on the performance has
> concluded, and Ezekiel's new iteration of the Rust thing moved to a
> non-overlapping part of the system, so I do not see any reason to
> keep this topic out of 'next'.
>
> Is everybody OK for me to mark the topic for 'next' soonish?  Any
> objections I overlooked?
>
> Thanks.
>

That seems reasonable to me.
