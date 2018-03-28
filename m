Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36921F404
	for <e@80x24.org>; Wed, 28 Mar 2018 12:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeC1MY2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 08:24:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36697 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeC1MY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 08:24:27 -0400
Received: by mail-pg0-f65.google.com with SMTP id 201so866666pgg.3
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YXU+VGc7yvRKMhdJIvxFiqvI6dgWpBM6McYDBCsYRG0=;
        b=ST+IMjFNBn7QOGohYhKDL6nvqd5i1ybGiTevfu02hCCwnBPUZs6qF2PGwtClBOXtj2
         ZHcWiUitTbOiJ+cPW2yKaFEoKx16qPbkb/a17UNcUT7026YnXQyW6rGWsvg5oYX9tMsE
         XED0dFg1TKcd7Eo2Ah8+Byvcf+9MO1xL8+1ZIsPBFWrp2/RgQc1Qq/QHeCgkjLX2CbzN
         YXaAiXBPMZkEH0P8Gvmt/0ckwijjQ8hGzF/ps/HF2Ks7cUwgAVzuRmcMIhCE+5LS9sm8
         nJsI5k1tdw1bZkCY2XQmxuFXCDFEavyHIRgywSQsVH1F9R6egpe9vOGp2oLKoUbwZeVT
         Nngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YXU+VGc7yvRKMhdJIvxFiqvI6dgWpBM6McYDBCsYRG0=;
        b=LaiR8x9XhpIApz3NuT4y5/kRajowWH791dzA2zkvpAvDt8XrUIK+gjuxA9QdwuCsLx
         h6wTXw/lPG3J4EQnncW+vnZbIlxy0ruWHq1bPTVeMYIkpPLQD96+CwyBw+oiYtMrOsnw
         a5Dwveg4Nqg5Aq9UoGvgmy1OrlQZBW+JnbB4CTYSFbRSjFqIWjegSKOhhxJe/0MSxfIe
         IW/OP7ZSEuOg2l7EHIXXn163M2J5bRtdJzws+VJ/+pZTBUMLCS0DNXd6uPE3UR3Q+oVS
         cTFVNm3DdkglNGXuUvNOinb1e1t3aU4xNAJzCxaXJ0WyDLzsjkauLRZB0J2GKHLrsily
         OnEA==
X-Gm-Message-State: AElRT7EqCy8bmF3Z0ot6gPglarKHDCTFDJZKHi+jcgHwL62DzCdnd10v
        YE6vEAdJc9FE2dCBbE4krVoxXHMQPnpbxeJzYDsUbw==
X-Google-Smtp-Source: AIpwx4/awuL6ab/GNBsbUbAUFCD1WpK5pVbtKEkCqU2kz4TztyT8nO6f9ivTaM7h0JQZXfUKc71TbRJxlW29c+LJAes=
X-Received: by 10.101.88.130 with SMTP id d2mr2418871pgu.383.1522239867431;
 Wed, 28 Mar 2018 05:24:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.191.141 with HTTP; Wed, 28 Mar 2018 05:24:26 -0700 (PDT)
In-Reply-To: <20180328084839.GA31002@sigill.intra.peff.net>
References: <cover.1520680894.git.martin.agren@gmail.com> <20180328084839.GA31002@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 28 Mar 2018 14:24:26 +0200
Message-ID: <CAN0heSru4-VoCTxZ6OHU_jdTs0__xvRmd45Dd0H3L8apMKkW6w@mail.gmail.com>
Subject: Re: [PATCH 0/3] shortlog: do not accept revisions when run outside repo
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 March 2018 at 10:48, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 10, 2018 at 12:52:09PM +0100, Martin =C3=85gren wrote:
>
>> Someone trying this out might notice that `man git-shortlog` renders
>> "\--" as "\--", which is not wanted. (Also visible on git-scm.com...)
>> There is quite some history around such double-slashes and compatibility
>> with AsciiDoc-versions, so I'd rather not do a "while at it" there.
>> Regardless of the destiny of patch 1/3, I will follow up later to
>> address various forms of "\--" throughout the tree.
>
> I didn't see any follow-up here, but in case you were delaying because
> the history search seemed boring: dropping the backslash is the right
> thing to do.  See the discussion in 1c262bb7b2 (doc: convert \--option
> to --option, 2015-05-13).

Thanks for pinging and thanks for the pointer. That commit is indeed
helpful and I am referencing it in a local topic, which I will submit
once ma/shortlog-revparse hits master.

Martin
