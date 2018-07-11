Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55B41F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 04:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeGKEEu (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 00:04:50 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:43106 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeGKEEu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 00:04:50 -0400
Received: by mail-vk0-f68.google.com with SMTP id d74-v6so13679667vke.10
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 21:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rgrjTWtOQikv/j4+n7v+P3zRgiCpzarlqr10TuR7G7Q=;
        b=S9kd8/bCwisZB3/ZWqPFHHyirMjCUFyI15yxb/1bBfhNANRDgJ34feML8Kib2r0AR2
         kmqtD5u420F7bfgOjMmrghorvKg+sllBPUsrE54DZjJUO60OZnwUHGJHT3JxZAKDjcI6
         iA/zpyaE3StUc3oUgqxvLr2prD90AkMrd7HzHS+TmGhj7f8s2A1f5v2yLnbmBhasmQkI
         fAzMZjE/azOxin0AErRhhn3pPMwnxqmtYFo/kX1k/y8AZVUCQAPS5Pky54gAz49KpmA5
         OvHR5aNZ4VPWGHaNLkWfkDyQI7JZMkj8CU0SknmuhQZW/nt2xUoVvG0hV4v/fWE9rjhx
         IUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rgrjTWtOQikv/j4+n7v+P3zRgiCpzarlqr10TuR7G7Q=;
        b=pZEkEvZKfZSrX9LZcV6B5LJgAJOSGHEusxnSrWWlkeY2EcKMHgjRecNycRD6/+sjyM
         ZN88c6Tt3yItH/PTwz3EcpWOlwKTYcG8OMDGUwjWCVrkC2i2pfCPckLHqwrd1HO3L0AP
         KCE0wgIZ3ol+6agRTfOlv528w+GsZHbsTVNQgpK37zh6yw8GsfG3WaeHIW3Dh+hoKKNG
         nxJpTv1y3QognPvJ+IuwNJPKXpq9gR1QD17WyMrsORXP+OLbogqx6B1hCxMuc7A2olBB
         0v4TOEGXORQk0bZFNoxva3NqQtENO/8ErwIiVIdcltq5CyPGHY+pdqp+GcRFipeAoKQ4
         sOFA==
X-Gm-Message-State: AOUpUlFJgr3onjXhek+wpmEc+x6R38fuMZOoNhxiTgn1U7s+eFt+ql4C
        nRZVyjmp8IX+aTQn5LqN9ik/umxhF567h40WcDY=
X-Google-Smtp-Source: AAOMgpcxdWtoLiTk3HzHZ899ADbz5BBbQUuEUpRS+2Z1JZAnCRD5n1Jm5sXVZeDMPptyJQJjRJErKOi1PsANrgp4ubE=
X-Received: by 2002:a1f:a182:: with SMTP id k124-v6mr7577810vke.118.1531281753380;
 Tue, 10 Jul 2018 21:02:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 21:02:32
 -0700 (PDT)
In-Reply-To: <20180709202229.10222-1-newren@gmail.com>
References: <xmqqr2kce1mw.fsf@gitster-ct.c.googlers.com> <20180709202229.10222-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Jul 2018 21:02:32 -0700
Message-ID: <CABPp-BGH+6XkJwqhUOydT0CQBRTr=Hf79SU5PGZ2NrvV5uNjCw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add merge recursive testcases with undetected conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 1:22 PM, Elijah Newren <newren@gmail.com> wrote:
> On Mon, Jul 9, 2018 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> When a merge succeeds, we expect the resulting contents to depend only
>>> upon the trees and blobs of the branches involved and of their merge
>>> base(s).  Unfortunately, there are currently about half a dozen cases
>>> where the contents of a "successful" merge depend on the relative
>>> commit timestamps of the merge bases.  Document these with testcases.
>>>
>>> (This series came out of looking at modifying how file collision
>>> conflict types are handled, as discussed at [1].  I discovered these
>>> issues while working on that topic.)
>>
>> I have a topic branch for this series but not merged to 'pu' as
>> test-lint gives these:
>>
...
>
> ... here's a fixup to the topic; as you pointed out, the exact contents
> of the script being written were actually irrelevant; it was just an
> input to a merge.
>
> -- 8< --
> Subject: [PATCH] fixup! t6036: add a failed conflict detection case: regular
>  files, different modes
>

Does a 'fixup!' commit require a Signed-off-by?  Just realized that
this one didn't have it, though I don't know if it's necessary.  If it
is:

Signed-off-by: Elijah Newren <newren@gmail.com>
