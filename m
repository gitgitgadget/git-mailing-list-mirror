Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ABF71F404
	for <e@80x24.org>; Tue, 11 Sep 2018 15:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeIKUtD (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 16:49:03 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37266 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKUtD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 16:49:03 -0400
Received: by mail-wm0-f48.google.com with SMTP id n11-v6so1528954wmc.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o0P/E6t/J3RlT2XBcq2geM/o0cA19P382cbJuCFzgEE=;
        b=pkkZajSYlwwyDRD2c/c6C/bxZoVkZFjhrugQe9AApTRQf/wEbhKtFGG9hc6DyrULpQ
         jJqLmNQf8wyynMTBZvRH36Wv7/RuxtZkq7L0IMp1W/aRQ5Tk/0UPVdleBEtgBXqP/Bfa
         Z53Dt9WddhdKWiw24wX6/nLUchiTmCQjic9kgdZjivUQ2+8FmSG8/f8Z1LMWZ5dRQFwh
         U/ECDl0tA0pxlibqVsOtahRr0jNsLro5W62NWtFEoPsFlZJS7S0xcVfQOHStORFFEyiz
         BPLJQnXoDj5Oenc1mmnS7NreBKIw3MP7ZHdO0Q3ThW8rfIUyhnb8nC3dGAMXZQLUFcE6
         Y5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o0P/E6t/J3RlT2XBcq2geM/o0cA19P382cbJuCFzgEE=;
        b=O9hCUMc5OnJWSwQXfT/cjQktuAWsOCLR1rEkIg+3P/egsOIUmcTFJ6vF1ZROH00Dvf
         ntfTcXFNnYdefsHRvDUI6reJF7a4Pe4MTt+4FNZy80kiMHrxzxjoRI1g1oYXMiQFoh64
         ZPje3QtHYWXriq882mjRVBwJyhoZnbTWic2PCPel4Objq61/qm7VO36Y4QDx+JXVHGcB
         66MkiRZaE36ZVomQDCWJtzqfwGWFcguDr1Ue1bf0xWCCa8ef48AA47oUa3+yOood4P27
         lvoNz5q/8RP/kmOLnGxTVXaG8bWkKya/2xwelhA7xw2spGSR+IzXu69sbQ405xlqkYqr
         HcfA==
X-Gm-Message-State: APzg51AGhkjOIO1XAH+DrvkRRyGdmYn+AK6LKrMCTioSpg8H9PTXI+ED
        yJCr6TR+XUOyLbLRCT48Oyz864bk
X-Google-Smtp-Source: ANB0VdbreFe9wnKPsoKccngdITa47rA69EU52nnHPWt4JO9W8kbsfSe9TfGqCKeINx5DmFvGXA99Ow==
X-Received: by 2002:a1c:a78c:: with SMTP id q134-v6mr1897138wme.42.1536680948100;
        Tue, 11 Sep 2018 08:49:08 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id n14-v6sm708850wmc.14.2018.09.11.08.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 08:49:06 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:49:06 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     ryenus <ryenus@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: Git 2.19 Segmentation fault 11 on macOS
Message-ID: <20180911154906.GA4865@hank.intra.tgummerer.com>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

thanks for your bug report!

On 09/11, ryenus wrote:
> I just updated to 2.19 via Homebrew, git range-diff seems cool, but I
> only got a Segmentation fault: 11
> 
>     $ git version; git range-diff origin/master  HEAD@{2} HEAD

Unfortunately the HEAD@{2} syntax needs your reflog, which is not
available when just cloning the repository (the reflog is only local
and not pushed to the remote repository).  Would it be possible to
create a short script to create the repository where you're
experiencing the behaviour, or replacing 'origin/master', 'HEAD@{2}'
and 'HEAD' with the actual commit ids?

I tried with various values, but unfortunately failed to reproduce
this so far (although admittedly I tried it on linux, not Mac OS).

>     git version 2.19.0
>     Segmentation fault: 11
> 
> Both origin/master and my local branch each got two new commits of their own,
> please correct me if this is not the expected way to use git range-diff.
> 
> FYI, I've created a sample repo here:
> https://github.com/ryenus/range-diff-segfault/
