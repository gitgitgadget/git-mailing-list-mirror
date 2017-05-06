Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D4D207B3
	for <e@80x24.org>; Sat,  6 May 2017 00:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbdEFAGM (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 20:06:12 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35740 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdEFAGL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 20:06:11 -0400
Received: by mail-pg0-f54.google.com with SMTP id o3so9764194pgn.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 17:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gp6G3cqvLUAufQBfiuwrT/K+7w+APvm2ih7LPG6BWnk=;
        b=sIqb4NItU3epwIIpjmUKpLSPUO60nLH3F4oIeEblGQhp48fWK1i8lI0KMDHAx3KDWl
         FoFFPqXkJFbFdj88dV6qunLL6lepGp2WbUQ+n8iY5qDyON5qtQ0Gwp5cMs66NY/bH0Nt
         ksO+/IW71rB5vgTVnfirFmCWvGpLA15jC6w98BmfW+YSmy5oeFp3IEcBwjc69WEWsA6V
         wtiLg/wUHCGmoYkYENnY5q+1fPnHjaX76ga4CTIROWxaaONQD63x/s7a+5xdndAvAmt/
         iMPtfesd8CIvaCKOOzdZ1qzfqaweFX8pR//MVVSq3oyABnTKsuJUg0gVH9zLCXS6yL1u
         1VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gp6G3cqvLUAufQBfiuwrT/K+7w+APvm2ih7LPG6BWnk=;
        b=YwsGbaJ7k9zUSarvo05wAu3l+WHfBDhL2Wr5yO0LiA0G+6ixpNHA9TdIpWtT881m4Q
         NCm5eV2QWTy6WuaRp3SkjanJwBydRoHydGGNuymXnPlA5yZA8A8TRTuJouNKrskd4e4D
         ap5SkVWzTBxFxX+qN+svl5l4hqRhzTuO6P5fobh1HfPdS+6yyCJ06uKYjSJ7haqba+56
         nBKrym2GKgiOhW/ERM8Bq82WYkefLfXkDFAYzgIw+CRDwu/ICtRhP41QsKkNBr+1IViH
         3M02X5h4ufKn6mo4l40QxVEH60TyaM8zbqc2ecwuSuJjLgAuBAfV3Y/Lk1F3SEIVHUip
         tW1Q==
X-Gm-Message-State: AN3rC/6HGyKYksx8j31WZ5E//D9u0ONAS0wB0U9UY0esF2dlM/4fTx8v
        npbn5HCfZyx6cEn4J8rAvQ==
X-Received: by 10.98.17.156 with SMTP id 28mr4605445pfr.267.1494029170407;
        Fri, 05 May 2017 17:06:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:68f1:1fe9:5380:71aa])
        by smtp.gmail.com with ESMTPSA id 186sm10746399pfx.72.2017.05.05.17.06.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 17:06:09 -0700 (PDT)
Date:   Fri, 5 May 2017 17:06:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] receive-pack: verify push options in cert
Message-ID: <20170506000608.GD55152@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
 <01e098de2da2e5f0b341ab6d967d032d840c365e.1494027001.git.jonathantanmy@google.com>
 <CAGZ79ka4vG1yd1JtK9bDBjWPUG0UCPMvw2XQUsfX_e_xFCpVLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka4vG1yd1JtK9bDBjWPUG0UCPMvw2XQUsfX_e_xFCpVLA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/05, Stefan Beller wrote:
> On Fri, May 5, 2017 at 4:46 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > In commit f6a4e61 ("push: accept push options", 2016-07-14), send-pack
> > was taught to include push options both within the signed cert (if the
> > push is a signed push) and outside the signed cert; however,
> > receive-pack ignores push options within the cert, only handling push
> > options outside the cert.
> >
> > Teach receive-pack, in the case that push options are provided for a
> > signed push, to verify that the push options both within the cert and
> > outside the cert are consistent, and to provide the results of that
> > verification to the receive hooks as an environment variable (just like
> > it currently does for the nonce verification).
> >
> > This sets in stone the requirement that send-pack redundantly send its
> > push options in 2 places, but I think that this is better than the
> > alternatives. Sending push options only within the cert is
> > backwards-incompatible with existing Git servers (which read push
> > options only from outside the cert), and sending push options only
> > outside the cert means that the push options are not signed for.
> 
> As the combination of push certs and push options are broken
> (at least when using JGit as well, which are used in Gerrit
> installations), I would not feel too bad about actually going
> the backwards-incompatible way.

yeah just think of the bits that could be saved!

But in all seriousness, I'd agree that doing the backwards-incompatible
way would be cleaner in the longer run (esp since they are broken
currently).


-- 
Brandon Williams
