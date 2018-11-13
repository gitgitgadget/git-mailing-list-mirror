Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC811F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 16:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbeKNCyd (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 21:54:33 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35485 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKNCyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 21:54:33 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so19493511itj.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zHY9jV1Y71rG6iXU0R3CQpTG1RXMJ7i0G04b20EnMzM=;
        b=EOcr5SVTEv8DRRTmvCeH18+Z3TwJjirmxYHP7Kw5jRmHMqbr6klt5rVq9hTEYW6nKq
         Fmo41lTW+dR/j0NjcG4EQPbFpFDdrvbASttB2LfdtHAcU20/nZtKD9ZuC/2mZrsa+uyy
         y4CrWN7OXtk39kBxfkeT/FklqpRAb75EUfyl2PBA+o8RJvOmtuKMigQS1ytQBDxv1wov
         h5A6/l1qbiQ5marnMxMxGafXcp/dHPnQSo2pVC8V4ESFy+SOIaJXyQ3Ke/ow9JPYLD/p
         zItQVM4iv6imZbACKV2IEp0Sg/iDTgo2Oo12eKpCcmSCrAayBCO6MiZT9N0fDqO8mvqi
         KSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zHY9jV1Y71rG6iXU0R3CQpTG1RXMJ7i0G04b20EnMzM=;
        b=FRYuzxI/GkHEzBk2EZDxBcwL2zla8vau6EKGHAssyn/VeUgkgg1ps+GUdaA7hMzpdg
         gC3ZQCY6l46xEcPD8PvJkP7b2rtTVQnbrWrpRtO/QWuvriwrPJz9jzoXcoq2yDfy3RaY
         Puo4erftqcM0pczQ//VggZY45PKRo4gBDzhuBPbntX1hQAroZUaUfSx0eP7gAOewjVmy
         DO55JQSi54tisg6OAvCFGP9L/j7LTdsDkeqku3nbQi0ADXOQD68X0dIcZVm4z5O2aN8P
         p4/ebf8BmGjWu6/uAU0vBuTJoTJGsxy4nIpPLSkt0oBTWNBl7uWa4wPL6I44rTHuHmj+
         +jXg==
X-Gm-Message-State: AGRZ1gLBPnO0evrpMfJCGBngqUmJAaJ+tKxgkzmV58/wKuLrmIjQlJ7C
        55yTOaYkgDj70o9v+my+a7rnK8EUFQ7y1pvttoo=
X-Google-Smtp-Source: AJdET5f1dPfb3DhSvyabIxWpAxaeBMfqM5kCONYW1ALzg9pcaDqEGkGld+alY/3cef+/qqnYrHx9jNScE1jOr1cym2I=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr5470839jah.130.1542128138141;
 Tue, 13 Nov 2018 08:55:38 -0800 (PST)
MIME-Version: 1.0
References: <874lcl2e9t.fsf@evledraar.gmail.com> <20181113153235.25402-1-avarab@gmail.com>
In-Reply-To: <20181113153235.25402-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 13 Nov 2018 17:55:11 +0100
Message-ID: <CACsJy8CaAC0UP+VxYU7zbdQc6DtKYa-FzOnbpNf+_P2L3zfUvQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] read-cache: write all indexes with the same permissions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 4:32 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I won't have time to finish this today, as noted in
> https://public-inbox.org/git/874lcl2e9t.fsf@evledraar.gmail.com/
> there's a pretty major bug here in that we're now writing out literal
> sharedindex_XXXXXX files.

It's not the end of the world because create_tempfile opens with
O_EXCL so if two processes try to create it at the same time, one will
fail, but no corruption or such.

> Obviously that needs to be fixed, and the fix is trivial, I can use
> another one of the mks_*() functions with the same mode we use to
> create the index.
>
> But we really ought to have tests for the bug this patch introduces,
> and as noted in the E-Mail linked above we don't.
>
> So hopefully Duy or someone with more knowledge of the split index
> will chime in to say what's missing there...

I don't have any bright idea how to catch the literal _XXXXX file.
It's a temporary file and will not last long enough for us to verify
unless we intercept open() calls with LD_PRELOAD.
--=20
Duy
