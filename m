Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838E399358
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511866; cv=pass; b=rCI2qWe2oPX8maHDzKTvaHoCl03nOQqYLFxqot/GNSj7F+HtDAwBEs/kpd8rDK+Et6ncPnu4a8jb2OtXcDo1kLaJIk7tVEoK1y4P0IxuMxx4f0CX5/euQTwINyoZUJoScfK0DXF1dTYWhEzbKJmibTIyyZadULaIgk6wbm2657c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511866; c=relaxed/simple;
	bh=CODPgYaskq6OTmM4QxyvZYqDKO2hpiEntir72QhcARc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDyvoSRC3kj5m+rfruK3G83pRZ4t4of7tCadELESRGcqvpfeBacTsbpQqVmVplNY8FXLhQiG5t6jv3h1qP8v0J2GYI9kO4s+aGR5UNBS/B++00RbOQNebe6+0/qWh0asI1RzFJK8bXtFwqhDBeod8V1yk73nTq2hd6NNGGCVB44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVeu6/Ok; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVeu6/Ok"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-604d532cfc5so393111137.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 00:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774511862; cv=none;
        d=google.com; s=arc-20240605;
        b=SLAHvxs3OBY1eX1PXBOeTY+HSIIGHcDebAvF2pbJ3TQHdqS7Ak7t6MZCpt8f23J4N7
         GbC871XSjU+xG8/nDWHBg+iny7FwK9wlpN+CYpZt1Vk4s3HqCeNpllXo3odFrf1G9mrY
         p5jBHB/gkDozCONWJLzAs1uWESGwBmxAbZc0+vqW0RoJQKH4jwZvIzPQeG6hiiBtZ/zg
         YtzwkJuF77PheSLxW+/o/2iS7/IUB0i1AdPABl2Yb8solS1DN/icv4s9OhQJqZSSDDp0
         9yO2aWuciWGGlC1e5BKfJURsr9K4AFMMKobmWeBrHykP1wZL8ZPkUuGuhDq3biwRVHCI
         bRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fKiRIZ4d9qvIT2IXyOuj+r8/hZs+Ckh+S5BpwDjD2DY=;
        fh=G0SVQ94IzogdhUv2ohlhRHcyoBY7+pOPcJFj4mOzk7I=;
        b=PIxGK0SilYKO11di00xH8+HRTkFt6gieU3AzokdpW2ifGCa/x4m0oyXXk2bsSkp1o6
         qWWaeMGwhLbndA2kX2JS7B4Cos8/fMZFdHd9lkzpkVRb7XqYOsEnOoJDKRMx2c1C9Tmd
         VJPpZqVXwqHgeMD+J67MFFdUdFbyOnlS+WFv35WK6r5361QRMGRDXchCHL1NfZCeDTuV
         gK/bHAHye3VJeGxaJueSm/ZkkNIkyHTWj0JGjx0AS4WD+EEn3L9v2Ezk5xE8BMHiBkYJ
         a/TwcphpU2ojfpwUr+rnz5NFrH0v2Eg5GpnA2uC4hBtxmKNpztRNKU/SnFXfwkX+mPj6
         EYtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774511862; x=1775116662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKiRIZ4d9qvIT2IXyOuj+r8/hZs+Ckh+S5BpwDjD2DY=;
        b=bVeu6/OkUmOHBkWzFebFk06mf4TE0Pm4lVObQInsYEoj6CFnJ9Aabm8BHRSq1mlaRo
         zU1sUoCAA+uYuCPnDHkiKuD8OkU9xWlGa29dxpEo6TyDCfQDVGpJKrxTFDhyZ1HsVcvl
         EOLlPdnsRj269HpvSiYXKA5Q6I15VKPbtfEzdKYKNN1h349+qCKBinokmIGlJNX2/W/Q
         7ZbF1TFMQmCyetmIlrWIepGbD58eiAV5MrrVoNPkdhAW1G64CDlGMagbot2HKIjnQYtY
         Sv7ye3lQJMhcvb9Zz8Je92QYSRPiyHM2VwWjsMemaL8V5DrZTHb32h6s7EWAXx/RCjRt
         Rzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774511862; x=1775116662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fKiRIZ4d9qvIT2IXyOuj+r8/hZs+Ckh+S5BpwDjD2DY=;
        b=SpGxfOIkEPZR2QPhSnB9LtgoN3HfDHn5jCQVqeHkgBRzW31PFaSo1NN4vmxuI5At9s
         6fyHAantDmupKFj9ZihlpwuOCjzPkaEyNItgDxXIFpwlLgR8X4bQYKnF7jxe2DuuZ+gd
         7dz2FmhXKHxY7QGcOqPG0mVSBpZsZ2m7amE5BN/duIF6HcG3na6BwHGPGU9zde1wgrMe
         tQL+ltRfinTJCSDlD/Hit9yzJbl3rVnI28Ld8r0Lpu3TADb8wHsMAUIjM0uVjQEHEW0W
         akno/SMWJthHyxlX0OtIBp9hWpd/fh1+WRr/aHGfYhL10tMxWOOICHPY5iBmIcYJOIrB
         GxJA==
