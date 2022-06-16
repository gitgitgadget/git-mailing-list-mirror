Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C346BC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 19:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiFPTNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 15:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiFPTNa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 15:13:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7005E23159
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 12:13:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E239A1AF88B;
        Thu, 16 Jun 2022 15:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y5S3fjGEuiF6HfKJkMkotGynlp0dWKRNaoQUP3
        6eixc=; b=Q3RyxTtMGYlbyiZlX6DPrY2uQcHRsJthnM06RAFlWSs44R1PEY8fJc
        EdJ7a3s+iDod52jL/YMmVu///X+wrRzNrZYcx2Mrp8uCMLdHdftDSB8HYShXmlnL
        6uMirxUCAvMq8bluRyfHStamb471zQU+awl5WAPKWSzOlY0YPx23s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAD081AF88A;
        Thu, 16 Jun 2022 15:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7BF1C1AF888;
        Thu, 16 Jun 2022 15:13:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/4] Reactions to v2.37.0-rc0 test coverage report
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
        <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 12:13:24 -0700
In-Reply-To: <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Thu, 16 Jun 2022 13:13:46
        +0000")
Message-ID: <xmqqy1xws9pn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6586100C-EDA8-11EC-8190-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> These patches add test coverage or simplify code based on discoveries in the
> test coverage report (specifically, some that I highlighted at [1]).
>
> [1]
> https://lore.kernel.org/git/3d1c6dfd-1df6-3393-df5e-692719375772@github.com/
>
>  1. Add tests for 'git update-index --verbose'.
>  2. Add 'git gc --cruft' without '--prune=now' to test.
>  3. Drop an always-NULL parameter from an internal method.
>  4. Revert 080ab56a4 (cache-tree: implement cache_tree_find_path(),
>     2022-05-23).
>
> Any subset of these could be taken (or dropped), but I thought they would be
> worth considering.
>
>
> Updates in v2
> =============
>
>  * A useless addition of --verbose was removed from a test in patch 1.
>  * Comments are updated in patch 2 based on Taylor's recommendations.
>  * Added --prune="01-01-1980" to exercise the --cruft-expiration logic
>    underneath 'git gc --cruft'.

Thanks.  Queued.
