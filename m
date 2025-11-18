Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068682D8791
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492681; cv=none; b=IxahkG6PiCNbOximXQ8rwJjrUfBRHIC1eRqYOo6Ob9GTubuIx4I8zThWwRtdKkIKwPfhmffceobSRLIeczucumpH9b6bIXIo0V0GEihChd9fZ7uADdQomM6IYQTorBppGgXRqwMzEvafh3TJZV1YDLu8L6Z1eLm8kuPL/tLpBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492681; c=relaxed/simple;
	bh=QI20P9hP/72JVd5a06nUlMvF5qyTc3QPdSHMcehqtkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuPumkegz+3gI0QF93BVewZhYM1VlDlxH9RTz0HQWp8F9j/yPZugh4RBcaquty6JtY6cORN1IUZyt1ftPx0sqtxwQiz1KO8G2gK2dhbUM4ggGKeVjNqWmIZztAKfOaXJAOgZHLJw11/t5EXPnVG0JWS8fpF1EMSqxAOF4lSIjC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5F34uYk; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5F34uYk"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-92aee734585so232024039f.3
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 11:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763492678; x=1764097478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIL2OL2hcWVXeY0jEEdqR26+1iy/jRhIAfQaqUIaMC4=;
        b=a5F34uYkK9SMhzrlH7qFPYX8BEH/KRoeH7lF9il9e7nRHn7fbaH0DdaSMaGlzzJDV1
         Pe0RNTh9NgzvosBWQ1RtM1vQ3G3H3dUcw8Kg9wjZlcdStiUHYDijtd6Wrg9x8jA3pQg3
         HVsqvV53j5n0TtT2mH/R9mUsx5IoiLgkYrptinCNN3EybzYroz/fkevWvuTXpCbxiZHF
         UuCCSAgYjLGo72IEMmiJiM3azkLtU2Xn6A+yVMkWn8gTe/4mJbwXzlVMea3y7fOoRmOO
         MBGeR7O9Ruim0uR4p3VqIN7zgUFe97axyHy5nGpHKQ7iRfl8S2GGaM8lSJkRbImtjjDn
         tcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763492678; x=1764097478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIL2OL2hcWVXeY0jEEdqR26+1iy/jRhIAfQaqUIaMC4=;
        b=oQwpZD8K750Wf4AjMEyrjItXg69/PHk3rEPV4LKk9nlDyTh1oiUThlARS5R/Ro4uIi
         HLcI71Z5bYDw4lxgCja0ejCiPwP8mDmZ021VPQ0pzG3CvhCyK3tQnuA4NQ+f6aCUEpGO
         nZdLf09CKSNqA9b0HyPpjRBpMZey/sktTw6i8PfI3rsxViGTEi76W7DRuEcPCx10V7yB
         srRU9M5HUG8Q1ZlAxQ/5op3l9GIBVBTdLi6xIP/Tq9RBVxwZjUzS41Qz9s5k8AtXzCsv
         YZqI7MF6quRfcgWdLdEXnSaNzc3+Qg9Ujc8rdmyyjkOpiAftOphvFc3/bGjytqXNrP2M
         CUYA==
X-Gm-Message-State: AOJu0YyDuEhFHb+T+8EuBIcaSEnZvqpAc41y2Oq7Tvkcm34NTYmKJX1K
	wOA5C/WxcocrLd+cNH/bIsAvi75scchv3Z0IkVFzIEeqnLUoIsBr8P4XOVnGkk/XyCA+7aINmml
	mnxzKDA/vbyyniC2rXD0pu8f1dVxjwhI=
X-Gm-Gg: ASbGncsjB+k4+SXHUfXW+n1JG6SNqxWPoBBr9/XGI4M6PEVDMaPZOZLvPaGojuCSN5z
	4I6QqHUkgNiiyrdRxXgLV7aw/LlFi0oOY60Iz9LmTKYGrZzuezUE8FvLKshmr8bKTxd3AgT8lyr
	WPY/pSG4ziTA9hA3jd1X5wPxLFmU53WNk/quJ52xGCgP5Wx3MFrS51rWOthHNxfu0Ci3UNjD6t9
	vCYsTwdguxhf9I54VtMnsWbOMW+ko9a9HupWmi6gdWoQSHoH0W99ek91TNLd+89atecyBnVNCFe
	0p/PteF/R8t7ae1i6clH6mY/xsq8
