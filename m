Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DD8B202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 19:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754991AbdKATvh (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 15:51:37 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:47109 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbdKATvg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 15:51:36 -0400
Received: by mail-qk0-f179.google.com with SMTP id m189so4150968qke.4
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PdZHGeb14b+KW1uGAEwcOXL8lkweUmJ31FliFvK1BPU=;
        b=NJmowrDHYQftnVxFm+ZjYa1gIdyUmG/cvZBfNwIbpa85ZtoXPJDsNoMdbgOy02Fx71
         bewPVtFYn24u30HMjeMyxrHWw9zuwtUcnp/lYx+ACwsqmOBEbTNyRPhyzp+9hLEUzw5+
         wMvYTp4IumUNEcgju2z3n+1VETFfu13+yMIiGbVn0s0xgLY1bah2g+BKEe8txkbPYS/m
         +JC3VB6ISWaFLT8LBiaaXaHtgf5TaSdc8osW1RIgkYCz4cfp32TKNYMZQ0u+fFPln3NC
         rsU0i4abzJhCVjsno2ilEFU9c5vjwQWPbDBlB3t3YOgJWiVK5upg0txyl4LLu0Gtg2pr
         I8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PdZHGeb14b+KW1uGAEwcOXL8lkweUmJ31FliFvK1BPU=;
        b=I4UcCqnoU1ChDGceGDepp5QgyjFRz0rMA7umxvi3CTxAEqZTvdaE2MrYZB+/aFZYdP
         hr5n4p+9lBoKwa6JVX6myvs6MzNWWimDW4FlBhvmCVPF5SCTGIpxoFmXcGshqYnLnyx6
         +xgGhWbEVmC/4JA/jQPDDfptm3D1OPiSU8KcOwG5JS8g0nvNUxJiqMSdnuuiOufs0I6/
         PH2cXKMdrYAw16zYNiDQIYbGeoR9kdq2FT12QpvyECdPXVPSLgXL5D6kz41WCGnKKs/o
         83OrDdpgw/seHYtzGUHx90dWg55HTDY5jPG/6VxmODIvcIQvIXNSjICIgFVT2YoSk+iO
         wAkg==
X-Gm-Message-State: AMCzsaW+/6ZtEVVo0aLLNV9DGMsKFMD5BpFTw0aGSWDCiZ054pYk9UbM
        TRUcn+kqZd6dN1qXsBGwL84bU9GpCrVjDkKVad0jf+rwqNo=
X-Google-Smtp-Source: ABhQp+QbRHnRFBKdd4Yrpz+dEbiIGX8bQA1D3KgYLA+Mx1PcUFgzry/1g6jUiBCWMdzxBE58SMSyJ0CwzrVMQJY1+pM=
X-Received: by 10.55.33.203 with SMTP id f72mr1607262qki.176.1509565895454;
 Wed, 01 Nov 2017 12:51:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 12:51:34 -0700 (PDT)
In-Reply-To: <CAPig+cRz6EjdEGUjdMiB8979VybKN8Xza9uUDKNuxKNn+pY8jA@mail.gmail.com>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-7-sbeller@google.com> <CAPig+cRz6EjdEGUjdMiB8979VybKN8Xza9uUDKNuxKNn+pY8jA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 12:51:34 -0700
Message-ID: <CAGZ79kZ86fEvtF4rdPiAMW_x040AmwTWUnY4g1ixMjooFjU6Fw@mail.gmail.com>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 2:49 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:

>> to make up a name for the commit. These names are ambivalent, there might
>
> I guess you meant s/ambivalent/ambiguous/ ?

Indeed!

  ambivalent
  early 20th century: from ambivalence (from German Ambivalenz ),
  on the pattern of equivalent.

In German ambivalent (~synonym to mehrdeutig, "multi meaning")
actually means ambiguous, one of the false friends!

Thanks for pointing out.

>> [1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> Blank line before sign-off.

fixes.


>
> Not at all worth a re-roll, but less nesting and a bit less noisy:

fixed.
