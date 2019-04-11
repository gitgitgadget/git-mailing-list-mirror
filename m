Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF1A20248
	for <e@80x24.org>; Thu, 11 Apr 2019 19:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDKTnL (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 15:43:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38524 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDKTnL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 15:43:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so3946175pfo.5
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O56fxaeLDIgmGoX1Zksh82fMoXenfDgSw3Eo5U317lY=;
        b=cFAtYKxOFkfSAtVM91tN0I/XYkOTpNCV0hoUUq4Feb341OmuTtysh7dKUlTudLZ3Gc
         cm0t87tUCNhjrTLby3a6bmTFk3rqirWgMxRELyUiK4vdsC1WGR8+Qo6BcVQWDSGbr9TC
         NcqOyLjakgl1Kp9MNumQ+TngZEB4FBvsQWubMP6TYMSmibKh5YU22bxTz29ScmgnptqU
         sT/awM+Dr6jwNRTPywiLKTGJHd7q+OO7/lSfQqamtNTZvRhjC6iw5zRXfw1e2v+hTLOx
         sgSe8at7sHPSqs79uTwn7Z8Ntr95jS0Aat/f2OSO6xH7SiV/GaWgOnyx7KeXh3zQo9qA
         HdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O56fxaeLDIgmGoX1Zksh82fMoXenfDgSw3Eo5U317lY=;
        b=IszGMaxwPWReiheg6M7fAsdEe8IK1V2d13c8sK5sReovZARHRhswMyRcPYTgDfjVfs
         yDx9Y9KA+/yxE6ObAO8CpSVvEhKGD1GV10NYsZCaFh5qAah7bBVxlie7bcF38K1p240a
         N0vRlaZgiUAbhP95IGsbRvfEDguqGU4IhpOZwn/7VT+wqK/jYGS2q0qYYgH0mBWLl+b/
         U9/V9Q/zIvX1L2vsEUtftzUYuQ4Yf7VPxsgrh5iFJrkXJgjLLmgh+Ocgu4HVij4/oSPS
         rLdHeZArkWC9pqBeD2UgEk8zSjUTktklXYU8HHFrFHlg6HiNeBvwTDDb3jZC/PS2S9er
         pmHA==
X-Gm-Message-State: APjAAAVQPdbENUSbV4D29JUqsTSAdH5vdm1P4Sx8rdW/Qa86DSkQW8ml
        aRDMjQRDpFhQvTGY90ByN7fsE5Ir5u63rA==
X-Google-Smtp-Source: APXvYqzaC15/EOKFCUZ+auyAbJuiOpK58TCXDdV75L5MEv8P1up22V4C8JUmNt0IdTF4qVy0b+xZMA==
X-Received: by 2002:a63:c112:: with SMTP id w18mr49633368pgf.200.1555011790010;
        Thu, 11 Apr 2019 12:43:10 -0700 (PDT)
Received: from localhost ([205.175.106.70])
        by smtp.gmail.com with ESMTPSA id a24sm43283796pgv.10.2019.04.11.12.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 12:43:09 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 11 Apr 2019 12:43:08 -0700
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        =?utf-8?B?546L5YGl5by6?= <jianqiang.wang@securitygossip.com>
Subject: Re: [PATCH 0/4] use xmalloc in more places
Message-ID: <20190411194308.GA26327@D-10-18-172-132.dhcp4.washington.edu>
References: <20190411134736.GA28543@sigill.intra.peff.net>
 <20190411191452.GA21290@D-10-18-172-132.dhcp4.washington.edu>
 <20190411193735.GB32528@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411193735.GB32528@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, Apr 11, 2019 at 03:37:35PM -0400, Jeff King wrote:
> On Thu, Apr 11, 2019 at 12:14:52PM -0700, Taylor Blau wrote:
>
> > > This series cleans up most of the bare calls found by:
> > >
> > >   git grep -E '[^a-z_](m|c|re)alloc\(' '*.c' :^compat :^contrib :^wrapper.c
> >
> > This (admittedly pretty awesome) 'git grep' invocation reminds me of a
> > series I was pretty sure you wrote to ban functions like 'strcpy' and
> > other obviously bad things.
> >
> > Some quick searching turned up [1], which landed as f225611d1c
> > (automatically ban strcpy(), 2018-07-26). Do we want something similar
> > here? Of course, the locations below would have to be exempt, but it
> > seems worthwhile (and would save a review cycle in the case that someone
> > added a 'malloc' in a patch sent here).
>
> I don't think we can ban malloc, since we have to use it ourselves. :)
>
> With some contortions, we probably could unban it specifically in
> wrapper.c (though note there are a few other calls I've left which would
> need to be handled somehow).

Right. I think that I should have made this point clearer in my initial
reply. I was thinking that we could #undef the banned macro in
wrapper.c, or some similar hula-hooping.

> Another option would be coccinelle patches to convert malloc() to
> xmalloc(), etc (with an exception for the wrappers). I'm not entirely
> comfortable with automatic conversion here because there's often some
> follow-up adjustments (i.e., we can stop handling allocation errors and
> maybe delete some code). I think coccinelle can identify callers and
> barf, though.
>
> I'm not sure whether coccinelle saves review cycles (since that implies
> people actually run it, though maybe that is better now that it's part
> of Travis?). It seems to me that it's usually more helpful for people
> periodically doing follow-up auditing.
>
> So I dunno. If this was a common mistake I'd be more concerned with
> saving review cycles, but all of the cases I found were actually just
> leftovers from the very early days of Git.

Yeah... maybe that's the bigger question that I hadn't asked. I made the
suggestion thinking that it would help newcomers avoid writing
'malloc()' and sending it if they didn't know we use our 'xmalloc()'
instead.

But I'm not sure if the argument holds up. I think that in general
exactly the sorts of new-comers that I'm thinking of would have more
than one review cycle anyway, so it might not be worth the effort,
anyway...

> -Peff

Thanks,
Taylor
