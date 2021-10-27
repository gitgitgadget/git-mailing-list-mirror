Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F0AC433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 16:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B08860ED4
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 16:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbhJ0QtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 12:49:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61949 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbhJ0QtY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 12:49:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A18AEEF44;
        Wed, 27 Oct 2021 12:46:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RJverc+EEWS1nM/i1tFe9201IY897B7gin8EQP
        uUhZ8=; b=ZhwczvAAUeU+7DwJmsRQIPX1NpQVzRXW3ZXOj/+UKQZ132h0QdzxIZ
        N7aHTU17SlHu54IygZARX4IBkRL28p+vXmcleYAzFIVS+3uAssW8sl5W3Vpb/H4x
        2cCSt1Ay5PQuoWr4TNe2C3xrOpgkFdqfivee45xiHcqmZxYXrCtpA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5233EEEF43;
        Wed, 27 Oct 2021 12:46:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5439EEF42;
        Wed, 27 Oct 2021 12:46:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     David Aguilar <davvid@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [RFC PATCH] mergetools/vimdiff: add vimdiff4 merge tool variant
References: <20211019212020.25385-1-greenfoo@u92.eu>
        <CAJDDKr5frTgh4_x5yvskJfppew3ntvpgBe9MnUB9CfGQaw1TLQ@mail.gmail.com>
        <xmqqk0i10xzt.fsf@gitster.g> <YXcP6kf3tGr+WFRS@zacax395.localdomain>
Date:   Wed, 27 Oct 2021 09:46:56 -0700
In-Reply-To: <YXcP6kf3tGr+WFRS@zacax395.localdomain> (Fernando Ramos's message
        of "Mon, 25 Oct 2021 22:13:30 +0200")
Message-ID: <xmqqy26ewh33.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FBC3C7C-3745-11EC-8056-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> The nice thing about this approach is that, as we have seen, it is generic
> enough to rule all current variants obsolete.

I am not a vimdiff user (or mergetools in general---I should use it
as appropriately from time to time myself), but it would be great if
such a general "layout rule language" can be used to replicate the
existing variants.

> So, please let me know what you think about this:
>
>   * Do you like this approach? Or am I trying to crack a nut with a sledgehammer
>     by making the whole thing too complex?
>
>   * In case you like it, should we keep the old "vimdiff1", "vimdiff2" and
>     "vimdiff3" variants for backwards compatibility?
>     If the answer is "yes", I'll just alias them to the new "layout" mechanism
>     so that the amount of extra code needed for supporting them is minimal.

It is great that the new "description based layout" can replicate
the existing variants, and it is natural migration path to redo the
existing variants with the new mechanism once the dust settles as a
separate step.  The end-users should be able to rely on their
existing configuration to keep working the same way as they are used
to.

Thanks.
