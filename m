Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE881C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDB820678
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SlY4wqe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHEVgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:36:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63524 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgHEVgh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:36:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2122A77106;
        Wed,  5 Aug 2020 17:36:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zLOnMAhvIFLrl34L3+5tcvTO8AQ=; b=SlY4wq
        e/HaE2b0vSyhItKyn7/7Ynw+bKYSAmHPgf6EAeGqmQQ8RShEUaBhLpKeSL7qrZqU
        wiMsMwn0XEhx+oKfM+dLUO/naqfwYzf7qjlyl2Ts+Y5pRqlobCb0hvEl5kcEWsG7
        KVFj6TvmN0RBcO/vwgq3wb5eZ/dAuYYaMkm1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tB4aC3gHXsvmV7pM3K5Ff12Q3t4+qQsA
        wMdlIqpecNIcuYk1dyihVv2UUK6oHNW5hjahHoDiE76GNQxyVpQcee61J94W9R9e
        nVYX8YjFQCR+P/OXZouQ35J+0gy3lv8TWEBdXZ4rZBYarMH6kZ/3d3Ct8wpT4O5G
        ZHiBfQRp/Ws=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1719A77105;
        Wed,  5 Aug 2020 17:36:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DC3C77104;
        Wed,  5 Aug 2020 17:36:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/4] t7401: add a WARNING and a NEEDSWORK
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
        <20200805174921.16000-5-shouryashukla.oo@gmail.com>
Date:   Wed, 05 Aug 2020 14:36:33 -0700
In-Reply-To: <20200805174921.16000-5-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 5 Aug 2020 23:19:21 +0530")
Message-ID: <xmqqy2msn5b2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC1D7EC6-D763-11EA-A352-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add a WARNING regarding the usage of 'git add' instead of 'git
> submodule add' to add submodules to the superproject.

Is that a warning worthy thing?  As far as I know, using "git add"
to register a gitlink is perfectly fine and a supported way to start
a new submodule.  It may have to be followed by other steps like
"git config -f .gitmodules" (e.g. when operations that needs to use
the contents recorded in the .gitmodules file are to be tested), but
writing tests using lower-level ingredients for finer grained tests
is not all that unusual, is it?  I dunno.

> NEEDSWORK regarding the outdated syntax and working of the test, which
> may need to be improved to obtain better and desired results.

Sounds good.

> While at it, change the word 'test' to 'test script' in the test
> description to avoid ambiguity.

Sounds good.  I often search for a pair of phrases to differentiate
a single tXXXX-name.sh file as a whole and an individual test piece
in it.  "This test script", especially when written near the
beginning of the file, is a good way to clearly convey that you want
to refer to the former.

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  t/t7401-submodule-summary.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index 145914cd5a..2db4cf5cbf 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -5,8 +5,13 @@
>  
>  test_description='Summary support for submodules
>  
> -This test tries to verify the sanity of summary subcommand of git submodule.
> +This test script tries to verify the sanity of summary subcommand of git submodule.
>  '
> +# WARNING: This test script uses 'git add' instead of 'git submodule add' to add
> +# submodules to the superproject. Some submodule subcommands such as init and
> +# deinit might not work as expected in this script.
> +
> +# NEEDSWORK: This test script is old fashioned and may need a big cleanup.
>  
>  . ./test-lib.sh
