Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5921F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 11:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJJTGc (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 15:06:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34825 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJJTGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 15:06:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id e187-v6so5423206wmf.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L92A3QwpKhsBe5UW4bp0OQd//mkppWrow8O9n1vM214=;
        b=pVj/8Z4QombmDyytmU/w+s2F3AfJJk19jeK+XbV4OT15/9q/XxJJRwKY7eOXlxXk5D
         sAP1kRvf18pJ/mHi1kKHHXIcEYcddW+xt6fTHAVmFUh3dpQI6J+E6f0Z2btdhLiDydNk
         WMNvhAxFEZbCgb8GqhCiT5Fzw4MsavQ8eexEQaOFa4PMBxc8u9wz5vCVasjMiz2qQz6m
         jrAuSBImKJwSm90Bil/D5o3LTfPokKd58Nmd1HyryK6a5gSU7j7vvMMdegU74T90x9Bw
         N5zNPcXphJ+R2/qWmYn9KHp5fEsPbQVZhcPuPDVyE2cc+Ri6ld5NuYzVyPXaIyK5iIg2
         ULPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L92A3QwpKhsBe5UW4bp0OQd//mkppWrow8O9n1vM214=;
        b=XocGp9Z1ufV91pslumBDIYd0tI2mXaw30omAVBj35MtWREDLG8PNZUMfwobzRb+Uq0
         3O1OivSRARf8FlnSSyfzvWfaajDuxRZccfWlgYAlbyCpUw0t2T6t1ogSPIKFFs5YtJyX
         ByIe5Zq/pLK5ndFSpbAfOXInxqADfTxFrQxFBAVI66hh3hhpfBNyJ6tVvVlw9Vy/uwwy
         ldCqokF+Ldgv/hnrOjlJH5PJi+3NPYRcbtkacMc1OOFdbcOmyv7pJkmOMy5PwMR6wc3d
         NAmtUKLSQ8YrKF8bwEys2hOpbZW/VSJFmioPFBqF2E51Om2+Y1l5UK/ZdBb83+ca/4IM
         AMtw==
X-Gm-Message-State: ABuFfojm+gC3y/aah+HMjs209lIDkCRegskKsa2dKaEfqlWatX0VKEMv
        djIxEQe3wF73OQV4I0dCCfQ=
X-Google-Smtp-Source: ACcGV60Y8s44IeIbCiwjdHE7x+uu7Ii0GJXw27ZdHgpG30hcXIhkcGRaxYX+8x2tYJd9SH0k/lmi8Q==
X-Received: by 2002:a1c:be09:: with SMTP id o9-v6mr596692wmf.109.1539171884491;
        Wed, 10 Oct 2018 04:44:44 -0700 (PDT)
Received: from szeder.dev (x4db070c3.dyn.telefonica.de. [77.176.112.195])
        by smtp.gmail.com with ESMTPSA id j128-v6sm14644048wmb.43.2018.10.10.04.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 04:44:43 -0700 (PDT)
Date:   Wed, 10 Oct 2018 13:44:41 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181010114441.GD23446@szeder.dev>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
 <20181005183904.GV23446@localhost>
 <20181005190216.GB17482@sigill.intra.peff.net>
 <20181005195413.GX23446@localhost>
 <20181009031542.GD6250@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181009031542.GD6250@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 08, 2018 at 11:15:42PM -0400, Jeff King wrote:
> On Fri, Oct 05, 2018 at 09:54:13PM +0200, SZEDER Gábor wrote:
> 
> > Runtimes tend to fluctuate quite a bit more on Travis CI compared to
> > my machine, but not this much, and it seems to be consistent so far.
> > 
> > After scripting/querying the Travis CI API a bit, I found that from
> > the last 100 static analysis build jobs 78 did actully run 'make
> > coccicheck' [1], avaraging 470s for the whole build job, with only 4
> > build job exceeding the 10min mark.
> > 
> > I had maybe 6-8 build jobs running this patch over the last 2-3 days,
> > I think all of them were over 15min.  (I restarted some of them, so I
> > don't have separate logs for all of them, hence the uncertainty.)
> 
> So that's really weird and counter-intuitive, since we should be doing
> strictly less work. I know that spatch tries to parallelize itself,
> though from my tests, 1.0.4 does not. I wonder if the version in Travis
> differs in that respect and starts too many threads, and the extra time
> is going to contention and context switches.

I don't think it does any parallel work.

Here is the timing again from my previous email:

  960.50user 22.59system 16:23.74elapsed 99%CPU (0avgtext+0avgdata 1606156maxresident)k

Notice that 16:23 is 983s, and that it matches the sum of the user and
system times.  I usually saw this kind of timing with CPU-intensive
single-threaded programs, and if there were any parallelization, then I
would expect the elapsed time to be at least somewhat smaller than the
other two.

> Have you tried passing "-j1" to spatch? My 1.0.4 does not even recognize
> it.

I have just gave it a try, but the v1.0.0 on Travis CI errored out with
"unknown option `-j'.

  https://travis-ci.org/szeder/git/jobs/439532822#L566

> That seems like a pretty unlikely explanation to me, but I am having
> trouble coming up with another one.
> 
> I guess the other plausible thing is that the extra memory is forcing us
> into some slower path. E.g., a hypervisor may even be swapping,
> unbeknownst to the child OS, and it gets accounted in the child OS as
> "boy, that memory load was really slow", which becomes used CPU.
> 
> That actually sounds more credible to me.
> 
> -Peff
