Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2880120323
	for <e@80x24.org>; Thu, 23 Mar 2017 00:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbdCWAqR (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 20:46:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53516 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751350AbdCWAqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 20:46:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 040FD7E68D;
        Wed, 22 Mar 2017 20:46:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Xl0ROehdo4pD
        H2fB8sXoDh40dSk=; b=q4HTkZGWWDSSBTFvu34mfCvTPI2HeJmQiMaJKMqyn+As
        D/7QvSN/8QUSxxXExBUuiU32gOpSpQoBLb8Iw0t724VcYBlkeExMTqmUdxNQG+5f
        V15huUWdYBWVvOeZqqOBIkOkNlmGKyaoA1nvgJ/2vbgYKXCh65ph+XDYu/++y84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GXcnqs
        M2tBl+65MsfiL8B091zJEbTZXlDCM6tK5PnMidlRle6Ff9J/p2IZ+NsEAvIYxy3C
        J5CSiLxpZtHN4IGorXUirfXIawXFB5GdvwvMSAFK4wRgsjlTW4K9xTQR7SarMzeV
        5ugNg8TQerJeCyHC6onCf3QLARTj3JJ30TNyY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F088E7E68C;
        Wed, 22 Mar 2017 20:46:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 250077E689;
        Wed, 22 Mar 2017 20:46:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/16] tag: change misleading --list <pattern> documentation
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-11-avarab@gmail.com>
        <xmqqo9wupixz.fsf@gitster.mtv.corp.google.com>
        <CACBZZX70pb=h3nPKDY-rcM3rjh9SNYUzUhxA3Hu0-Jph8ODxdg@mail.gmail.com>
        <xmqq1stpj9xv.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4rofOquS4q0NDCb8cHOF=E7iPzFMxj3bre6CTB7=b_MA@mail.gmail.com>
        <xmqqtw6lgd82.fsf@gitster.mtv.corp.google.com>
        <20170322223600.huyel6j5wl644ddf@sigill.intra.peff.net>
        <CACBZZX7kJ_G8mAYd3mN5WtP0ZLUUOuWs4hu1fhTSspWuW_O=5A@mail.gmail.com>
Date:   Wed, 22 Mar 2017 17:46:11 -0700
In-Reply-To: <CACBZZX7kJ_G8mAYd3mN5WtP0ZLUUOuWs4hu1fhTSspWuW_O=5A@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 23 Mar
 2017 00:43:20
        +0100")
Message-ID: <xmqqd1d8hlbg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D624B80-0F62-11E7-B356-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Junio would you be fine with just this on top:
>
> diff --git a/t/README b/t/README
> index 4982d1c521..9e079a360a 100644
> --- a/t/README
> +++ b/t/README
> @@ -379,2 +379,5 @@ Do:
>
> + - Include tests which assert that the desired & recommended behavior
> +   of commands is preserved.
> +
>   - Put all code inside test_expect_success and other assertions.
> @@ -424,2 +427,17 @@ Don't:
>
> + - Include tests which exhaustively test for various edge cases or
> +   unintended emergent behavior which we're not interested in
> +   supporting in the future.
> +
> +   An exception to this is are cases where we don't care about
> +   different behaviors X and Y, but we need to check that it does one
> +   of them, and not Z.
> +
> +   Another exception are cases where our documentation might
> +   unintentionally stated or implied that something was supported or
> +   recommended, but we'd like to discourage its use going forward.
> +
> +   In both of the above cases please prominently comment the test
> +   indicating that you're testing for one of these two cases.
> +
>   - exit() within a <script> part.

This would probably be part of your other three-patch series for
t/README?  With a quick read-through I spotted nothing questionable,
but I am not 100% sure about the value of going into that level of
details, especially with the latter one about "discourage and wean
off of".

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 0a7ebf5358..35402ad9a0 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -350,2 +350,6 @@ test_expect_success 'tag -l can accept multiple pat=
terns' '
>
> +# Between around v1.7.6.1 & v2.13.0 the documentation unintentionally
> +# implied that --list was what took the <pattern>, not that patterns
> +# should be clustered at the very end. This test should not imply that
> +# this is a sane thing to support.
>  test_expect_success 'tag -l can accept multiple patterns interleaved
> with -l or --list options' '
>
> Or do you think the "long documented but unintentional" argument isn't
> worth a test, in which case squash this:

Oh, I didn't know I was given two choices and the second one does
address the "I am not 100% sure" above ;-).

> diff --git a/t/README b/t/README
> index 9e079a360a..9f85b8d1cd 100644
> --- a/t/README
> +++ b/t/README
> @@ -433,12 +433,8 @@ Don't:
>     different behaviors X and Y, but we need to check that it does one
>     of them, and not Z.
>
> -   Another exception are cases where our documentation might
> -   unintentionally stated or implied that something was supported or
> -   recommended, but we'd like to discourage its use going forward.
> -
> -   In both of the above cases please prominently comment the test
> -   indicating that you're testing for one of these two cases.
> +   In that case please prominently comment the test indicating that
> +   you're testing for one of these two cases.
>
>   - exit() within a <script> part.

So for the doc part, I can go with either, but prefer the latter
between the two.

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 35402ad9a0..83772f6003 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -348,19 +348,6 @@ test_expect_success 'tag -l can accept multiple pa=
tterns' '
>         test_cmp expect actual
>  '
>
> -# Between around v1.7.6.1 & v2.13.0 the documentation unintentionally
> -# implied that --list was what took the <pattern>, not that patterns
> -# should be clustered at the very end. This test should not imply that
> -# this is a sane thing to support.
> -test_expect_success 'tag -l can accept multiple patterns interleaved
> with -l or --list options' '
> -       git tag -l "v1*" "v0*" >actual &&
> -       test_cmp expect actual &&

I'd actually think "multiple patterns" should be kept, as that is
really what we want to support forever. =20

Acceptance of multiple and redundant "--list", e.g.

	git tag -l --list "v1*" "v0*" >actual &&
	test_cmp expect actual &&

immediately after the above may also be something worth protecting,
but that is how OPT_CMDMODE works in general, so it may not be
necessary to test it specifically in a test for "tag -l".

Acceptance of multiple and redundant "--list" that are given after a
<pattern> is already given on the command line is not something we
want to actively deprecate (it is not worth our time or effort) but
it is not something we want to encourage, either.  So I have a
preference for dropping the ones below.

> -       git tag -l "v1*" --list "v0*" >actual &&
> -       test_cmp expect actual &&
> -       git tag -l "v1*" "v0*" -l --list >actual &&
> -       test_cmp expect actual
> -'
> -
>  test_expect_success 'listing tags in column' '
>         COLUMNS=3D40 git tag -l --column=3Drow >actual &&
>         cat >expected <<\EOF &&
