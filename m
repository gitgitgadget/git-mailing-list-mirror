Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EEFC433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 17:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbiBIRv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiBIRv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 12:51:57 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5CC0613C9
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 09:51:59 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m4so9536942ejb.9
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 09:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4b/p0U1qpgf93STCwAGs854xsSIoPqhdRghg5pEmKM=;
        b=kEC1C3Q9GwfnqPsXMLvKLDogGG/q2w8fOSHTsmqq9RHWPpEGr6oC7igMEnTtYtJD3s
         S2DAy7r74I4zOJ3te/VvrDLNNqKCESGaYoTb3LqplRdKP1mlGgNMizQh8x2RxZo6DOih
         ibhbvYItc68HfRZmAjxe9wdIx3eRbc41AwccdF4SbxAotXZ8qOMR6E2DC7ienPtt4zvd
         1kvd8DYbr2xsBoWXX0H2UXUKY6jOHAdBKZYtnTLo3bumWcssV+UCSw0rucIR2pbvYy6/
         3NEwD7ZIesJEycQrABwqnYx+LWEIA8ETvHvvMkSHaBmRaC3gM+9XMu6VQc1FDkZImVx3
         VOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4b/p0U1qpgf93STCwAGs854xsSIoPqhdRghg5pEmKM=;
        b=gowEhKqhLHjfms9sv1bztjFmUM+loOlVvQ9kYJ4rMVM/QHrQfr2IDlPQNvYYSEH+0N
         UvuYLxaUAMlmKpyQpVrWbSa6b0K2CNoA39Sjn1GH58hFx7GyGnf1gsN8HDKhFEnbDonP
         aTUbIsEM3yf3nQD41a7rSCfedO1ZdXZx6UpcQul/SuKIDVYroj4seMxDlwgh7EUzWWd8
         VsE+jt+5441alBOatGaYcXr90Xlf+c0UwjSV8HHru9W4mr0Du7VIRjPwILEdAXqXqAWb
         tSwqe4wTU3J0uSDTPwwZCaox9kAV8ICaegu4RMFV31dpwB5ZB6ne7lBsn6wnz4n6lLXB
         Wv1A==
X-Gm-Message-State: AOAM5302F8AT8FlTQaYsyrQCqt+1RcMxjBJTjhcnFHBKZELFG0YC07/j
        Y4oJRUueF7PpKUZjRSQhiT3dV5yYod/rkfW1a88=
X-Google-Smtp-Source: ABdhPJxa/eV64qr6xjCaiguMCIy5SNXGdAR7O1mQbn35xEY65XTo4cyTpQdrRc9zAet7DG04wkybrMhG+y3cjk+gkeA=
X-Received: by 2002:a17:907:2ce4:: with SMTP id hz4mr2987235ejc.613.1644429117965;
 Wed, 09 Feb 2022 09:51:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com> <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
 <xmqqo83hatm1.fsf@gitster.g> <11bf1541-c46a-fcf5-f8d4-0d144b942d59@gmail.com> <xmqqmtj09cuz.fsf@gitster.g>
In-Reply-To: <xmqqmtj09cuz.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Feb 2022 09:51:46 -0800
Message-ID: <CABPp-BHKr3xPStXE6HXUBB0KR=6Y1-CSjDc1DTDdd63uYvK7uQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig details
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 9, 2022 at 9:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> >> +[[def_work_tree]]worktree::
> >> +    A repository can have zero (i.e. bare repository) or one or
> >> +    more worktrees attached to it. One "worktree" consists of a
> >> +    "working tree" and repository metadata, most of which are
> >> +    shared among other worktrees of a single repository, and
> >> +    some of which are maintained separately per worktree
> >> +    (e.g. the index, HEAD, per-worktree refs and per-worktree
> >> +    configuration file)
> >
> > I like this addition, except that I don't understand the "per-worktree
> > refs" (other than HEAD). Are there other thins used by features such
> > as merge and rebase that would appear as worktree-specific? Of course,
> > some state for these operations is stored per-worktree, I just didn't
> > know if any were actually "refs".
>
> "per-worktree ref" is an entry in the glossary.
>
>     [[def_per_worktree_ref]]per-worktree ref::
>             Refs that are per-<<def_working_tree,worktree>>, rather than
>             global.  This is presently only <<def_HEAD,HEAD>> and any refs
>             that start with `refs/bisect/`, but might later include other
>             unusual refs.
>
> And those other things are also listed as "pseudoref".
>
>     [[def_pseudoref]]pseudoref::
>             Pseudorefs are a class of files under `$GIT_DIR` which behave
>             like refs for the purposes of rev-parse, but which are treated
>             specially by git...
>
> I think the motivation of special casing refs/bisect/ is to allow
> use of a separate worktree for bisecting without affecting other
> development or another bisection.  The HEAD is singled out in the
> description, but MERGE_HEAD and others (pseudoref) that are declared
> here to be files under '$GIT_DIR', when we migrate fully to other
> backend that may not want to have files under '$GIT_DIR' to
> represent them, ought to become per-worktree, for the same reason as
> HEAD should be per-worktree, i.e. it allows worktrees to be
> independent from each other and have their checkout at different
> commits, growing history of different branches in parallel.

You had me worried for a second; things would be really broken if
these pseudorefs weren't per-worktree.

But testing just now, I think the pseudorefs are already per-worktree.
I just did a merge in a secondary worktree, and then observed from the
primary worktree that a .git/worktrees/<id>/MERGE_HEAD was created,
not a .git/MERGE_HEAD.  (Maybe the glossary could just spell out that
these are under $GIT_DIR and _not_ $GIT_COMMON_DIR to avoid potential
confusion?)
