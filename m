Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9BC1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 19:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGCTGr (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 15:06:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35483 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCTGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 15:06:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id c27so4043860wrb.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C4u7mTmf7WrQLNiFF8JYo2YLZMmvbrtztwVVstfKQEE=;
        b=NUMUYbkOoLZOXI8u+0sjAxoWWfccnhnWusU2FpjmOO2OHT9kgUAXb2xS11b5gQtJ86
         pX/kGqnUaw/KJ9Lo4cnp/mE7Mq42w5OMgFB2dLK8Q5y3ONYZOc20tA6h7DKcEvroGwbT
         2iPA15RTRkiw6zdCj9tVeTp1F1vaeRzeZmAW7Yyn38bZoPxBc9mJJEog+rM/6MQPz/md
         25CZ8T04DMta9LdcGN5AW/6CKYNOLtU7Dnrk9kBlDzNVHCUPNrv1mmdQFTdQl2bbHlSW
         mlmeb2e8VJTzlW9aUr93U9nYyl+wbIhDAwsyb8eZCys6/GRh8Jm7ZR+WbGvMQM1CUT7g
         Xpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C4u7mTmf7WrQLNiFF8JYo2YLZMmvbrtztwVVstfKQEE=;
        b=c1YkJ2wRag3ximnsd905j4jZcX6pmm0GUF+RaLbZcrgnNcZinZbPqInO3jW/8UHIwf
         bxyhl6HvVDyX5Qewakm7FiCZ6pASnIhT7xDdzCWZym+jxE59Fpzlwj/dCdewpDzU0QVp
         qsFhllNnVMUvAJWKRMBnwf+QGYaI6Hr40ltmd1kU8HIvFQLgZyrDeGqqXHXTESYeD9rg
         HycgM4BcBl1VTOh54FXGzO5hFcXvbmU0X3DXi3rZ1wB3cmwOIShFlS4nxYH2T8zAMHtP
         /grjSCKl4nhSbwJWrlAc6VdFGyI0W5LWEOemi6dgw1A93JTpBO2NqukClN3BQIY7l2FR
         CBzw==
X-Gm-Message-State: APjAAAXsFncUXVUtpxCTAH20ej75RlnD9qNXYswT7TGY85AtS/JZsOtu
        kV5ta8TGGiB2pCwSvCNFUH4=
X-Google-Smtp-Source: APXvYqzvx3jeN8gwgFD+CTvpzSVXGa/QPDdAj4OFpJVU1HLyeUZq1BRanVSkjWQs9YwYdGbyY7AhZg==
X-Received: by 2002:a5d:56cb:: with SMTP id m11mr30124013wrw.255.1562180804913;
        Wed, 03 Jul 2019 12:06:44 -0700 (PDT)
Received: from szeder.dev (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id u1sm2441967wml.14.2019.07.03.12.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 12:06:44 -0700 (PDT)
Date:   Wed, 3 Jul 2019 21:06:39 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
Message-ID: <20190703190639.GA20404@szeder.dev>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 03, 2019 at 10:50:26AM -0700, Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Here's another try at completion fixes, cleanups, and more tests. Some
> > of these have already been sent.
> >
> > Felipe Contreras (14):
> >   completion: zsh: fix __gitcomp_direct()
> >   completion: zsh: fix for directories with spaces
> >   completion: remove zsh hack
> >   completion: zsh: improve main function selection
> >   completion: prompt: fix color for Zsh
> >   completion: bash: cleanup cygwin check
> >   completion: zsh: update installation instructions
> >   completion: bash: remove old compat wrappers
> >   completion: bash: remove zsh wrapper
> >   completion: zsh: trivial cleanups
> >   test: completion: tests for __gitcomp regression
> >   test: completion: use global config
> >   completion: add default options
> >   completion: add default merge strategies
> >
> >  contrib/completion/git-completion.bash | 202 +++++++++++++------------
> >  contrib/completion/git-completion.zsh  |  53 +++----
> >  contrib/completion/git-prompt.sh       |  10 +-
> >  t/t9902-completion.sh                  |  37 +++--
> >  4 files changed, 161 insertions(+), 141 deletions(-)
> 
> Having scanned the discussion threads so far, I think the last four
> patches are going against the list consensus of (1) it is OK to rely
> on --git-completion-helper; using ancient Git with new completion
> script won't obviously work, but that is "if it hurts, don't". (2)
> some subcommands will fail the --git-completion-helper request
> (e.g. outside a repository), but as long as the output from failed
> request is not cached, it is OK.
> 
> But we haven't seen any response to the earlier zsh specific
> patches.  Does it mean that nobody other than Felipe cares about
> having a working Git completion for zsh?  Or does it mean that all
> users other than Felipe are happy with the current Git completion
> for zsh and it works very well for them already?  Or somewhere in
> between?
> 
> What I am trying to get at is if we would want to keep the earlier
> zsh parts of the series, but with nobody seemingly interested in, it
> is hard for me to justify queuing them.

I'm not a Zsh user and am mostly unfamiliar with its antics, but
FWIW...

Zsh has its own git completion routines, which are in some aspects
more advanced than what can be achieved with Bash's completion
facilities (or more wasteful in screen real estate, depending on your
preferences :), e.g. Zsh's completion shows a short description for
each completeable --option and whatnot).  I suppose that the avarage
Zsh & Git user uses Zsh's own git completion instead of our Bash
completion script wrapped for Zsh.

Having said that, I applied the first 7 patches in my tree and then
followed the updated installation instructions, and it finally worked.
I remember trying it in the past once or twice, to check whether some
of my bigger completion updates break something in Zsh, but it never
worked.  So these patches (and perhaps patch 10 as well) seem to be a
definite improvement (though admittedly I haven't tested them
thoroughly).

As for the latter part of the series, I think the more hard-coded
options we can get rid of the better we are off, and I would rather
not see them making a comeback.  I don't really have an opinion about
patches 8 and 9 (that old wrapper is probably just bitrotting away,
but I just tried to source our bash completion script from Zsh, and
apart from the deprecation warning it appeared to work).

