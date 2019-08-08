Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4488A1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 19:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390275AbfHHTDx (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 15:03:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57798 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390203AbfHHTDx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 15:03:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1EEC66F634;
        Thu,  8 Aug 2019 15:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KpLOUdMDLM3q239onf3Gb9YGQaI=; b=eUNRlt
        +gRwmG3FmNVLdqsWrOx/OFO3qNfwxNNC+KXY2E+p+HqhPpakkuWND5lvxr3c9Y0g
        /VixW88P1D5yYOg3soiy9Aub3fILLqUH/0qbRlolckVtO1T9NFirab4Ts/W0udTL
        v8YpBcUucnZY4WSo2mT6zJ7bCwAzHBLrY6Zks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z8foFF+K/MQ9v+U070v/IbSKfmyERjml
        5AqJGYUSKTwkzAdo1F/ethwJ6FZ8u+QYPYh0Ur/6RhTZVWJNr5pT9V7uxIwk6DIZ
        yAohX33lgFNkNaP6ULD7phnRvHqwH2JQqTzFpZeYkBPFU0tMGrF6YWfjAmbuBUqq
        OxrK6ASjXU0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 156396F633;
        Thu,  8 Aug 2019 15:03:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 113DF6F632;
        Thu,  8 Aug 2019 15:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: What's cooking in git.git (Aug 2019, #03; Tue, 6)
References: <xmqqv9vahs6p.fsf@gitster-ct.c.googlers.com>
        <20190808182242.GA96790@comcast.net>
Date:   Thu, 08 Aug 2019 12:03:45 -0700
In-Reply-To: <20190808182242.GA96790@comcast.net> (Matthew DeVore's message of
        "Thu, 8 Aug 2019 11:22:42 -0700")
Message-ID: <xmqq8ss3fpim.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 407F5C98-BA0F-11E9-84CF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

> On Tue, Aug 06, 2019 at 02:58:38PM -0700, Junio C Hamano wrote:
>> 
>> * md/list-objects-filter-combo (2019-06-28) 10 commits
>>  - list-objects-filter-options: make parser void
>>  - list-objects-filter-options: clean up use of ALLOC_GROW
>>  - list-objects-filter-options: allow mult. --filter
>>  - strbuf: give URL-encoding API a char predicate fn
>>  - list-objects-filter-options: make filter_spec a string_list
>>  - list-objects-filter-options: move error check up
>>  - list-objects-filter: implement composite filters
>>  - list-objects-filter-options: always supply *errbuf
>>  - list-objects-filter: put omits set in filter struct
>>  - list-objects-filter: encapsulate filter components
>> 
>>  The list-objects-filter API (used to create a sparse/lazy clone)
>>  learned to take a combined filter specification.
>> 
>>  Will merge to 'next'.
>> 
>
> This has been the status for a while, and I don't see it on "next."

I doubt it will be during -rc freeze period, before the final week
of the upcoming release.  

> I notice Johannes wanted a fix for incorrect strbuf usage to fix a linter check
> - (just saw his earlier message now) is that the cause of the delay?

That may be some of it.  When we approach -rc (that was a few weeks
ago), any large change not ready for 'next' would get backburnered
to allow higher priority "oops, that one is already in or just about
to go in 'master', but it needs this fixup before the final" topics
to graduate sooner.

Thanks.
