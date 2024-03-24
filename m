Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA62107
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711290572; cv=none; b=qs61RzTPtbjSXVhcj3jISINqA1kTCULglcWcHChV/lmXW1BzvPmGaeaadQFPq6OHJZygrkpcayJhCQvX9mHpm569iMo8+A/dHdBfP5G3tACG/xxP5MEvEhLietWNsHC7kStAQ7pBkycOUhhiSbhFL1I+ggGLtZoTMidZmhddaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711290572; c=relaxed/simple;
	bh=2fHEsWzbUtKOdRS8g1KRfiKX1M2sr1eBSnvxTdHsQLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuVaQlKxXJ0APDcJzvV8knOxQSiMzQzKAJzvA5SyOkcWFl8eh2DU8nOBPyO/4w+/9d+l8DtVXa67kf/znw0sXLfp5E4gbDuuVBAa++FWgEC4PsOtxzEwPYIycZOxWdKswCSPyW3uFkA8SHSa4txlB101RVLw/GJIqJX2Yif0t1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Scj/scUh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Scj/scUh"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso4221849a12.3
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711290568; x=1711895368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL1++Epa74vObbVSE3rXxcRj9coV8nxt6Ts2MMF4eRE=;
        b=Scj/scUhzBQRfeyxG7lCoCy1nD7/FDrDMEYVPOTbR5Ymq59nmz0BJPDZsuNO63M8rJ
         IIzg2PLQKT0LYN+f/R9pHxYUsgnqKp2UqoGOOrmBT0kppDEXiThRsJqKpYcaG+0nu5oc
         KNTPjEEb8fbp77TLi91SWM5OuYoXKTOCmlCS2QyenqEnIUSln4I7k/HOStRR2lWgLtU3
         RQsbOaUb4a/xzRJ4Z+qxDPJk6NgNKlQUqZwSnlLKnVSkas6XnngkSI9VLquDbfoTAgzc
         t0sGI1oZOuQsnX55T7YB11buUk+Pf4G1hNyunpu0hxuR385x4kuQfrSPZ2AWEnfChvj8
         QAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711290568; x=1711895368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RL1++Epa74vObbVSE3rXxcRj9coV8nxt6Ts2MMF4eRE=;
        b=b0pd+YL/MPuCKRHWzdO/NmxYYYornD2K8nzPiC+V4i4wmMOwxS9HKUFOfFWlaf6hsj
         R+t2sSijb+aDpHq6KmearhfuPqy9dm4whRRMR+7t8a2eYFKhBsrRLC2SPoTTiPk7Gume
         D0oE9/QIOzxoAFuPT10G/r3QzPpbTuRwsRFZYYoyTqDfvOpASsUjNyFiGQI/pFxdz4oq
         2QH9o6di+VkxeSBS50ew80Ywpej4pm/Cz4y4r+j7mGt2zkQ/3ppX4FC64V4woOq86NQQ
         PML8RQlv5kDFyv20c4iEKB+4affkf6R9rFZKs1wji3K60jhlXSnxnX1c772NMKanAoVT
         GkJw==
X-Forwarded-Encrypted: i=1; AJvYcCXhABoKOsQTUNjPNFDDe4iqdR4bE5IHmc/GHGnwobWoTQEZ/G+lHwy1vx0RSuPRib6pLblfDfjcDFy+wtD641OdfYw1
X-Gm-Message-State: AOJu0YwTYjIYHKA3GAkVad1sB7eIqWwQ0/PsLa4AZWoNrzibLb8dQ/VL
	V5BRBHFvq+7EJOHm/CpRFepF3EDT2GfXUIwS6+r9homda91cFdRof2jDE75l3+kMMl0PuJt97N4
	WtJAnbOlSbjnMLfUVbhBOKzoyytE=
X-Google-Smtp-Source: AGHT+IHQ7pDz92yeLzvFJFviXNCBExi5PYTaBiRVgZO7uYWSUv68eKN8sztQQBRgbdrGUfAQ5Of3QWs8uEXuG94Cy54=
X-Received: by 2002:a17:906:3d6a:b0:a46:d79e:a28f with SMTP id
 r10-20020a1709063d6a00b00a46d79ea28fmr2956505ejf.76.1711290568294; Sun, 24
 Mar 2024 07:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
 <xmqqwmptzyny.fsf@gitster.g> <01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de>
 <xmqqle68x008.fsf@gitster.g> <e896da79-c87b-4475-9890-10051d8ddf76@haller-berlin.de>
In-Reply-To: <e896da79-c87b-4475-9890-10051d8ddf76@haller-berlin.de>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 24 Mar 2024 15:29:15 +0100
Message-ID: <CAP8UFD2DhkmVias+RfMESJz9Z-rKKHWHB+MFHcDb9QLO16TOhg@mail.gmail.com>
Subject: Re: Allow git bisect to auto-skip
To: Stefan Haller <lists@haller-berlin.de>
Cc: Junio C Hamano <gitster@pobox.com>, Olliver Schinagl <oliver@schinagl.nl>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 11:16=E2=80=AFAM Stefan Haller <lists@haller-berlin=
.de> wrote:
>
> On 23.03.24 19:43, Junio C Hamano wrote:
> > Stefan Haller <lists@haller-berlin.de> writes:
> >
> >> On 22.03.24 23:31, Junio C Hamano wrote:
> >>> It often is discovered that a commit
> >>> breaks bisection after the fact and it is not feasible to rebase
> >>> all the history after the commit.
> >>
> >> This reminds me of a similar problem with git blame, for which we have
> >> the blame.ignoreRevsFile config to work around it. Couldn't there be a
> >> similar mechanism for bisect, e.g. bisect.skipRevsFile?
> >
> > A Very good point.  If a breakage of a commit is "this does not even
> > build" kind of breakage, such a mechanism would be an excellent fit.
> >
> > But if a breakage is "only this particular test fails and we know
> > the reason why it fails has nothing to do with the bug we are
> > chasing", then compiling such a fixed list of commits, or pointing
> > at such a list with a configuration variable, would not work very
> > well, I am afraid.
>
> That's true, but the same can be said about blame.ignoreRevsFile. There
> may be commits that contain both uninteresting whitespace changes and
> real changes (not in a well-maintained project of course :-), so it
> wouldn't be a good idea to add those to blame.ignoreRevsFile. But that's
> not a reason not to offer the feature at all.

I am not against the feature, but I think it would be especially
useful if the file(s) containing the revs that should be skipped
is(are) tracked in Git. In this case though, any such file wouldn't be
used automatically after cloning the repo as the bisect.skipRevsFile
option would still need to be configured.

Also, how much better would this be compared to tracking  "git bisect
run" scripts in the repo, even if they have to be copied somewhere
else before they are launched? I wonder about this because writing the
conditions that decide whether the current commit is good or bad might
not be so easy either. So if the goal is to simplify things for users,
then simplifying all the way by providing example scripts with
comments about how they could be customized might be even better.
