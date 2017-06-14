Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61FDC20282
	for <e@80x24.org>; Wed, 14 Jun 2017 17:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbdFNRVB (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 13:21:01 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35328 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbdFNRVA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 13:21:00 -0400
Received: by mail-pf0-f171.google.com with SMTP id l89so3382244pfi.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c0GiM39P5mJe72LetYyEpEYx4n0wE6t11jpbmS4UjuA=;
        b=LHO4X3AR34X0yFlSA5GKR452X2UHck9+XQkuJiy6XKjmjicPJn26rlxfPMIVqLPCOA
         dDOqXyxYhIda09RMqzYPJxdFqph6HzinOgOFY3w93YMBFTX4rn7EbVyyMnQgOvwb7x0/
         PXL/ZI1pPrCgYglDgmUoG5yTgKLni3JRxctzwVJFnHsiFIBS8UrH+lSseNV0oQHWL/K8
         0B5sbqCo+ZvEtYEJxrGgRK/7mPKu85Mz9G5vkJRsUsBghR66v67IVvzkSWSfXXwaSJ+7
         Y0dXk3mhkSxTuTqZBRt3MUvRlIPSt2fHxLF8eV/67UEjD5VZhtxDRccvurr1rJXY/gFn
         rRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c0GiM39P5mJe72LetYyEpEYx4n0wE6t11jpbmS4UjuA=;
        b=j0Fo7N2KH5HfL4iqaT0oOLzCnIjsfgPfcO9vS6/sY6fiUsC8w4YE2MZc4etV7TvWK4
         JH6VarryiNaoUbdM8uXRdgaIQSNtAsBqX+P0DLHg0d08yPStQoMaUe2EFIGvAj+BSxuB
         KYeZh3w/bP99CwmM1FdLfO58iwX/wc2TxcH+e27Prth6y9S/OElK0jPFKLI0vFN/mT8j
         IkrkogMYMDHBMGWo4raQl5lRmXwe75uwpdxWRhoe2zzUI4UAbzKDwl18doQdEf3XTSq3
         3i7coAwQZisMGCcgyLlvvfFCkwMlLK3q2AF21ZEdIu2arf+ntWOIJ8Xvw2uGfkrFTBqK
         NBlg==
X-Gm-Message-State: AKS2vOzRv4bmc41xuI5MqGA4wTz2qssjdZ2WRCI5wbRk1OqNTNpzsfHH
        wlHI70ISXD237yHNtZ/DnA==
X-Received: by 10.84.131.35 with SMTP id 32mr1270613pld.142.1497460859776;
        Wed, 14 Jun 2017 10:20:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:cd44:1c15:d824:b4e])
        by smtp.gmail.com with ESMTPSA id v3sm1046788pfi.73.2017.06.14.10.20.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 10:20:58 -0700 (PDT)
Date:   Wed, 14 Jun 2017 10:20:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] Use the early config machinery to expand aliases
Message-ID: <20170614172057.GC55677@google.com>
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
 <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de>
 <20170613182606.GO154599@google.com>
 <20170614055824.p2ueyiyfsdf6inve@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1706141223021.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706141223021.171564@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Johannes Schindelin wrote:
> Hi Peff & Brandon,
> 
> On Wed, 14 Jun 2017, Jeff King wrote:
> 
> > On Tue, Jun 13, 2017 at 11:26:06AM -0700, Brandon Williams wrote:
> > 
> > > So because I've been looking at the config machinery lately, I've
> > > noticed a lot of issues with how things are handled with respect to
> > > gitdir vs commondir.  Essentially the config resides at commondir/config
> > > always, and only at gitdir/config when not working with a worktree.
> > > Because of this, your patches point out a bug in how early config is
> > > handled.  I'll illustrate this using aliases.
> > > 
> > > Before this series (because aliases are read using the standard config
> > > machinery):
> > > 
> > >   > git init main
> > >   > git -C main config alias.test '!echo hello'
> > >   > git -C main test
> > >     hello
> > >   > git -C main worktree add ../worktree
> > >   > git -C worktree test
> > >     hello
> > > 
> > > After this series (using read_early_config()):
> > > 
> > >   > git init main
> > >   > git -C main config alias.test '!echo hello'
> > >   > git -C main test
> > >     hello
> > >   > git -C main worktree add ../worktree
> > >   > git -C worktree test
> > >     git: 'test' is not a git command. See 'git --help'.
> > > 
> > > The issue is that read_early_config passes the gitdir and not the
> > > commondir when reading the config.
> > 
> > Good catch.
> 
> Oh wow.
> 
> > > The solution would be to add a 'commondir' field to the config_options
> > > struct and populate that before reading the config.  I'm planning on
> > > fixing this in v2 of my config cleanup series which I'll hopefully have
> > > finished by the end of the day.
> > 
> > I think that read_early_config() really meant to set the commondir, as
> > it was always about actual config-file lookup. So it was sort-of buggy
> > already, though I suspect it was pretty hard to trigger.
> > 
> > But I agree that since include_by_gitdir now reads the same struct
> > field, swapping it out fixes the config-reading at the cost of breaking
> > that function. And we really need to pass both in.
> > 
> > I'm not sure whether we should care about this for Dscho's series or
> > not. I think his series _does_ make the problem easier to trigger. But
> > it's a minor enough bug that I think I'd be OK with letting your
> > solution proceed independently.
> 
> Brandon, how hard would it be to build on top of my series? I ask because
> I have to take care of some other things and would not have the time to
> adjust my patch series on top of yours anytime soon.

It should be pretty easy to just rebase ontop of your series.  I'll make
sure to do that before sending out the next revision of mine.

-- 
Brandon Williams
