Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B199C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645F9613AA
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhESBSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 21:18:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60960 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhESBSw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 21:18:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D2D813DFA8;
        Tue, 18 May 2021 21:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=37bpClNHjaImjgihRqk3fixumvNFT3A7imj9jI
        NXs9E=; b=x4EuCCIQqwBiMqF3ck8R4+l1f7vc4D5LAm69JlG7zMt3JNiAAqjmSf
        6ILRnEomNfa2CMw/p9JYSq80S3JZVbmcCBASFK3b8KF3GpEaTWv2zV6mSf6dNQsh
        gw42Ke2j7QnMJNNmtnXpo0coEKpDnb587afBKVrUvfOGDuLduyXEg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E65613DFA7;
        Tue, 18 May 2021 21:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA3F613DFA6;
        Tue, 18 May 2021 21:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] fetch: improve grammar of "shallow roots" message
References: <20210518061855.57478-1-alexhenrie24@gmail.com>
Date:   Wed, 19 May 2021 10:17:29 +0900
In-Reply-To: <20210518061855.57478-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Tue, 18 May 2021 00:18:55 -0600")
Message-ID: <xmqq7djv1pzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB84018A-B83F-11EB-AAFF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/fetch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This and the other one on setup.c both look good changes, but it's
not like these messages are new breakages in the upcoming release
whose -rc0 has already been tagged and call for help to translators
has been issued, on which presumably translators are already
working.

So please hold onto these patches until final; I might pick them up
and keep them in 'seen' but I may not, and I do not want to see them
lost.

Thanks.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 97c4fe6e6d..c19a041526 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1123,7 +1123,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  
>  			if (rm->status == REF_STATUS_REJECT_SHALLOW) {
>  				if (want_status == FETCH_HEAD_MERGE)
> -					warning(_("reject %s because shallow roots are not allowed to be updated"),
> +					warning(_("rejected %s because shallow roots are not allowed to be updated"),
>  						rm->peer_ref ? rm->peer_ref->name : rm->name);
>  				continue;
>  			}
