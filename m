Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5735B1F461
	for <e@80x24.org>; Mon,  8 Jul 2019 17:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfGHRlI (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 13:41:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57616 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfGHRlI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 13:41:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC13D69FAE;
        Mon,  8 Jul 2019 13:41:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8psBwByat4SQeUtBJAp8zk2/uUw=; b=W9A4we
        NNLcDa+as8s0dekBqAP7hgAaN7EnxvK/iJ/p18BpofKOc67F21oSyCZUdFzcXf68
        yAA5k/pS2ht13J0LXlC1iWxsOhl1ectujFzyWpzHa5sfsYxPXzwDr/ebMT5B7jFQ
        glAWyt7OPn/HH3I+JPPq2rKkCmDsSkGSc4ZCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WqblOQgGNrJnPhPmMcD6MbsGGniy5Eww
        0h3qf4VkClPaDv8TnWAo24/FM1CInrsjwbFe5rf/dINZlwiKPVqSbTivkyf1n99B
        mKi/MBgTfaPj7kWrRtQq8cWdgU2qpfFSuQR4/RlmuZzcQsh/f6sk3KJkTfWLcxAj
        uGy0bW6ffp4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3F4769FAD;
        Mon,  8 Jul 2019 13:41:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05F5869FA8;
        Mon,  8 Jul 2019 13:41:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Janos Farkas <chexum@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] repack: warn if bitmaps are explicitly enabled with keep files
References: <875zow8i85.fsf@evledraar.gmail.com>
        <20190623180226.GA1100@sigill.intra.peff.net>
        <20190623180825.3ospajjgat3clwiu@dcvr>
        <20190623224244.GB1100@sigill.intra.peff.net>
        <20190628070211.hfweqcons6c6gy52@dcvr>
        <87zhm26uq9.fsf@evledraar.gmail.com>
        <20190629191600.nipp2ut37xd3mx56@dcvr>
        <xmqq7e917h9x.fsf@gitster-ct.c.googlers.com>
        <20190703173814.GA29348@sigill.intra.peff.net>
        <xmqqftnn0z1t.fsf@gitster-ct.c.googlers.com>
        <20190703212316.GB32035@sigill.intra.peff.net>
Date:   Mon, 08 Jul 2019 10:40:58 -0700
In-Reply-To: <20190703212316.GB32035@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 3 Jul 2019 17:23:16 -0400")
Message-ID: <xmqqlfx8zaol.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D19BA24-A1A7-11E9-84AE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 03, 2019 at 11:10:22AM -0700, Junio C Hamano wrote:
>
>> > Or perhaps we could differentiate our temporary locks from "real" .keep
>> > files by looking at the content; I think our locks always say something
>> > like "(receive|receive)-pack \d+ on .*", and it wouldn't be too onerous
>> > to commit to that, I think (or even adjust it to something even more
>> > unambiguous).
>> 
>> True, but it may be overkill to open and read.
>
> Yeah, that cross my mind as well, but:
>
>   1. We'd only need to open them when we _see_ them. And they're pretty
>      rare anyway.
>
>   2. Effort-wise, we're already opening and mmap-ing the .idx files, so
>      this is on par.
>
>   3. Most callers don't care about keep-files anyway. We could turn
>      packed_git.pack_keep into:
>
>        enum {
>          PACK_KEEP_NONE,
>          PACK_KEEP_LOCK,
> 	 PACK_KEEP_USER
>        } check_packed_keep(struct packed_git *pack);
>
>      and then most programs wouldn't pay anything.
>
> Just some thoughts. I don't have immediate plans to work on it, but
> maybe somebody else is excited about it. :)

OK.  I do agree that .keep would be rare enough to justify spending
a bit more extra cycles, as long as the benefit is big enough (and
in this case it may be a good trade-off).
