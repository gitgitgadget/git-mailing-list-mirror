Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FA830B502
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270978; cv=pass; b=GCDZWMXkbVLuNLv7Mza19WbgqBIos5uXHhYt1OumizGziKmQRmCYHctF3jp/41vRr8qHamnmrzZ3NzbU+UBuJHBvwKAQNwiCZgtEMmiBDHr0+LkPK7hzWQ0JWrWotR8BORBi5y0ZUa664Tmf6113B6eeatowKajmLFBYrhNGc0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270978; c=relaxed/simple;
	bh=lgzmGPKdR5j2Qckwozxr/n+byTblTcT3fkiZA7bqmX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnaxS/p0sB3EiQnl64b4P2mSnOw0fogi//4IqT3LY8GBiYY8chuPgMpyaHBACHPYGG5tMW6Afi7ESjr5pWXdHUc3xFssGAo/MOwn2Fx217w+/rj3DNRvnHAOo7F4PgIyBPHCD2z35U9arPgIFs96zEEXyQiW1rsLKQDKl1tR1rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlGER5z8; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlGER5z8"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1363fe80fe8so1472257c88.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781270976; cv=none;
        d=google.com; s=arc-20240605;
        b=MlTJN3xMbT//RqfEhaw+aLcWPlR1VmLzz1IdyetsOjfi2KJQ4Ns7IbAeG5tbUbmV3W
         CBz04JasdnCzhw8JOVdQ4Lv5ibcS0TX/Dq68EOUv4zjZlag8KDH6XSs38yV1WInudBVB
         BnmmNHM8FTtUIaYHcWFyeYTpNMkkRSA/34x1kseVA9F82V17XPfWELE48lMMnPTwsZaB
         Y3AT/ph3oEUg+zPgtmr5GZEft6RhKv8GBXhrqDPtMWRzMDwRRYAGCKIU7ZhJrjRZIzAx
         oU/tJbbZXvdbU+g1dFgvQ2+c1XG/AoVvp6WHKrEPJxh9IvSJRqQNsk38d4P9L0jDHd+J
         neng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B/Oy7Rtb1CzYtM7/zQtKoMobcVaXXOc2NCrEwdekfio=;
        fh=LwuSnJBCccdjKxYEcovLKSJ6FbFCwY5qXrqI3Nds1Cs=;
        b=UU89SJ3KFWx6AtMvXPx+TyElIEDv6yNwQub1100Tr244ecs1jqCUmU5NC3sY+/GoeS
         BUBH8F5lYPLIQgjXA1AriPKx6NVIv2oNDgxM/TO7h9rFNIO/pibLR6oZXwIMKNqHkRm8
         86wJtj2HjBwTS7ydGEkaOZRiPQ8c8DqdjHfWscVm8o3HTA/gPlWp0kxyKzlvFo89D34n
         kJe9Wd6bBNYvk+bZFidFqc4xxz4dSdK7qQsmU2Q2d55plODwJhKKEC6ZLuLsYTjU8Nsh
         VAzKES16Ug4r7S97Sewzu5ByeEa58hz6cIJF6SG5/SFWWHUsVFIVSGaJ/pC7hTJyoJd6
         Qisw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270976; x=1781875776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/Oy7Rtb1CzYtM7/zQtKoMobcVaXXOc2NCrEwdekfio=;
        b=GlGER5z8yz0sVlI5PjgzBAmRmy4iOxJmT4xT1a/QTRObbgbdlfwCxePWqgwiHvePfO
         FqS+miYdOHt3x5oJKSI5xyUoONkf2vJqyg7Ng1/PN3UP8pylvJZWoDr+IllBmNOFHLAG
         TfBL4xQ1b2eXMpKPedLAszuP1eOGywBUzaVkcujxC/W8kGrE1BQzdXQF/G5sgKFctcDF
         r/pZdtkMvricUdIeFfh1c3Z+NTnMyl/08bwTRew2ZLiVX/97d5QZBzOMcPlGALnDEY/n
         BzSr4SQh8nvAdsNMx4iKPeYMeG+0Z12QUFuZYO3u/dSYnOYzeueDLhrAYgtuU123w6Fl
         7NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270976; x=1781875776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B/Oy7Rtb1CzYtM7/zQtKoMobcVaXXOc2NCrEwdekfio=;
        b=UD4HCoAi5Lc0bL2PeBknO50PCvwdxWLasfyCCTVUQ1cjx8S7l1KkG2Ul8+Gci5Fh3j
         8ELcQAqN3jeGpoFQ0rhex/lgbxdPlefNtaQNHwl45zGWOnQWhiGXE+Blcr+AFvDp0Q7N
         Ulv38HlwKe/MPNge8rqwOWiPnwEL5oTUEI+qZsxhdwlZhOwOtBLzTWcRCzBrXm/J5A38
         LTwmR2ooAQGOvsaFo9J9WT/nvJpRQoq0pTkfXc7u6SWaFeBSQlGSgNIh757e2hCDnpU+
         087qHhnqUmxxDfez0G78BEWncB4XSGKxlnM4yV07rUDXYIhPke3SiDGAQENiM9Y13Ty8
         VHsA==
