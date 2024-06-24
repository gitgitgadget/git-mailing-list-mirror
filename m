Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540945010
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262403; cv=none; b=lzQ2Am5tmtgl7eg2g0YNU5uvbdvJ3pLen9nbhDp+k0FG1diB9+TuR+73t0fsuiXL/K/yWXQMIuHYuLWcq9pt+NfgNqi+uYZuVVtqS0Y1USZFQubHO4I334+hpaoQeTbz5+03EgZJwrFdgSUgpgJWygLIzLUtW+uc2+79fFIaIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262403; c=relaxed/simple;
	bh=EZmtz/dfYCHcxbYgZ+i//s3d1BhzVCF100d+DyuXOZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mz19lKNwLK56oLvVHRAI7moDN2xENGfPO0yvE6DZweOrWAXq3d52ITiJI7IgVkrCjQDC9hqCIjdHTnckXHtEp6iZ7j+Y5+s6uOgcg4K2LmriQweb2XmUmyl1FiyaySfGAnYPNLUiBIV3td9mFnljZCnGVAfRCoUm87KPlS+dXTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N6O0w+Rz; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N6O0w+Rz"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D8B71FE23;
	Mon, 24 Jun 2024 16:53:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EZmtz/dfYCHc
	xbYgZ+i//s3d1BhzVCF100d+DyuXOZo=; b=N6O0w+RzvpwEE7rQc2JWgDgc/20B
	b2jNbRyrhDeHBm52ZuCAvC51TiDUbekUihEL9gQwK5Ggle1viYlO2hC3CA/h4I3B
	uyiaADUIo556WEvEG/14rRrg23l0e2zltFBs0iNqRlWl/iBMRxecxxh/QyLFE+nj
	wMYpGOL96aSZs8k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8587D1FE22;
	Mon, 24 Jun 2024 16:53:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB0AD1FE21;
	Mon, 24 Jun 2024 16:53:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: lolligerhans@gmx.de,  git@vger.kernel.org
Subject: Re: [PATCH v2] diff: allow --color-moved with --no-ext-diff
In-Reply-To: <fee1815c-80bb-42a4-97f3-d3f8e9b3a6ca@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 24 Jun 2024 21:15:45 +0200")
References: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
	<fee1815c-80bb-42a4-97f3-d3f8e9b3a6ca@web.de>
Date: Mon, 24 Jun 2024 13:53:18 -0700
Message-ID: <xmqqed8mawqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C9C4D170-326B-11EF-AC36-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> * use echo instead of false as the (unused) external diff command to
>   avoid giving the wrong impression that diff.external is a boolean
>   option we turn off here.

I am fine with either "/bin/false" or "echo".  I kind of found it a
nice way to assert that --no-ext-diff is indeed in effect (if we did
not disable it, "false" would lead to "whoa, your external diff
driver returned a failure").

Thanks, will queue.

>  diff.c                     | 3 ++-
>  t/t4015-diff-whitespace.sh | 9 +++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 6e432cb8fc..aa0fb77761 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4965,7 +4965,8 @@ void diff_setup_done(struct diff_options *options=
)
>  	if (options->flags.follow_renames)
>  		diff_check_follow_pathspec(&options->pathspec, 1);
>
> -	if (!options->use_color || external_diff())
> +	if (!options->use_color ||
> +	    (options->flags.allow_external && external_diff()))
>  		options->color_moved =3D 0;
>
>  	if (options->filter_not) {
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index b443626afd..851cfe4f32 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1184,6 +1184,15 @@ test_expect_success 'detect moved code, complete=
 file' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success '--color-moved with --no-ext-diff' '
> +	test_config color.diff.oldMoved "yellow" &&
> +	test_config color.diff.newMoved "blue" &&
> +	args=3D"--color --color-moved=3Dzebra --no-renames HEAD" &&
> +	git diff $args >expect &&
> +	git -c diff.external=3Decho diff --no-ext-diff $args >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'detect malicious moved code, inside file' '
>  	test_config color.diff.oldMoved "normal red" &&
>  	test_config color.diff.newMoved "normal green" &&
> --
> 2.45.2
