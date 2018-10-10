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
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB311F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 11:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJJTFB (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 15:05:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33162 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeJJTFB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 15:05:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so5384768wrs.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=H7x9QfShmzZ/ZkAYuY3Qw0hNvdRy/5bC4uwMadIk+14=;
        b=tFyB0pDjO9MLHnO9t78BLs1iNqmULWl8AaJT+R4I/v3uWbGEjpfP8JXZBlG+FwcEYD
         KrPjtMTnlD6GutGAZb7DtqnEMz31+JwIsZWTMp1AOA+vfXkDvdtWxrDm531IoZX/JnBc
         cu+rO7LO7zfb7zy3iGG8fJQI/sbQrLe7xZLVdANCogUS7mL+MppYtFk5lGDOAR1V5qsW
         ZBjIlz8iheVc9JoLg4QjH+6REj59YECB41HYKauCy9gyasFKALVJSPLvdiIQQkI1ST7D
         NEtifzxOhSMoYYTc/rz7b/bnKVkUChulYirbrK39O76nNHQECFCmg64jVowndJRdFCty
         vO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=H7x9QfShmzZ/ZkAYuY3Qw0hNvdRy/5bC4uwMadIk+14=;
        b=cVXbitGNNnjF6vDLO70ty5QhBXBeGt+neZrkyCF/ttMNHa253jrWU9O2Mz1N4vBS8Y
         axwsStWeI2ZVPJc7mdUi9MQRXkkQGOEwvinz05+GGlekV1BEBiahFujV6l2pe1KDL+dQ
         U+SQHdJdLGiOFZRbYYRDOBBGwIZl3rOrqgxJMDf8XpwpRjrsYkXwEAgGX5kUip4DRGrg
         sx3YZtp5lV+YVdm/tQ1nV9sE06ARRJq5lVlsSfX0xyq+PORJzJw+vHiVT/e3U9f/E8vd
         59Kv6JhpCI5hNoGlpPCI/8I8B5XFZYdOAX1t1pjtYoA0yM7kL35xzPSAdWTCzUM8T5dZ
         dKfw==
X-Gm-Message-State: ABuFfojFFjwUH1NL0Yp/7JOJH348MEruB8VfqXZoM31rOdK76D861L2G
        bRuLzWxMwQxAh9Ts4EVj+vU=
X-Google-Smtp-Source: ACcGV60M7knUA+2yV63C5Adoo6yDU6gVRTKr6vvEf8WvVKePaNHzy2FIDSjMZunbV6ZPDOPu8HB+bQ==
X-Received: by 2002:adf:a547:: with SMTP id j7-v6mr25449448wrb.220.1539171793144;
        Wed, 10 Oct 2018 04:43:13 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 67-v6sm15542226wmd.1.2018.10.10.04.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 04:43:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, e@80x24.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git svn clone/fetch hits issues with gc --auto
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com> <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com> <20181009234502.oxzfwirjcew2sxrm@dcvr> <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com> <CACPiFCL0oTjN+-aYgKEDtKC0gYwkv6RLMwakdJV85PJ5XQej6g@mail.gmail.com> <878t36f3ed.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <878t36f3ed.fsf@evledraar.gmail.com>
Date:   Wed, 10 Oct 2018 13:43:11 +0200
Message-ID: <877eiqf2nk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Ævar Arnfjörð Bjarmason wrote:

> On Wed, Oct 10 2018, Martin Langhoff wrote:
>
>> Looking around, Jonathan Tan's "[PATCH] gc: do not warn about too many
>> loose objects" makes sense to me.
>>
>> - remove unactionable warning
>> - as the warning is gone, no gc.log is produced
>> - subsequent gc runs don't exit due to gc.log
>>
>> My very humble +1 on that.
>>
>> As for downsides... if we have truly tons of _recent_ loose objects,
>> it'll ... take disk space? I'm fine with that.
>
> As Jeff's
> https://public-inbox.org/git/20180716175103.GB18636@sigill.intra.peff.net/
> and my https://public-inbox.org/git/878t69dgvx.fsf@evledraar.gmail.com/
> note it's a bit more complex than that.
>
> I.e.:
>
>  - The warning is actionable, you can decide to up your expiration
>    policy.
>
>  - We use this warning as a proxy for "let's not run for a day",
>    otherwise we'll just grind on gc --auto trying to consolidate
>    possibly many hundreds of K of loose objects only to find none of
>    them can be pruned because the run into the expiry policy. With the
>    warning we retry that once per day, which sucks less.
>
>  - This conflation of the user-visible warning and the policy is an
>    emergent effect of how the different gc pieces interact, which as I
>    note in the linked thread(s) sucks.
>
>    But we can't just yank one piece away (as Jonathan's patch does)
>    without throwing the baby out with the bathwater.
>
>    It will mean that e.g. if you have 10k loose objects in your git.git,
>    and created them just now, that every time you run anything that runs
>    "gc --auto" we'll fork to the background, peg a core at 100% CPU for
>    2-3 minutes or whatever it is, only do get nowhere and do the same
>    thing again in ~3 minutes when you run your next command.
>
>  - I think you may be underestimating some of the cases where this ends
>    up taking a huge amount of disk space (and now we'll issue at least
>    *some*) warning. See my
>    https://public-inbox.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/
>    where a repo's .git went from 2.5G to 30G due to being stuck in this
>    mode.
>
>> For more aggressive gc options, thoughts:
>>
>>  - Do we always consider git gc --prune=now "safe" in a "won't delete
>> stuff the user is likely to want" sense? For example -- are the
>> references from reflogs enough safety?
>
> The --prune=now command is not generally safe for the reasons noted in
> the "NOTES" section in "git help gc".
>
>>  - Even if we don't, for some commands it should be safe to run git gc
>> --prune=now at the end of the process, for example an import that
>> generates a new git repo (git svn clone).
>
> Yeah I don't see a problem with that, I didn't know about this
> interesting use-case, i.e. that "git svn clone" will create a lot of
> loose objects.
>
> As seen in my
> https://public-inbox.org/git/87tvm3go42.fsf@evledraar.gmail.com/ I'm
> working on making "gc --auto" run at the end of clone for unrelated
> reasons, i.e. so we generate the commit-graph, seems like "git svn
> clone" could do something similar.
>
> So it's creating a lot of garbage during its cloning process that can
> just be immediately thrown away? What is it doing? Using the object
> store as a scratch pad for its own temporary state?

