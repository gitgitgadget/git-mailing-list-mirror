Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04504EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 16:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjGNQwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjGNQwf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 12:52:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E983B1FC8
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 09:52:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 567CF19A496;
        Fri, 14 Jul 2023 12:52:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BCl+vFylODf+p2t0tiGmZW/dIrJU2BRIbxHwxT
        Mvxz4=; b=TBNm8BV9cpNcC2dTDghKOOMW1XMTMi8w1m5u5xyVlrOif8M/Yka7Ys
        iNbTwcFymvG1t7D9foawMtzgJAUVG+PB5q2lnMkZxKClXuv1m/aQTkxckniAjE5k
        cbfwojEoFVX/0b4rn3WZM9cabfk8G32c/EXdzRQpGeNT3yDQGTvtY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F74219A495;
        Fri, 14 Jul 2023 12:52:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9FEE19A494;
        Fri, 14 Jul 2023 12:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH] t4002: fix "diff can read from stdin" syntax
References: <pull.1545.git.git.1689341410476.gitgitgadget@gmail.com>
Date:   Fri, 14 Jul 2023 09:52:32 -0700
In-Reply-To: <pull.1545.git.git.1689341410476.gitgitgadget@gmail.com> (D. Ben
        Knoble via GitGitGadget's message of "Fri, 14 Jul 2023 13:30:10
        +0000")
Message-ID: <xmqqzg3yph9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4316422-2266-11EE-B96B-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
>
> I noticed this test was producing output like
>
> ```
> t4002-diff-basic.sh: test_expect_successdiff can read from stdin: not found
> ```
>
> which is rather odd. Investigation shows an error of shell syntax:
> foo'abc' is the same as fooabc to the shell. Perhaps obviously, this is
> not a valid command for the test.
>
> I am surprised this doesn't count as an error in the test, but that
> accounts for it going unnoticed.
>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---

Nicely spotted.  Thanks.

Will queue.
