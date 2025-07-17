Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C75126F0A
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739255; cv=none; b=qi92DXjZ33uWo5uecop+WNYwDk6L7ycT2Xe07C3w2CidrcMcBIwxBLR2H7Mg6HWB01wyBlNpkvS03SqQweOWToypYrV4Qu9RV2q09Wia3w4Z7khHqNGkiq4FM7Kg28aBuYFA7H42FysQ9sorVQqqeArHl7p/ERA+oRbt/2a718k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739255; c=relaxed/simple;
	bh=SsJUyb2kG5Bhk+XeFUB0sSbt7Bh4sQOPzQNvy1hOK/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJlsBAUAY06ZUCPl98pyqD4VSWRQV2P6iM/mYc4UKsZCLjHOlFI2fUJWwmLWH2KZ2Vrm8B9DQlulU6LHdiP6dQdRIH8EsUDJYd4pIYZ3HlUxUXT/xe8fsbRkWZbd765vta4HSBZOSjjRzqXofbTi4CzcgX/ZZMuFUHHvuNy4CSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoXYN+dM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoXYN+dM"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313cde344d4so760263a91.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752739253; x=1753344053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj6PWKiov2HUwIcvPkFBMF+pELxT9BFiVyrZiN2AZJQ=;
        b=ZoXYN+dMNy0OSkKG3aAFvMBeX1vUvZ1/tt4kkaO7Yir/dSVUGAjti9BgJkIKbM2+PP
         nsYrbpW/Xm80b6ZQ6HK3u/jrJaLanr1IVv12NXDtOqp7xwb79YFJznW8z7S6hHj0cEAX
         4VS66VyZ1DCb6H5ObaPr2C61c4j874YjxMfm5R+6SpcbgLJHNrRtiTt9MTT0Ty1TBJSZ
         IB5BtfmarSKAdZQOLuIGp3vCW0I0LIbYml6vOdExJmHrQaMBUCLVARCQ0/dnRS3WzMh1
         OURRB03L5kxwjpXam9/foQOYz7XKk7f91/wPdfdStW0Lyus4P4nfVE4+yHTwqa5ghg4M
         +H5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739253; x=1753344053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj6PWKiov2HUwIcvPkFBMF+pELxT9BFiVyrZiN2AZJQ=;
        b=Wndo68dQcaH/VntEPwSO7+8XTnqfJLtg3lVIWsmkFW8RZgPZtK9msixH0ZKyKmgKlg
         Br+SJGibmrqEZEQiOP0/gb/uZhI8P0IK5oXq6WJO4u2qrW78d4nqbRYhyYxRQ7UkrWDD
         rxunjStNU3otNIAUkCogD7ymGMwH+halrsU21sHxhN/jJS7Zs7awJd+sjl7/IiA0wgUA
         yMXpl9b8FZqsvcaiggPFgYJE4KGZDYvvHJZpcMySZo1ef0J/rndyrmNdIi3iCgARj8i2
         I88yFvQyaETzNtkK9h1jKoSedmYSqdstVStwIQiqqiA2mT/lOKxKqzVgiuXN0YxfB1CG
         xZgA==
X-Forwarded-Encrypted: i=1; AJvYcCW5u/MZbR5suxU7YCmc6bXbVUzq0xxyjSAmtK1GgBc0JO/n/sB9/pDyA8IckJ/t307WVAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzv/K/mZsuYT+moFJK5zgOp7TWQ6UAR9mwEA8w+m3rj1MHZIn4
	FtEHKT9fqSgT6MG+eIvcpWTv6/4qNGjKeYlFvi2CY3jmX5V4nRTYfC6jp7g1IT+F21QqP4Sw4EW
	z4VKuoyX9bZNhqiiZ6MQEIhh1UEBVRkg=
X-Gm-Gg: ASbGnctbMiVdGFZDKUvtDXGdeC4V0zQF8Le1V0uDE7mWEfIE6yH5rjMv40KK/UsXxKH
	Bb+ecb0tcO0gnh+mY/i8GNsr9pVoCQncJ7yVbQKJzHAzkJVy2KWhejtRzJQ7aNRRrf7FKl6JFIs
	SYWdNwhuQ9LJlhcSJBKVCYi/g2YIa8Sk3apiaJkUGMCNBc4sYzhSJwO7tM09poH5dvZlw1H58kL
	Vi1N4e8S8DbrNLWkHY=
X-Google-Smtp-Source: AGHT+IFf5FfnexN3ikgKs6pS7+9L8+oN+KXGkUEcyA71h5V19VWpO5cs0wDJbBTJT+/ugEc6iXAu003PwogZ/bmgel0=
X-Received: by 2002:a17:90b:2ec7:b0:312:eaea:afa1 with SMTP id
 98e67ed59e1d1-31c9f4389ddmr7668691a91.29.1752739252481; Thu, 17 Jul 2025
 01:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
 <32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com> <xmqqbjpq1rs0.fsf@gitster.g>
 <aHY7LYHqVj-ECf_z@pks.im> <f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com>
