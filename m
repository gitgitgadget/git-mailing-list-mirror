Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588CC1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbeGTRiW (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:38:22 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:39188 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGTRiW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:38:22 -0400
Received: by mail-yb0-f171.google.com with SMTP id k124-v6so4862078ybk.6
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wsxcmjf/FzpYwVMJgM1cBYyND9v+GVhQE/vwrIXOMs=;
        b=Mfhk3J7vghpqDoCijPZ1hVp8eaCpp1qpMWseglf2RAYmqWHV3p+UnDLCQMrnlpxOvL
         B25sEhGaQO70cRV7eYrmyrMoOfh7+XfXvwcpJlpHBwi8Ol2D6IWetbyGKDASVzxHyJPK
         Kc2ZVc9/CC16qFdIaY9d8xe2EBVRypsqmyTjYu6tO8spIkeJU/EVW4WX3RY53uuFjJ8a
         Tgi+QwmZS0Lb5SYwMR7LJ1RHJLb/kwMapxeUugHIYqFk340L+r7k+cUmIb5LMP9lzh5z
         RKOORU4dPlvv5LpYrofVwich25jN0dv27MQrdavZzncrW7cRfi556YoujKlF440T+Fb3
         diAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wsxcmjf/FzpYwVMJgM1cBYyND9v+GVhQE/vwrIXOMs=;
        b=hrYetzdlBrR6JuJLifU8sLFGA12hZ63jYvoDIlt2owIDm9C07g6wt4kweJ0HTblT2o
         nvAWDhwJyc41X+QnS/9e2WExT9wTx9D1YP8jkeuUso+3p2+an9SMt4vKO3yvSwQI1oom
         xNgfLQFwonh9qCanh/hf2T358Wxwpwawn/5eEohKUVecOgKPLEuaOLZ3X42Q3UR4El0c
         oQ/aBV59DofdZNj+AmvAD5z9XZQaHEx7UKsHwcJBu9kKPssfS2JO2aajqFDcu4Ilo6am
         YTq8NpRRAEItC824HblCozd3qEkrQ/q3X2Dpne32ZWoRGR+IJBBptE97Quxt2cCI5FQQ
         52Vg==
X-Gm-Message-State: AOUpUlEHjZBmYUnZ7qb4OAEKiqMuJqJDwrH0P1wHPl2/kZ3ZNg+dUPMl
        YoIlu913Nxu0x5qs7bMZNxGXG8d73HYcOd+UDiXazg==
X-Google-Smtp-Source: AAOMgpeFbo0hhCN4foSzxMqiFzCfAqL7z/ZMxwYdzQ8LLxZRVPw6q8TPnn0cydAnp2I9iODdJzRtpA2TWPFXQ9ZbmgY=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr1504037ybm.307.1532105354929;
 Fri, 20 Jul 2018 09:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.11.git.gitgitgadget@gmail.com> <7f596c1718d35539f02828edbf933c8e660f123b.1531926932.git.gitgitgadget@gmail.com>
 <20180718194657.GC7778@sigill.intra.peff.net> <f5d2f06d-1736-57e4-edbd-aa638ae34238@gmail.com>
 <a3640919-95cf-cca4-d552-4715a031dd7f@gmail.com>
In-Reply-To: <a3640919-95cf-cca4-d552-4715a031dd7f@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jul 2018 09:49:04 -0700
Message-ID: <CAGZ79kZatUUO6s6h7uH6K3Ta5a9k-t6xuWeQ0uiAUF0sjp1avg@mail.gmail.com>
Subject: Re: [PATCH 5/8] commit-graph: not compatible with replace objects
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks, Peff, for improving the check_replace_refs interaction [1].
>
> Since this series now has two dependencies (including Stefan's ref-store
> fix [2] that I had included in my v1), I'll let those topics settle
> before I send a new v2.

FYI: I have not been working on, nor plan to work on (in the short term)
on the ref store fix series, which needs another abstraction layer IIUC to
make it easier to integrate such a thing as well as extend the series to all
functions in the refstore.

Feel free to take over that series partially (and defer the extension for
all functions in the ref store until later) ?

Stefan
