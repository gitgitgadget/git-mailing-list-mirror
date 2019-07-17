Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCFCB1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 16:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGQQFu (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 12:05:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63695 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQQFu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 12:05:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1EE9B69FD5;
        Wed, 17 Jul 2019 12:05:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SdC5Tvqf0a1Gw0PUyBFmdm21SQA=; b=JCaCDD
        HZV+WWSHViD1VhAN+uZchPL5RHpEqkkY5xxhsNYjZKLHlVSeRPStqsdjOY8cxo1r
        ZZMwjd1gQVlkWEeLWw15KZFtRPeA/o0cHIpdcWU3C5aTW/emZzzpKzOItBbggSch
        jwYhRTjJi9lUW2k/pWhRRmO4h3mhhUSBOjNmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IM9LZAlSO+04So4/KT+6nRlrjSpUf6fQ
        KmXltTPYEvQGuG/YRGKvmtPufnaiQjLiVNZS+6d+p/BUanU7I4jOCpD5Xjz/5eRu
        qDEVytebrpc4bDM3kdjC+QuYH2IJ+srtD6K6ZHwSVc0Qb+3nR9MAPF+IG0zpaR6h
        sX3KXvzBMfI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1702369FD3;
        Wed, 17 Jul 2019 12:05:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4190969FD2;
        Wed, 17 Jul 2019 12:05:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>, Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC/PATCH] CodingGuidelines: spell out post-C89 rules
References: <20190702005340.66615-1-emilyshaffer@google.com>
        <20190709211043.48597-1-emilyshaffer@google.com>
        <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
        <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
        <xmqq4l3l520f.fsf_-_@gitster-ct.c.googlers.com>
        <CAGyf7-EWuW5NX27YPeSb9+5iMU0pftUs-WxvUH1NqpGeNsXESg@mail.gmail.com>
Date:   Wed, 17 Jul 2019 09:05:42 -0700
In-Reply-To: <CAGyf7-EWuW5NX27YPeSb9+5iMU0pftUs-WxvUH1NqpGeNsXESg@mail.gmail.com>
        (Bryan Turner's message of "Tue, 16 Jul 2019 18:09:06 -0700")
Message-ID: <xmqqr26o1wa1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB5DA1B4-A8AC-11E9-AD22-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

> On Tue, Jul 16, 2019 at 10:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Even though we have been sticking to C89, there are a few handy
>> features we borrow from more recent C language in our codebase after
>> trying them in weather balloons and saw that nobody screamed.
>>
>> Spell them out.
>>
>> While at it, extend the existing variable declaration rule a bit to
>> read better with the newly spelled out rule for the for loop.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/CodingGuidelines | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index 1169ff6c8e..53903b14c8 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -195,10 +195,24 @@ For C programs:
>>     by e.g. "echo DEVELOPER=1 >>config.mak".
>>
>>   - We try to support a wide range of C compilers to compile Git with,
>> -   including old ones. That means that you should not use C99
>> -   initializers, even if a lot of compilers grok it.
>> +   including old ones. That means that you should not use certain C99
>> +   features, even if your compiler groks it.  There are a few
>> +   exceptions:
>>
>> +   . since early 2012 with e1327023ea, we have been using an enum
>> +     definition whose last element is followed by a comma.
>
> Is there a significance to the leading . here versus a leading - below?

Absolutely.

    - Item 1's description

    - Item 2's description
      . subitem a of 2
      . subitem b of 2
      These two subitems are exceptions.

    - Item 3's description

was what I meant.

