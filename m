Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17659503BFC
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540196; cv=pass; b=axBlmv86HmdLLgmKfbGuwoLb4RBlnbCcze9KTywrnFc/69CQK/e+locZOIz1vvBBsZY0jGo+p+W80AcNcaUOtXIAntzvYQnd1n2O61T89uv3sDLpdFhvpGRcAdKnBPI1ypS/sH2rjRg/cUSk5N+KMw2akw4BGBpsNAsdNDjGg/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540196; c=relaxed/simple;
	bh=WPtLQlKeWl/fGoxExxbtfPkiNqxA0JGP8P3BuwLFie8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppb+LoePGwbuqnlQWtQt+TLDZvgMPOdB8ofj8KG6isNW6uuQXasyjUuCh7pIDk8CPFmdMaXGJ6JHIv64YJMni2GeIWPLa9W3X3TWexDj0+mQFWNMqoXie2GMMKFvf+XNn3GC+3H3piWcdSwQ1AUysXL2fG2H40N3nJpTuWGRKK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJhuks1b; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJhuks1b"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a60f0dbeccso1789366a12.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 09:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788540193; cv=none;
        d=google.com; s=arc-20260327;
        b=MfTHKZiE6Hree8QuTd3r2qm064nd7ZhmoM4llZWNhY7+XB2KZsi0KWkD2zQI2o5z1A
         yyQoeTCI2zwCFo9UdKRFNKZ6jiawO/IZQ6gKi8XucMbQbJA+ytkC6TwWyKnho0w9BUQe
         V1eg/ZW2eKv5oON6XqEd7yWX8PHtylFgjlZ5FAW4RqU+LnehBDRGsj1Z5mfbYZsDXPuF
         yii/sUJgJfXoHN/AbAtdCBOWw0OsWlIhc3mItIIeItlKznCao9LCS+RiUI2Oh/VvpX0e
         kYJ7GCzv6cyR6OcxTgX9jsQ8ixbOSFYdmaMppu0tzzE9MvACED1DHQ5mKnwcBxPGAvtc
         giaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BLTWQJD59XId3eNlxaFTAXE9aK0w9X4gusui3FV1Oq0=;
        fh=GrbUA6j5pWrFgcQspFlVdso3UWthctSYZtYMvxCXq2E=;
        b=QZr6mYI0XPG3z8wwV5fHOUvAiJj5GY91JZIt+akm3z1Se+brTqrmC5+EVzzjJTcg8T
         Zz+Iw/PU9BMVRKdsDfhHr7hU21EeRq7r0cNmHtsCOrhr2SzpO7zhr1Oo3iL2CK8AJayN
         ZVD2zToUnBe1YQRuR8GjDyiFP+p4tXFlIRz3BUivF0eTBEc8XcHh18em0K388qNFom8B
         q6Kmdg+D7KVurESPdJ69V4XcsCFfR9qEPPHyx05lzp70T489UwVnzgegGh2GU86Vzr1Y
         lAPLunrGVAw6zPmef0+j+yZQTU+hZst6J1udlK8kTS7qoj6QvoP4tNDQrqCWchwN+Yc7
         lN5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788540193; x=1789144993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BLTWQJD59XId3eNlxaFTAXE9aK0w9X4gusui3FV1Oq0=;
        b=BJhuks1b5VBeQSb8HGeGJARvcqUZcaQyOECFYmxGdQW6zfDBNGx7wrDpC7Y2pcazPg
         p8eoUVTYck9BNePusCZnueEMm7YwgL+7tBHsUJWh3167089uG4/gbkCDYu4A46WnMQFu
         Z27LLj8hvPCFjnrgogO4DOlJP9jAGCL+Vj6vkDKBrVqUsolKLY9yI56WrufjaeAv7c9Q
         P4v6ZzZx7Ry1/fAU2kKaK5LmZdr92p7y4t2fnjK1SHtqmS57SFVmvVfyon1GPcdyfOFt
         IR6x1V3B4lexVRj2zeE1Kk17nlzdi2LniLVRkz4+cXAhUnbnojf2A1eugEIcxSMuAPAZ
         V/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540193; x=1789144993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLTWQJD59XId3eNlxaFTAXE9aK0w9X4gusui3FV1Oq0=;
        b=lQTBFQgYSYlOHyWY31b8U0lBNA69dOiycFYvZontSsV8A8HssOQMXvvX1sR+HVh3nz
         UTB8d4Plboy5Qq6g5hdZewDhM0psYFtzAZf4qqerQPFQVHsqSlfkbC/EtaulnMoZ5H9j
         xM1COy52WW0mEIkLsTSea6+I7FPO+IZQMiYV0F0ggHQhQpEtuLaMUXsWAmmZOa/oHRsn
         ZMnd5qK5RT7E0bUUTd4lmjAg3H22XRK9Dnl2eFpKw37gAPDM55/DVTNZ+id1oJC7pgKK
         JG6ZkRP9wQzzSRSP6EaVozIvZF7LZsmOXRGlyZ74X4HfAXpsWrONFofmtsJYwr/BFZGb
         k1hw==
