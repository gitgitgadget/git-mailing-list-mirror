Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFB7211B5
	for <e@80x24.org>; Thu, 31 Jan 2019 20:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfAaUxv (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 15:53:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41897 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaUxv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 15:53:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so5067552qtf.8
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 12:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/9kQRdKWCOzFDII5R9vmgEdQetvDu2Vo5MtqdsjGB4=;
        b=D11mho/GYnuaOcnddrXl2PEx7lvkBbo8b/C9KtxzMuzqV3Wu41FwTegmsvF7U5ERuT
         WlXS/w5UsgeZUV0g4j9tM6vEUue/xI4oaK8Bf8gJTsll780cUyravAbTwARbve1x+W3l
         ka8pN2TWaVO+ygsyj6iICyrOenfXGtiG6++sb5JFYhd4rw+epTKr/989nrJYWlaUf86e
         fq51joxENO7EDFZuPjDITWwczWLygM0EUIcySJfBDMb41WYzNcGfELcXeCnG7rAXBs/W
         1rTJ1jGlZfy2DEDd/ZN5X7Ic8yLd7khHeRhzfJdVddAW/nRvTFn5OoYP8TSLZ01Za6H0
         wIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/9kQRdKWCOzFDII5R9vmgEdQetvDu2Vo5MtqdsjGB4=;
        b=DomBUrxVywxDovpLTmmguL0XFygSSeYNGFivDwehmUGer9PXiNDmGxfR9fLsTN2wOe
         J1rY4Zt7wQmY4Tc5w8/5NjC3i8/MZlzOuaRQ41fd2LMo6QwpsHP+PX/vqZJfxeaB43UG
         F69jupx8PvsS+FK8YHjchNxyz2bAhFstVPzwqpq88o/F9eesebB5jyiRSTAb2otUW84Y
         d1mNCnkwJyKFcc44DNHbzbQLpUtTVc3e81+6ljRPu3COP43+f/aYqFddwwelHIQFw3Y+
         eyZi4CrmJ84GMb4fWfv+wi5+X11XpEezCpnucH4NaEfDX/UELygdHirFQw0CQVrJwJJW
         5cCQ==
X-Gm-Message-State: AJcUukeiII7+OllN7vH7m3quem1nDqi+n+OtboTHb8emg3PhLO4nTPIq
        9jHiibDsl2MzNhxa4oZRLD4CJ1F5wEMpAeKr+vE=
X-Google-Smtp-Source: ALg8bN4QUPB2zkERWUXeX/mRRwBDSq7M4kNNmQ1kPNroX7d7ngnjkGhisa6N6El2DS4O3ShQitP4K6zbmP+dPTKauu0=
X-Received: by 2002:ac8:41c8:: with SMTP id o8mr36013446qtm.232.1548968030459;
 Thu, 31 Jan 2019 12:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20190122232301.95971-1-nbelakovski@gmail.com> <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190122232301.95971-2-nbelakovski@gmail.com> <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
 <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
 <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com> <20190124183235.GA16580@sigill.intra.peff.net>
 <xmqqd0olj1kj.fsf@gitster-ct.c.googlers.com> <20190124212608.GD16114@sigill.intra.peff.net>
In-Reply-To: <20190124212608.GD16114@sigill.intra.peff.net>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Thu, 31 Jan 2019 12:53:24 -0800
Message-ID: <CAC05385KQPXodr-LymXVK97fBAp5==M=OBr1mRYueGbG1qcepA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So where does that leave us for this series? We could move hashmap
back into used_atom, but if a user entered
--format="%(worktreepath)%(worktreepath:)" we'd end up freeing
worktrees twice. Not that that should stop us - that scenario is one
where user input isn't sensible and personally I don't think it's
necessary to protect against such things (unless the user was
reasonably confused, but I don't see that as the case here).

I agree with Jeff that a ref-filter "context" would help. And in more
ways than one, it could help us decide ahead of time whether to check
if a ref is a branch or a tag before doing a hashmap lookup or just
skip the check (i.e. if there are no tags within the context, the
check would only add cost). But I do believe that that would be
outside the scope of this series.

I think leaving it as globals is a tiny bit safer and also makes it
easier to pack it into a context if/when we decide to do that work,
but as always I'm open to other interpretations.


On Thu, Jan 24, 2019 at 1:26 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jan 24, 2019 at 11:30:20AM -0800, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > What if you have other atoms that need worktrees? E.g., does
> > > %(worktreepath:foo) use the same used_atom slot? What if we have another
> > > worktree-related atom?
> > > ...
> > > And that one is a good example where we _do_ need the global, because we
> > > already have multiple atoms pulling from it.
> >
> > I guess that we broke the original atom design by mistake when we
> > added ":<modifiers>" support.  There should have been one layer of
> > indirection that binds the instances of the same atom with different
> > modifiers together---I agree with you that we cannot avoid globals
> > without fixing that mistake first.
>
> Yes, that's one way to fix it.
>
> I actually think the biggest mistake is having that used_atoms list in
> the first place, as we iterate over it several times asking "can we fill
> this in yet?". The way pretty.c does it is just to incrementally parse
> the commit, saving intermediate results. And in cat-file.c, we figure
> out what we need ahead of time in a single pass, and then just fill it
> in for each object (which sort of works out the same, but doesn't
> require that the parsing needed for item X is a strict superset of item
> Y).
>
> So I'd much rather see us parse the format into a real tree of nodes,
> and figure out (once) which properties of each object are required to
> fulfill that. Then for each object, we grab those properties, and then
> walk the tree to generate the output string.
>
> -Peff
