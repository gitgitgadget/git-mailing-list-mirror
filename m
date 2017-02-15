Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F452013A
	for <e@80x24.org>; Wed, 15 Feb 2017 18:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbdBOS3Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 13:29:24 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34451 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdBOS3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 13:29:24 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so11771223pgv.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 10:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W5jEiKWaQfWZWnIJLBOklBJRsvISZFoMs83BS6j5zcI=;
        b=fxDWMMlGcfXpysSnyj2G1fGzwdfPvHxlJiOKDl4w0xyccgPKOHcJAAgaQPaGOkHmLe
         ivhoOo9ayjD0BXcHM7O4iSH2IaQXCxDmOCWagj7O3+AkfHr4OR6bG2/irm5QrIlXLeee
         mV2HJA0WbZO0K2EInCIKVuIgkdM6WyImYNkwLcMfWo5OGghnYaUaRf3B6mSNZy8eKXP4
         B8qomT4w00NoGOj2uA+Tgc7gipw70Bkowi+c2k9ufI/REN0SQEwHyJoC+xpZJpmP8Fsu
         o9SxkWIx5OXv3p3j7qNSaq4VnlDNzAxSzEl5VRd67r21osAKqfaF4UPjcfAtGnWQKC3h
         4RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W5jEiKWaQfWZWnIJLBOklBJRsvISZFoMs83BS6j5zcI=;
        b=l0ocS5clPR0IOyNkZL+MRDk8Fgf65ADROBGTmpt06iuKueQUXXp07dpbpg++Rigzas
         ppoQZVnCFBEXyxyEPw+KWhRH5J2jnUZRJ4+aIirHWy6pcQU55xNtwMm7o9HTU1WrA359
         p4vGDDWlwKWajZkKjHwS4sc33x+L12cSNBoYkeI+AQ2IaCjsfKZUptOynMT/Q+MXhbC2
         gdNmNEE9rizPnQTr77tYHPhtDUB8uqXIPpaU7SGYSctjGp26aHFMqERI0VEAfi8oG0nI
         slN4BAhbC/qILRRTYBtt86V2zocc7KcDAnK+dhAeLoAXRpfXrDWEEVJuu5nAtGxH6+8p
         Cq3A==
X-Gm-Message-State: AMke39mEpBq5Z8xs8MebLjVn01/aSZiCUGlHq1KLGsynELKH12Tvtlbgeal2UDnjTsmOnw==
X-Received: by 10.84.224.11 with SMTP id r11mr16915197plj.130.1487183363239;
        Wed, 15 Feb 2017 10:29:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id v9sm8830725pfl.102.2017.02.15.10.29.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 10:29:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     unlisted-recipients:; (no To-header on input) git@vger.kernel.org,
        bmwill@google.com, jrnieder@gmail.com, sandals@crustytoothpaste.net
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)git@vger.kernel.org
                                                                     ^-missing end of address
Subject: Re: [PATCH 05/14] update submodules: add submodule config parsing
References: <20170215003423.20245-1-sbeller@google.com>
        <20170215003423.20245-6-sbeller@google.com>
Date:   Wed, 15 Feb 2017 10:29:21 -0800
In-Reply-To: <20170215003423.20245-6-sbeller@google.com> (Stefan Beller's
        message of "Tue, 14 Feb 2017 16:34:14 -0800")
Message-ID: <xmqqd1ej48am.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Similar to b33a15b08 (push: add recurseSubmodules config option,
> 2015-11-17) and 027771fcb1 (submodule: allow erroneous values for the
> fetchRecurseSubmodules option, 2015-08-17), we add submodule-config code
> that is later used to parse whether we are interested in updating
> submodules.
>
> We need the `die_on_error` parameter to be able to call this parsing
> function for the config file as well, which if incorrect lets Git die.
>
> As we're just touching the header file, also mark all functions extern.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 22 ++++++++++++++++++++++
>  submodule-config.h | 17 +++++++++--------
>  2 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 93453909cf..93f01c4378 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -234,6 +234,28 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
>  	return parse_fetch_recurse(opt, arg, 1);
>  }
>  
> +static int parse_update_recurse(const char *opt, const char *arg,
> +				int die_on_error)
> +{
> +	switch (git_config_maybe_bool(opt, arg)) {
> +	case 1:
> +		return RECURSE_SUBMODULES_ON;
> +	case 0:
> +		return RECURSE_SUBMODULES_OFF;
> +	default:
> +		if (!strcmp(arg, "checkout"))
> +			return RECURSE_SUBMODULES_ON;
> +		if (die_on_error)
> +			die("bad %s argument: %s", opt, arg);
> +		return RECURSE_SUBMODULES_ERROR;
> +	}
> +}

Proliferation of similarly looking config parser made me briefly
wonder if they can somehow be shared, but I think it is correct to
view that update/fetch/push have conceptually different set of
allowed modes, whose names happen to overlap, so keeping them
separate like this patch does (and its predecessors did to take us
into the shape of the current code) makes sense, at least to me.

