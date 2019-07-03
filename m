Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247141F461
	for <e@80x24.org>; Wed,  3 Jul 2019 18:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfGCStt (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 14:49:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53847 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCStt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 14:49:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED4B87B36C;
        Wed,  3 Jul 2019 14:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wPrDXHQiMi1OQbuVe3JaK/FglMI=; b=D4QSbv
        6qktvyHAv3Hcb8kX2kiAM/JjYkzy/K+ccHZX6QCZ1pR1scjsNKds2VOE5eaMqmJ2
        jBEhk/IfbbTbZBIOC58aE3YLOnzh/UAyCX00rFD6aR6lgVKLf3XCGwb0KjVSnueF
        uW5NyT08ln+u1cvRf+KuBN7Yl8xT/iOvKEYJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tFc+qsDvSkUbYszgTub9ne9obILGhZv2
        cS7SvQFUSy7ZSqqSi9+cCfTwVe1iqLW9qWcVXJpmeQPMcXk9SX3WemGzxwCddiBV
        LUFyEtBu05vzvjZ15dl3tY3q6z+8sCsjEUpVQxFAfufpug4ZT0iISd7jNGWcUb2E
        PUNWa0pLzRw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E78227B36B;
        Wed,  3 Jul 2019 14:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 506907B36A;
        Wed,  3 Jul 2019 14:49:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] a few more redundant system include cleanups
References: <20190618064537.62369-1-carenas@gmail.com>
        <20190618155326.GA4014@sigill.intra.peff.net>
        <CAPUEspgRnGd4nT3yd2YTGMt8t4qQ=V3GGNeTih3cmjnZHNextw@mail.gmail.com>
        <20190619174841.GB27834@sigill.intra.peff.net>
Date:   Wed, 03 Jul 2019 11:49:42 -0700
In-Reply-To: <20190619174841.GB27834@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 19 Jun 2019 13:48:41 -0400")
Message-ID: <xmqqtvc3ymux.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52B74654-9DC3-11E9-B11D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jun 19, 2019 at 02:12:30AM -0700, Carlo Arenas wrote:
>
>> > I did a quick grep for similar cases, and didn't find any that I think
>> > would be problematic. There were a few cleanups, below.
>> 
>> would you mind if I add your 2 patches to a series and include that
>> missing one?, that way I'll also have a chance to write a better commit
>> message from my original change, including the other feedback I got
>> as well
>
> That's be fine with me. Thanks.
>
>> PS. is there a recommendation on how to version a patch that move
>> into a series that would be preferred?
>
> I think you can just say "v2" on the whole thing, include all three
> patches, and then write a note that the series supersedes what I sent.

Carlo, no need to rush, but has this happened already?  I do not
recall seeing an update, and I am wondering if I missed one.

Thanks.




