Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034EC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 23:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9468620772
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 23:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iTvcjqKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgHRX53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:57:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55077 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgHRX52 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 19:57:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04BFBE792C;
        Tue, 18 Aug 2020 19:57:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8EX7hmLTNz9kVb+I8LZOIJW8wZM=; b=iTvcjq
        KFgrZnpgciFxtpAQHpTibVZg8xJdXVh3t40Xt2yqvyp8BG/D0uiLVUvIsZD8Cyz3
        OC/sLy4aiqth6LkBPJxhoPnpsJKzjPsdVqzj4OBSEdwpB0m+lchrwGIhRHlH/3Od
        co/Uhyybq8Nu19buuOpqsK93koRsS4mCuXPTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WJfudW7ArKulO1o76r8aDSt4xnS8m7SL
        NyQLYCUo6ouzYDFcuBQnRJ+mep2R51O71ANdErZDxU96KIDwh+CwCtXKfuA9PAiE
        b869IHkjLvHyMEbsz7VDserH7NCOVZcIlRH0P9Q28uMCWSvcTqzcZiwdYo7mrGT7
        4n0w14iX/iY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1B94E792B;
        Tue, 18 Aug 2020 19:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4A00DE792A;
        Tue, 18 Aug 2020 19:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fixup! promisor-remote: lazy-fetch objects in subprocess
References: <xmqqk0xvwpob.fsf@gitster.c.googlers.com>
        <20200818233630.2829739-1-jonathantanmy@google.com>
Date:   Tue, 18 Aug 2020 16:57:22 -0700
In-Reply-To: <20200818233630.2829739-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 18 Aug 2020 16:36:30 -0700")
Message-ID: <xmqq7dtvwlr1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FE8CFFE-E1AE-11EA-9E10-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> ---
> Ah, sorry about that - here's a fixup. I forgot to switch the name of
> the negotiator in the patch (and also because of the change to a "fetch"
> subprocess, the trace is reported as "fetch>", not "git>").

Excellent.  Thanks for a quick update.

>
>  promisor-remote.c      | 2 +-
>  t/t5300-pack-object.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 56d6d4d821..6530e26f98 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -23,7 +23,7 @@ static int fetch_objects(const char *remote_name,
>  
>  	child.git_cmd = 1;
>  	child.in = -1;
> -	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=null",
> +	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
>  		     "fetch", remote_name, "--no-tags",
>  		     "--no-write-fetch-head", "--recurse-submodules=no",
>  		     "--filter=blob:none", "--stdin", NULL);
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 3d6a93343a..392201cabd 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -528,7 +528,7 @@ test_expect_success 'prefetch objects' '
>  	TWO=$(git -C server rev-parse three_branch^) &&
>  	git -C client fetch --filter=blob:none origin "$TWO" &&
>  	GIT_TRACE_PACKET=$(pwd)/trace git -C client push origin "$TWO":refs/heads/two_branch &&
> -	grep "git> done" trace >donelines &&
> +	grep "fetch> done" trace >donelines &&
>  	test_line_count = 1 donelines
>  '
