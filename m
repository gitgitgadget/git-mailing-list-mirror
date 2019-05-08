Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4C51F45F
	for <e@80x24.org>; Wed,  8 May 2019 01:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEHB7d (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 21:59:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56419 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEHB7d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 21:59:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93C48146780;
        Tue,  7 May 2019 21:59:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ohdqyv1Wguel64gwT+04+cEBKvg=; b=vOKtZl
        wRG+OLNcVi2cmeNsCeNnHaQUVWikG0ir8kC8Pw3T0dgyjrznCiAu9bcLHnK8fHff
        OYm8iZGHKIb6/ViuWcSdqyY1XFHOzsHRbM6/2RNGsD1o6XTt012vpe/ZFBSXLqnS
        KtZhU7gloIY/pzCpXlCp1K+A7DgRl3661zlCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ejxxLgjiEXMpZHuPuJzhndEagAVersDF
        PMxxSxN5FUefuKGHOPk4tF5g07HQH9VM5TGHFBKutgy+Us37VHm3dzQKp4vriKfQ
        MQOMZKpXRa9G9zkMQ50Ob2Ugbd2xMd+pno34QvpNZSoDYEgsvtdnF49zaCGhwlfk
        d8iC5A+guU0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 888AD14677F;
        Tue,  7 May 2019 21:59:32 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2D8F14677E;
        Tue,  7 May 2019 21:59:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/6] perf-lib.sh: fix 0baf78e7bc regression, refactor & fix bugs
References: <20190506232309.28538-1-avarab@gmail.com>
        <20190507105434.9600-1-avarab@gmail.com>
        <20190507213612.GB19955@sigill.intra.peff.net>
Date:   Wed, 08 May 2019 10:59:30 +0900
In-Reply-To: <20190507213612.GB19955@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 7 May 2019 17:36:12 -0400")
Message-ID: <xmqqa7fxk8ot.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBC7CB18-7134-11E9-AF10-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think this is reasonable, especially with the feature in patch 6 to
> tell the caller they're doing it wrong, instead of just silently
> producing nonsense results.
>
> Junio, if you haven't been following closely, this can replace my patch
> from jk/perf-installed-fix.

I did not pick up v2 or earlier as it wasn't clear what the
resolution would be, but I agree that this round looks sensible.

Thanks for the hint; very very much appreciated.

