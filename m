Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424580625
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322766; cv=none; b=qjW+Rtj+oy6OG5nvmizAmer7Qt8ERrIuIkHdUlThGA891duvRtjOtTvDtKHWVP8hRxA4zR0W/6sHDViTR2wjfDg/6FNsi1IslSmg6sLItvMaM6xEtwMeHMr6bfsvsoKPZYsbyLNWDXLlksJRGKpMz/To+60gWW9CHT6+yhKzHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322766; c=relaxed/simple;
	bh=xjuwQwxxBr+4Yv8xRjzVuCpnT0A95M34hgIdMi3SHXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZECDmrmbxNPwIhNKOUpnRus1kwavS4sS7lG3I72D8t4JQfCRAHtQwgmdAPcQDw+57cf7Ao63k5e8vW1PnJDuKajvjJZyhrzTutecKeoCmr45nL2SECYAllmD4+f2kDPpNGBwlryuLQkTkZQiYXSGlAKV1otOtVGOZHvTiiBjCr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRen8ZZi; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRen8ZZi"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e12b917df2so471521a34.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707322764; x=1707927564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oYnZBztl6dKy9Ik33f6yDc5tyWZdwCTdoGoiRlzlsE=;
        b=TRen8ZZindNU8D4JcDk8ZfybqQflUjBYszg6Ip/9kQdAqUCttdLcTrchUGBl8BjQyo
         QIkn86a6Rm3fwL0oL2UAv6aYTE91A/OZ8SkWKcV7XTBr/RQQsUR4NCry/H7lZaU1OFRf
         7rxnHNnIPSP9C+oHMyFsChQ2WzfuodJhy87WUpb+6dHtO9IBPVYGt0vbInc5L8b7TB+m
         3snbvQbjQYzL8LeB8jLnHHNj8mm+GedlBrOzidUF+UH7TFKzxnMCI7BFDPcfkePsL3q3
         zck9N7P+NH3Ak52vvypZozdh+ihGwJ6vuN1a5NJxJo0x6TmFvdoh1B4lymKksH1NFdHS
         N7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707322764; x=1707927564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oYnZBztl6dKy9Ik33f6yDc5tyWZdwCTdoGoiRlzlsE=;
        b=U5xWQ/ZFYpeMNCJ36Q5O2IdnoHp7CgzLQnS68XyfSEA+ouqXTBNNb1dTKd4bR9nda/
         8Avn7m1tpfi2QO/3uzwib/OzihcHuFWrz1sYW+rcwygodmGsq+Ed4bUdC2nUDMsBIhbM
         NtYIClnfUPe9XSwV5bKk4uRPZvLWQatHokpujV5DQfD/z2pbqFjmU5QLTr+b4IdiKXWE
         iByPNJBy2G3LNvVSZ+C+b2px4dBVsGu5lWoraAGoO/Z+5bkSQcSh6BH91D1ncp5Vqk6W
         JdfrTNItqAFIZ9pf3XBfva4UD0nfTUHtWreyoVt6Mi1T0NtS8WhKM6S48XpAlbW81pqi
         +EdQ==
X-Gm-Message-State: AOJu0YwQk9GcBsAIkdNr/dR1gD1JsMd10+0Ak9i1mLQ+NVRpI3V4PB4L
	Tr70alQY9Bw5V7lqJAFHx7r03M+2wuCHM0tpXx3NlpiTRa3kD87aWQZqIJHyjmmpSBcXQVX1OU5
	XADez3GT5D6Th7VNudhQ62chmlJ8=
X-Google-Smtp-Source: AGHT+IFDi1OsDWWcoKl++xjLhCaFmbsAl3V4NnEmfKi75IO5SuytvPELLKe5TzO9r10o1j2Jp2Bfy0MV2o4VEaXcOHQ=
X-Received: by 2002:a05:6870:469f:b0:219:c8bc:66a8 with SMTP id
 a31-20020a056870469f00b00219c8bc66a8mr3144701oap.55.1707322763869; Wed, 07
 Feb 2024 08:19:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com> <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com> <CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
 <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com> <xmqqle7xjzic.fsf@gitster.g>
 <xmqqr0hph1ku.fsf@gitster.g> <CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
 <xmqqcyt9fdc7.fsf@gitster.g> <CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
 <xmqq1q9oe029.fsf@gitster.g>
In-Reply-To: <xmqq1q9oe029.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 7 Feb 2024 17:18:56 +0100
Message-ID: <CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > I'm thinking "--all-ref-types" might be a good alternative. Mostly beca=
use,
> > "--include-root-refs" seems very specific to the files backend. Also, w=
e don't
> > include other refs which are not HEAD | pseudorefs, but in the $GIT_DIR=
.
>
> I strongly disagree wiht the "files backend specific" part of the
> comment.  No matter what backend you would use, refs and pseudorefs
> have the full refname, which may look like "HEAD", "FETCH_HEAD",
> "refs/heads/maint", etc., and you can easily see these full refnames
> form a tree structure, with "HEAD", "FETCH_HEAD", "refs/" at the
> root level.

I conceded to this point, I was thinking "root" here refers to $GIT_DIR
and this structuring comes from the files backend. But I see the flaw there
that irrelevant of the backend, there is a tree hierarchy built up and for =
refs
without prefixes, it can be considered as "root".

> I do not understand your "we don't include other refs", either.
> There may be "things" that are ignored by your implementation of
> "for-each-ref ''" even with the files backend in $GIT_DIR directory.
> They are not refs, because the refs are by definition inside "refs/"
> hierarchy, unless they are ones that are specifically included from
> outside the hierarchy ("pseudorefs" is one class of specific
> exception, "HEAD" is another).

This is a bit of a grey area, what I mean is that we do allow users to crea=
te
non "refs/" prefixed refs:

    $ git update-ref foo @~1

    $ cat .git/foo
    2b52187cd2930931c6d34436371f470bb26eef4f

What I mean to say is that, by saying "--include-root-refs" it seems to imp=
ly
that any such refs should be included too, but this simply is not the case.
