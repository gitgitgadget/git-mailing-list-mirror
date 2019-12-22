Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFA6C2D0C3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 00:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86880206B7
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 00:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SUxeqFZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLVAMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 19:12:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55655 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLVAMG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 19:12:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69C65AAF44;
        Sat, 21 Dec 2019 19:12:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SFq1/mQr0IOAkuufsMDTFusWFpE=; b=SUxeqF
        ZiH4rCH0dUQlQG/eVYUDvG2yPCyhF8YpBR53erByVZtfRzI01FTIgJ4GeNMdWg7E
        jLnq7LMG31iBKqIP2Lg21AqGlVp+Vj/e9B2SLKLc6wHQbvQAjLiHW2roC76bdHCy
        09sVPzLajT5XhxYdUYDH5gZuAPDXnB9VH0Gmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PK4XxpQwM7x7nAC+dTkXe5DmVuqMUhOu
        ljWZgo/JtDRaq+lQ9PrDcJATdX8yozZ7RFBIFh/XrEJ88S4JYIuwl0yCKkBxBg4H
        J83vxVQJU/H6PjEba/IaK+36PEY0UVN6zWidj0Uq1Jq1s6h7qRUJegYKlwAT+uty
        d1zeXc7YsrI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6124FAAF43;
        Sat, 21 Dec 2019 19:12:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 87D2EAAF41;
        Sat, 21 Dec 2019 19:12:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 9/9] ci: include the built-in `git add -i` in the `linux-gcc` job
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <9719604a1fb6ec4cf1b1297875cae86c076c9cdd.1576968120.git.gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 16:11:59 -0800
In-Reply-To: <9719604a1fb6ec4cf1b1297875cae86c076c9cdd.1576968120.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sat, 21 Dec 2019
        22:42:00 +0000")
Message-ID: <xmqq5zi96wxc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD3CEE4A-244F-11EA-9F2E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This job runs the test suite twice, once in regular mode, and once with
> a whole slew of `GIT_TEST_*` variables set.
>
> Now that the built-in version of `git add --interactive` is
> feature-complete, let's also throw `GIT_TEST_MULTI_PACK_INDEX` into that

Huh?

> fray.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/run-build-and-tests.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index ff0ef7f08e..4df54c4efe 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -20,6 +20,7 @@ linux-gcc)
>  	export GIT_TEST_OE_DELTA_SIZE=5
>  	export GIT_TEST_COMMIT_GRAPH=1
>  	export GIT_TEST_MULTI_PACK_INDEX=1
> +	export GIT_TEST_ADD_I_USE_BUILTIN=1
>  	make test
>  	;;
>  linux-gcc-4.8)
