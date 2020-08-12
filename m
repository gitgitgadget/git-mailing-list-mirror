Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB06C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509E82076C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gGuOVbpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHLU5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:57:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55492 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLU5o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 16:57:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA0E4D6F4F;
        Wed, 12 Aug 2020 16:57:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BRJ6SyFVOxCCeCipUCuCO3vO3K8=; b=gGuOVb
        puDetA4jyLSdU4kJhsZJZNUcsfDW343j50J6IfM1+LObB9AD5N21wbSqO2xRCjBO
        +55Oa7Y5b1dtJ8z2mBSBOvg5YaVKyY3pNGIYjlENCsmKP6tZbTCfe5rpQWtmqTqj
        WE18lNxl5H6d1Zf+Il3RbBxLz6+SwIqJyBoyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ITruxWrRHG7IOlRePyD3db1bJxUuMM5P
        nx/l0khgkxkaNpJBNVqYzARge2a4QvqNKeUnqgCYn8yy5ja7hXtea4kZ7RDk/VmO
        NvzKaGnXnhP55hJUfnKxXijPFSpN9e9kkSUT1ar95OwmRuQ9avTd+3jWxtbaR4xY
        c/n2Q/+yynw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E255ED6F4D;
        Wed, 12 Aug 2020 16:57:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B701D6F4C;
        Wed, 12 Aug 2020 16:57:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/4] t7401: change test_i18ncmp syntax for clarity
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
        <20200812192737.13971-1-shouryashukla.oo@gmail.com>
        <20200812192737.13971-3-shouryashukla.oo@gmail.com>
Date:   Wed, 12 Aug 2020 13:57:38 -0700
In-Reply-To: <20200812192737.13971-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Thu, 13 Aug 2020 00:57:35 +0530")
Message-ID: <xmqq1rkb60ql.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75977EAE-DCDE-11EA-BFE8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Change the test_i18ncmp syntax from 'test_i18ncmp actual expected' to
> 'test_i18ncmp expected actual' to align it with the convention followed
> by other tests in the test script.
> ...
> @@ -285,7 +285,7 @@ EOF
>  
>  test_expect_success '--for-status' "
>  	git submodule summary --for-status HEAD^ >actual &&
> -	test_i18ncmp actual - <<EOF
> +	test_i18ncmp - actual <<-EOF
>  * sm1 $head6...0000000:
>  
>  * sm2 0000000...$head7 (2):

This one does more than what the proposed log message explains, but
it does not do enough at the same time.  

If "actual vs expected order" is what this commit wants to fix, then
"<<EOF" vs "<<-EOF" is outside the scope of it.

Personally, I think it is a good idea to update the end-of-heredoc
marker to "<<-EOF", but the patch makes its readers wonder if the
author of the patch understands why it is a good idea to begin with,
because the end-of-heredoc marker is the only thing the patch
changes, and it does not change the indentation of heredoc itself.

The whole point of using "<<-EOF" instead of "<<EOF" is so that the
result becomes easier to read with indentation, e.g.

	test_i18ncmp - actual <<-EOF
	* sm1 $head6...0000000:

	* sm2 0000000...$head7 (2):
	...
	EOF

Compared to the original:

	test_i18ncmp - actual <<EOF
* sm1 $head6...0000000:

* sm2 0000000...$head7 (2):
...
EOF

it would be easier to read.

