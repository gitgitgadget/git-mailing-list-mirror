Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC971F404
	for <e@80x24.org>; Wed, 28 Feb 2018 17:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeB1RoJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 12:44:09 -0500
Received: from mail-pl0-f45.google.com ([209.85.160.45]:43607 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbeB1RoG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 12:44:06 -0500
Received: by mail-pl0-f45.google.com with SMTP id f23-v6so1929786plr.10
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JBHFGeBBTZkZ2kES3iMReppZNP2/opZubghmG2myc+w=;
        b=eed8aSff/BCihTl8kxliUxiVdDNKxC+r6H+LzlZ7VffZNyx6iDHdAtDd0kM2j4HKkg
         2RH9EEungaGYBBKwA+Cqbs70FriIFlZJOzJPy3GTl1nYY44LY5jnkzFCej7k1WCpa/SY
         2OoUUMO3+zLIiQwEHTBaDODUqO+pWwtIplsmi6lwvzRUPZIWz4/C2M1L+IyWrcJ8vIja
         pMX6e0iu1ovk0Cakt/FVU+GHE9/8oOZ7Jq3q/+CImwb7XkCAclpV50j0/EgYeFoOfu61
         JecJWTsO7WsVnNvsOIK7Y9LCHLHdNomlXkY7mmMbue3z9yl0WlbgePBu+o9HwIg/I0Z3
         X9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JBHFGeBBTZkZ2kES3iMReppZNP2/opZubghmG2myc+w=;
        b=TyEnP8gpqlna9BN86gjEhCD8yjTB9MRAos1I0BbjygVyYjtD3Ns0I3E/7YHvOcBAam
         FggEOnKEQRsJc5gHqT1xMW/ccR4DS13dwuFg6oOn84Qyp1Z2fGpQ5k+puDzHyuhU3imT
         fsEKMqw1t89kLpu4hEFn1lWqrG5pjVqqt/w9+zHixtB29UslHvYVje2qGA5An9dTCFsT
         GqPOlmEObSuXr2m6nvvSbq2tCNEMpIJbgqarBC0dbZgEAe9MqNEuYgZbNuWqLWU1P3Nd
         zqel3DUH/2EU1jBD4ISL7FrafmtlVKg6ZPrxmGo3m3AHiYWJQ3DkG3cpoosB2w8IPJgJ
         IyRA==
X-Gm-Message-State: APf1xPBMHyvjYFGaKnZN+EPcz/bUUh/OWU6VIih9XeJUOr19wN5m+oD4
        VcJkpMKRaCoBKtBRZvp22/o=
X-Google-Smtp-Source: AH8x224Lv/cHDRaYKI0xTiEP8kGwFKrgCThFnjmzXYHWR/38dCRzGCDwJrS5a+t1g8vxMv8MGNLUUw==
X-Received: by 2002:a17:902:6c4f:: with SMTP id h15-v6mr18816974pln.435.1519839845553;
        Wed, 28 Feb 2018 09:44:05 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t8sm3695759pgr.21.2018.02.28.09.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 09:44:04 -0800 (PST)
Date:   Wed, 28 Feb 2018 09:44:02 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'demerphq' <demerphq@gmail.com>, 'Jeff King' <peff@peff.net>,
        'Eric Wong' <e@80x24.org>, 'Git' <git@vger.kernel.org>,
        'Joachim Schmitz' <jojo@schmitz-digital.de>,
        =?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
Message-ID: <20180228174402.GC251290@aiede.svl.corp.google.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com>
 <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net>
 <20180228074251.GA11673@dcvr>
 <20180228074918.GA32127@sigill.intra.peff.net>
 <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com>
 <003901d3b0b7$0a144280$1e3cc780$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003901d3b0b7$0a144280$1e3cc780$@nexbridge.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:

> The problem is actually in git code in its test suite that uses perl
> inline, not in my test code itself. The difficulty I'm having is
> placing this appropriate so that the signal handler gets used
> throughout the test suite including in the perl -e invocations. This
> is more a lack of my own understanding of plumbing of git test
> framework rather than of using or coding perl.

Can you elaborate with an example?  My understanding was that
test_must_fail is only for running git.  If a test is running perl and
wants to check its exit code, the test is supposed to use !, not
test_must_fail.

t/README backs me up:

 - use '! git cmd' when you want to make sure the git command exits
   with failure in a controlled way by calling "die()".  Instead,
   use 'test_must_fail git cmd'.  This will signal a failure if git
   dies in an unexpected way (e.g. segfault).

   On the other hand, don't use test_must_fail for running regular
   platform commands; just use '! cmd'.  We are not in the business
   of verifying that the world given to us sanely works.

So I don't consider the initial issue you raised a test issue at all!
It's a bug in the git commands, and a fix for it should not be
specific to the test suite.

And now it sounds like there is a second issue: the test suite is
overusing test_must_fail in some context and that needs to be fixed as
well.

Thanks,
Jonathan
