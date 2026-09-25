Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCD3909B5
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348655; cv=pass; b=kZNME5wLX0nUAeTFXwKQ1ev//J5ZEyie5Ctiglm5uM66YX0BxAb75hDvc9mFsqZWXUK/rJaKkVian//zotDPWMl6vgaNyQj+csuioUzXLGEKSiq8f7QsEpi1L8Tz0XBKdRmbfhPUWws8LVe5gCeYqF1bIGUKXBx/hi5WstPk74I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348655; c=relaxed/simple;
	bh=GuCVsiZrjrNbG7i8liLbPqapEXrMS202WeO5GMrGcrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBc5yRsF7KwiKdf9y13oxj9Jcdw/iA1Eh/nn1ot3MQmTlMQFmDK6y7hxKrWtesP2Ae9y6fgAbUMKLGcrGaaw8EIiuEpNbAFtuvMllcffsxAodFxKqlEtZ9CAKEQ/DqbBYSfeTyHSDHjxzt99gPDVIKw3qfBlRPtXKA8LlB2lp4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8JLcIDW; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8JLcIDW"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5919af2eeso7181141fa.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 08:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790348638; cv=none;
        d=google.com; s=arc-20260327;
        b=lh87lhZbWlnUBgSevW/T0wmhcjWZK9WnfTwXTb7INCrdj59xCUAbCRUCozze6NUkm1
         FXb3lxmX7QeAGKzvSwNx71RvB3Q7VlZnRO9Wp80uTPfhMHAqxjijaPbE92y5n2PXGPcx
         1Hh0bn8aVcwMJakp1rraxIeITPOB/6GWzizR6NbRpYUS3hUqZ6oYP1EH9VKeYVfqjplh
         9YGuFWm9aUNo9/koDBHHL3BmybFgus0GIbSRxsbQrHQF7D8g9SCZKN6aE9VYkTLQ0Ug0
         nmO5mhJaaDmn6bdBUuNxIQQ2IkWyOmOvwTfcSsieIDDxc2pKkk12sNECoGjbtdolZJ8n
         PqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rrVDlS/0WLPT59f55YuGOWGrezERAVJKjcHwGd7msN0=;
        fh=4ryOG4wBbIqKixWzeKd5dc717SQGdNJth+KYU2DAukY=;
        b=SA7SDpx9vq2Oe+M14t/z6pzSCnqKZpp++XNN8fLhHMQb1bUF65iUaNwU8dQz1nJyEu
         ct3Op169uFCsbzp4KXoJ/ozYwyPBvq7sF6brRzfKFa5jilOWwZLEPlJOWxf7NMQTmgn3
         RS0ppmQ5ouY3F49TS17+S0BagI1I5TVHA3U3d3eVTuWW5069iLytTccn0SRBCmK14sgp
         ujf8TRpIEBS5Hthfj1tUdOl7dP6wQdSNuhoO9F5si+qzX5kpA1s3cN9QlZH95D8cEg9B
         mYIxA57CNB2JPaIw1xEg0Cop3uDJwQBn3I9iEpwIFNBUUQkKgrAyvCJJK1CSXVsyBxpp
         rbOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790348638; x=1790953438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rrVDlS/0WLPT59f55YuGOWGrezERAVJKjcHwGd7msN0=;
        b=r8JLcIDW0yHCf8shGM61dVkuKEvUIJPOqjg1jmT1fmfXXwOG0se08jbSmm/A/0rwo6
         5xutmvoqm2+JamtQsYFlNJxM0XEx09x/+kdqfE71kSmJvn1odHH9vkByUTXp09+07h5G
         svPt4iXEzZ/l6yZCVps3Xl6XFdw0kjACIowlHhocUKuUKtagUA7FcQ0T+EsH6q983ofQ
         nDP5Azw0pguHd9L3FaclLxHE7ap9hwNxP5BQrL7+KFp+4wtlyiLLXtmrjVT41hBvmpT3
         UN4OXLrpwx9grf9lqwWD4BhV1fWET2Wvx7PVEWUanLAF05d6DXR4p/Lu7C5UZaqsfL6C
         iDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790348638; x=1790953438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rrVDlS/0WLPT59f55YuGOWGrezERAVJKjcHwGd7msN0=;
        b=BotId+UiWK+lOdISuX317VQ7RSuamymcoAufaeSpssbFKfwHY20avV9l/Hg3+7QQKA
         W7cQqYCAJz+OIYEy7NegV4ABQDty2FUERDs0vO69hdkumkNi1q/mcCOJUPxo/vztKOZL
         uJP1dW4ONHNVulzBJo97GPooT2U27cGme19aPveSYFfKk4s2aDl5dNDhpRMFGdy6BKqK
         F4uhKfndNeCCzquc5UOSDHC55pb3qHVIYwHfd5lku3hI/R3qSUPCAtdkfneQ112u81Ez
         xKXPiwMfiE7h5jrS/s8g3bm8jIwCsvFHBoTlGaF1LfxJgMJdW4vXER8lb3NpxOoMzO7h
         CJZQ==
