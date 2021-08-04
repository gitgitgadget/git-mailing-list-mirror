Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BE4C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A6160F35
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhHDRgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:36:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62854 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhHDRgu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 13:36:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08103E1716;
        Wed,  4 Aug 2021 13:36:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rMy7gG2V2lIl
        NipGcXG72vOYfX7oM8kIKGLghLoEX/4=; b=s6JMjjp04jgLv+pwSovSv4y5UL/2
        o6dLtGzP+zfudbYNo9WPBr8XY213Lio6N7b0v965X1NHUzl/iFmY4oBQJTqyAlZc
        TCfWCXcIqZeO+BKeCAZ7y/bWXf3u+86ttBv2y/qN7n5vLj/sQDO6eSUcpV+CDQed
        SZI83DrthMN3pdM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F36FCE1714;
        Wed,  4 Aug 2021 13:36:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A375E1713;
        Wed,  4 Aug 2021 13:36:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: --pickaxe-all typofix
References: <20210804122419.53968-1-bagasdotme@gmail.com>
        <87o8admdsv.fsf@evledraar.gmail.com>
Date:   Wed, 04 Aug 2021 10:36:35 -0700
In-Reply-To: <87o8admdsv.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 04 Aug 2021 17:26:10 +0200")
Message-ID: <xmqqh7g5p0ws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 846F1C5E-F54A-11EB-8732-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Aug 04 2021, Bagas Sanjaya wrote:
>
>> When I was fixing fuzzies as I updating po/id.po for 2.33.0 l10n round=
,
>> I noticed a triple-dash typo (--pickaxe-all) at diff.c, which accordin=
g
>> to git-diff(1) manpage, the correct option name should be --pickaxe-al=
l.
>>
>> Fix the typo.
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>  diff.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 82f88de755..a8113f1707 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4640,7 +4640,7 @@ void diff_setup_done(struct diff_options *option=
s)
>>  		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe=
-regex with -S"));
>> =20
>>  	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OB=
JFIND_MASK))
>> -		die(_("---pickaxe-all and --find-object are mutually exclusive, use=
 --pickaxe-all with -G and -S"));
>> +		die(_("--pickaxe-all and --find-object are mutually exclusive, use =
--pickaxe-all with -G and -S"));
>> =20
>>  	/*
>>  	 * Most of the time we can say "there are changes"
>>
>> base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
>
> Thanks, that's my typo from d26ec880096 (pickaxe: die when --find-objec=
t
> and --pickaxe-all are combined, 2021-04-12) and this fix looks good to
> me, sorry about that.

Thanks for a timely fix, as this is a mini-breakage we gained during
this cycle.
