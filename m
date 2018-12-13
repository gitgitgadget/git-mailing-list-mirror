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
	by dcvr.yhbt.net (Postfix) with ESMTP id E07D2211B3
	for <e@80x24.org>; Thu, 13 Dec 2018 14:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeLMOFH (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 09:05:07 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33638 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeLMOFH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 09:05:07 -0500
Received: by mail-wr1-f51.google.com with SMTP id c14so2166023wrr.0
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 06:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=YZjJyHyoqXnk0iyS09Tmmm5b77p1DzN9W2+Uv7oP/6s=;
        b=IHVpKFqGT6zVdFHxmHaSlzMTTI8B3DTcXtHrFXyXIs1WqKeilC9xE5AqrkaZIPl9Lu
         zOKVWr0m3nhSNvsTtdtrf6b8m0+EA3QK4/x7xkvXoGqHYuDQzrdy0H484Mu9wtC1ZwDF
         yYTj/BbYgF4QnfeKTKJeNP5/g0b6WoHY0hMH2U5JEaN0nlxG8UhxV5CTjRIwL8SDWVJL
         votTHsRiw+uajbDk8qMxqsXhWokyvqNEPX2LvNPyTfAvh9TGcA0tnRVxtZEH3dyRdAdZ
         mctjvpqvawQQWL6/XVruNod7oA9SfWBEgHiB48JS/GGN5njf7nIsEp0c+SWotlCqIsk0
         yqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=YZjJyHyoqXnk0iyS09Tmmm5b77p1DzN9W2+Uv7oP/6s=;
        b=L4eCU4/nwwH3Fl4Jt0FlrG8Nqek2eG2txUATjNUcbFuztof1KJpjpYt1vmdXuIKgvq
         dFNXKPPJRMA8V9wFVS4mtZ6nzIZ45hE4sHTb4PLZnnm6OMUFmMCLgc3s8ttn7sxYyVqr
         6ilM1j75z6e7VYufd89bG6DVj6EuJdJ1FFIk6rL/Cn2Jas70yNyogu4lgQU9xQQCKUXF
         puTWGWyVsp2mG0EIuGBCxiGU04OGchQHda1QpH/ePuQgcIcxC5K8F/LplI/usDgDhfdB
         2CRBxcu4ysDpCs6DJtoSZiI2dos/ej3d9v/7m4nA/uZdOjDqTQMVtTruntLiPRcI/yBv
         1nxw==
X-Gm-Message-State: AA+aEWbab/nWMV73SAHuAkzoWLUi+g7LwShguWlROto6iPzT4ZRsk7ki
        Q0LQHQdJr6iv5899E7M/CSY=
X-Google-Smtp-Source: AFSGD/WNaY7hCy7Wa05H7oAw6nkDaArg4PjTR22C+kwlZo1QFBz3bjbVPRTkejlSDqetPQ+rKc+Iag==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr20982881wrv.288.1544709905989;
        Thu, 13 Dec 2018 06:05:05 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id a12sm1889586wrm.45.2018.12.13.06.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:05:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: Preparing for 2.20.1 brown-paper-bag maintenance release
References: <xmqq4lbiey7s.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq4lbiey7s.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Dec 2018 15:05:03 +0100
Message-ID: <87r2el1q0g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 13 2018, Junio C Hamano wrote:

> Here is an excerpt from a draft edition of "What's cooking" report
> for topics that are about an immediate 2.20.1 maintenance release,
> with five topics that I plan to merge to 'next' and then to 'maint'
> soonish (they're all marked as "Will merge to 'next' and then to
> 'master'").
>
> They'll be in 'pu' but not in 'next' in today's pushout, but unless
> I hear breakage reports in time, I am hoping to merge them to 'next'
> during tomorrow's integration cycle, so that we can start the new
> week with 2.20.1.
> [...]
> * nd/show-gitcomp-compilation-fix (2018-12-12) 1 commit
>  - parse-options: fix SunCC compiler warning
>
>  Portability fix for a recent update to parse-options API.

Since I reported this, just a clarification: Unlike 46c0eb5843
("files-backend.c: fix build error on Solaris", 2018-11-25) this one's
not an error on suncc, just a warning (and we have 20-30 of those exact
warnings in our code).

So if you wanted to minimize 2.20.1 this could be held back, but also it
looks obviously correct so it's fine that it makes it into that point
release. Just FYI.
