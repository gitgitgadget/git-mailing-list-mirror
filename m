Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2355D20248
	for <e@80x24.org>; Thu,  4 Apr 2019 13:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfDDNr6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 09:47:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47101 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfDDNr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 09:47:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id r25so1809200lfn.13
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=c0N+FtjHMVkVjbN/1cZxkGsam+i3TCutTXB0mwTj1Po=;
        b=FnKydX+ICk4Q3NALY8k9w5+1zZuGjYVWqNnonYF1PuWSlS+wKhA6DQV5VorlZiJgrN
         TRyDXTgHix8yjA92YXj4VvtMmChLGEXqG8/6jA+aTnjd4nbkW3KycNHi0bO5NLlQinds
         SvpEOiCwn9gFLFT/d5/nA9p3NtSfDnki+87BFWqNHhiR2zadPcuFvP3JJyR7oQuHAWKb
         FxM2FlfG7yqBJcwkCqZ3uJUDOH5x8zsgMqkcnYQ4moPQuno9cy/wH54Y5LjYnqh7L+J/
         USStBB0sQFTCbwp5SrAhJ3VMV9C9Z4oSJ8fS/0zTqZgGgsr7d/2j5M/PcQCaMP7zJVWE
         rLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=c0N+FtjHMVkVjbN/1cZxkGsam+i3TCutTXB0mwTj1Po=;
        b=ZIwQHMU/V8b6OZCzGu+imaGgl5h8mf28RNldGZE4Htn3CMHM2YPy521QgWIVBFK9ld
         Fkb96xtfBIXCmvXbA1/4+FaBpV6H1BvwwfFuxXS2HFJlx8hGsIqddrxMnof9mWAEOsbv
         f/jareRg9ujCc6hCWcFr/s2nBG+ftijiPqmg/722qxmo89H+SxMn0ILy7VMUuSVEwVC2
         axI1pex5jUkTzGuAbaJm/fuwsJUs/9dWjsBM1lEcJzD9PR9PRGEIynn3D3N3EhZ6dxVg
         P73fNP5lEZoK0LeLMHv3xCSA4McyAXNK74mv3Amm3IyqMh0FwFAHrg4jmwiQ2NeopLHF
         gzPA==
X-Gm-Message-State: APjAAAVi6k0/W3nKGEb5UpUv4vRoy4H+Hk9/wiDfaTrV9qRBGDpK94VG
        EBJWaFIU6HoJAIbfuGuUqLz31CoXS1s5VR2V//+tT+Kf
X-Google-Smtp-Source: APXvYqw+pb7C1SlKh/iLe7j9R+ZEv0z+OUaVtQHEwAoE+buSpY5aQxlDp158a2UOJ/Z3GiJAZoVtx13TXMYxyDvvm0A=
X-Received: by 2002:ac2:5581:: with SMTP id v1mr3248178lfg.92.1554385675651;
 Thu, 04 Apr 2019 06:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
 <20190402230345.GA5004@dev-l> <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
 <xmqq7ecbscay.fsf@gitster-ct.c.googlers.com> <CAHd499C9g3yPvs=wuaSuLrW=R09yjT5DcKHfpH9=PYYkAcpuhg@mail.gmail.com>
 <xmqqbm1mf74c.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm1mf74c.fsf@gitster-ct.c.googlers.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 4 Apr 2019 08:47:43 -0500
X-Google-Sender-Auth: k_qkymLqPu-wdDwuEOeyXv6ji1g
Message-ID: <CAHd499Dr5sjzFCFYvkwcS0WOo0W51_RyL7nLAg_MaGeFy5eQKQ@mail.gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 4, 2019 at 4:32 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
> >> > more clear in the doc and/or in the proposed log message what
> >> > practical downside there are to the end users if we do not stop this
> >> > "mistake", that is.
> >>
> >> Having said all that, I can sort-of see that it may make sense to
> >> forbid tagging anything but a commit-ish, either by default, or a
> >> "git tag --forbid-no-committish" that can be turned on with a
> >> configuration.
> >
> > I don't really understand what part of the change is a negative for
> > you. Are you saying that `git tag` should peel the tags for you? Or
> > are you saying you don't like nested tagging to be opt-in and an error
> > otherwise?
>
> No, no and no.  I am saying "git tag -a -m 'message' tag anothertag"
> that creates a tag that points at another tag is perfectly fine.

It might be fine within the realm of git itself, because git knows how
to deal with them by peeling, as you say, but there are 3 reasons I
dislike that this is allowed:

1. The intent by the user was to create a tag pointing to the commit
that another tag points to. So the peeling was expected to occur when
the tag was *created*, not when it is used. Again, the use case is
that I create a new annotated tag, then realize later I pointed it to
the wrong commit. So sometimes I correct it by pointing it at another
tag, but my intent was for both tags to point at the same commit, not
for one tag to point to a commit and the other to point to the tag.

2. When users on my team do a `git show tag`, they see 2 descriptions
and 2 tags. This creates a LOT of confusion. I wasted hours trying to
find out what this meant. It was very obscure and indirect. Most users
do not have your expert level of understanding of the internals of
Git. So I think there's a disconnect between how you like how the
machinery works internally with tags, and what users expect from the
porcelain interface. I think we should go with what's pragmatic (tags
that point to commits, not other tags) and design the interfaces for
the majority use case. Tags pointing to tags is a minority use case,
or an edge case. Given that, I think it should be opt-in.

3. Even if Git internally handles peeling tags, external 3rd party
tooling may not. As I mentioned in another thread, `git lfs migrate`
was not programmed to peel tags. I reported the issue here:

https://github.com/git-lfs/git-lfs/issues/3568

The author there admitted that migrating the repository *and* keeping
the tags pointing to tags would be difficult. So I think the solution
they're going to end up going with is that when you migrate a
repository for LFS support, they will permanently peel your annotated
tags. Which I personally think is the correct solution.

So in summary, I think it's better for tags to be peeled when they're
created, or at least make the user aware of the fact that they're
creating something that they might not be expecting. Just because Git
handles peeled tags transparently doesn't mean that's what the user
wants, or what the user expects. I've been using git for years and I
never knew tags pointing to other tags could exist. It sounds like a
technicality that most users shouldn't care about.

That's my feedback as a user, take it or leave it. I'm not really
concerned with what's right or wrong from a git-internals perspective,
what I want is a tool that makes sense for my day to day job, and I
think this PR aligns with that.
