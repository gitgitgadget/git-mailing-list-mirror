Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC641F404
	for <e@80x24.org>; Mon, 11 Dec 2017 21:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdLKVlN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 16:41:13 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36495 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdLKVlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 16:41:12 -0500
Received: by mail-wr0-f194.google.com with SMTP id v105so19090245wrc.3
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 13:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EVyLVV5ygh43j17++Q85RBZvPwEHaulE4KsEWritimM=;
        b=JspmwZLpnTPJucgD71w6Ily2Ha/AiSrBZk9hapVwk1p6RdmzT6EV+pvCpMRVCDYO+z
         EQU521HDGr99AXG4bm2ZTtMY3oKJGYkUA288SnowqG0RxAU8/j3AqUt1NTlta9tKMuRC
         vNQQSBVJVqMHBcHrf2V56HYmGxgXp/1C6RNhYUca8B5ZuZPh0ElbCVVJAn2d+nGRJRDP
         uYPvmE/ttv0s5X82YNHY2ADgl4xGg5+DlMS1OM8Osy8EfRZEcc3G78itdfoFGumoaaQ8
         eeRLlVl3FsHmv2nXt4SqgkRne3W6Q9fdnjeeHM+C16cix+f5gOTKmSxEKy+Aw/Z46AJt
         LrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EVyLVV5ygh43j17++Q85RBZvPwEHaulE4KsEWritimM=;
        b=dbjS59QT3IkGImBtZJqNQ6Z+WVrM+V57WNa+rEYdwmQ2hXAhfzvg9hGsF1+AOtOtvn
         B94tG1DdhzD/bSnwmZ3iq15Z30xmts800MoH88vJFE3fD9DhALWzHEbrXvXZN4yuDGwo
         40ej96XwgWD9tpYAXIC9lbJDC5j6t1oNqkIJuiO3fIsQT819N02xQP8g4Ap5YRZnKLDk
         aIV7dawZ2WYKZQwpFYCePHsx84iCAVdUmBhhZjsEbJ2NdiVVsbMqU2qi/Xd3DGtw/V4r
         hyZf8yYk/+XnUR3IGW4Npzkyq0p8mS7PZMPyN7Zk0c2toxxdfQ0yj4QfzZUgPR/BfpHO
         VhcA==
X-Gm-Message-State: AKGB3mIiBkkIINgOLw9VcOzBxr4LFOODoTEnm8xQatAk4Qq9QpltcCjh
        SvKDExz3HPSHbJcUg0gjU8M=
X-Google-Smtp-Source: ACJfBosdRzqq08FxLEEQkhp9Bu0zaN00aBX+FgFci9bhbg0HB6YaNqMwri3QADC8/Zv5bi7KYqVoTQ==
X-Received: by 10.223.167.76 with SMTP id e12mr1772580wrd.204.1513028471200;
        Mon, 11 Dec 2017 13:41:11 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id w142sm562784wme.3.2017.12.11.13.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 13:41:10 -0800 (PST)
Date:   Mon, 11 Dec 2017 21:42:55 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
Message-ID: <20171211214255.GA24597@hank>
References: <20171210212202.28231-4-t.gummerer@gmail.com>
 <20171211210948.6867-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171211210948.6867-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11, SZEDER Gábor wrote:
> > Make sure that split index doesn't get broken, by running it on travis
> > CI.
> > 
> > Run the test suite with split index enabled in linux 64 bit mode, and
> > leave split index turned off in 32-bit mode.
> 
> This doesn't accurately describe what the patch does.
> Travis CI runs three 64 bit Linux build jobs for us: one compiled with
> Clang, one with GCC, and one with GETTEXT_POISON enabled.  This patch
> enables split index only in the latter build job, but not in the Clang
> and GCC build jobs.

You're right, it's my first time using travis CI and I got confused
about how the .travis.yml works, thanks for catching that.  Will
re-phrase the commit message.

> >  The laternative would be
> > to add an extra target in the matrix, enabling split index mode, but
> > that would only use additional cycles on travis and would not bring that
> > much benefit, as we are still running the test suite in the "vanilla"
> > version in the 32-bit mode.
> > 
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  .travis.yml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/.travis.yml b/.travis.yml
> > index 281f101f31..c83c766dee 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -39,7 +39,7 @@ env:
> >  
> >  matrix:
> >    include:
> > -    - env: GETTEXT_POISON=YesPlease
> > +    - env: GETTEXT_POISON=YesPlease GIT_TEST_SPLIT_INDEX=YesPlease
> >        os: linux
> >        compiler:
> >        addons:
> > -- 
> > 2.15.1.504.g5279b80103
