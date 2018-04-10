Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CCD51F404
	for <e@80x24.org>; Tue, 10 Apr 2018 19:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeDJTK4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 15:10:56 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35019 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeDJTKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 15:10:55 -0400
Received: by mail-yb0-f175.google.com with SMTP id c1-v6so4700775ybm.2
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 12:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BKGseMxbQ2K5jbCi/rFMk95fqCry+0ToKysKlmM8q+M=;
        b=b5RsNyZ9lZBtXrXofJjPYqKS5cgz6NSqihAtmbO4fzwikfCBpLx3RuGemYiZ3PoSwx
         R8DevHbDa3NKXfgGAFqpUkzqHzsYsN4sCVJuyNyTwm6gXrmKtKuMgqCnFJxq2FmGXDFf
         /lSv7CLzuaXoV3ji62fnXIICPOlRszzWj4W9PCAO9KWjkDr0ntvr+pp+bubn/hYng83a
         V+tjCy9aAVxYSjOSLtFeBgWHPcTPS9dAHIzQ3b7F4818RU2ob1HJMi+hR/ZNs5rVPT+A
         2rwk6ALW/2myPHafGIuZ7lred2UqLbqnxmDFRZ7tK9n00/F+J4Dgv8I6KJPl3DlwcgZp
         bW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BKGseMxbQ2K5jbCi/rFMk95fqCry+0ToKysKlmM8q+M=;
        b=osU8Wcuv1Iup5ntU0VEJqkzl7aRQ4cdK3cczHtFQwyw3uDnv0ONLIF+K50byZZDFYe
         tPFjr1I1eS6+7MZ0gGP4X7Rx8/p+bq5UktItuN73Sy9X1EZEiWcyaTP7jdExrcdmpZkn
         5IhuAUURDxTC9UP27Dc8IFT2tdjU03LZcM5vm62W50aGn6qLc9qbhsOgAN78p8uiwpaa
         AMAi0X+2C3vbQh8d8YK+yZ9BXmi9rcJpYWM58L3/7kZ4Qhqr4zSPxRSfFi481BYcrkLJ
         KKbAUQVlaJzszwKhyzcMN9DQ406JDNIcNdQjfJeeKTykDHDgRqgcSbIF6NtjPWjeliL/
         jD7Q==
X-Gm-Message-State: ALQs6tDJy09EfVqQQA6Mgs9iTC3mwl+smwVl8ufJDNkg31tqudcrwvK3
        i972iOcYPImUa/5t23BGOov3SH8WWw3naf4j+6kdSbxoNXE=
X-Google-Smtp-Source: AIpwx4+VsMpYT9Z/bECnXAkwaVY6w72Bk0LfFVT205gslQQGve89HGlNx4GNVahZnWGMV68d1PMycZF9qPTs/ETCiBc=
X-Received: by 2002:a25:ba51:: with SMTP id z17-v6mr1039424ybj.334.1523387454636;
 Tue, 10 Apr 2018 12:10:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 10 Apr 2018 12:10:54
 -0700 (PDT)
In-Reply-To: <20180410125608.39443-4-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com> <20180410125608.39443-4-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Apr 2018 12:10:54 -0700
Message-ID: <CAGZ79kYDXTGdS8sx-iW_JNdk7icpwdd3Opwbjw1cL8gMs_47dw@mail.gmail.com>
Subject: Re: [PATCH v8 03/14] commit-graph: add format document
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

On Tue, Apr 10, 2018 at 5:55 AM, Derrick Stolee <stolee@gmail.com> wrote:

> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
> +      The ith entry, F[i], stores the number of OIDs with first
> +      byte at most i. Thus F[255] stores the total
> +      number of commits (N).

I was about to give this series one last read not expecting any questions
to come up (this series has had a lot of feedback already!)
Although I just did.

What were your design considerations for the fanout table?
Did you include it as the pack index has one or did you come up with
them from first principles?
Have you measured the performance impact of the fanout table
(maybe even depending on the size of the fanout) ?

context:
https://public-inbox.org/git/CAJo=hJsto1ik=GTC8c3+2_jBuUqcAPL0UWp-1uoYYMpgbLB+qg@mail.gmail.com/
(side note: searching the web for fanout makes it seem
as if it is git-lingo, apparently the term is not widely used)

I don't think we want to restart the design discussion,
I am just curious.

Thanks,
Stefan
