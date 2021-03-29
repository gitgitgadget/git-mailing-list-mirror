Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B3C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E5A6192F
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhC2Voa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:44:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65167 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhC2VoM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:44:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B98CB8B44;
        Mon, 29 Mar 2021 17:44:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=olLCOMRCN/xAOW0zlbFMRiZlbHo=; b=Oc3T5a
        A84vPtvnn5GllQRTx0JuOFTKa+F/tFdlUeOauehqE66r/E/UiYydDI0tVk/s5cwA
        xN5vwRLpxp3OuH0Kkpvwz7aF7qhVKObiDKwc3aVVHbm4HoIJ2AaKSnboatX1im4j
        35cXX3wAdoY42ar5PztuiqVV/cBabrME9tKC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ik1I4Y3E/Blfziin7Youh0d6otHExT28
        cwtSPGBAPsMofE2VH5DtTMGoII7w/oEKyYaIXccYRpKxGBYGRu0O9iV4llGXie0b
        fT6pqooBDKxJbAuERJzYbMjsidXXbyDqtMO/KQvhac7fEfX0Om32D5QmPZhkqpwx
        LFzu93amYNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4052BB8B43;
        Mon, 29 Mar 2021 17:44:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C30F8B8B42;
        Mon, 29 Mar 2021 17:44:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with --table
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
        <87r1k5pcmx.fsf@evledraar.gmail.com>
        <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
        <874kgzq4qi.fsf@evledraar.gmail.com>
        <CABPp-BGRwxn73sntpX8Q5aD-O192RZmOOy_jiU3SQp4-erivtg@mail.gmail.com>
        <87eeg0ng78.fsf@evledraar.gmail.com>
        <b1eee802-f20c-5381-366c-729755bfac8a@gmail.com>
Date:   Mon, 29 Mar 2021 14:44:10 -0700
In-Reply-To: <b1eee802-f20c-5381-366c-729755bfac8a@gmail.com> (Derrick
        Stolee's message of "Mon, 29 Mar 2021 15:46:32 -0400")
Message-ID: <xmqq5z19iqj9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E587BD2A-90D7-11EB-96D0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I think changing 'ls-files' before the sparse index has stabilized is
> premature. I said that a series like the RFC you sent would be
> appropriate after this concept is more stable. I do _not_ recommend
> trying to juggle it on top of the work while the patches are in flight.

I do not have a problem with either of approaches to help debugging
(i.e. extending "ls-files --debug" or a new test helper), but I am
curious to be reminded what the plan for "git ls-files [-s]" output
is, when run in a repository in which sparse cone checkout is used.

Do we see trees and paths outside the cone omitted, or does the act
of running "ls-files" dehydrate the trees into their constituent
blobs?

Thanks.
