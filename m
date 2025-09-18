Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C672EA494
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181359; cv=none; b=NtTcWuXZ4hU6xL6bf5pF20GOKdwMBGNclvkwEqMeXmJRqnQFul9kzI8KTWs0pRCbn6vr7FeJEsdLMjB7LpfkKGFFDrmBrxcu2HZugn2+0tHkRL0CuE8NbXi0fFeBky3j9qFcSrHAwxcXRKXaigXqABniHtXjPHdBx2UQiQy71Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181359; c=relaxed/simple;
	bh=jhQdTmJ45pvMa2j+9SyBQT051lm7mreKaT+MSnThCHA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSZIfbktS5lblOy0YvwNZeSuwcZ5nqWQ/pedimVv+s09gAuK0i+f6Q8iXxFu9P5MSWlimCgK4pt/2PfIYEYvzbuKQKPaLBLjfpC3qq8+90xrYBpwAqf7+oJbepDkZvm4K0NFbqVpdg7v08CYrh4hkmT6rugqB4EikuR7jERW3ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jjerphan.xyz; spf=pass smtp.mailfrom=jjerphan.xyz; dkim=pass (2048-bit key) header.d=jjerphan.xyz header.i=@jjerphan.xyz header.b=JV6vwHNT; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jjerphan.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jjerphan.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjerphan.xyz header.i=@jjerphan.xyz header.b="JV6vwHNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jjerphan.xyz;
	s=protonmail3; t=1758181353; x=1758440553;
	bh=TSxiXLhZksWtC8SGaAu0JV671w/mhULZsKlRARWrg/g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JV6vwHNTeL7E7khwcPYUEpvKpPMpTPNpeqS/H6DT6Y8DdZFEiB1w9exjpjoYqbMSG
	 dK+P/TEzfgcvahV4WoBYMxvHfxydZls6GnTLeNPHoIrGLL1YTG0befuReCxvOyTwqp
	 CZSNu+8EclU+nDZaZC+umuKwfOClzLn1p32S2sLqyNV8MguOf+/2A4bjslQ2VifX41
	 TcjHRjbGitVYbKyc7zZrqAK80nPSizBWzB87p0/SFZGsDpMoZ1A3M4aD3a/VTBJfLe
	 VXg3Oi1XC0DjK8gyTQ/BycJh4kJUs9Q5/6BqXOjUrAp+rCkNfSkAntEBc1jAR0jHBR
	 nYTlWTrK0sQAQ==
Date: Thu, 18 Sep 2025 07:42:28 +0000
To: "gitster@pobox.com" <gitster@pobox.com>
From: Julien Jerphanion <git@jjerphan.xyz>
Cc: "gitgitgadget@gmail.com" <gitgitgadget@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Add `-u` short option for `git pull`
Message-ID: <P018trwh6r7kRRrp99nCCDUdrKT3u7MvjNd_wUm2o2w3alWw4gpsvbEmp856xwAnMkuuLQBEUNfNxCU-K7xO0Zrw0Qsy5ZP5kOrDXjcwNQQ=@jjerphan.xyz>
In-Reply-To: <xmqqplboa9cb.fsf@gitster.g>
References: <pull.2037.git.git.1756147789443.gitgitgadget@gmail.com> <xmqqikiam90b.fsf@gitster.g> <VVHyXy0fQW1fnBgiAFswUMEMMX4wnc3YIZWSRtSJzZbHOt0dfY0wCJt69MDxfue54cN2gPd8StlVtW2ERYKZcEs8Hpm7X5TaXrygCN2rK-A=@jjerphan.xyz> <xmqqplboa9cb.fsf@gitster.g>
Feedback-ID: 10827467:user:proton
X-Pm-Message-ID: 00587da80edcd1cbd49d2e8cd7bad7d9a5ea1d6f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-------- Original Message --------
On 9/18/25 02:32, Junio C Hamano <gitster@pobox.com> wrote:

>  Julien Jerphanion <git@jjerphan.xyz> writes:
> =20
>  [jc: line-wrapped an overly long single line]
> =20
>  > Having this shortcut would be really useful for some use cases
>  > where one needs to pull locally branches from forks before
>  > updating them and pushing them again on the fork instead than on
>  > the upstream project (typical use case for conda-forge's
>  > feedstocks).
> =20
>  Sorry, do you mean that you stay on a single branch, and then you
>  would pull from one place with "git pull -u" followed by "git push"
>  to push back there, and repeat that for other places, practically
>  redefining the meaning of the "upstream" to "the last remote
>  repository I pulled from and I am supposed to push to that remote
>  and nowhere else in my workflow"?
> =20
>

More or less, I was referring to the official repository in
such workflows as `upstream`.

I would also sporadically fetch and pull from `upstream`,
but I would not set local branches to tracks remote
branches there.

As a user, I find that having `-u` usable for the `pull`
command would be consistent and expected given that
it is present for other commands already.

Thank you for spending time considering this addition.
