Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC4257D
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737328638; cv=none; b=cLMup4YMCuiKxblSk2pZVbG68r1wSB88FQN/+uRUCwuopRSIPHImf3Gj2i/+3rGEWCcn7SW4uLMRKjPiVL9hVPKCZJq1MEtIDGK1ROaLKoVRdJhDfMQhnZAD/XbI0kdr39gmKy5FZRYOaT3bccRLHe6jmgafBB16rXI14pprW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737328638; c=relaxed/simple;
	bh=N7lZXA+OZv7zzWUAV+vEoxJK6GU3LGaWMjleu9wWGKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMeAMixMQL9apRUrmUX3zqQ+svcng+R9Phbw0bFRHO9+zr6Tx7gSfMo0RJK6acNb+B/KWYw5eZMoiE0k+UBk3VSPZmkSQBu5XKZYnyp6/BXJ9AzJfeup7lZFOmtq4C0si1RAypThicFilYUeWgJJrWuGcbb3WDrcSUnHhTG6T64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN9Kf1Rb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN9Kf1Rb"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so671518766b.2
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737328634; x=1737933434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3O4/gIzVzJ3UgGK4etz7g+nNzdflCsrKhJ2BSG861I=;
        b=JN9Kf1RbaIyTp7UmNiNJQrxnY7yQ+z4oGxNzxhroA9qcwq9xbtpXdezVo47jSWkAI2
         xnRtUc4QGxMQaG02qQ1dF9SidA691z15bEWYkS5Lc7Outq0KF7HQuSMjwe4QrMXFxdnV
         stK3JT45NrrV82dqo7NbZ94rlcJc6KC0BhX7eKO9bgbscGbY3j9roCi5szxO2TYnGerE
         kruo8aDWhr40AC5QAZH2oigkZV7j4GUSJQdv4GR/nMPHtxEHWPSF61Y8N2tSGMjIYKBw
         HAHL4KZx/C6rbMLcu7jMPCPYgmqRvJwGWwm3wUmN/6t7Lk1db38t/gnshN+TACWvIGvs
         RzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737328634; x=1737933434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3O4/gIzVzJ3UgGK4etz7g+nNzdflCsrKhJ2BSG861I=;
        b=NGlejlFFLWDMBE9zLqt5jb36Ujvp3sjqWCMj2W5JvWr8kUFVV5EmYbZLrZ8MYO87Im
         pJFaiHvJGa+8sMtfPdmqHDajwG1CpcuhHir+m3DDCOSdYyrNs3U8A4r4BM8NhPG5t/vo
         uPMxezqWVr7QHsuWT0V2dfmchDEITi8IX/8hJ0zuv2+rQbJs49vg272onyIxe1YgbtCU
         XtAO+yOEMdgxcjsWXjv4WWheGhPuj0BT9LkAjXSHSWvfnFGk0dPpoBJ6pVJjXGpTZHAY
         L/RYdEP+/k0TWKbN5n1NvUsG3StE5lRy15/lVybDFpvvraNvnLjIugU0bTbeibEfTHmS
         JTKg==
X-Forwarded-Encrypted: i=1; AJvYcCUfY9odvP8gj3JYXguwnJeD9lwF+Yp+EpUpv/CFTPQc0PtL9dMR3FGrGvrCII42pv4e1wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxofekyOLyLde407v+xo9kblzsdXjW2jRw9dTKQcCJZn+apJXdV
	HcTwf6Dfgmg4n1b5F69JeK2BkRUcdnAaXN0hWFcBukLgWid1Vt9iwfr47PV/mJ6nM67PBxcNG/a
	zZFNqq2uaymZfwgrflF94BfqddYRAEIOc
X-Gm-Gg: ASbGncsrPKOvhQ7hhV0V0Zgr+hdkNp2+pV9ChrzY5DzQ3jbMuvoC//og4AvPtkBkM9Y
	FBNuNG5Kld62KvMheahc10mWfwkJgJH+hda9mBtRJSbDIXFxJOcYeQ64j33SBAZaE/ux0ujgkl9
	2NuVwrsyA=
