Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A261F403
	for <e@80x24.org>; Wed,  6 Jun 2018 21:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeFFVcR (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 17:32:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34279 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbeFFVcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 17:32:16 -0400
Received: by mail-pl0-f67.google.com with SMTP id g20-v6so4618764plq.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uxPPqRl1mj6AYV6m5+fXj33zp0fE1jbSx2Z5OTlH6r4=;
        b=Df8oHtCJmq0kpQT8rRyrb+5zHWBsmlrf1TRO31pNgsWWqxSHTkudjR6lfAtK1q8W7o
         RK81j9up0RUBuNDdsgO8jYVS4vjkK5h9yXjZhls2onDPVHC5hnfF+xVpxsPMn8hpXliz
         tuFGhZyiZM/nn1F/gmB9mk/CxvSzmoCIrSO4YrAAjipQFd1+b+x1zJeD5XtpNVELL7dJ
         EPWTQuKu5Z7pYUDYY7BuBduZaQYTeyI1axQv69dZnrcp7AmANy22M0eUIxJ9+rXeBYFJ
         fwJz13Os4WhfPUcPqFEXl4VuMurjDMWByV7vB7NPCXFlcjZhe3o5pHE6owJOcoxAGGiu
         FERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uxPPqRl1mj6AYV6m5+fXj33zp0fE1jbSx2Z5OTlH6r4=;
        b=t4gDtCDjRGRamit/Ndzlh0Z9PnxDMEA9wGM1PpP/rFBS6zi6r9lCgMlSexZYoXUKZL
         OQ09wJnejV91B/JkuFh1MPH5qZ1ZQ4t6S/tJIcwFM3cKi1GfWDdERERfvxcm3vk8X9bk
         HvCgEbnkExn2t28GcVQOlGsPX+fLaqhjBsAZKwja5YiArNNLGxCQ3SqZ7PmyfFcDmlaY
         8teXFEDduCmyrTavDX+BfywAEXNKvwJ18vuHz81WAAwsTHE05zrURl9N/jsiXyfD0Bj5
         6+l4/SRLd6qdTKt4KwB0b1N3k0u2Ka7QKdXwgPjiM1sJT7EADjSqbm07BV+vVue7uepr
         aEfA==
X-Gm-Message-State: APt69E0iM7dml0k/iXD4eUJFJSxCN7557Ul8hOXZhXQE+Kow04BmcW+g
        AD6BybFpSpPNXFapcNWwarfLYQ==
X-Google-Smtp-Source: ADUXVKIGu3xX76rlpuFFn0TrJVP6R6468oYuQMuUKW/oPqRlK4kRY21G4YbfElmZLf6tXpN3ZrOw3A==
X-Received: by 2002:a17:902:bd8f:: with SMTP id q15-v6mr4714091pls.161.1528320735795;
        Wed, 06 Jun 2018 14:32:15 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t21-v6sm13287697pfi.22.2018.06.06.14.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 14:32:14 -0700 (PDT)
Date:   Wed, 6 Jun 2018 14:32:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] upload-pack: implement ref-in-want
Message-ID: <20180606213213.GA154134@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
 <20180605175144.4225-3-bmwill@google.com>
 <87po15ynx1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87po15ynx1.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jun 05 2018, Brandon Williams wrote:
> 
> > +uploadpack.allowRefInWant::
> > +	If this option is set, `upload-pack` will support the `ref-in-want`
> > +	feature of the protocol version 2 `fetch` command.
> > +
> 
> I think it makes sense to elaborate a bit on what this is for. Having
> read this series through, and to make sure I understood this, maybe
> something like this:
> 
>    This feature is intended for the benefit of load-balanced servers
>    which may not have the same view of what SHA-1s their refs point to,
>    but are guaranteed to never advertise a reference that another server
>    serving the request doesn't know about.
> 
> I.e. from what I can tell this gives no benefits for someone using a
> monolithic git server, except insofar as there would be a slight
> decrease in network traffic if the average length of refs is less than
> the length of a SHA-1.

