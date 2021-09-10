Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619F7C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40ACA6120A
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 22:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhIJWKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 18:10:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51547 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbhIJWKG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 18:10:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03527E85FC;
        Fri, 10 Sep 2021 18:08:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1g2G9L1lC8tw4BxBH/SamNpk7ewP/2qhTPbln/
        J41Qk=; b=WhezpeXCOQlUmsIcORd9xT2VeyvzIdyRTdG7WqTGqAajNEV9/SK+u6
        QnYxgc0u16pvVCE4Iy9A28g+FWEHPkQENgYfU+DqQL3qD2xOX2PcY82cNIpVI5Sa
        LzQbYctpEKMBWZWIY5g5FupRePQBNTdqCIMpSc3p01Ac8fB8GXjpU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED769E85FB;
        Fri, 10 Sep 2021 18:08:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73F64E85FA;
        Fri, 10 Sep 2021 18:08:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
        <YTOW352xtsbvJcKy@coredump.intra.peff.net>
        <20210907211128.mauwgxupbredgx7w@meerkat.local>
        <YTiVDo4m5B5RcfCg@coredump.intra.peff.net>
        <YTiXEEEs36NCEr9S@coredump.intra.peff.net>
        <xmqqee9x1wvh.fsf@gitster.g> <xmqqa6kl1wjs.fsf@gitster.g>
        <YTtECuP2/A6+EI4J@coredump.intra.peff.net>
        <YTtleYs48A1NpUpp@coredump.intra.peff.net>
Date:   Fri, 10 Sep 2021 15:08:52 -0700
In-Reply-To: <YTtleYs48A1NpUpp@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 10 Sep 2021 10:02:33 -0400")
Message-ID: <xmqqwnnoqe17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF6EC156-1283-11EC-8E82-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 10, 2021 at 07:39:54AM -0400, Jeff King wrote:
>
>> I'll re-roll with that change, plus some documentation changes adapted
>> to this new approach.
>
> Here's what I came up with. I think this should replace both
> jk/http-backend-handle-proto-header and kr/doc-webserver-config-for-v2.
> The latter does give some specific nginx tips which I didn't carry over,
> but they shouldn't be necessary after the change in http-backend. If we
> do want to include them, they can be mentioned as optional if we later
> add an nginx example config to the http-backend manpage.

All look sensible.  This topic will appear in the next round of
integration, not today's.

Thanks.
