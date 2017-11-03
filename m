Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE11202A0
	for <e@80x24.org>; Fri,  3 Nov 2017 09:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754742AbdKCJdA (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 05:33:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44649 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbdKCJc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 05:32:59 -0400
Received: by mail-io0-f196.google.com with SMTP id m16so4985804iod.1
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=29U1QbwtJeqhqAq6NM2Ccg3aEUPmQihBQo42LL+V42k=;
        b=rGybqYU+FxVTjezcziaqNir2A5xTraSlu42PLEhRbTxWiCpW2G3f83CXg/zOfK+gms
         MWKeKGD17utuDjFoxQY2Z7mB2frt2MG/HRefWv548WQZK2DtngLsew2ZMaD7vF0z8H4f
         5lNXCIFWy9npjQBfpO1Une3ONMohyDL/aCODt/ioV96GC4nMNfS30rzbIZrtKcuq/iF1
         SW97gyrU9HiJ6p0X68kX3hrLAYfkHr8BDVGXlPQvU3lR8es0QfHrUO8xIYDozYFQkQ1l
         1B1SceIMBS2ylAtuBVcHM5zf85ySWnwv7dVpvv33WrbwwllLJXsih1A6xK0dhaaTvDIA
         z9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=29U1QbwtJeqhqAq6NM2Ccg3aEUPmQihBQo42LL+V42k=;
        b=T+bAN2H461CCbkTOyOqkOdShdMGFsvU0/DG9rc7ePAh+CNGGWxn95zb0vRHFaW5H5m
         yuiOfVrf2JHeTVD/yTXlrBxlt2GRzpLJOOqXRm9RRQ0sVfHbmzd7l8erBeCaoVN/Mz55
         Du3CrfFh/btSrE6gC/T3QhAcS1iN0PKFwhFpYv1CtAGVrROU7tagnle36qTb6kviosZB
         dOe4sOCSmUN259bOM+kaHnmDgL9xP9E1Vvh1klRMPoaGlJwmUoSa6ilRx1Qz4MPck0L0
         /+mGhryTVHzQzo+43leyIbPpy2XCcsxxAdKEtR+rnPuYcKjLTYJqPZ4M7TqFUDM2E4l1
         QXGg==
X-Gm-Message-State: AMCzsaWOnbuoLqwtsI+MYx1S1nP2wWU6KrD3OmNyX2k3+xh3FwmmeLWb
        5Nfz6ICAO0+/Utpu94NnMlY=
X-Google-Smtp-Source: ABhQp+TnRZlyevYgBjfix1Q9xz7aoa60Zj+WjesouE4SzlgaluJImfknJNFgGR2f3FNloRB2IQRm3A==
X-Received: by 10.36.76.1 with SMTP id a1mr6604185itb.94.1509701578542;
        Fri, 03 Nov 2017 02:32:58 -0700 (PDT)
Received: from [192.168.42.176] ([117.251.239.143])
        by smtp.gmail.com with ESMTPSA id z201sm2604998iod.6.2017.11.03.02.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 02:32:57 -0700 (PDT)
Subject: Re: "Cannot fetch git.git" (worktrees at fault? or origin/HEAD) ?
To:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
 <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net>
 <CAGZ79kZc+O9gM97bVZETE3sgkmc-t78Nf_Hq6=K4Gf2yaE79zA@mail.gmail.com>
 <20171020060443.l6v74ik4v4jdt4ky@sigill.intra.peff.net>
 <CAGZ79kaeJsahVuWgFsJfyGahciT4xBeM3m59F5crGy4+ZRJMCw@mail.gmail.com>
 <1508682297.6715.15.camel@gmail.com>
 <20171023003647.4pvzmhk7v5t6zqm5@sigill.intra.peff.net>
 <CAGZ79kYAn0Hi0qaG8P5zvVOFTsfXYrtvrR7oiT0KwwWeKLqZgw@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <0f1f8317-9d82-5e61-5332-f877ca886056@gmail.com>
Date:   Fri, 3 Nov 2017 15:02:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYAn0Hi0qaG8P5zvVOFTsfXYrtvrR7oiT0KwwWeKLqZgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 23 October 2017 11:07 PM, Stefan Beller wrote:
> Exactly. By memory I mean volatile RAM (as opposed to
> memory on a spinning disk).
> 
> Using GIT_TEST_OPTS has had some issues (I remember vaguely
> there was an inconsistency between the output of `make test` and prove),
> so I put my entire working tree on a tmpfs, I run roughly this script
> after booting my computer:
> 
>    sudo mount -t tmpfs -o size=16g tmpfs /u
>    mkdir /u/git
>    echo "gitdir:
> /usr/local/google/home/sbeller/OSS/git/.git/worktrees/git"
>> /u/git/.git
>    git -C /u/git checkout -f HEAD
> 
>    cat <<EOF >/u/config.mak
>    DEVELOPER=1
>    DEVELOPERS=1
>    CFLAGS += -g -O2
>    CFLAGS += -DFLEX_ARRAY=2048
>    #CFLAGS += -Wno-unused-value
>    EOF

Did I thank you for a good explanation? If not, thanks that was 
interesting and enlightening.

> The test suite (excluding t9*) runs in less than 50 seconds on the ram
> disk.
> 

BTW, this is what I call _way way_ faster. Unfortunately due to the 
limited configuration of my system, the test suite has following timing

     real    3m14.482s
     user    2m10.556s
     sys     1m12.328s

Anyways it's better than the timing I get for running it on a spinning 
disk which takes

     real    4m37.585s
     user    2m17.244s
     sys     1m37.136s

Thanks,
Kaartic
