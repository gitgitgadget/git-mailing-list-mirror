Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5BF1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 00:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfJBAGa (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 20:06:30 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:43786 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfJBAGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 20:06:30 -0400
Received: by mail-io1-f45.google.com with SMTP id v2so52651524iob.10
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 17:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WUSoHI2F5/eVP8Cic3Cageljt6HhVyYJZQPcqM6PsY=;
        b=pmA2DZjFNwJ3Hcyq0CvHukvN3l2RA7hlMJeggr87BZ32Vq/1+9rUaDJhiVp+bcqvRB
         OFQXbiGX+2TFb9aB/Qn12euct2kNqXHhSHHbS6XGrh4VFV8l+bqd5hR11je1Qwro50A7
         Q1uL+IVu4OGJe0M/3llglUcq+RpzXvktxALOve1eYtWEWRdhqDn52edTys1cjO2HRJOR
         yehartiiQ1krYu6mNUjbVQEbf0GbyHwci4J/j2Yc1QARCUgdKKBMPz9sCkYDo54LLx2F
         WXhqOywpS8XZ3S2ZFPk2b5v+gLnqE8TneXZh0f6Ay9r/jEFHkyldwHK2Nz1W9gSLjR8L
         FNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WUSoHI2F5/eVP8Cic3Cageljt6HhVyYJZQPcqM6PsY=;
        b=cOz1Qvosok2ovzmq2Y5SXzqmR+GpDtBEyWTEuJJBMHs/YlTLE3eaF84lg0hqqmJ6oE
         ZPjCT0sgz6XFy4WkowOdDn8NUkr0epKwL7onC/CbNf8/A+u2GitfE5AWGYTZytcSmV1k
         4ZBXvw1+H3L0OQIIDuOATEyxfeQjhjtYJPNEPH1e0dNamagGuoBQtFCE1RSVN2xQ3j86
         CfWyD0NpK+Yn4Axo4p8JG8o7HNAWeEvoJq39X2LFPeecBbGpoDBA/DzbvjW6lf5sBt4J
         TGBHm3r7Lkvxd8B6AHUIU2X2pzvNlqi90IxeE9B0ashXcT0b3kOLjMitCErrwpAhxylu
         eenQ==
X-Gm-Message-State: APjAAAW9AZf519F4k/W6Yiv4qBvaTOEBgnUYLJY1KxPsXd8+Y+gCNROW
        Lnxyuu6n1q6Qvu878MQ21e8zrr4gfs9qBPnh0o0+Cw==
X-Google-Smtp-Source: APXvYqzr5T8ayqCqob+gu/gL1sNvJw/ZwZTBFPGy8yj90KRTmet31s+fSPAvUpwxUuWvk0wdQlQn0ln63kyo9Y5AFIs=
X-Received: by 2002:a5d:9814:: with SMTP id a20mr920621iol.19.1569974786931;
 Tue, 01 Oct 2019 17:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7e5qCuxZLBeVDq+Th3E+E4+P8=WzJfK8WcG2yz=n_nag@mail.gmail.com>
 <f3101c8f-9709-5bcb-35f0-39ffaf8aa809@gmail.com>
In-Reply-To: <f3101c8f-9709-5bcb-35f0-39ffaf8aa809@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 1 Oct 2019 21:06:15 -0300
Message-ID: <CAHd-oW6XUFO2mG_5kiqsTYuh998j95Sg_6zBBE4sXTtCJ3dPDA@mail.gmail.com>
Subject: Re: git-grep in sparse checkout
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 1, 2019 at 3:29 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/1/2019 9:06 AM, Matheus Tavares Bernardino wrote:
> > Hi,
> >
> > During Git Summit it was mentioned that git-grep searches outside
> > sparsity pattern which is not aligned with user expectation. I took a
> > quick look at it and it seems the reason is
> > builtin/grep.c:grep_cache() (which also greps worktree) will grep the
> > object store when a given index entry has the CE_SKIP_WORKTREE bit
> > turned on.
> >
> > From what I understand, this bit is used exactly for sparse checkouts
> > (as described in Documentation/technical/index-format.txt[1]). But
> > should we perhaps ignore it in git-grep to have the expected behavior?
> > I'll be happy to send the patch if so, but I wanted to check with you
> > first.
>
> Is that the expected behavior? In a sparse-checkout, wouldn't you _want_
> Git to report things outside the cone? You can already use external tools
> to search for things in the sparse cone: they are on disk. You need "git
> grep" for the objects reachable from the current tree but not already
> on disk.

Hmm, we can use external tools to search in the sparse cone, but even
in this circumstance, I think we need git-grep for some usecases.
git-grep on disk can exclude files not being tracked and access other
git functionalities such as --textconv to read .gitattributes and
convert the files before grepping. So maybe people would want to grep
just the cone but also have these other options that would be
unavailable through external tools?

(Users could already simulate such behavior giving the sparse clone
patterns as pathspecs to git-grep, but that can get complicated for
more complex sparse patterns.)

> I respect the goal to minimize the work "git grep" is doing, especially
> in a sparse-checkout + partial-clone world, where we wouldn't expect to
> have the blobs locally and this search would cause many blob downloads.
> I just want to truly examine if this is the right behavior.
>
> At minimum, I would expect a new option to have "git grep" go back to
> the old behavior, so users who really want a tree-wide search can have
> one.

Yes, I totally agree that this behavior change should come with such
an option. Maybe --ignore-sparsity-patterns, as Elijah suggested.

> Thanks,
> -Stolee
