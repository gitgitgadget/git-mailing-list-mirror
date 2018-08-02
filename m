Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413481F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeHBViz convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 2 Aug 2018 17:38:55 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33901 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbeHBViz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:38:55 -0400
Received: by mail-yb0-f196.google.com with SMTP id e9-v6so1761132ybq.1
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 12:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SMTWjGkPh2LUFYBAo1iBRwr5GWsALhiLIJ37yZTq8q0=;
        b=iDOxfvsqdNrgtbKGaT8pTe6jUXAkfmbs8EGohshn+ZiNByOA+JguqXDu1qj11lUqXy
         T7DEMvQKGxSACOle8BpYzzqV4rbTuVRcTEqjSErXIUNutjavgJoI9KTDO1s0p2+vm+xS
         xEPuPPTwFbBlbv3tmkK630R1G66H6ggENqnzwbPuUl9jEbWcqPQGJLWRaDqZN1vIXEQ7
         uVykrrtUUrphQQ6lzPAJVhjIP6hNQV3bv70KNqVmQF7gGAJhv/w4pMDbPF93hMF5WqnH
         69hm17wKqH2Q8xQTWj2ONjhAYQNtVuIeDE/pIDOwi9telZL6RLgVxDtbL0uGpEEtlOi3
         T2rw==
X-Gm-Message-State: AOUpUlEz2+2m5i1prplVZ8QIxJDA9/A6FWRCz03DDA5b27okF596ogb7
        YsaaMaw1cQy9o9ccovgkGznTa3GOWQ5GwVXf9W8=
X-Google-Smtp-Source: AAOMgpeYLcLD3Qd1URUnpazRPkDQLsbT4J5c4brfEhUNi3M/b1FkR41RIR7uFY/ooFRSDpF9U3Hwzezl8OYMISLyapA=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr585150ywk.74.1533239179691;
 Thu, 02 Aug 2018 12:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180723135100.24288-1-szeder.dev@gmail.com> <20180802115522.16107-1-szeder.dev@gmail.com>
 <20180802180155.GD15984@sigill.intra.peff.net>
In-Reply-To: <20180802180155.GD15984@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Aug 2018 15:46:08 -0400
Message-ID: <CAPig+cQSg=MBB7zp5bx5Z6tep89FaqNfTXV0tATRRG3WAPn2MQ@mail.gmail.com>
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more fine-grained
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 2:02 PM Jeff King <peff@peff.net> wrote:
> On Thu, Aug 02, 2018 at 01:55:22PM +0200, SZEDER Gábor wrote:
> >     This approach uses $(eval), which we haven't used in any of our
> >     Makefiles yet.  I wonder whether it's portable enough.  And it's
> >     ugly and complicated.
>
> I looked into this a long time ago for another set of Makefile patches I
> was considering. $(eval) was added to GNU make in 3.80, released in
> 2002. Which is probably fine by now.

For the record, MacOS developer tools are stuck at GNU make 3.81 (from 2006).
