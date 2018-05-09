Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4751F424
	for <e@80x24.org>; Wed,  9 May 2018 04:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933675AbeEIEXU (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 00:23:20 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:37778 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932801AbeEIEXT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 00:23:19 -0400
Received: by mail-pg0-f49.google.com with SMTP id a13-v6so22092674pgu.4
        for <git@vger.kernel.org>; Tue, 08 May 2018 21:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EiuIskVIiayxrEBVP8AGf6hPRJQIDWrJrm6Fz1yQqn8=;
        b=OtdMjKTuoGamD2vaDUQeevmmfx3FPCYSJl02CfDRMayQGewYZAfDyW2h/iBPpDuJVO
         6OLa6M8r0L+4j9wIvxwn3TSemPwR7JMCKdmAF2KLraNW95RkVLHokFg/fb4FbGNSu6dK
         vEZ44Psfdq5BzxnXWOfONE3QGp7cpxzR689mUROU+IsLaPYUfSj2OwaFwh9a8PgqmR1D
         JYYbLT3QRbjXCQ3vfq/YKRWGrUt9V8mIYDitDogmgB68ht9PrLd8jhWtbvuoYbpNMzzt
         q6LgTZEGV5wmgIveZv/hqF5uD8bry8XufRruQowwk7spLGexRvwFkGYh9cHrYMooci+9
         4vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EiuIskVIiayxrEBVP8AGf6hPRJQIDWrJrm6Fz1yQqn8=;
        b=hSQexLpY6TOjCxACEs1cUAwLS5E4tGfnjSaZA5RKFTNLTU/gXimGg3rU2r+oDI5CC6
         quD2Br9p5NKB5JxsU4oM8fAcZK4S6iyJZHsEcxYtnFYr/lpKnYjxDNmj/rlaT+coy9Mf
         xRma0WKZp4zGGXVPFssCLAEbn4O2LNjYtiyaBqYat9kFT/+9Siu8sRMJ7IJ85jTeuaYh
         tE6MvN2lhzeLe07yX2gDjWkvI32l9yqTIIEzIoteydq+Oaf2ohPYSqEdqZM+eJyi8Ov/
         nm9v2krtyHW6Qt9O8JlQr4fCBass/73kOAelAdS7bJyREhDkllGVvJIzarSSRwSkkGdk
         eijA==
X-Gm-Message-State: ALQs6tCtudHpwHMvEexcHXehANXyp9NXoDgQuSatzIvutSf2UFO9BChQ
        LA4Whln5ZN43Z5bRQBu+ZJN3Xlodra14iDRS0l0=
X-Google-Smtp-Source: AB8JxZpnv9n+f8ffm6Zzglt/wMkSPK830WvIiystKkXW26ZLx1HnWCanNpldumGks6i3QO9b9v56TvUpLV2gXdO5NE0=
X-Received: by 2002:a63:7e08:: with SMTP id z8-v6mr27253229pgc.383.1525839799011;
 Tue, 08 May 2018 21:23:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Tue, 8 May 2018 21:23:18 -0700 (PDT)
In-Reply-To: <20180508181034.GB7210@sigill.intra.peff.net>
References: <20180506141031.30204-4-martin.agren@gmail.com> <20180508181034.GB7210@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 9 May 2018 06:23:18 +0200
Message-ID: <CAN0heSps9reV82=Sy0J7g3Ewr2fqiPcCT2XBVPNk2yPi+4+mrQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] refs.c: drop dead code checking lock status in `delete_pseudoref()`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 May 2018 at 20:10, Jeff King <peff@peff.net> wrote:
> On Sun, May 06, 2018 at 04:10:29PM +0200, Martin =C3=85gren wrote:
>> Unlike in the previous patch, this function is not prepared for
>> indicating errors via a `strbuf err`, so let's just drop the dead code.
>> Any improved error-handling can be added later.
>
> I suspect this ought to eventually be converted to return an error, to
> match the rest of the refs code. And in that sense, this is a step
> backwards versus leaving the current die_errno in place and dropping the
> LOCK_DIE_ON_ERROR flag. But it probably doesn't matter much either way,
> and whoever does the conversion later can deal with it.

Thank you for your comments on this series. It's much appreciated. I
will be rerolling this series with extended commit messages about the
lock-handling. Looking over this code again, I notice that a larger
cleanup of the error-handling might be warranted. It would indeed feel
better to do a minor part of that, instead of taking a small step in the
wrong direction...

Martin
