Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0C14885D
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946471; cv=none; b=CtAkv9eAHJ8vs7g57/2krpe2lH/vdyZuX9nrczz1O1C5KQDlF1RVXSzfgBz5z+hoxUNZhsVhKKDy1zS/y0IUIgQxZ2+TstIEKlpNOrtyJD0VNETIB3hvTIoI+LXwywkqkBIWr+jseatkk0nSnh1UDmEEK55LAQ/I1n8e5lUe2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946471; c=relaxed/simple;
	bh=lQvKYaQMpJjgvu0+Bz5J4g2Hsd97Pj4O3Z5pctIFbTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDuVSTjb9iK1a19RnvZKaw5MCzuCmj872XTR0vW7qnnwfdI2dvI5c3z/GdZjpHBVE5UhpMEXPGRH9Weaw7eTFYDGe1BRu5WtvRniXU+4Ur1aEDRkCuGcza6HTS7TVbjbh4IiXcOwQIEfS2SRf2KO30BZdkBNG/kN7usI1HTnjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKOmjYiZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKOmjYiZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so114130a12.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753946468; x=1754551268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7j4CDWOqFwnJmDfdQa1Gf+iDkR+xmBHjFklZPzmyLk=;
        b=QKOmjYiZwFo9x9StVFKy3abjKO1YX97a/h7x2vPn9kEfXPSqzXQRiUI/K1TuHXVIWX
         OWdbBjGn00pNdg7W80ka4PccmkEBO4zxwWuvVcHtvg7ZX9yRnd+f37UOSn06fcQr7Pbu
         aNgj2f5iP3CtmEJwqIZEFfKBfSFUuCQwaLgauQBPKT06iLO7nnb57ztoKZSIPkUJoNWh
         16ZXuAKLNbWDKtV/G3AxmjqY14q1VoXs4HkJJaTKx6WlqnXI6dF81jNALCEjbcdRPJDT
         7YUSCXSp2GtXFVU7LmnjHhSzjFiTALKT02y8p1b9r2YXg4FT2IJHyDgbRPyzT5QT2Ye+
         3Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753946468; x=1754551268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7j4CDWOqFwnJmDfdQa1Gf+iDkR+xmBHjFklZPzmyLk=;
        b=iHm1SROSF2Vbp8W4l8NyPXdSb5M7bvpgB7FY+xmqbJQKqLStikRxe9H7PJbKNvAWup
         +5Vd9yHECyONrRnvJx+EoAbmX/P6zrzW3caSQSryfMmmGYyw7EOICLWOx/m+waTal+wX
         gpecVXUZ0QZKHhILj89m4KBnCQoH4qsttSGFxzpreokCiCVSopRy5Y9z+DIxmkmgMi7D
         KY2WwmXqmqtmVYPumnIGp4lp9k4ckCJMNzirve+mG9sg6ADLaicnq8pUnYmsaXJm7W+x
         mbwb9vfISHGWaWY7Fg374S7VxNhywBaLk7nmLLHqJ1Nb9hYbGh8/0Vr11VKCZD1ev90c
         cKCQ==
X-Gm-Message-State: AOJu0YwN0BEBP8uSRy0aM7sqdoHxtnKLlmlFd3I9GHpro1+l/MT2VKaB
	5pb4mk9CGO+g+CfV3AGQL6jl0GlfFGL7nWsxLHHw/h1Uu2Y+sv140eUAokbt5sitSW/lEm1tOYO
	qIzkCdDWmJSJlVk9pzGdr2CzgJfIz92ZChg==
X-Gm-Gg: ASbGncusyxBnyRRsayWG90p/5u0HcUJcZujbdjggZtD91ud6+2Vu8Gikh8xskzISmz9
	ZKWcki0f5F0Pz/PQn8Gaf1vqXUGwpOtGnY+RVskKkhOkcx6+dMjalCfl+MafImP2VtQexbegyyB
	XpD8nHUH5Leb0gHphkb25UTj9xb1STZ6zFyIAHVRXgWAAXRHjYisvkC+YdE0mx16HMYpI2lotxJ
	p1Mk605ZA==
X-Google-Smtp-Source: AGHT+IG5NFIL6bQkRPxjNS3CGNrl/pu+fTYL2xEtDPYHGjwfVMY6s85OfmV0fsBUT8OwWXm+hYIMGLB1megeNWb0/sQ=
X-Received: by 2002:a17:906:eecc:b0:ae9:c494:1ade with SMTP id
 a640c23a62f3a-af8fda4f577mr659617066b.53.1753946467478; Thu, 31 Jul 2025
 00:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250625125055.1375596-1-christian.couder@gmail.com> <20250625125055.1375596-3-christian.couder@gmail.com>
 <xmqqbjqbsbe0.fsf@gitster.g> <CAP8UFD1wYXrEC2VYBHTL7NS1ksSa0oiBgB3Ua=6V1SnP=+RMsQ@mail.gmail.com>
 <xmqqtt35xtng.fsf@gitster.g>
In-Reply-To: <xmqqtt35xtng.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 31 Jul 2025 09:20:55 +0200
X-Gm-Features: Ac12FXwjkajUwCglpMz-lSoQyMF2L1EZigHGDWlC1_1skmrKdphR6f9L4c7GaGs
Message-ID: <CAP8UFD0scEUQ1X6gX+ZTKE_z05RESyJi2pq8Qa0MhS0CxjMQVg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] promisor-remote: allow a server to advertise more fields
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 8:53=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Ok, I have changed it to the following in v6:
> >
> >    To allow clients to make more informed decisions about which promiso=
r
> >    remotes they accept, let's make it possible to pass more information
> >    by introducing a new "promisor.sendFields" configuration variable.
>
> A meta observation, as I haven't even thought if the above proposal
> makes sense or not, but a reponse for v5 like the above that comes
> nearly at the same minite as v6 highly discourages any response to
> this message that may want to say "oh, that is not a good idea
> because ...".