X-Google-Smtp-Source: AGHT+IHQDAX4LVRcdsA0iM9e2hZRBpV1uZIVVlT/m2jMSG4jMQ7FvfnsiOVQTPW/Bh8b/hQYJqCjSyeNDyXzEb6CJto=
X-Received: by 2002:a17:906:4442:b0:ab3:a2f9:d8cc with SMTP id
 a640c23a62f3a-ab3a2f9eef5mr641039866b.41.1737328634297; Sun, 19 Jan 2025
 15:17:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1878.git.git.1737066042014.gitgitgadget@gmail.com> <xmqqy0zanzdw.fsf@gitster.g>
In-Reply-To: <xmqqy0zanzdw.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sun, 19 Jan 2025 18:17:03 -0500
X-Gm-Features: AbW1kvamvuSpn8ZjNb9P3_oVlMWi_oBftYWbNWBEhyXoT7vfncfPu3uuBYqWCAM
Message-ID: <CALnO6CBUbmZaL1NuG2RxrvuxbUexKdtKfgYi2jTDY3QEa9NQkA@mail.gmail.com>
Subject: Re: [PATCH] grep: document negated line-number, column long options
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
> >
> > I set grep.lineNumber and grep.column on in my user .gitconfig;
> > sometimes, when I script over the results from `git grep`, I want no
> > prefixes, only a filename prefix, or only the matched text. I usually
> > comment out the relevant config sections or use `git -c` to tweak them =
for
> > a single run---why? Because `git help grep` doesn't mention they can be
> > disabled any other way!
>
> While I am somewhat sympathetic, I'd prefer to see it done in a more
> centralized way, so that people understand that *any* Boolean option
> and associated configuratrion can be negated by prefixing "--no-" to
> the base option, instead of having to learn "Ah, today I learned
> that --line-number can be negated with --no-line-number thanks to
> this patch."

This makes sense, though I want to also make it discoverable. Relying
on `git help cli` is not quite as discoverable as I would like, since
I wouldn't have thought to look there myself=E2=80=94further, it isn't alwa=
ys
clear _which_ options can be negated in the way `git help cli`
describes. [Returning to this midway through writing] Upon
experimentation it appears the answer is "all long options"=E2=80=94TIL!

I wonder if there is some way to point more folks to the conventions
of `git help cli`?

>
> >  --line-number::
> >       Prefix the line number to matching lines.
> >
> > +--no-line-number::
> > +     Turn off line number prefixes, even when the configuration file o=
r a
> > +     previous option requests them.
>
> So, this is not quite welcome for two reasons.
>
>  - We do not want to see us keep repeating "configuration file" for
>    any negatable option, as it is common to all command line options
>    and associated configuration knob that the command line option
>    trumps the configuration.

Fair=E2=80=94as you noticed, this isn't really spelled out anywhere, but yo=
u
have patches to fix that below. Thanks!

>
>  - We do not want to see us keep repeating the substantial part of
>    the body of the base option by adding a separate entry for a
>    corresponding variant with "--no-".
>
> Even though an approach to centrally teach people that they can
> negate a Boolean option "--opt" by saying "--no-opt", and thatn they
> can negate a configured setting with a command line option is
> desirable, for such an approach to work, the documentation must
> somehow signal which option is Boolean.
>
> The way we do so is by doing something like this.
>
> $ git grep -e '^--\[no-\]' Documentation/
>
> An example entry (this is from blame-options.txt) looks like this.
>
>     --[no-]progress::
>             Progress status is reported on the standard error stream
>             by default when it is attached to a terminal. This flag
>             enables progress reporting even if not attached to a
>             terminal. Can't use `--progress` together with `--porcelain`
>             or `--incremental`.

Fair enough; I dislike the `[no-]` formatting because it is harder to
build into a search pattern (I have Vim keybindings to search manuals
for long and short options that it breaks), but I will probably live
with it and adjust my search patterns rather than complain further.


>
> As nobody complains that "I cannot understand what --no-progress,
> which is described in the above, means", there must be a central
> place where we describe this convention ("git help cli" talks about
> negating options).
>
> So I suspect you'd only need to do something like this
>
>     ---line-number::
>     +--[no-]line-number::
>             Prefix the line number ...
>
> in your patch, without doing anything else.
>
> Thanks.

Sounds like you would prefer a re-roll that does something similar for
`--[no-]line-number` and `--[no-]column`? I suppose I have to
wonder=E2=80=94for which Boolean options is it worth doing so?
