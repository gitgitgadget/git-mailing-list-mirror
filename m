Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFFDC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D02820829
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="agxRbOG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMSWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:22:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55593 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 14:22:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CE3FDD052;
        Thu, 13 Aug 2020 14:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kVGk6t9Vaehfb3C9floya+FcwME=; b=agxRbO
        G74mNL6jgmykn07pBjk8DR+Xa6h8n9Xb8xYv6ZsflfgUEuOgXr6+40Ylo4j1fCvA
        ZX39VIeepyS+x8sm7I/LQkx5NEMM4OVaPZ+OqHMa1jBe0ec40ROKjlUexm7/asxZ
        18OuyV9g3qMt0jxJKfdMCJFWvC3N7QrMxIDyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M9s4ICETNMu5cyfuIUATPACd6X5t089t
        5oRQkSD2WZHHbJXMQJBIPs2+ITnvfgesqyFhphuv7NiJ84HiyC+FA+Z1mjmkNBJp
        35l3j6DLbEqTYbwyTLyaRuzWO9MJBzaQsCzQSypO+IZxLEQSdr1YhnZouuWAwCH4
        L9TAwX9unB0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44B62DD051;
        Thu, 13 Aug 2020 14:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86628DD050;
        Thu, 13 Aug 2020 14:22:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 0/2] Improve and test Fortran xfuncname regex
References: <pull.700.git.1597271429.gitgitgadget@gmail.com>
Date:   Thu, 13 Aug 2020 11:22:09 -0700
In-Reply-To: <pull.700.git.1597271429.gitgitgadget@gmail.com> (Philippe Blain
        via GitGitGadget's message of "Wed, 12 Aug 2020 22:30:27 +0000")
Message-ID: <xmqqeeoa2ypa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7B57050-DD91-11EA-BED1-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series adds tests for the Fortran xfuncname regex and fixes a
> shortcoming of the regex.

Will queue.  Thanks.

>
> Philippe Blain (2):
>   userdiff: add tests for Fortran xfuncname regex
>   userdiff: improve Fortran xfuncname regex
>
>  t/t4018/fortran-block-data          |  5 +++++
>  t/t4018/fortran-comment             | 13 +++++++++++++
>  t/t4018/fortran-comment-keyword     | 14 ++++++++++++++
>  t/t4018/fortran-comment-legacy      | 13 +++++++++++++
>  t/t4018/fortran-comment-legacy-star | 13 +++++++++++++
>  t/t4018/fortran-external-function   |  9 +++++++++
>  t/t4018/fortran-external-subroutine |  5 +++++
>  t/t4018/fortran-module              |  5 +++++
>  t/t4018/fortran-module-procedure    | 13 +++++++++++++
>  t/t4018/fortran-program             |  5 +++++
>  userdiff.c                          |  6 +++++-
>  11 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4018/fortran-block-data
>  create mode 100644 t/t4018/fortran-comment
>  create mode 100644 t/t4018/fortran-comment-keyword
>  create mode 100644 t/t4018/fortran-comment-legacy
>  create mode 100644 t/t4018/fortran-comment-legacy-star
>  create mode 100644 t/t4018/fortran-external-function
>  create mode 100644 t/t4018/fortran-external-subroutine
>  create mode 100644 t/t4018/fortran-module
>  create mode 100644 t/t4018/fortran-module-procedure
>  create mode 100644 t/t4018/fortran-program
>
>
> base-commit: 4f0a8be78499454eac3985b6e7e144b8376ab0a5
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-700%2Fphil-blain%2Ffortran-better-userdiff-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-700/phil-blain/fortran-better-userdiff-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/700
