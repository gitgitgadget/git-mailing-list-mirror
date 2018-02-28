Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0741F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbeB1SQ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:16:59 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38508 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeB1SQX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:16:23 -0500
Received: by mail-wm0-f66.google.com with SMTP id z9so6797764wmb.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3mDShPnDXM93gg9aOfOeM8G9L5kzGnejJHcLHYqLcMk=;
        b=Pima0ltt0q7knWSceeLJs+IWwbuKNbF07cG24HmJ16qcoV8Ebsh+9O54vfwVCcySLq
         JqlSiEr0hhyNkD3FguF/JQx7Et1NK0X10FsgaJofrngzSocDyNabHPR2bRxuoz2zCYPz
         z/xNWZjeCfP6QGdxN26eobXbUf73TANvc2cNXCxM27MCcymj4TYDYVL6+EUBRg6u9Ptc
         aJWpRR3CwW9RsN0vakmxsfTJqscXw5B9ZsvPrIOjlnWUAwZdOKVVLSzFEsXGX+1IJq3z
         JUQ1DhQlGbe9WhOCYL2TSX+I1Eh9YdohLyf55ODpHH1RCdFx7dGUnQsXyWhzS8M2TnsE
         K6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3mDShPnDXM93gg9aOfOeM8G9L5kzGnejJHcLHYqLcMk=;
        b=p0MzCkGXeafzvsV5alDOi9WlnkWoh5JHUMw0xoU60ZE0MYRGBpvdF+8fWPKzEJianA
         h8nZKnznX7XlBUtl06jPH5q0mrlCDMXFj1kYOwZmzIHmESw9C1ONtwjb47IayiVSITBg
         y6aoCZxtLFIjRzDHVHaCOKoBlpVUSL4L4YOsjXOhyM+8YnInjDNH0lvU9VQWQHMxmJIZ
         ArWwmbbedsXGhLz8TmnzGiqlyi+D12WQL4u/14U7+2iQHW01CHH/v4N8pOww9ZpzUgMc
         L9UoF6CD9qyl/y998KC89QHRSRlTP/7O2p620H00GFJnCW9U95GsFAcsJSsaNNFUmGTx
         Jmyw==
X-Gm-Message-State: APf1xPB0zP6R5zKKahHOyL4ohnBJxFIOHZtP3QNAKR09QOnyFmREyFpB
        LJz2ElE60Un1PkhrbaYf3qj+UFRp
X-Google-Smtp-Source: AG47ELvJgYyngJFFjDpss1yQN3VdvQrxl9aP8HcncAEeM5d0pkuFylEVkBcX2Xs63vcXZYb1Z0iXkQ==
X-Received: by 10.28.183.9 with SMTP id h9mr12945577wmf.99.1519841782502;
        Wed, 28 Feb 2018 10:16:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 62sm2327579wrf.24.2018.02.28.10.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 10:16:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     git@vger.kernel.org, Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] hooks/pre-auto-gc-battery: allow gc to run on non-laptops
References: <20180228044807.1000-1-kilobyte@angband.pl>
Date:   Wed, 28 Feb 2018 10:16:21 -0800
In-Reply-To: <20180228044807.1000-1-kilobyte@angband.pl> (Adam Borowski's
        message of "Wed, 28 Feb 2018 05:48:07 +0100")
Message-ID: <xmqqpo4pkmiy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Borowski <kilobyte@angband.pl> writes:

> Desktops and servers tend to have no power sensor, thus on_ac_power returns
> 255 ("unknown").
>
> If that tool returns "unknown", there's no point in querying other sources
> as it already queried them, and is smarter than us (can handle multiple
> adapters).

The explanation talks about the exit status 255 being special and
serves to signal "there is no point continuing, and it is OK to
assume we are not on batttery", while the code says that anything
but exit status 1 can be treated as such.  Which is correct?

> Reported by: Xin Li <delphij@google.com>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  contrib/hooks/pre-auto-gc-battery | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
> index 6a2cdebdb..7ba78c4df 100755
> --- a/contrib/hooks/pre-auto-gc-battery
> +++ b/contrib/hooks/pre-auto-gc-battery
> @@ -17,7 +17,7 @@
>  # ln -sf /usr/share/git-core/contrib/hooks/pre-auto-gc-battery \
>  #	hooks/pre-auto-gc
>  
> -if test -x /sbin/on_ac_power && /sbin/on_ac_power
> +if test -x /sbin/on_ac_power && (/sbin/on_ac_power;test $? -ne 1)
>  then
>  	exit 0
>  elif test "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = 1
