Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 517A71F404
	for <e@80x24.org>; Sun, 21 Jan 2018 08:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbeAUIOk (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 03:14:40 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36958 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeAUIOj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 03:14:39 -0500
Received: by mail-wm0-f45.google.com with SMTP id v71so11033925wmv.2
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 00:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4oZFzHT1ubU9agcZ5H/Em9VGR3K05BYSlT+0KpmjbEw=;
        b=pDBwfwgmy0cYQZtviMePvNPb23bPsVrLAvHOj+UGY+OBR+USylrGGWP8XD465Yb/pM
         u/9rWyqPpWywuI/mLZOlfPOrMbWkFmvq07t83Q3GgN5bzwcIATcSi1h4UcNC9dUrpkQk
         8jQp00hZbsJDYaNBnVIMYFykgwlZ0N8GvqLK3r4vv0gy351cPBz2nFA7uHoOMLTFZh+d
         3sw2S2KFd2fepVyX15KbTBaK3/CZko/rrLLZshwnsAWHNeY/morHmTp3qzBBSf+dZaBx
         TnR1oWRb/SozO0DylU2OOn4ZFalhIBzNgBofFXXKbr+L4PyKzsLnqSGGqfM2X9tPz7so
         LC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4oZFzHT1ubU9agcZ5H/Em9VGR3K05BYSlT+0KpmjbEw=;
        b=n2iMs9Y7vj9CeIqbuyZUIXVx/7eBkBcwn6tkutNyRdTqLWWUFGNWZTsQ4yDb2dY5kV
         ar5N5Hj2myru5BKMz0u8rdSolS3Q1t5aPVU+BzPPTZB6Qz/Ic/3pymSn3bzog0OgK2dt
         n4UY5QP7ldefiKEwmPYsEmcNewFLZzcJQCYJUJGEzXx3TaHQYqBMxtnyBZXXj67rMQxj
         GnueIOenzGf7KZ/w3EJ5gF2ELOLQIUgQzaFdgPuANN/XpvaLoTBN3ufw4bxVjMjnQ3Bf
         nY/echAhx95pGUF0d4veHkAQ/AOnS0I2L0NpE/3j9id+/Bg4Swq8pV7cMEUMaI2v9dyB
         Xzfg==
X-Gm-Message-State: AKwxytehY36sm5BFzYjBhjisLeoT/EThToZWqlfS7QoyLMe1ohm+fFxX
        uF66QphJ/8oQ5+mUuq/bJwc=
X-Google-Smtp-Source: AH8x2248piw0R3beyX6hS/PeLrI7bYoR4kuPtgPJwP0b46GIjsfHIGMzX1woUtkZL6ThVFEMRXG61A==
X-Received: by 10.80.137.164 with SMTP id g33mr7348496edg.261.1516522478243;
        Sun, 21 Jan 2018 00:14:38 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id k5sm9610214ede.51.2018.01.21.00.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jan 2018 00:14:37 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Bleecher Snyder <josharian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git merge-tree: bug report and some feature requests
References: <CAFAcib-2fxiVxtVWcbvafY3-Br7Y70HMiHFZoT0VfK6JU0Dp9A@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CAFAcib-2fxiVxtVWcbvafY3-Br7Y70HMiHFZoT0VfK6JU0Dp9A@mail.gmail.com>
Date:   Sun, 21 Jan 2018 09:14:36 +0100
Message-ID: <87607viq6r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 21 2018, Josh Bleecher Snyder jotted:

> 3. Feature suggestion
>
> There's no direct indication of whether any given file's merge
> succeeded. Currently I sniff for merge conflicts by looking for
> "+<<<<<<< .our", which feels like an ugly kludge. Could we provide an
> explicit indicator? (And maybe also one for binary vs text
> processing?)
>
> Note that binary file merge conflicts don't generate patches with
> three-way merge markers but instead say "warning: Cannot merge binary
> files: binary (.our vs. .their)". Looking for this case even further
> complicates the output parser.

I thought I had a way to do this, but looking back in my logs I find
that I was just using:

    git merge-tree $(git merge-base A B) A B | grep -e '^\+======='; echo $?

I.e. a variation of what you're doing, which as you note won't work for
binary files.
