Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69421FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 10:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeAJKiw (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 05:38:52 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:40226 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeAJKiu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 05:38:50 -0500
Received: by mail-wr0-f169.google.com with SMTP id 100so925943wrb.7
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ea+XES1ifyEh9r2BON9+Op6XKziKpCAwhVtw6uINDC0=;
        b=Tfydh+4QJLyozTiMh+zjHjtz+/TWg7w97a0TooLNVZN8xxqYT7XFwjlNj5h5mBGoac
         KdMRxUMiq4Vfg032jjypLnzPxFbL4sR5KqXwbMUqQawjLYCkOa5lm6ewQwFv5EUxw9Oh
         TVropcGRjeWIc/RMrzrXXTxoVuCcboVDxP54U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ea+XES1ifyEh9r2BON9+Op6XKziKpCAwhVtw6uINDC0=;
        b=mWh8QR0eS0iVhajP7TeLyyBvyTbWnKfdvU+mECTUVxw50oxjcTy9Qjpeo8dx0Tzu6M
         nJihIB88k8CTrvNFVBiy1USsbDigZPK++KfRXZpAuYXV5KLlsGjTp41EuMPgFQmKPP+T
         PlZ0+3VXx62SLWuTeZC8yqcWutjLiksof/pnbqAd2bH+0OiSmWCJL5zKdpT4KVCW2XXI
         kBj3oGrVARnACaLugBXYXyiHKoQGuog72MBKGeHB2NGZA3RYDLbLGJadvfJooa6q49eR
         PeWEF2F3IzFvaNAOzBstixYt+EjSQQAaCHXJM1wow9Ji0EHUo7OZk6WjcAIAxvjT6qWL
         e4og==
X-Gm-Message-State: AKGB3mKI0vLZdy3TSjW9HrF5PsGzt0N1JcYU2Bl12RUyNTAZoU3FkDYC
        /A94u+0FpwSJ9i0/sluLznXwJg==
X-Google-Smtp-Source: ACJfBovaBJpze/vGzZnWSWtA23QPm+qbA4rHH7VtkLHwwMzPwRbFc2kTBgF5QBevXBMpaDwXjzKQCg==
X-Received: by 10.223.182.18 with SMTP id f18mr15247781wre.11.1515580728965;
        Wed, 10 Jan 2018 02:38:48 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id j6sm18549993wmg.41.2018.01.10.02.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2018 02:38:48 -0800 (PST)
Date:   Wed, 10 Jan 2018 10:38:32 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on
 Windows proper
Message-ID: <20180110103832.GA4018@dinwoodie.org>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <20180105221222.28867-1-avarab@gmail.com>
 <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com>
 <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <CACsJy8CDz57RR+VHpaPb5YMhKG5kUgb9rt5TWKL8n+e7Xart3g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801081319520.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180110090724.GA2893@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110090724.GA2893@ash>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 10 January 2018 at 04:07 pm +0700, Duy Nguyen wrote:
> On Mon, Jan 08, 2018 at 01:25:04PM +0100, Johannes Schindelin wrote:
> > I agree that it would make a ton of sense to use a proper, portable test
> > framework written in pure, portable C.
> > 
> > However, this ship has long sailed, hasn't it?
> 
> If you meant converting the whole test suite, oh yeah that's not gonna
> happen. But it's still possible to have some tests written in C.
> 
> I played a bit with this. The assumption is if it's agreed that we can
> get something bare bone (but functional) in then we could start having
> more and more C-based unit tests in future and also improve the C
> framework to be on par with shell one on the side.
> 
> There are still some minor problems with my patch, and a bunch of
> optional features not supported. But the numbers looks unexpectedly
> promising. 0.7 seconds on the shell version and 0.03 on the C one.

I see even more promising results from a single run on one of my Cygwin
systems: from 21.3 seconds for t3070 to 0.112 seconds for your t3071.  I
expect there's a similar improvement in Dscho's Git for Windows
environment.

> One disadvantage of this though, if this kind of framework does not
> get popular, then any new test feature must be added at both places
> but it's a waste of time to support both. So...

I don't follow: if we end up implementing every test twice, as we have
here, then I agree, but I don't think there's much value in doing that
except as a proof of concept, as in this immediate discussion.  The
obvious-to-me way to do this would be following the precedent of the
core code: gradually migrate things away from shell code to C code.

Adam
