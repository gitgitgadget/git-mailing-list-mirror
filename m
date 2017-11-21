Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211EB2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdKUXVS (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:21:18 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:43190 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdKUXVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:21:17 -0500
Received: by mail-io0-f196.google.com with SMTP id s37so10357399ioe.10
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xs6YmEF86PcznvTCbNj47w+mGrsQRI0lavTVmjhpTvs=;
        b=TeWaLRpEnjtLxTTdpuUkdqPhXoOX6JI298ye6D351E3OKz7YLs5jFZxhyJGkVPXmeh
         9qIxICZcNOtEwv8ADafJwMGSWED/8jybArs16Y3vyU2LdMd/cMsAFeTPniqbMQF+a9SQ
         N/CIGhA/uLnGJYIFXkSHM/JcYBac/PT+sPj0iEl8LD2Fuv/NYud5Bp4GRYM/Dl3WuYht
         l29yEiTUwnbN6EJvBgbsOvIKlsdQm0kTHFgYCskLDmKRVNar03ni8apq/vCCBi2mFxxH
         now8CgBvxQXdGICxUkuSAj+9BFbxgVzNueyL8KPTPHt1SdxLC78/vYjxPKPQ3dNXrKU1
         OPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xs6YmEF86PcznvTCbNj47w+mGrsQRI0lavTVmjhpTvs=;
        b=XcEnlfDdtaTPaPl6l3JgqgL4x8+m5ssPzuaIvsRaEj5QCiG4r95M7vlQr8iK3WHGoz
         XEiEOFhDiKgA8ZQuZTFzR7olTU5xk3s8j0fRxtXTjpNdttlNX7P6FAVM1x05TKshvFBx
         +3dBxk+0tnD3G/CqhSb1TIHT3T2R9PYqQi1D79FuwlFW38vbpDs1k6D9cun1jZr+CW1h
         BFikdRiA3yX1q3qG6LHYT+DnALZ0Uu43Gs7yoxkfrIOFVnRRhyidzDWpWenluZGf0A3e
         F24H5GFRifqowat2mA5nd9sQByLt9VfzkjXS7UUFFRXAiFUs3D5N+yLxwTrDRPreELe6
         LyNg==
X-Gm-Message-State: AJaThX68vUGyvKG75n7J5uqHRxOhW8dKtcoNsgjppbCfgbSWtAba2Z8D
        0Xhcs03EIFFqs3PdP2JSseg=
X-Google-Smtp-Source: AGs4zMbz6qKIni+ckMmkVYAPqSz37gj3SWEY2i0DKQdFLiCm0AHks4HPtBl/EfPsVpaSOCPkn2XxfA==
X-Received: by 10.107.62.10 with SMTP id l10mr19853646ioa.178.1511306476313;
        Tue, 21 Nov 2017 15:21:16 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v125sm1350123itv.42.2017.11.21.15.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 15:21:15 -0800 (PST)
Date:   Tue, 21 Nov 2017 15:21:13 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: doc: prefer 'stash push' over 'stash save'
Message-ID: <20171121232113.GK3429@aiede.mtv.corp.google.com>
References: <CABURp0pxYiwrpvT9E_jpvZKDMOUVA9e7dUhARfKEQymWzUwtiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABURp0pxYiwrpvT9E_jpvZKDMOUVA9e7dUhARfKEQymWzUwtiw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord wrote:

> Although `git stash save` was deprecated recently, some parts of the
> documentation still refer to it instead of `push`.
>
> Signed-off-by: Phil Hord <phil.hord@gmail.com>
> ---
>  Documentation/git-stash.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks.
