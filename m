Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2393AC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E097422CA1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="btPN9RKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHEVXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:23:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61470 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHEVXw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:23:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4262A77056;
        Wed,  5 Aug 2020 17:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2T04d484tmLHnbKFDvw4jLYj+i8=; b=btPN9R
        KPNKPNLSwPUdwj7brdMr2s0kJFrUNpMExDktV5rq8evmMVlnIYR27P3t/h+BvFMy
        VfCDiJU87KiuOQbSOAIY4eTJRq3GoWTjWACbrAQ9QuQz2ueweoI+HWF2LNpBISHf
        TAFev4sFfWMxPV5cCFOsuoOVKsaTWJdD3hovA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FUAN66RkgySztZ9BVvYWtVSPzJM7ehnj
        lm4/mIsDontehGv1WXK5k9/hJGVJqlFEi+wTl0z7M4oNS8FQM4H22O2Cmg/MD6JP
        8NpYIzQqD1aF6o/DXD/uczzoy/pKO+2rCXhky2MZEvabHVLnZKHjSCc6Txn4r87C
        i4CpqCdsflQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36F8977055;
        Wed,  5 Aug 2020 17:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB56E77053;
        Wed,  5 Aug 2020 17:23:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/4] t7401: change test_i18ncmp syntax for clarity
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
        <20200805174921.16000-3-shouryashukla.oo@gmail.com>
Date:   Wed, 05 Aug 2020 14:23:49 -0700
In-Reply-To: <20200805174921.16000-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 5 Aug 2020 23:19:19 +0530")
Message-ID: <xmqq7ducokgq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F440BF90-D761-11EA-8BB9-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Change the test_i18ncmp syntax from 'test_i18ncmp actual expected' to
> 'test_i18ncmp expected actual' to align it with the convention followed
> by other tests in the test script.

Yeah, this is a good thing to do, as a failing test_cmp gives a diff
between the first file to the second file, i.e. a patch that turns
the expected output into what the tests actually produced, so that
the tester can see how the expectation is broken.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  t/t7401-submodule-summary.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index 4439fb7c17..18fefdb0ba 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -183,7 +183,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' "
>    < Add foo5
>  
>  EOF
> -	test_i18ncmp actual expected
> +	test_i18ncmp expected actual
>  "
>  
>  test_expect_success 'typechanged submodule(submodule->blob), --files' "
> @@ -193,7 +193,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --files' "
>    > Add foo5
>  
>  EOF
> -	test_i18ncmp actual expected
> +	test_i18ncmp expected actual
>  "
>  
>  rm -rf sm1 &&
> @@ -204,7 +204,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
>  * sm1 $head4(submodule)->$head5(blob):
>  
>  EOF
> -	test_i18ncmp actual expected
> +	test_i18ncmp expected actual
>  "
>  
>  rm -f sm1 &&
> @@ -217,7 +217,7 @@ test_expect_success 'nonexistent commit' "
>    Warn: sm1 doesn't contain commit $head4_full
>  
>  EOF
> -	test_i18ncmp actual expected
> +	test_i18ncmp expected actual
>  "
>  
>  commit_file
