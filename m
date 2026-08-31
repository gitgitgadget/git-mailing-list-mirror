Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2764A4405
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196168; cv=pass; b=nOSyxVdNYIA6G+3X9gKaFi/mBwvuII12hCcf3ySe4Zj/EbdedD4jDIq8H7IyIJ7QukbatGkEEo/wei0X3jpQ75CLFrvpMJ9CeyumY91hL0VkuJT+GEzVjO6HmnTedXX5Y2C+ktYdfQUYFH50Zcuj+ijA/QLijbWiH2ZCC5VbOpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196168; c=relaxed/simple;
	bh=fTHY1U3nzjZeI0TLExs3pQ9QuIDB0WH78GvH3G5Dnhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qnacv0oGJBABNJHy0TvoYa1yGQ9iZLxN/u4S25gZe5SRyekQ+oNbtcAsDIwMzc9ctxh0FFc9Q74HwRavuEo6VpkHgZz3+WnAVNbES5FZxkXbr7TK9olxPOvQmGzMXdHZVqN5N4JSfiifywyoCaBJBKu1+JGcvq+NP1u2R8gqD5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvQ5deaj; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvQ5deaj"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f3ff92cf4aso3939746a34.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788196166; cv=none;
        d=google.com; s=arc-20260327;
        b=ZDeOd5dXYE0n40VNce1G+w0fu/BSldaDojq2Z8ldBUkH/RKvO3axn8Jium3TXN6+oj
         IJ5biCWTvH7I+8WgtWI98CE2o79mr61edSUl8O7/Ttx4Gyg0oyMvqJvPYRPtT4KnXMaT
         n74g3l31v8poeQxaTL9faMut4dF6oHxYsB3BD0NfvSSxTs34mz+Neca0WSvwGYykU562
         Yy3I1NAqXzaZkCFS2CTWCGYNM6uIgePufHN764UdTVx7ZUNT1FZ/O9emtxQlKaLsjf38
         k1jUN0ZawVMARmLt5Lxc8+kHXOkDND3/tYeWLtXtOjrO41r39X4F+Q2uYIQE7UfT6GLs
         OTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fTHY1U3nzjZeI0TLExs3pQ9QuIDB0WH78GvH3G5Dnhs=;
        fh=SSUWuFhxMYV6ppXtqOZMmvNk7lvDD72X4tCX1vPPE70=;
        b=nX/t7DeozTybc7N/7M3xbIjDnkTCKXDtCdKy9OnxctDe4Pf0z87KgTQ6Aef7iNj6FK
         lxVJFS34cvrf74RRj76XXRIHiqRC23pxu3xw+/onNH0rc4DN6oTm3NhQqaJa5EFCHZFQ
         pg7kSZ+8zvVdBs1PKaDIu1qBS1MwtJU3SjlvpWfuKp6UWlKqb9JYx7g46GNGKv9yS+eg
         zf6+zy+HLAvsN1JYUfSaLZXH6BzpOjKtwsfiNAARjso+jhcUMuijjl1ctgeoOt6rbqXu
         v8fx6YYEj6JfoWzJpkBx5xsjo2azIZH/mAxYNtKWTTO74gjSMLmywA0MqoSJNetfN134
         ftNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788196166; x=1788800966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fTHY1U3nzjZeI0TLExs3pQ9QuIDB0WH78GvH3G5Dnhs=;
        b=NvQ5deajq5HIJzLCCFlzfyqNpreKIyEKn2zEbg8WmAA0rrSBgUZjkCSZZLkaDxGrEL
         /V5h98H4062kPJIr06AGQv/f0/dVAlT/ZKPKh4+XOLLNPdwNSD6BpGaAg5rrI0PrRFy8
         i+RHdDeBl0nj0xWsxh80vG0+rstP0cmAJ3oEAgB5ZyRC3sYDzsXunTs4g13fwBwjtJQf
         oSO2LHnCVhCiQLmFY+Mkz/AbSBC+ZUVxiBSYFDl8jLkZbN373Kj48S0R/t/XoH6WUqkf
         iK8NnZw7lhVa+xTXPzoOeYSC0yLU9LaJDhkWwyqE5xq6/PsxFbIpBzi9jwtcC3kALOCd
         eOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788196166; x=1788800966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fTHY1U3nzjZeI0TLExs3pQ9QuIDB0WH78GvH3G5Dnhs=;
        b=E7ZdPeJ9ShjmN4bPoQk/heax27BRQSspWRthhRZFNt+WPprNW7szyd6IqS5NERXB+3
         f+bxhb4Kega0/OUehz4wBUFdSl1kdApFqQzvocFPwK4aTXCs0JBGnwD4WnFgPvV7qZQf
         CilK/Dt8MjuhNC47VCGvqw9JG4YDiCdjANb1CbR7WEmfFD8jxqGs7t9CF9zsq3IgmkJ3
         1pE+ue0+G3uMgeCEEqys/Ycd4C1nWLDLhJWAnHMPkxbqfyLh6eu4L45s1DWXsP2sRlq8
         4tLORNwnw3ohVj28vqrNySPLynQDJwJgAk3NQMNYduYagMx58XxPgWrSEJomdYEbbxYr
         zVSg==