X-Forwarded-Encrypted: i=1; AJvYcCXlSZy5K2GpmKc66LII5JRKjKRkVY+xHWR6MAVSvqUfB1CFSvD1b/Y/JiYPH/lga/M0+gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWDwGGi2jGLV4P5aDoK6w/2W5DlGjzLlfTFXnbAgARwTJ372E
	jB6pJaquKAAM2VGYYikYl1JGWSl6jhKEMc84jin3kxn8emB4xzFKQAODEWn2MtRCyq4arGAq/oM
	z5r+SoHYzfDN2buSi7vTKQOGGftLAouc=
X-Gm-Gg: ATEYQzycEVgrEP3Ei+p/qP95FEZ/rtEYUyMSgl3n1x2KhW4FO7ZZbcvU99YTtIDZUrC
	SpHJAw1mTSf8X+qksAUUR5wiAPh1WYztuQ0QROvkF13vgo+wVHF8U7nF6te0RO/GrSz2vYrMUNW
	2AdYdl5PP7ogZZK6z4iaeLODu+KnFN4CUKO6kouVZ6UT83lKCgWxXq1C8G9dhKZZdmQ9KY3nLsJ
	SiC/uiKDGqpeYZvdbEzw143oud6/UNg9ruVPZhiGQ0vFq/RbX72zVnedincM0Wj73G0Kttc2rmq
	bzU6g5kKP9s/4Cpw4PkEhbKVummS83cMS4nIw2c=
X-Received: by 2002:a05:6102:3e0c:b0:5ff:9ed3:448a with SMTP id
 ada2fe7eead31-60387235b78mr2847619137.24.1774511862441; Thu, 26 Mar 2026
 00:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
 <b444fa7af9f39960652209143c9845a47efd58e1.1771187016.git.gitgitgadget@gmail.com>
 <xmqq1phdavik.fsf@gitster.g>
In-Reply-To: <xmqq1phdavik.fsf@gitster.g>
From: Orgad Shaneh <orgads@gmail.com>
Date: Thu, 26 Mar 2026 09:57:31 +0200
X-Gm-Features: AQROBzAoYObjBAD30Jo3kXzQ-UONBhawUMzPk5NRViAoHhFmaeaH41ENNcVCpQU
Message-ID: <CAGHpTBJKaTURMJmJ6W4iiCAy3-M2YWb48rF8GMoEPCfpGcE=QA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch: clobber existing tags with --prune-tags
To: Junio C Hamano <gitster@pobox.com>
Cc: Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Orgad Shaneh <orgad.shaneh@audiocodes.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 8:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Orgad Shaneh <orgad.shaneh@audiocodes.com>
> >
> > This was documented but not implemented.
>
> And instead what did the command do / how did the command behave?

Even when passing --prune-tags or setting fetch.pruneTags, git fetch
fails to force-update tags, resulting in the following error:

! [rejected]        testTag    -> testTag  (would clobber existing tag)

Furthermore, when a tag clobber is rejected, the entire fetch operation
fails, preventing the update of other refs and even new tags.

> It also is curious when it was "broken".  It could be that it was
> broken from day one when 97716d21 (fetch: add a --prune-tags option
> and fetch.pruneTags config, 2018-02-09) was written, c1a7902f (Merge
> branch 'ab/fetch-prune', 2018-03-06) merged it, and Git 2.17 was
> shipped with it, but knowing =C3=86var (by the way where is he these
> days???), I somehow doubt it.
>
> And unless it was broken from day one, we must find out if the
> change in behaviour was deliberate, in which case it would be the
> doucmentation and not the implementation that needs fixing.

I dug into the feature history and found:
1. The flag was added in 97716d21 (fetch: add a --prune-tags option
   and fetch.pruneTags config, 2018-02-09) as you mentioned.
2. Tag clobbering protection was added later in 0bc8d71b (fetch: stop
   clobbering existing tags without --force, 2018-08-31).

It appears the --prune-tags flag was overlooked in that later commit,
either in its behavior or its documentation.

Since there is currently no way to suppress this error globally, if you
consider the current behavior acceptable and prefer to fix the
documentation, I suggest adding a fetch.force config to allow clobbering.

> >                       git -C ../child1 fetch origin '+refs/tags/*:refs/=
tags/*' &&
> >                       git tag $tag_args testTag HEAD^ &&
> >                       test_must_fail git -C ../child1 fetch origin tag =
testTag &&
> > -                     git -C ../child1 fetch --force origin tag testTag
> > +                     git -C ../child1 fetch --force origin tag testTag=
 &&
> > +                     git tag $tag_args testTag HEAD &&
> > +                     test_must_fail git -C ../child1 fetch origin tag =
testTag &&
> > +                     git -C ../child1 fetch --prune-tags origin tag te=
stTag &&
> > +                     git tag $tag_args testTag HEAD^ &&
> > +                     test_must_fail git -C ../child1 fetch origin tag =
testTag &&
> > +                     git -C ../child1 -c fetch.prunetags=3Dtrue fetch =
origin tag testTag
> >               )
> >       "
> >  }
>
> None of the steps we see in the added test do not seem to check that
> --prune-tags does clobber existing tag that no longer exists on the
> other side.  It only checks the "git fetch" command exits with
> status 0, but does not see if the tag actually went away after the
> operation is done.

In these tests, the tag is being replaced rather than deleted. Existing
tests for the pruning mechanism itself are located in t/t5510-fetch.sh.

Would you like me to add a check for the tag content itself to verify
the update? I suppose I should do the same for the existing test cases
in that block as well.

- Orgad
