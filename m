Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA11CFA9
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501587; cv=none; b=Lp09bilwR/DQw65Hekef6QLFp+A4vcY2PCrd0VDrJuyk4FLtOJvmLLNkADHk6lNwdHqnVGLIPZUK8PCIpFi/oQZXPzau7yu3BeDyYAuBmEeDcnq9F+52abNDJjaQBqd2SFiCR+loCymkKxJWQTJtNK8/C2K08hczwb83vQwojd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501587; c=relaxed/simple;
	bh=ecirRlREFJNs+THxjZWRpZIxXkWNzrxhTgpKrORobA0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dc5F5PDjoYkLxyw/XAx+vs9CQbEbxU2gAT0Vbj5IdOVfADFvOxU1t2KmpsKwuy57cTcBJ3c4weWnPbapC+K7yI/elYPpt/Guu4ljHDPu3ArE9QAOfO6QBVgZUFjdwWGVpWDZDW4t0wJ6sFUVWNU0NaSVIz5PYN6bqdIyrh7WWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Qkfi5V8+; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Qkfi5V8+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728501583; x=1728760783;
	bh=ecirRlREFJNs+THxjZWRpZIxXkWNzrxhTgpKrORobA0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Qkfi5V8+iXJwABWiz8+iDvWY5+lqy0OpBbzzdIK1zm7L/qsXoSUWWGCyfcMk5HBpg
	 D8s4qNhOVkP0/zYH4pMVZjSMhLGRu57Ad/IDwqAZbOppU6agkgju9E//H5E0feCR5T
	 H1ewuHWD31mo+CTKOSelzpp718tOCechs/RcVPcoB2hN3/54vgoyFs011Nnj8Yfxkn
	 DRntBCBV3YMex4PsmRu9eFQmaucUHSPY0CTCO6VwulGomoSZRK7KFD5tJJEBpfOora
	 WsOekGX2yoV9DaTm8PZLNPB64r6HmuEH9i+IvpvxoSr3f2GpKl+5d/ceoHmSzbAZR8
	 RrZuJzT44Xp8A==
Date: Wed, 09 Oct 2024 19:19:40 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] worktree: link worktrees with relative paths
Message-ID: <oUBKv4JI3Bf1nqAFU_C-HDl5vkZC6mg8mb5F0HB7akXC6n0T1ddV0LiOCqY_AGHCyr9_W7gs2EyTGqIihz89ciBbL61UFwznnHcYRNzfGLI=@pm.me>
In-Reply-To: <xmqqy12xqehd.fsf@gitster.g>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> <20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me> <xmqqmsjexkcg.fsf@gitster.g> <k3X5W4US76LBJ_IUq-quVRha2jd-4iWJ9yX6Ukh6-ifZdWC3iajoUJ8VUyTDfkJHSqiD1RJlqIuVlDGIsReR_SDREVWyHGIqsXhazvJu1ek=@pm.me> <xmqqy12xqehd.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 4753510af3a11970e707f1298c979e11c3755a1b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------f71fcb580722f17d0cbc0d47c9ec5ff080839829b76b4525082c2536cc94fe17"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------f71fcb580722f17d0cbc0d47c9ec5ff080839829b76b4525082c2536cc94fe17
Content-Type: multipart/mixed;boundary=---------------------21d8f9d185d323daa609255a67a085b9

-----------------------21d8f9d185d323daa609255a67a085b9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

> Caleb White cdwhite3@pm.me writes:
> =


> > What's the best way to parameterize the worktree tests? I would like
> > to run the same tests for both absolute and relative paths and I'm
> > not particularly a fan of just copying them all into new *-relative.sh
> > files.
> =


> =


> What I meant by interoperability tests are a lot smaller scale.
> =


> A test that creates worktree/repository pair without the option to
> use relative, and then tries to use such a worktree/repository pair
> with the option would simulate "how well the newer Git handles an
> existing repository", and another test that creates with the option
> to use relative and uses the worktree/repository without the option
> would simulate "how well existing versions of Git works when seeing
> a worktree made with the newer git with the relative option".
> =


> By "parameterise", if you mean running a set of worktree/repository
> tests without the "relative" option enabled, and run the same set of
> tests with the option enabled, you could model it after how t8001
> and t8002 (or t5560 and t5561) share a lot of same tests that are in
> a file that is included by both of them. In smaller scale, it is
> common to have an ad-hoc construct like:
> =


> for conf in relative absolute
> do
> test_expect_success ...
> test_expect_success ...
> test_expect_success ...
> done
> =


> that has bunch of test_expect_success, which may change the
> behaviour depending on the value of $conf, not &&-chained inside the
> for loop. You can use a nested loop (one for preparing, the other
> for testing the use of worktree) if you want to test the full
> matrix.
> =


> I do not offhand know if such parametralized tests are necessary in
> the context of this change, though.
> =


> Thanks.

Ah, I see what you mean, thank you for the details! I'll be sure to
look at the examples and try to determine which would be the best
paths forward.

> existing repository", and another test that creates with the option
> to use relative and uses the worktree/repository without the option
> would simulate "how well existing versions of Git works when seeing
> a worktree made with the newer git with the relative option".

I can already tell you that this particular case is not going to work
because existing versions of git expect the path to be absolute. Most
of the changes in this patch revolve around properly reading/handling
the relative paths, not writing the relative paths.

Best,

-----------------------21d8f9d185d323daa609255a67a085b9--

--------f71fcb580722f17d0cbc0d47c9ec5ff080839829b76b4525082c2536cc94fe17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnBtc/CZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAACLugf+N4L7LeGwGoAgvPrYM/iN6ICrKYAD+QgFNuYiu1h/zdulb1wL
f32VW0UrtbmHTxJ9+HvPJPWLIl8Qw0lWAHXP2Rc5xf0Kp3hfxJ1JM200DwED
Hvhi7eX7eFQetolqRE+lH7u3vv2uijbJaI7IL/iBZPSLaNvnn4G6NY7nGZEn
+vne8D4lhgY9pCMyN6geUICsD8OKFYNW7LIgfvoYhH4vDu0kpvLRl5u5jF0d
PyTjdN/eYHnpG7lSn5sVJlQDJDAZkzPNElFaPuFh1l9YjeGedN+JRMqVGIkN
BDXMBrT4p0vJOgCzabSU2izbnc4Js5+64bpl63uz2tAWaCDMTaeRLA==
=P0+h
-----END PGP SIGNATURE-----


--------f71fcb580722f17d0cbc0d47c9ec5ff080839829b76b4525082c2536cc94fe17--