I am not sure why it discourages reponses. People can still reply to
the v6 patch or to the discussion that started from the v5 patch or
both. The discussion from the v5 patch is not obsolete if some
comments have not been properly addressed.

Also the fact that the replies come at the same time as a new version,
means that reviewers don't need to context switch as much as if there
were for example some replies at one time, then a few days later
replies to the rest of the reviews, then a few days later a new
version. So for reviewers who don't like to context switch much it
should be better if everything is sent at once.

> >> By making it easier for casual humans who manually write the
> >> configuration variable (presumably while testing) and allowing both
> >> comma and space as separator, this design decision is forcing one
> >> more rule to worry about for those who are writing the parser for
> >> the value.  There may be some existing configuration variables with
> >> such a "leninent" syntax, but I'd rather see us not make the mess
> >> even worse.
> >
> > We indeed have a number of configuration variables accepting lists of
> > items separated by both comma and space. As we cannot fix those easily
> > for backward compatibility and they still make things a bit simpler
> > for users, my opinion is that we'd better bite the bullet and make
> > sure we have a simple and hard-to-misuse standard way to parse such
> > lists.
>
> The position is understandable (I am not saying agreeable), but if
> one takes such a position, this series will get even longer, by
> requiring such a refactoring and new set of helper functions in the
> front of the series, to avoid making things even worse than they
> currently are.  If you want to punt on that "simple standard way"
> and leave it outside the series, then please do not add such syntax
> to the variables in this series.

I'd like it if there was a consensus on doing such a refactoring
before starting to work on it. So if you are fine with that
refactoring, I am willing to either add it as part of this series, or
work on it after this series is merged (like for the recent
cc/t9350-cleanup patch), as you prefer.

I couldn't know your and others' opinion on it (and I am still not
sure about it) before we started discussing it. Sometimes for example
you are also fine with just leaving over those kinds of bits. So for
now in v7, I haven't changed this, but let me know and I will make the
necessary changes in v8 or later in separate patches.

> > Yeah, it seems to me that there was previously a sentence about what
> > fields are, but it looks like I removed it by mistake. Anyway, before
> > the paragraph about what the "promisor.sendFields" configuration
> > variable contains, I have added the following in v6:
> >
> >    On the server side, information about a remote `foo` is stored in
> >    configuration variables named `remote.foo.<variable-name>`. To make
> >    it clearer and simpler, we use `field` and `field name` like this:
> >
> >      * `field name` refers to the <variable-name> part of such a
> >        configuration variable, and
> >
> >      * `field` refers to both the `field name` and the value of such a
> >        configuration variable.
> >
> >> What do we call the third-level of a variable name in the
> >> configuration file?  The description on the "--regexp" option in
> >> "git config --help" hints one:
> >>
> >>     With `get`, interpret the name as a regular expression. Regular
> >>     expression matching is currently case-sensitive and done against
> >>     a canonicalized version of the key in which section and variable
> >>     names are lowercased, but subsection names are not.
> >>
> >> So a for remote.origin.partialCloneFilter, "remote" is the section
> >> name, "origin" is the subsection name, and "partialCloneFilter" is
> >> the variable name.
> >
> > Yeah, I thought that "variable name" could be confusing, so I prefered
> > to use another word, "field", to talk about this.
> > ...
> > I'd rather avoid talking about "variable name" other than to explain
> > what "field name" and "field" are. I think it would be too confusing,
> > especially if the name of the new config options are still
> > "promisor.sendFields" and "promisor.checkFields".
>
> Sorry, the argument does not make much sense to me.
>
> After all, the end-users who follow the documentation needs to know
> which *VARIABLES* (in remotes.<name><VARIABLE>) to set to affect the
> value that this mechanism lets them send out.  And the configuration
> variable to control which of remotes.<name>.<VARIABLE> are sent out
> is a new thing, and it itself calls it a FIELD.  Whatever name that
> new thing chooses to call itself, the fact is that it is about what
> the users have long known as configuration variables.
>
> So, what makes this whole thing more confusing than necessary, to
> me, looks like your use of the word "field" in the first place.  The
> use of word "field" in "sendFields" and "checkFields" are much much
> more recent than the concept of "configuration variables" that has
> long been established in users' minds (as far as I know, these
> "fields" are not even in any released versions), so I do not see why
> we want to keep it and force users learn yet another word.  Just fix
> the name of these new configuration variables,

You mean using "promisor.sendVariables" and "promisor.checkVariables"
instead of "promisor.sendFields" and "promisor.checkFields", and using
"variable" instead of "field" everywhere in the documentation and the
code?

> explain that they are
> used to name other configuration variables, and be done it without
> uttering "field" even once, and we would be good and less confusing,
> wouldn't we?  Or am I being too naive and forgetting some already
> established use of sendFields and checkFields?

I just think it will be confusing because after being sent over
through the protocol, they are no longer variable in the sense that
the client can't (and shouldn't) change them. They could also be
confused with environment variables, so perhaps
"promisor.sendConfigVariables" and "promisor.checkConfigVariables",
but the names will start to be long especially if we have to say that
they are from the server when processed on the client side.

Also I think it's better to use a different name because they are used
differently, serve different purposes and have different rules applied
to them in the context of the promisor-remote protocol capability.

Anyway if that's what is prefered, I will make the change. For now in
the v7, I haven't changed this.
