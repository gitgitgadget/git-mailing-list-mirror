Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DBC1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 17:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfFXRL7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 13:11:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60043 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbfFXRL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 13:11:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 015C115D650;
        Mon, 24 Jun 2019 13:11:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RucdywyiajJOugXnsp7amnLpKgo=; b=Pdk5jt
        Vrx/kuU+31htXNcsi5NoNN/ndn2aatMnRpjqaOkp6pw3fM7hxrdp7hoA/fNatfty
        L66WKqEpRrWstR2CKDtDMjW07jH5p+VNG/OJqqD7fYI7r4JUUaH61DlyKc0/u2cT
        1WAZKCb1Rm5Kc9JIDqFFPNYStWJjZxq8iB9yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k0Jbd4c5oQ9uSOh2g9dqxrXC3gdiSGBS
        4caj1+KP7sy9RF6hpM9pSrQjqutjznzL/mn2+dFY6BkbOflWIqITsg/9xVvz5IvH
        ijf7dbaIuVGkPZuV0/IBuLW0mvF91uZMIAZwWkiiDqHs8Rss+kC0BkC52pHCWQa7
        jIhs3m9d3XE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE20915D64F;
        Mon, 24 Jun 2019 13:11:56 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6369415D64E;
        Mon, 24 Jun 2019 13:11:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH] l10n: localizable upload progress messages
References: <20190621185051.77354-1-dimitriy.ryazantcev@gmail.com>
        <xmqq8stukarw.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BF0RHgrw9A_6zj8hQk7s15LvCZDz_P7rxgRvGfRhLJZg@mail.gmail.com>
Date:   Mon, 24 Jun 2019 10:11:55 -0700
In-Reply-To: <CACsJy8BF0RHgrw9A_6zj8hQk7s15LvCZDz_P7rxgRvGfRhLJZg@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 22 Jun 2019 10:10:21 +0700")
Message-ID: <xmqqef3ij4bo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B71A610-96A3-11E9-9628-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Hpmh, if it is OK to assume that in all human languages it is OK to
>> express the reate as <number> followed by translated "per second",
>> without allowing the order from getting changed, then ...
>
> Probably not (but I don't know any language that is not ok with this).
> I would just add strbuf_humanise_rate() that prints "GiB/s",
> "MiB/s"... Then we probably should print "bytes/second". This will
> print "bytes/s" which looks just weird.
>
>> >       if (bytes > 1 << 30) {
>> > -             strbuf_addf(buf, "%u.%2.2u GiB",
>> > +             strbuf_addf(buf, _("%u.%2.2u GiB"),
>> >                           (unsigned)(bytes >> 30),
>> >                           (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
>>
>> wouldn't it make more sense to split GiB, MiB, KiB and "bytes" units
>> out of these messages, and ask only these unit names, without the
>> %u.%2.2u number formats, to get translated by the localization team?
>
> That assumes all languages will print the unit after the number. I
> guess that is ok and it helps share code if we add
> strbuf_humanise_rate() above because only the unit part changes.

I think this is the direction I expected the discussion to go in.
It seems that the other subthread went the other way, though.
