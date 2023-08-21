Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314EEE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 23:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHUXXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 19:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHUXXA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 19:23:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A343F132
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 16:22:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C02F637508;
        Mon, 21 Aug 2023 19:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kmvRzNSEH2tnfzIa9JWWHLFVfGxWRpK5weilOk
        9/lz4=; b=fOFzBEZbEXJM5ID2eeHO725iiHKfLCSPlKkbWCLtEAVU17Ys3bdPNw
        /lS/SbwZT6WfmbvoY15XZJ6Ow8odvpT3pwv9SUdeZP+Yh8O+zDbS8VkB70YUGBQ7
        lueYXvMUUvKAa9pn/XlywF84JRneynbDDcOvdl66GRCFYo/IcrXRo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7EFE37507;
        Mon, 21 Aug 2023 19:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A684937503;
        Mon, 21 Aug 2023 19:22:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/4] commit-graph: fsck zero/non-zero generation
 number fixes
References: <ZNUiEXF5CP6WMk9A@nand.local>
        <cover.1692653671.git.me@ttaylorr.com>
        <20230821215518.GA1811034@coredump.intra.peff.net>
Date:   Mon, 21 Aug 2023 16:22:51 -0700
In-Reply-To: <20230821215518.GA1811034@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Aug 2023 17:55:18 -0400")
Message-ID: <xmqq5y58nfp0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6B228F2-4079-11EE-AAB6-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The end result looks good to me. I probably would have squashed at least
> 2+4 into one, and probably just squashed 3 into that as well. But I am
> OK with it as-is, too, and it is definitely diminishing returns to keep
> polishing it.

I had the same impression.  The endgame after applying all four
looks very sensible but the changes necessary to fix things while
keeping ZERO_EXISTS and NUMBER_EXISTS looked more or less like
unnecessary detour.

> Thanks for assembling it into a usable form.

Yup.  Will queue almost as-is (except for dropping the repeated
"commit-graph" on the title of the last step).

THanks.
