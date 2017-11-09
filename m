Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A13A1F42B
	for <e@80x24.org>; Thu,  9 Nov 2017 06:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbdKIGys (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 01:54:48 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:56761 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdKIGyr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 01:54:47 -0500
Received: by mail-wm0-f50.google.com with SMTP id z3so15317543wme.5
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 22:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ufMx+RfQQ1/i0r6WB16iGdnx+ZTCaaQioQQsheeyio4=;
        b=qZgw1PFBZC1P9csLc87faY60IJpD7PvlAbDz0SvYpFSBEw+k1MFlnqaugWglFIlySI
         88rKbmpNrHJH41BmfvQDTrZ0s9DJwEieGkwP8zHw3YWD9ZLZbOuYvdxg4xnU5n5gFoPN
         SiPxQPnfk4hys9gJkNlkZkRaIRqtdzTsMUL/s1aEpTayV8Y49Phmx0sMWELM/ysIrlLY
         J9XyJH0rktKWrFVtjd3TLLLATQMc2wDZgSaUQIFULWGw4ZQG8Z9npI29T90W5djoJg3p
         JEncelPERSXQrffBUi6wJ/Ga/Egj1E7potuupLQvfuS3S/jH41jtnxxYkhBi98jomHMo
         ho+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ufMx+RfQQ1/i0r6WB16iGdnx+ZTCaaQioQQsheeyio4=;
        b=kGJYCvUuXZA37Tmo+flHfpUYpsLsL/ZDuJaEK3v7vXYiubjhhjmjJNQX2IMUH+g3cA
         e7YpJA2KRK56ee1mqXvvixNLY3T+QgQgxQ9EFVoIbIq9Ae5qY0ng1piL82D9EHK3uMG+
         auRrcG8JQm9MXz2a3G3aCXqCj8gqIhXusSRRuqaq+Yu0t9Tb/mS8c4bVJTA8Uy/Ubysu
         bz8LDhJ3sVN8JM+kmj5jM0ZMvbdWPMMksc+/un0/BDSOLCj7slXuuzdPtPCPZ9dFa8Sf
         d/ZHQuNhr7hFqo/pTHN1wzeBop2zFbNv2e1ygsZeKmdegs0Dzz/I/KnMSHZTZBbzpF8w
         jhKg==
X-Gm-Message-State: AJaThX7PlGSHgWI+V7AMWfa3kVW4zximGVz/3CzMR78P/Zqjp9CxPZWe
        +er+7yCZ7r3enMSxMTNaM6FO/1+LeSC9eNDQzog=
X-Google-Smtp-Source: ABhQp+QE3776JakCN8DCWi8DUNRbSbcH0+5tXuMxBJ1ozCqxVStpRl4VtffIIREn0wf1cnFn8IsxpqMNonjHiPj0FMw=
X-Received: by 10.80.182.210 with SMTP id f18mr4090497ede.104.1510210486158;
 Wed, 08 Nov 2017 22:54:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Wed, 8 Nov 2017 22:54:25 -0800 (PST)
In-Reply-To: <20171109001007.11894-1-sbeller@google.com>
References: <20171108143646.2e1870a82360072557094e01@google.com> <20171109001007.11894-1-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 8 Nov 2017 22:54:25 -0800
Message-ID: <CA+P7+xpTCHHNG1tAhysOFV5jFHpXdzRk5zfYNHUUVdYiGY55cA@mail.gmail.com>
Subject: Re: [RFD] Long term plan with submodule refs?
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 8, 2017 at 4:10 PM, Stefan Beller <sbeller@google.com> wrote:
>> The relationship is indeed currently useful, but if the long term plan
>> is to strongly discourage detached submodule HEAD, then I would think
>> that these patches are in the wrong direction. (If the long term plan is
>> to end up supporting both detached and linked submodule HEAD, then these
>> patches are fine, of course.) So I think that the plan referenced in
>> Junio's email (that you linked above) still needs to be discussed.
>

> New type of symbolic refs
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> A symbolic ref can currently only point at a ref or another symbolic ref.
> This proposal showcases different scenarios on how this could change in t=
he
> future.
>
> HEAD pointing at the superprojects index
> ----------------------------------------
> Introduce a new symbolic ref that points at the superprojects
> index of the gitlink. The format is
>
>   "repo:" <superprojects gitdir> '\0' <gitlink-path> '\0'
>
> Just like existing symrefs, the content of the ref will be read and follo=
wed.
> On reading "repo:", the sha1 will be obtained equivalent to:
>
>     git -C <superproject> ls-files -s <gitlink-path> | awk '{ print $2}'
>
> Ref write operations driven by the submodule, affecting symrefs
>   e.g. git checkout <other branch> (in the submodule)
>
> In this scenario only the HEAD is optionally attached to the superproject=
,
> so we can rewrite the HEAD to be anything else, such as a branch just fin=
e.
> Once the HEAD is not pointing at the superproject any more, we'll leave t=
he
> submodule alone in operations driven by the superproject.
> To get back on the superproject branch, we=E2=80=99d need to invent new U=
X, such as
>    git checkout --attach-superproject
> as that is similar to --detach
>

Some of the idea trimmed for brevity, but I like this aspect the most.
Currently, I work on several projects which have multiple
repositories, which are essentially submodules.

However, historically, we kept them separate. 99% of the time, you can
use all 3 projects on "master" and everything works. But if you go
back in time, there's no correlation to "what did the parent project
want this "COMMON" folder to be at?

I started promoting using submodules for this, since it seemed quite natura=
l.

The core problem, is that several developers never quite understood or
grasped how submodules worked. There's problems like "but what if I
wanna work on master?" or people assume submodules need to be checked
out at master instead of in a detached HEAD state.

So we often get people who don't run git submodule update and thus are
confused about why their submodules are often out of date. (This can
be solved by recursive options to commands to more often recurse into
submodules and checkout and update them).

We also often get people who accidentally commit the old version of
the repository, or commit an update to the parent project pointing the
submodule at some commit which isn't yet in the upstream of the common
repository.

The proposal here seems to match the intuition about how submodules
should work, with the ability to "attach" or "detach" the submodule
when working on the submodule directly.

Ideally, I'd like for more ways to say "ignore what my submodule is
checked out at, since I will have something else checked out, and
don't intend to commit just yet."

Basically, a workflow where it's easier to have each submodule checked
out at master, and we can still keep track of historical relationship
of what commit was the submodule at some time ago, but without causing
some of these headaches.

I've often tried to use the "--skip-worktree" bit to have people set
their repository to ignore the submodule. Unfortunately, this is
pretty complex, and most of the time, developers never remember to do
this again on a fresh clone.

Thanks,
Jake
