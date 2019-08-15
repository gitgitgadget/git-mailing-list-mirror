Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9181B1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 22:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfHOWYe (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 18:24:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34670 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbfHOWYe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 18:24:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id b24so2052422pfp.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adnRuobOrD3egO7MNU98kt9vHq/JAdY9ax///uq1BXc=;
        b=WDYb7j9GdSqFkM2qpErp948FU7m8+7bC7tphVItV0lKkOa4hg8pDefmCRjCMHf5lj0
         ehWi5DRUhoHBGhe/4C9jTaAVeKmEmbLP5j6ufn4z+6AKo4KLCvuz0EvBFGz8tso2FMRb
         HgdvCTscMQMZlgMtya6Qu6z32aNbMLuj/mFUpw9Wrs76uDDpIDru8VJk9lJwfPeyYpBQ
         Ud4UGVXm1MWUXHc2wmww8Xeo53MUOEAOX/eqtyFtupeQMufqtHhWjorPPjm+rcYu/Bsw
         sfi0/FJqgUoyFy+HTtz93OiiE/bBKKykekH4O2Gva8buZVECO0fDoRLa9NlMFamZer+F
         3dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=adnRuobOrD3egO7MNU98kt9vHq/JAdY9ax///uq1BXc=;
        b=LAIHBASsCrcrxv3o3zXokAof6OVlx5tnQkvg1398Cx45JWjg1aejSUQH8J5/F0WhVz
         GwaUjoPPKAIarajbF6Evx6QanCT+IIfiDSCjbcNreL+OMk8xi+36sZkGjTEIZPBi9Nu0
         rx35bEVhJ7NZ8rBWF/vKnNEzyXTY8/5Y0WFfcBNvQ/OSawaIs5N+KtsbVc12taR8UL0r
         bNeoczllAUPE9f/Yl92ntxk5RFlyuQsSpNUpQiZOaogI6799gGnSZHldjneRNayyek8d
         HNE/FAd8WffI03T8xKRX5YshuWLepui684gGDKDNW0nUPupjhsjdbZvv96zUBO5MkK1u
         Vm+Q==
X-Gm-Message-State: APjAAAVB97PnGBVaeofWDUjmyF4IMqT92P9/Z8/10X4R7Olr46Yr/HAu
        J+0CGLnjoiEJAcXG4sTk+NxlBg==
X-Google-Smtp-Source: APXvYqzq9PpqBtojGbOd9k1vjdsNTJMuVGTWDa8urywCIEk4S6Uqtbj53I24GaFSE6xfNnfHjlsS0A==
X-Received: by 2002:aa7:946d:: with SMTP id t13mr7821595pfq.121.1565907872583;
        Thu, 15 Aug 2019 15:24:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w189sm3754846pfb.35.2019.08.15.15.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 15:24:31 -0700 (PDT)
Date:   Thu, 15 Aug 2019 15:24:27 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
Message-ID: <20190815222427.GC208753@google.com>
References: <20190815023418.33407-1-emilyshaffer@google.com>
 <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
 <nycvar.QRO.7.76.6.1908152205390.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1908152205390.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 10:07:57PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 15 Aug 2019, Derrick Stolee wrote:
> 
> > On 8/14/2019 10:34 PM, Emily Shaffer wrote:
> > > diff --git a/git-bugreport.sh b/git-bugreport.sh
> > > new file mode 100755
> > > index 0000000000..2200703a51
> > > --- /dev/null
> > > +++ b/git-bugreport.sh
> >
> > At first I was alarmed by "What? another shell script?" but this
> > command should prioritize flexibility and extensibility over speed.
> > Running multiple processes shouldn't be too taxing for what we are
> > trying to do here.
> 
> Git for Windows sometimes receives bug reports about Bash not being able
> to start (usually it is a DLL base address problem, related to the way
> Cygwin and MSYS2 emulate `fork()`).

Hmm. In a case like this, then, how is someone using GfW at all?
Embarrassingly, I don't actually have a way to try it out for myself.
It seems there's no GUI, and users are using it through the command line
in mingw, so when you say "bash doesn't start" do you mean "users can't
use the mingw prompt at all"?

> 
> In such a case, `git bugreport` would only be able to offer a reason for
> yet another bug report instead of adding useful metadata.
> 
> Something to keep in mind when deciding how to implement this command.
> 
> Ciao,
> Dscho

Yeah, that's an interesting point, thanks for bringing it up. So, in the
case when bash won't start at all, what does that failure look like? How
much of Git can users still use? For example, would they be able to get
far enough to run a binary git-bugreport?

 - Emily
