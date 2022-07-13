Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B058EC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 16:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiGMQSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 12:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiGMQSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 12:18:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197B82724
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 09:18:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BCAF14446F;
        Wed, 13 Jul 2022 12:18:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RG1Rmn4/4OURIfrfFrLYvwKx1IpvrRwpa3UVhV
        afaKg=; b=yJRunvIhGV2+sABM+Y98ERVIe2rPLGxRVgzCgrm9eBwk1dKiA5Boes
        2PbtL+cHMYgDiT+Bz+8a1UpBXmwtLfRdRhLI+PNldZbRbhe6KjVPxGUqAnNRdaEM
        riCdqHMvqjx/DTnlk4mkwQcYYy9c7303MvkIdlY9hlscS52FCY3ko=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4315414446E;
        Wed, 13 Jul 2022 12:18:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB59814446D;
        Wed, 13 Jul 2022 12:18:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Use "allowlist" and "denylist" tree-wide
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 09:18:34 -0700
In-Reply-To: <pull.1274.git.1657718450.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Wed, 13 Jul 2022 13:20:47 +0000")
Message-ID: <xmqqk08hdm05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7245148A-02C7-11ED-8F3B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The terms "allowlist" and "denylist" are self-defining. One "allows" things
> while the other "denies" things.
>
> These are better terms over "whitelist" and "blacklist" which require prior
> knowledge of the terms or cultural expectations around what each color
> "means".

Half Devil's advocate mode on, as I got up on the wrong side of the
bed this morning.

I am very much for consistent uses of allow/deny and I think it is a
good idea to review and apply this series.

But I'd prefer to see us more honest to ourselves.  Like it or not,
the code comment and documentation are targetted toward those who
can read English, and when you say something is whitelisted in
English, you know exactly what it means, due to shared knowledge of
historical use of the word.

We are doing this change in the name of inclusion.  I find it
intellectually dishonest to avoid saying that true reason, and
instead say the allow/deny pair is more "precise".  They are not
more precise.  In fact, the fact why you have to choose between deny
and block and defend deny over block shows that these words are less
precise.  People who use white/black do not have to choose between
black and other colors and say "white/red may be OK but we choose
black because..." to defend the choice of their words.

The reason we do this change is because the project thinks that it
is the right thing to encourage the adoption of these more inclusive
words, together with other projects that did the same.

In addition, they are words more widely accepted in today's world,
and new folks are more likely to be educated with these words.  As
time goes by, the historical white/black will be less understood, so
it makes it a future-proofing change, as well.

