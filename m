Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF92FC29
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708281599; cv=none; b=Z0ouQGwCdqYzDPfKjEllwi/o+R3Wf+1GlSPbyzzws5hMNCL7gOgjsiRhUgswOgdwitg3bzaTLQVvk/T7Bu95sWqaykAh93tn5pELmKkMrpq6ksop1Q5avR+jq5TLAH3jc89Wth1AyQ11BACEehmgkZWZljaP1FeU08q9bkwkJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708281599; c=relaxed/simple;
	bh=PN3Yq9I/7kK3LZ/00px3eDUfOEWxox4tt/ytiugUFzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LE4YIKWF0oX2Pss53syBKU5FK81gA4zvAnloK1z0f8M+qLxZ/gsE9e0QnUblO8z/gjiB+OP8/3AI0o+tePyGWLPs/ykRZM7eBio7QlvMxJA2PgzsgOohN0iW2p/7+gUgnpcjohckjd/HXxFIrU3lcGRcxlA9KTk6GT7f9TX1YDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d5c25267deso1651224241.3
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 10:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708281596; x=1708886396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXr+XBxrs41EY90Sa3orqqWfrLUl1eloWNmm4m8THQM=;
        b=lkKE24BNcvhNRaZdpw3Le6lzfaobcsgUUD//K2cPVYal6W/kUGh39OT+kRgd+PEMEi
         kwFIN26JL5aoA0xswP7E8f2FroWnUkLcZ+xDkSgbdV3WLMncvZB9gpHTIcMgVJx/Y/93
         cJ2f2UaAP2fEvrnvZSD+JFAFRKkpHxXq2CAehD83iZ5CKrHi8uOnOi0HEgMZ35VgNZuF
         E3/vc5bCZCt0TEb0eg5RwUmA3xbbf5nzOCltXpip0/6SxjQs5ddu8guwMW42tGkGYkVR
         Xry8+3WvTyleMyAdiMm1njWVGkmU2as/ddh1YKzakXyYJIgRVUxhfniGpqSgoF495YyY
         i9lg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Z+UohnYo3yl5io5pJ+i03yzdsjk7wIfQJ9kyQkivSULZEzyNpvTLOqmTaxRTqgurm3NK1WswDlTKuR7V+hKKJ6Eo
X-Gm-Message-State: AOJu0Yw0t0Xy1BYnAk6eMJdtpi9ohDArxQJscma0jzusQ0CfIgbIUjjJ
	g6YpKCT50513vt/uCXFo7L8q+Jm5GmBMc5Tg2npUn8cksTDsg6DG7M5JCbae2DyPQCfJUDopLip
	cq+9VgyMt7aJudkW5WQLAWMeH6OEc7sIF+VY=
X-Google-Smtp-Source: AGHT+IFQBeWVFCR+KYbuH8Ybh4Yh52KmbjzG5PCFPtaPMitq25xEAY5gyokGpwQHmtw0WClqzQfWESYC1zTZGjSkv30=
X-Received: by 2002:a1f:e602:0:b0:4c9:d0ee:bd67 with SMTP id
 d2-20020a1fe602000000b004c9d0eebd67mr463513vkh.5.1708281596533; Sun, 18 Feb
 2024 10:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
 <f7031316a043b36fac10ecf784d2294894967e7b.1708212896.git.gitgitgadget@gmail.com>
 <CAPig+cR_XYjArdYpU-qm+Wont=yEEXe5hANRyz+YRdhv=UZf=Q@mail.gmail.com> <AFC4D25B-D6ED-4706-A804-CA0183B84604@boanderson.me>
