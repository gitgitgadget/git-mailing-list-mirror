Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55371F405
	for <e@80x24.org>; Thu,  9 Aug 2018 19:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeHIWA1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 18:00:27 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53692 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHIWA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 18:00:27 -0400
Received: by mail-it0-f65.google.com with SMTP id 72-v6so1810946itw.3
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LuFSw/Gc6gXDhFMtnt1vVkxzKSJbSken+8oM1pq7zMU=;
        b=GZAb15J3mJCkx9HfLr3P1PcDa+AWCt8ujofArqjGq6UZ0EcbzUXDkM0jfsiD6+QlZt
         ITsH57AAOo6kjV2dGWTTFhp584LPHXJD7DfTP9UQkXW3ic6P0mak3FxUhjgTtR0DB4L8
         eWFU37BiimEM5o92CMNeFVRQHJVrI1OeaYIz936RCRQaXHkk9au3a+A3LhsB/YPejDTP
         FZpsTSjjB9x3eEG/ll5rvQkSRztpM/11R3ZoIo8oEt5iob9hne0KthuBGhWTJp1uDPCr
         ayLlxKIA3mzs9MR3/Lq5m/gxTpPI1RbAQriHJ5q4fTnHbi4hn8FyC81gbggHcnQgBhf9
         BLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LuFSw/Gc6gXDhFMtnt1vVkxzKSJbSken+8oM1pq7zMU=;
        b=XBY/csw+mybksMapu9svDc40wa8XcrLr3p+Uqw7Me9sgMY7VHHrVKQt7mw5rWfbcSP
         XDRhLdw/DQZcCwidFbAI/gpT9TimkUF8cJ1oFh98AJPeMzPqhxOWnxhef4/ypP/zUUGd
         ZbMTG/ikZjaHKPnCudXVEYld2Lt/5M63HrCIoRMdyPITjFzVbHVnuIKkdfLyXp757+hG
         WhnhmmULuPLiUjoEg8R3t7HSmRvxGIWzqZy9Xnw85EMykn5HsgIs1rkW7w6DzrTL2Pri
         xmaIP8/H3mlzwTMl4Yn0clsFXhonyh7UX4iZEKNKPNW+qjFJBaDKDFKeajrvYNle/J6j
         MGrQ==
X-Gm-Message-State: AOUpUlFT2DHaF1nQDBnPDdREvr8MSuL6PXAhe1c4nV3o3lfUAwKz2Kuu
        Azdyv5/8d/CroTLNExNUylcBX67/K+pbXTa/i77RJtkb
X-Google-Smtp-Source: AA+uWPxNaTqMZ/O1dy5XzmJo4nKHRJFEPCarD6Qvh8YPGuf5j/9xOq2US1KKu7+lGPqOf59Jc7bkHBuNx6q6D22siy0=
X-Received: by 2002:a24:dd88:: with SMTP id t130-v6mr2929772itf.129.1533843250149;
 Thu, 09 Aug 2018 12:34:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 12:34:09 -0700 (PDT)
In-Reply-To: <20180809155532.26151-1-chriscool@tuxfamily.org>
References: <20180809155532.26151-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Aug 2018 21:34:09 +0200
Message-ID: <CAP8UFD27LbAiperQTbm_unZvkoThv2JjfM4wa2n5Ay=E=ZM1+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Add delta islands support
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 5:55 PM, Christian Couder
<christian.couder@gmail.com> wrote:

> The following changes have been made since the previous iteration:
>
> * suggested by Duy: move the code computing the write order for a
>   layer to a new separate function called compute_layer_order() in
>   builtin/pack-objects.c in new patch 3/8
>
>   I think that indeed this makes the following patch (4/8) shorter and
>   easier to understand as well as the overall result nicer.
>
> * suggested by Duy and Peff: rework the way the 'tree_depth' field is
>   moved from 'struct object_entry' to 'struct packing_data' in
>   pack-object.h in patch 7/8
>
> * suggested by Duy and Peff: move field 'layer' from
>   'struct object_entry' to 'struct packing_data' in pack-object.h in
>   new patch 8/8

I forgot to tell about the following change that is also part of the v3:

* suggested by Junio and Peff: increase the 'regmatch_t matches[]'
array from 8 to 16, advertise 14 group captures max, and add a warning
if the final element gets filled in in delta-islands.c in patch 2/8
