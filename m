Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490ED1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeHVTef (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:34:35 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38604 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeHVTef (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:34:35 -0400
Received: by mail-it0-f45.google.com with SMTP id p129-v6so1980178ite.3
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++QhUpAiWLQMl37pIK6HvKgBk4zdWa5UUHujNlOfT5A=;
        b=Q5okSEeSSlJ5gHPvVDHv8GicTRwUwuhaSk+vGkoG6yjFgW2BA76VekbezLsqyvLwaA
         DJiHI9U/9267BinNL+J4TMu/fY9m8hc/I1yaeV5RK/gTjWB4htMSqNEhTsBqnvSVibYS
         GMGUcuW21JQjK/deYHpib5p6Yp9/VX8Pk4TGLiLlrrXJdF92/nql4Wzb6wg/WodLwxWh
         fenvLjl6Uq7xm5978NpSyHEwMIvfBwPCFejmNRNwC0tmuTAO4M08BArRaMIXVNtpk0cM
         kgoIdHeyFTcoAoc5rYE6wulHW5hSA9Hrn9EwYpu8QOiWhwlZJTNVXZXmMHg18z1uvsMS
         vUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++QhUpAiWLQMl37pIK6HvKgBk4zdWa5UUHujNlOfT5A=;
        b=Nx8NyDnP95Foh9gJAwSfE9lId9S8tC2QzAlWJ5EwC5Sn7oLnZEO6+Hms26pjrW+e53
         czYRNWQVkWqPATCBNTEHKMffKyBEUKFBATr4aIe5uogsvVd2hFLoHWDWrBlMfSPYPzwf
         KDdJrW4vkDvn9z4+/MyZ+Fre6TZeH1QpT487N2COnm51Vuh3Rx8TUDEN0jpjEUWy30q3
         zJplSP+67O0IN0//MsQkvoweNWgs2re8YR7+JG3Zpb6ixFwpxetRuvtRINOy86ypJia+
         EIkbkZUkdMamP86narphRjgbZSyNsa9arzzfcoEuZTYQef8clp7fVhz71wrcnP/C5v25
         VEUg==
X-Gm-Message-State: AOUpUlHzq42bBaw0GdtYmT5MUcEpz2T/6m0/8Yq+RPqtfgqFtxe1PeSv
        phE2BqA8c+kdMJ2+ZreDJfh6Ms/pTvjpszu2MSc=
X-Google-Smtp-Source: AA+uWPybvx1XoB91X0lGVqUavKmHR7d/6bkmB6Iq5gQEeOnx/i360qyc72ZgjRL9bo9bJgFPUaXH2eUdUTm8P61UDaI=
X-Received: by 2002:a02:920b:: with SMTP id x11-v6mr10366356jag.94.1534954144594;
 Wed, 22 Aug 2018 09:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com> <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net> <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net> <20180822053626.GB535143@genre.crustytoothpaste.net>
 <20180822060735.GA13195@sigill.intra.peff.net> <CACBZZX7Cmp8d=UKF2nk36fL7mR+umdKwKZAKNZSkyP0NXvquhw@mail.gmail.com>
 <d1fafc75-d6e4-d363-d600-579c200aca43@gmail.com> <20180822151703.GB32630@sigill.intra.peff.net>
In-Reply-To: <20180822151703.GB32630@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 22 Aug 2018 18:08:38 +0200
Message-ID: <CACsJy8B+FN6W32ZUgetXbEJ=Ld5ZDHHhNWVz2aiZLZG1_qA+FQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 6:03 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 22, 2018 at 07:14:42AM -0400, Derrick Stolee wrote:
>
> > The other thing I was going to recommend (and I'll try to test this out
> > myself later) is to see if 'the_hash_algo->rawsz' is being treated as a
> > volatile variable, since it is being referenced through a pointer. Perhaps
> > storing the value locally and then casing on it would help?
>
> I tried various sprinkling of "const" around the declarations to make it
> clear that the values wouldn't change once we saw them. But I couldn't
> detect any difference. At most I think that would let us hoist the "if"
> out of the loop, but gcc still seems unwilling to expand the memcmp when
> there are other branches.
>
> I think if that's the thing we want to have happen, we really do need to
> just write it out on that branch rather than saying "memcmp".

This reminds me of an old discussion about memcpy() vs doing explicit
compare loop with lots of performance measurements.. Is that what you
meant by "write it out"?
-- 
Duy
