Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1847320401
	for <e@80x24.org>; Tue, 13 Jun 2017 00:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbdFMAth (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 20:49:37 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34529 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbdFMAt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 20:49:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id v14so15808340pgn.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 17:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQ+IMrEqNiDulmaslqksl69puRViptwuWqqomHiFcHA=;
        b=lDRzbboZZbgt3Oe8z349WZEamjEJRb3PExh7PssTOR2AaPmCR77odp10GEgfHwxaLW
         ZNMGfC2x1aPueLW1uxks7UceuKG+JG3q5kMgnBv/NiYaoTjLWRQhz7vJqWHNYMkvqevn
         d1CqcC5jyG3xdeTXeTH/ao7IhR5E6fjQnYC5im+TtA+48rPl0G74ZQuLxx9jROCzrIms
         NUQVBrWw5y4X4VQh71edhhcgD6Q+WNh87VtdFKxpxhRhrkCH5KmqJ3XDNSprcRn/eXVF
         Rz8makwIFDjmaJCOq6g5c5g/+lxZJ0i3Jyn8LeOEGi8/buQWzyO81nIm3Q0XkqVO1pgR
         mi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQ+IMrEqNiDulmaslqksl69puRViptwuWqqomHiFcHA=;
        b=mrDExRB0yhs5qCT6V+tbMwo8wUEGoKZsPwprZ92wpivub+CuxN7+h6JjlZr16n8aT0
         s6HJLkzlvkV/9jh6S2o7XEpi5L4ydLPt0dI+GY8AZn/ktI07ElJcHb6sS29NXXyNURoT
         TTu2srsbELyr8sn9n+bRMLbkn++e9eXBS3E3IXhcwMWSwe66QNLE6fGO7D5BlaHIapj/
         MPJWfwK1nXWW3coLcCdLZ3nIZAog0sakg52JuKyeHHgsGyZm3APezkzzqNLatCZnWa/T
         kVdR6ndMUBvpM7rotybM4U7BeqXtYehQxfpAYB6qivI3jrV1J3jI2LOZPGal81DyyAqm
         Tgsw==
X-Gm-Message-State: AKS2vOyGDh48Mt97BQRAqCBWCLnabjzvhogoD/sxiukf8Jio/Oikx1LW
        VnHIo7KrBKepCw==
X-Received: by 10.99.113.65 with SMTP id b1mr552763pgn.275.1497314967515;
        Mon, 12 Jun 2017 17:49:27 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:e453:89d5:deb:c7b6])
        by smtp.gmail.com with ESMTPSA id z13sm22795169pfk.99.2017.06.12.17.49.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 17:49:25 -0700 (PDT)
Date:   Mon, 12 Jun 2017 17:49:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 2/4] config: remove git_config_iter
Message-ID: <20170613004911.GA133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-3-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170612213406.83247-3-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+tanayabh)
Hi,

Brandon Williams wrote:

> Since there is no implementation of the function 'git_config_iter' lets
> stop exporting it and remove the prototype from config.h.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  config.h | 1 -
>  1 file changed, 1 deletion(-)

Good eyes.  Looks like the function never existed.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> diff --git a/config.h b/config.h
> index f7f8b66c5..c70599bd5 100644
> --- a/config.h
> +++ b/config.h
> @@ -165,7 +165,6 @@ extern int git_configset_get_pathname(struct config_set *cs, const char *key, co
>  extern int git_config_get_value(const char *key, const char **value);
>  extern const struct string_list *git_config_get_value_multi(const char *key);
>  extern void git_config_clear(void);
> -extern void git_config_iter(config_fn_t fn, void *data);
>  extern int git_config_get_string_const(const char *key, const char **dest);
>  extern int git_config_get_string(const char *key, char **dest);
>  extern int git_config_get_int(const char *key, int *dest);
