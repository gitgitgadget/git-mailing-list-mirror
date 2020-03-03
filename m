Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E87C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 23:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D958A20870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 23:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="av0D6mJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgCCXTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:19:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64115 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgCCXTm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 18:19:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5518956356;
        Tue,  3 Mar 2020 18:19:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=284MU4YjQBKdHlGepBmBWzVW2bQ=; b=av0D6m
        JRAVz31cijQCGTKnbA4GG5zPWgb3V2j59BrQ7Nb+L9/Ebl2+7mU2hwpgeptDhWCn
        Q48Ev0z3UobetRPclSJA7At+4SElGHaUns/KltsWfrbPJtFrxspyvxDVaLaaKZTo
        2DZO2HJj84ud9kaPvzxX48Jg67Wt1JU8PEtdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jlqYFuvVZU0PCWqWHb7OzNHlX/dPpTPr
        PRGJYyhf4oJGz4751g7UiYu9h02kE6Fb3+6koXwU5H6gM2RlYABd2X+/ue1sUQ9L
        t+SQYpu5qsoV0ltTTG1oKvxasWSFNw1k7vuYsnmUI72nDiK2pXa1OoaPsHSFRCyD
        bMubdGnjLpY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BCA856354;
        Tue,  3 Mar 2020 18:19:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC0485634F;
        Tue,  3 Mar 2020 18:19:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #01; Tue, 3)
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
        <20200303230554.GA11837@syl.local>
        <xmqq1rq96nih.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 03 Mar 2020 15:19:38 -0800
In-Reply-To: <xmqq1rq96nih.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 03 Mar 2020 15:12:54 -0800")
Message-ID: <xmqqtv3558mt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74B46F14-5DA5-11EA-8FB3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> What's in 'v3' of that series [1] is ready to merge, in my opinion.
>
> Alright.  Let's do so.
>
>> [1]: https://lore.kernel.org/git/cover.1581486293.git.me@ttaylorr.com/#t
>
> Thanks.

Hmph, actually...

> It was intended as the former, but I share both of your feelings that it
> could be read either way. I amended the commit message to clarify by
> adding:
>
>   (and haven't since been deleted from the object store)
>
> as a parenthetical after "already in the graph...".

... don't we want to get that "amended" one, at least?  I do not
recall if there were other things you said you'd tweak or not during
the review of that v3, though.

