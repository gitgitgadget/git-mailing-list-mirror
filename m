Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7E31F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934267AbcJERrB (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:47:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53690 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933241AbcJERqU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:46:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 997D044A29;
        Wed,  5 Oct 2016 13:46:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fvt9ijMkR1qHETDf7LCqUpowwrU=; b=VvMk/g
        YPNWjPYT0USk8RIMA5TlVUknKxcbRYs1VOgydUu/ay/wMai9s8geDVgaLblzo0MH
        Tk1VeYxb/uhPxOHvLUMig6mD32KVJOWX6hkD6i1UdhUmoPER7/Kozuy3R8Cnoelp
        FmCZCyXc/0duhBTm8h7GpmVhCjhC5/FfclJBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PBxkYSjMKTC72PAfrtPHbE4A/hgt1VFZ
        wYj7uEHMkYsTqvoGITR2ClbEX4AX7S/+O79gKT26pIlnoYuUxcTmF3NTzCClRqg5
        Dr42078ZTe2FWUmrNZlpMOaIhBtLnWkW4Bj82PLhw5xTNk/4DJ3kaZkRJBfh+L5W
        l1t2wrmpejk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 928ED44A28;
        Wed,  5 Oct 2016 13:46:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13C2F44A27;
        Wed,  5 Oct 2016 13:46:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     sorganov@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] git-merge: clarify "usage" by adding "-m <msg>"
References: <cover.1475678515.git.sorganov@gmail.com>
        <773a11751c91c31a05c967ade902b0c8279aab56.1475678515.git.sorganov@gmail.com>
Date:   Wed, 05 Oct 2016 10:46:16 -0700
In-Reply-To: <773a11751c91c31a05c967ade902b0c8279aab56.1475678515.git.sorganov@gmail.com>
        (sorganov@gmail.com's message of "Wed, 5 Oct 2016 17:46:19 +0300")
Message-ID: <xmqqint6pu3b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E83BF28-8B23-11E6-8D7B-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sorganov@gmail.com writes:

> From: Sergey Organov <sorganov@gmail.com>
>
> "-m <msg>" is one of essential distinctions between obsolete
> invocation form and the recent one. Add it to the "usage" returned by
> 'git merge -h' for more clarity.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  builtin/merge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index a8b57c7..0e367ba 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -43,7 +43,7 @@ struct strategy {
>  };
>  
>  static const char * const builtin_merge_usage[] = {
> -	N_("git merge [<options>] [<commit>...]"),
> +	N_("git merge [<options>] [-m <msg>] [<commit>...]"),
>  	N_("git merge [<options>] <msg> HEAD <commit>"),
>  	N_("git merge --abort"),
>  	NULL

While this is not wrong per-se, as the deprecated form will go away
soon, I hope you do not mind if I had to drop this one from the
series to avoid merge conflicts to 'pu' (I do not know how bad the
conflict would be yet; I am just reviewing in my MUA).

