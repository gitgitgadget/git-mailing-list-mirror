Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29A4C1F462
	for <e@80x24.org>; Wed, 29 May 2019 21:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfE2Vpg (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 17:45:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53683 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfE2Vpf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 17:45:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 742A976127;
        Wed, 29 May 2019 17:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cS6DBbmwRkj0
        YCWKjKISXWhm66Y=; b=Y4BCkuZE5dC7hZiIJdqWWzxnWsC4NUEmS9wRmpb1N2BM
        0Y1bHzrmCX6vxZhBn76TPhDzh+ntQVji7J1A4RiPDi8wAQmJw7WyrouoHDT0aeFX
        8Ggd8IBatl91x4XgLuKgXeE6GXlRoQzyneGCLkpIwbu/4rRNSzc0dsOTuvrxW+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rYBZa0
        q6IyhpUp1v+vm9xNTdgI30uCpco4zW0vugxIyYOPb6xrc2dFr2wtsx50iL28izLX
        mjflidyCNAMDdkcjHkdgdoqfa4slB3ZZ8MyvvJaKnhdjlbKBNnEKePqp8MBg25kO
        Ok/XyH4iP0UetVVUsl3hO6zIrhXVnchaqcZm4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CFD076126;
        Wed, 29 May 2019 17:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9DC776124;
        Wed, 29 May 2019 17:45:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] trace2: rename environment variables to GIT_TRACE2*
References: <20190510211502.GS14763@szeder.dev>
        <20190519144309.9597-1-szeder.dev@gmail.com>
        <87blzmmbd7.fsf@evledraar.gmail.com>
        <c93cb249-1618-e2ed-5ba3-31d716fdbe06@jeffhostetler.com>
Date:   Wed, 29 May 2019 14:45:30 -0700
In-Reply-To: <c93cb249-1618-e2ed-5ba3-31d716fdbe06@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 29 May 2019 15:58:32 -0400")
Message-ID: <xmqqk1e9x7d1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 15A771F4-825B-11E9-BD54-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 5/28/2019 7:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Sun, May 19 2019, SZEDER G=C3=A1bor wrote:
>> ...
>>> So let's rename all GIT_TR2* environment variables to GIT_TRACE2*,
>>> before they make their way into a stable release.
>>
>> Good to see this land in 2.22.0. I wonder if we shouldn't take this
>> further and rename trace2.* config to trace.*, and just re-use
>> GIT_TRACE=3D1 instead of having GIT_TRACE2 as well, and have a
>> GIT_TRACE_VERSION to switch between them.
>>
>> Then we could just switch in a future version. We've never promised wh=
at
>> the trace format was going to look like, and the existing one isn't
>> configurable (and we won't be making the v1 one...), so starting from
>> the outset with "2" in config is unfortunate.
>>
>> We'd still have special snowflakes like e.g. GIT_TRACE_PACKET.
>>
>> OTOH we can just do this after the release if it's deemed a good idea,
>> and just support trace2.* as aliases for trace.* for some amount of
>> time, same for the env vars.
>
> I'm open to considering such a change while we're at it.

I'm a bit against "while we're at it" part.  Let's take the
s/TR2/TRACE2/ change and stop at it for the upcoming release,
without spending too much time on over-engineering the stuff that
are primarily for developers.

Thanks.
