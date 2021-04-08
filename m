Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BB4C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 18:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B06961108
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 18:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhDHSWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 14:22:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50819 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbhDHSWN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 14:22:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 006AAB2771;
        Thu,  8 Apr 2021 14:22:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+OsIknUJIZ//
        lZosSjyPuUi24GY=; b=uZ3uqd+9uH5CmPvMzG2r2hmBoIbfBRz+n22GCwI2CDnI
        0Cyxaibnbw5sM6V1MN/8LCrg1mAw32QULNyWfe7Z+INp9iRxwe1iDi4XOyumld+U
        CTWSd0hPeRwqGBza/YHdU4E0G3WuFZN3Untm8AJol3BFbsVmQfpsLWh/SfTj734=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FEMal5
        D0CCxyR3odhzD6f8RFo5+hJTx2Y0V5s5oaZj/zb+FZkwZI23V1F7pjYWS8QNQjD0
        3RXfpPaeSK0FjfSL3bm3C3aZJcxB5g92kv/IHZasAtgUbu25RL3JiYQw0vImmHjI
        tDHJV7nAMQE6puvROdwYEtkbjfgKyEY2UWnBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9DC3B2770;
        Thu,  8 Apr 2021 14:22:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17FCBB276F;
        Thu,  8 Apr 2021 14:22:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/5] config tests: test for --bool-or-str
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
        <patch-2.6-2f6c2de050-20210408T133125Z-avarab@gmail.com>
Date:   Thu, 08 Apr 2021 11:21:59 -0700
In-Reply-To: <patch-2.6-2f6c2de050-20210408T133125Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 8 Apr
 2021 15:34:26 +0200")
Message-ID: <xmqqim4wtz5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F334CAA-9897-11EB-BEA6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add the missing tests for the --bool-or-str code added in
> dbd8c09bfe (mergetool: allow auto-merge for meld to follow the
> vim-diff behavior, 2020-05-07).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t1300-config.sh | 72 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e0dd5d65ce..a002ec5644 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -802,6 +802,78 @@ test_expect_success 'get --bool-or-int' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'get --bool-or-str' '
> +	cat >.git/config <<-\EOF &&
> +	[bool]
> +	true1
> +	true2 =3D true
> +	true3 =3D TRUE
> +	true4 =3D yes
> +	true5 =3D YES
> +	true6 =3D on
> +	true7 =3D ON
> +	false1 =3D
> +	false2 =3D false
> +	false3 =3D FALSE
> +	false4 =3D no
> +	false5 =3D NO
> +	false6 =3D off
> +	false7 =3D OFF
> +	[int]
> +	int1 =3D 0
> +	int2 =3D 1
> +	int3 =3D -1
> +	[string]
> +	string1 =3D hello
> +	string2 =3D there you
> +	EOF

That's fairly complete set (but misses common permutations like
"Yes").  I am not sure, if we try "true" and "TRUE", if it is worth
to check yes/YES and others, but at the same time, I do not know if
reducing the permutations tested would improve the readability,
runtime and/or maintainability of the test.

> +	cat >expect <<-\EOF &&
> +	true
> +	true
> +	true
> +	true
> +	true
> +	true
> +	true
> +	false
> +	false
> +	false
> +	false
> +	false
> +	false
> +	false
> +	false
> +	false
> +	true
> +	true
> +	hello
> +	there you
> +	EOF

The "right answer" is hard to read and maintain.  Can we immediately
spot what happened to int.int3 in this output, for example?

Perhaps with something like

	inspect_config () {
		name=3D$1
		shift
		printf "%s %s\n" $(git config "$@" "$name") "$name"
	}

we can make these lines to say

	int.int1 false
	int.int2 true
	int.int3 true
	string.string1 hello
	string.string2 there you

to make them easier to follow?  Without such a hint, I would expect
that a failure output from test_cmp at the end would be very hard to
grok, especially with so many permutations tested that produces runs
of "true" and "false".

> +	{
> +		git config --type=3Dbool-or-str bool.true1 &&
> +		git config --bool-or-str bool.true2 &&

This is a bit curious.  We do not do full permutation between
--type=3Dbool-or-str and --bool-or-str here.  We just check both
would work only once.  Feels a bit inconsistent.

My gut-feeling vote is to just try true/TRUE for case insensitivity
and try all the other variants in lowercase, but I can go with the
full permutation if you strongly prefer it.

> ...
> +		git config --bool-or-str int.int1 &&
> +		git config --bool-or-str int.int2 &&
> +		git config --bool-or-str int.int3 &&
> +		git config --bool-or-str string.string1 &&
> +		git config --bool-or-str string.string2
> +	} >actual &&
> +	test_cmp expect actual
> +'

Thanks.
