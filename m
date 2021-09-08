Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B33EC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A5361100
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhIHWDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 18:03:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62365 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhIHWDa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 18:03:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C121114E2E7;
        Wed,  8 Sep 2021 18:02:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d5f2NIdKNNpJL37JxL1WxM6doIaoUSmLK3o/nc
        YMp64=; b=Tph7bkqEHNhHtWEorg8oTaSR/Lm05/mlccYLZ6QSMXNCvw10NMpHDT
        /CZ3SzXTAIcHFdI0Yg+kPcCovPKrE9vO+olQSrcyVIKTpKo/k0fCi3wV3ZuG75VB
        sHIN2RUh9eIIxerFOHeg1357pvs908M+jG5WMazJoJko1FC+8Y++c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9AFF14E2E6;
        Wed,  8 Sep 2021 18:02:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E79814E2E5;
        Wed,  8 Sep 2021 18:02:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Aleksey Midenkov <midenok@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git diff: print hunk numbers?
References: <CAF8BazDKG03bpBEQyC9EsM8WxV_7WnQ386T=VT49EHNzsZ3PPw@mail.gmail.com>
        <YTktpQ9uZkbwtuLO@coredump.intra.peff.net>
Date:   Wed, 08 Sep 2021 15:02:17 -0700
In-Reply-To: <YTktpQ9uZkbwtuLO@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Sep 2021 17:39:49 -0400")
Message-ID: <xmqq4kau3evq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F83C31E-10F0-11EC-93FD-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Of course that only helps if the patch actually applies. If your goal is
> to filter out hunks that don't apply, it won't help. :)

That can be done without filterdiff, though, via "git apply
--reject" ;-)
