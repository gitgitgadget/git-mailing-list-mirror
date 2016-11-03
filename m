Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9592021E
	for <e@80x24.org>; Thu,  3 Nov 2016 18:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760027AbcKCST6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 14:19:58 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32931 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759995AbcKCST5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 14:19:57 -0400
Received: by mail-pf0-f177.google.com with SMTP id d2so35767088pfd.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bb2wISS/xLdNZd0DMvsAff3APmVqJv/gmHexaPxY2ws=;
        b=kZLrp8B47lOmgNByWQpLsEIvQndl3jhZsSI5Auj3uxLnU06M6FVxxgMfwReAPcs/t4
         jBZDI1c63nmPS2XP1bSXzKd+QseLoVZ1RoFQR0y6BOFv2qZi1EsIeRMzWXOGAOzrEXwu
         swKt4HuAialeuWIZxXNue/S+35UdFFoK65VrND6FRSH0KomWskI0U0vH5lSqtu9NJFrN
         i29zblg4RYTpM7nwvzBIb/pkVNSCthWCUD+qKpyEaPVkTPcf+plaAFxqJqVwBBGEF9Zs
         Xa/Q8LS3IBDwJZspr5Xl2c0PHeI19tppMmsopStwEP+4xYXP/dVOOBHBYlRmMMr2Lelz
         wXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bb2wISS/xLdNZd0DMvsAff3APmVqJv/gmHexaPxY2ws=;
        b=b6eBj9u3vGOSJ2ElpaiNg/kLULOQnw9oyPLGvYUqH83o1dddn782owLu5AOq+uxU9w
         yRYOkpNSnw+ipDCPjed1b5PgA8jT1DRDiGSbGIuScyvkJHlFvB7pb81RtRW53glB9RsG
         KXoJ5mwp6RQ9th3niE02z/4TMwlXPfiWi3Pcqa9tU/AndLB3LOARmewv7A3I1YqJfEas
         ug+W21cWmXqR3hOh929UoF6fDxFPT8AcdUpeH/2N4hmbo9OFtwIbDz4Q+Kv8UBWosfWX
         Pu6o3d+sIg347q6xRBsNrLBMWeMFyOgAdQ5O2wZOrnU/8rHkHSICUVe/iiBdobikEkix
         hRoA==
X-Gm-Message-State: ABUngvcE5ynpvtd5bI3rB/X3eFvqhxU51UAsVAat8hJagVEFiWYuu6PXD7sHGbydaPbPLBg3
X-Received: by 10.98.55.67 with SMTP id e64mr19111532pfa.80.1478197196252;
        Thu, 03 Nov 2016 11:19:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b42d:d807:c3e3:2b82])
        by smtp.gmail.com with ESMTPSA id s7sm14357787pfg.32.2016.11.03.11.19.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 03 Nov 2016 11:19:55 -0700 (PDT)
Date:   Thu, 3 Nov 2016 11:19:54 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103181954.GD182568@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
 <20161103175327.nn2yasvlsxsy22be@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161103175327.nn2yasvlsxsy22be@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/03, Jeff King wrote:
> +
> +	/* unknown; let them be used only directly by the user */
> +	return PROTOCOL_ALLOW_USER_ONLY;
> +}
> +
>  int is_transport_allowed(const char *type)
>  {
> -	const struct string_list *allowed = protocol_whitelist();
> -	return !allowed || string_list_has_string(allowed, type);
> +	const struct string_list *whitelist = protocol_whitelist();
> +	if (whitelist)
> +		return string_list_has_string(whitelist, type);
> +
> +	switch (get_protocol_config(type)) {
> +	case PROTOCOL_ALLOW_ALWAYS:
> +		return 1;
> +	case PROTOCOL_ALLOW_NEVER:
> +		return 0;
> +	case PROTOCOL_ALLOW_USER_ONLY:
> +		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
> +	}

I know this is just a rough patch you wiped up but one question:
With the 'user' state, how exactly do you envision this env variable
working?  Do we want the user to have to explicitly set
GIT_PROTOCOL_FROM_USER in their environment and then have these other
commands (like git-submodule) explicitly clear the env var or would we
rather these subcommands set a variable indicating they aren't coming
from the user and the deafult state (no var set) is a user run command?

-- 
Brandon Williams
