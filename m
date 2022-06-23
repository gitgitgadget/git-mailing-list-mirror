Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2675C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 17:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiFWRlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiFWRj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 13:39:59 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F370E973F6
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 10:09:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B467C13D27A;
        Thu, 23 Jun 2022 13:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z18XC4ZOQYRfxUP7gRPS3hQFGOQFm7XqssnL5R
        xYLWQ=; b=S40TSl46MtbPZSBM4GfaPPTRfSRkdBXxHuJEQUPxLJysCXjvSyHRfo
        Py3u5hdX5sN9x+eDmLE0+2GTzthjzDD9xtq21ReD6OVHLlY3k8KlR2LJox8Pflfl
        yy55/psNBO8R99rtOLtVK2Mdi2cr5Y/0l6g8+HRduMjKOClbspVlQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC47313D279;
        Thu, 23 Jun 2022 13:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1511213D278;
        Thu, 23 Jun 2022 13:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH] ls-files: update test style
References: <pull.1269.git.1655974015414.gitgitgadget@gmail.com>
Date:   Thu, 23 Jun 2022 10:09:48 -0700
In-Reply-To: <pull.1269.git.1655974015414.gitgitgadget@gmail.com> (Li Linchao
        via GitGitGadget's message of "Thu, 23 Jun 2022 08:46:55 +0000")
Message-ID: <xmqq5ykr1f37.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A7B1FC2-F317-11EC-8B94-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/README b/t/README
> index 309a31133c6..70205fba41b 100644
> --- a/t/README
> +++ b/t/README
> @@ -560,6 +560,21 @@ Here are the "do's:"
>     Even code that isn't a test per se, but merely some setup code
>     should be inside a test assertion.
>  
> + - Keep test title the same line with test helper function itself,
> +   and end the line with a single quote.
> +
> +   Take test_expect_success helper for example, write it like:
> +
> +  test_expect_success 'test title to describe this test case' '
> +  # test body
> +  '

If you want to show the pretty layout, then the test body should
be shown indented, i.e.

	test_expect_success 'title' '
		... test body ...
	'

But I am not sure if this belongs to the existing "Do's and don'ts"
section, which lists tips that matter for correctness.

This new one certainly encouraged as a more modern style, but is not
about correctness at all.

A separate "recommended style" section might make sense, but there
will be a lot more entries, like when to quote and not to quote EOF
marker for here-document, indenting the body of here-document, etc.
