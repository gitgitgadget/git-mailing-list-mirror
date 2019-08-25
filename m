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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EBA61F461
	for <e@80x24.org>; Sun, 25 Aug 2019 08:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfHYIKB (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 04:10:01 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33187 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfHYIKB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 04:10:01 -0400
Received: by mail-ed1-f47.google.com with SMTP id s15so21428013edx.0
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 01:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hePmEPivWB5pM5pQwcAOIuuFuA+AKq9NzXd/RaI8QqI=;
        b=NOpD4WagYCHLpsLpuTfnpUNZ6PCMlaMkjpNsxCDGxP+XZVNPQGhyc0JUZD8QG0SLCS
         Rby0fzy0umOPTkVOI4f2jMHoUFIqip5nVdLOnIpcSlotHbSmuAGk8v9UzM+hXGD9JjXe
         CiZuUVX6f85BFevMfX8b4qTLu4K8eTABflbhYhK4pTbEdcMxKRhrJ1loC3Hdv+xI7m0r
         /r1r1VF8/WQm5BtYrHLnazolHD9DOfct0HQfkTczr6PMGOXeA1DTL57BFRI5Va1m4eMD
         /sYKe478reys4Cqu+YTM6CMN3IlIJGYMq8GKqOxMB/VPVBRvbYTJ9xpnq9+GtnBV1zP+
         we0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hePmEPivWB5pM5pQwcAOIuuFuA+AKq9NzXd/RaI8QqI=;
        b=kDX8mPFlfqFK+Om1c+qW9YfwkyLK5mpAarCB2w5IeQjsqK78RDP4QEf+x9Vfp4tbAR
         33sJIcMK1F6dlmeeuD69jBBeTLIw/tHlE3VdQF/VC15D77bDvfV5QsdmpFvZ40DNEwd2
         X+u3q8sSHFk7kYr3DS9cGx3FHXUDZp/hJFlfuEKxf2EtgyEY8V7tiApai1IKM9r8DC7U
         kBvQRNNaYyMrtMM2YUSnvQiE4a2eBHgSDW8AaUrank/3BM6S3Pm4CantE6EtqPnCL9L2
         TcoMK2V7xNRH+F1DyMmDO1W7FQdVtLZNGgL++KaOIovvjJlhEoqv44OmbjddZOObOqcZ
         oJhA==
X-Gm-Message-State: APjAAAXRPSfCsl9zHZhPxxLgcKTReBwTBK2Mjddx7LYbPbbpJgOSQDFX
        dKodoxQbWCwkwlGZflO6BVU=
X-Google-Smtp-Source: APXvYqyesya6DNhShzD2dU+BetNqrpsybICvqDouOTYyO7oPvIWf8pRTzENWBHa3v5EQRdIXdXjvhQ==
X-Received: by 2002:a17:906:490d:: with SMTP id b13mr11590509ejq.16.1566720599092;
        Sun, 25 Aug 2019 01:09:59 -0700 (PDT)
Received: from instance-template-1.europe-west6-a.c.vaulted-journal-250706.internal (169.120.65.34.bc.googleusercontent.com. [34.65.120.169])
        by smtp.gmail.com with ESMTPSA id e12sm1788086ejc.84.2019.08.25.01.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Aug 2019 01:09:58 -0700 (PDT)
Date:   Sun, 25 Aug 2019 08:09:56 +0000
From:   Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>
To:     Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190825080956.GA15000@instance-template-1.europe-west6-a.c.vaulted-journal-250706.internal>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com>
 <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
 <20190823082900.GG20404@szeder.dev>
 <20190824174952.GA688@instance-template-1.europe-west6-a.c.vaulted-journal-250706.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190824174952.GA688@instance-template-1.europe-west6-a.c.vaulted-journal-250706.internal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 24, 2019 at 05:49:52PM +0000, Giuseppe Crinò wrote:
> On Fri, Aug 23, 2019 at 10:29:00AM +0200, SZEDER Gábor wrote:
> > What I wonder is whether we really have to remove crud from the user
> > name if it comes from the configuration.
> 
> Yes. If the primary use of removing crud is to remove quotes from a
> quoted name (as in `From: 'Foo baz Bar'`) why not directly removing
> pairs of quotes around the name and leave crud _inside_ the name?

I keep forgetting crud is removed *around* the name.

By the way, it's probably more conservative to remove crud (without
removing quotes) and finally remove surrounding quote pairs.