In-Reply-To: <AFC4D25B-D6ED-4706-A804-CA0183B84604@boanderson.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 18 Feb 2024 13:39:45 -0500
Message-ID: <CAPig+cTQ246qEMWe7h9E7nTZrEMSSoxiNGC1gViycXrAkC35Vw@mail.gmail.com>
Subject: Re: [PATCH 1/4] osxkeychain: replace deprecated SecKeychain API
To: Bo Anderson <mail@boanderson.me>
Cc: Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 9:48=E2=80=AFAM Bo Anderson <mail@boanderson.me> wr=
ote:
> > On 18 Feb 2024, at 06:08, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
> >> +    va_start(args, allocator);
> >> +    while ((key =3D va_arg(args, const void *)) !=3D NULL) {
> >> +        const void *value;
> >> +        value =3D va_arg(args, const void *);
> >> +        if (value)
> >> +            CFDictionarySetValue(result, key, value);
> >> +    }
> >> +    va_end(args);
> >
> > However, isn't it a programmer error if va_arg() returns NULL for
> > `value`? If so, I'd think we'd want to scream loudly about that rather
> > than silently ignoring it. So, perhaps something like this: [...]
>
> In this case it=E2=80=99s by design to accept and check for NULL values a=
s
> it greatly simplifies the code. Inputs to the credential helpers
> have various optional fields, such as port and path. It is
> programmer error to pass NULL to the SecItem API (runtime crash) so
> in order to simplify having to check each individual field in all of
> the callers (and probably ditch varargs since you can=E2=80=99t really do
> dynamic varargs), I check the value here instead. That means you can
> do something like:
>
> create_dictionary(kCFAllocatorDefault,
>   kSecAttrServer, host,
>   kSecAttrPath, path, \
>   kSecAttrPort, port,
>   NULL)
>
> And it will only include the key-value pairs that have non-NULL
> values.
>
> It would indeed be programmer error to  not pass key-value pairs,
> though it is equally programmer  error to  not have a terminating
> NULL.

Okay. I had thought that this check was merely protecting against
programmer error, but the described use-case to avoid passing NULL to
SecItem API makes perfect sense. It might be helpful to future readers
to explain this either as a function-level comment (explaining how to
call the function) or as an in-code comment.

> >> +    username_buf =3D (char *)CFStringGetCStringPtr(account_ref, ENCOD=
ING);
> >> +    if (username_buf)
> >> +    {
> >> +        write_item("username", username_buf, strlen(username_buf));
> >>       return;
> >> +    }
> >
> > According to the documentation for CFStringGetCStringPtr(), the
> > returned C-string is not newly-allocated, so the caller does not have
> > to free it. Therefore, can `username_buf` be declared `const char *`
> > rather than `char *` to make it clear to readers that nothing is being
> > leaked here? Same comment about the `(char *)` cast.
> >
> >> +    buffer_len =3D CFStringGetMaximumSizeForEncoding(
> >> +            CFStringGetLength(account_ref), ENCODING) + 1;
> >> +    username_buf =3D xmalloc(buffer_len);
> >> +    if (CFStringGetCString(account_ref,
> >> +                username_buf,
> >> +                buffer_len,
> >> +                ENCODING)) {
> >> +        write_item("username", username_buf, buffer_len - 1);
> >> +    }
> >> +    free(username_buf);
> >
> > Okay, this explains why `username_buf` is declared `char *` rather
> > than `const char *`. Typically, when we have a situation in which a
> > value may or may not need freeing, we use a `to_free` variable like
> > this: [...]
> >
> > But that may be overkill for this simple case, and what you have here
> > may be "good enough" for anyone already familiar with the API and who
> > knows that the `return` after CFStringGetCStringPtr() isn't leaking.
>
> Would it make sense to just have a comment paired with the
> CFStringGetCStringPtr return explaining why it doesn=E2=80=99t need to be
> freed there? I=E2=80=99m OK with the to_free variable however if that=E2=
=80=99s
> clearer. Idea in my mind was pairing it based on `xmalloc` but I can
> see why pairing based on variable is clearer.

Most likely, anyone working on this code is already familiar with the
CoreFoundation API, thus would understand implicitly that this isn't
leaking. But, yes, a simple comment should be plenty sufficient for
everyone else if you are re-rolling anyhow.