Yeah I agree that the motivation should probably be spelled out more,
thanks for the suggestion.

> 
> That's fair enough, just something we should prominently say.
> 
> It does have the "disadvantage", if you can call it that, that it's
> introducing a race condition between when we read the ref advertisement
> and are promised XYZ refs, but may actually get ABC, but I can't think
> of a reason anyone would care about this in practice.
> 
> The reason I'm saying "another server [...] doesn't know about" above is
> that 2/8 has this:
> 
> 	if (read_ref(arg, &oid))
> 		die("unknown ref %s", arg);
> 
> Doesn't that mean that if server A in your pool advertises master, next
> & pu, and you then go and fetch from server B advertising master & next,
> but not "pu" that the clone will die?
> 
> Presumably at Google you either have something to ensure a consistent
> view, e.g. only advertise refs by name older than N seconds, or globally
> update ref name but not their contents, and don't allow deleting refs
> (or give them the same treatment).
> 
> But that, and again, I may have misunderstood this whole thing,
> significantly reduces the utility of this feature for anyone "in the
> wild" since nothing shipped with "git" gives you that feature.
> 
> The naïve way to do slave mirroring with stock git is to have a
> post-receive hook that pushes to your mirrors in a for-loop, or has them
> fetch from the master in a loop, and then round-robin LB those
> servers. Due to the "die on nonexisting" semantics in this extension
> that'll result in failed clones.
> 
> So I think we should either be really vocal about that caveat, or
> perhaps think of how we could make that configurable, e.g. what happens
> if the server says "sorry, don't know about that one", and carries on
> with the rest it does know about?

Jonathan actually pointed this out to me earlier and I think the best
way to deal with this is to just ignore the refs that the server doesn't
know about instead of dying here. I mean its no worse than what we
already have and we shouldn't hit this case too often.  And that way the
fetch can still proceed.

> 
> Is there a way for client & server to gracefully recover from that?
> E.g. send "master" & "next" now, and when I pull again in a few seconds
> I get the new "pu"?

I think in this case the client would just need to wait for some amount
of replication delay and attempt fetching at a later point.

> 
> Also, as a digression isn't that a problem shared with protocol v2 in
> general? I.e. without this extension isn't it going to make another
> connection to the naïve LB'd mirroring setup described above and find
> that SHA-1s as well as refs don't match?

This is actually an issue with fetch using either v2 or v0.  Unless I'm
misunderstanding what you're asking here.

> 
> BREAK.
> 
> Also is if this E-Mail wasn't long enough, on a completely different
> topic, in an earlier discussion in
> https://public-inbox.org/git/87inaje1uv.fsf@evledraar.gmail.com/ I noted
> that it would be neat-o to have optional wildmatch/pcre etc. matching
> for the use case you're not caring about here (and I don't expect you
> to, you're solving a different problem).
> 
> But let's say I want to add that after this, and being unfamiliar with
> the protocol v2 conventions. Would that be a whole new
> ref-in-want-wildmatch-prefix capability with a new
> want-ref-wildmatch-prefix verb, or is there some less verbose way we can
> anticipate that use-case and internally version / advertise
> sub-capabilities?
> 
> I don't know if that makes any sense, and would be fine with just a
> ref-in-want-wildmatch-prefix if that's the way to do it. I just think
> it's inevitable that we'll have such a thing eventually, so it's worth
> thinking about how such a future extension fits in.

Yes back when introducing the server-side ref filtering in ls-refs we
originally talked about included wildmatch or other forms of pattern
matching.  We opted to not over complicate things and favored prefix
matching because it didn't bake in some subset of globbing or regex and
it was easier to compute on the server side.

Anyway back to your question.  Yes if at some point in the future we
wanted to add in wildmatch/pcre to the protocol for ls-refs or for
ref-in-want then it could be added as a feature or capability.  I don't
think it would require adding a whole new verb (it probably would for
the ls-refs case since the verb used there is "ref-prefix") but the
capability could mean that the "want-ref" verb now understands wildmatch
patterns in addition to fully qualified refs.

-- 
Brandon Williams
