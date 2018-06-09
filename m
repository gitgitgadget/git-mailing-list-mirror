Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3305A1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 13:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeFINoc (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 09:44:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43899 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeFINob (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 09:44:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id j20-v6so7965169pff.10
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c7O5OLXRpCYWNc0M8ImdyR1cfB8Cly8/w7YNQSc0F/w=;
        b=VDRpx7CZhmEibJ0nvpSlj0XFOvhQwBB1l9hk+wtyK9+349iGwcs+6p8t9t64LUGKSm
         2vipYszfdinqMRvcLUbY/S4uOE4h6wsEDMX6BfE12O+j2dZ3pci3el48ejGY/b46UlFb
         OMn/hFfQkoblyGiWBHrdZB12ZOv0Fe8dgCRnxMyskxFPPAJavRg0OTHf0//y5yhYWYVl
         ys6IDoKVO4v2fczqlM4zparWiiS/zes5oEHo4S7eSejUEA1Tcpt0v/4rW3ZyQ4cpf+tZ
         ddgancHA/MP3sbKPTVtjCP8Rq7tf/pWTtQ1/SgKIyYeExBDIP8NbdviQzuFxqrlOajNl
         /ZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c7O5OLXRpCYWNc0M8ImdyR1cfB8Cly8/w7YNQSc0F/w=;
        b=clv+Vr1i7lI8DasJiQ39jkldWWGncIovYrz6cluu+Fmem6GPuyLe32zGsvudnMUPOk
         q8p1j5y0++FFjn4QpVLtTO4/f4JOC5qnM7ZT1PfVT9cN+pRRbHkEYLYfJu5EIQkDtGqv
         VOZ7b0oSPSpQHU1q0FmE0mVD9HmWduDhmi84JZlvBvPVpdOnpwiXeqr02oTr6Hd9Invm
         V5fZ/c135NeJtyorVEHH/VSJ8I7/XEhOggTE2xLP93Ss+wFjBYUBR9wYZ0t09P3PvuKU
         /+SYNArwz6rC0FfCnFUVZutHmNSKm+PrFpBDm3p63MW3T+IcRXEI/vpaRfiuvo9lFRru
         Nu6Q==
X-Gm-Message-State: APt69E3iJHJBtp6+kNDRYUgVSpOE1vcNpVN+i4/hK4fIrrkSZvk+IAvW
        cm+8GRb2ztdUQU4zHkq/BggvtX/cFl+Raw2OAk02FnFk
X-Google-Smtp-Source: ADUXVKJDlPybUlcZ42wMtCwCYF1QThTAjvcwmtpkQwYDTbhWd6uEdkJ6blmytUS/JKUjkco4Of3949mMEizzqDG47oU=
X-Received: by 2002:a63:6dc3:: with SMTP id i186-v6mr9000530pgc.316.1528551870792;
 Sat, 09 Jun 2018 06:44:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Sat, 9 Jun 2018 06:44:30
 -0700 (PDT)
In-Reply-To: <20180609092135.GC6817@sigill.intra.peff.net>
References: <20180609083159.GA6158@sigill.intra.peff.net> <CAN0heSqHRpOerHV8tgA-ntU6QvYQMxgrXPCPsrVcHLKUSwANXQ@mail.gmail.com>
 <20180609092135.GC6817@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 9 Jun 2018 15:44:30 +0200
Message-ID: <CAN0heSqkcZ5KBpaq7R45A7wPxQ3F=6PKeHqwAQztdJyz31Vdwg@mail.gmail.com>
Subject: Re: [PATCH] fsck: avoid looking at NULL blob->object
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 June 2018 at 11:21, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 09, 2018 at 10:50:36AM +0200, Martin =C3=85gren wrote:
>
>> On 9 June 2018 at 10:32, Jeff King <peff@peff.net> wrote:
>> > Except it _does_ do one non-trivial thing, which is call the
>> > report() function, which wants us to pass a pointer to a
>> > "struct object". Which we don't have (we have only a "struct
>> > object_id"). So we erroneously passed the NULL object, which
>>
>> s/passed/dereferenced/? Probably doesn't affect the fix though.
>
> Well, we passed it, and then that function dereferenced it. :)
>
> I'm going to re-roll for the minor bits that Eric pointed out, so I'll
> try to word this better.

My bad. I somehow thought we get into trouble already before we call
`report()`. Well, we do, since we have undefined behavior. But for all
practical purposes `&blob->object` and `blob` are the same
(NULL-)pointer so we only crash after we call `report()`.

Anyway, obviously no need to do anything about this in a v3.

Martin
