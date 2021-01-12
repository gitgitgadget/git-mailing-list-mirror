Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EA7C4332E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859062311C
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392995AbhALTsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 14:48:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54645 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406975AbhALTsL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 14:48:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42DC6AAC09;
        Tue, 12 Jan 2021 14:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1ITYcq5kb4b+cepFib3nN9zWogw=; b=Yo/w8d
        UmloNTCqCjj5NDGXqD6xYjCVIcH+erfbZcGZ0I1TWruok2hAHdSY1yorBX5MtT5g
        jUvmvlFUNauMpEggQ1UUAelMYvgU+iEOyZBYpkg5IhGU+e1P2Mb06IA+A9Lya1lU
        Axw/CydRYSU0Hdsfi0BGslpiRpmyTNqWhhU0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IiLoEgaat4t5XHu+jltf4cVu9+0nhZa+
        lMUVwaauW0tgYuUtUxbms9erDGPdMIb/TPi2GB49Umqz1Xf8OoRDa7hYeo1X1vq7
        RSgOdCGiRPTbeDmTo/r0Oci0Z9WaqldjfFPwOLaIy2tXliYeJP5D+I4l/MUabS42
        PgMdj1wewXM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B6EFAAC08;
        Tue, 12 Jan 2021 14:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBB69AAC07;
        Tue, 12 Jan 2021 14:47:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 09/11] GETTEXT_POISON=rot13: do compare the output in
 `test_i18ncmp`
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
        <4669ccbb1ae40f0c58a2d8e3c8b3a34d82176c7a.1610441263.git.gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 11:47:28 -0800
In-Reply-To: <4669ccbb1ae40f0c58a2d8e3c8b3a34d82176c7a.1610441263.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 12 Jan 2021
        08:47:40 +0000")
Message-ID: <xmqqeeiq3pkf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00999B06-550F-11EB-9A98-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +static size_t unrot13(char *buf)
> +{
> +	char *p = buf, *q = buf;
> +
> +	while (*p) {
> +		const char *begin = strstr(p, "<rot13>"), *end;

AFAIR from my reading of [02/11], the encoding side did not special
case the payload that has <ebg13> or </ebg13>; if we want to make it
reversible conversion (which is excellent improvement over the
current "# GETTEXT_POISON #" obfuscation), we'd need to do something
about it, I think.

But on second thought, nobody can prevent a caller to die(_("%s", msg));
to have "<rot13>" in the msg part, so perhaps punting like this
series does is sufficient.  I dunno.

> +		if (!begin)
> +			break;
> +
> +		while (p != begin)
> +			*(q++) = *(p++);
> +
> +		p += strlen("<rot13>");
> +		end = strstr(p, "</rot13>");
> +		if (!end)
> +			BUG("could not find </rot13> in\n%s", buf);

And the user of this looks quite straightforward and nice.

>  test_i18ncmp () {
> -	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
> +	if test rot13 = "$GIT_TEST_GETTEXT_POISON"
> +	then
> +		test-tool i18n cmp "$@"
> +	elif test_have_prereq C_LOCALE_OUTPUT
> +	then
> +		test_cmp "$@"
> +	fi
>  }

