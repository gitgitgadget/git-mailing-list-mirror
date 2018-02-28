Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9231F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935353AbeB1WYf (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:24:35 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53389 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935151AbeB1WYe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:24:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id t74so7996612wme.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 14:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H1bHhZBrEFNGsahCQyPlv5zafcudF46XeKMYUHSakdk=;
        b=XxRfofulQZCFgoqFyodpHRsFJUMpC5JHMxfhKDS0g0lfYDM3FreL0FtnFhvm8hqceW
         YCwnsLKVDe0NF4uPFPuUI5UpCwQ6NlZTcSMmuXhXsEJaQt0gFnEvCEEZ63ahDxHUZT9C
         O1FW8jksNvtetiLPQdEBJ8yOQcRYHy5uQZF/XPHg7PGBr2jqE9fbXyx9StaEwLiZ0pcy
         L6L0NTUXQsA1uEXfI6PUYEKJKCn/U8ZOVxJ5C1+Pdu/ClE+Ha0lWqt1A0aqW2/32aYKZ
         HTInOGZ0d9nQE6VxriVohFT9suonRFA4SbnCQBUIiBY8J9Vc4TO2nbD9YsoT1uew9UG2
         PdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H1bHhZBrEFNGsahCQyPlv5zafcudF46XeKMYUHSakdk=;
        b=k6y55JqTYPi61dtMV+5ChHBE4iEYp+FJvnVoPQkNfcD3nd9VemR54+LR8ltzXh2+If
         l7vs7qO48mrx3fXfxvKfinvF6USF00HZ5Hc7SZ4SKZbVW1GK9Wmtkm8eh5V5ulJPkqjL
         OzUMPfuXntvy54qCDs7H/WcH0e7GC3K+DFBrt/yMJIAM+AqpKgo2zhYRSjo4Fb/3d/Fb
         MhxX2hicZSi8la1nwobEKPD/rmPu0UiKGKzCJSyyRQobrf5HnGyTuL1N/z3BcLEn1Cr9
         cwUOILrQCjHAEb/XnxJp1if+88MZ7VsRn5f2ab3g9uUgFOeHmIcQs3IKf7UK2syBoQZO
         i1uw==
X-Gm-Message-State: AElRT7ES3mZgVPxklFWGe922HPc9QJER2epouYgDmrJH6zbtMPspzUo0
        Mpx/hGMSapNFbkv9uTzSv7Q=
X-Google-Smtp-Source: AG47ELvyNykHU2a6qP4luHAFF6/TaeHCTdsF4aBCazy2n1/3niEz4y/aJjJiNdOpRgPXVnajEgVTzg==
X-Received: by 10.28.150.14 with SMTP id y14mr53435wmd.5.1519856672932;
        Wed, 28 Feb 2018 14:24:32 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z7sm2882071wrg.1.2018.02.28.14.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 14:24:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     git@vger.kernel.org, Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH v2] hooks/pre-auto-gc-battery: allow gc to run on non-laptops
References: <xmqq8tbckca1.fsf@gitster-ct.c.googlers.com>
        <20180228221204.27356-1-kilobyte@angband.pl>
Date:   Wed, 28 Feb 2018 14:24:32 -0800
In-Reply-To: <20180228221204.27356-1-kilobyte@angband.pl> (Adam Borowski's
        message of "Wed, 28 Feb 2018 23:12:04 +0100")
Message-ID: <xmqq4lm0kb1b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Borowski <kilobyte@angband.pl> writes:

> Desktops and servers tend to have no power sensor, thus on_ac_power returns
> 255 ("unknown").  Thus, let's take any answer other than 1 ("battery") as
> no contraindication to run gc.
>
> If that tool returns "unknown", there's no point in querying other sources
> as it already queried them, and is smarter than us (can handle multiple
> adapters).
>
> Reported by: Xin Li <delphij@google.com>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
> v2: improved commit message

That makes the patch and the log consistent so that people who know
the area can reason about it ;-)

Will queue.  Thanks.


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
