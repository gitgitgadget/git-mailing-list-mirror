Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC161F453
	for <e@80x24.org>; Mon,  1 Oct 2018 18:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeJBAx6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 20:53:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34459 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeJBAx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 20:53:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so9835289pfi.1
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UK9aUlQ31hFOjssvcFP+LOPWm8Zxp8Jwcufcauuve8Q=;
        b=XvVdL8HO9WmGq0LRKqWx29NKI2sPGIpEZk6BRvJgYpRox3j+ULCwpppFx7VqeBS8og
         Twu40sqpJOKla9gHXnDlw5+6B9dVEQXpKxOWNDOblDBhchrvxdXyDEqKEASF71L8vMys
         y223nqB/c4XbPkqo8brJ7Kjkzv4CZ46k6Mz/JPYX89+aicfl3zHz4uxSPR4VKar66bw+
         Z06QtDAlp5kZi1A6waELrALXNqXtgehtRT8+Re4KF12NpNPc6oLnZaswBEdxod0ri+eh
         5ARqRJbwgwtQORT6IgEE/jNtYvWMeq/clPYYDi2y48eTiMOTtkXv4QL7tjZugOrdUt2w
         VN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UK9aUlQ31hFOjssvcFP+LOPWm8Zxp8Jwcufcauuve8Q=;
        b=iHz80gI5z1yrptMWA88cxwiIC0CadeNd386994TAJ2t7fnrJ5Cw07M+lKefft2oyXw
         aoP6HdGYLWu1zZItjI8XTwmJv5h68pdLWAN4W/rwuhQ7G2EyuAbd4+lPsnLXwo/YIwar
         VpmdGe4Dz/hjOKns1XZVLiBJWLFEapK6ySvsqiTRKpwHdhLh+GPmoWxEEGOvQKGjLSKf
         sa6Y1eEhcBJMEu0OpVsm3VDvLtVtrm+NFMUSUizPkfPukPHSGGSK/wk5N2KmRxJjSpaw
         +cTDW9Ms3TqGCfkGpJIbqE6px5BOon8smYWNRWF7SZx4atx+yNCs+qyoQiM7s7lkifPP
         aI3A==
X-Gm-Message-State: ABuFfoisKmhiDLPlUBsS1HlWsmgym7y01g8jJp0YNgIzcWEmrSo/iWkq
        mGdFpapvTt1r6lH+qD545CxsbA==
X-Google-Smtp-Source: ACcGV60e5qJwW40IS/6mtLUZM+b0lMZ4PKvlMtmqWcr9WKk0e6ANLmeDkoGCbQ6kLpuNuDszeMo/0w==
X-Received: by 2002:a63:cf4c:: with SMTP id b12-v6mr11418415pgj.418.1538417695909;
        Mon, 01 Oct 2018 11:14:55 -0700 (PDT)
Received: from localhost ([205.175.107.117])
        by smtp.gmail.com with ESMTPSA id m20-v6sm18541768pfj.171.2018.10.01.11.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:14:54 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 1 Oct 2018 11:14:53 -0700
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] help -a: improve and make --verbose default
Message-ID: <20181001181453.GA77583@syl>
References: <20180922174707.16498-1-pclouds@gmail.com>
 <20180929060814.22781-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180929060814.22781-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 08:08:14AM +0200, Nguyễn Thái Ngọc Duy wrote:
> When you type "git help" (or just "git") you are greeted with a list
> with commonly used commands and their short description and are
> suggested to use "git help -a" or "git help -g" for more details.
>
> "git help -av" would be more friendly and inline with what is shown
> with "git help" since it shows list of commands with description as
> well, and commands are properly grouped.
>
> "help -av" does not show everything "help -a" shows though. Add
> external command section in "help -av" for this. While at there, add a
> section for aliases as well (until now aliases have no UI, just "git
> config").
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  v2 makes 'help -av' default and the user would need to type 'help -a
>  --no-verbose' to get the old printout back. 'help -av' also has
>  external commands and aliases.

Thanks. This looks like what I would have expected based on my
recollection of the discussion earlier on v1, so this has my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
