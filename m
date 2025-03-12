Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109923AE64
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780052; cv=none; b=M0PcXTIfs7rSc495RoMMtTxIgssHi2hdMMbVeVDCUdKB+ke/ivf+7fr419zsYTQMh3+jciSNlbDgXHeObPyouMJjNwGyLjXz9y8t4QGLEYtXF2+IBOV3I5whGGymn+GzBaBYHD/857ZOGsy4cIEH01DcILxQvn++EHcEFLUfa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780052; c=relaxed/simple;
	bh=e2TKhqx39RHBVCP1Leho9y7glHrOKf8ijDRhH6H46co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTdivZNkuimQ03PpgSfdnMTD7ZddUeoOti+B1y3jj0BLsKS90WNeH6VL6uc7YgJqkFQrd9U6I41gm1lGlUdBOezRidn0kELJWINpBnSo8ooVjhKG/Tu1HMcQdSdiJDHK6GWsclw2VGPBQ9Tzx9KMQxHCamoAQtobjzQ+ocwJGtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPXNav8W; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPXNav8W"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so1558034a12.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 04:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741780049; x=1742384849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5E62YDnFZYHWxGPep6ubUy4haSlA4504/ARKkSlcNs=;
        b=HPXNav8WhcSAvvqQXhSKiQZ0ZyCAnVm6mW8Bwfs4lso2knTYyuiYvzDVWsFAIsyOzS
         /borRdhYIgSUs7gn7UkBESrOYjlr2xF01Eat9oWv5p/9//jkAvf0op128GZiA82I3qjo
         qnTqoqvz4xil6EmokdUdkemzjRb01Wa1rskGx/Qmd7Mk6ereI7hWqcO5NQKb3UIfNt+y
         BUZqrWrULGITq7lsdkuiI4E0D9J1LQql/pT3A0kdx5Klb+PomQSXPtccBjUi6DO1VjQL
         ytNlnzaJjocjppLobydAwLFqqCfBsHFDRQ/z3fpT0hnkYc2it/nPxQFv/AIZLes54WFv
         QaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780049; x=1742384849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5E62YDnFZYHWxGPep6ubUy4haSlA4504/ARKkSlcNs=;
        b=Pnszpv8wkPDdwIyGnj/rm4VKZfMZn/xIBOEHn1RBGoVH0CsJEHOTOJDZQI15kWmZu3
         LY6fL0jdifyZWmlOeUNhVdPM8SKu5YQClf6MPbmD0IkTyCjK1WbJxQUN0G5dXyWE15s7
         8Vfp0dQNgspDZnPyJuBfRHluZIRi0tTVcCPDLe5sO+ldNddXTZME/M9Jhd4QU4Ckf2Gc
         1J8pTAskQfvfJ2v2D9KPEOT4kPQSrW8nnkXGjJxB7x0wcNjYfeY/iTBBPnUksQnkZvH0
         45IF9i822VtUnbMjsysDw817YLUjbWd7kwCppFxmJI+YnKe2Dn0hm9anDYo/MTopaEud
         Bo1w==
X-Gm-Message-State: AOJu0YwJxJ1PlbcyEXI5+zy9EmanOC3nsYHZp5Ghz7aKXsPEalz1Cm3O
	n0TBSLMoQa/xbwSZlMqaJ9spQ/qYoQwdBa+edygng033KjZ40VfhJSJUJuGug5Him3jMnu/mK+r
	oeePQ5HFyei6jwKHjXJjojlSSrf4=
X-Gm-Gg: ASbGncvOH0r1hlHQ3titE3j0Dr3AGqE+308MIIPgk/EwK1Y6R3+oONTtgawAbv/cBbC
	bIgDuh5nS4hdHYcOmiy3BlzU1EwNCvLtZqzx+yCdHiYadqg5Ikx8IXISYbsP5NygRkm7X2LRbzD
	YstojJCUOXFUXvarpyyvVeVfGIrsUl
X-Google-Smtp-Source: AGHT+IF2dwA8sS04pvZyToVuzmqj1RZUo6Si867NVi+czk2Izqirg5LPQ1PVZQ9Ff6gNe5oKS0ia8TRQNtTOqwi/3W8=
X-Received: by 2002:a05:6402:d0e:b0:5e4:d2c2:b8e8 with SMTP id
 4fb4d7f45d1cf-5e7631ea318mr8890540a12.16.1741780048561; Wed, 12 Mar 2025
 04:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310074053.1886097-1-christian.couder@gmail.com>
 <20250311152413.1059343-1-christian.couder@gmail.com> <20250311230601.GA72712@coredump.intra.peff.net>
