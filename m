Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB721F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 07:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJBHEp (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 03:04:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61959 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJBHEp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 03:04:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B1C682EC9;
        Wed,  2 Oct 2019 03:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZQaixE4YBTJti4xzkYeQm4PK6T8=; b=HY+kEP
        6870ZJdAzy/tVfG6JEklbPKMnjYHPUyGc1ZVTKEwkwsTYDGfSVrQQJoiv/D74W9P
        8oJdHJqViVIE6FFvpVV1EvsF3A/Lmk6zaDWjd28/ETXfodh0tghdI/rUApn60GXg
        XNhC2wqWSGFCgfiWKjq3f7idgnTxn2QuJ+G1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kWsgrxvXzqJBofJAqZhTCJCd+oV95wTO
        EW5grNFP6m2/14PbO31mXbqkezKwkf3uD96Vy9gQzxDa/6OZgbHBFYonDM2kaeXU
        Q70w/js+EvjrvBgfnP1obuClfCU1a7zdTIMl64xmpdsS0BypUAjwxetDu8Yd5Ndm
        whGAz8jmivY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8477582EC8;
        Wed,  2 Oct 2019 03:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B64AC82EC4;
        Wed,  2 Oct 2019 03:04:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Baker <williamtbakeremail@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
        <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
        <20190921121104.GA6787@szeder.dev>
        <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
        <2de6b236-7bd8-256b-7d8f-911d63a47498@gmail.com>
        <xmqqsgobg0rv.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 02 Oct 2019 16:04:38 +0900
In-Reply-To: <xmqqsgobg0rv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Oct 2019 14:43:48 +0900")
Message-ID: <xmqqlfu3eigp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E76856B0-E4E2-11E9-B572-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> William Baker <williamtbakeremail@gmail.com> writes:
>
>> Although my debugger might not be the smartest, I haven't noticed any
>> downsides to switching this to an enum.
>
> Well, if you write
>
> 	enum { BIT_0 = 1, BIT_1 = 2, BIT_3 = 4 } var;
>
> it's pretty much a promise that the normal value for the var is one
> of these listed values to your readers.

... that is why compilers give a warning when you write

	switch (var) {
	case ...:
	...
	}

and do not have case arms for all the declared enum values without
having the 'default' arm.
