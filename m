Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF62D20899
	for <e@80x24.org>; Mon, 14 Aug 2017 23:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbdHNXPm (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 19:15:42 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35104 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbdHNXPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 19:15:41 -0400
Received: by mail-yw0-f181.google.com with SMTP id l82so63442961ywc.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 16:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ADEW9UqB+xctuw8mguYTf76/P8J+iWJbvu1LYMgUMxE=;
        b=FRbZgusc/oOOthP9tDV0xOpuTucisEBk4FJ3IRNzyDNj2yTxqO3mtmAWSWEadCIUHX
         Sz9UP3M8qdytarGY89dGBdg4gtsrfBYCOjv/MS54yz88WNYBwgEPAVcaCt0oFycxze3N
         Ffy1blXQoz1LAfbR1ZakY9pE4cLGHWdi5FUZX1ILS0XL2iCvEixwBEvDNx0eZ2S7TUMF
         muU9gLsTRBJCPj1OZ1a3TySEmsY1zvufLuDw3sdPObdIWNPNojS2jMRfIuWAd+1Rsodv
         7fNE0o4pCdC+0BBc26+IHbheGIEDpI5JQZGgIZgld7Jo87cIQhyXOg6q1N7jAQYjnamn
         0o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ADEW9UqB+xctuw8mguYTf76/P8J+iWJbvu1LYMgUMxE=;
        b=PbXGKIgmHffogJct7ephB1GDm0JH04W551fD+cYbxrSwrIKfEkY0L+6HZTsfUbPWvV
         yOwaECtsB3oSjHLgYC6PMyYhQSaIW401fNBtBaLgt6m4i6X7I1jh3zZawbWvn31w/bYa
         kbK3IxcJvPqtOBN3XbFztw8JM7IRaz9yLdpA+bCwGJcSi24iu8pEvuIdUsdh11TeDBvM
         UgLIBSuiTHh4WqR6d02v41i/uOw+VLBz+66RNZc/DVzBLCUSNq3IQ7qyEGyPM3ddcPXS
         Gu3qOotLBTo1+Jz6dCLOuK3FmxO1P3pjeXd0lFfKciPWT4EgG6ssvKbK4hpO2ZqFC1sn
         7aTA==
X-Gm-Message-State: AHYfb5h36qObcIrooRiwk0OAnlri9x4B9Apy3ca0sNT0/TS1xnQoEA1Q
        7hAeKY6AXZg40dgvVMqJgHKP1zHGyvPm
X-Received: by 10.37.183.130 with SMTP id n2mr10524178ybh.353.1502752541028;
 Mon, 14 Aug 2017 16:15:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 14 Aug 2017 16:15:40 -0700 (PDT)
In-Reply-To: <20170814230657.bmn7exoqmqw3tlyh@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com> <20170814213046.107576-1-bmwill@google.com>
 <20170814230657.bmn7exoqmqw3tlyh@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 16:15:40 -0700
Message-ID: <CAGZ79kZgRTzWiufZUE02YYOJpH66x_hShBfcv=4RWDn-qR2LUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] clang-format
To:     Jeff King <peff@peff.net>, llvm-dev@lists.llvm.org
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ llvm-dev@lists.llvm.org

The Git community is currently discussing adopting a coding style
defined by clang-format, here is a bug report:

On Mon, Aug 14, 2017 at 4:06 PM, Jeff King <peff@peff.net> wrote:
>
> One more oddity I found while playing with this that Git folks might run
> into:
>
>   $ git init tmp && cd tmp
>   $ git commit --allow-empty -m foo
>   $ echo "[mysection]mykey" >>.git/config
>   $ git clang-format-5.0
>   Traceback (most recent call last):
>     File "/usr/bin/git-clang-format-5.0", line 579, in <module>
>       main()
>     File "/usr/bin/git-clang-format-5.0", line 62, in main
>       config = load_git_config()
>     File "/usr/bin/git-clang-format-5.0", line 194, in load_git_config
>       name, value = entry.split('\n', 1)
>   ValueError: need more than 1 value to unpack
>
>   $ sed -i 's/mykey/&=true/' .git/config
>   $ git clang-format-5.0
>   no modified files to format
>
> So it looks like they do their own config parsing and it's not quite
> compatible. :(
>
> That's not the end of the world, and something we can try to fix
> upstream. I just wanted to mention it here so other people don't waste
> time trying to track down the problem.
>
> -Peff
