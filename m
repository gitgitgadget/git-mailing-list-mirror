Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1C01F453
	for <e@80x24.org>; Sun,  3 Feb 2019 12:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfBCMMM (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 07:12:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33507 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfBCMMM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 07:12:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id a16so6006174wrv.0
        for <git@vger.kernel.org>; Sun, 03 Feb 2019 04:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K7t7JVmorsI944tvTAtR6JKATq7Sf4HX8bwFRHDj3vs=;
        b=c5Sxd8pwiDoiig8Jwl9Oq4mCwqGeCJ7axqkuF+uhjMudZdG8pr9HcmJ4lQ9CTtw0wh
         /DIVSmXdSnju7tMdndYQLVRH2gOZY4XW7mGLyGb62BBsKvUd49UvMAnw/oACFJJhoPg/
         hkngKQA4nhwnqVgIhCUhQU8B8NWVaSOYuA7TmlX/SWRPOZNCXWUfXAOBoZB4hQvlgWD+
         PlGVvK3SOX7La903vZfqKD48ed7JK4Ac2IglVy7hrAZxLqEnomDgOy5zA7djEaVBhnC1
         jgr4tjmd7cZOfsKRzcemQP+PdoW3SB3oZNa5uCxUfMzN7vddO2aDkwSLBAG0CbZSlFW/
         N5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K7t7JVmorsI944tvTAtR6JKATq7Sf4HX8bwFRHDj3vs=;
        b=CyLE4dzBa03ePqeML7l0FYCRLq/2qa+kiHAYgl192H5ijXoz1CtkUm8yCwsGaue6E9
         G/5FTQ4ZCtOf3HAz8PcIRvBO9xsvh2IV8ppGiGe1Mt0DmfJ87FQSZBC6y2ZU/85MICHl
         KVdCwFhp4Ydf100vepPixZWEnwoJiW+N4HbSVMpRZ/0x6ObzoZX0kN0s5CAKhq9kHBLU
         7MukGfuOLCmFKBYnGnYSQg+ms178uhhEkIGTsVh7bfPka9EA50jY5Oq3stTybzhAducq
         SsI0bZbrVpdL72HLjyFFEKV6Fv060O3CGd0fozO3Ahmt7y10Wx+kcisFBUykGAHO0k0p
         pHDA==
X-Gm-Message-State: AHQUAuZJ8gEIZZJy8Ht6Pw8nE1H2QYGAVnuOzERKgWgxono4b1XxPVXp
        PfMZOUN4VxFFu9c4n51BhmeXSGXrpWM=
X-Google-Smtp-Source: AHgI3IaKl6oVWstfdoBfmfwIMDcQJXCzYDMpaUihEulmwQNGI1Mq3mMIECwNvCkQ/VJ01SlKhatlbg==
X-Received: by 2002:a5d:43cd:: with SMTP id v13mr8086386wrr.194.1549195930215;
        Sun, 03 Feb 2019 04:12:10 -0800 (PST)
Received: from szeder.dev (x4dbe931f.dyn.telefonica.de. [77.190.147.31])
        by smtp.gmail.com with ESMTPSA id b14sm6519366wrx.36.2019.02.03.04.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 04:12:09 -0800 (PST)
Date:   Sun, 3 Feb 2019 13:12:07 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/1] Using sparse in a CI job
Message-ID: <20190203121207.GF10587@szeder.dev>
References: <78f85f0b-176f-0b54-2ec8-4c13fd386733@ramsayjones.plus.com>
 <20190202004145.GE10587@szeder.dev>
 <719468c8-3c62-96d6-57de-b0629fab0be3@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <719468c8-3c62-96d6-57de-b0629fab0be3@ramsayjones.plus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 03, 2019 at 01:49:37AM +0000, Ramsay Jones wrote:
> On 02/02/2019 00:41, SZEDER Gábor wrote:
> > On Fri, Feb 01, 2019 at 09:01:20PM +0000, Ramsay Jones wrote:
> >> At the moment, on Linux, the sp-out file is free from any sparse errors
> >> or warnings. So are next and pu:
> >>
> >>   $ grep error sp-out
> >>   $ grep warning sp-out
> > 
> > On 'master' I get:
> > 
> >   $ grep error sp-out 
> >   $ grep warning sp-out 
> >   connect.c:652:40: warning: incorrect type in argument 2 (invalid types)
> >   pack-revindex.c:65:23: warning: memset with byte count of 262144
> >   unix-socket.c:83:26: warning: incorrect type in argument 2 (invalid types)
> >   unix-socket.c:108:23: warning: incorrect type in argument 2 (invalid types)
> >   daemon.c:1041:36: warning: incorrect type in argument 2 (invalid types)
> >   daemon.c:1184:67: warning: incorrect type in argument 2 (invalid types)
> >   imap-send.c:1022:42: warning: incorrect type in argument 2 (invalid types)
> >   credential-cache--daemon.c:180:37: warning: incorrect type in argument 2 (invalid types)
> >   $ sparse --version
> >   v0.5.0
> 
> Yeah, that version of sparse is a bit too old.
> 
> If memory serves (it may not), all of the 'argument 2 (invalid types)'
> errors are caused by the glibc headers using a 'transparent union' to
> define the 'struct sockaddr' type. sparse could not handle that until
> commit 7698bae699 (aka. v0.5.0-5-g7698bae). The only remaining warning
> was addressed by commit bcfe020ed9 (aka. v0.5.1-rc1-22-gbcfe020) in
> sparse and commit 54360a1956 in git.
> 
> So, it seems you need at least v0.5.2 of sparse on your Linux system
> (which can't be too recent, or you would need v0.6.0).

The latest Linux image available on Travis CI is based on Ubuntu 16.04
LTS, which contains sparse 0.5.0, while their default image is based
on 14.04, with sparse 0.4.5-rc1.  Even the latest Ubuntu LTS is only
at 0.5.1.

  https://travis-ci.org/szeder/git/jobs/488113660#L487
  https://travis-ci.org/szeder/git/jobs/488113661#L208

