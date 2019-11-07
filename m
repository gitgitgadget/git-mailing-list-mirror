Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5227C1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 09:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbfKGJvT (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 04:51:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59653 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGJvT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 04:51:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 173AD92F74;
        Thu,  7 Nov 2019 04:51:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YrCYfgPVQuK3hqOJ5gnSplhtCpw=; b=WNqMtc
        A5GXAYwmwSK0zX56eqOckdV/8urz0/RkzYRIY6iCaQLM+2t4zGdzhGZz2hfHepQT
        2/kckfl5kYHOEkQbSycu18mT84IuCpTt2a1RIrwwQRJtvN17Gn6zb7+Y+vIvCuXM
        3oNjtEKlQdril2UnUj7ns0HDCs7Cl2LzPJJz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=otVbMfRHaxkv585CcjCwaGl0xpxGm20n
        hojtUgrJl95juEIveDZwqHdqgbNBglPb6Gbsm/kgtin6AIKQT3GmagvgvwuMxkw7
        46xts7hD+HRuV1lbxVv1S7IABc+rc1+pkG9NQUSKHhsVdQNivZQcxHKQIQ/rUkxG
        utE73FILm2Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FDE292F73;
        Thu,  7 Nov 2019 04:51:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2740492F72;
        Thu,  7 Nov 2019 04:51:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, rynus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] commit-graph: use start_delayed_progress()
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
        <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
        <78bd6bc2c02f1daf13938a738d8eae56b5f6b74c.1572984842.git.gitgitgadget@gmail.com>
        <20191106040955.GD4307@sigill.intra.peff.net>
        <xmqqpni4s3mn.fsf@gitster-ct.c.googlers.com>
        <20191107064356.GH6431@sigill.intra.peff.net>
Date:   Thu, 07 Nov 2019 18:51:11 +0900
In-Reply-To: <20191107064356.GH6431@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 7 Nov 2019 01:43:56 -0500")
Message-ID: <xmqq36f0qak0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22D14A22-0144-11EA-B830-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think any no/auto/always here is tricky, because it already has a
> meaning: to use or disregard isatty(2). And overriding that might be
> independent of the "type".

Yes, your "let the users optionally give the delay" in the other
subthread makes a lot more sense.

Thanks.