In-Reply-To: <20250311230601.GA72712@coredump.intra.peff.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Mar 2025 12:47:16 +0100
X-Gm-Features: AQ5f1JqZtzY9lC7vfZZ5POVl7GW7wN3jYyVvk3jeiWokLeXd9dZXcS03pHr1v6g
Message-ID: <CAP8UFD16xD4airwbf_c5ysrvVdXEHb9QkiepKBxCCMmpyx0jDA@mail.gmail.com>
Subject: Re: [PATCH v2] promisor-remote: fix segfault when remote URL is missing
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:06=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Tue, Mar 11, 2025 at 04:24:13PM +0100, Christian Couder wrote:
>
> > Using strvec_push() to push `NULL` into a 'strvec' results in a
> > segfault, because `xstrdup(NULL)` crashes.
> >
> > So when an URL is missing from the config, let's push an empty string
> > instead of `NULL` into the 'strvec' that stores URLs.
>
> Is a configured remote with out a url key really a missing url, though?
> In other contexts it defaults to the name of the remote. E.g.:
>
>   # make a repo so "foo" is a valid url
>   git init foo
>   git -C foo commit --allow-empty bar
>
>   # configure a fetch refspec, but no url!
>   git init
>   git config remote.foo.fetch '+refs/heads/*:refs/remotes/foo/*'
>
>   # now fetching will use the configured refspec with a url of "foo"
>   git fetch foo
>
>   # and git-remote will report it, along with its url
>   git remote ;# shows "foo"
>   git remote --get-url foo ;# also shows "foo"
>
> This is obviously a weird thing to be doing, so I admit I don't really
> care all that much. But it feels like the most natural thing is just:
>
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 6a0a61382f..761eb1dbd5 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -327,7 +327,7 @@ static void promisor_info_vecs(struct repository *rep=
o,
>                 char *url_key =3D xstrfmt("remote.%s.url", r->name);
>
>                 strvec_push(names, r->name);
> -               strvec_push(urls, git_config_get_string(url_key, &url) ? =
NULL : url);
> +               strvec_push(urls, git_config_get_string(url_key, &url) ? =
r->name : url);
>
>                 free(url);
>                 free(url_key);

Yeah, right I am using this in the next version. I have added warnings
to help debug this in the case a remote is rejected because urls are
different, as I think it could confuse users.

> > We could have modified strvec_push() to behave like
> > strvec_push_nodup() and accept `NULL`, but it's not clear that it's
> > the right thing to do for the strvec API. 'strvec' is a kind of NULL
> > terminated array that is designed to be compatible with 'argv'
> > variables used on the command line. So we might want to disallow
> > pushing any `NULL` in it instead.
> >
> > It's also not clear if `xstrdup(NULL)` should crash or BUG or just
> > return NULL.
>
> We have xstrdup_or_null() for the latter suggestion.

Yeah, I forgot about it. I think it makes sense to replace xstrdup()
with xstrdup_or_null() in strvec_push().

If we ever want a mode (possibly the default one) that forbids NULL in
strvec, we could add that on top. But right now as strvec_push_nodup()
accepts NULL, I think it makes sense for strvec_push() to accept NULL
too.

Anyway this is something we can work on after the release.

> There was some
> light discussion at the time about having xstrdup(NULL) handle this
> automatically:
>
>   https://lore.kernel.org/git/20150112231231.GA4023@peff.net/
>
> but it was mostly negative. I don't think anybody really dug into the
> thought experiment beyond a general "it might propagate NULL places you
> wouldn't expect" vibe, though.

I don't mind having both xstrdup() and xstrdup_or_null(). At least it
gives a hint to readers about NULL being expected or not.

> For the same reason I'd be a little hesitant to bless NULLs inside
> strvec structures. I think "nodup" allowing them is mostly an unintended
> consequence.

Yeah, but then if we ever need a strvec like struct that can contain
NULL, it would be kind of sad to have a separate struct with its own
files mostly duplicating the strvec code. I think we would then be
better with strvec having two modes, one accepting NULL and one
rejecting it.

> > For all these reasons, let's just focus on fixing the issue in
> > "promisor-remote.c" and let's leave improving the strvec API and/or
> > xstrdup() for a future effort.
>
> This part I certainly agree with. ;)
>
> >       for (r =3D repo->promisor_remote_config->promisors; r; r =3D r->n=
ext) {
> > -             char *url;
> > +             char *url =3D NULL;
> > +             const char *url_pushed =3D "";
> >               char *url_key =3D xstrfmt("remote.%s.url", r->name);
> >
> > +             if (!git_config_get_string(url_key, &url) && url)
> > +                     url_pushed =3D url;
> > +
> >               strvec_push(names, r->name);
> > -             strvec_push(urls, git_config_get_string(url_key, &url) ? =
NULL : url);
> > +             strvec_push(urls, url_pushed);
> >
> >               free(url);
>
> Probably not super important, but while reading this I noticed that
> using git_config_get_string_tmp() would make the memory management a
> little simpler (since you do not need to free "url", you are free to
> point it to at the empty string and do not need a separate url_pushed).

Yeah, I will use this in the next version.

Thanks for the review.
