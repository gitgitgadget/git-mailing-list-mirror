Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2E3C001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 22:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjGMW7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjGMW7V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 18:59:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807CAB4
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 15:59:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2865A1EACA;
        Thu, 13 Jul 2023 18:59:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5y7fqx2C0ItLLz5I7xs/b+IvmXWGcwAvRSnd8/
        kzoic=; b=BPlB7/ltbw8i36rCzG5/3nxARkrSb1MkF/8OAbzrqeBLucsn7Y5xUw
        ETlVdV059UV54/Tutsft9UZGXSv9HL49Wm0czAatxDYy493zLz+Bz8AFZoR/DKRe
        mhvbaQ87XsZBnveqKSOslzLEUDq3IoSVkMjwKvZB6sKJRyJUtS0Ms=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 164021EAC9;
        Thu, 13 Jul 2023 18:59:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 999021EAC8;
        Thu, 13 Jul 2023 18:59:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 0/4] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1689283789.git.jonathantanmy@google.com>
        <xmqqlefjlanl.fsf@gitster.g>
Date:   Thu, 13 Jul 2023 15:59:15 -0700
In-Reply-To: <xmqqlefjlanl.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        13 Jul 2023 15:16:46 -0700")
Message-ID: <xmqqwmz3ju4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E48D48CC-21D0-11EE-8819-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>      +If 0, git will write version 1 Bloom filters when instructed to write.
>
> And we will only read 0 and refuse to read 1?  Or we will read both
> 0 and 1?

Answering to myself (only this part).  As setting the "version"
variable to 0 is equivalent to setting "read" variable to "false",
we will refuse to read anything.

