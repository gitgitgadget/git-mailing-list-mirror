Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBFE41F462
	for <e@80x24.org>; Thu, 25 Jul 2019 16:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGYQom (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 12:44:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54318 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfGYQol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 12:44:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B92BC887EE;
        Thu, 25 Jul 2019 12:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=74P8S7OiT6fw+CQFCCpwMYoNgX8=; b=Y4L4+5
        7awjxH0tdak5CUEQTH3SesHGFYm4QzGsw2ac6DEnCcNevQ5BHgQCtW3pyZUeeeAC
        aQxmJX6+y7jr4gY3Ns882aohzNdCB5/JVyP64JNkdbfan1zBt4ukdKjXHBhS2kvo
        BiBbMnUeUf3kI1UY2xcJIXgXTNL8jCTQY7FHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yIBU9UNChkbiVYwucuw4N1C3b1s5qFot
        8slGXupO0e/ZHxqg12379L5WNLbfwwFEjjEvsTwBL+Y9z9Zy247zi+ohkAImN/UB
        v7XEocEpt8H4u3ebsCGF34EcMHJaC3LdohzL0ccCZoxijhe6WCtkimgsf7dqL0WM
        ZA8kaDv84yc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1C6D887ED;
        Thu, 25 Jul 2019 12:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D5B62887EA;
        Thu, 25 Jul 2019 12:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] t3422: mark two test cases as requiring support for `--preserve-merges`
References: <pull.296.git.gitgitgadget@gmail.com>
        <ed41e8d7abc93603063e9a99f628548608413d34.1564046191.git.gitgitgadget@gmail.com>
        <xmqq8ssmqe02.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 25 Jul 2019 09:44:34 -0700
In-Reply-To: <xmqq8ssmqe02.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 25 Jul 2019 09:23:57 -0700")
Message-ID: <xmqqpnlyoyh9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D037632-AEFB-11E9-A7B3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> We started marking all of those test cases that require `git rebase -p`
>> to work in the recent past, to allow for skipping them (because the
>> `--preserve-merges` backend is already deprecated and will be removed in
>> one of the next major versions, so it is a bit pointless to test its
>> functionality all the time).
>>
>> This patch marks two previously forgotten test cases with the `REBASE_P`
>> prerequisite, to allow skipping them via setting the environment
>> variable `GIT_TEST_SKIP_REBASE_P`.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  t/t3422-rebase-incompatible-options.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Thanks.

Wait.  What is the relationship between this one and the part that
touches the same path in db4a3f26 ("tests: mark a couple more test
cases as requiring `rebase -p`", 2019-05-28), which is reachable
even from 'maint'?



