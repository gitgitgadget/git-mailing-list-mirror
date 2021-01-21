Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA27C433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DC8238D7
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbhAUDtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:49:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52815 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbhAUDMT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 22:12:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB651101723;
        Wed, 20 Jan 2021 22:11:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3pj9NwihlHNS
        Dhk6VRmRjMLS+R8=; b=YXG7qKoHUC2cF3InQJZUPlTiAtMVi2WNMELEXKNJhmzW
        pfHdtNrv+y5YbhF3Uo+qNLDOj9+putb5nzxe+J9Cr2vqGgen1HJ2sRXPQpnVJuJb
        8jl3INQ4JX7YYceQvhSDUFNqEUpEM+tCrCbwFNwunCOz94NF4oH6ZTLukEW5gUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ImdOyx
        U+kwMoIwSpmftx53Q7ckPOBtnfpiMmcTDYR8mcUGZPYeghBBUfrHqef76aOg5MrQ
        eD5eWdMaH51TpNOzHXnfqP8s0BMgXbD9M1CrRbwzUSA8grHFjMOywgAcsmFKEPx4
        atdTaO2hlZ58gjVBIdSOp8/I1jSqgJAPBcNa0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A54CA101722;
        Wed, 20 Jan 2021 22:11:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA837101721;
        Wed, 20 Jan 2021 22:11:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, David Greaves <david@dgreaves.com>,
        Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] fsck doc: remove ancient out-of-date diagnostics
References: <4269557C.1050606@dgreaves.com>
        <20210116171500.20092-1-avarab@gmail.com>
        <YAbtH5hSiRTwulGv@nand.local>
Date:   Wed, 20 Jan 2021 19:11:12 -0800
In-Reply-To: <YAbtH5hSiRTwulGv@nand.local> (Taylor Blau's message of "Tue, 19
        Jan 2021 09:30:55 -0500")
Message-ID: <xmqqwnw7c7cf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51C0F456-5B96-11EB-B81E-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Sat, Jan 16, 2021 at 06:15:00PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> Remove diagnostics that haven't been emitted by "fsck" or its
>> predecessors for around 15 years. This documentation was added in
>> c64b9b88605 (Reference documentation for the core git commands.,
>> 2005-05-05), but was out-of-date quickly after that.
>>
>> Notes on individual diagnostics:
>>
>>  - "expect dangling commits": Added in bcee6fd8e71 (Make 'fsck' able
>>    to[...], 2005-04-13), documented in c64b9b88605. Not emitted since
>>    1024932f019 (fsck-cache: walk the 'refs' directory[...],
>>    2005-05-18).
>>
>>  - "missing sha1 directory": Added in 20222118ae4 (Add first cut at
>>    "fsck-cache"[...], 2005-04-08), documented in c64b9b88605. Not
>>    emitted since 230f13225df (Create object subdirectories on demand,
>>    2005-10-08).
>
> Thanks for digging on both of these. I checked independently and came t=
o
> the same conclusion that you did, so I agree that these can be safely
> removed.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks,
> Taylor

Thanks, both.
