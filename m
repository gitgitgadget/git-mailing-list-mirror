Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E7013A276
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480202; cv=none; b=HR13NzSjILAkjKumGrizNim4lfej5sjOpeAwJ0+zP7yZbxZaV95wF9dECfW8uiwyqTP9K6XLtUwM5WPLKVMBBgMAsTOXEKcvS8N9D2D/WWVa1Pmpr0GfOXYp4uI5k5j6mmzYwrHzMRpwSa3cv1NwPJxF4eKUYoMGhYG6SUCG0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480202; c=relaxed/simple;
	bh=ZQx1xtZKUB9IWocDIqNS3Nnua7gnVl4/F39AMybVBwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAdtSENSYThzq5Wj9yb0y3IIgqe/JW8RMMDJ2RGOayQYwIlflzZOjfSIyiuUkGr0XPe7k+LLdLxnICx6Gow/WIw90+PFaPTQ/L9pIfIK/MDAWwfAktnacWYuTg3OLT2oJX3h0yM/+5zfwzlFb2t0b22K4XNxPvTt9GQ3azpQQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUmqy8+s; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUmqy8+s"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-709346604a7so25242a34.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725480200; x=1726085000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lxy5d0jqU+x3cibDPuxzVwntZqTN6syiKsGDeTjSsoM=;
        b=HUmqy8+sci5ChCULIm82n+oXIN7FJVaHusw/1Iz8yif4UAvHcGdorFRqvyHMCHeRBP
         DOugA4yVbWl4+1yXl2xnfMmbRorn5RoIhOzZKNf2acyfUdtDRLPgrENfUykPwu6GVjhT
         DtcH5cHJ1kpsZZwGk+S2nG0Az8u6hK4lSxITnotQOSBe5rTNZyIAGHwiDuIaIb0Lvk/4
         ZjskzpnQd35r38Kscp+fpj3/rqpAarzy1uEixLmjWP0lyHzuAmhRix/3cIhpZu6cdM0k
         +TUrI/kS8bcYYzj+8R9xIFKRFzuv+LYRIKQ1k+BZQL4l7o/uGtCmVlOGM2xtlIsQSm1g
         DeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725480200; x=1726085000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lxy5d0jqU+x3cibDPuxzVwntZqTN6syiKsGDeTjSsoM=;
        b=VqiRxvzrxJ4S6mykYTdS4Q/wPOGMkXdzz3tFk92ugtc1J9pSlEg3LPaJ7kFmdRmwGv
         slmwG8fViEvxqyn4fKuQgqxqT91U9Y6brQm32nE6TehnDJ41XR3SAPXOFoo1b+bWP3Vu
         GvVf7lMsN7B1V31EqIKRQ8KpZM1jR9B2tyb+3COA4msfPQ/Z0YiT0VT/ABJ2v/99awRM
         RA/Fj3usrgXjQYbYxPR9fzD0kWpjtQ6/3vDFKIc6WR3nxVPqPeCTVIsBUNjDGzZ0fvgl
         nLbppvjOlJpi75h1SS7GwNS0S+zYcLr+b+z/ElllITrH/o6692xda8jURlgN+Sd9LPgG
         sS5w==
X-Forwarded-Encrypted: i=1; AJvYcCUE6kHFZ5kpvlDlVauZ7S7ChTQRrxPm50e/kf85AT9XfGiN4r/QclEpvToI2lUt19DlIng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHLzBwl0HeS6TFXeFAqZpjWULRZ0aoDHYFATTC1yESm6Nt5sU
	VKmIx77+bi/aE/rkjiqT0L1OpkY3z+mKiK+SV1YrMjo+DAIsqxemdWxT9+esF8IlTm1Pesk3N8n
	+aiqcUavNunvs4w3QHxhUy3AhyDI=
X-Google-Smtp-Source: AGHT+IGvxSWrErtftmaYog68k/ngJJ0pRSWNd2rwigoPQxncPmVGlOORxnC+Wrpewb8lUYuxiqBRNjEgKtRqHKq8po8=
X-Received: by 2002:a05:6808:150b:b0:3d9:dcf8:3450 with SMTP id
 5614622812f47-3df1d6c9fd0mr18348608b6e.33.1725480200131; Wed, 04 Sep 2024
 13:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zp89ntYaeFUumaTO@w3.org> <m0wmjto8aq.fsf@epic96565.epic.com>
In-Reply-To: <m0wmjto8aq.fsf@epic96565.epic.com>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Wed, 4 Sep 2024 13:03:09 -0700
Message-ID: <CA+P7+xop8OY18nQaREFk6LeDdnn53oSGnigN-ddSHAU7mAMO8g@mail.gmail.com>
Subject: Re: Problem: git Notes not discoverable (+proposed solutions)
To: Sean Allred <allred.sean@gmail.com>
Cc: sideshowbarker <mike@w3.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 6:06=E2=80=AFPM Sean Allred <allred.sean@gmail.com> =
wrote:
>
> I agree that git-notes is an under-utilized idea. There's a lot of
> potential to add context where it matters.
>

I also agree with this.

> sideshowbarker <mike@w3.org> writes:
> > I=E2=80=99d be 100% happy to do the work of writing a patch to implemen=
t a solution
> > (a git behavior change) for this =E2=80=94 if I could get confirmation =
that the git
> > maintainers would actually be open to reviewing such a patch.
>
> Best way to determine that in my experience is to just propose some kind
> of patch -- especially if the actual change is simple even if
> controversial.
>
> > As far as what the change would be: I realize this has been brought up
> > before =E2=80=94 but it seems the obvious solutions are to =E2=80=9Cjus=
t=E2=80=9D change git so:
> >
> > - Proposed solution #1: git auto-fetches all Notes when a repo is first=
 cloned,
> >   and then auto re-fetches them again for every =E2=80=9Cgit fetch=E2=
=80=9D or=E2=80=9Cgit pull=E2=80=9D.
> >
> >   I think that auto-fetching-of-Notes would ideally be the _default_ gi=
t
> >   behavior =E2=80=94 but short of that, at least a new [notes] _option_=
 for enabling
> >   that behavior would help. That would seem somewhat more =E2=80=9Cappr=
oachable=E2=80=9D to
> >   than =E2=80=9Cgit config --add remote.origin.fetch '+refs/notes/*:ref=
s/notes/*'=E2=80=9D.
>
> This would certainly be the most turnkey approach -- but what could go
> wrong here? I can think of at least one potential danger: that your own
> notes would be wiped out on fetch if you don't remember to push them
> first. Laying out the risks involved with each approach would help the
> conversation by showing the effort you've put into the design.
>
> It's my understanding that the git-notes feature is considered a little
> under-baked to 'turn on' more broadly like this. There are simply too
> many sharp edges:
>
> - the 'push before fetch' footgun I mentioned above
> - merge conflict resolution workflow for the notes themselves

I had use cases involving notes in the past and this was the biggest
dealbreaker. There is not standardized way to fetch notes in such a
way that you can perform conflict resolution.

This sort of fits into a bigger problem in that any non-branch refs
don't have the equivalent "refs/remotes/<blah>" area to fetch into for
comparison, but changing refs/remotes is a big backwards compatibility
issue. I considered in the past to add things like refs/remote-notes/,
but that also ended up not going very far.

I would love to see some of these problems solved, but unfortunately
have not had motivation or time to work on them, as we ended up not
using notes. The problems are quite tricky to find suitable solutions
and get folks to agree.
