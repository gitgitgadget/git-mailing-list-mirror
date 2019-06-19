Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509A31F462
	for <e@80x24.org>; Wed, 19 Jun 2019 22:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfFSWJ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 18:09:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45677 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSWJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 18:09:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so381691pfq.12
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0frCvFr5+HanNvrtHLhZ/m83nE1bby5MVPC7ns7QlE=;
        b=cwWY22ssUZmii+BesbISh5gri66gW3vSie7I1twxLHw5wmQvIDBMW2xlFNUlhZcoJI
         kIjoV8Qe/y4V2L0Q5YP/jEyLCqRg2VG/dv1f8TZs/PiZiRVAmK1YZEkSi10duBoAzcIO
         nvUPF2vtSE79Qrn3Uuon6RcUSpga5aPX0iM96+Hspe6mo7VLwUymY8npM+ju5PoL3ZEB
         GtsKUEC5jkU0usXY82fa10AN8AyRKd45B6NV51VQmODA9PpxKHc3CJSnxpoARDmetFO2
         /B1rRDN+peBOm8I8ZgZIn5aoKSNwEZgD+D7I28tjMLT6torSXnmqvOB1n10FF/YbLbGl
         UKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0frCvFr5+HanNvrtHLhZ/m83nE1bby5MVPC7ns7QlE=;
        b=WAi8hkqMLvcapJZUbS6aDsL1P1tXaI0Cwr4BPusLAhy4BmlZ5jficdbt3ufTqCnAw9
         UsRwJM83iQ0RG2o0ukPNV03T2uecaqAbAo4CO0jrB8MrDMGx91SlyeFZOfd6FSX1msSU
         TELYBmgjcCzhEXOPbBRA+fAx/J6/hKXtx/l0AYbW7udf20Ow3UUzeT5sJtFlkyNZ/Wg+
         rfBPDiAHCbTbJMX8o4InFjeIT6SCyFF5FOhWbof7T7MORCn6NKg411xQqF2Ewoa8TGgE
         Ay0ocAgPLfIf0MF0zBPCSCtU85wLZL8mGj7u2WegITXNx95bhqRNfRBdwMVkwoxfFAN1
         nPUQ==
X-Gm-Message-State: APjAAAU7/sG4bf6jYjp5wACZiNK3abrPHFlh8eyvnDPQgZVu9J+R1V7L
        /4DlqntN7Cww8nOU+IaOHMX4Ww==
X-Google-Smtp-Source: APXvYqwA4jcEAdBG4Ajm/RD3EWsJVAN1EFoequTlFNJTFP5XYxjqJijN3TQRnS9LHywGLci5eKC3yA==
X-Received: by 2002:a63:db05:: with SMTP id e5mr9726508pgg.121.1560982164570;
        Wed, 19 Jun 2019 15:09:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id d123sm25131937pfc.144.2019.06.19.15.09.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 15:09:23 -0700 (PDT)
Date:   Wed, 19 Jun 2019 15:09:19 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rev-list: clarify --abbrev and --abbrev-commit usage
Message-ID: <20190619220919.GG100487@google.com>
References: <20190613221541.10007-1-emilyshaffer@google.com>
 <20190614161841.GB30083@sigill.intra.peff.net>
 <20190614205950.GC233791@google.com>
 <20190614212714.GA15798@sigill.intra.peff.net>
 <20190614225654.GD233791@google.com>
 <20190619212159.GA6571@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619212159.GA6571@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 05:21:59PM -0400, Jeff King wrote:
> On Fri, Jun 14, 2019 at 03:56:54PM -0700, Emily Shaffer wrote:
> 
> > > Ah, I see. I don't consider "|" to indicate an exclusion to the point
> > > that the options are rejected. Only that you wouldn't want to use both,
> > > because one counteracts the other. So every "--no-foo" is mutually
> > > exclusive with "--foo" in the sense that one override the other. But the
> > > outcome is "last one wins", and not "whoops, we cannot figure out what
> > > you meant". And that's what the original:
> > > 
> > >       --abbrev=<n> | --no-abbrev
> > > 
> > > before your patch was trying to say (and I suspect there are many other
> > > cases of "|" with this kind of last-one-wins behavior).
> > 
> > For what it's worth, in this case it's not last-one-wins - --no-abbrev
> > always wins:
> 
> Ah, thanks for pointing that; I hadn't noticed. That _is_ unlike most of
> the rest of Git. I'm tempted to say it's a bug and should be fixed, but
> I worry slightly that it could have an unexpected effect.
> 
> > I think a good solution here is to go and add --abbrev-commit=<n>
> > without breaking support for --abbrev=<n>; I'm a little more worried
> > about changing --no-abbrev to last-one-wins but I'll take a crack at it
> > and see what the test suite says. While I'm at it, I'll check for
> > last-one-wins with multiple instances of --abbrev[-commit]=<n>.
> 
> I think --abbrev-commit=<n> sounds safe enough, though I worry it may
> get a bit complicated because we'd presumably want to fall back to the
> <n> from --abbrev=<n>. I'll see how your patch turns out. :)
> 
> I like the idea of changing --no-abbrev to last-one-wins, as above, but
> the test suite may not give us that much confidence. These kinds of
> cases are often not well-covered, and we're really worried about the
> wider world of random scripts people have grown over the last 10 years.
> Of course if the test suite does break horribly that might give us extra
> caution, but I'm not sure "the test suite does not break" gives us much
> confidence.

I think at that point, based on what I've seen on the list, there's a
tendency to include a config option to enable the new behavior. And I
think that might pass the tipping point of "wasted effort" for me.
The change isn't really enabling anything that was impossible before
(last-one-wins is handy, but it's legacy public behavior now for
--abbrev). So I'm kind of starting to lean towards doing nothing at all.
It's a lot of work, for a not-very-functional change, which needs to be
specially configured to even happen... So maybe I'll save my time and
work on actual bugs instead. :)

> 
> > Having done so, I'll also change the documentation here in rev-list to:
> >  --abbrev-commit[=<n>] [--abbrev=<n>] | --no-abbrev
> 
> Yeah, that makes sense.
> 
> -Peff

Thanks for the input, all. I think I'll drop this.

 - Emily
