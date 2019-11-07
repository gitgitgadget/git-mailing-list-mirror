Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86A551F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfKGFnb (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:43:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65344 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfKGFnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:43:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26E808CCC2;
        Thu,  7 Nov 2019 00:43:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kNvdkxjNRWFSE2GMwvFm6iL37Ps=; b=uDQRqZ
        GLPRCWZQm6LFJb3ZqGe55sbQvl3iyssBEwnwEIPPDfcKw2k2lH35CsjBjEsDS9vU
        NR+Eab4dQhu5dmCvtENSbGBMwT7e+iaprmBQgIbkhJHz3IkY+elbXp5ZmsJ/nmI5
        fDAEwN0IShFmxCuItJ7wbETHXzEF+6dt+W0Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fcfRM0zm26eWhD+khSOXG7sREq4atCG+
        XQPq3rjXRmoVs295nciaq+hKjg/n4e7fBtbWsbuExKdU0kOHyt3RaETr1xeAuwgi
        0yv7AHIojtQvMg6dB3WVhsp3OWNkWY0GD7bs9Ojb8qPbPsPmjbkbPTkDUG8ZrUb6
        dk+Ke7Z4StE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EB9E8CCC1;
        Thu,  7 Nov 2019 00:43:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F8DB8CCBD;
        Thu,  7 Nov 2019 00:43:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/1] t6024: modernize style
References: <pull.455.git.1572998303.gitgitgadget@gmail.com>
        <pull.455.v2.git.1573004049.gitgitgadget@gmail.com>
        <0aaf1799e05e1f942d0a09888c008e7e4b73a8ce.1573004049.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 14:43:25 +0900
In-Reply-To: <0aaf1799e05e1f942d0a09888c008e7e4b73a8ce.1573004049.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 06 Nov 2019
        01:34:09 +0000")
Message-ID: <xmqqsgn0qm0y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 857E21D6-0121-11EA-96D5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> No substantive changes, just a few cosmetic changes:
>   * Indent steps of an individual test
>   * Don't have logic between the "test_expect_success" blocks that
>     the next block will depend upon, move it into the
>     test_expect_success section itself
>   * Fix spacing around redirection operators to match git style
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6024-recursive-merge.sh | 130 +++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 63 deletions(-)

"git show -w" looked good.   Thanks.