X-Forwarded-Encrypted: i=1; AFNElJ+/n2QyiKusx/a4U+9lrCsTISBDIsgRoEo5c65CK5Rx13HAvh5aXK3c7kjGtyA+Wp7baXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15Q+aj/IWaceyBNlldd3gA9OJiucQZljBkH2uNFhKWnzwY4Ik
	E6+jNpO2Fuq1+xkGqJ/HH3mcXZ9WMulPBeRX2ARakKCBvGFOjGuPzfjtc/ooB5usAR61OuJqSXf
	SfUs5BIuNLlHz8cSraiTjYCMMXCUVfJw=
X-Gm-Gg: Acq92OHQhN9iiKP27O/wkSpXJNwhGcA7VKbIF5w7KaIVkdDWmDKvFXOjbTsLL2+JQgi
	qEn9JSfeLfUN0OuMlijXv6zZUvDRyvcOuoT5jljEa9DgkWHsDiAkkeHx5HRy6k0e1E4+Iz7odEo
	7gYbpPTydNVdXLEPat2gfLu6f6DU+iSX9bIvRsj0UmfYC3/ZDsO4rEGDhem6H2Z9QbPxEhaChZe
	Y784L2MZAAqRwtjYQDTCzfhdHfpT2kgEDVRh9Ujy72nnFVtMQ3NuLigE3ijYHd6TvP7H3Q3XvVY
	fDZdWEWY3jA6sbUjoKE2yQqUFXpnAQU66qHGe6Ao1KWb7CtlMLokrJ/+SWDkufx6UJA+
X-Received: by 2002:a05:7022:491:b0:138:56d:27e8 with SMTP id
 a92af1059eb24-1384baef0c6mr1261402c88.1.1781270976120; Fri, 12 Jun 2026
 06:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
 <xmqqpl2a4f09.fsf@gitster.g> <ah2PLBluBFy44AQI@pks.im>
In-Reply-To: <ah2PLBluBFy44AQI@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Jun 2026 15:29:24 +0200
X-Gm-Features: AVVi8CdHbMvGp4NVEfJaakD_s3xI41cGby-RfVgT_jjUITJLApuZCqWEUpW7Wgs
Message-ID: <CAP8UFD35cLP6FcEuPr+SghKae1ew4JWLWYAoMQ-fuEOu-JmZdg@mail.gmail.com>
Subject: Automated reviews by AI (was Re: [PATCH 0/5] Duplicate entry hardening)
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git <git@vger.kernel.org>, 
	Elijah Newren <newren@gmail.com>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 8:16=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Mon, Jun 01, 2026 at 09:33:10PM +0900, Junio C Hamano wrote:

> > This is a fix to an important corner of our system, but somehow left
> > in "Needs review" state for much longer than I would have liked, so
> > even though I am officially on vacation ;-), I took some time to
> > read these through (by the way it was a pleasant read, thank you).
>
> Honestly, I always shy away from the merge-related subsystems. It has a
> lot of subtleties that I don't have any experience with, so I never
> really consider my input to be helpful here.
>
> > I wonder if we create a rule like
> >
> >     Those of you who have more than 30 commits in our project are
> >     expected to review one topic (or more) from other contributors
> >     for every three patches you send and ask for reviews by others.
>
> Heh, that would make me condense patch series into fewer patches ;)
>
> > it would help balance the patch vs review ratio, perhaps?
>
> It's a good question. I typically try to aim for reviewing series on the
> mailing list at least every second day, and I always encourage other
> folks in my team to do the same. But recently I (well, rather we)
> haven't really been able to due to the current situation at GitLab,
> which forces us to put almost all of our focus towards a different
> project for a while.
>
> Overall I agree that everyone who is a core contributor should also make
> reviews part of their regular worflow. At least for corporate
> contributors that might also make it easier to communicate this to their
> respective employers. Regardless of that, my expectation is that there
> will be times where it works well, and other times where it works less
> well.

Sashiko (https://github.com/sashiko-dev/sashiko) is used these days by
Linux kernel developers and seems to work well for them.

At GitLab and probably in other companies, some of us also use AI to
review our work before sending it to the mailing list. And yeah, it
helps find issues before our patches reach the mailing list.

In the same way as we require that patches must pass CI, do we want to
require that patches "pass" an AI review before they get accepted?

The benefit would be that it would hopefully catch a lot of trivial
things like indentation, typos/grammos, etc, and a lot of things a bit
more difficult to spot like memory issues. Perhaps with some amount of
prompting/configuration (for example pointing it at our
CodingGuidelines and SubmittingPatches) it could also catch issues
like style issues, commits that do too many things, refactoring
opportunities, etc.

We would likely still require at least one human review (by someone
who is not the maintainer) to validate architectural decisions, to
make sure it goes in the same direction as other efforts, and perhaps
also to make sure that AI suggestions were properly handled by the
patch author.

If we decide to require it, then there are a lot of questions that we
will have to answer.

Do we want to have our own system somehow managed by us or would we be
happy to use existing systems already in place in some companies as
long as we can still tweak them in some ways, like the current CI
systems we use?

If we use existing systems likely at GitLab and GitHub, it might be
more difficult to get coherent results as they might use different
LLMs, but maybe it could help tighten our docs to make sure everyone
is aligned, and we could get better reviews by using multiple systems
because an LLM might find an issue that the other LLM missed.

Do we want an AI review right after a patch is posted or only if there
is no human review in the next X days?

Also what if the AI makes a long concrete suggestion to improve on the
patches? Could that be incompatible with our AI policy to apply it?
Should we try to prevent the AI from making such a suggestion in the
first place?

I haven't looked at how Sashiko is used for the kernel, but maybe
there will need to be some kinds of restrictions/authentications to
avoid potential abuse.
