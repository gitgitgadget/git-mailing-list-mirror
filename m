Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B841F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeC3SJr (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:09:47 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38341 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752474AbeC3SJq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:09:46 -0400
Received: by mail-wm0-f52.google.com with SMTP id l16so17952178wmh.3
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GYQ+HLKopXrBDdbj/xOWyt2quv31/ffmIeEBK8MZOJo=;
        b=WhJ9MIXN7GIPOOor8mAkYtIUzv69FyWqU3lNcepV04yuZ0hosWWITRRSzrPOkAVBkF
         m/2nwkQDDFF2cqfLLhf/29ROgxSxSHZy7geGPB+AKUrgzXVeEtae34yFprZwpgwvyHmt
         Xjv4hjNR95os9YzeNfYhJS/qGmewBDounnZv8MMtAu/Bo2N2bJT4mUXFOqpv4zVpWDZQ
         boCfFOyQJmK8RqVwHBWjwSd0GT3WKi7tHrzGX2Zb0I5VrN4qepSr6brs9SzjrlT60FDy
         c8wOG6RafweE0JyjK/12vbPEHt1sJpnV8khExJIx6r2/rj8bZlj4nNPuuFNyK4B9RSWc
         MiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GYQ+HLKopXrBDdbj/xOWyt2quv31/ffmIeEBK8MZOJo=;
        b=lRNbGWZyQWh6TzLdV4ev2Fjuz6h5yLOHAaszsxsROx/ILs/Ym+Sruezil3OAM7Nmf+
         j2TbfcD3FiVRrD4ueIYFNAncOMb0IQxkGHKnhkkIdjCea2Q6aB3OvsCa3vf/i0DogGzn
         w7gbUUlvTSqsLMlNXcjgpowBEbPIwKDE6i+KirQ9bprQVKSFg9dT9oU/ArngxUcrwtaU
         lcKMYEMEjUsdjm/Q7u/gBPAWw1MnxGi3GKCSIZFooLsW2grvBv7anCJ5emTAquBCxxCF
         +Tslwpm9RMWIOavUt8+AXms2UQdWiMlnps7JQ1TPPM9ClfdetD2O+eQjxqD+cjLPHK7I
         128w==
X-Gm-Message-State: AElRT7HpXdxjH7JqUzH5TEhpktqTYk1LV+GdSAwfcrHqQPxe0KaWILpA
        4xz5R0t8akLujmVg5CUsL+Y=
X-Google-Smtp-Source: AIpwx49BLM0AIo6ig8vHdy2g7gIqDLof77cOz5oQsFP45c6AZ5smZKHbdEX0EVJu4YfXDrSIdN8jhw==
X-Received: by 10.28.110.17 with SMTP id j17mr3126921wmc.65.1522433384553;
        Fri, 30 Mar 2018 11:09:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x9sm11414950wrb.18.2018.03.30.11.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 11:09:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] builtin/config: introduce `color` type specifier
References: <20180324005556.8145-1-me@ttaylorr.com>
        <20180329011634.68582-1-me@ttaylorr.com>
        <20180329011634.68582-4-me@ttaylorr.com>
Date:   Fri, 30 Mar 2018 11:09:43 -0700
In-Reply-To: <20180329011634.68582-4-me@ttaylorr.com> (Taylor Blau's message
        of "Wed, 28 Mar 2018 18:16:34 -0700")
Message-ID: <xmqqtvsx3060.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> @@ -184,6 +183,7 @@ Valid `[type]`'s include:
>  --bool-or-int::
>  --path::
>  --expiry-date::
> +--color::
>    Historical options for selecting a type specifier. Prefer instead `--type`,
>    (see: above).
>  
> @@ -223,6 +223,9 @@ Valid `[type]`'s include:
>  	output it as the ANSI color escape sequence to the standard
>  	output.  The optional `default` parameter is used instead, if
>  	there is no color configured for `name`.
> ++
> +It is preferred to use `--type=color`, or `--type=color --default=[default]`
> +instead of `--get-color`.

Wasn't the whole point of the preliminary --type=<type> patch to
avoid having to add thse two hunks?
