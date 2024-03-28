Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B11849
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652904; cv=none; b=dwWzgZ3qhjGySq9ktQtR2M0aC2cGvPBjWSCBznwbs1bBuZwodHMZRLSnxUqOV62pVAv4q1nCDomO/MYY6kDFghnhRAn1QXvWsWzOqjLAUdg8/EHG2yYHNtIeyevcLffZmtdKlCznTU3UwDDRimh4UF7Rpu7L8GvQFKdaANQi7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652904; c=relaxed/simple;
	bh=3SuytZcTu/Esyr9CE+3uCLRBwukLYJnYoNXkHncy4lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVb136ZnJJMKnj8RbucBxhJjnke5e2sppqE/rNS48vYh5zrEO4FER0nUA5wvnM9WSrW0XF0qCBBnBZw7rU1XY7UFC2/roB3zK74clQ2R8EzD1HWudHJPikZbYURKNlLwYTMAd9RejSvQSuWXNNMFGBgyrcX+XOcqhE0bdOuH/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/dyX7Ha; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/dyX7Ha"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51381021af1so1967993e87.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711652901; x=1712257701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/x1v8L55B/K1aAFmf1rBgUZ9o8/ssZyWjinUGKHOQ84=;
        b=P/dyX7Hap8sdmot/G1w/mgEcYZpOVE75t07YzrxiTrWaR3wkgMGO0dnQEoI8papA5T
         n7/y1ijiElcua2K9EE/2UTnaoNtudp6qfccpvq/eFDz7l9J9mIjtK36ChnrnGWwBuSCw
         7LXLJirLE31MpiParUg1v6/XlIdMzjKHT4lKUGXSRpfwmLPv3TGHYNX8U67uYgRzJ/py
         8p/PSMqYCS5eO600cglC6WLqTO6QnWM5qPLId/6naL5sEHaNzaaTCtsfCltXNKarnpsU
         LYyDpdSHOymI16xZyxAM6AlkUbANMNA1tv+oWTq9D4DIL9BfumRQGSnsZlS1FxMwy8VN
         /+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711652901; x=1712257701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/x1v8L55B/K1aAFmf1rBgUZ9o8/ssZyWjinUGKHOQ84=;
        b=l0WjgkA7OWt7viBjCII9XCZrJtAN2FP5PlHJWOWPYPAnyaYX3XpMI7c5uE+dL4BxIL
         /TYTQUYEmdCXuOc7QcEQtcY7ikJjnZ0Nm2Sq9P9vi56LyBBU8BCY8/9aY6g5HEIfmmM/
         k0Kc3wv4/2z+LbEqamvygYrp/nEKpIr63YivGrt9Y2KC/Kd68kvCFGcKSpvYFWqrVDn7
         qC5BqYrXa03Xncoxg7NEll/Obo5x/q+RWAd01KGa2/or5QbdbpUJxbVcD8TUMdrG8nX0
         /C8AJDO99zLW5CHgFdWvleON2cwADbdAIV+W2YNmBiRxCGjMrEhWpHh+fb1kMMdTLJBN
         TgCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDXpkZlTo4g9KMq+4NyPWeixT4KsZPVbHO7hxTtzap8W9YZlUo6rozw6HW01+2wa96jYuUslwKg3SKaWqecyspHNS1
X-Gm-Message-State: AOJu0YwBaEiqENsOI5Ae8cuaedmCDhN2gv5BrDuymz1Mgv+mud82fMCW
	2KIc3wxF58I+taE7/ltPIDLXJIX/aGtxAKiRKqzuH6Mao1OH/uBNCybfF0+mEQaGH1XMjxRU9fB
	PRoSZxBrSCVPGi0Iuo29S0deYdMI=
X-Google-Smtp-Source: AGHT+IFZT9DH915pcysxP6FTERCV45gZuwir6ULjmcqhxDTwZVoO3FNQ3ZlnRLnvOBi/Vmwla4nl4tBcCsgWXDKTEuI=
X-Received: by 2002:a05:6512:359a:b0:512:e02f:9fa7 with SMTP id
 m26-20020a056512359a00b00512e02f9fa7mr303337lfr.1.1711652900865; Thu, 28 Mar
 2024 12:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
 <xmqqo7ayuwpi.fsf@gitster.g> <a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
 <xmqq1q7uusin.fsf@gitster.g> <1b81a013dd0faccdc24fe018fd740755@manjaro.org>
 <CAHfn=+tsrgAyUUqUkq4TpXcABr7=ZcH+cna+vwALJqZ3H8LxFA@mail.gmail.com> <26f8d21dfd53d699804485b0f8c6abe1@manjaro.org>
In-Reply-To: <26f8d21dfd53d699804485b0f8c6abe1@manjaro.org>
From: Eugenio Bargiacchi <svalorzen@gmail.com>
Date: Thu, 28 Mar 2024 20:08:09 +0100
Message-ID: <CAHfn=+s5_hvV1osP1HFjWs4wxRfr9YUW-9=WkXbgSp-8sPZ-Qg@mail.gmail.com>
Subject: Re: Better visual separation of hunks in `git add -p`
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

But then each can configure it specifically for their terminal, no? Or
are you afraid that a user may use different terminals at the same
time, so the same config would be applied, so it would not work? In
any case, my suggestion was aiming mainly to avoid having to add
multiple options while allowing to freely customize the separators,
but if that will not work in general to clear, that makes sense as
well.

On Thu, 28 Mar 2024 at 20:04, Dragan Simic <dsimic@manjaro.org> wrote:
>
> On 2024-03-28 20:01, Eugenio Bargiacchi wrote:
> >> Here's a possible solution, or better said a new configuration option,
> >> which I've been thinking about for a while...  When running "add -p",
> >> displayed chunks can sometimes become confusing or a bit hard on the
> >> eyes, but simply clearing the screen _before_ displaying any new step
> >> (i.e. a new chunk, interactive help, etc.) could make it much easier
> >> on the eyes.  It would be a new option, of course.
> >
> > In my head, an option to print an arbitrary string would be amazing,
> > since then if wanted one can print a special character that clears the
> > screen, or simply add some space, or something else.
>
> Huh, letting the users handle screen clearing that way could be rather
> problematic, because different terminals may do it differently.
>
> > On Thu, 28 Mar 2024 at 19:29, Dragan Simic <dsimic@manjaro.org> wrote:
> >>
> >> On 2024-03-28 19:21, Junio C Hamano wrote:
> >> > Dragan Simic <dsimic@manjaro.org> writes:
> >> >
> >> >> Here's a possible solution, or better said a new configuration option,
> >> >> which I've been thinking about for a while...  When running "add -p",
> >> >> displayed chunks can sometimes become confusing or a bit hard on the
> >> >> eyes, but simply clearing the screen _before_ displaying any new step
> >> >> (i.e. a new chunk, interactive help, etc.) could make it much easier
> >> >> on the eyes.  It would be a new option, of course.
> >> >
> >> > Or your 'p' option can have a 'P' variant that clears before prints.
> >> > I have this feeling that even those who want clearing of the screen,
> >> > they do not want it always on, when many of their hunks are 7 lines
> >> > long.
> >>
> >> That would be even better.  Though, would adding new short
> >> command-line
> >> option to git-add be frowned upon?
