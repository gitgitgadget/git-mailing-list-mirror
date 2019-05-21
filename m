Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57CA41F462
	for <e@80x24.org>; Tue, 21 May 2019 10:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfEUKXR (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 06:23:17 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53190 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEUKXR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 06:23:17 -0400
Received: by mail-it1-f195.google.com with SMTP id t184so4051442itf.2
        for <git@vger.kernel.org>; Tue, 21 May 2019 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKZRD8uLvxi9Eo/A+apzRIZAdT721POprM3Bt5MQkTo=;
        b=T9ejh3s8pu6OEmAlmB6KGgjshDK6f34tfKrpDx2BVeftYP+g8VYAnDUDzn5gm5Pee/
         2TX0fN+/jDZq2tYJ2+9Bqc9Nj9PkXH2asi4ptBCDF35F6ggWIyBZt8wuYGvqrwXUo0i0
         3MT3LpBgL2mT7ncreuaJMPu6dBQJtZPNUOAyiHG45vUwjZnNFs0Q9VRF3HZvaOw6Tgcz
         NAEf9lpOd7WkbQEyvI6T6Up0SxbQoaJcvftcFP69mbjsXsJLmNqLt58nxthiqgpfj6Sj
         ZzXPP4Sd28TobAhft6OGqVn02EvOAlZf5yEwvOgbXz/TMUo/UbGNrkXt+KdN5Sske1L5
         RskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKZRD8uLvxi9Eo/A+apzRIZAdT721POprM3Bt5MQkTo=;
        b=p+sxBBa4lZyAfr/vbZgVE66Noo2Jsme698KbtCuuw5jwn08DCN53rlOXw6QH7Sc9ml
         u0SBX1ODusTKHMQFbgnxYSToh4UJ3AZbNR/ModExJTuxXP9bvN4wiRsSDuQWyIEDNB+8
         7xrftOy1xOFASAphw64r77VJ65s6+NYj4rDqKPjVvmMh39+JNmA2OHyZVNri97fH2FXS
         rcTk7oZQQumXnvkaEm0hivjHUn/f53Y2jsBWZSanCcax91r36w0ym2RTYhWK++VRHJmJ
         xQb0CebCCYT4zCeMV9NAe2lkB6rJea/oPVWXdaxLNyz4RS7FRgZi3FTKl2FX2gEtctl4
         ysFw==
X-Gm-Message-State: APjAAAVSw1f0iqfdhJKVmPw1WuLzRbIGZY4cZcrY2wmIAbLtLKtfEVuP
        xICWoW1qiUJa0AhcTmjonNlHLTR4VaNmflPVgFs=
X-Google-Smtp-Source: APXvYqxotGV17qd4PePT/IRqkmA0LQDiq92Q3HZHdtdNY68MmF4AotAGZJFRxxxtiMM9s1Yo7T/6Q+bARxUxwa1dULY=
X-Received: by 2002:a24:194c:: with SMTP id b73mr3039641itb.157.1558434196369;
 Tue, 21 May 2019 03:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com> <CAGyf7-F-d-n39fJmjYc_2rjqQa4d7PFCx63LwW3m7PFetEgzEw@mail.gmail.com>
 <87ef4svk1k.fsf@evledraar.gmail.com> <CACsJy8AdhQH25NeDKKdSBctXcU=oyGcJ05XaNryj22GUQH5Btw@mail.gmail.com>
In-Reply-To: <CACsJy8AdhQH25NeDKKdSBctXcU=oyGcJ05XaNryj22GUQH5Btw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 May 2019 17:22:50 +0700
Message-ID: <CACsJy8AU7=N_npgTuLES3r8VBMw+6kS+7D-B5MY0eghdD8O=AQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.22.0-rc1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(dropping lkml and git-packagers)

On Tue, May 21, 2019 at 3:31 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > The bug there is that the old opt_arg() code would be torelant to empty
> > values. I noticed a similar change the other day with the --abbrev
> > option, but didn't think it was worth noting. Maybe it's a more general
> > problem, in both cases we had a blindspot in our tests.
>
> Hmm.. this one is different (at least it does not use opt_arg()). But
> I'll double check.

What is wrong with --abbrev? The code is simple enough for me to just
compare line by line, and the only difference I can see is that if you
pass --abbrev=12a, then the old code accepts "12" while the new one
rejects.

Granted, I said "no behavior change", but this may be pushing the
limits a bit. But maybe you're seeing something else?

Note that "git diff --abbrev" still uses the old, but different,
parser in revision.c. parse_options() is only used for --abbrev with
--no-index.
-- 
Duy
