Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8664C1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 23:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeHXDCV (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 23:02:21 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:43569 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeHXDCV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 23:02:21 -0400
Received: by mail-ed1-f41.google.com with SMTP id z27-v6so2370373edb.10
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5L94ioK9GlsdeQu0YmGIIcTdYUIitNIMm4Qn4t+pqnY=;
        b=X6/XzssE6ekTP9JRZDdvTLRKzckFgqAMi2CwXXcjDNAFKeunDrNVBoouKF475mkHoK
         Li54sWA3Qd0L5hk3+eQsUzcnEV5Pqd/uOj9RilShieNgrN4IYhDoIgO2X3nqhSmg99n5
         2wfIybZPFm8GLJTJevHpX1QXxSW3jqAbkfVPozQkPWN5jbFlpYsNMgNgtnWCBUQ14Jsi
         lOTB+wJX6agB0zFFDyIpvbhK6NJZuOIaNSTix4B2VHWyUfwIn2sYJnCblvF1pJnq7Yx6
         RH+lKpAYQZpa2jVLgmI8BHmXjr2Uv6ImC1my7/Ks+uuG2/G91XmloCvkZl2GfNBq1eta
         eBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5L94ioK9GlsdeQu0YmGIIcTdYUIitNIMm4Qn4t+pqnY=;
        b=EXdHZVeKg2ufIvqlX6xbif46sP2/lBm24XsOqTeCJHSsX+qAc/0GJwViN//fjbtF+I
         XhVTm64pRdmUjJkrP7aKuZaoKaECZhJSNy5ybIB1EztO1Z7nvMTpkTYW7iq2gNO+uC6+
         Ji0+UDMwcGw84DuKfbBXwxeEHGsqsA4HuNSnG64gDqFXQBMIQnnkgASd5Xx80inDmVlJ
         qA0g3P+vFxRCV+wpjPxWaUbFDZfpxkeeOAF+Ig6pQPAAlutCHfTscU966x2MHV74b6hP
         1nZMZvjqrdb55XrpMyVRB8+bmNt8B8xPg/wL2nfuSxkyJl/ppSXBC7W3Z3sD6870l8fp
         Qqrw==
X-Gm-Message-State: AOUpUlFvYTSuIkjhnFgfoMPfosUnCis+yYfbKJ3ahf68JGVHSRXVbFX1
        9VbxOjYJJC6I1OAgrLZEAjmcg33MyRGL8+qlmBB28g==
X-Google-Smtp-Source: AA+uWPwV/og6w4tjxMOTxRgmGrfopEB5cEBM1pOOyksx1uJ6jIxoptlN5LeBW773nPVCi00jYc9UVo1717Wku/DFcJs=
X-Received: by 2002:a50:da01:: with SMTP id z1-v6mr73337038edj.62.1535067022215;
 Thu, 23 Aug 2018 16:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180821212923.GB24431@sigill.intra.peff.net> <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net> <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net> <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net> <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net> <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823161451.GB29579@sigill.intra.peff.net>
In-Reply-To: <20180823161451.GB29579@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 23 Aug 2018 16:30:10 -0700
Message-ID: <CA+P7+xqbt_BVi9+1-4=ha64LW_07dJB84F0gjKd9TRE1R-Ld7A@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, paul@mad-scientist.net,
        Git mailing list <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 9:30 AM Jeff King <peff@peff.net> wrote:
> I think that audit isn't actually too bad (but definitely not something
> we should do for v2.19). The cocci patch I showed earlier hits most of
> them. It misses the negated ones (e.g., "if (oidcmp(...))"). I'm not
> sure if there's a way to ask coccinelle only for oidcmp()
> used in a boolean context.
>

You can look for explicitly "if (oidcmp(...))" though. I don't know if
you can catch *any* use which degrades to boolean outside of an if
statement, but I wouldn't expect there to be too many of those?

Thanks,
Jake
