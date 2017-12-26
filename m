Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911641F406
	for <e@80x24.org>; Tue, 26 Dec 2017 01:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbdLZBsS (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 20:48:18 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:43210 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdLZBsR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 20:48:17 -0500
Received: by mail-wm0-f42.google.com with SMTP id n138so33257286wmg.2
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 17:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XNtfJQObvTkjiW9CNxow+cV1OL0GOac1uB5WNe3CClA=;
        b=rq1LbgaTf4QFRdIQakUcCOvsMNsqUNwqoeQJCDrsuo6zGxc8FMPSe6eqGRCLSOzkai
         DO8liljSw84QeQR58emYPrEdbifIsrvrfhcWOsZY2xWqGEFRMpWWZK2uucpPaTmTx2Zu
         Hr1+y88gmsDUi1Gnqt8SBTLonPpEjuxjbhfwtchGFVl86mHu0XkxBdRuX3/Tby4HUejK
         Ul02MtIYg0cJ62m2gd3WrR2qew5hdqQmwRlGZ7UJQa4piTjNGp5YFTNDskBUn0XDsLNW
         2HMwcKW2xaSk5cFQ6XqCaaqAOOn/QFnlQzoMvcf3fML+M9tyEtAyfwgfeTBWxtt4v1+p
         ufIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XNtfJQObvTkjiW9CNxow+cV1OL0GOac1uB5WNe3CClA=;
        b=VwwIq2CltKWXyvk6DCz2Mz8QKdYj9upX1eKBVGFcID2PwgFfQDZhf3dqpM2ecj4dNh
         hoH6W2XpcSQ3L71QV6jKPRM2GpoV1J5rmE9BSSKoWkl+2wTOmhXxEVCJ6fJSAYwp9NVw
         FBaWJ0JrcOI6cgOOkdEU6h+dcXBYE2xtdYJp3xt71XhxpFkfEy4pomJJpK51DPerPwzF
         cYgjE56UCDc01vbumnGK71Q1le9Dse7fpbU9BV7gZj+F4NCPa/pUBoAtgGXFsCLoEute
         58U2nmOtXHKsGJ+nRdOUtEYsRFWSDKoBgCmYrxZaDSYH5e8o46up0S5SwSG/vhYKxw+g
         wD+g==
X-Gm-Message-State: AKGB3mLIs1I7r/ZIpp4EHKDS0wN2ztCFsN2Jah3l9PBsoP8ksADQzesd
        JgaoJ2sTrWNisYFx7wM0FRlwuZXUGMZi7wHFLpc=
X-Google-Smtp-Source: ACJfBou4AI89LYNa6Cdm5/zOkTtY/KjqJa8vWZgM+I3TeadXvXDS9ANE6rAQgZsjQ3xpOd0HMEnHd+bHDEAcWsZMs5A=
X-Received: by 10.80.182.217 with SMTP id f25mr29769254ede.104.1514252896552;
 Mon, 25 Dec 2017 17:48:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Mon, 25 Dec 2017 17:47:55 -0800 (PST)
In-Reply-To: <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org> <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 25 Dec 2017 17:47:55 -0800
Message-ID: <CA+P7+xpj4o+N3uy2ea7DM-Y0oY_scayUARZMWP5QCwJEG02bZg@mail.gmail.com>
Subject: Re: Bring together merge and rebase
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 5:16 PM, Carl Baldwin <carl@ecbaldwin.net> wrote:
> Anyway, now I am compelled to use github which is also a fine tool and I
> appreciate all of the work that has gone into it. About 80% of the time,
> I rebase and force push to my branch to update a pull request. I've come
> to like the end product of the rebase workflow. However, github doesn't
> excel at this approach. For one, it doesn't preserve older revisions
> which were already reviewed which makes it is difficult for reviewers to
> pick up where they left off the last time. If it preserved them, as
> gerrit does, the reviewer can compare a new revision with the most
> recent older revision they reviewed to see just what has been addressed
> since then.

A bit of a tangent here, but a thought I didn't wanna lose: In the
general case where a patch was rebased and the original parent pointer
was changed, it is actually quite hard to show a diff of what changed
between versions.

The best I've found is to do something like a 4-way --cc merge diff,
which mostly works, but has a few awkward cases, and ends up usually
showing double ++ and -- notation.

Just something I've thought about a fair bit, trying to come up with
some good way to show "what changed between A1 and A2, but ignore all
changes between parent P1 and P2 which you don't care that much about
in this context.

Thanks,
Jake
