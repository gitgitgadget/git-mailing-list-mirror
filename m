Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4A22047F
	for <e@80x24.org>; Fri,  4 Aug 2017 20:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbdHDUet (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 16:34:49 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33377 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdHDUes (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 16:34:48 -0400
Received: by mail-qt0-f194.google.com with SMTP id u19so2636776qtc.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2017 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cZqZKSi67r2LIPUXNc1UrIhJLhPS1SN3h7OxtviWcd8=;
        b=kYo/GX1VxQdxQO+Vmn2X9PIMTgmhDBLprHC7zgK8bUU/zyoyZ2Ju0wxZj9cyNk7tNL
         zQPIWwfsEsOBZ/AJedU23hPj2PlWvSJdheYUTa77URSKFPjplsMfKAKnrui9cSv00tz4
         qddWeqfT6E3jzq0og1gd1D0MHiav4T4XxGP0CjLc4/CEE21WkPZGFT58tfLamGXQKqJj
         hH4AVpRx16b5DfWB1JZqwptmeSD+OAvYHUVHcG01r7Z5XGMiNiAKZBZi9k+T4YrxTmpy
         ipaQXVEae7trE01nxcHiP4pDaWXdqbwiQdhbvCIsB7tPgTBy9K0bdPLU7y90Jf8VG/HK
         FLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cZqZKSi67r2LIPUXNc1UrIhJLhPS1SN3h7OxtviWcd8=;
        b=VhM2T3rQBYpkhw5Z/kmOug0PQwX6RFB4d7DIxu9dAdTK3uogHUlVlHedDGZPnKLUQp
         ZH3OVlgWrTPBBSG8OnOgdAcICYAyn4R6a3W7hiovmtOQ78iqHLv9jrWoMCALWmum6zh4
         NZzbqYw2Q8krgg4OWdpIMU7PdB72b3+wnPaY7G4JB4rBneq8EnRMJEleUkILp7t95fIS
         jQy8q7o/B05TFlOa+gcAXnUEuZQWxtj2OPhkoqDN51gcF0hkrVkMXLX+lFMMOFtwet3p
         Meyh3JFKfq6K+/2Yx8VduRlhE0inUHvJzppFZQq1kJ6QG/ns6xzIi1Xv87PvAn5GbNTw
         xaMg==
X-Gm-Message-State: AHYfb5hUKredZGJfDhx59r3zkZYS1aGc5a3lng//gGAh2/bvzlAWNP9X
        HJbBOUrwPt5JhyjTj5cd5AoFx6dD6g==
X-Received: by 10.200.37.193 with SMTP id f1mr5000201qtf.264.1501878887691;
 Fri, 04 Aug 2017 13:34:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Fri, 4 Aug 2017 13:34:46 -0700 (PDT)
In-Reply-To: <xmqqk22kxy3m.fsf@gitster.mtv.corp.google.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-9-chriscool@tuxfamily.org> <xmqqk22kxy3m.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 4 Aug 2017 22:34:46 +0200
Message-ID: <CAP8UFD1wMFPzRD76QfAH2L9kAZs592-_F0sr3oQm0DMF09jL9Q@mail.gmail.com>
Subject: Re: [PATCH v5 08/40] Git/Packet.pm: add capability functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 9:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Add functions to help read and write capabilities.
>> Use these functions in 't/t0021/rot13-filter.pl'.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>
> Steps 06-08/40 all look sensible to me, but they probably fall into
> the same bucket as step 03/40, i.e. better done before step 04-05/40
> (which should probably be a single patch, as I earlier said) as
> preparatory steps.

Ok, I moved patches 06-08/40 before 04-05/40 in my current working version.
