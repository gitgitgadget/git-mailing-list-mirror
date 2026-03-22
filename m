Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267BB8F4A
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774141989; cv=none; b=qHNeURYQZ35hyurxYTBOr+HgFiNIBWWmBzJHzqLgUWguatOiDZ4tdlmp1pNy/vjn2k/MXOZXVgjdwXBLMZSp45ut9xZQAsyt/eDHE+Dy9reAE/vrVYM/ixQlL20+c4W9VZjXxYzs+y/Qebn8/OT5UyxkwtuqQT6HjyPoWRAZP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774141989; c=relaxed/simple;
	bh=JVUCKJy/iMPv3L09Vn1BKwFdYyc508I31fzqnVAtdFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5cFoTeOYWg6xinauj9oqcfUpDOUXo2DZmhaEooSSE/L/YTAXoOsWbSpMt4jVLAly3HsftVyCNWj57josb0u1T6sgWRqKyoy7la+Nu81cXnrBaQIXVvhJCl2ipTZmwVMh+ehp/NXtoVflf/9Pf8qp9UqJHZvpordLCGqwc/HwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QZOVmEnS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wrjl8nPi; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QZOVmEnS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wrjl8nPi"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBEF77A011B;
	Sat, 21 Mar 2026 21:13:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 21 Mar 2026 21:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774141985; x=1774228385; bh=xNDkGR+5z9
	Fw2my72fry1mfn7vI+yA1nsmZ9QyWSQ2w=; b=QZOVmEnSq2BD125QhF/ZtwUZJS
	o4j4YLfkk33wHwq04b9ze3yoBhixipWNjJmn5uO17lU5xsVdQcBnLQZZtGHObYUU
	XhY3l+ebJSuQ3ttvVdDPHR4G2TIgOA6j93vFRaT2LwZjhOnJK7uEj8DD9vKLZR0h
	r5SGastycaqL0JPxZfab3F37DWeL9GFXapaZJaRdhOQ0nfg0SF9dP0zYERuYzaZK
	MX+YOBNOq8T/wCE30PZuXRfNw9vH05YM4Btvdaa9/LwaiOjKJKY1eEiW8SyiQSiH
	tsTbU161MQ9LFH44j0UlHbjVwo28cb17XlRwaIkJdQssBF7Dcjr5sVUfHMlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774141985; x=1774228385; bh=xNDkGR+5z9Fw2my72fry1mfn7vI+yA1nsmZ
	9QyWSQ2w=; b=Wrjl8nPinXM3HZkH/n803Cl5cplSb/w4S7IUTtBzgH6KsujFzrN
	wsomIUzqwylXA9VaUkuQOjr6ldiSzGrb4uU5MLt5j/SQwGa5M8nuRtKyaTr92x7m
	fZaSoA0YcLJfD/1MrvPO+lKXRUv5/uSGUmLKW3NAgcQNJ6fNoeaFd/xZbipLlcqY
	OnmHLhEKV0bPNmVGsfJJpXjoz0SvZi8iWNcnlFbKf6v9blFnNPEZl62FOlVZ3e3c
	8dfwV3WkWUTfy8LTKN8zSlGBY/b1asGdJkrymotHfByAV26r7lNg0+m4Yd3fCYmH
	3NHsJzl28zrAc/FN7OaKYqG+Hvx5CkLhzLg==
X-ME-Sender: <xms:IUK_abcBhaWFCnsqfCvblAWycai6NyBr31z3dOJZxetXsaluXfOqjA>
    <xme:IUK_aYELDVu5fu2D1C28bX1K11asFYaAyeVoosuS87CoeBHKfkfniB_Fk6Kx6gbDw
    dN4FidNXO14KSSIxTZuMdeC7XvxGtwWjGKWas836WfHU1ya1xabMw>
