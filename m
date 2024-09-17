Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA326296
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726595441; cv=none; b=RA43mg1db2OJ0HRFxVHkstHXw95OIKrXFem8HRJmcXqng8sDjONSFtemABNiLNQg5GKnSFF5MaVt3dB2zZB1nLaAdQpYVJiQp4fuAa2AciiZwf7Uei63O3nU4GTffESzWWbUazEVkaZzGoMynisXOLPghRWt+EYW75qgu5o0N3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726595441; c=relaxed/simple;
	bh=9FBd+RXrI3AZgjbi+3vbvCRnehIY7v/syZBf+kCMqSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+/zQteyi5boibV6UxYsu6GjHW6PDFGJvuKDaFv4TuzyfqZxY8Wy909D09N2JV1IE0gaGRGmrAExclRY2TiWRbBU+MP5zd/gizedYsfMOBOjlsD7j98lBdVih92F4lJ1LuoZi1SK3LAlFke5IQDdUHwUHDC+YcpgBUwIpfbsKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c362879f70so5933976d6.1
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726595438; x=1727200238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzwDKCrFGAV+IRC8piBx+DZ6vLyaAQGGjZXE1wIezAQ=;
        b=jl2CUliLcFisypnhGLeq5p0sW1rSxvxZZ6SkVix6SMOKw89ak16mIw33DhF0cWBLHl
         52zymYS3f0zF039s2NHB2/x3QFUR+EWo/tQbTIlMjNS8jvwK9cIN4L2fP50mMjt8OM2F
         ltYbeMy1aCQpGl8xsoz9zmSgjRcFLq3kSJJ96piFzhO/Y+j4xxubUcUyg8bAeb6loZIW
         0pjQ1uVVewK9iRLKiawQOALm79l66TOn8kzMaaKZFKHWg+1GaYWC5B2FCl2Gz02zi17/
         bJadY2VSO9d5lCUpLYGbzeYh6zWxbuw8qo0GYasnE6sBZqblO7NfuRF9HYTS8WIOa/r0
         +/xA==
X-Forwarded-Encrypted: i=1; AJvYcCXViWZCbWaW8jzLqUqRtytjPE0YfOwcY+y8hwB5mQLsAdpXY8R7LdDLgKynvr4fJUFbLLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGeWpYwPW5a33RhJ8SwubjPTgQg/xcw23ajGh3uCcfo5sUgZZ2
	FFQed4dlolKejhBAc1ExL6luWGk1DXPgOZNEm2z3tmI3hWSUynsgNbbzSw0TNXxKDUVKfhFs/Qf
	8Xax3TCAZibKzsamGI9bnWnuxet0=
X-Google-Smtp-Source: AGHT+IGedK7AAyGLGm6zFfWJFEeAJ4N5x6Ti6iNjss2XKQdBhWWlnSRrG8fPlvYJ/IzlrsQ8O3Agb4IrzePosGqwHN8=
X-Received: by 2002:a05:6214:2464:b0:6c4:5764:debf with SMTP id
 6a1803df08f44-6c57351cac3mr158193986d6.5.1726595438217; Tue, 17 Sep 2024
 10:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726578382.git.ps@pks.im> <ca3eab99f7ef86d1b7a5b4d4bdb8d2b0a55566e1.1726578382.git.ps@pks.im>
 <CAOLa=ZTja-nFmKZ8iyyp0szuaAWAnPncy0E6rM5=WWgnr=01uA@mail.gmail.com>
In-Reply-To: <CAOLa=ZTja-nFmKZ8iyyp0szuaAWAnPncy0E6rM5=WWgnr=01uA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 17 Sep 2024 13:50:27 -0400
Message-ID: <CAPig+cQ_+C65V6Rj9uCBKJy-rdymRd93-0S_w-bfSSJj82Zsrw@mail.gmail.com>
Subject: Re: [PATCH 1/3] refs/reftable: introduce "reftable.lockTimeout"
To: karthik nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 1:46=E2=80=AFPM karthik nayak <karthik.188@gmail.co=
m> wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +test_expect_success 'ref transaction: retry acquiring tables.list lock=
' '
> > +     test_when_finished "rm -rf repo" &&
> > +     git init repo &&
> > +     (
> > +             cd repo &&
> > +             test_commit initial &&
> > +             LOCK=3D.git/reftable/tables.list.lock &&
> > +             >$LOCK &&
> > +             {
> > +                     ( sleep 1 && rm -f $LOCK ) &
> > +             } &&
> > +             git -c reftable.lockTimeout=3D5000 update-ref refs/heads/=
branch HEAD
> > +     )
> > +'
>
> Nit: This does stall the test for 1s. Which is slightly annoying when
> running single tests locally. Couldn't we achieve this by doing `sleep
> 0.1`?

`sleep 0.1` is neither POSIX nor portable.