To answer my own question (which was based on a thinko) it's continually
creating loose objects during import, i.e. packs are not involved (don't
know why I thought that), so yeah, because all of those have <2wks
expiry we end up warning as gc --auto is run.

But I actually think the git-svn import is revealing an entirely
different problem.

I.e. when I clone I seem to be getting a refs/remotes/git-svn branch
that's kept up-to-date, and when I "gc" everything's consolidated into a
pack, we don't have any loose objects that are meant for expiry.

But the reason git-svn is whining is because we're doing this in gc
(simplified for the sake af discussion):

    if (too_many_loose()) {
        expire();
        repack();
        if (too_many_loose())
            die("oh noes too many loose that don't match our expiry policy!");
    }

But they don't fall under our expiry policy at all, we're just assuming
that a crapload of loose objects haven't been added in the interim from
when we ran expire() + repack() until when we check too_many_loose()
again.

That's a logic error which we could just solve at some expense by seeing
*which* objects are loose and candidates for expiry at the beginning,
and not warning if at the end we have *different* loose objects that
should be consolidated, that just means we genuinely should run gc
again.

Or is this just wrong? I don't really know. If the above is true I'm
missing how tweaking gc.pruneExpire=5.minutes.ago is helping. Surely
we'd either just end up with the same set of loose objects (since the
clone is still running), or alternatively if git-svn hadn't gotten
around to updating refs create a corrupt repo.




>> m
>> On Tue, Oct 9, 2018 at 10:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Forwarding to Jonathan, as I think this is an interesting supporting
>>> vote for the topic that we were stuck on.
>>>
>>> Eric Wong <e@80x24.org> writes:
>>>
>>> > Martin Langhoff <martin.langhoff@gmail.com> wrote:
>>> >> Hi folks,
>>> >>
>>> >> Long time no see! Importing a 3GB (~25K revs, tons of files) SVN repo
>>> >> I hit the gc error:
>>> >>
>>> >> warning: There are too many unreachable loose objects; run 'git prune'
>>> >> to remove them.
>>> >> gc --auto: command returned error: 255
>>> >
>>> > GC can be annoying when that happens... For git-svn, perhaps
>>> > this can be appropriate to at least allow the import to continue:
>>> >
>>> > diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
>>> > index 76b2965905..9b0caa3d47 100644
>>> > --- a/perl/Git/SVN.pm
>>> > +++ b/perl/Git/SVN.pm
>>> > @@ -999,7 +999,7 @@ sub restore_commit_header_env {
>>> >  }
>>> >
>>> >  sub gc {
>>> > -     command_noisy('gc', '--auto');
>>> > +     eval { command_noisy('gc', '--auto') };
>>> >  };
>>> >
>>> >  sub do_git_commit {
>>> >
>>> >
>>> > But yeah, somebody else who works on git regularly could
>>> > probably stop repack from writing thousands of loose
>>> > objects (and instead write a self-contained pack with
>>> > those objects, instead).  I haven't followed git closely
>>> > lately, myself.
