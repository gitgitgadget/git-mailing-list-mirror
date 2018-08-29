Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B581F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbeH3BXx (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:23:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37475 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbeH3BXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:23:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id h69-v6so2853745pfd.4
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0FudICNXS28cLm3FQTslwtIKZD9LTWVMeC7RHd0JRs=;
        b=i4c1+2+g7Po4RlXtHPBqoPHon5tR7JUU9EXSYxajN2Fezi5C5g6GCdPH0gJ6e6hkND
         HYgNuz71ouDF2Fv33fK24DUX2747OHJES1/YJmk0S35iNL7fLX4WM4BlMby7rvW0t34y
         jJbXDfK9dtzF6RAJhmMOjDVglltRo+2uOA6e1/EJeBxqwDhUYjFN1ceUAU5q9OxIYMOi
         FQxwshlwSUsY8DEdIUDz+54PMtTRdt54TL/nRLod7cBdlP80s6kvts5c39L1D6yixF3C
         wcuHlFT37JTmbGGtcRxZDD/DlWSOcfOLOoO3aAbjh3A6QnDchku/PJWEcri/5eoLfxew
         dX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0FudICNXS28cLm3FQTslwtIKZD9LTWVMeC7RHd0JRs=;
        b=ZwcqKBFJnGJCv9CKloc9SXiz9cQMgCJTrxGMpRYs3pGrrlpAqTBYll4F5ni6N9HCT7
         qaUC5r3NFarNbKAuP6tiNGu1SiGJcSY3z7favBb3w5MRSRpuAnc4LzP0UtindhMg1qJF
         UB8xJTst8MwddRRR+saUZhMYcyqDW1c6sIi0rp/cOeaibCZia9EPiHELr4mOXQMgzFTS
         QMh7M8TwvAG9ohI6COFo3f/fy+CqXkXvpVPcpg27Swz7lfRdKACr4NSQx/k1Ac9zzl9v
         kVBMIboKAuSQiLV6SWSIxvVT4jS3VeyP+yVxqP1TfVHrs9pEqQXS81JtQXTcPV5t75YV
         m6lw==
X-Gm-Message-State: APzg51AFbKz2yvRaLcH4fsZPtYUc3WTY+Q1IkMJIEAUCeJ3pYFgZCuj1
        c1KwdUf0HjWTQk6fZDHycyzFEA==
X-Google-Smtp-Source: ANB0VdaW2/CAslPGkv0Dx5HiNYPJqcZC6swvDHJErW/D3m83pwqwHs97FW/HOFkHPHwYq1UTzafuBg==
X-Received: by 2002:a63:804a:: with SMTP id j71-v6mr5332607pgd.171.1535577906842;
        Wed, 29 Aug 2018 14:25:06 -0700 (PDT)
Received: from google.com ([2620:0:100e:3010:35ad:1810:bc11:7e7])
        by smtp.gmail.com with ESMTPSA id x87-v6sm13203067pfa.143.2018.08.29.14.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 14:25:05 -0700 (PDT)
Date:   Wed, 29 Aug 2018 14:25:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180829212504.GA72254@google.com>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
 <20180829052519.GA17253@sigill.intra.peff.net>
 <20180829210913.GF7547@aiede.svl.corp.google.com>
 <CAGZ79kafLRXag0DBmw57sJ0WdTUEckCejKFz0j6UJVNdG7_UDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kafLRXag0DBmw57sJ0WdTUEckCejKFz0j6UJVNdG7_UDA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/29, Stefan Beller wrote:
> On Wed, Aug 29, 2018 at 2:09 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> >
> > Jeff King wrote:
> > > On Tue, Aug 28, 2018 at 02:35:25PM -0700, Stefan Beller wrote:
> >
> > >> Yeah, then let's just convert '/' with as little overhead as possible.
> > >
> > > Do you care about case-folding issues (e.g., submodules "FOO" and "foo"
> > > colliding)?
> > >
> > > I'm OK if the answer is "no", but if you do want to deal with it, the
> > > time is probably now.
> >
> > Have we rejected the config approach?
> 
> I did not reject that approach, but am rather waiting for patches. ;-)

Note I did send out a patch using this approach, so no need to wait any
longer! :D

https://public-inbox.org/git/20180816181940.46114-1-bmwill@google.com/

-- 
Brandon Williams
