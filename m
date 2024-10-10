Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF419922D
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581431; cv=none; b=Vi1QpdpJi4rHpbAOH0NfNEbOcy03T5U+Y2gqCG0ZlyyZqaR9Flejf+54ry4wdCNfyg/OaCNlwPQR2x4VQSgqq++zelYAryMKnx0GF/l5rx7eAmxXBmtMXkOAMJO1h0gvFfuN/QKteQCC+QvxjSkvgmrIhEthy6BGFiBIWq8nsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581431; c=relaxed/simple;
	bh=35P5a2uFDVWOh3EVC2l1OZJuvz1/mH/P1/tNFbu4UxM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olgDHAxbyQFHCDdMJU4sH2R/JhB1T+0I7KgnuxzqrnpIpjagqWt+gDsaly5Z8V5bwOs1Husr1tgyQ0aG40AKRxJy8iY1Kte3uajQIxa3ofez886+j/CFcevOebt1bLl/4AQjgJCVFEUL9jPUA0TZuZD3YDvoxypJWrQdqXyLb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=oVz7maWg; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="oVz7maWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728581428; x=1728840628;
	bh=35P5a2uFDVWOh3EVC2l1OZJuvz1/mH/P1/tNFbu4UxM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oVz7maWggrdWuMWZuEU7pmlvrYxUc08xDNPx2FbXNKFZa4eoNR4DV2scrgWMYe2ml
	 tZsxVcnbv8Z1QjC3liUh6hNmN8XfMKXjfYg7Mcxu3tmKlIHuTwAGQR83ORc+lrZiPZ
	 bltnWCiEbm0ljrHSXjsFSuvrhsOMO8Yu/mm+TVDG9aChS72La7TVDaV19jbt8N8q+z
	 FJmIuBO0nG8yhGeLmBbaBOLJjRo7dIT17koyFvuiVhpTX8tbrfUGvhGwRP/Hsk1Kxv
	 nmadyYTL3iJSDgTqRZHH4oKH4mLZG7PefPzyqxoerVF1fvHb1PztxN86bYiM0/v3US
	 Ac36W34DWHZ6A==
Date: Thu, 10 Oct 2024 17:30:22 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] worktree: link worktrees with relative paths
Message-ID: <gSEdRZ0rf9yJ68dp1Jgq7CYrXPGMgUxgBji4qs_emJy25eHOG7ULCtH8f2bawTRFSMGoxC_QsB7EN0OJnbQ_Olf66hNk8fEJoVMkkIlyA14=@pm.me>
In-Reply-To: <xmqqfrp4onjd.fsf@gitster.g>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> <20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me> <xmqqmsjexkcg.fsf@gitster.g> <k3X5W4US76LBJ_IUq-quVRha2jd-4iWJ9yX6Ukh6-ifZdWC3iajoUJ8VUyTDfkJHSqiD1RJlqIuVlDGIsReR_SDREVWyHGIqsXhazvJu1ek=@pm.me> <xmqqy12xqehd.fsf@gitster.g> <oUBKv4JI3Bf1nqAFU_C-HDl5vkZC6mg8mb5F0HB7akXC6n0T1ddV0LiOCqY_AGHCyr9_W7gs2EyTGqIihz89ciBbL61UFwznnHcYRNzfGLI=@pm.me> <xmqqfrp4onjd.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 422fdcb5dd257ddd3b46ac78d4c01bcab8fa77b2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------9ecb843d7ae508a0942b6f551aec0f87803e663d74232f75442641d34cb66b36"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------9ecb843d7ae508a0942b6f551aec0f87803e663d74232f75442641d34cb66b36
Content-Type: multipart/mixed;boundary=---------------------e8542617f3ce24bfaee60847911af45e

-----------------------e8542617f3ce24bfaee60847911af45e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Wednesday, October 9th, 2024 at 18:37, Junio C Hamano <gitster@pobox.co=
m> wrote:

> Caleb White cdwhite3@pm.me writes:
> =


> > > existing repository", and another test that creates with the option
> > > to use relative and uses the worktree/repository without the option
> > > would simulate "how well existing versions of Git works when seeing
> > > a worktree made with the newer git with the relative option".
> > =


> > I can already tell you that this particular case is not going to work
> > because existing versions of git expect the path to be absolute. Most
> > of the changes in this patch revolve around properly reading/handling
> > the relative paths, not writing the relative paths.
> =


> =


> If we are talking about making irreversible change to an existing
> repository, we may need to grab one extensions bit (cf.
> Documentation/technical/repository-version.txt and then refer also
> to Documentation/config/extensions.txt [*]) and flip it when we
> wrote a relative link to refer to an worktree and repository.

Thanks, I'll take a look at the references.

> [Footnote]
> =


> * The repository-version document claims that any extensions
> invented must be registered there, but config/extensions.txt that
> came later ignored it and seems to have acquired a few more than
> the "master list". We should clean up the mess.

Would you like the contents of config/extensions.txt moved into
the repository-version document and then deleted?
-----------------------e8542617f3ce24bfaee60847911af45e--

--------9ecb843d7ae508a0942b6f551aec0f87803e663d74232f75442641d34cb66b36
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnCA8gCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAA0uAgAoTm3qqMrykrK5l5BoAAuvBbqOjdhBVGujwrGVweCmzS/avCA
Qge0MQLNkGqSI8AY3fEnbibOH6X/PP7omO/7JAjSAdfpQ2irmycmaw23Oa11
b4cs3EEolo0b8EQbQns2hVAKncWAMTlWHFNGLiQmUg9z5PhXvIFa65+99QGG
URLSxInabgv3244uDjbqT+YvycsSjvID5vdYwKMjyofG1UQ4HCwuKmq4YC2c
aBu9KjD4K21mn7N1KtzsvZ6YpsgauprJGv4YdaoSm26UKd+Iu89ZZdMf3O/N
jbRMpviCjfLu+tkDqATNsmKDNjX2HEob0WYcMUYldB2yIFz3UhQDHA==
=fp7E
-----END PGP SIGNATURE-----


--------9ecb843d7ae508a0942b6f551aec0f87803e663d74232f75442641d34cb66b36--

