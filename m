Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4098C1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 17:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeIZAFP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 20:05:15 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34476 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIZAFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 20:05:15 -0400
Received: by mail-yw1-f68.google.com with SMTP id m129-v6so3898618ywc.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oL7DTdNbIg9LlYT8O8TG9JwFSNqtiJ8DbebqbDjgiFc=;
        b=aCCG6i5PDF05ZV0hKSKsnmvsHMa4JJHoELkPjqKRnwvtuLxQuPn5wyZFWLyrVhb+Aa
         VHCy6oNvOvEf16Iy7Uk1EQ3nQYZPUD9hkfcMFEvXWirQpUGddccphwBKf1xfVxTymECf
         juKjFNOXj6j0dnABivIVixcwfxC0xm6nOnuKCnnaFKdBetuij4zTtmDAf8MQb4FBDy3D
         cahXHfVOlUoDFx06jn3IdPkpXBdarAn7S1XHFIl+ykYdccb4tnD1coJH+wvC9S2ewLaM
         NMm5GG3OHNkVHvyhKwzKrwgzubuYP7+yYc2jHCBCpE1uVjqw6MBZEWzpHocqS1Bsdj51
         7G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oL7DTdNbIg9LlYT8O8TG9JwFSNqtiJ8DbebqbDjgiFc=;
        b=eW2UEu5CvKXoQ8XmGcAyo8y4Z5HdzRVSBKNV2LzFpKfESom1oNXXkTKaO3PYvHjciI
         jRkUFeufXB8/BcI21fqsQF34FNJYjCF2wkcodBp+zPy6ht67TbRICYO7Bj0KDz56qdpi
         X/283jZ+w31Wiwhyd1R4f9hY8Q/4j/X1OlL77GaHM8RZWi26T+qFP+EuHC+FAIOwkBbZ
         kDeWb2Pb5hJioHPkextc6kv50gwqgwdD2Z2SpM6LJEZ6hatoFPcnDGHBpEH2uiSspo8s
         mFQ9tAxtHVwjWz+StwYbnegbl8uHvhylg3mpL3SJLDUS7zcphseSiCBVwo8c+2EvlUWj
         6P3A==
X-Gm-Message-State: ABuFfoh+vDJApsRNl1anN4webgeGrDF6jCdpQ8T5XpWDFMRF8gnwb1va
        bkIKJcBluokPRAsQqj+Assu8ZXveav7uXNjpptnXjg==
X-Google-Smtp-Source: ACcGV60MsQtZj3Qu5LkMy0iDUtfQrrgZrrgIGjFodnWy+T9XrOVv1mCzDQu2/QdhAiP0OXPRnnfWXy9TdikY6OsZm6k=
X-Received: by 2002:a81:5855:: with SMTP id m82-v6mr1175188ywb.300.1537898195555;
 Tue, 25 Sep 2018 10:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-3-pclouds@gmail.com>
 <CAGZ79kZF1+0PTEgF_NwM_AwttJ0sedAP8CT834L5ZGJpxZ+G_Q@mail.gmail.com>
 <CACsJy8BKTkbc=ZgMnO7Yuk0eaqzZnifo80tnR872_T8b02biqg@mail.gmail.com>
 <CAGZ79kZw8-BiW5VE_YN5X2E07FeMA=XtHpjcUoSFtWNRu44fAQ@mail.gmail.com> <CACsJy8BRv1wb7urzriaj9AceZh-Ot1Tsb2w9rExRXkoHFn7_hw@mail.gmail.com>
In-Reply-To: <CACsJy8BRv1wb7urzriaj9AceZh-Ot1Tsb2w9rExRXkoHFn7_hw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Sep 2018 10:56:24 -0700
Message-ID: <CAGZ79kZqQVZJpiAkS0xy1rN9vLa-udaPDwWd03OC8TGiayOTcQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] Add a place for (not) sharing stuff between worktrees
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 9:55 AM Duy Nguyen <pclouds@gmail.com> wrote:

> > And with that said, I wonder if the "local" part should be feature agnostic,
> > or if we want to be "local" for worktrees, "local" for remotes, "local"
> > for submodules (i.e. our own refs vs submodule refs).
>
> You lost me here.

Yeah, me too after rereading. :P

I think the "local" part always implies that there is a part that is
not local and depending on the feature you call it remote or other
worktree.

When writing this comment I briefly wondered if we want to combine
the local aspects of the various features.
However the "local" part really depends on the feature
(e.g. a ref on a different worktree is still local from the here/remote
perspective or from the superproject/submodule perspective),
so I think I was misguided.

> > > think as long as the word "worktree" is in there, people would notice
> > > the difference.
> >
> > That makes sense. But is refs/worktree shared or local? It's not quite
> > obvious to me, as I could have refs/worktree/<worktree-name>/master
> > instead when it is shared, so I tend to favor refs/local-worktree/ a bit
> > more, but that is more typing. :/
>
> OK I think mixing the two patches will different purposes messes you
> (or me) up ;-)

possible.

>
> refs/worktrees/xxx (and refs/main/xxx) are about visibility from other
> worktrees. Or like Eric put it, they are simply aliases. These refs
> are not shared because if they are, you can already see them without
> new "ref mount points" like this.
>
> refs/worktree (previously refs/local) is also per-worktree but it's
> specifically because you can't have per-worktree inside "refs/" (the
> only exception so far is refs/bisect which is hard coded). You can
> have refs outside "refs/" (like HEAD or FETCH_HEAD) and they will not
> be shared, but they cannot be iterated while those inside refs/ can
> be. This is more about deciding what to share and I believe is really
> worktree-specific and only matters to _current_ worktree.
>
> Since refs/worktree is per-worktree, you can also view them from a
> different worktree via refs/worktrees/. E.g. if you have
> refs/worktree/foo then another worktree can see it via
> refs/worktrees/xxx/refs/worktree/foo (besides pseudo refs like
> refs/worktrees/xxx/HEAD)

Ah. now I seem to understand, thanks for explaining.
