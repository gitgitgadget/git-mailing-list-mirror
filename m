Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41F137E
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713496046; cv=none; b=FNcZpOyvFaraSNpLzpYt+7g+4+G7eQtbLcG4XG6LUBD+0M9jVZ0LfO/efwhdH5cTi9CCoV7AJv6kwNau/4JxG47u42+aYNO0+azGcg1qM85UoHso3j5schIpoSYdAJwFnv2IUh8z//tg3fSeVFnyw/lDGdofLlZBdICZrhZSECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713496046; c=relaxed/simple;
	bh=zOkUYyTAJZ89dWPJ+FK99zc+t2UhqKzXbf50ccoAULU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If3pODQrqZtcR2AVLgPERFhT/FIaSN5iEpws4bTRQTfxbGwDvfWQTsx9SvKFlCzgwOdwy9z2E2Nq4xasY1prgQEnljrj/S1W7OKqAVlKWaMZ6GzqvqddKUeJZ/wSOEHC9LLh+vu/VbB/TPaC2cvaOdUTp+WbupdoLPL342TtQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69cb4a046dfso6104996d6.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 20:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713496044; x=1714100844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oicPEW1HLiHSEeVfQ5+jUpUzTQ13mYJEQggXo7wq5e8=;
        b=SpELKJdVZhX2lskqlbhp62B7IEVlDRP2RxfFdJmfU+u8xuQip9wd/2AUDgCowfVBnp
         wh9PvbxyT4iCZp2Ig0sbU1ILKejOl8jFcLfe8ZGOf4OivfV1ffsBY0KSkySYdANSMOEC
         TFUAgK0K1poZ8fIwXX7R32MB8SsmVbZYILrZzOIHoJpCKCmHWt5WjJbA/GxEQu7HZN1n
         Eb5hi+W2a79CdgS8zcNlnfp8c3xTe5Td/LXF3ECMqZElwqCcFACUo4PLEVlghpvyNeRe
         WonNQ9k/DtS7ni7k52QP4za8+T03csyp9Blz5KsIecj1VFHjFl6wGd2irbKJgHJCGcG3
         POPw==
X-Forwarded-Encrypted: i=1; AJvYcCUJHeX1a+puK6a5rt9npwXs9jXzdGDfzQRC8M2Sj2u398CAp+R5gqxVCr9JMEc73WpQwJqQ2M+1zb8GbuTTvHLW9zIp
X-Gm-Message-State: AOJu0YzDAqycUh/9F7Hs2m7ttrhKHAm1UUXt/I4CjWC17BrZMcVvj77w
	nTHVhlXoHTerEhOVN9c7rotZX2dI9+7sD1uWcUZ70zxyahSdZmntCeksZWLgFZYLGOLkPPKDpN6
	QBgHU8Sd53LkDXQNVtjHjKuEvIr0=
X-Google-Smtp-Source: AGHT+IHOxrbGlj7Om4CfH24xBRsfKhXZ+Jjc5dc0niBmmUL+1XV7B506Db/PesdHUQZTLJywcuKvBxU/tTSHtH87RFk=
X-Received: by 2002:a05:6214:c63:b0:69f:db85:ee9a with SMTP id
 t3-20020a0562140c6300b0069fdb85ee9amr1125688qvj.59.1713496043809; Thu, 18 Apr
 2024 20:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713324598.git.dsimic@manjaro.org> <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com> <xmqq7cgwau1v.fsf@gitster.g>
 <c2cb9268c29ae4a5cac34383b7443763@manjaro.org> <xmqqle5b66sr.fsf@gitster.g>
 <19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org> <84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org>
 <xmqq5xwepafi.fsf@gitster.g> <CAPig+cT9A9N=zGZDXuB+c17L8hZ-h5zvZgD5W-8VYqiM9QaBew@mail.gmail.com>
 <xmqqedb2nlpf.fsf@gitster.g>
In-Reply-To: <xmqqedb2nlpf.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 18 Apr 2024 23:07:12 -0400
Message-ID: <CAPig+cRpxvYAJpHahsWxRP=ekr9wwWoxK9_c0vRehDiuzgP72g@mail.gmail.com>
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 10:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > I do understand and am sympathetic to the desire to reduce the typing
> > load (hence, the original `--resend` proposal), but I have difficulty
> > believing that `git format-patch` is so commonly used throughout the
> > day that the time saved by typing `--resend` over
> > `--subject-prefix=3D"RESEND PATCH"` warrants the extra implementation,
> > documentation, and testing baggage. Likewise, I don't see the value in
> > `--label=3DWIP` (or `--rfc=3DWIP` or whatever) over the existing more
> > general `--subject-prefix`.
>
> I am not interested in adding unbounded number of --wip and the like
> at all, but the value you seem to be missing of the separate "--rfc"
> is that there are folks who configure something other than "PATCH"
> to "format.subjectPrefix".  They do not want to keep typing
> --subject-prefix=3D"PATCH net-next" on the command line, so they use
> the configuration variable, which is "set it once and forget".  The
> stress is on the fact that they can forget about it.

Indeed. I was unaware of that behavior.
