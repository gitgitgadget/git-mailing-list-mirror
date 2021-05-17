Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48DFC433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BA961209
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhEQG5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 02:57:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63605 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhEQG5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 02:57:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67C15C13DE;
        Mon, 17 May 2021 02:56:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rQWr8fFqsS4p/2qLeKSGrC07FrRAwldU1GRnE9i8+TA=; b=ZFqV
        fHY+qeft8LgR9UnDrUp+CyV+AbWW4eS4pEt2U9G6OPJDGwWF7QnfL1RNYqfcRMNh
        +yxzknQsGQ5KwXC954LzYfdAHMvnUoY4eyeNzJKL5u8N9mHEHkvrugmO0/9ZOdJa
        JrdcwqAIFpLPCVryNctKhij9Nomw2bsB7fJvnSI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4813CC13DD;
        Mon, 17 May 2021 02:56:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C3A7C13DC;
        Mon, 17 May 2021 02:56:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, pc44800@gmail.com, chriscool@tuxfamily.org,
        stefanbeller@gmail.com, kaartic.sivaraam@gmail.com,
        Johannes.Schindelin@gmx.de, shouryashukla.oo@gmail.com
Subject: Re: [PATCH] submodule: use the imperative mood to describe the
 --files option
References: <20210516215957.33341-1-alexhenrie24@gmail.com>
Date:   Mon, 17 May 2021 15:56:02 +0900
Message-ID: <xmqqmtst3l31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F21F2926-B6DC-11EB-8D43-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/submodule--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d55f6262e9..ae6174ab05 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1300,7 +1300,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "cached", &cached,
>  			 N_("use the commit stored in the index instead of the submodule HEAD")),
>  		OPT_BOOL(0, "files", &files,
> -			 N_("to compare the commit in the index with that in the submodule HEAD")),
> +			 N_("compare the commit in the index with that in the submodule HEAD")),
>  		OPT_BOOL(0, "for-status", &for_status,
>  			 N_("skip submodules with 'ignore_config' value set to 'all'")),
>  		OPT_INTEGER('n', "summary-limit", &summary_limit,

Unlike many other helper functions in this file, this one is likely
to survive when the remainder of "git submodule" scripted Porcelain
is rewritten in C, so it is a good idea to update it with this
patch.

Thanks, will queue.