X-Forwarded-Encrypted: i=1; AHgh+RrVqZC23uN0Jdj5/S/0E65YedjK87jNRNqaUrmbgZDl9FA+UMafKbBYAHBDQt+R2n+SQpA=@vger.kernel.org
X-Gm-Message-State: AFuF++meBydz2lI/pHG2GKsAU9jXqY7T57VywqGX23yVqFZQSk6aGJi6
	SbLCEwupbil8SVWgbwTJwFH82UF5lQ3OklESLqSk4E7jmQT50qgWTRu5j4hAKzS7C5QBgUhH8Nx
	GMqZM+Lt/gUTZLFtc8DZAuE7LqyBsga0=
X-Gm-Gg: AR+sD12zk4QSoaHh+WV1Z6+aZD4xFVBFZo7CCpp0uD8c+K2Kih+LoMLPqKX2EKUNTQN
	Gd1X5SKJKn0qGNPSU9nheqpMRGJyi/elGF4X8OHbYjhUwGLAVrP9ov2Ms9rJZyebrBDyQk2Yg9D
	84rCsvR8DYVwiKz6A6lIGL+Tr8cI8f80Vi0QNu2SWEwHemHhzsqZW19csOSOiFeYci5tl7JVQin
	X5YmmHUIQuZvbtaywoSkVnIcvGa1E6NjaDZPef1XhBH8HVRIcvQJ9dU5YCH3bwZv9nDSEpEIIrX
	ZFmuf5YTQmUYU+Fbi7tG+QRtpz7pGw6hY9plKshvuOZMgP7bdiuSomcxp/pP8mNRcjJWoqvf8yG
	TplMVxYqzYYgmc4vu1JH3UyVDmimC1Boe8RqBcME7wECVedHWX2pSOs8V8FevI9s=
X-Received: by 2002:a05:6830:3105:b0:7e7:76f:3ec0 with SMTP id
 46e09a7af769-7f687c09d4cmr2473575a34.15.1788196166210; Mon, 31 Aug 2026
 10:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v3.git.1786583137.gitgitgadget@gmail.com> <8ed22c02a192e10ab46c7df61e92a3669faaf25a.1786583137.git.gitgitgadget@gmail.com>
 <apUqs8N3EnTFngyQ@pks.im>
In-Reply-To: <apUqs8N3EnTFngyQ@pks.im>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Mon, 31 Aug 2026 10:09:14 -0700
X-Gm-Features: AcwNN1WyORwMYPGzuAXj6QETd5TRzKML-zdEuLKQo-g3dJp-CThqgBv-mb9KGGk
Message-ID: <CAC2Qwm+L01XZgys2NGtZwWfVapWmnqDbsevt3Z4WKpS9EoP65A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] t/lib-httpd: make http-429 first-request check atomic
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:18=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Thu, Aug 13, 2026 at 01:05:35AM +0000, Michael Montalbo via GitGitGadg=
et wrote:
> > From: Michael Montalbo <mmontalbo@gmail.com>
> >
> > http-429.sh returns 429 to the first request for an endpoint and
> > forwards later ones to git-http-backend so the retry succeeds. It
> > remembers that it has already answered 429 by checking for a shared
> > state file with "test -f" and creating it with "touch".
...
> > There is no regression test. The check and the set are adjacent command=
s
> > with nothing in between to synchronize on, so the overlap cannot be
> > forced deterministically, only reproduced by chance; the fix is
> > preventive.
>
> A lot of AI-fluff in this message that could have otherwise been much
> briefer, but okay.
>

You are right. I will go through all the prose in the series and re-write i=
t
by hand. I apologize for giving you unnecessary AI-fluff to read and will
not do it again.
