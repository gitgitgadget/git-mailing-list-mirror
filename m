Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595B1C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 18:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiAYSL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 13:11:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54671 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiAYSLS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 13:11:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A89017FCFB;
        Tue, 25 Jan 2022 13:11:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=emgfuPOLl2VzeeQMlJp0+sR47uNuaRAeMntZ7p
        HdhfA=; b=LqBVwb4XxCuNBezqx+pX/PwtVBRhIQEoNce+GvVJzwcOrtN9ZIDA4m
        KubI36uOcHODddejePLl4b+fv2ec6AubJa+k0r/WMoTWOs8mTwWVPrbUuWScY6Kg
        MBCghWQ79qbEglEQORVrhZk8ljvEd3SMzDIbXT4QmiAracbk4eSe4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2356817FCFA;
        Tue, 25 Jan 2022 13:11:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8196617FCF7;
        Tue, 25 Jan 2022 13:11:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5] compat: auto-detect if zlib has uncompress2()
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
        <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
        <xmqqr190ekrh.fsf@gitster.g>
        <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li>
        <xmqqtudu9s7k.fsf@gitster.g> <xmqqh79t7sj4.fsf_-_@gitster.g>
        <xmqqr18x3s5s.fsf@gitster.g>
        <220124.86r18xgcv4.gmgdl@evledraar.gmail.com>
        <xmqqlez43mx1.fsf@gitster.g>
        <CAPUEspheGc2kYkX-T8YUbW7z8v650L83===q29DWZrE823FktA@mail.gmail.com>
Date:   Tue, 25 Jan 2022 10:11:06 -0800
In-Reply-To: <CAPUEspheGc2kYkX-T8YUbW7z8v650L83===q29DWZrE823FktA@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 25 Jan 2022 02:11:10 -0800")
Message-ID: <xmqqtudrznwl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2ADC4E70-7E0A-11EC-BC8C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Mon, Jan 24, 2022 at 12:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> If the question is "name a compiler that breaks and is *still* in
>> active use", then the answer would be fuzzy (it depends on the
>> definition of "in active use"), but is useful to find out.
>
> `gcc -pedantic -werror` will abort the build (ISO C forbids an empty
> translation unit) because an empty translation unit is not
> syntactically correct code per ISO, as well as clang (ISO C requires a
> translation unit to contain at least one declaration
> [-Wempty-translation-unit]).

Ah, I remember that one, and it cleanly concludes the thread.
Thanks.

