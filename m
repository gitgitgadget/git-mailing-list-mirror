Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83B7F1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 21:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfBRV2T (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 16:28:19 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40059 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfBRV2T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 16:28:19 -0500
Received: by mail-it1-f194.google.com with SMTP id i2so1339871ite.5
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 13:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZi1DStO4RrZ0d75LWz7g+qSKaN3p2OE2th6T99CgO8=;
        b=BfdSo61EC0LjudW8UdeymcVoo8Y1xsGMoQcR2vibCLotvE/NLffz9QL2RQg0akR7Bm
         j4VcRjfL/acu5atZmF4Nh7f30bET0m33PEqn1uQ9NmOsBjeR2Wy1gRehEt4ykdhDDCiX
         BhO44UCTg0i84xPR95ixYT1pCID+L/AIw2PMV90NMSNguicl1VddyNXgPcZ8iF2Jnotr
         jCdKswhfHdxAMp3ldXWyEE4RiZTj1dXu+M6himS+aTDavEKSid5zRB3Uf2Rrq5R6/GOd
         Y9M2r/nN8AvWSz+/l+gSqPbANIfqBDeMmBGPmZDOQKWNfj8HyZmJDhetiM1jPiRQArh5
         rXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZi1DStO4RrZ0d75LWz7g+qSKaN3p2OE2th6T99CgO8=;
        b=KA018fW9inL8z7v1355F14lXqdQ1AeS+IaUqWDNqQPYFnLFDNuSi7/dgJCF3b3stSC
         1BlI0H80DFfNsj2UZv/EslxLHDbKXlRBk4nP6kyteHUmMjL4LWHSaT2hf0WPusYhi+s4
         nSjrENfA6Nwk36G0WX8lVcIyzTmhEWAby0H73OKikCxzAQT6/anwRQP/TTp+oi5zjp3W
         Juq/zIbRn0kSnGXOKMWgIv6x00781u3wgmHd+ocsMWYukVqH2o25LmIp8wAoT+i8Sst7
         ITfptIa6ZksDtITTLeKtU21kFRCh4Pk/SSv9oQqh9zHBKyCcwBehUdNNKtyEWSiy3NDI
         uBOQ==
X-Gm-Message-State: AHQUAub5F7CbFeuobwUbKtPESLzWHS2Qc4W6iN20ZhvRHGJ5PwiBGPCU
        Jb4ZPpHeyMaGwvBP6N6nQlafUyqXow/51nHIDsWRyA==
X-Google-Smtp-Source: AHgI3IZhIHhxnITX+NWY8aVhgh2WifWUxCZNdXxsoLSDvpVvcMTXPa+W6hcTzt0POJEkblDc4Bt5aCOeBlsnFibKLzY=
X-Received: by 2002:a24:9102:: with SMTP id i2mr544802ite.4.1550525297835;
 Mon, 18 Feb 2019 13:28:17 -0800 (PST)
MIME-Version: 1.0
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
 <20190215154913.18800-2-matheus.bernardino@usp.br> <CAP8UFD1pFeV6wUPpqNHkYB_3m=HQYFssJzTSrhfsyg0p+svDgw@mail.gmail.com>
In-Reply-To: <CAP8UFD1pFeV6wUPpqNHkYB_3m=HQYFssJzTSrhfsyg0p+svDgw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 18 Feb 2019 18:28:06 -0300
Message-ID: <CAHd-oW7rocXECsYdFwVefD58hxoRocw=2UZBJGSPyWjDE53zXQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/2] clone: extract function from copy_or_link_directory
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 16, 2019 at 4:23 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Feb 15, 2019 at 5:39 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > Extract dir creation code snippet from copy_or_link_directory to its own
> > function named mkdir_if_missing. This change will help removing
> > copy_or_link_directory's explicit recursion, which will be done in patch
> > "clone: use dir-iterator to avoid explicit dir traversal".
>
> "which will be done in a following patch" is enough and perhaps even
> better as the following patch can then be changed independently of
> this one.
>

Ok! I will fix that in v2.

> > Also makes
> > code more readable.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>
> [...]
>
> > +static void mkdir_if_missing(const char *pathname, mode_t mode)
> > +{
> > +       /*
> > +        * Create a dir at pathname unless there's already one.
> > +        */
> > +       struct stat buf;
>
> I know that the variable was already called "buf" in
> copy_or_link_directory() and that there are a few other places in the
> code where a 'struct stat' is called "buf", but in most places the
> 'struct stat' variables are called "st":
>
> $ git grep 'struct stat ' '*.c' | perl -ne 'print "$1\n" if (m/struct
> stat ([\w_]+)/);' | sort | uniq -c | sort -nr
>     129 st
>       6 sb
>       3 buf
>       2 statbuf
>       1 st_stdin
>       1 st_git
>       1 statbuffer
>       1 st2
>       1 st1
>       1 nst
>       1 loginfo
>       1 cwd_stat
>       1 argstat
>
> So I wonder if we should use "st" here instead of "buf". We also often
> use "buf" for 'struct strbuf' variables which can be confusing.
>

Right! I'm changing that in v2 too.

Thanks,
Matheus

> Otherwise the patch looks good to me.
