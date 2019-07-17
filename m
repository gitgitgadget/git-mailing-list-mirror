Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2681F461
	for <e@80x24.org>; Wed, 17 Jul 2019 16:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfGQQfz (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 12:35:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55655 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfGQQfz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 12:35:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF6411515DD;
        Wed, 17 Jul 2019 12:35:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nYl5V63zOBO3mK+6xL1OqUzdSck=; b=WSbX4H
        zG/Lmb1iqDlZShZR2dKr8FR4N4Yzt94VdjoiZkHo2IAVVD7y9/VOl68isSGkTq/M
        QLBtYkoVzcFrUv32dGpqLukwNLZnACSotSvd9a4Su1m7YVNdi+sy9U8cgB7onTxh
        MOPE4w5zTJTMBL3ye1NFuE0Mk6skblRR/jh2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YyXaJlL8DML4c0QXgfCukpmKP17ktBO1
        t1lL+dzJj2W0nDwLqFc5SPaZICVMAgpIxGjkJ19oNHXb8HuafTe2H++BwHMZF2g3
        w11NHxTDcj2yVI2rbJcz7qQ24V5++fquRHVU2cKLGc5XOp/g6gt1u/W5gurpbw7c
        YjDmTie4300=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7DD01515DC;
        Wed, 17 Jul 2019 12:35:50 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F4921515DB;
        Wed, 17 Jul 2019 12:35:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Matthew DeVore <matvore@comcast.net>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2019, #03; Fri, 12)
References: <xmqq8st3otj7.fsf@gitster-ct.c.googlers.com>
        <20190714231558.GA24609@comcast.net>
        <CAP8UFD17pUNrDMQF1vRqaJiyhCn1Y+FkaTzp2V-sruW6nxzq5A@mail.gmail.com>
Date:   Wed, 17 Jul 2019 09:35:49 -0700
In-Reply-To: <CAP8UFD17pUNrDMQF1vRqaJiyhCn1Y+FkaTzp2V-sruW6nxzq5A@mail.gmail.com>
        (Christian Couder's message of "Wed, 17 Jul 2019 09:02:26 +0200")
Message-ID: <xmqqims01uvu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFBDC0E8-A8B0-11E9-A8E8-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jul 15, 2019 at 1:16 AM Matthew DeVore <matvore@comcast.net> wrote:
>>
>> On Fri, Jul 12, 2019 at 02:02:52PM -0700, Junio C Hamano wrote:
>> > * md/list-objects-filter-combo (2019-06-28) 10 commits
>> >  - list-objects-filter-options: make parser void
>> >  - list-objects-filter-options: clean up use of ALLOC_GROW
>> >  - list-objects-filter-options: allow mult. --filter
>> >  - strbuf: give URL-encoding API a char predicate fn
>> >  - list-objects-filter-options: make filter_spec a string_list
>> >  - list-objects-filter-options: move error check up
>> >  - list-objects-filter: implement composite filters
>> >  - list-objects-filter-options: always supply *errbuf
>> >  - list-objects-filter: put omits set in filter struct
>> >  - list-objects-filter: encapsulate filter components
>> >
>> >  The list-objects-filter API (used to create a sparse/lazy clone)
>> >  learned to take a combined filter specification.
>> >
>> >  There is a bit of interaction with cc/multi-promisor topic, whose
>> >  conflict resolution I have no confidence in X-<.  Extra sets of
>> >  eyes are appreciated.
>>
>> Sorry for the delay. I was on vacation and then catching up for a week after I
>> got back. I uploaded a merged commit here:
>>
>> https://github.com/matvore/git/tree/filts
>>
>> And the merged file itself (only this one had conflicts) is here:
>>
>> https://github.com/matvore/git/blob/filts/list-objects-filter.c
>
> The merge and the explanations behind it all look good to me.
>
> Thanks for your work on this!
> Christian.

Thanks, both.
