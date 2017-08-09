Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F6320899
	for <e@80x24.org>; Wed,  9 Aug 2017 05:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbdHIFpf (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 01:45:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61507 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750770AbdHIFpe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 01:45:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B062A0785;
        Wed,  9 Aug 2017 01:45:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sxp6cnR759Bqv9EpsaHdTOvpgko=; b=wMKR75
        +IhJmXWmTloaH3KZ7KFmu/EfTK57LMU3sB0AOH+K13pFFJANN/TGYGy4o8fdkM86
        PcQ9R9FTkyFLzb4dZcC8NHBRUU5phLmM4gP4lOD6BPpQ2JC3eWfCoa/BmPkWm72+
        zBv9++winI0YtXktMl6Uq53xIWfArKG3OEtAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZY37f1SlWfR1q/NKajDqzf/GdI2eSb8N
        aL/U0Kkxt6owGOjD2rsxBH7u5zNr2p6RLGsN01pV5F8vy2rzh5DjIQKTTQIYc2Sm
        57yeYnC658sdAvmCb+XRfyytN3bcRxY9ttnsOXboyASCGGtKqldI0RnNl3JdoJtw
        OSW+VmB+ANM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02508A0784;
        Wed,  9 Aug 2017 01:45:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43A5EA0783;
        Wed,  9 Aug 2017 01:45:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/add: add detail to a 'cannot chmod' error message
References: <aa004526-3e0d-66d4-287f-30abd29758fc@ramsayjones.plus.com>
Date:   Tue, 08 Aug 2017 22:45:32 -0700
In-Reply-To: <aa004526-3e0d-66d4-287f-30abd29758fc@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 9 Aug 2017 01:51:23 +0100")
Message-ID: <xmqqd1858fb7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5D63CD0-7CC5-11E7-81DE-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> In addition to adding the missing newline, add the x-ecutable bit
> 'mode change' character to the error message. This message now has
> the same form as similar messages output by 'update-index'.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> This is v2 of the earlier "add a newline" patch. Thanks!

Thanks; here is me reminding myself to apply this with Jonathan's
reviewed-by in the morning.

>
> ATB,
> Ramsay Jones
>
>  builtin/add.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index e888fb8c5..5d5773d5c 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -32,7 +32,7 @@ struct update_callback_data {
>  	int add_errors;
>  };
>  
> -static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
> +static void chmod_pathspec(struct pathspec *pathspec, char flip)
>  {
>  	int i;
>  
> @@ -42,8 +42,8 @@ static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
>  		if (pathspec && !ce_path_match(ce, pathspec, NULL))
>  			continue;
>  
> -		if (chmod_cache_entry(ce, force_mode) < 0)
> -			fprintf(stderr, "cannot chmod '%s'", ce->name);
> +		if (chmod_cache_entry(ce, flip) < 0)
> +			fprintf(stderr, "cannot chmod %cx '%s'\n", flip, ce->name);
>  	}
>  }
