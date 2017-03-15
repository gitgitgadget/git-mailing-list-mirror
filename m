Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D17620953
	for <e@80x24.org>; Wed, 15 Mar 2017 17:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753613AbdCORK2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 13:10:28 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34819 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdCORKX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 13:10:23 -0400
Received: by mail-pf0-f173.google.com with SMTP id x63so6159031pfx.2
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c6+39mkMGDUP1nw2eJEsOUpBXAryXCW4J6O7wl8454I=;
        b=NFcjyJzFO0BhlzBFieAAIvRgZwqXguRRv6HqmZUclNYexWKSbZe9g7ULF8GvxPan5U
         CL37oB7BeOJPSIQIx2GBhs2RHNZjkpQG46S2FKfAkHOTLLNiyvC+B140j7WrLXPDhUyx
         2iWLjfQkMfFT6IyAN5E40nOlnMfU/ku5p524YhwVe9NZK7KLHgPthF9dPfd3P83Vi11m
         Uv8ChmjirmAZHceaHmf42tJrJZ4DnRWZycXmK+8mGWzbfc/fvbmKqWvbBDQXQeIVmBue
         tacFyuSR4aXe5zUNcx+Xkjmzmz+zQViF5+eR1Bv0LqJwZZbRKneaXMOTNnVlEcNoGZVi
         gDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c6+39mkMGDUP1nw2eJEsOUpBXAryXCW4J6O7wl8454I=;
        b=L5dw069g5PshP+eDPtqJAqnzgLVG6tyLk6FEGcatSNNDL5pR6yr/IKBLRHtICUhQB9
         JKD5oII0qZmPJCTGBuDNsGZBP5TdFMz9zUQtRVBExxpadqBm70U9THqdqBJqFylFxfBd
         j28Ty4YJleaVvAkCLIajPfX4obvyOsh26MmBzRtmfdxwMxO91Q3COIz3JaxD6hlB3kRY
         cb8ep1Isgqdr5YKFeFRQZeM+EyzNAZkHwWQtvqoRgATLKw722uYKbz7n6MG2TDoNHKno
         cGb1k+eV5iwN/CJQgKoMKs5kaX3p93Av/mX3thf9s5ra719DD4R9CVJIoiDE6m7GcH2m
         bKPw==
X-Gm-Message-State: AFeK/H0T9oyhpoAX1X+G31My3r+imnuDKcixgOp2BDIqBF0S9ZApPuwHdh5fJIl1CrT4XLS0m23mf1WJipaPOHta
X-Received: by 10.99.98.6 with SMTP id w6mr4802567pgb.223.1489597822249; Wed,
 15 Mar 2017 10:10:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 15 Mar 2017 10:10:21 -0700 (PDT)
In-Reply-To: <CAHd499CfJnPtLmi8qzr=_jrfCgMw85MOUv-wPKmAHFUyDFXhRA@mail.gmail.com>
References: <CAHd499CfJnPtLmi8qzr=_jrfCgMw85MOUv-wPKmAHFUyDFXhRA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Mar 2017 10:10:21 -0700
Message-ID: <CAGZ79ka56DtHeAMVK7T-voXm3aRrGvUPNYW9MC1YR+kcGriWJw@mail.gmail.com>
Subject: Re: Finding a tag that introduced a submodule change
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 7:40 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I have a repository with a single submodule in it. Since the parent
> repository represents the code base for an actual product, I tag
> release versions in the parent repository. I do not put tags in the
> submodule since multiple other products may be using it there and I
> wanted to avoid ambiguous tags.
>
> Sometimes I run into a situation where I need to find out which
> release of the product a submodule change was introduced in. This is
> nontrivial, since there are no tags in the submodule itself. This is
> one thing I tried:
>
> 1. Do a `git log` in the submodule to find the SHA1 representing the
> change I want to check for
> 2. In the parent repository, do a git log with pickaxe to determine
> when the submodule itself changed to the value of that SHA1.
> 3. Based on the result of #2, do a `git tag --contains` to see the
> lowest-version tag that contains the SHA1, which will identify the
> first release that introduced that change
>
> However, I was not able to get past #2 because apparently there are
> cases where when we move the submodule "forward", we skip over
> commits, so the value of the submodule itself never was set to that
> SHA1.
>
> I'm at a loss here on how to easily do this. Can someone recommend a
> way to do this? Obviously the easier the better, as I have to somehow
> train my team how to do this on their own.
>
> Thanks in advance.

I cannot offer an easy way. However I can come up with a proposal
how to make this easy in the future. ;)

"git-{branch,tag} --contains" currently only takes a commit id as that is
easy to check for. (Just a revwalk from all commits, as we walk over the
commits in the graph)

We should extend the possible arguments to --contains, such that you can
do

    # check that a given path had this exact tree/blob id
    git tag --contains <path>:<tree/blob-id>
    # check if the given tree/blob was at any path
    git tag --contains <tree/blob id>
    # generalizing from above:
    git tag --contains [<pathspec>:]<blob/tree id>

With this designed API you could ask for

    git tag --contains submodule:<sha1 from step 2>

For the implementation of this feature the revwalk would also need
to walk the object graph (as restricted by the pathspec) and
see if there is the given object for each tag.

Thanks,
Stefan
