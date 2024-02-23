Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D0E12E43
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671513; cv=none; b=GwSNwDx9frxV52fmcYoScWNqpiH/aiaqxHJFMPLc8xiVC+n02Aorvsnqm9c2gLL+fFWXKCzC3/A5q6nXFJc1jvajhh2nJ4XHwvoeBE65MZrUKlM/vNlbpcGe0H3LFw5W8hzU+o2xSisSR4o5dcd6Roga5NobNHt3xw6HcfkYKSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671513; c=relaxed/simple;
	bh=gUp2w0MlLSKDds4PgPMoTtQIEuhtKcTil2FIlZj267Q=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=YDKLVI6OGBGQe/JxPN+cAuTbR1AHLYsJNyKaviCDIXL5xTigWJ+2XD8sgo/nVJ1aqIYk05VjuZnbx6zvMakSfgaoe9l6OIY02jatrYSS/w1I9fiBVGzRNoTNaCBha2rXcZwzMEEv8oLXO9heTpMoftYP6ioq9VZ0EzObp9U7PLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkicMEcy; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkicMEcy"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-787a2e56b11so31982985a.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 22:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708671510; x=1709276310; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2rULARKdLcgcAH9PgzEU/s1LQFURy5NnYrajAEICHes=;
        b=YkicMEcyEtivPIshwod2XNErVLU67sGqsvXh7DYO/5F6ouTduwaYnmgPwpubgRJfOZ
         W54lwnQYukgahZLQiJGuQeMm+EtfdUvKrgFcJFXCspB2udnP6RW9tLTl+3ar9RuZH4SY
         O+kSjIBZHy2uYH6f0stOuXxm3eqnz9Tnmp2TKZDvJubBBAGotwuXDPWJreW5BaZPElaU
         eeOHgEzDpXRXfp0rZb6yv1Euio+8wwW7zTEFgaPKW4O708qSYvID2BLHqvNC94d5rNcd
         zK2twdLr1QyZcobdfIhg2T5oE1FEr2FOhedbj+Dzvy1XZUlToBxpib71C7pYB18d7KnW
         b+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708671510; x=1709276310;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rULARKdLcgcAH9PgzEU/s1LQFURy5NnYrajAEICHes=;
        b=ml7q5k4PtWnvaaQlWywv2zy/g/nujNDP4P/4PXBhX7ZkVdTyKRAgyLLTZO1bumMXWh
         V0JJkczTiu8Lgb14FMubDbEOOPNHul+dLyYJD31Bje73JRfKEw5bDifZ7uyDBlpVBaVi
         eazCnBi5V2d7rqd3mseb0USJoCtaVPVHcv2t2fAAZ2scVbjntmtZ1c67O8ZHZvV8LcoZ
         /eRk2ZsWWlXMmneTqi6wxLtZIXet/YeSuQYNGpf50H8vTvsx5PIBn3gCjrhgwXMW/aPn
         W7d8ThX1rfYjwe+mJ0aR3pYmICEo+xaGHN23ORlZAcFHPRAQcEmxn5sSTaOZz+cUecjj
         nGgg==
X-Gm-Message-State: AOJu0YxKzNhq1sx1tA4j1yg2BJ04fE5kU2kZ+JxtM+qCZswnYgAUVli2
	MLGLPLTjdKQGVudCOQQEpZ0/87X6r4PxcMb7VwU8U69B5klVQfbdGpBMMv4V
X-Google-Smtp-Source: AGHT+IG90/k3ajhPrjR2azYmvmXTQwl1sykEqCjCGytrAaoKdFqTRDDYn8Ac6luPEc/79AQ+vWCqag==
X-Received: by 2002:a0c:f383:0:b0:68c:e521:4af6 with SMTP id i3-20020a0cf383000000b0068ce5214af6mr1184962qvk.40.1708671510186;
        Thu, 22 Feb 2024 22:58:30 -0800 (PST)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id nf2-20020a0562143b8200b0068fd04cc474sm737473qvb.41.2024.02.22.22.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 22:58:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <phillip.wood@dunelm.org.uk>
In-Reply-To: <bb23026e-72c5-40a0-bd5f-356a03efa5aa@gmail.com>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, 
	<me@ttaylorr.com>, <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] cherry-pick: add `--empty` for more robust redundant
	 commit handling
Message-ID: <17b66baf4d8c4255.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Fri, 23 Feb 2024 06:58:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On Thu, Feb 22, 2024 at 10:36=E2=80=AFAM <phillip.wood123@gmail.com> wrote:

> I'm leaning towards leaving `--keep-redundant-commits` alone. That=20
> introduces an inconsistency between `--keep-redundant-commits` and=20
> `--empty=3Dkeep` as the latter does not imply `--allow-empty` but it does=
=20
> avoid breaking existing users. We could document=20
> `--keep-redundant-commits` as predating `--empty` and behaving like=20
> `--empty=3Dkeep --allow-empty`. The documentation and implementation of=20
> the new option look good modulo the typo that has already been pointed=20
> out and a couple of small comments below.

I think I'm on board with leaving `--keep-redundant-commits` alone. I'm
on the fence about having `--empty=3Dkeep` imply `--allow-empty` after
seeing Junio's concerns. I laid out the options that I see in a reply to
patch 6/8[1] and would appreciate input there. I'll adjust the details
of this commit in v3 based on what we decide there.

[1]: https://lore.kernel.org/git/17b666ca6c4b7561.70b1dd9aae081c6e.203dcd72f=
6563036@zivdesk/
>=20
>> +enum empty_action {
>> +	EMPTY_COMMIT_UNSPECIFIED =3D 0,
>=20
> We tend to use -1 for unspecified options

Thanks, I'll update this in v3.

>> +test_expect_success 'cherry-pick persists --empty=3Dstop correctly' '
>> +	pristine_detach initial &&
>> +	# to make sure that the session to cherry-pick a sequence
>> +	# gets interrupted, use a high-enough number that is larger
>> +	# than the number of parents of any commit we have created
>> +	mainline=3D4 &&
>> +	test_expect_code 128 git cherry-pick -s -m $mainline --empty=3Dstop ini=
tial..anotherpick &&
>> +	test_path_is_file .git/sequencer/opts &&
>> +	test_must_fail git config --file=3D.git/sequencer/opts --get-all option=
s.keep-redundant-commits &&
>> +	test_must_fail git config --file=3D.git/sequencer/opts --get-all option=
s.drop-redundant-commits
>> +'
>=20
> Thanks for adding these tests to check that the --empty option persists.=
=20
> Usually for tests like this we prefer to check the user visible behavior=
=20
> rather than the implementation details (I suspect we have some older=20
> tests that do the latter). To check the behavior we usually arrange for=20
> a merge conflict but using -m is a creative alternative, then we'd run=20
> "git cherry-pick --continue" and check that the commits that become=20
> empty have been preserved or dropped or that the cherry-pick stops.

Indeed, I was modelling these new tests after other existing tests in
this file. While I agree with you in theory, I am hesitant to make these
new tests drastically different from the existing tests that are testing
the same mechanisms (and appear to be very intentionally testing that
the options are persisted in that config file). I'm also hesitant to
update the existing tests as part of this series (primarily due to a
lack of familiarity, and partially to avoid scope creep of the series).

How concerned are you about the current implementation? Does it make
sense to you to defer this suggestion to a future series that cleans up
the tests to do more user-oriented checks?

--=20
Thank you,
Brian Lyles
