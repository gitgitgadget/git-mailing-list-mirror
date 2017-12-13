Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 613EB1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 23:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbdLMXT7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 18:19:59 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33204 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdLMXTz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 18:19:55 -0500
Received: by mail-wr0-f169.google.com with SMTP id v22so3612203wrb.0
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 15:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LfHIa7qw8TX1EY1HP/cqr3eIXhrotpcdxEGlC9BCudw=;
        b=dGWTVrPgojRPXFmFekj4x6DbXwbxhkqf0oNjh3p1d9AES85UQMOLqMvKRDUStYXaFR
         Uv6zbe1zDN1Xm+/onmYj+RNSC5vKiYYRRNl9NHTObRgPW81MHAaAc4EHsuu3tEpgXXBn
         72F1bNIz5InCgsGfBAYa5NzWCJINgwq0wen6JODxXVN5YlZp4bWko4kbeiOKD9Foq3U4
         Y/7SDX2CdRI9soNmSFelnovYaP4cCnQyZW3EZjCjmV7zS9vfmMmXtq6RS2jB/CxlJ4Xl
         Hb86vkTksYjZzREwiCFB/6FhKqiMOrBCngVv57EJW0z3LdHcSn6joZZg+hx1z5fbmjaL
         F54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LfHIa7qw8TX1EY1HP/cqr3eIXhrotpcdxEGlC9BCudw=;
        b=kNjAY3tpeQovPhhwkNU0rwse0e5+ruNqpbGTqzvTMObWavcV0F7WzNe8lDheKH/TkN
         lBxXrM7PUXhdhCcRRY0wI/w4J4n5yUbACLQkhBEIfjV2ejulg3Zi2XM+CbejEn//Y/OH
         HDRjTEtE/Ya4VxxJxR1Qbck2s5Qg56LfWxsNAX5H5xzw56Y/kA1WGh20TXLLIk7CLaGP
         WjfN+2CjRgZrkh7oEEre23tTHIshYp88PWupsEBhwATvCzz3e7SP8vY0QV+LGEJn2b4e
         BCxNuaN45Bg3/UJY7FtBuQQ5Ln5CXdnKQ5saiyB3Gp2967Sw6wP4QXaL6nk7cvOf+5tC
         1amA==
X-Gm-Message-State: AKGB3mJK9B/K//xzyxcdLbtB/x7ffRaB4i3A6PAVcVwt0cRuU+63xj1p
        p7MMklBhUuiV+e5E1vkF91euYrON
X-Google-Smtp-Source: ACJfBot6lFObKVTLftqkwBDoNQSRqotw3qG+8T/JO4n9I7Ct7Egg2sGaKjW4tThOxnlFz5r0NzpnHQ==
X-Received: by 10.223.196.247 with SMTP id o52mr3809917wrf.119.1513207194446;
        Wed, 13 Dec 2017 15:19:54 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r14sm6568514wrb.43.2017.12.13.15.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Dec 2017 15:19:53 -0800 (PST)
Date:   Wed, 13 Dec 2017 23:21:40 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
Message-ID: <20171213232140.GE24597@hank>
References: <20171210212202.28231-4-t.gummerer@gmail.com>
 <20171211210948.6867-1-szeder.dev@gmail.com>
 <20171211214255.GA24597@hank>
 <C5F93DFF-D3DF-4507-8546-941BFA768705@gmail.com>
 <xmqq609b3gi3.fsf@gitster.mtv.corp.google.com>
 <20171212201558.GB24597@hank>
 <xmqqvahbzn3c.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvahbzn3c.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >
> > The breakages wen the split-index code fails tend to break things in
> > much more obvious manners than a wrong message, usually git ends up
> > dying if it gets broken.  Both of the bugs that were fixed here would
> > have been caught with the change in my patch.
> >
> > But yeah I can see the argument that it doesn't give us a guarantee
> > that it catches all things the test suite could catch.
> 
> I think you misunderstood me.  When split index is much easier to
> break than poison tests, combining them together would hurt the test
> coverage of poison tests.  If you value poison tests much more than
> how well split index mode works, that is a worse outcome.

Sorry, indeed I misunderstood you.  I do agree with the above.

> >> I wonder if it makes more sense to update ci/run-tests.sh so that
> >> its final step is run twice with different settings, like so?
> >
> > I kind of wanted to avoid that, because it ends up running the test
> > suite twice on travis for every test, which seems a bit overkill.  But
> > I don't exactly how worried we are about cycles on travis (I don't
> > check it very often personally, so I don't really know).  If we aren't
> > worried about cycles what you have below would certainly make sense.
> 
> I think 64-bit gcc/clang builds tend to cost us about 10-20 minutes
> each, and 32-bit linux builds about 10 minutes or so.  I wonder if
> it makes sense to do the "run twice" for only one of 64-bit builds
> (perhaps the clang one, as I suspect 32-bit linux one uses gcc) and
> the 32-bit linux build, and nowhere else.

Yeah I'd be happy with something like that.  And I see there's some
more discussion about it in another part of the thread, will follow up
there.  Thanks!
