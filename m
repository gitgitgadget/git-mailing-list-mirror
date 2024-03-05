Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47F13FF6
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 01:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601935; cv=none; b=GCOVy6HQDyLDdpN6/zTXred2SqQgqZfvTbsyquQuopBBSONOOUxi1hl135Y+4e3tWGZI8g+Avm0zY8F0FBBZpmAKN4GNxs+W4zNCpDd2wXFaEPrqThdOxdz98F89cEigxiWoKsSjcZ+ndrk97TNJxxzPPBPMOOmAHa6D9476U2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601935; c=relaxed/simple;
	bh=8zjuP6lI+pffovixBPxr4rdcncTuZn7ZbRvGjF73GCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hCLmxIjTG72XDRqw7XqEkhMq/12Avs80vQBV3Laip8DaijhDhrfgIV2mLGdH1mPVn/0vZ1xuOmmHMThyUveGsf2xe1Kq3i7sDgZLFIhGbqWIZPpmwyTOjoLw6wQevzXHipUUi+nko1sUVrDtZEFIVRForoOefdVGU40lNlUXQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AWTJS9ox; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AWTJS9ox"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A799238AF8;
	Mon,  4 Mar 2024 20:25:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8zjuP6lI+pff
	ovixBPxr4rdcncTuZn7ZbRvGjF73GCQ=; b=AWTJS9oxSfXqcQo3JPnysXS/uucq
	DNVr5XJ5V0GtbN9dB8mwOsnOGnGiVzpBhYpMfPVmA31feh9/xc3AKYLSYk9R4ddY
	op40pEIbwVVzp9m7ojIZxDluzSuw5FvgZ+WvdwPCKcWcZ8oQ1xRZWr8Dybb/qApe
	PeOXCjeN1c/HNF8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FAE038AF7;
	Mon,  4 Mar 2024 20:25:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4034038AF6;
	Mon,  4 Mar 2024 20:25:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/5] t3200: improve test style
In-Reply-To: <e6a2628ce57668aa17101e73edaead0ef34d8a8c.1709590037.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Mon, 4 Mar 2024 23:07:26 +0100")
References: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
	<cover.1709590037.git.code@khaugsbakk.name>
	<e6a2628ce57668aa17101e73edaead0ef34d8a8c.1709590037.git.code@khaugsbakk.name>
Date: Mon, 04 Mar 2024 17:25:28 -0800
Message-ID: <xmqqplw9lbav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 411E88F4-DA8F-11EE-BD6F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Also:
>
> =E2=80=A2 Remove a now-irrelevant comment about test placement and swit=
ch back
>   to `main` post-test.
> =E2=80=A2 Prefer indented literal heredocs (`-\EOF`) except for a block=
 which
>   says that this is intentional
> =E2=80=A2 Move a `git config` command into the test and mark it as `set=
up` since
>   the next test depends on it
>

Especially the change to use "-\EOF" to make them align better
caused too many tests to be touched, but overall the result may have
become much easier to follow.  Good job.

> -mv .git/config .git/config-saved
> -
>  test_expect_success DEFAULT_REPO_FORMAT 'git branch -m q q2 without co=
nfig should succeed' '
> +	test_when_finished mv .git/config-saved .git/config &&
> +	mv .git/config .git/config-saved &&
>  	git branch -m q q2 &&
>  	git branch -m q2 q
>  '
> =20
> -mv .git/config-saved .git/config

The above is a truly valuable clean-up.

But I am not really sure if the paritcular condition is worth
testing in the first place these days.  No configuration file means
we cannot even read the repository format version, and working under
such a condition is quite a bad promise that we would rather not to
having to keep.  But that is an entirely different topic from what
this patch is doing.

> -git config branch.s/s.dummy Hello
> -
> -test_expect_success 'git branch -m s/s s should work when s/t is delet=
ed' '
> +test_expect_success '(setup) git branch -m s/s s should work when s/t =
is deleted' '
> +	git config branch.s/s.dummy Hello &&
>  	git branch --create-reflog s/s &&
>  	git reflog exists refs/heads/s/s &&
>  	git branch --create-reflog s/t &&

I do not know if the change of the title is warranted.  It is doing
its own test, not just setup.  It may be merely donw for the side
effect of making the step unskippable, but still ....

> -# Keep this test last, as it changes the current branch

Yes, removal of this line is really appreciated ;-)

> -cat >expect <<EOF
> -$HEAD refs/heads/g/h/i@{0}: branch: Created from main
> -EOF
>  test_expect_success 'git checkout -b g/h/i -l should create a branch a=
nd a log' '
> +	test_when_finished git checkout main &&
>  	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
>  	git checkout -b g/h/i -l main &&
>  	test_ref_exists refs/heads/g/h/i &&
> +	cat >expect <<-EOF &&
> +	$HEAD refs/heads/g/h/i@{0}: branch: Created from main
> +	EOF
>  	git reflog show --no-abbrev-commit refs/heads/g/h/i >actual &&
>  	test_cmp expect actual
>  '

Thanks.
