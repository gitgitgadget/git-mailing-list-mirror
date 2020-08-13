Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A72C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1059F204EC
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kgEaE9Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHMSVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:21:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52032 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 14:21:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A31C764CC;
        Thu, 13 Aug 2020 14:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EgOoaGEvuHP5LtRoLjsp8egD6mg=; b=kgEaE9
        VjvIJUYdeUr7tqIBWCumyZUBZM06TDfMlmJBvg/AUhVc1MEEbY6Zaro4bD8rhUKt
        b3kork9WKAidyvuiVf2Jz93tX50QBDxSeljURCk6BVFbcWU6DTa26lkZPYBzfzc/
        8Ji0k3UTam7He79G+Ej9Oyxs95Q/CIy/MogEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XZL2XvLxJQFknlwc7eGJ/ayekEg25XnX
        8cnI18VQCulGPO0Wwga6djzXXGxkSL0fs/bk3jmfmZOhHwP52mCVa95BqZV+AMPr
        p4yKFBY+A6nv4ZBGOTQN+LSc3iSRtxpQ04mH8m1oEXVBpZz0AiGuObkJqtX4lRqf
        8pZ/1Tfmjlc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92493764CB;
        Thu, 13 Aug 2020 14:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F906764C9;
        Thu, 13 Aug 2020 14:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>,
        Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] fetch, pull doc: correct description of '--set-upstream'
References: <pull.701.git.1597276320563.gitgitgadget@gmail.com>
Date:   Thu, 13 Aug 2020 11:20:58 -0700
In-Reply-To: <pull.701.git.1597276320563.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Wed, 12 Aug 2020 23:52:00 +0000")
Message-ID: <xmqqimdm2yr9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC81BF92-DD91-11EA-ADFC-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -186,7 +186,7 @@ ifndef::git-pull[]
>  endif::git-pull[]
>  
>  --set-upstream::
> -	If the remote is fetched successfully, pull and add upstream
> +	If the remote is fetched successfully, add upstream
>  	(tracking) reference, used by argument-less

Makes sense.  Will queue.  Thanks.

>  	linkgit:git-pull[1] and other commands. For more information,
>  	see `branch.<name>.merge` and `branch.<name>.remote` in
>
> base-commit: 7814e8a05a59c0cf5fb186661d1551c75d1299b5
