Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D9C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 22:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA2611BF
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 22:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCWxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 18:53:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54502 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCWxA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 18:53:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADE27CBDC1;
        Thu,  3 Jun 2021 18:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R8+NWy+ZWimC03dRL1rP9Nnfb7UyBToNGK8gfd
        Pu9hs=; b=B0xIl/lF48wU9OMTCudlwXpVhd0AUl7XWBLPFCPWowewEMplpe1sze
        scb78IyRZ2ttxAwjfmQRRETDeBaaK7EZu8/NLFZCLeYuzmDLxJ3s2e4zRDezB+G6
        qeaQnAYq98xDPtFF0kH6a6/cUB9cJ+kvITOpgkf1RUoHlqSAlyQ2A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9376CCBDBF;
        Thu,  3 Jun 2021 18:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C22DCBDBE;
        Thu,  3 Jun 2021 18:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 0/2] [GSOC] cat-file: fix --batch report changed-type
 bug
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
        <pull.967.v2.git.1622737766.gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 07:51:13 +0900
In-Reply-To: <pull.967.v2.git.1622737766.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Thu, 03 Jun 2021 16:29:24 +0000")
Message-ID: <xmqq7dja4l5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32D664B8-C4BE-11EB-B896-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Change from last version:
>
>  1. Modified the test structure under the recommendation of Peff.
>  2. Use clearer and more concise commit message help by Peff.
>
> ZheNing Hu (2):
>   [GSOC] cat-file: handle trivial --batch format with
>     --batch-all-objects
>   [GSOC] cat-file: merge two block into one
>
>  builtin/cat-file.c  | 10 ++++------
>  t/t1006-cat-file.sh | 22 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 6 deletions(-)
>

Nicely done.  Thanks, both.
