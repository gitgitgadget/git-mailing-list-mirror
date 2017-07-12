Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE8F20357
	for <e@80x24.org>; Wed, 12 Jul 2017 17:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdGLRlB (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 13:41:01 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35296 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdGLRlA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 13:41:00 -0400
Received: by mail-pf0-f170.google.com with SMTP id c73so16339047pfk.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lZX+Ftea9Ommd83WNhbkceUP7Nbx7U0PKRt30pnBd0k=;
        b=YBKm9QJ0LKLbAE8IneuOhSzY3aHPFizl3QgO2Y4dWthEasn4nbAnRwFwA2C2PdmVlF
         K50IevfuRY4ZM2S6LYs7WOCSSfbQjeD2xXKEWNHWHXk+wkJiPgeg+gJaLr5C1OisZzwd
         2UD4qdz0WO1MMkgSpD2JDtuNK7stGfhQDQ99Pr9FLmFMB8LdNHmAy53IhLzlZddaSrH1
         pnH9oPkU4t91Z+7C7TR0aR3zjrG4xg9cBmZvu43M2vWaNCwB/Rmi9nyTWViF0BtrGE6E
         5Lyu+J5pdse1CRvFZU2sOYZqH8z2w9rZa0birBVTQdq305CyW+ZsdbELOlxsDxlk3qHU
         0oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lZX+Ftea9Ommd83WNhbkceUP7Nbx7U0PKRt30pnBd0k=;
        b=UNM7Pu0T0Gj3IHaH2ml8LlWp4lXhEvx3N3NRxrZylcSG7b8rAegoIRlkhGBZN8vzUG
         Ic5rjeTECgRPbLHNmqYV0dSQzygoXJzJnc7Ghl8WW1bu0c2MVaOooNP+Ptlk59qK6EQC
         lptVhgZzUpZQQvQUhzZKgQRUI8vz7WSSAB/RVrpY+VYkdgpXq7WYD8/YqHsEh/mO1IDs
         G0ImI5BsECZ4BMtSrJ8xQtlZ2YtqimiqUPnhT6WBNzAWNmaA2q7aHbArHjXjAdrsjEy6
         weBltt8vZj86sb3hyCN/dsjagkYKuGypBKJ94TcJZ9ut8gm0/4nRh274j+ZcXELQbwkv
         ZRoA==
X-Gm-Message-State: AIVw110IvlhLwA8EVbwk5cRtL70Ht+rVcG6nRMSk2Z7TDKImSI1kc92n
        A/EdHwa95qAqd006HmLJuBg7Nz6rc/1jG87fYw==
X-Received: by 10.98.112.137 with SMTP id l131mr56515909pfc.194.1499881259097;
 Wed, 12 Jul 2017 10:40:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Wed, 12 Jul 2017 10:40:58 -0700 (PDT)
In-Reply-To: <81052ff7-cece-400d-1742-e13693fae7e3@durchholz.org>
References: <81052ff7-cece-400d-1742-e13693fae7e3@durchholz.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Jul 2017 10:40:58 -0700
Message-ID: <CAGZ79ka59qkekqGCSmVHb0=H--4HtjC7Ts9eXj_hb6f2cRQ4ww@mail.gmail.com>
Subject: Re: Mirroring for offline use - best practices?
To:     Joachim Durchholz <jo@durchholz.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 3:47 AM, Joachim Durchholz <jo@durchholz.org> wrote:
> Hi all,
>
> I'm pretty sure this is a FAQ, but articles I found on the Internet were
> either mere "recipes" (i.e. tell you how, but don't explain why), or bogged
> down in so many details that I was never sure how to proceed from there.
>
>
> Basic situation:
>
> There's a master repository (Github or corporate or whatever), and I want to
> set up a local mirror so that I can create clones without having to access
> the original upstream.

'git clone --mirror' should accomplish the mirroring part.

> I'd like to set the mirror up so that creating a clone from it will
> automatically set up things to "just work": I.e. branches will track the
> mirror, not upstream, possibly other settings that I'm not aware of.

And then 'git clone <local-path-to-mirror>'. This would setup the local
mirror as upstream, such that git-fetch would fetch from the
local mirror. However git-push would also go to the mirror. I am not
sure if this is desired or if you rather desire a triangular workflow, i.e.
the local clone would directly push back to the real upstream.
That can be configured with url.<base>.pushInsteadOf, but there
is no way to have that setup by default when cloning from the local
mirror as the config is not copied over.

>
> I gather that local clones are fast because hardlinked - is that correct?

Yes, a local path implies --local in git-clone, which (a) uses hardlinks
and (b) avoids some other protocol overhead.

> Is that correct on Windows? (I can't easily avoid Windows.)

Let's see if a Windows expert shows up, I cannot tell.

> Ramification 1:
>
> I'm not sure how best to prepare patches for push-to-upstream.
> Is there value in collecting them locally into a push-to-upstream repo, or
> is it better to just push from each local clone individually?

It depends on a lot of things:
* How critical is the latency in the desired workflow?

  Say you have this setup on a cruise ship and only push once when
  you are in a harbor, then (a) you want to make sure you pushed everything
  and (b) you care less about latency. Hence you would prefer to collect
  everything in one repo so nothing gets lost.

  Say you are in a fast paced environment, where you want instant feedback
  on your patches as they are mostly exploratory designs. Then you want to
  push directly from the local clone individually to minimize latency, I would
  imagine.

* Does a local clone have any value for having the work from
  another local clone available? In that case you may want to
  have all your changes accumulated into the mirror.

> Ramification 2:
>
> Some of the repos I work with use submodules. Sometimes they use submodules
> that I'm not aware of. Or a submodule was used historically, and git bisect
> breaks/misbehaves because it can't get the submodule in offline mode.

Oh!

> Is there a way to get these, without writing a script that recurses through
> all versions of .gitmodules?

Not, that I am aware of. You need to find all submodules.

When a submodule gets deleted (git rm <submodule> && git commit),
then all entries for that submodule in the .gitmodules file are also removed.
That seems ok, but in an ideal world we may have a tombstone in there
(e.g. the submodule.NAME.path still set) that would help for tasks like finding
all submodules in the future.

> I'm seeing the --recurse-submodules option for git fetch, so this might (or
> might not) be the Right Thing.

That only works for currently initialized (active) submodules. The submodules
of the past and those which you do not have, are not fetched.

Without the submodule ramifications, I would have advised to have
have the local mirror a 'bare' repo.

Hope that helps,
Stefan