X-ME-Received: <xmr:IUK_ac1e4pgMeAzOzIkJI0bbR6INW3MJY4z8bJSBlp5FEgsF7pBwZThhQkDJe8RQsEAoGpkzR3DPS64uESxPPUPvu6zYDzFJRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeggedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepueeifffhjeefvdfhffekheeuteefkeeuffegiedtkeeguddvueejfeeuvddt
    vefhnecuffhomhgrihhnpehhthhtphgurdhshhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrdhsih
    guughhrghrthhhrdhshhhrihhmrghlihesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IUK_aYm1KyoNkPG0mjzT4cSy5Ca4rSRhuaQhTUuirq57Z7-6hMIjzg>
    <xmx:IUK_aU8eF5f5bZPxY-PoD7-NiXUhBycBu5y_VtLFsmbVsKRc_SQfHQ>
    <xmx:IUK_aVo745APAvwBFGVN7z7SCD3dWyUcRsgDn2hygCo0fRxpbkXUrg>
    <xmx:IUK_aVlpRPEQP_MWImjdZkupmB4A-K0fdieW0EaN_q4n9hONAOzAMw>
    <xmx:IUK_af38x0_M8qYSDcFkY3Okv9BlEplMwbseIuGOhmoF3x9mOEpZhgm6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 21:13:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  stolee@gmail.com
Subject: Re: [PATCH v2] backfill: handle unexpected arguments
In-Reply-To: <20260321174730.34762-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Sat, 21 Mar 2026 23:17:30 +0530")
References: <xmqq341tdbal.fsf@gitster.g>
	<20260321174730.34762-1-r.siddharth.shrimali@gmail.com>
Date: Sat, 21 Mar 2026 18:13:03 -0700
Message-ID: <xmqqfr5sacps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> git backfill takes no non-option arguments. However, if extra
> arguments are passed with git backfill, parse_options() leaves
> them in argc and the command ignores them silently, giving the
> user no indication that something is wrong.
>
> Add a check after parse_options() to call usage_with_options()
> if any unexpected arguments remain. To ensure the user understands
> why the command failed, print an error message specifying the unknown
> argument before showing the usage string. This is consistent with how
> other Git commands such as git-bugreport handle this situation.

While it is a thing to aim for, I doubt the updated behaviour is
consistent with how bugreport behaves.

	$ git bugreport extra-arg
        error: unknown argument `extra-arg'
        usage: git bugreport [(-o | --output-directory) <path>]
                      [(-s | --suffix) <format> | --no-suffix]
                      [--diagnose[=<mode>]]

I.e. the command does not show the list of options with descriptions
to the user, who did not make any mistake in specifying any dashed
option.  On the other hand,

	$ git bugreport --mistyped-option

would give usage_with_options(), because unlike the case where the
user gave only an extra argument, it is clear in this case that the
user failed to choose the right option, which might be helped if we
tell them what each option does.  Also with

	$ git bugreport --suffix

the user will get a more targetted help that is specific to the
option given incorrectly.

Compared to that, the way the updated code would react to

	$ git backfill extra-arg

cannot be called "consistent with how" bugreport handles this
situation, I would have to say.  I didn't check how the command
behaves in the other two cases (i.e., option that does not exist,
and an option that needs a value but the user forgot to give one)


> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index e9a33e81be..5a333afde0 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -135,6 +135,11 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  
>  	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
>  			     0);
> +	
> +	if (argc) {
> +		error(_("unknown argument `%s'"), argv[0]);

Yikes.  Please do not add more uses of cute quotes.

Perhaps we found a microproject target for the next intern season?
Let's not spread cute quotes any more than what we already have, and
clean existing up ones before it becomes too late.

    $ git grep -e "'%s'" \*.c | wc -l
    2012
    $ git grep -e "\`%s'" \*.c | wc -l
    16

> +		usage_with_options(builtin_backfill_usage, options);
> +	}
>  
>  	repo_config(repo, git_default_config, NULL);
>  
> diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> index 58c81556e7..d74e1be74b 100755
> --- a/t/t5620-backfill.sh
> +++ b/t/t5620-backfill.sh
> @@ -176,6 +176,11 @@ test_expect_success 'backfill --sparse without cone mode (negative)' '
>  	test_line_count = 12 missing
>  '
>  
> +test_expect_success 'backfill rejects unexpected arguments' '
> +	test_must_fail git -C backfill1 backfill unexpected-arg 2>err &&
> +	grep "unknown argument .*unexpected-arg" err

The test is a bit underspecified, isn't it?

This test will still pass if the code called usage_with_options() to
show the list of option descriptions after the short usage, instead
of showing just the short usage by calling usage().

As with any test, it is important to test that the output has what
we expect to see, but at the same time we need to ensure that the
output does not have what we do not want to see.

> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
