Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041A4C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D240E61105
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhDHR4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:56:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62798 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhDHR4F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 13:56:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9898B241E;
        Thu,  8 Apr 2021 13:55:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TOwIQVMeq3Gh
        uT+fhEe/uglKzzA=; b=YcsDP043T9xTCtPAh43hmQDdG4+bMBR+llMrSTlIrV5V
        bbumy1KB7KiccUZaYUv9D2kgLoHrvchiGhHqiKdIVt8s0c1suB7FejMQcXOqcij/
        UOYgzNx13MruvkX3u0Iow7+Ik5UZKfE7xxR2x0YLXZr8B2Bb9B6BwPAHQ3irVSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=a09fT3
        OgHoY+TfMD4uDAFyK/mTqnSacBis2VH5VnsX4aRg71ZOrLyj9oD+49DUag6tjZDZ
        itsmcpO3fBB/VSnY32p3lWKxCP21tgSjfw8L9P/mD91d7P8/y52Zs2E5gCTmEuhX
        zrIqIisvhGbvB0Mpc1nQ6DeLEMhMlbFdKR29s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B211AB241D;
        Thu,  8 Apr 2021 13:55:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44AC2B241C;
        Thu,  8 Apr 2021 13:55:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] config.c: remove last remnant of
 GIT_TEST_GETTEXT_POISON
References: <patch-1.1-ea968affa8c-20210324T233254Z-avarab@gmail.com>
        <patch-1.1-2b2ac8471f-20210408T132357Z-avarab@gmail.com>
Date:   Thu, 08 Apr 2021 10:55:52 -0700
In-Reply-To: <patch-1.1-2b2ac8471f-20210408T132357Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 8 Apr
 2021 15:25:55 +0200")
Message-ID: <xmqqr1jku0d3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A94CEEFC-9893-11EB-8E63-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove a use of GIT_TEST_GETTEXT_POISON added in f276e2a4694 (config:
> improve error message for boolean config, 2021-02-11).

Thanks.  Will queue.

>
> This was simultaneously in-flight with my d162b25f956 (tests: remove
> support for GIT_TEST_GETTEXT_POISON, 2021-01-20) which removed the
> rest of the GIT_TEST_GETTEXT_POISON code.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> This trivial cleanup now without the objectionable and needless change
> to the tests.
>
> Range-diff:
> 1:  ea968affa8 ! 1:  2b2ac8471f config.c: remove last remnant of GIT_TE=
ST_GETTEXT_POISON
>     @@ config.c: int git_config_bool(const char *name, const char *valu=
e)
>       	return v;
>       }
>      =20
>     -
>     - ## t/t1300-config.sh ##
>     -@@ t/t1300-config.sh: test_expect_success 'invalid unit boolean' '
>     - 	git config commit.gpgsign "1true" &&
>     - 	test_cmp_config 1true commit.gpgsign &&
>     - 	test_must_fail git config --bool --get commit.gpgsign 2>actual &=
&
>     --	test_i18ngrep "bad boolean config value .1true. for .commit.gpgs=
ign." actual
>     -+	grep "bad boolean config value .1true. for .commit.gpgsign." act=
ual
>     - '
>     -=20
>     - test_expect_success 'line number is reported correctly' '
>
>  config.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/config.c b/config.c
> index 6428393a41..870d9534de 100644
> --- a/config.c
> +++ b/config.c
> @@ -1180,20 +1180,6 @@ static void die_bad_number(const char *name, con=
st char *value)
>  	}
>  }
> =20
> -NORETURN
> -static void die_bad_bool(const char *name, const char *value)
> -{
> -	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
> -		/*
> -		 * We explicitly *don't* use _() here since it would
> -		 * cause an infinite loop with _() needing to call
> -		 * use_gettext_poison().
> -		 */
> -		die("bad boolean config value '%s' for '%s'", value, name);
> -	else
> -		die(_("bad boolean config value '%s' for '%s'"), value, name);
> -}
> -
>  int git_config_int(const char *name, const char *value)
>  {
>  	int ret;
> @@ -1268,7 +1254,7 @@ int git_config_bool(const char *name, const char =
*value)
>  {
>  	int v =3D git_parse_maybe_bool(value);
>  	if (v < 0)
> -		die_bad_bool(name, value);
> +		die(_("bad boolean config value '%s' for '%s'"), value, name);
>  	return v;
>  }
