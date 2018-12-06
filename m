Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C9D211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 22:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLFWQC (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 17:16:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45562 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLFWQC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 17:16:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so2079881edb.12
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 14:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6JEfiNf5n2+MhaO0HVvlW1RsO1AOnBzQ0+wWwsFcMI=;
        b=vUJnv7WHIZvXGUBk4fop6Oy1FmDxRg5LBs34e2+tZjIWUIqv1N5yYr8m9tXmz+9VoV
         PV5fFWYITgj6Udz9YLVZhSPcic+UU/yUnQo8CKfEwnUQEyvBPQYi+aWp7CNz9QnLRznh
         1WtLHCT0OxOBz9B0EEDBQq148mSd1fAYYiFK4Z/aZGBYHeiLFvdtdi+QCngStFLK/X4N
         Mo/ZZwECn4IXiG87MvnMZ9DK8YP6vZ9vOugpiS1noMcQTPvXKB+6DJgh8IPWV+weh+8Q
         TSmgnuolOBXX2MIObnSOziLPdV/oFLzEkI20FcEieyZsqfBP/kaOzjzpr2NOotg4ZkRv
         V9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6JEfiNf5n2+MhaO0HVvlW1RsO1AOnBzQ0+wWwsFcMI=;
        b=Tr3j8P8GuZ73uZRAw+meleIQkja3jZ1oMHfWewMfoFNFFWdvO1yihdE4nN7wMOYJnT
         wa5BGzRIZzI6eS7cYJ0p5katfkvD63AVyO1VFvATyho6UEjdH88sYzJjEwR/DDeH8QX7
         p2hwQAVk70tbrJZbSw8weQkjeZ/AwBsVNaugtRxPfnXaSfXnDDVOV0Nxccme+aLTeqfa
         fRNB+03p87GmXW4/uHkp85ovl5Rl66AejIrYUMph7zGAnWUnfsDTPy5nqRPaiFmK5L3I
         21nMYyZCMhSvu+kZiGFrAsuEpHRszP8uHShpbhXP+7OMYhTicGg1wc3kTzWyPCat9sDx
         VqgQ==
X-Gm-Message-State: AA+aEWZWyigqLWs/kATJ2PtFUKrV9l7oFzeKRS1zVh7lP72SUQJBB4EQ
        HB8YYEZ6bl0og1UxV2jbpzXoIycswNSgJI83Bnvh1s4irHA=
X-Google-Smtp-Source: AFSGD/VpTeMUVcIIVZipVAyS6EWC/3m3QRO1/YjCqVmunftd0v4ZYlHFt+PbIvK//4J41SeLChAHkmV1in5BadJJgwc=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr102673eji.106.1544134559105;
 Thu, 06 Dec 2018 14:15:59 -0800 (PST)
MIME-Version: 1.0
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com> <20181205210104.GC19936@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1812062100020.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1812062100020.41@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Dec 2018 14:15:47 -0800
Message-ID: <CAGZ79kaQhQi9XVQVLresPWwQkRAKgXNmkt-jwZ-o0703FFW=Ew@mail.gmail.com>
Subject: Re: git, monorepos, and access control
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, John.Coiner@amd.com,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 6, 2018 at 12:09 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Wed, 5 Dec 2018, Jeff King wrote:
>
> > The model that fits more naturally with how Git is implemented would be
> > to use submodules. There you leak the hash of the commit from the
> > private submodule, but that's probably obscure enough (and if you're
> > really worried, you can add a random nonce to the commit messages in the
> > submodule to make their hashes unguessable).
>
> I hear myself frequently saying: "Friends don't let friends use
> submodules". It's almost like: "Some people think their problem is solved
> by using submodules. Only now they have two problems."

Blaming tools for their lack of evolution/development is not necessarily the
right approach. I recall having patches rejected on this very mailing list
that fixed obvious but minor good things like whitespaces and coding style,
because it *might* produce merge conflicts. Would that situation warrant me
to blame the lacks in the merge algorithm, or could you imagine a better
way out? (No need to answer, it's purely to demonstrate that blaming
tooling is not always the right approach; only sometimes it may be)

> There are big reasons, after all, why some companies go for monorepos: it
> is not for lack of trying to go with submodules, it is the problems that
> were incurred by trying to treat entire repositories the same as single
> files (or even trees): they are just too different.

We could change that in more places.

One example you might think of is the output of git-status that displays
changed files. And in case of submodules it would just show
"submodule changes", which we already differentiate into "dirty tree" and
"different sha1 at HEAD".
Instead we could have the output of all changed files recursively in the
superprojects git-status output.

Another example is the diff machinery, which already knows some
basics such as embedding submodule logs or actual diffs.

> In a previous life, I also tried to go for submodules, was burned, and had
> to restart the whole thing. We ended up with something that might work in
> this instance, too, although our use case was not need-to-know type of
> encapsulation. What we went for was straight up modularization.

So this is a "Fix the data instead of the tool", which seems to be a local
optimization (i.e. you only have to do it once, such that it is cheaper to
do than fixing the tool for that workgroup)
... and because everyone does that the tool never gets fixed.

> What I mean is that we split the project up into over 100 individual
> projects that are now all maintained in individual repositories, and they
> are connected completely outside of Git, via a dependency management
> system (in this case, Maven, although that is probably too Java-centric
> for AMD's needs).

Once you have the dependency management system in place, you
will encounter the rare case of still wanting to change things across
repository boundaries at the same time. Submodules offer that, which
is why Android wants to migrate off of the repo tool, and there it seems
natural to go for submodules.

> I just wanted to throw that out here: if you can split up your project
> into individual projects, it might make sense not to maintain them as
> submodules but instead as individual repositories whose artifacts are
> uploaded into a central, versioned artifact store (Maven, NuGet, etc). And
> those artifacts would then be retrieved by the projects that need them.

This is cool and industry standard. But once you happen to run in a bug
that involves 2 new artifacts (but each of the new artifacts work fine
on their own), then you'd wish for something like "git-bisect but across
repositories". Submodules (in theory) allow for fine grained bisection
across these repository boundaries, I would think.

> I figure that that scheme might work for you better than submodules: I
> could imagine that you need to make the build artifacts available even to
> people who are not permitted to look at the corresponding source code,
> anyway.

This is a sensible suggestion, as they probably don't want to ramp up
development on submodules. :-)
