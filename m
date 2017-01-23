Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DC820A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdAWT77 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 14:59:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53640 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750950AbdAWT76 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 14:59:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51DC762DAD;
        Mon, 23 Jan 2017 14:59:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=saoiVpRZeePrrrv9wiZIYSz7B6k=; b=jD/tk8
        9Zj3OOhyk/b+bNELP1EI9chhYjM+tDlfIQD96jE3LRBSSxyEvtzutEVIV2dA9SPK
        U4bGyY9+tIH/ebx78+NdkLZgjzatEFNcDqHj5jCyt6QIrPCWMeeZRdovKg6tbPbb
        EKA2eRY0hdQo/TKxKoTMbj5K3iNpfvjec3QLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tDGPIkrarehHkaw9jHI4g8B3C4HazCSO
        aigeNv5VZ/whX3SRIzke///odtBVHlHxUon2Selvob4/4yuN+yK2Bqc4hnfkQT/3
        O1eJ4yw7j9KnP02bYo5cQQyJ/cDG8zU6KEeoguav4ub2s20euKMC3bB+6JPyfXwC
        ysAlIyBZsJE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C2EF62DAC;
        Mon, 23 Jan 2017 14:59:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B52262DAB;
        Mon, 23 Jan 2017 14:59:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 08/21] Documentation/git-update-index: talk about core.splitIndex config var
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-9-chriscool@tuxfamily.org>
        <xmqqpokd9ocw.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD06mxGiZmr4Lwv3M8CedBZaamswzz-Q+mOxuuUFet8KNQ@mail.gmail.com>
        <xmqqshou35zr.fsf@gitster.mtv.corp.google.com>
        <CACsJy8D1Pf6zTS8gqv5Gq6xMxNNbDrTpKHGADRMKNqW1FAzZvA@mail.gmail.com>
        <CAP8UFD2aQJ92KjzTQTGLyYeEuVk9TK51mn05OSWCZu5c4c6WuQ@mail.gmail.com>
Date:   Mon, 23 Jan 2017 11:59:55 -0800
In-Reply-To: <CAP8UFD2aQJ92KjzTQTGLyYeEuVk9TK51mn05OSWCZu5c4c6WuQ@mail.gmail.com>
        (Christian Couder's message of "Mon, 23 Jan 2017 16:55:38 +0100")
Message-ID: <xmqqo9yxr1hg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83590828-E1A6-11E6-8465-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>>> Perhaps we should declare that config will be the one and only way
>>> in the future and start deprecating the command line option way.
>>> That will remove the need for two to interact with each other.
>
> That would be my preferred solution as I think it is the simplest in
> the end for users.
> Also, as Duy wrote above, one can always use something like "git -c
> core.splitIndex= ...", which by the way can work for any command, not
> just "update-index".
>
> Anyway we would have to introduce core.splitIndex first, and it
> wouldn't make sense to have a different behavior between
> --[no-]split-index and --[no-]untracked-cache in the meantime before
> they are deprecated and eventually removed.
>
> So let's just go with the implementation in this series, which is
> similar to --[no-]untracked-cache, and let's plan to deprecate
> --[no-]split-index and --[no-]untracked-cache in a later patch series.

Sounds like we have a plan.  Thanks.
