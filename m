Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286381F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 14:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbeKVAkE (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 19:40:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43291 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbeKVAkE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 19:40:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so4879167qkr.10
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 06:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7oOI+bJ5IwVb0sDo49NKlO4XjcBu6s1FA9QqFrSzxq8=;
        b=keEnX84cCAjmNR/qbGdCnRbEyeP2FORuBjwSOtwohdzUpe6XH1TYw7hJanKjTNcNDR
         AQLPmvUbhpdAS3hMby1G6D6iOgqGH3nLbsZ9xS8zxC3U0qKzaFVFgLnET9qLiRejdAKZ
         RSw2kl6HU0CGcSEfrIE5eZ+vfaW0vcF5E347miLAT2WOZPlgnWlyk7gZnRmzl8CEu+Z7
         HWN96rD1kP3rNdCkyA4vhwopuonEknmi/FE9hX19kBK633VmAAxDxweuJNk0GD3hrMqK
         OTy1Lf0H3Nmw5uFCMEC7khZExHORZNzkfdYD2yMvEtjPh1/d+MlymWEoUWZNEEWh/tUr
         Fvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oOI+bJ5IwVb0sDo49NKlO4XjcBu6s1FA9QqFrSzxq8=;
        b=JvTLNpqNXzI8ntZ1j3GXGOT8wyVPFRcausIfsVOIQ775xLjM2d4+RcXjGIn5bvbkDq
         fsaBK7JT1WhWcPY5uksEi1KX8fD5XT9nYhUQNX20AsHuNzXi8nsXBs81Epe9JA8NNC+g
         wgttUXMv12gn28gku5WOR40WoqYKG2UJVZ198+c98DFixy4dmpTSVbIbpokX4DniX+FE
         /6YBJ7UWp1H9YAH1ryLds6Enz/q/J8gq8NwicGQ0DceWVzrn4OwqckbrIJsHaMGnCPmU
         fUXCPRN6RfBKssUXYxSrBUZoYEd2KUtQMRmPFiFOHHrvwze18fE7Ye66K/J6O9r2o8ty
         g8Bg==
X-Gm-Message-State: AA+aEWa/goLgf00YF6P9wCM/wfrwGgE14TZmJ779V50RcUmDOAMWTkzR
        qkEDZBh/j1S4lwSIhiIb9CSY0oPAHw9ECOjp+Y8=
X-Google-Smtp-Source: AFSGD/XaBDDGurd87d2ai/zILtQ2ihFO5h2XmUrfYCsSUsDX8A98r5OtnvvPAe+T9fODUpC5Mk9hn5EnRv/0eIJJ+N8=
X-Received: by 2002:a37:6e43:: with SMTP id j64mr5321578qkc.278.1542809130659;
 Wed, 21 Nov 2018 06:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20180927204049.GA2628@rigel> <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181111235831.44824-2-nbelakovski@gmail.com> <xmqqsh061u7o.fsf@gitster-ct.c.googlers.com>
 <20181112122245.GB3956@sigill.intra.peff.net> <xmqqd0r9zri6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0r9zri6.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Wed, 21 Nov 2018 15:05:04 +0100
Message-ID: <CAC05387v6odwx3JTfJUR8tCxyqEEf7Z13ROgrLthc4rVLy3bJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ref-filter: add worktree atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think if we move to making this atom just store worktree path, that
needs to be implemented as a hashmap of refname->wtpath, which would
also solve this string_list issue, correct? Just making sure I'm not
missing something before I submit another patch.
On Tue, Nov 13, 2018 at 2:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >> I wonder if "The worktree at /local/src/wt1 has this branch checked
> >> out" is something the user of %(worktree) atom, or a variant thereof
> >> e.g. "%(worktree:detailed)", may want to learn, but because that
> >> information is lost when this function returns, such an enhancement
> >> cannot be done without fixing this funciton.
> >
> > Hmm. I think for the purposes of this series we could jump straight to
> > converting %(worktree) to mean "the path of the worktree for which this
> > branch is HEAD, or the empty string otherwise".
> >
> > Then the caller from git-branch (or anybody wanting to emulate it) could
> > still do:
> >
> >   %(if)%(worktree)%(then)+ %(refname)%(end)
> >
> > As a bonus, the decision to use "+" becomes a lot easier. It is no
> > longer a part of the format language that we must promise forever, but
> > simply a porcelain decision by git-branch.
>
> Yeah, thanks for following through the thought process to the
> logical conclusion.  If a branch is multply checked out, which is a
> condition "git worktree" and "git checkout" ought to prevent from
> happening, we could leave the result unspecified but a non-empty
> string, or something like that.
>
> > file-global data-structure storing the worktree info once (in an ideal
> > world, it would be part of a "struct ref_format" that uses no global
> > variables, but that is not how the code is structured today).
>
> Yes, I agree that would be the ideal longer-term direction to move
> this code in.
>
> >> > +          } else if (!strcmp(name, "worktree")) {
> >> > +                  if (string_list_has_string(&atom->u.worktree_heads, ref->refname))
> >>
> >> I thought we were moving towards killing the use of string_list as a
> >> look-up table, as we do not want to see thoughtless copy&paste such
> >> a code from parts of the code that are not performance critical to a
> >> part.  Not very satisfying.
> >>
> >>      I think we can let this pass, and later add a wrapper around
> >>      hashmap that is meant to only be used to replace string-list
> >>      used for this exact purpose, i.e. key is a string, and there
> >>      is no need to iterate over the existing elements in any
> >>      sorted order.  Optionally, we can limit the look up to only
> >>      checking for existence, if it makes the code for the wrapper
> >>      simpler.
> >
> > This came up over in another thread yesterday, too. So yeah, perhaps we
> > should move on that (I am OK punting on it for this series and
> > converting it later, though).
>
> FWIW, I am OK punting and leaving, too.
