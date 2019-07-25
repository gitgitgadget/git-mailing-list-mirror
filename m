Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8515F1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 16:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbfGYQYI (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 12:24:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56299 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390476AbfGYQYG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 12:24:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB9576C4CC;
        Thu, 25 Jul 2019 12:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BkmEhjfbkLEJbyY1pHC+TrHrHH4=; b=uE2R9b
        V2u/8zM1kDUa/ia+hdeEz21cxVwiEeWWr+2uZVt52O1oDBUUigzvGIIepbZiTTWu
        zKOYOSr79ZhtfH36uMvgaU/3Qikg5ofHfj3gt7vTzdPu5mjscf15Q6udICRZXgud
        5S7GNyZgexelZOkE2QeFha6T+7Y9gpj6e+fWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i9gwFJIk0d0kF89V2vwY2REpJRB3k1a+
        DVi4Ld0K1BtbTFPwczxpojJLJbZ65zyruatqLX6mBngym//aV6AxU3/8liVvgkyZ
        /1nhdUFIM3iZqZzICLCvmZQTqDD+c6TufpWuyxIlq2MW/FglJWd4sUDltzFJoQqu
        Mr7fb0yLSaE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3D986C4CB;
        Thu, 25 Jul 2019 12:24:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE3146C4C8;
        Thu, 25 Jul 2019 12:24:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] t3422: mark two test cases as requiring support for `--preserve-merges`
References: <pull.296.git.gitgitgadget@gmail.com>
        <ed41e8d7abc93603063e9a99f628548608413d34.1564046191.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Jul 2019 09:23:57 -0700
In-Reply-To: <ed41e8d7abc93603063e9a99f628548608413d34.1564046191.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 25 Jul 2019
        02:16:33 -0700 (PDT)")
Message-ID: <xmqq8ssmqe02.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C51D1EE-AEF8-11E9-8551-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We started marking all of those test cases that require `git rebase -p`
> to work in the recent past, to allow for skipping them (because the
> `--preserve-merges` backend is already deprecated and will be removed in
> one of the next major versions, so it is a bit pointless to test its
> functionality all the time).
>
> This patch marks two previously forgotten test cases with the `REBASE_P`
> prerequisite, to allow skipping them via setting the environment
> variable `GIT_TEST_SKIP_REBASE_P`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3422-rebase-incompatible-options.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.


>
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index bb78a6ec86..eb5cb67b06 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -65,12 +65,12 @@ test_rebase_am_only --ignore-whitespace
>  test_rebase_am_only --committer-date-is-author-date
>  test_rebase_am_only -C4
>  
> -test_expect_success '--preserve-merges incompatible with --signoff' '
> +test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
>  	git checkout B^0 &&
>  	test_must_fail git rebase --preserve-merges --signoff A
>  '
>  
> -test_expect_success '--preserve-merges incompatible with --rebase-merges' '
> +test_expect_success REBASE_P '--preserve-merges incompatible with --rebase-merges' '
>  	git checkout B^0 &&
>  	test_must_fail git rebase --preserve-merges --rebase-merges A
>  '
