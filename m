Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3241F404
	for <e@80x24.org>; Tue, 20 Mar 2018 04:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeCTEtk (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 00:49:40 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:38731 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeCTEtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 00:49:39 -0400
Received: by mail-oi0-f49.google.com with SMTP id c3-v6so285926oib.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 21:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aJslmqu1B+8NiOFoILjCQUGd+sFzKAZ0QpK2AFSVtl4=;
        b=ZMiytyAXrD8mWgmS0TT+34+t3NR1xwName0ggZrCZWTggTY4iU62jF0G/QtoYtsvPb
         6I+YAMG5ta7ZPUuaIEPxUCJ6akK1DeBbWA6fyKsKEdmz58uVsZLuc2AEgAD0Q90/uqgD
         hg0Eb1Oo97RgOG7cIQ6/RhwBGegJL9fLC8o4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aJslmqu1B+8NiOFoILjCQUGd+sFzKAZ0QpK2AFSVtl4=;
        b=Mk4llTDVykAkrYERDNA6M4tUbTOdeXxKlu+dDwOFmi+ndkfci0OgHMJ5b93zoXy+AO
         fLhKTiqmQoe4tpIxjYsIyFfsxU8OFfjcYIPoBQP7Z342r9EEmz08Yf+KK4WMwhl+NDeP
         CBnC2W5SUHXpXsy5+/14nPComEWyrfRQdlWRO7LfSJIhwu0mm9Dquq3sQQg8tfYywIBw
         obj+FcgDTUUmR9ygHNSCICeHG7n+gelpu0judnNcjGsk3gEWkBqLO2iXhbSXVL6A6ApG
         f807DqmldOqurt0EMreDxFeVx2nXzKWLiOdJJSp0sn9rIOhGYLZ8M0BhvJxAhof8EBT7
         BbUQ==
X-Gm-Message-State: AElRT7F9P6bs00YbOjLcx4lVfjK45KKSxOGHLw0Zb3AHpElIw4unUfPT
        hTIMxfIyKejkAAxToQuYOV99+m+sSRhkP3mWnp2aWg==
X-Google-Smtp-Source: AG47ELtjjxHIPnh/sZ09WMT9m06Cm5M/EkU8pyVJ7xwEdwhI+MWQ3eyskluvawYUyIzOU9ibRvxIiFCtvUNQRXZwfs8=
X-Received: by 10.202.11.1 with SMTP id 1mr5823314oil.157.1521521378644; Mon,
 19 Mar 2018 21:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Mon, 19 Mar 2018 21:49:38
 -0700 (PDT)
In-Reply-To: <20180320044036.GD13302@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net> <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
 <20180320044036.GD13302@sigill.intra.peff.net>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Tue, 20 Mar 2018 00:49:38 -0400
Message-ID: <CAHnyXxTj_TzUz13cK76D_hGF4FmBo40Q1RypvOLC8Q1eNk7FmA@mail.gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So I think the "recommended subset" is basically "everything but these
> few constructs". We just need to document them. ;)

Mentioned so-far/running list?

- Matching directories recursively, or at all I guess (e.g. "<dir>/")
  - (???) Instead: "<dir>/*"
- Negative matches
  - (???) Instead: Is there any longer-form attributes-OK equivalent?
Just positive-match with "!<thing>s"?