X-Forwarded-Encrypted: i=1; AKwUvBzG28Q3G1S8e1iGTfGkuZg0VgWMkrBTwZElyBtWh5+jDE/MLEPlon7EEBJEhqcdu3AVp2E=@vger.kernel.org
X-Gm-Message-State: AFuF++kTKvXyvWa4FwgRQI/XOO5L17Pqi3mZKohhiF0VoJqVXSh9YfRE
	ZKpkqGfmoXjGYhspHwMvUOnYbW+EO8dbnhKUJbWab05OEGlF8b6X6j5gq29VDjnVy4OpuD8pNHq
	yuyjbRzWA4RmzSX/MoW+PWtqyqkSbq9w=
X-Gm-Gg: AYBFou3wfEKSM6YoHpJ2NCCpv+ogwv7T7ZR6x4Tuiis5GzJWGXTlNQHvd6FYOXXUvIs
	7CPjW1RWuK1M7QvFDWXGErjer1rogTPWmXvtU+ZTs7xRtTHz6PIT+SgcU9rk5BmGpE1UEWjlW/l
	2wIWr1OL6Cvd82Ux7RlFefgGz5U1CLl3jL2ljgfejVSdAJQdtrjOOPdQqVb8L6mRxlBOvOi4hiR
	jL1FKPzam221avZ1fsh/l2KmOg5ceMSkulXRasaHQAJm2ObwxP8JAEmVizZY+NmBzhdZZpMMUxA
	4I39H6IR1Bp7MbHmR0Lc17XAgJhcwt8mTuh/0dBN
X-Received: by 2002:a05:6402:3220:b0:6a7:ea54:38a with SMTP id
 4fb4d7f45d1cf-6a7ea541ee8mr2171614a12.27.1788540193029; Fri, 04 Sep 2026
 09:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com> <ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
 <xmqqwlt3h1oc.fsf@gitster.g> <002b1324-0f7f-45ec-9f67-624a41801ff7@gmail.com>
 <CAHwyqnVp6BVGx3+UCqBC_gOCuyq1c62uNi1f7Wyfpxd1KdyM9A@mail.gmail.com>
 <xmqqqzjab2ho.fsf@gitster.g> <CAHwyqnW8sdnDcncpZpaMD8fmWaj+WJQxhA4G-Y+L5PTW=h3k6Q@mail.gmail.com>
 <xmqqwlt29l01.fsf@gitster.g> <CAHwyqnU2c3T_i0gvkqiPPM7UYr8t5bzynr66iG4Z6YUKqZk1Cg@mail.gmail.com>
 <99b6da14-e03a-472b-b7a3-81162dc74166@gmail.com>
In-Reply-To: <99b6da14-e03a-472b-b7a3-81162dc74166@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 4 Sep 2026 18:42:36 +0200
X-Gm-Features: AcwNN1WpY42IR21s29lPKKiIYgPL2ihcBt1OCn-rJ04uh9V4oY5SF52c7SXw41o
Message-ID: <CAHwyqnXoxmgstsczTkkFDQbi2oN5aH8sg57zBtj1WEvqWy_zRg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 5:09=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> [Cc'd Karthik for a view on the CI style job]
>
> On 04/09/2026 09:16, Harald Nordgren wrote:
> >> A local "make style" while you develop runs
> >>
> >>          git clang-format --style file --diff --extensions c,h
> >>
> >> which tells the command to check only the parts of the system that
> >> you touched.
> >>
> >> I do not think it is used in CI.
> >
> > It seems to run as part of CI and doesn't catch it then:
> > '.github/workflows/check-style.yml'
>
> My recollection is that we made that job never fail because clang-format
> does not always do a good job of following our style guide and the
> output is not guaranteed to be stable across different versions.

Thanks for the history! Seems that when linter output is not
consistent between versions, then version pinning is necessary.

> That
> makes its value debatable as I don't think many people (anyone?) bother
> checking the output to see what suggestions it made. It would be a lot
> simpler for contributors if we just devolved style decisions to
> clang-format so no one had to think about or comment on the style.

My professional opinion is that a consistent style, auto-enforceable +
auto-fixable, is extremely valuable, because it removes an entire
class of code review discussions. I almost never care which style is
chosen, as long as it's the same everywhere.

I tried today to apply the full clang-format output and it was A LOT.
Doesn't mean it shouldn't be done, but it would need to be done at a
carefully chosen time because there will be lots of conflicts on all
in-flight topics.

> Whether that tradeoff is worth it depends on how far the output of
> clang-format deviates from our preferred style.

In the best of worlds, the preferred style is exactly what the linter
dictates, then these two are equivalent.


Harald
