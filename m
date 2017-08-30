Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B390120285
	for <e@80x24.org>; Wed, 30 Aug 2017 16:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbdH3Qyt (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 12:54:49 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:38803 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdH3Qys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 12:54:48 -0400
Received: by mail-pg0-f47.google.com with SMTP id b8so21457486pgn.5
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HJmblSLEcZx8OjMS8hLivPk+bV15FOdwim8NboywHlQ=;
        b=o8e6HkDakYcwYI+y/BYgMizIgsR2AheWsS5YRpXHZ8VI0Is7WRCd8EJhiSuXq6/l3n
         QlJDhEwQacoyfh2e6ki8B5J/PpCqMlm9FdXJcCyjqU/wFKKcVVXDlKMkp7/FKCaQuHhU
         f2qixbZnQzQNM8425vfB47XRTpSo8ecbj6JzWZnj0bLCy3vM4XGLxZ+Wtts360uS5MQy
         fkYpCY33rFJVCVQelQIQqM4Y52++1r/wQtwA3HHXoKWHg96QRom0AL7Avhkr0rV8gwve
         eRFg/ZaXvib7edQ2q5qYXR6ZdO1atJspkPts5sea4XaVFw20BoUw8A2800nVHLjxilF5
         GnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HJmblSLEcZx8OjMS8hLivPk+bV15FOdwim8NboywHlQ=;
        b=Lo3DT0L/fs7xi7smgtNe1dh1nSlALtURI+7LLCMGiuZ9qk+fRiJPTLwoit/Xf47OT2
         oRtulw1qmXEHRVc+AXzsogHMhrlJBFewnkCHYbby6z4/DDuH40mg5I0FIlIs5SrjFFkc
         Q/BRZAM5PflIQuvS8qnU4bKEOmLH5W/J2aLkFT45Hj9IIy/6IT9Z+GdXQJtFiyf8AzHc
         gIQD4fqu0awc25/LFX04mUWY5NJYG7rePW8Xz3kEP5HwQFkkYKsOnCOIRAbyR3P/QboQ
         YhBobZq1/FM6wGMmb4SYKLUL03GsQGSIqRV7bhZbmKXihAb4nx3hHi0Hdod+0r83WncL
         vQJw==
X-Gm-Message-State: AHYfb5ic5HJFQkvGniPVKvUUI3TLq0OKhVLzBDpqu9Gbr05+2+SW+i9T
        tn2vA4wiDUcsV/h4
X-Google-Smtp-Source: ADKCNb5s/C4hXLPlN+krm7CfB3v0H2TKjJuGStumyY1/sZXySHVLdYhkqoFA7xuUQWBtiSd0EjviEA==
X-Received: by 10.84.215.154 with SMTP id l26mr2778034pli.314.1504112087684;
        Wed, 30 Aug 2017 09:54:47 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c55:9408:3387:8e7e])
        by smtp.gmail.com with ESMTPSA id i187sm11493668pfe.67.2017.08.30.09.54.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 09:54:46 -0700 (PDT)
Date:   Wed, 30 Aug 2017 09:54:45 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [RFC 0/7] transitioning to protocol v2
Message-ID: <20170830165445.GA50018@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
 <20170825173550.GJ13924@aiede.mtv.corp.google.com>
 <2ff0ead4-e13a-220e-f858-36ab206c1485@jeffhostetler.com>
 <20170830030612.qjss3ygouardxi6k@sigill.intra.peff.net>
 <3a2694ca-b5e6-7258-de01-c9898cfa60a2@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a2694ca-b5e6-7258-de01-c9898cfa60a2@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30, Jeff Hostetler wrote:
> 
> 
> On 8/29/2017 11:06 PM, Jeff King wrote:
> >On Tue, Aug 29, 2017 at 04:08:25PM -0400, Jeff Hostetler wrote:
> >
> >>I just wanted to jump in here and say I've done some initial
> >>testing of this against VSTS and so far it seems fine.  And yes,
> >>we have a custom git server.
> >
> >Great, thank you for checking.
> >
> >>VSTS doesn't support the "git://" protocol, so the double-null trick
> >>isn't an issue for us.  But "https://" worked just fine.  I'm still
> >>asking around internally whether we support passing SSH environment
> >>variables.
> >
> >The key thing for ssh is not whether you support passing environment
> >variables. It's whether you quietly ignore unknown variables rather than
> >cutting off the connection.
> >
> >To support the v2 protocol you'd need to pass the new variables, but
> >you'd also need to modify your server to actually do something useful
> >with them anyway. At this point we're mostly concerned with whether we
> >can safely pass the variables to current implementations unconditionally
> >and get a reasonable outcome.
> 
> Right.  I just spoke with our server folks and, currently, our SSH
> support quietly eats ALL variables.   So we're safe :-)
> 
> I'm starting a conversation with them to pass them thru so we can
> be ready for this.  (Assuming we choose to go this way.)

Perfect! Thanks again.

-- 
Brandon Williams
