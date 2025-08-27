Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F067280A5F
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756330050; cv=none; b=ZBe/rWV68Z9qBmUvMMk/0wkGYymjxnunNlb5249Ytz1SxmLD0Gm6VcYbaZzGl/QNZSVrq4Z4cvJUAaDjRqhgs7f6fa51tXPwRlxMIVacYHXpuUzpQhsIQ5ejq7Qo9Cfr1Nh1Rkiy3whg2CaYh0vq2vRau8oAiRE+5QSg2hKvgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756330050; c=relaxed/simple;
	bh=ezfEi97YhhEIGoZx0d8LP5QrobdtnClviewdQ+oO8tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mv5JXgPcU6NZx8I32ighHWYk6WCm2xVr6UelWp7ikwP/ezoHuP2kiNlQhKeH66lLzS6/QwEgcSWQSyswOjX4SusyVvY5/zVF8cYNc86Z8reVv7MkE0AWhc9VuWvwenw1V/fBNSYYW4yh7SdoEATMuadX3b73N0fFUzNiCHX0qcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e870634d93so463885a.2
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 14:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756330047; x=1756934847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnH0PaZ2y6zPLcHwc4V2LEW6L9BKZBxdM2ivs1iYiVg=;
        b=uAzb0rPMHQGS8yI1dU6RApQuUXrWcZ5wed65E8NC7in575SLnFvKMCmgkWzL5Hn82V
         3gAiFglDkf9B2x2hIoZH521kw62QJcL+zDANdRJFt+uK9A4y25trGmqE0l1WGIBpMmAm
         /pD8isRz/urRGht8pRrs0Qg+hzkQGK44qgO0rS5FMHKvz4anSinSr3FgT+60geNXQPDX
         cqegcodOMCMP4JraISzUswSHgRo/GmnZTPDFky6d6cmaynEOT+ZORkWQzjl9wNzln0P5
         k7L352aQhmUjgSFzf3TA2mcH49xU0x0X0UetFneQ17sOaVmy+pH8JkSjgLmF6j1p/a0D
         6zuw==
X-Forwarded-Encrypted: i=1; AJvYcCWu3mWmTNkOzyg6TshF9u4//NhTocR4pBjTunOTi1kNNvZCSIz2SPnlxq+7FHA9qWCAlK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsdI3rWYLfYsTHrBby/yhqyYkGA2nmc/wzfKkylIurD9j6bqoc
	jnadtk1MYA/Bytv1jyPMFcT0gKGcHroppNPh1gyZfEeoAbmJjeiE95WE8V0DlbICh7PQZw2nbqf
	k0oH3prKKN1TJCxZUysFuEy/eQBix+6mCrF3h
X-Gm-Gg: ASbGncvggOTMtEgOkB2LMYgObqTm3YtwdCjjtkk8MEwi3oRHVPLDcu5VkvFRdpKItXz
	i3NQDDI96OaCg4Wfr3sMiJ+XnzUG0MweMj4Upj8lL5uEnMWDreNIGwuvKVRw/wN32Q41JymS2Pc
	PoPVVLY+8Nq+kDsi6YGNTg273NV/JnmbwAh/CGqS/4jCPkjbPH/cbJ9DRX3NzotWVVeTaE6bcOh
	3GaYiJBffL0ceOu+CXQTlb7Th73/4zRFXsHXm9O3VeH+HH9koM=
X-Google-Smtp-Source: AGHT+IFwhMpB5Dn4Do+M5UMhYQ1XsECrQIXmjqZB/02awDeWsWzarIeBtw1pNgrhgIIuldd/kpbRQ3ZZwDgjRHAu0Z0=
X-Received: by 2002:a05:620a:2a16:b0:7c0:b3cd:9be0 with SMTP id
 af79cd13be357-7ea11014951mr1500512785a.10.1756330047268; Wed, 27 Aug 2025
 14:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756311355.git.code@khaugsbakk.name> <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com> <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g>
In-Reply-To: <xmqq349czcl8.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 27 Aug 2025 17:27:15 -0400
X-Gm-Features: Ac12FXyJfe668aQvXv5F0GpBX2OAgwdmSl813gmGO6QN0tRYEtQjGnm-a8X20Js
Message-ID: <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > That's still inviting unnecessary emails, isn't it? It would probably
> > be better add the qualification that people should send the email only
> > if they were unable to find any workable replacement. Perhaps:
> >
> >     - send an email to <git@...> to let us know
> >       that you still use this command and were unable
> >       to determine a suitable replacement
>
> In practice, people will respond to such an instruction by always
> sending an e-mail.  Asking others who sound as if they are promising
> to give answers when asked is cheaper than investigating themselves

Thanks for pointing out that my final editing made my suggested
wording too succinct. What I really had in mind -- in conjunction with
Kristoffer's patch [2/4] which provides hint(s) for replacing the
command being retired -- was to reference the provided hints. So,
something like this:

  - send an email to <...> to let us know
    that you still use this command and were unable
    to determine a suitable replacement using the hints
    provided here
