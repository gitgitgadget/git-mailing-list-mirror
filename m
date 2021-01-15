Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1D1C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 03:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B8923AF8
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 03:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbhAODTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 22:19:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63372 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbhAODTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 22:19:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7173AB1F48;
        Thu, 14 Jan 2021 22:19:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BjgiM/kisCyeZ+INxarWZkAEHmM=; b=BMvnLK
        HGMwadKGTr8tDBmM2bTw/wyJvXQraNUK6slqI92RWC085GW0yMfuwh4j/T2HXrVQ
        oL0JAB3WsiwcgqdPUiVthDVLlmgrz63PBlij8VNSqQA/lDKa2NN1OqeZFx572wqd
        9qBKSxV3ckkdEuUniEtc5q8DH48TNNP5LAvLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SgL02pLUp79SfnteWEGmMgu9BibWHg19
        mo3VerVNDtK+UwTbPeHok5LjftMmYYVJs8OU8YMIQt8LHwH1m+r6Y3eG2s+tz48Z
        wl/cb0SbpuAo+hTGR83t/t0Lz73sf2wM3Y+LAO5fEhuTWVfAK4hB3j7sssBMY+VY
        RYP79bSWn4M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D4A2B1F47;
        Thu, 14 Jan 2021 22:19:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 892AFB1F46;
        Thu, 14 Jan 2021 22:19:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 01/22] mailmap doc: create a new "gitmailmap(5)" man page
References: <20210105130359.21139-1-avarab@gmail.com>
        <20210112201806.13284-2-avarab@gmail.com>
        <a71860ee-6810-8766-b9c7-4c03ea7e6e01@gmail.com>
        <xmqqk0sfxpd4.fsf@gitster.c.googlers.com>
        <6612514d-051a-1e58-7ea1-c00428882f2d@gmail.com>
Date:   Thu, 14 Jan 2021 19:18:59 -0800
In-Reply-To: <6612514d-051a-1e58-7ea1-c00428882f2d@gmail.com> (Philippe
        Blain's message of "Thu, 14 Jan 2021 21:38:35 -0500")
Message-ID: <xmqqft32vqe4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6965ED74-56E0-11EB-A094-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> I was not sure...) I feel it is cleaner for that commit to use
> the correct variable name from the start, hence the fixup.

The topic is already in 'next', and that is why I asked follow-up
patches on top from people.  Otherwise I wouldn't have asked and
instead just squashed these fixes in while the topic was in 'seen'.

Thanks.

