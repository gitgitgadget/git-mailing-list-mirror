Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12918C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BF022CB8
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 21:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388918AbhAKVzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 16:55:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63223 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAKVy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 16:54:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45DDAA295F;
        Mon, 11 Jan 2021 16:54:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=r7eaHzKgKIz7
        Ouqr1OrwDSYJsFc=; b=riteKSgfEd3/v63Jn9Q+SqSKTuYqjlMZBi5xLzzhsemh
        KZvNHZTQqHaq/+cHgaSyykF53Dqh5mFaqpbayUjggv/yE5wX+m2y9AwRtHzdVZj2
        HjjTONQmu255qqM8WYYrG04bkEgz2Up988V8kHWq7mJ0sdjKw7IN6VhH/1wuU70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yiyPq8
        bARpg73lhuVWQxC5dO56tAgFt5M1dh9q5KYN3ya6yTrOZBj6H3VDYsHiPsnVCB+l
        N6yNYI77poxo9cYsQ7gXhAQlKOSFDL1Di/koGvDpqn/mEHGATwr+wTntol3PO2rM
        3XEUxo91orvPqcHZicot+44H1Kloyv7JFfkJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C965A295E;
        Mon, 11 Jan 2021 16:54:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8838A295C;
        Mon, 11 Jan 2021 16:54:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/6] tests: remove support for GIT_TEST_GETTEXT_POISON
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
        <20210111144740.6092-3-avarab@gmail.com>
Date:   Mon, 11 Jan 2021 13:54:16 -0800
In-Reply-To: <20210111144740.6092-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 11 Jan 2021 15:47:36 +0100")
Message-ID: <xmqqa6tf6sxj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8CDC7786-5457-11EB-842B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/po/README b/po/README
> index 07595d369b..b9b6c9cb24 100644
> --- a/po/README
> +++ b/po/README
> @@ -284,23 +284,27 @@ Perl:
>  Testing marked strings
>  ----------------------
> =20
> +Git's tests are run under LANG=3DC LC_ALL=3DC. So the tests do not nee=
d be
> +changed to account for translations as they're added.

After we told readers this ...

> +Testing whether marked strings are used by plumbing
> ...
> +It's still possible to do a one-off test of where a string might be
> +used in the tests by simply replacing the "some hardcoded string" with
> +something like "POISON ME" locally and running the tests, before
> +finally converting it to _("some hardcoded string").

... I do not see how this manual check can still be effective.

People rely on our tests running under C locale, and will add tests
to grep for error messages meant for humans in C locale.  What does
it help to notice that a particular string you are contemplating to
translate _is_ being looked for in an existing test?  The author of
such a test knew it was meant for humans, but trusted our promise to
run tests in the C locale and used grep for it, in which case it is
a fair game to be marked with _().

I think we should honestly admit that after this change it is no
longer possible for our tests to help catching strings that are
mistakenly marked for translation when they are meant for machine
consumption, and justify why it is still OK to apply this change.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 999982fe4a..c7b1d857c4 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh

The changes to this file all look very attractive ;-)  Not having to
worry about poison test certainly makes it easier to write tests.

I just do not know if the price we are paying for the easier life is
too high.

Thanks.