X-Gm-Message-State: AFuF++kO240RpsXpjFbpQUYl1Lrh6dkoHeKCTwYbzVk073L5O1f695Zr
	Job1b5sMpfy+2OadcmALKj99s0C7RKOlWR2ILHvSjf1cRDRx2dJ+5mHrLhtLRU/gn/rZhK3mJxR
	Wm0IX5HpEVRbEWFSF+6G8fWiiGxhhS8O2bEhf1mE=
X-Gm-Gg: AYBFou2EkbNaiXwkLkVxzyTw7QFv/8A0Fm1rkCieyz9rsxDlNW9VxivHhPrvc7WeOJ2
	kc/6KXyB4AKXt+H0yh9rySvfgI9AmyX4UnRm9UfOKmIqlTJ7uIFf2LB1uWWYTFMDGUlH7cNDVY/
	H7SsKOZzE8Lbqp1wPokU0EjmVduukihrekDrOB3Wou3JPjqN13sFr0TnyKXQBctna9tAAAulH+A
	irIQkfs5R3/TKT4Cf/auOjwERUVuRmYEpylwU5lxaFW0rJ+lZAhCRW78ZBzqj0+UXLbDBqpYtay
	wDla/InT8b9Er5evTxv3ElMdzYyPv0op0KyS+zd3xYWasDoLBSxSkFcfV6F0Li0NKo7nUycPtgV
	AQnQM/eGzFIsz7aYKtwBMk7APifuOhQ0IFuUGeTIFohL4jpsutoDAXdymxmCEr9UyE98=
X-Received: by 2002:a05:651c:1990:b0:3a6:3074:122c with SMTP id
 38308e7fff4ca-3a63c0b0092mr15590031fa.17.1790348637451; Fri, 25 Sep 2026
 08:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
 <20260923-ci-large-test-resources-v1-2-c28416d59475@gmail.com> <arS_nA3g-on2RdIL@pks.im>
In-Reply-To: <arS_nA3g-on2RdIL@pks.im>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 25 Sep 2026 11:03:20 -0400
X-Gm-Features: AclHuK-Rsoy6zzy07QQtGsNwftslokdo1yzeBICDY24ZbLwypOv_A1j1UBBo_pg
Message-ID: <CAJ-ks9nQF2E9Pp-mXq8VAo=m0ZUi4Am46ysSH9zU8cPK4V-Geg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ci: match Linux jobs to available CPUs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 2:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Sep 23, 2026 at 01:13:29PM -0400, Tamir Duberstein wrote:
> > GitHub Actions runs ten Make test suites concurrently even on private
> > Linux runners with two CPUs. Pull request runs enable the long tests.
> > These runs hit ENOSPC while multiple multi-gigabyte clone and repack
> > fixtures were active.
>
> Again, a link would be appreciated that demonstrates this.

Yeah, sorry about that. Again, I suspect GitHub runners on private
repos (2 CPUs) make this worse than public repos (4 CPUs).

> > Use nproc to choose Make and prove parallelism, as the GitLab CI path
> > already does. This reduces overlapping fixtures on small Linux runners
> > while keeping the long tests enabled.
>
> It may avoid overlapping fixtures. But what does CI runtime look like
> before and after this change? Does it improve? Does it regress? Would it
> maybe make sense to oversubscribe at least a bit?

I ran a bunch of tests of this in GitHub and the disappointing answer
is that it's not clear what the right choice is:

                    Fixed 10   CPU count   2x CPU count
Linux Make             278.9       273.9          259.9
macOS Make              94.5       119.1           99.8
Windows Make           102.2       103.8          100.8

>
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index c6ccbf8c17..0855026dad 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -228,6 +228,10 @@ then
> >
> >       GIT_TEST_OPTS=3D"--github-workflow-markup"
> >       JOBS=3D10
> > +     if test linux =3D "$CI_OS_NAME"
> > +     then
> > +             JOBS=3D$(nproc)
> > +     fi
>
> Makes me wonder whether we should have the same logic on both GitLab and
> GitHub going forward. There probably isn't a good reason why these two
> should differ from one another.

Agreed. I have rewritten this patch to use the same logic across CI
providers (1x CPU count) in v2. I'll leave tuning (e.g. moving to 2x)
to a future change.

>
> Patrick
