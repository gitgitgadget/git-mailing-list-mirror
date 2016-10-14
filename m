Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4C21F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 18:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbcJNSkd (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 14:40:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63010 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752591AbcJNSkc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 14:40:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B41C044E99;
        Fri, 14 Oct 2016 14:40:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4I06YG4F2DWc
        bfbXSmmr40RhSPo=; b=JAxAaIYbjhcmIs0plOIN6ZXsPc35jej81dIRkFDpbn6N
        zGxtakp6w0SxjTfi0496bjpp/UmuKoL5vNh2YaUFL1bCh//XpDKoU1OGc3I2Jil9
        vVg81DdFG+Alwc+Pj2BChlRRapx1Y3Kf6tFixzF/aVqye+VVE0WbGv1E+8a+YOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TTVr9/
        WPxgDTl7s8YSj/PpyfALzwjspFae40IYTsKox/veDPO13itEelSrear0/j9BKhIT
        gxoPM+kBod4F3DaH9vcVs7m22aoFty9odT/W04Yh7lEV3qpuK7et9v+wFhO8lD75
        uK18GILMw3Dr/ToygKnJ64HbRqXsL1XIWGhq4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD33644E98;
        Fri, 14 Oct 2016 14:40:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3159044E96;
        Fri, 14 Oct 2016 14:40:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] gitweb: Link to 7-char+ SHA1s, not only 8-char+
References: <20161006091135.29590-1-avarab@gmail.com>
        <20161006091135.29590-3-avarab@gmail.com>
        <3fa9902f-3b01-5ec6-8129-34cff4c7cac9@gmail.com>
Date:   Fri, 14 Oct 2016 11:40:23 -0700
In-Reply-To: <3fa9902f-3b01-5ec6-8129-34cff4c7cac9@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 14 Oct 2016 19:45:12
 +0200")
Message-ID: <xmqq37jyzsdk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABAB30D4-923D-11E6-B3BA-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> s/SHA1/SHA-1/g in above paragraph (for correctness and consistency).
>>=20
>> I think it's fairly dubious to link to things matching [0-9a-fA-F]
>> here as opposed to just [0-9a-f], that dates back to the initial
>> version of gitweb from 161332a ("first working version",
>> 2005-08-07). Git will accept all-caps SHA1s, but didn't ever produce
>> them as far as I can tell.
>
> All right.  If we decide to be more strict in what we accept, we can
> do it in a separate commit.
>
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>
> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

Thanks for a review.  As the topic is not yet in 'next', I'll squish
in your Acked-by: to them.  I saw them only for 1 & 2/3; would
another for 3/3 be coming soon?

>
>> ---
>>  gitweb/gitweb.perl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index cba7405..92b5e91 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2036,7 +2036,7 @@ sub format_log_line_html {
>>  	my $line =3D shift;
>> =20
>>  	$line =3D esc_html($line, -nbsp=3D>1);
>> -	$line =3D~ s{\b([0-9a-fA-F]{8,40})\b}{
>> +	$line =3D~ s{\b([0-9a-fA-F]{7,40})\b}{
>
> By the way, it is quite long commit message for one character change.
> Not that it is a bad thing...
>
>>  		$cgi->a({-href =3D> href(action=3D>"object", hash=3D>$1),
>>  					-class =3D> "text"}, $1);
>>  	}eg;
>>=20
