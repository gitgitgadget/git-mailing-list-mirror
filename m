Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729C6201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932882AbdEKUII (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:08:08 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35811 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932294AbdEKUIH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:08:07 -0400
Received: by mail-pf0-f174.google.com with SMTP id n23so13973928pfb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xrm0Kg088wN7yVJYlDhiaohDXdX6m2VjhsUY9Xis4Mk=;
        b=UmP8nHjyF8rNh3vDfA7nYljiNykSRjzO/R0lKh/iLtcyfXy99T8zoPTHc9NMLjaNhi
         pqtHWLop/jzoYWx/hNsGyXuBONmedr9UV3CWiayMJzPf+attWGMSTgJMHqPlpW0WLSPn
         /R3THbmn9pCmJPDylW1QSfV68R+N4NZfhzr8GkIal5Isjsf40Er6rwytaeAMQV5X19PV
         A1V2CyfKJ4t0cZBXAPRZS1c0sL1x7flGbKLTxK3GDYEJSD7FeTts2eG5RkkQSexs3gC6
         qdwpCvP9/TwUA18baKu4o7ZA/I1UM+HdSkJ2RYDUw8K0aCwmc9Va+PfUsi/HJx5HFhmq
         +seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xrm0Kg088wN7yVJYlDhiaohDXdX6m2VjhsUY9Xis4Mk=;
        b=ufjhk/VsPoSbUbOu02nOeOjSegMnQ1G3aI9VgzoI6rpMihEBCvYcIOKDZ/q4FbGmGu
         YRuijfw6Zl7KK65B7nsbiG37v00kZac9x/rV/j1MIjVsTuYkyWm2rqOy0EWXNplieQCG
         1gHCrkMmVzXpfgN+fJMr98FEz/izGYskGFkwZxo/nZgelha5ZR3wy7S1NT/P3S9wUOVT
         YaXPM3/RNSEiK5R/7eL8FUFo5YnyPT+Ms6ejnhmqSI85q3dsqFyhojfVx3C8/eR16eXQ
         QdCeiO6ot7pcrLbIUPardcV8EZCKwTZGyLIcWjHWbNMxnUtsi0ZYEql93CyZTxY0ZWfn
         qzCQ==
X-Gm-Message-State: AODbwcDLxM3qYPHGIrYy4EVuTlcT3QlHNVaqlcOxbwyCBSe/nBHnBcFI
        MSbe76n+1AIcEusK
X-Received: by 10.84.168.69 with SMTP id e63mr391395plb.124.1494533286604;
        Thu, 11 May 2017 13:08:06 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id g10sm2098904pgn.35.2017.05.11.13.08.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 13:08:05 -0700 (PDT)
Date:   Thu, 11 May 2017 13:08:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 18/29] grep: catch a missing enum in switch statement
Message-ID: <20170511200804.GF83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com>
 <20170511091829.5634-19-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511091829.5634-19-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> Add a die(...) to a default case for the switch statement selecting
> between grep pattern types under --recurse-submodules.
> 
> Normally this would be caught by -Wswitch, but the grep_pattern_type
> type is converted to int by going through parse_options(). Changing
> the argument type passed to compile_submodule_options() won't work,
> the value will just get coerced.
> 
> Thus catching this at runtime is the least worst option. This won't
> ever trigger in practice, but if a new pattern type were to be added
> this catches an otherwise silent bug during development.
> 
> See commit 0281e487fd ("grep: optionally recurse into submodules",
> 2016-12-16) for the initial addition of this code.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/grep.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 3ffb5b4e81..1c0adb30f3 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -495,6 +495,12 @@ static void compile_submodule_options(const struct grep_opt *opt,
>  		break;
>  	case GREP_PATTERN_TYPE_UNSPECIFIED:
>  		break;
> +	default:
> +		/*
> +		 * -Wswitch doesn't catch this due to casting &
> +		 * -Wswitch-default is too noisy.
> +		 */
> +		die("BUG: Added a new grep pattern type without updating switch statement");
>  	}

Thanks for adding this, as I got it wrong while developing this bit of
code.

>  
>  	for (pattern = opt->pattern_list; pattern != NULL;
> -- 
> 2.11.0
> 

-- 
Brandon Williams
