Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20520C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 19:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE86220838
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 19:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DkY4aiQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHNTDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:03:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56521 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHNTDB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 15:03:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3A86E9662;
        Fri, 14 Aug 2020 15:02:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dIPuNxfU1KkrOrhaKS30ZIC3+a8=; b=DkY4ai
        QSXnUxF7Gx4p1ULAVamQEe/kXO503Y29l4ut6wtLL82CxzRKhsQlKwFixG77OVm4
        om9BS3+CVcONWbVAzk2DzZ+uD3dokHBwx2n/WpyOcS7S/RwnukLp9dqF8dkgDzjS
        P15va7oaPJz2eQTZ0r+JVIXNU+uhv+fulk0aU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FyA8rj8KxiI+AOS03vHZZQlP4zlce0ex
        uzU90ns1ZgnClGwRceA/9f0DrDIZsnQnAxiHnpxJO6pmDWCE/gf0tzSnY1CTVpN1
        fQa+3THn4/5XTeNWNq0u9No5y1XU5YOd27fDucpI7g8HYvJ8lmZAqTHDVoDVft3j
        8rNO369XfiM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB70DE9661;
        Fri, 14 Aug 2020 15:02:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0CD8EE9660;
        Fri, 14 Aug 2020 15:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] t/README: document GIT_TEST_DEFAULT_HASH
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
        <242a44b63c8fc0ab7e8d8a6a913fde71444f931d.1597428440.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 12:02:55 -0700
In-Reply-To: <242a44b63c8fc0ab7e8d8a6a913fde71444f931d.1597428440.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 14 Aug 2020
        18:07:18 +0000")
Message-ID: <xmqqtux5vyn4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3C1CF02-DE60-11EA-AE8A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/README | 3 +++
>  1 file changed, 3 insertions(+)

Very helpful.  Will queue.

>
> diff --git a/t/README b/t/README
> index 70ec61cf88..ecf8c7291d 100644
> --- a/t/README
> +++ b/t/README
> @@ -421,6 +421,9 @@ GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
>  the default when running tests), errors out when an abbreviated option
>  is used.
>  
> +GIT_TEST_DEFAULT_HASH=<sha1|sha256> specifies which hash algorithm to use
> +in the test scripts.
> +
>  Naming Tests
>  ------------
