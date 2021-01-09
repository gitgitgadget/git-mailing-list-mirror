Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A668C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 21:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57265225AC
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 21:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhAIV3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 16:29:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58141 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbhAIV3p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 16:29:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8930B10F7A5;
        Sat,  9 Jan 2021 16:29:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jABZJGWSCdVU
        tkrxpsQJERiE16U=; b=T3serdmLfdUCq9bhp5/XaltcMkA0HaqvYRzfSSWvoVg0
        3Dts9btQzler0zxZP3yG+2OilMV7NgW12Lw76j2c/Pp/x8q9tLC6G0jGgUs2YjFe
        HaRGKFeWtlEvFty8XzvBB/6Ih6T9QG8SgBRMdfLR9ijraMaLqSyeZNqjj+T8kGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dKe4Lv
        c2kW8fUkxos9/2NGP6zJjbJFEomP2G0QepAgOqxPUPuEFFGoweiTbrbS5llmPor3
        wiVhRnaq3llMSyYBZT0HttHpdwgJ56QSZ+mhwUHzKKJKWFoK4JhlTef7VVV99ZbP
        n6tQxExjHETWVC2IYRb6tBUnH8zjM6GUo7p1c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8196910F7A4;
        Sat,  9 Jan 2021 16:29:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED32D10F79F;
        Sat,  9 Jan 2021 16:29:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <871reu752k.fsf@evledraar.gmail.com>
Date:   Sat, 09 Jan 2021 13:28:58 -0800
In-Reply-To: <871reu752k.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 09 Jan 2021 11:55:15 +0100")
Message-ID: <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0989692-52C1-11EB-B5DB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/trailers-extra-format (2020-12-09) 5 commits
>>  ...
>>
>>  The "--format=3D%(trailers)" mechanism gets enhanced to make it
>>  easier to design output for machine consumption.
>
> Thanks! Am refactoring some out-of-tree code to take advantage of this
> :)

Thank you for interesting additions.

> I forgot that, oops. Is just declaring here that all of that's:
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>
> Since you have some acks etc. squashed into it at this point...

Puzzlled.  The patches on the trailers topic were all signed-off by
you, unless I was careless when I checked before merging them to
'next'.

Do the above three lines refer to a different topic, on CoC 2.0?


>> * bc/hashed-mailmap (2020-12-12) 1 commit
>>  - mailmap: support hashed entries in mailmaps
>>
>>  The mailmap database learned to take hashed value as the original
>>  side of mapping.
>>
>>  Expecting a reroll.
>
> FWIW there was since a re-roll on 2021-01-03, but the discussion is
> sort-of outstanding, so maybe that's intentional...

I had an impression that those 4 or 5 patches haven't gained
concensus that they are good as-is.

Thanks.