X-Google-Smtp-Source: AGHT+IFsL/ZSo4oiLNyZE3T9V0cmOlHRrqcDzMCE2o/2epmbgZoaSz0wEj3XaZJ0OhvTI46v9/z50WXkrK2hO3elepg=
X-Received: by 2002:a05:6638:18d:b0:5b7:bd3f:ae06 with SMTP id
 8926c6da1cb9f-5b7c9e06eb2mr10698356173.18.1763492678271; Tue, 18 Nov 2025
 11:04:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105061918.3688870-1-christian.couder@gmail.com>
 <20251117043450.322644-1-christian.couder@gmail.com> <CABPp-BHY4SLmWY=V5aHJ6igN0GWeg6V1MoWDwszPe2O38wqBhw@mail.gmail.com>
 <CAP8UFD03YK47nONVRV_wqOEanC8Oth1iRzsFv=eFhbFs6Q5mPA@mail.gmail.com>
In-Reply-To: <CAP8UFD03YK47nONVRV_wqOEanC8Oth1iRzsFv=eFhbFs6Q5mPA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 18 Nov 2025 11:04:26 -0800
X-Gm-Features: AWmQ_blc_7RqQoCF6SIl2meykdd_gOejEX7TTs1WoViRtH01LyTRluMZkkxVnc0
Message-ID: <CABPp-BE=wcFicz0H7n4CQSFmLF0hv1-0tJQuWdsjKi0rWAQHFg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 10:30=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Nov 17, 2025 at 8:52=E2=80=AFPM Elijah Newren <newren@gmail.com> =
wrote:
> >
> > On Sun, Nov 16, 2025 at 8:35=E2=80=AFPM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > > There are no code changes in this v2, only commit message,
> > > documentation and test changes:
> > >
> > > * Rebased on current 'master'. This avoids the need to mark some
> > >   strings for translation as a recent series doing that has been
> > >   recently merged to 'master'.
> > >
> > > * In patch 3/3, improved the commit message to better justify the new
> > >   feature using some sentences from Elijah.
> > >
> > > * In patch 3/3, removed tests with dual signatures. This avoids a
> > >   conflict with a separate series from brian carlson that adds a
> > >   "RUST" prereq that is then needed to run tests with dual signatures=
.
> >
> > I'm a bit surprised; from
> > https://lore.kernel.org/git/xmqqms4rry7f.fsf@gitster.g/, I thought you
> > were going to rearrange the tests to avoid the conflict, not delete
> > them.  Are no tests of this new functionality needed?
>
> There are still 5 new tests left in patch 3/3 that are testing the new
> 'strip-if-invalid' functionality after I removed the 2 tests that are
> related to dual signatures.
>
> In "t/t9305-fast-import-signatures.sh", dual signatures are already
> tested to work with `git fast-import --signed-commits=3D<mode>` by the
> tests that brian's f6581e23 (repository: require Rust support for
> interoperability, 2025-10-27) modifies.
>
> f6581e23 not only adds the RUST prereq to these tests, but it also
> introduces the RUST prereq itself in "t/test-lib.sh" with:
>
> +test_lazy_prereq RUST '
> +       test "$(build_option rust)" =3D enabled
> +'
>
> So it's much simpler to just remove the 2 new dual signature tests
> that will need the RUST prereq when f6581e23 is merged. We can still
> add back these 2 new tests after f6581e23 is merged if we think it's
> worth it.
>
> To avoid the conflict I could introduce the RUST prereq itself in
> "t/test-lib.sh" with the same code that f6581e23 uses, but then how do
> I justify it? What happens if f6581e23 is not actually merged?
>
> It seems to me that if we really want the 2 new dual signature tests
> in this series, we would have to wait until f6581e23 is merged or
> discarded.

Oh, right, there were other tests.  Sorry about that, I should have
double checked the patches instead of only looking at the range-diff.

> > > * In patch 3/3, improved documentation of the new option to say that
> > >   validation behaves as the validation performed by `git
> > >   verify-commit`.
> >
> > Looking over the range diff, the other changes look good.
>
> Thanks for your review.

Yeah, I think the series is good to advance.
