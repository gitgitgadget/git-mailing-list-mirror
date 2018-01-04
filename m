Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2E51F404
	for <e@80x24.org>; Thu,  4 Jan 2018 20:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeADULG (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 15:11:06 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:42208 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeADULF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 15:11:05 -0500
Received: by mail-wr0-f172.google.com with SMTP id w107so2563760wrb.9
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 12:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NPvuKISLr5WL7cBmvLeJJxr1PW4g5gOWsS65VEdrfhk=;
        b=dqKrWwakLFH8wT4zBCa7kVWcA4yj1YEt3MmJnI7j+3vlz7BicozpjN2jPDHOm1w+tp
         1Vpf4uOihN7yDJnn/dAtGC9thtHROc7I/6GZKn0OdjR4ZjNDx6AV2quiKOAgNz1KjJy1
         PjecxBipaoGWw8/XF0WIi/y6GSzankNlGN20IWx1AQhZTUPE/F9r/YC5JoBx3/L5B4WA
         OwyhyuNW6LSYiWKnNqznHFKCx/zExPbeIPdsw9ivCjTAMB8QgLJiRcSe+IUmedBEimde
         uHvOxxp4+/WNNcWMPUTcpaRmr4u1PE+vG8m5fFDNY2C4aMpfXaQAL2960nOnZLzgVD8Y
         9dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPvuKISLr5WL7cBmvLeJJxr1PW4g5gOWsS65VEdrfhk=;
        b=afcJmgAgGFUYZXyH5HW8I86L5YxLs8WU7gDepJ2Z+6H9psl6bdoKGBejLgGOEaUBIs
         XdShWyeMOoRiGr+UP/hJWs2MQoHLZR1Ihvah8uQd2pyxJmBOvWzetuRJ3TlBAYtzbs7J
         PB8f4lvywS5IcFFqemJDjGm6T7v2myuI8OwmMyxrItKESAxKPUfdzTOMEGTPwGFA6rKO
         +yMf99CDcxZv3TvwNNv1VUbuy2oSFQf2ZpnVCUkYmYUEj/KWT7rpE6M/8osLMv9CaLMZ
         LwVXfTzo9cum3QTBUHz9z2/L2qs9L5nxDC2U+gkMpEu9m2HKAhgwS2n8Xow9v4RY8833
         LSqA==
X-Gm-Message-State: AKGB3mLcaml7Sn1txUWXMmZ9OriZr5VQG+oCB62kECSJuOAbP/ZdHGv/
        2QyGGn7hbe7+o2ymCQ8Uq7M=
X-Google-Smtp-Source: ACJfBot5cUOPGIFWUa9CTzw89LaJ4AvTSEmYyBYYd71nKR8Lz8bo3GTB94w3FT4rp9Bi/cc+8OrRbA==
X-Received: by 10.223.166.99 with SMTP id k90mr627968wrc.114.1515096664263;
        Thu, 04 Jan 2018 12:11:04 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y124sm4079809wmb.42.2018.01.04.12.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 12:11:03 -0800 (PST)
Date:   Thu, 4 Jan 2018 20:13:12 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
Message-ID: <20180104201312.GD2641@hank>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171217225122.28941-1-t.gummerer@gmail.com>
 <20171217225122.28941-4-t.gummerer@gmail.com>
 <CA6C93AD-B24D-43A2-8AAA-DE98A4C9E719@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA6C93AD-B24D-43A2-8AAA-DE98A4C9E719@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18, Lars Schneider wrote:
> 
> > On 17 Dec 2017, at 23:51, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > 
> > Split index mode only has a few dedicated tests, but as the index is
> > involved in nearly every git operation, this doesn't quite cover all the
> > ways repositories with split index can break.  To use split index mode
> > throughout the test suite a GIT_TEST_SPLIT_INDEX environment variable
> > can be set, which makes git split the index at random and thus
> > excercises the functionality much more thoroughly.
> > 
> > As this is not turned on by default, it is not executed nearly as often
> > as the test suite is run, so occationally breakages slip through.  Try
> > to counteract that by running the test suite with GIT_TEST_SPLIT_INDEX
> > mode turned on on travis.
> > 
> > To avoid using too many cycles on travis only run split index mode in
> > the linux-gcc and the linux 32-bit gcc targets.
> 
> I am surprised to see the split index mode test for the linux 32-bit
> target. Is it likely that a split index bug appears only on 32-bit? 
> Wouldn't the linux-gcc target be sufficient to save resources/time?

I'm not sure it's particularly likely for a bug to appear only on
32-bit builds.  It also doesn't seem to take too long to run, so I
thought I'd add it just in case, but I'm happy running the tests only
in the 64-bit builds if that's preferred.

> >  The Linux builds were
> > chosen over the Mac OS builds because they tend to be much faster to
> > complete.
> > 
> > The linux gcc build was chosen over the linux clang build because the
> > linux clang build is the fastest build, so it can serve as an early
> > indicator if something is broken and we want to avoid spending the extra
> > cycles of running the test suite twice for that.
> > 
> > Helped-by: Lars Schneider <larsxschneider@gmail.com>
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > ci/run-linux32-build.sh | 1 +
> > ci/run-tests.sh         | 4 ++++
> > 2 files changed, 5 insertions(+)
> > 
> > diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
> > index e30fb2cddc..f173c9cf2a 100755
> > --- a/ci/run-linux32-build.sh
> > +++ b/ci/run-linux32-build.sh
> > @@ -27,4 +27,5 @@ linux32 --32bit i386 su -m -l $CI_USER -c '
> >     cd /usr/src/git &&
> >     make --jobs=2 &&
> >     make --quiet test
> > +    GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test
> > '
> > diff --git a/ci/run-tests.sh b/ci/run-tests.sh
> > index f0c743de94..c7aee5b9ff 100755
> > --- a/ci/run-tests.sh
> > +++ b/ci/run-tests.sh
> > @@ -8,3 +8,7 @@
> > mkdir -p $HOME/travis-cache
> > ln -s $HOME/travis-cache/.prove t/.prove
> > make --quiet test
> > +if test "$jobname" = "linux-gcc"
> > +then
> > +	GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test
> > +fi
> 
> For now I think that looks good. Maybe we could define additional test 
> configurations with an environment variable. That could be an array variable
> defined in the lib-travis.ci "case" statement:
> https://github.com/git/git/blob/1229713f78cd2883798e95f33c19c81b523413fd/ci/lib-travisci.sh#L42-L65

That sounds like a good idea.  I'll try to see if I can come up with
something.

> - Lars
