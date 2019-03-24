Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B97220248
	for <e@80x24.org>; Sun, 24 Mar 2019 14:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfCXOvJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 10:51:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34906 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXOvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 10:51:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id d6so5398780eds.2
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+/9e/vYyF2XDHBLfBStRehmzFtC0a++y/4txgqFWmIw=;
        b=X9pletKE3hjymkUqzQ9LmMy98JgWdm0oFsgY8qz/A0BZiG8EwGXw+s1pTqlYvzJIDM
         kHueE9X0jnJk85yRpo5d8Uaqy64w2dtYw4hzE+o/CrE4+ZuApRsAzz1zVgdHRhqraNSy
         544WULZsWjFi7dNMbfGFBHmzvgZb6i8xDWmkvrbTgQYzHXT7pTLP6N26HUQ5Juqtsomc
         59oBEf313AH5cWMtIpGxKU4W4lVezCOsHwO+cFWNXn9fZxdcpIBjklnWHZ9B7hU3fAMY
         C+UfHF6curwQckjF3HjaW2/u/IpGw66kynMEAi0xOIjN/kggmAL5sl0+V1cRHryRqy4m
         bXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+/9e/vYyF2XDHBLfBStRehmzFtC0a++y/4txgqFWmIw=;
        b=OUufIiNUwKb3Ajx2fBLmycqa9oEKhMmHyL6jgyaUuhjEgr2iMWUiGl69uIhobA8h8t
         vV87Nlcjz+RjESdglzNKzY0cOcpDsg3uolJS+ulWhKMhLr6X08DYOSvwOLwhp6dy9xdo
         qn8rhvDDVwdds0JLLY8kTKu6iuyex0TxhAyDg4wNwKhahvc6O/zP8eiv3ZaBgGVAaxr1
         dT+0+u98oEfrYQ9cJDS+c5crnPMz4y3b0cKVs2FOAdKJqsr7BS1fFSKNdUvPKfyzpGVL
         WIZEKe0zWbV6Sf4H80fsEqNcs2clguDyfF98BCMu9AfBwY95fEJRCy7zEpruJzmRZfji
         1DNg==
X-Gm-Message-State: APjAAAWiffcrwJrQ3TEw7icDfdnp72lJJ9rVeHc9PbvVP8Ml6Z9VNpTk
        ndVnJCqsV2ia1XSDYfLGv/Y=
X-Google-Smtp-Source: APXvYqwnoMcNOetTuke9EN3ewNb8cK5h0rjl6Qct0JN3atM9TbRkRkXp2/XCBXFvRLOhIT8bp5TN2Q==
X-Received: by 2002:a17:906:3112:: with SMTP id 18mr11321936ejx.84.1553439067555;
        Sun, 24 Mar 2019 07:51:07 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id w11sm4339084eds.39.2019.03.24.07.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 07:51:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v3 1/1] trace2: write to directory targets
References: <cover.1552519463.git.steadmon@google.com> <cover.1553202340.git.steadmon@google.com> <ce5258610ffbc2e498ff33336c5c89b69468d4fd.1553202340.git.steadmon@google.com> <87bm21coco.fsf@evledraar.gmail.com> <xmqqlg14pi2x.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqlg14pi2x.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 24 Mar 2019 15:51:05 +0100
Message-ID: <87a7hkcome.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 24 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> The reason I'm raising this is that it seems like sweeping an existing
>> issue under the rug. We document that the "sid" is "unique", and it's ju=
st:
>>
>>     <nanotime / 1000 (i.e. *nix time in microseconds)>-<pid>
>
> If it is just that, then it cannot be unique, can it?
>
> Let's just fix the wrong doc and move on.

I don't see why we wouldn't just fix the SID generation & move on if
we're already carrying code purely as a work-around for it not being
unique enough.

Of course nothing is *guaranteed* to be unique, not even a 128-bit
UUID. The point is to pick something that's "unique enough" given the
problem space, which is already one where we'll ignore I/O errors on
writing the file unless you opt-in to a warning.

And it's a very useful property to have the SID be a) unique enough like
that so you can use a unique index for "git events" b) fixed-width
(which the current one *isn't*), so you can use fixed-with indexes in
some logging databases c) as a bonus, be human-readable at a glance,
hence spending slightly more space on the the YYYMM.. format in my
suggested SID format.

I can write that patch, but first it's useful to know if this is a case
Josh is running into, or if it's just a guard out of paranoia.
