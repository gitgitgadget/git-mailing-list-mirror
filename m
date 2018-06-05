Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5F81F403
	for <e@80x24.org>; Tue,  5 Jun 2018 12:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeFEMZy (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 08:25:54 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37406 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeFEMZx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 08:25:53 -0400
Received: by mail-wm0-f41.google.com with SMTP id r125-v6so4611848wmg.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=NEQqeQABwwwkar97StA5Pv0Tbzuq0NKsr/4xEl6GsUg=;
        b=GQGGNuRe3iNMW9cW7mrch9N2dDNUb5t9txvQwrLd4YvJajF2Z2hDVjb3bNOFZx0XbU
         K3LUSIegTdvVObhVjh5aGcT6UwLMcw+jFfTGI66u5kwZDWW38LcyBfKSOvFkdi3EOLI6
         ch6aJQyfN1SsNR65w2qvw3K460ADtyqIqz2V/S0jCQnSMLzL6Sl+rizI7Stz8PsICOWx
         URxd0OsOwb1R9JN1bVrHdVT8Cqak3xPKfVI8zxp6GoP1xi0ZaMk54BkVA96p0tXyLylT
         URXbKloLwem7uKsThQbqp81y4VvYQVPhVE4JppTNS1dmz6Ym2PkzUG5S09VznoML7whP
         EjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=NEQqeQABwwwkar97StA5Pv0Tbzuq0NKsr/4xEl6GsUg=;
        b=tEdARGZEDncLEuIVvYhnLuSrCDwkXecdxpeE3+Bor5EGn/xNyGIUebcfpOwxXew3Qi
         Xv09Fkh5qYjQkmex8z/478E9TMlAXnhPgHYcNi2bqHRYRj8tv6YVyZkjNpbaxGeRiFf+
         Xrz3z2WVAzqoeEZ/I2Sy2FAP6zmujn65p0p9sU8IVPplksfpn8Drrj3GNTrg41JxIm2f
         G/ZehDsVCatkchjF9NxfIUQaQYRyns6c+dhYR2MF8gXgvuCOLQh5KP8wgiidbNlgbVWs
         Bg/t7z0ZwtkHjcfz5DEiWwvbRCy1LCn0ZCx/O7KqNANvuHFY2ipNofdM4renY46IsO1o
         ibpA==
X-Gm-Message-State: ALKqPweOxw/+qPZxWWwSJRPYrhs1VwIyHNnf6cEG9khep2RHoByweIOE
        4KNQXcG0KWNgLr2REq4B2Ao=
X-Google-Smtp-Source: ADUXVKKc21QCws+zbjkdvnFw2hlZ7uGOXkvds3trF2+1eYgiIruUajmjI4KCrthW0Vnca1/rTdywSg==
X-Received: by 2002:a50:f5a1:: with SMTP id u30-v6mr25808516edm.93.1528201551854;
        Tue, 05 Jun 2018 05:25:51 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id k1-v6sm20521437eda.35.2018.06.05.05.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 05:25:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tim Friske <me@tifr.de>
Cc:     git@vger.kernel.org
Subject: Re: Git not creating merge commit when merging signed/annotated tag
References: <374116891.50361.1528200631824@office.mailbox.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <374116891.50361.1528200631824@office.mailbox.org>
Date:   Tue, 05 Jun 2018 14:25:50 +0200
Message-ID: <87r2llzagh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 05 2018, Tim Friske wrote:

> Hi Everyone,
>
> ten days ago I asked on https://unix.stackexchange.com/ why Git is not creating a merge commit when merging a signed/annotated tag. Does someone has an answer to my question https://unix.stackexchange.com/questions/446154/git-not-creating-merge-commit-when-merging-signed-annotated-tag?
>
> Thank you in advance!

I believe my answer in this recent thread which brought up the same
topic applies to your situation as well:
https://public-inbox.org/git/CANgJU+VFCY0LNRLMSGtD7ScpcLaPFMzUOyw6Bjgk6q=Kx9DvCg@mail.gmail.com/

Try to apply the patch I noted to builtin/merge.c there and see if you
don't get the same message printed out.
