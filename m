Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAE3C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931F561263
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFHF0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 01:26:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64152 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFHF03 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 01:26:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53C08C5432;
        Tue,  8 Jun 2021 01:24:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3605GRUj6lPUkBkw9aG+OWOX/Nxt2ejmBSvyN+
        9SLfI=; b=jB5wajvyG6YpBzzIdum0kOTGUQ6S3cWe7uBCR1k/9BhOQRU5zxs3Yz
        qk1wt5bB+bu7ejtlJrFvl40UdgXdDkUA0b51neZn0Msra9p2EWQLxGAgBgQvM17Q
        cvM399kZx/h0lQBbsnmvKu0I0hAUK2MRyuXJSt+LOlA5/G9bk38MM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A657C5431;
        Tue,  8 Jun 2021 01:24:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B3ACC5430;
        Tue,  8 Jun 2021 01:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: merge: mention default of defaulttoupstream
References: <20210608015807.906101-1-felipe.contreras@gmail.com>
Date:   Tue, 08 Jun 2021 14:24:35 +0900
In-Reply-To: <20210608015807.906101-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Mon, 7 Jun 2021 20:58:07 -0500")
Message-ID: <xmqqy2blorn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0B77ED4-C819-11EB-8BE7-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Commit a01f7f2ba0 (merge: enable defaulttoupstream by default,
> 2014-04-20) forgot to mention the new default in the configuration
> documentation.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/config/merge.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
> index cb2ed58907..6b66c83eab 100644
> --- a/Documentation/config/merge.txt
> +++ b/Documentation/config/merge.txt
> @@ -14,7 +14,7 @@ merge.defaultToUpstream::
>  	branches at the remote named by `branch.<current branch>.remote`
>  	are consulted, and then they are mapped via `remote.<remote>.fetch`
>  	to their corresponding remote-tracking branches, and the tips of
> -	these tracking branches are merged.
> +	these tracking branches are merged. Defaults to true.

That's definititely an improvement.

Will queue.

By the way, is the convoluted description around remote-tracking
branches still understandable to those who often work on a branch
forked from another local branch, or would readers be helped if we
had a two separate descriptions (one forking from remote and the
other forking locally)?  This is a side question as the answer does
not change the validity of this patch at all.

Thanks.
