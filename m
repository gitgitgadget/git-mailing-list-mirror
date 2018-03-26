Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694D71F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeCZRKX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:10:23 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44437 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeCZRKV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:10:21 -0400
Received: by mail-ot0-f193.google.com with SMTP id x6-v6so19974639otg.11
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DaCWOUsf6fvmnmVxjOWXb4wlzq9HXZ5X2yQkv1yre3Y=;
        b=A3yD6n85k7O0evgkRVyw45PgkI8Ze8dzLluArT1AUZSqhJJ2CWhKuaSxcfvw0f10y6
         XYzahUMCybZAqfVNE7uGc806vz+JyYjgJeiRXoXFuebCvAdYtyHQWcOPPcHdq9bQArMh
         2gngACKGMJbpiF+JLmfEAuOeAthQKDSz983fv6Hg9+MUW8X6ID2NKgcquNPrdXiwf7z2
         QVX1uMMRAJa811q+dfCmNXnrZr33yD2t+wW43zJ9oaOOXWoaPcY1hIre3RiGa6pzUItv
         AD0gE/JqnR0EzuoOAG5ACy5h5eU87xB/dYa0eOHi5jRy9Ew5NxzEE4Orsq78PCiGxIJV
         ewEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DaCWOUsf6fvmnmVxjOWXb4wlzq9HXZ5X2yQkv1yre3Y=;
        b=i1Ce03xmlw0/xW5RKRw/Ws7Rx/eyCRMJdgxaAC6c3/NBVHNVexDpAt45k9/HZlumW9
         bsRA5BDWsIBBC9gthT90jA8YhmLyiFDLFszT0HRoovpUZb5yFRIV9+ZLffsUV34Wtts4
         FGRS3wooSDNZSOjm8v7/ShA819DolAtL2n7YbIJMWoNcgMMgIcJH0s3723WaMgaYau+d
         nhA/vjEmuuPCKNHtdmYHyKHGJ95DxJHI/RLJYpevrrODigC7SyfdhcAi2kFeDR877QHN
         9irmMfjtBsLzJqVmpft4QLN8p2pVp+nlyEAujydVmH0WLhAg5oUqXyB6nRNp+c+yG4mc
         R8cw==
X-Gm-Message-State: AElRT7G1F8kCx4FePwHkRUx4ItO60dykTEPoSgw1iGkCcKCPYdyzf/RP
        J3Q4/3AFuDGbSTP+OYtZ2XXVr1lYWkhePIuq/RY=
X-Google-Smtp-Source: AIpwx48/52YuHYNQfKePRx2fzafxcQPkKMMc/r8UbUaBTn4AAKFxCTOXJBPnPTYan8neEF/gnksbyEChDShmNI7Fur4=
X-Received: by 2002:a9d:e84:: with SMTP id 4-v6mr7862921otj.14.1522084220499;
 Mon, 26 Mar 2018 10:10:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Mon, 26 Mar 2018 10:09:49 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803261722350.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074505.19100-1-pclouds@gmail.com>
 <20180324074505.19100-2-pclouds@gmail.com> <nycvar.QRO.7.76.6.1803261722350.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Mar 2018 19:09:49 +0200
Message-ID: <CACsJy8Dz87YHiA48m_X7OmJXioKorUDNSyPy250jaqU7xt1JXQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/36] t/helper: add an empty test-tool program
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 5:27 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Sat, 24 Mar 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
>> new file mode 100644
>> index 0000000000..c730f718ca
>> --- /dev/null
>> +++ b/t/helper/test-tool.c
>> @@ -0,0 +1,27 @@
>> +#include "git-compat-util.h"
>> +#include "test-tool.h"
>> +
>> +struct test_cmd {
>> +     const char *name;
>> +     int (*main)(int argc, const char **argv);
>
> This makes the build fail on Windows, as we override `main` in
> compat/mingw.h:

Sigh.. not complaining, but I wish somebody tries to compile git with
wine (and automate it in travis). This way we could at least cover the
compilation part for all major platforms. Probably too small for a
GSoC (and making the test suite pass with wine may be too large for
GSoC)
--=20
Duy
