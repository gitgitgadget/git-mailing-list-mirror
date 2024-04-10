Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE779CF
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789955; cv=none; b=qSPkEvSQfQ8gg8Y4TB6dYCqYV+0UymoYlnWgF/Ib5Qa2REUtkgIsFVCRyXnpb18ljMERncJrkV0UBTcA5d2emK5D2L8oCCVQKcxYwBjRHJXdB9O/XWBftJCfmzsA/IVFve5y0BDO2lKuOTEEjr3Fuwi9OqSVtj1vyBFFz6QOvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789955; c=relaxed/simple;
	bh=jXib2I9vsL7UGSzmfoc7JS1509aueMmA7yj0V0V3Y+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayR5Lm6LqeojKL7RiLWi5t3KVr873nWZutRFsW1DAhhEoZfcXqGKolQm4Uukm9ypVZSgM9xfmKoNdkS2xd2tJ73+cC1SJP6HW6Wkdyv3js6ASMartijGLoqUof1bWh+3Ft7YihAyADPupXXaKWxiDT3bEPij1ygsXlrc7VZe4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5aa3af24775so2456923eaf.0
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 15:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712789952; x=1713394752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzP7ZAFGoqXkyd/AoIVTfty8XQUXeWA/4EKQNxbGA4o=;
        b=m2e66mbr7W5Hb+QAiPGZO6T+XtuDfaiVINwPRyX9UldW5G8hwMI8rA1Cbe6x1CwHPz
         bdMLu0pQqJbCJEac1lHBOzkH0DCtA/hJevaxqQNLhzZCdekHWjpwBFDnQOgitZYu8gLK
         M0S2JvfmwzBKw0MxEJx12nrxEaInZG91GVL5RXD4QhZu8qcJ+SxWHS7in6At1ne7QAKi
         MNen8JieJni8thYwmSYrpzUuOzPGsOTFIaHynXynW8/RdOtx+k7p1uIKqX4GjvI5S4GF
         tdhchIR8wimwTrB11c8xT/6Qn5ZPFTV6dsi2X2yABHiCTSLr9iET1EtqhlkgWMb/UBE2
         vNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpHrLcZlsOXFYDNu0f/VEEjxEHbvRHBMhkFbcP2MHIjfZrbRZ3Cu2FDyFPNvyGUtLFUKFxC5mDE95l/KYIevGvAIng
X-Gm-Message-State: AOJu0YyLqqbn52Bj6Y5x3ZbEX/5vFDEIASaEZgmZvIf1+bRndKfHZeiv
	gY0147r/AXb77tJmip+oza8FAR7e+N20IVNchprotiy9ZRfpt8wITIz+YMqcU+P2ptGVqL1O3wD
	9VjCXrcNHhBeY91KIKaKj/rU98H0=
X-Google-Smtp-Source: AGHT+IG0V0YfgWDHTxIgzql8H0uTEsAexnq8LHusWljwqRKo3wJSZIetL02bAFqpx9z0PupViuRqB06SMfSgUDn0plA=
X-Received: by 2002:a05:6359:1907:b0:186:3ae:e13c with SMTP id
 mf7-20020a056359190700b0018603aee13cmr4841919rwb.0.1712789952631; Wed, 10 Apr
 2024 15:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712732383.git.dsimic@manjaro.org> <c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
 <xmqqh6g9w5bf.fsf@gitster.g>
In-Reply-To: <xmqqh6g9w5bf.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 10 Apr 2024 18:59:01 -0400
Message-ID: <CAPig+cQ+VV_Raxsk31vG8H4D5NjLsW5oFCA-o28raqrSRhi1TQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] send-email: make it easy to discern the messages
 for each patch
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org, code@khaugsbakk.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 12:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> >     MIME-Version: 1.0
> >     Content-Transfer-Encoding: 8bit
> >
> >     Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
> >
> >     OK. Log says:
> >     Server: smtp.example.com
>
> This is obviously in the realm of subjective preference, but I find
> that the prompt line is distinct enough among all other output that
> we do not need an extra blank line to locate them.
>
> I'll let others comment as the "blank around prompt" smells quite
> subjective and do not want to be the sole reviewer on it.

For what it's worth, I had the same reaction about the extra blank
line related to the prompt being unnecessary, but I didn't feel
strongly enough to say anything about it, and I still don't feel
strongly enough to suggest dropping this change.