In-Reply-To: <f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Thu, 17 Jul 2025 13:30:38 +0530
X-Gm-Features: Ac12FXwmytK3DbpfxxacdAt0rj2WWEa3XvRZPF_QCI4Q8QP2JFOiL--0Q6r6IIs
Message-ID: <CAE7as+Z7b-cpn8=kjP=bQHkiRnLd8XYe9b8_50KYcg4ea7sASQ@mail.gmail.com>
Subject: Re: [PATCH 17/19] environment: move compression level into repo settings
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 9:21=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Patrick
>
> On 15/07/2025 12:27, Patrick Steinhardt wrote:
> > On Fri, Jul 11, 2025 at 11:55:27AM -0700, Junio C Hamano wrote:
> >> Phillip Wood <phillip.wood123@gmail.com> writes:
> >>
> >>> I do not think adding prepare_repo_settings() calls all over the plac=
e
> >>> is a good way forward as it makes it very easy to introduce
> >>> regressions like this. Our builtin commands parse the config at
> >>> startup for good reasons if we're going to move settings out of
> >>> git_default_core_config() we should ensure that they are still parsed
> >>> at startup.
> >>
> >> I think that is a good guideline that applies not just to this
> >> series but to other topics that attempt to move globals to a member
> >> in struct repository (or repository_settings)
> >
> > So... the only real solution that I can think about right now is to
> > start parsing the repository configuration whenever we instantiate any
> > repository. E.g., something like the below patch. This has the effect
> > that the repo settings would always be populated when we have a
> > repository at hand. Consequently, we wouldn't need to clutter those
> > `prepare_repo_settings()` calls everywhere anymore.
> >
> > But there is a big question: what do we do with invalid configuration
> > then? Do we want to die immediately when we see such command? The answe=
r
> > is probably going to be a solid "sometimes":
> >
> >    - Some commands must function even with an invalid configuration. At
> >      the very least git-config(1) needs to handle this alright, as
> >      otherwise it might be impossible to unset/change invalid
> >      configuration. There may be other such examples.
>
> That's a good point.
>
> >    - Not all configuration is equal. It may be perfectly fine to ignore
> >      some configuration, but other configuration may very much be missi=
on
> >      critical. And whether or not configuration is important isn't real=
ly
> >      something we can decide, as it will depend on the specific use cas=
e.
> >
> > So I'm afraid that there just isn't a perfect solution here. Does it
> > make sense to die due to a config key that isn't even used by a specifi=
c
> > command? Maybe. And if not, which config keys _should_ make us die in
> > case they are invalid?
> >
> > The overall situation right now is a proper mess: we have config parsin=
g
> > cluttered everywhere, and the behaviour is just plain inconsistent. Som=
e
> > parsing is delayed, some isn't.
>
> Indeed. My objection here was that we were delaying the parsing when it
> wasn't delayed before. Is it feasible to call prepare_repo_settings() in
> repo_config()? That would at least avoid the problem that moving config
> settings into `struct repo_settings` changes when the settings are
> parsed unless the command calls prepare_repo_settings() at start up. As
> far as I remember `git config` uses config_with_options() so that would
> not be adversely affected by such a change.()
>

This is exactly what came to my mind too while reading Patrick's message.

As the global variables which were shifted to `struct repo_settings`
were once parsed by repo_config(), we would have no problem calling
prepare_repo_settings() inside it as the behaviour would be the same
as before, and it checks if the repository is null too.

> > Some is per-repo, some is last-one-wins.
> > Some config keys will cause us to die in case they are misconfigured,
> > some will just be ignored.
> >
> > So where do we want to end up?
> >
> > My dream would be that all configuration were to be defined in one
> > central place. The configuration should be typed, there should be
> > verification for each value configured by the user.
>
> Being able to verify config settings when they're set would be a great
> improvement but we're a long way from being able to do that.
>
> > All configuration
> > gets parsed into a structure, and it can be parsed either via a
> > repository (in which case we take into account its local config), or
> > only via the global- and system-wide configuration. The whole config
> > needs to be parsed at startup so that issues like the reported one don'=
t
> > happen where a subprocess that uses more config keys than the parent
> > process dies because one of the extra keys is misconfigured.
> >
> > But I very much feel like this is a pipe dream right now. We already ar=
e
> > working on multiple fronts to modernize the code base, and I don't quit=
e
> > feel like opening up _another_ large transformation right now.
>
> I agree with this
>
> > So I don't quite know what to do while we're not there yet. Without thi=
s
> > large refactoring, all approaches feel like they aren't a perfect fit t=
o
> > address the bigger issue.
>
> I agree addressing all the shortcomings you've outlined would require a
> lot of refactoring. If we can find a way to avoid introducing anymore
> shortcomings as we migrate away from global variables that would be a
> good start.
>
> Thanks
>
> Phillip
>
