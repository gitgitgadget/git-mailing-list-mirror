Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347A2207B3
	for <e@80x24.org>; Fri,  5 May 2017 17:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbdEERUx (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:20:53 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34034 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdEERUw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:20:52 -0400
Received: by mail-pf0-f181.google.com with SMTP id e64so5574835pfd.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0i5CL9q/pMF78qqGWuqtwuCDuSo+8qEFXiUP16IWl2A=;
        b=daC1e4t6F9W5WvP68WFwlgT2K5K/PRyqqyDkbKFWp3J23XkB/CTEHXefREC/t2g4FG
         JLsyqHjVkBGjYZnrdGWyNEcHQAJ25gWaKJyOdwBuCgs6TnnhXPiLZamQJ4ipMTPEb2Zt
         X1j8fzOWwtit4AIov+xmn3LwMVwmtF8LdKs2kpAVRsT/b7H+KQ/Vi3ZFwprTXBGO3GSv
         VjyIoVZP43UaQ7J+5r8euV9WDIrTF9QmFRIKCNiM/NpZeNZ8JdYidZJQ72+QEnrIP8TZ
         aeOfJutpeHk+givSiGcJRVI3ey0KSGfyJBb79Lb5cU6s2K+ByepTadcib/R1FzGBSEhi
         Mqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0i5CL9q/pMF78qqGWuqtwuCDuSo+8qEFXiUP16IWl2A=;
        b=ftiGHMkKznGO721tga+TaCc3QXFynhsnKSzB5d2xLMtCOpKZR29/PK5S2U7GBA8Mc8
         y8BUzijus1xU144h9QESvT8X/kvabhqk8fHaGv/iT1c7pYiGXqUf7BvHkHT59maD5L1p
         F+csUZ1IaIOlk1+mo1b/KQKlTuHwihxRMR+PaL5ZJmd8f6jSdWdomZQw2kr388mILA0L
         OTDkcVFL/FczO1pFFJKKUgrq+3re/GUbQVXnStG7RAAq7W3QH56ClTB+ZGxpRmRm6SFJ
         WwtwKUWfK7hIZUJk3AJcsozmd1WnsRDc/kkJe2Bg8V/FwNn+t2yLpOEOEHH/qKG1eHhH
         lvBg==
X-Gm-Message-State: AODbwcDOFjZPomS2BoVouUVW+hEo7zpGEIQT776uTBZhdR8JklkhMB5w
        srjOAwsXCqUeouYo
X-Received: by 10.98.210.199 with SMTP id c190mr2322503pfg.87.1494004852038;
        Fri, 05 May 2017 10:20:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:2d18:25e6:8c0f:28a2])
        by smtp.gmail.com with ESMTPSA id j65sm11740579pfc.86.2017.05.05.10.20.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 10:20:50 -0700 (PDT)
Date:   Fri, 5 May 2017 10:20:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Start of a journey: drop
 NO_THE_INDEX_COMPATIBILITY_MACROS
Message-ID: <20170505172049.GA55152@google.com>
References: <20170501190719.10669-1-sbeller@google.com>
 <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com>
 <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZiBOrY6Qno_wFpvFHpbpCY0BtriqYGW5JKG+1hfgJwiQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705051244310.146734@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1705051244310.146734@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/05, Johannes Schindelin wrote:
> Hi Stefan & Junio,
> 
> On Thu, 4 May 2017, Stefan Beller wrote:
> 
> > So instead of a mechanical replacement, we'd rather want to
> > see "the_index" not appearing at all outside of builtins, which
> > implies two things:
> >
> > * If done properly we can move the macros from cache.h to
> >   e.g. builtin.h. That way future developers are less tempted
> >   to use the cache_* macros in the library code.
> 
> Yessss!
> 
> > * we'd have to pass through the_index from the builtin function
> >   down to the library code, potentially going through multiple
> >   function. For this it is unclear if we want to start this now, or wait
> >   until Brandon presents his initial repository object struct, which
> >   may be suited better for passing-around.
> 
> Or the other way round. I guess passing a struct index_state can be a
> first step, and we can later convert it to struct repository. I fathom
> that more places will need a struct repository parameter than a struct
> index_state parameter. That is, if you first identify all the places where
> the index_state parameter is required, it should make the struct
> repository change easier.

Exactly this.  I have a local series which converts ls-files to use a
repository struct but it turns out, for that to work, dir.c needs to be
converted to take in an index_state struct for fill_directory().  So I
then started working on doing that conversion and hopefully will have
something clean enough to send out later today for people to comment on.

-- 
Brandon Williams
