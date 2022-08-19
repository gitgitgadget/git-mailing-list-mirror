Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC8FC32773
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352310AbiHSVVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351418AbiHSVVU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:21:20 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B995105F09
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:21:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DBEAE19EF4E;
        Fri, 19 Aug 2022 17:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lSRxGKMO+zmBVRNhNupa7NKTdDUBPlcMm17C9x
        N0P8k=; b=xAwkG6BQTaqWG4vx+5pDTxztAYS4uah2nbaBbbfh0Dyy4629OBWBJf
        hL04wLvrCzsE1v1evniA3EhE9fjKvsQJWZATD9DnLxwt8z0g7n1XVpm0OgY+RsrP
        ZttdK5YDsry+CuSQ3aef5YJojNfTkA6D2y4iLU/1cd5askHU7y4Fw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4A5219EF4D;
        Fri, 19 Aug 2022 17:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8520E19EF4C;
        Fri, 19 Aug 2022 17:21:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v6 0/6] [GSoC] bitmap: integrate a lookup table
 extension to the bitmap format
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
        <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 14:21:14 -0700
In-Reply-To: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com> (Abhradeep
        Chakraborty via GitGitGadget's message of "Sun, 14 Aug 2022 16:55:05
        +0000")
Message-ID: <xmqqlerkj5f9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBA98924-2004-11ED-94F2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
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
> Changes since v5:
>
> As the failure in the test case is not due to this code, I think it makes no
> sense to delay the patch further.
>
>  * The performance test changes were not accurate as the second
>    test_bitmap_cases call using the repo built for the previous call. This
>    version fixes that.
>  * Taylor suggested some minor changes. Those are addressed in this version.

The discussion on v5 was quite active, but we haven't seen any
traffic on this round.  Is everybody happy with what we see here?

