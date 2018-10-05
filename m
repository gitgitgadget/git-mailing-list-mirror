Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8DB1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeJFCyb (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:54:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34857 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbeJFCyb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:54:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so14699867wrt.2
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Sc7AX6Yo6sn/S/MUmP2VZd/Et34Sfq4H/y3yNyfsfuY=;
        b=s48mrrRe7Nbo9YNNmgAhsdiUBUYUzOHLKkYV3JcaCXXH4W1eIZ7qQhwCN2AowkYhr6
         EjsWoC5rFRLAZYy6y8thUZgBqAjfrgceMnd950i/fNtmr0pKn8k/WOqRsDHXRAzfUhKg
         XQ1EV/D7PFrMxw7oXcKwRkO9rkh8evSpgenedjZR00vLcCk3xH8D/GgiShN5Ladv6m0c
         OzhLf5k1+oEyFvVGFceTc6NjUEbAC5UrEZWvrn5BQvoZ6iUwyzWOLgNl8AqJ7FnZRnB9
         Ipq9EXTXGqe+QedcmeH6Umkev8W2bFEGPOhm3QCZ68v/tHtuwCMZEwpgDIdGg9/THaAk
         aaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Sc7AX6Yo6sn/S/MUmP2VZd/Et34Sfq4H/y3yNyfsfuY=;
        b=B5LY47gL1G7UQunrKV7iJ4V7eeDikPd6G4LWx4IVx95rSMvXiG8NiPq/oty4WeikCC
         eWKJ/M9IWub+kZe4gdPIWrFaMDDWkn4P+viqCA3WwK1IrgWoMQsfgoxj3gIH9t/WBtdU
         uSWfC8CTWCDk7rDq66SGPN08Ezuy7euGXBHNUPRmbYYDWcaT2qr33LbypO1CSZqmn9fU
         2DdCntVXTqxIye+JTSMDQqevPh2jELJlGkdCB6HsbxBKoMESb57+7slaEmiJ6QHh+4rr
         h3aeVRM/xL53StI5fnxDxzY0XqJNQMSPTzRnat6sUaphfr2dnXslRKH3NY9g2X4lzZAq
         6whg==
X-Gm-Message-State: ABuFfoiT32BFjiQW0ZjJfwpnWCdDM2oQAWvUfslAVV9FFdaOuH8uXPyC
        eGxZuMKirzb3dIUQhg+rTWQ=
X-Google-Smtp-Source: ACcGV61MFCAg5n9BHmlqeXzNOY0RZfN0JNTloH2nadrU6b0TlZ6rcK6w6SWD/PKDc6SRk60rSd6Ugw==
X-Received: by 2002:a5d:4b06:: with SMTP id v6-v6mr8669443wrq.87.1538769256176;
        Fri, 05 Oct 2018 12:54:16 -0700 (PDT)
Received: from localhost (x4d0c6f69.dyn.telefonica.de. [77.12.111.105])
        by smtp.gmail.com with ESMTPSA id w2-v6sm10616612wre.46.2018.10.05.12.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 12:54:15 -0700 (PDT)
Date:   Fri, 5 Oct 2018 21:54:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181005195413.GX23446@localhost>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
 <20181005183904.GV23446@localhost>
 <20181005190216.GB17482@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005190216.GB17482@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 03:02:16PM -0400, Jeff King wrote:
> On Fri, Oct 05, 2018 at 08:39:04PM +0200, SZEDER Gábor wrote:
> 
> > > It should still be a net win, since the total CPU seems to drop by a
> > > factor of 3-4.
> > 
> > Well, that's true when you have unlimited resources... :)  or it's
> > true even then, when I have just enough resources, but not much
> > contention.  After all, Coccinelle doesn't have to parse the same
> > header files over and over again.  However, on Travis CI, where who
> > knows how many other build jobs are running next to our static
> > analysis, it doesn't seem to be the case.
> > 
> > On current master with an additional 'time' in front:
> > 
> >   time make --jobs=2 coccicheck
> >   <...>
> >   695.70user 50.27system 6:27.88elapsed 192%CPU (0avgtext+0avgdata 91448maxresident)k
> >   5976inputs+2536outputs (42major+18411888minor)pagefaults 0swaps
> > 
> >   https://travis-ci.org/szeder/git/jobs/437733874#L574
> > 
> > With this patch, but without -j2 to fit into 3GB:
> > 
> >   960.50user 22.59system 16:23.74elapsed 99%CPU (0avgtext+0avgdata 1606156maxresident)k
> >   5976inputs+1320outputs (26major+4548440minor)pagefaults 0swaps
> > 
> >   https://travis-ci.org/szeder/git/jobs/437734003#L575
> > 
> > Note that both the runtime and the CPU time increased. (and RSS, of
> > course)
> 
> I'm not sure what to make of those results. Was the jump in CPU _caused_
> by the patch, or does it independently fluctuate based on other things
> happening on the Travis servers?
> 
> I.e., in the second run, do we know that the time would not have
> actually been worse with the first patch?

Runtimes tend to fluctuate quite a bit more on Travis CI compared to
my machine, but not this much, and it seems to be consistent so far.

After scripting/querying the Travis CI API a bit, I found that from
the last 100 static analysis build jobs 78 did actully run 'make
coccicheck' [1], avaraging 470s for the whole build job, with only 4
build job exceeding the 10min mark.

I had maybe 6-8 build jobs running this patch over the last 2-3 days,
I think all of them were over 15min.  (I restarted some of them, so I
don't have separate logs for all of them, hence the uncertainty.)


1 - There are a couple of canceled build jobs, and we skip the build
    job of branches when they happen to match a tags.
