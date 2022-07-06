Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A44C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 19:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiGFTVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 15:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGFTVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 15:21:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E024F32
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 12:21:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44DAF1B176C;
        Wed,  6 Jul 2022 15:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=x3CvDW7HGa38Q1dbGhrzGmJ+IbWYpGK1XZdboN
        sW+9U=; b=Jq2Yy6Fct11JERVG02Mz4QpxthTxvSqGt9LDwnPgK6tRmkQyIjA3U4
        Y5jIZER0RJ6aZw7BuakJeOsCRCQTlYYe5R26DpphRKwYBIHFvvD0IUJOZFRT+uet
        ff/x5QvKf0kUgkNrkqxTmb5+oNKIJrSjUib0ZG9CC5GZnIDoNlV4U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28E8E1B176B;
        Wed,  6 Jul 2022 15:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1FFA1B176A;
        Wed,  6 Jul 2022 15:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3 0/6] [GSoC] bitmap: integrate a lookup table
 extension to the bitmap format
In-Reply-To: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com> (Abhradeep
        Chakraborty via GitGitGadget's message of "Mon, 04 Jul 2022 08:46:10
        +0000")
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
        <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 06 Jul 2022 12:21:35 -0700
Message-ID: <xmqqiloagi80.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA9425CE-FD60-11EC-9AD5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> When parsing the .bitmap file, git loads all the bitmaps one by one even if
> some of the bitmaps are not necessary. We can remove this overhead by
> loading only the necessary bitmaps. A look up table extension can solve this
> issue.
>
> Changes since v1:
>
> This is the second version which addressed all (I think) the reviews. Please
> notify me if some reviews are not addressed :)

Is this the second version that is labeled as "v3" ;-)?

>  Documentation/technical/bitmap-format.txt |  39 ++

I haven't tried merging it yet, but doesn't [1/6] overlap with and
semantically depend on your other series that touch the formatting
of this file?

Thanks.
