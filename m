Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F60D148857
	for <git@vger.kernel.org>; Fri, 30 May 2025 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748581272; cv=none; b=gnMV6ZR9VzDWK5v7lVHzcpC9gXrnL+4Hm32NCx9xNnsPJtMaE22y1vLWrhDnGe8GWUFnJUdNluG9CuwyUY6/1DMNZXwtzjIyZqDuuzFmFX4wY28VrnG6ZGsgi6FR+o+QrDJj3BXz/wjxULfQ5QpX30P8pNRuE0V4yv9tOGwww8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748581272; c=relaxed/simple;
	bh=jzkvYMBrdKHXO4wPZQzN+As5k0IrN3atqAn1wmRXSoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7nLd21Fp1cljSug9cNE93C//bsV8MwYRVH93vMdTUvtL7MAWgxBQL+9GfAHe1WN2K1FS0bHjVTdJ8Gm3FP4JvjHeOg7YcMwR5i+bkeLtvOLir3ABWkfM8LfZFB864tGr1eKhirSAqHaLk2rXBSbTEnENtYd/s9gPbkjnrzXqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fabba1706aso1972846d6.1
        for <git@vger.kernel.org>; Thu, 29 May 2025 22:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748581269; x=1749186069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhB8N7e+e6Y3GT4Av6lYYZ4TC4QCNRWHPKRkMJv80gU=;
        b=b93ksU4C7apJjBZoQ+62A5mwWYOFlaIf3VJJC/pklq3PJDQWpt2y25qbmDm+DfSLDx
         szqKUnetKf8NOree8wW7b2eLIrKWX3VnBPXafXo1xlp/lUFhwEjJBZpsObL/rvoBwY62
         myX74HHZuNEdeH7Mx32cnY9n642aDmhBcLH6sfPp41DNh8h3RMisGcgQ9RdT27tJDqxL
         LbbNyZmdMhISIlExsYDPWjZePUbR++mBV1PNjL3VndiW4Cwu7KsQdhg+aI6Bn1BFw9e5
         E5E1BcnI1COZrcsUNQVZDy7wRzgKJ78Zs4I0ifocxmE4BHCkY3lvSk0OJDhx/hIUatq7
         C5fA==
X-Forwarded-Encrypted: i=1; AJvYcCWOFoclnpNl81grZVQPEtyb/X67x2buYK4h7G6sJjOW3kBI9Gj+39lfe7PZjpeAAqHgCnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9i2F0RU/ThmVaBKbfKM9G+O/wS2rNlnl4Tqq06ddPIOc2JEy
	XDFDTJcjnDP1W+C/lxfliLz5hrteLlmi24e5jx3OU3hZIsiDwb6OkP7PUE8nBs+8E5BCPPomJMn
	7HK3bBOJsJ1zSjwALWkL7dQtgcMVU62c=
X-Gm-Gg: ASbGncubA5TuYy6W5IA76MuxtY3IhEDeFp77KGVHBJe7mGKM/UMWX1rX1KnfMU7KLAb
	SAdAuCTs950Pgw/WJHNcHx+38rGKsPW2S4L6atH4IEapD+pAMWYDuI1QKLKH1/ugbMMinRUiXg0
	qi8hHjYNBfsoKwBrURqCBu6gOmyNRt+RWh1rPczGnt2I72j8RXsGvFZF0pH1kfEJJrM4OyqhxP+
	tgO
X-Google-Smtp-Source: AGHT+IGDi/35gz4q8bNeX9f3ZfkKN92guI+yJiyY36nu4KssxEaENBAKuzHSyWkD1LVitpQsOvmGtyXehluq8Ezp9c4=
X-Received: by 2002:a05:6214:20e6:b0:6fa:c46c:6f84 with SMTP id
 6a1803df08f44-6fad06afc56mr7524176d6.1.1748581269012; Thu, 29 May 2025
 22:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
 <d8d8c10d-4f4f-4fde-8b91-b979e2931fad@app.fastmail.com> <CAPig+cTdN=x2GXGW2p_g_k4jgC0eQmjW5zLsWhJm-PP7eMBTiQ@mail.gmail.com>
 <4c1f645b-42fb-40b9-987e-08ce9e057e01@app.fastmail.com> <CABXyHXoCuwAUqiQPxE82mV4n0PQtY1zopD+rJDb+oyTkR8qwyg@mail.gmail.com>
In-Reply-To: <CABXyHXoCuwAUqiQPxE82mV4n0PQtY1zopD+rJDb+oyTkR8qwyg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 30 May 2025 01:00:56 -0400
X-Gm-Features: AX0GCFv7holgSZxh_5ZIk8jumQnMcfxvCZPAn3nH5mQKlbRpEVVOtSCvSyi9CaA
Message-ID: <CAPig+cQbchWLMH+pTVfLHwFshaex2vhC8Pk57EC4U-vch00ZDA@mail.gmail.com>
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
To: oneee <kimww0306@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 11:43=E2=80=AFPM oneee <kimww0306@gmail.com> wrote:
> On Wed, May 28, 2025 at 4:21=E2=80=AFPM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > > > +     word "patterns"), and (2) the sparse specification might
> > >
> > > I would also use a semicolon to separate `1` and `2`.  I think this i=
s
> > > the correct style for any list introduced by a colon:
> > >
> > >     see here: (1) ...; (2) ...; and (5) ...
> > >
> > > Because then you can use commas freely inside each point.
> >
> > I'd like to push back on this suggestion, at least in the context of
> > this particular patch, the purpose of which is to fix an actual
> > problem in the documentation. The sort of improvement you suggest
> > probably ought to be done as a separate patch, but let's not make it
> > seem as if we are heaping extra work on the patch submitter; it's more
> > important to get the fix itself landed.
>
> I'd like to apply it to the same PR in GitHub, producing an additional
> commit. (I don't fully understand how the system works, sorry).

You're welcome to submit an additional patch implementing Kristoffer's
suggestion. Normally, it would make sense to send them both as a
two-patch series, however, I'm not so sure that that would be a good
idea in this case. The reason I question it is that the original patch
is an obvious and uncontroversial fix, however, Kristoffer's
suggestion -- because it is a subjective change -- may get pushback
from reviewers. If it does get pushback, then that pushback could hold
up the entire series as discussion ensues, thus slowing or even
completely derailing the original "fix" patch from being accepted.
