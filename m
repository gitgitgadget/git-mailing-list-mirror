Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792EA1FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 01:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937108AbdAGBT5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 20:19:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57643 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933312AbdAGBTz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 20:19:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 424A75D82A;
        Fri,  6 Jan 2017 20:19:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S8cxcR99YCfHGGKtzeA+ovTLByo=; b=Rtr77Y
        +PRRzmz31zKmgvm2iBdGSPrwAjmgtQzqbNBpDUtu+guAVI4N0d7GtwlmV4hjvD9b
        22HM9jMciXVxyPcb0ONKlDI0cSiqpcWfkk16zlow731rYaJq+Piu0w8tY5x9XVd0
        n5D8Qv6eDco/FxMPlMXsUSMvpyQ8YZIneD9Ng=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A1AC5D829;
        Fri,  6 Jan 2017 20:19:54 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC7125D827;
        Fri,  6 Jan 2017 20:19:53 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch_get_push: do not segfault when HEAD is detached
References: <20170106045623.21118-1-kyle@kyleam.com>
        <alpine.DEB.2.20.1701061438300.3469@virtualbox>
        <87inprllpv.fsf@kyleam.com>
        <20170107011138.uuy6ob234kyy3y4e@sigill.intra.peff.net>
X-Attribution: Kyle
Date:   Fri, 06 Jan 2017 20:19:53 -0500
In-Reply-To: <20170107011138.uuy6ob234kyy3y4e@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 6 Jan 2017 20:11:38 -0500")
Message-ID: <87bmvjll8m.fsf@kyleam.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64BFA3B8-D477-11E6-9501-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:references:date:in-reply-to:message-id:mime-version:content-type; s=mesmtp; bh=S8cxcR99YCfHGGKtzeA+ovTLByo=; b=l4ma3OHwMzF4qRP2hn5WQ+eC+x7AhDk1eNY1t+CtAXj6ADa7DwMbhA4gxPbdXx3zlHj+zzvGHZJi4KS840XoOtRW6EVzNaJx1yGsWFEnVyTjqySZM3wwGRp0j6gem8gwKFmOyNo/1VGuH0loqQN1MpQPgGzKNjqKDXO8gbLGaIQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jan 06, 2017 at 08:09:32PM -0500, Kyle Meyer wrote:
>
>> > $ git grep -c HEAD^{} junio/pu -- t/
>> > junio/pu:t/t3200-branch.sh:3
>> >
>> > Maybe use HEAD^0 just for consistency?
>>
>> Yes, thanks for pointing that out.
>
> The other option is just "git checkout --detach", which is also used in
> the test suite. I tend to prefer it because it's a little more obvious
> to a reader.

True, that does seem clearer.  Seems I should've waited a bit before
sending out v2.

--
Kyle
