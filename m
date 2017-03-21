Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AD712095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932811AbdCUSiR (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:38:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65003 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758176AbdCUSiP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:38:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 258706ECEC;
        Tue, 21 Mar 2017 14:32:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UuWUw1H1Zl+K
        Q9FU/bMqVXhkfQg=; b=V/W2vF2nM20y7PuNVqI9LgDqaJZI+v7dLzZ+KPn13kn3
        /X4NHEFS+PWGZsYrpBkaooIj46jhqut19WkTPmSCPs5aIt4DW1FelftVpdUBeBbM
        JOh+6Vwqo4Qz7cwJ3aI8D52eHYzoryOTGajhxLAZ+Nqen0E89pfI4eo1wyMHvpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eFYj2I
        DXmsxSEzxA0aQpEV1ke3iVsSljOZFb8T+PSkO/4IO4ZUn/d3Yx8EHXJqctcknwue
        xl8URhWRZNQoblnr6amXSe4FXKJaF+wfm6M6ClqsrhAyom0bCqRJG/wUE4RMykdu
        L/WV7HTCkltLlGPVGyd4yZBn6bffhPb70hHFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D7CE6ECEB;
        Tue, 21 Mar 2017 14:32:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 706FE6ECEA;
        Tue, 21 Mar 2017 14:32:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 09/16] tag: add more incompatibles mode tests
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-10-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:32:57 -0700
In-Reply-To: <20170321125901.10652-10-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:54 +0000")
Message-ID: <xmqqshm6pjja.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEB21C20-0E64-11E7-BCA4-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Amend the test suite to test for more invalid uses like "-l -a"
> etc. This mainly tests the `(argc =3D=3D 0 && !cmdmode)` ->
> `((create_tag_object || force) && (cmdmode !=3D 0))` code path in
> builtin/tag.c.

The second sentence is now stale, isn't it?

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t7004-tag.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 63ee2cf727..958c77ab86 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1455,6 +1455,19 @@ test_expect_success 'checking that initial commi=
t is in all tags' "
> =20
>  test_expect_success 'mixing incompatibles modes and options is forbidd=
en' '
>  	test_must_fail git tag -a &&
> +	test_must_fail git tag -a -l &&
> +	test_must_fail git tag -s &&
> +	test_must_fail git tag -s -l &&
> +	test_must_fail git tag -m &&
> +	test_must_fail git tag -m -l &&
> +	test_must_fail git tag -m "hlagh" &&
> +	test_must_fail git tag -m "hlagh" -l &&
> +	test_must_fail git tag -F &&
> +	test_must_fail git tag -F -l &&
> +	test_must_fail git tag -f &&
> +	test_must_fail git tag -f -l &&
> +	test_must_fail git tag -a -s -m -F &&
> +	test_must_fail git tag -a -s -m -F -l &&
>  	test_must_fail git tag -l -v &&
>  	test_must_fail git tag -n 100 &&
>  	test_must_fail git tag -l -m msg &&
