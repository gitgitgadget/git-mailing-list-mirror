Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410471F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 15:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfKMPG2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 10:06:28 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46605 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfKMPG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 10:06:28 -0500
Received: by mail-wr1-f43.google.com with SMTP id b3so2726297wrs.13
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 07:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w+9CvHzA8TZ/a1v8U5yYf3CrRGz9CemYr6NzX5WGcio=;
        b=VlVwx7pz5DyU5FdT7ndDPNUls6tj8r/J72zWz9Ih8qqQ2GMWNSwhsDn6bHKAiDpbXA
         iHU/CTKYfiaOr0Up+TSPq/2ZhbKHkg/t/mY3PjaknBCdlSTsbHUCCiph5FCEmTBr6f/D
         ZbtNM9Oe1j8oHNxSc+Mq7ssiqkuz/5QwTRofPtg/hUT7PPbREieVXvHWsqyUqIM8kKz6
         Hv+Ed++9K2QUEcjdJtPBgc3gnZRKVzpvT3Tah1fW7CY5ftGP1iIpPxyIu4w7PGbrlL4g
         8j074gozsgmVVvUI4UFjNLPQBOgaabypf1agxMRYTHZ4aYvWt8BQbYEtWEv2a9NwtSo4
         daEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w+9CvHzA8TZ/a1v8U5yYf3CrRGz9CemYr6NzX5WGcio=;
        b=OU8I4g1VJp6FFS4niXVAh0phyuettvmdRoiiEpkG5F5c59MDekYAXSPdz9ZRlchiaQ
         JPz1PXQGURsGFn5sgjnKSU2xgD6nTZhG2opV6M3nbgBUIZPJXF9Kxbe1AbGUk2MzKp6R
         166hXazi9ITp8Kx3zBoHXCDcMDXaqY9vPxoDEaL6Y4u2Vx0EAG+Vmdmj+GFYYlu5AMkW
         ydOqX3W3XOiHwTi4obWUSccwig17T5wbq9MGAN1hcsALxNnbKvkRF+GNMtBllcAt2jz9
         4mH5mh+oKFYmHf5MDT/yH+bylQzL8/VDF4nwKe3vFsdRYUQ1MsSi5Z6OgnEg9430o6zD
         hw1Q==
X-Gm-Message-State: APjAAAUOyL2GzyBzkJtCl8FcLRPSYuubybOkfKHnMcsodiqlc/RuwQmX
        21FPnyuehnv/t2Pgh8H2Vl0=
X-Google-Smtp-Source: APXvYqzthaoeBHEXEHYAJPSdlnDH9NbitKcwHL1aVuPaNS0ijBxr7QZu6IndhC9pHyWBVG+YPY7DDA==
X-Received: by 2002:a05:6000:34f:: with SMTP id e15mr3584376wre.232.1573657585937;
        Wed, 13 Nov 2019 07:06:25 -0800 (PST)
Received: from localhost ([62.253.227.125])
        by smtp.gmail.com with ESMTPSA id q15sm2677306wmq.0.2019.11.13.07.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 07:06:24 -0800 (PST)
Date:   Wed, 13 Nov 2019 15:06:24 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Garima Singh <garimasigit@gmail.com>
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20191113150624.GC3047@cat>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
 <20191112184547.GA38770@google.com>
 <nycvar.QRO.7.76.6.1911122100220.46@tvgsbejvaqbjf.bet>
 <CAP8UFD2qjUa=y81YPVSMcuEcDkrkrV=j912qySmG83pig=dFDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD2qjUa=y81YPVSMcuEcDkrkrV=j912qySmG83pig=dFDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13, Christian Couder wrote:
> On Tue, Nov 12, 2019 at 9:04 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 12 Nov 2019, Emily Shaffer wrote:
> >
> > > I'm still really interested in participating on a mentors list like
> > > this; can we set one up?
> >
> > I would subscribe immediately to a Git mentors' mailing list.
> >
> > Thanks for bumping this,
> 
> I would also subscribe, and yeah I think it might be worth trying.

+1.  As mentioned in #git-devel during the last standup, I'd like to
be on that list as well.
