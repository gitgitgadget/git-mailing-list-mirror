Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23EF3208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 12:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbdHIMAn (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:00:43 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34177 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbdHIMAm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:00:42 -0400
Received: by mail-qk0-f178.google.com with SMTP id u139so34285287qka.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BvhjD5U4FXKtmHMegp6hL+JLwu9v/t99NYGUI4H8n8M=;
        b=gSYaiaY46bZvwfV9q8Dh+gCma7OPYp6HoHE267qozRjWCv4VvErYsQh4Y4b99FtkRc
         oSMJgH6bAFFMFiO8Zt2wqnsQ7r/TOBnU2RytQZd3I0YKcqZGpq9nwEOr6mgvybLwdkHx
         I3phtb0rF8l+d2uQNRAAy6Q/dxCqC8z+yFkl2xEraQoHzNn1KNEdgFuUB3jfOuFa7JOI
         y3h8o1ZCFIjjx7vZAgYdhNW+/5ED10TxFrYONcMET6OPG5F02nLVnjmPBZFBywXO3GSb
         nuX+c4fesYCRZmqHTXIBouXtVsOyCWpFztoiwzU4r18Ir1hpSE7W87aTNfp8olYQ13GW
         1LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BvhjD5U4FXKtmHMegp6hL+JLwu9v/t99NYGUI4H8n8M=;
        b=fXEUxAVw7p16nEqZkZ08g0Hj2fWHMZWSdl0VcqgmAFtx5zg9hjvODV05Sz972gwE4r
         9DKsGd4Yb9dSI95JEgdcrN9t6v/xP1tmoX1J+XBLAF6u2voifoeTr5G1gG+IeS7u1u8H
         YhesAG9SCUueI277zIPbQzvVk7qyL2jgpisPYys/eeLpO015H9v+Hh8K0DJMTK2GzF3A
         yQbsgB4KIStg6jerasX6EHN4K8MRIbYeWm2+rdRIfvZDa1AloKp2ZXYjZL1tJ01iQNiP
         Xut60TU+buEMGDg5rlKapBIkmNyV1xPikUIJEdBozEWz+4paKSbhfgwT0hoEEHNpoFrd
         ACpQ==
X-Gm-Message-State: AHYfb5iGP30Mb8SQRbC2OKv6+d4Erbz+KmUpAK1mtdRsz52O1ouJS2EP
        NbUSJm5c9/lp7uEIMSdBEgoi3VWfuw==
X-Received: by 10.55.138.71 with SMTP id m68mr9545773qkd.137.1502280041583;
 Wed, 09 Aug 2017 05:00:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Wed, 9 Aug 2017 05:00:40 -0700 (PDT)
In-Reply-To: <20170808135001.48f2440e@twelve2.svl.corp.google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
 <368a1095557aa5f68cebd4d4e08628351c03b843.1502220307.git.jonathantanmy@google.com>
 <CAGZ79kYQP74fTu1hFDLyKhS-2NTbUhtirWTxRMNavgO09SenYg@mail.gmail.com> <20170808135001.48f2440e@twelve2.svl.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 9 Aug 2017 14:00:40 +0200
Message-ID: <CAP8UFD20_Q7djbJfMmrGEnN3j2NasHyvuNAfZHMr_bNRjO0qpw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] pack: move pack name-related functions
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2017 at 10:50 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, 8 Aug 2017 13:36:24 -0700
> Stefan Beller <sbeller@google.com> wrote:
>>
>> There are also packed refs, so one could (like I did) think that
>> pack.c is for generic packing of things, maybe packfile.c
>> would be more clear?
>
> Good point. I'll use packfile.c and packfile.h in the next version.

It looks like you used "packfile.c" and "pack.h" in v2. Is there a
reason why it's not using "packfile.h"?
