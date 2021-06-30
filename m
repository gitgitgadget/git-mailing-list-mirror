Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B98C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 06:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590E461CEF
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 06:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhF3GMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 02:12:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53894 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbhF3GLu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 02:11:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9611D1A9A;
        Wed, 30 Jun 2021 02:09:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/hU77tohJvtEKhfXx9SyN7zAqha0pALXlptpkj
        l5zek=; b=raESXFfulrupgyXeEby1VS+lTWQFbA4ZNpwW3fSE54kClpxynDc4vT
        hl2O6s1DIPk7Wy5KLlZNbX/RglHE7LAXyYQc7QYedqJ3rJfQTDMawvAtd5sSJ8qq
        iLP5tBUfUiTMuFZuQpoV6RHBw4J4WjMkz1h2E3BzYmf9dUg9+Ojgc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0ECED1A99;
        Wed, 30 Jun 2021 02:09:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43376D1A98;
        Wed, 30 Jun 2021 02:09:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Antw: [EXT] Re: git add --interactive patch improvement for
 split hunks
References: <60D45FE4020000A100041FCE@gwsmtp.uni-regensburg.de>
        <YNSnlhbE30xDfVMY@coredump.intra.peff.net>
        <60D9A01C020000A100042099@gwsmtp.uni-regensburg.de>
        <87eecmgrnx.fsf@evledraar.gmail.com>
        <YNvT+tUlW98dQY3B@coredump.intra.peff.net>
Date:   Tue, 29 Jun 2021 23:09:19 -0700
In-Reply-To: <YNvT+tUlW98dQY3B@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 29 Jun 2021 22:16:26 -0400")
Message-ID: <xmqq5yxvvq7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B563375C-D969-11EB-B587-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>     It looks like Junio carried it in "What's Cooking" for almost a
>     year, marked as "waiting for re-roll" to handle the squash, but then
>     eventually discarded it as stale. :(

Heh, thanks for digging.

Is the moral of the story that we should merge down unfinished
topics more aggressively (hoping that the untied loose ends would be
tied after they hit released version), we should prod owners of
stalled topics with sharper stick more often, or something else?
