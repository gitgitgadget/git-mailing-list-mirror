Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D408D21848
	for <e@80x24.org>; Wed,  2 May 2018 17:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbeEBRCO (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 13:02:14 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:39943 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeEBRCN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 13:02:13 -0400
Received: by mail-ot0-f177.google.com with SMTP id n1-v6so17423016otf.7
        for <git@vger.kernel.org>; Wed, 02 May 2018 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bEs2wyNIrQNHNoRWQvFg4ok69vmBG24RGdp7e2QsNwg=;
        b=fjpz+FyuI6mbvp7oOIddrgfoFpZKUQQn9I6PGAQCGrzhJpRAyrOK5NH5tfQBJtFQY+
         JdJhG2X4tkCAlIbkLAuFQ64kcaUV0Y1ll6QR7aUOP5ldKVmkh18LqG+RFLIc21h55whj
         v23L+wvoVTOtYPwGuVa4omVLPBfYg6f19XOmwEOt1i921lK1fRC+iLvQrKzP44GXn9BJ
         ApzTzL2hmZc0hpmHQRyRkEKAbdkXNdnKR4gfo9kLggbMDpqjPcvbzdcsLfA28LglqL06
         eNuShmeH9gMPlJ02+1iKraJerCOrog87eOLvkVkyF5Griiii0wE+rJ/1evqcaYmE0zdF
         8Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bEs2wyNIrQNHNoRWQvFg4ok69vmBG24RGdp7e2QsNwg=;
        b=hEFPD/LwlXO87g0dOn+bNgTPE5SzNf0B1xlOY8+W6+gdpACeia/aw65aiYT9zGGdit
         0YRZzhSIYTV4T0MwuCVyUYSPus7FIK+viEW2U1r1VPig8jbB5OXFC5EeTprQAX9AU1yx
         YGfODu+sJQuuXsKq2q7eNopjahs7NN7Pe3ldpZeThftLtY3ETQ4FbgMuq9gyawItubmH
         kd5ZqwW030dZhfIWavf58vXPMkpZihHtsiDZ7/fb9aMJi4OPYl4ItjiFh/evV2J3udaa
         a7bEjs4jE6+RGMskYdOap4GriwAr3465q0dZ05mMS87D4GqP1oGaK1kjBnYEefpRIRrJ
         87IQ==
X-Gm-Message-State: ALQs6tBPFVdc+R/jEFLewAzYVkVRWBlrSw9yb4Wi6r6EtixcN6k3bB5d
        dDrE6hGljKxH6i8M+WYPfUp4J7C9UCS6ajtDysc=
X-Google-Smtp-Source: AB8JxZqOmsvlXxyojM69a4gD7WPP5OV0GrZGs57UvM/lJy6niazLPEwsM7favQg8sGyLClMqgCKHEgJSB8o3Gwpdpeo=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr5376315otr.173.1525280533170;
 Wed, 02 May 2018 10:02:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 2 May 2018 10:01:42 -0700 (PDT)
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 May 2018 19:01:42 +0200
Message-ID: <CACsJy8DKnBRDZC=oBd8nTOAVzQf3UtoLCeoGKjcMHgUmXf-KqQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] object store: alloc
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, jamill@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 11:33 PM, Stefan Beller <sbeller@google.com> wrote:
> I also debated if it is worth converting alloc.c via this patch series
> or if it might make more sense to use the new mem-pool by Jameson[1].
>
> I vaguely wonder about the performance impact, as the object allocation
> code seemed to be relevant in the past.

If I remember correctly, alloc.c was added because malloc() has too
high overhead per allocation (and we create like millions of them). As
long as you keep allocation overhead low, it should be ok. Note that
we allocate a lot more than the mem-pool's main target (cache entries
if I remember correctly). We may have a couple thousands cache
entries.  We already deal with a couple million of struct object.
-- 
Duy
