Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CE791F770
	for <e@80x24.org>; Wed,  2 Jan 2019 16:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfABQSQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 11:18:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39887 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfABQSP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 11:18:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so27987883wmd.4
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 08:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQCZUcivNh0+41VPupDcE2QJ69IrMo/KsStY0KZuyWA=;
        b=HAQ5oGLXIN7y6pivh5l/OH40B65cpO3xUa5kN+FMlw66mD0/Jmm9w4m4NL2o8MkWRt
         yL7Q4NL4KYrVQEMBLvodxLcS5I5dXZ5Lu7OfvIbbEJvkBrT08JlCbJfRzGWeH6Z/TcTA
         c1T00xUtqos7sohLNCpnOmJKu+qRgxuHp9NwSd0PFen6ExDHuzKB/MjFvpqFOjS6mxJ/
         nLvqvyXHDPyrflAFFPPiK8ZjJ5O+rCbwIMMZSdHLqkNlNNPTF0nh9+SZ9BGp3NisGs2Y
         q6PrItOH9Zuyfm6zKoKGTIpeo5anGP+Tu2JH/HBxXfEkxB+p6szT4J4Xod1z1xURxzW/
         LraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQCZUcivNh0+41VPupDcE2QJ69IrMo/KsStY0KZuyWA=;
        b=pQSOmf99HFb1KIw7UDuEMhH0F+w2bzPDVgKfRWieICxm4z/Wco5qbLlZ889b+ikZHf
         JKM0eAlr53IRbijMWVtN0QwW3H3Bvqqpie+JLJlcFJVxpyoeszVUNZIkVEaNHNUM/LLk
         U2LKzEn03Lkk3uhIQ9iEzy+vPBkoXbvwWjzB5FZqUS0Mcv/OuqeU8w/QTkayrCnSsG+W
         DZhUmclgifwGgEMZpg0Y7IIJV5k+dEuecFsGEpmc1eUxarlgXBgmAujAf2/oxvU3wJlM
         H2oPKByRRRfJ59PGlHeOFGsp6JVQTmp74vCFBtlIaiVT3bPmZJUnPtVl62aBgYCnrOzR
         6qmg==
X-Gm-Message-State: AA+aEWbzyua1cNV22zkjQFdXSIlbHicPiLUvklLv4yCO4ZoEfUxyxNqO
        NLsvcisb63zC04Zg2eH9PULlEh3fXtUgNDCX96Q9Iw==
X-Google-Smtp-Source: AFSGD/WDzuqrkBcBJi3Su+W3tr8yNkZAbiu+FP70Hj5y5mjZSbuNQ/g8wjE3pQbftWUR1YZPWHsGQOpc9MzLZGJy6Ck=
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr35619429wmb.33.1546445893244;
 Wed, 02 Jan 2019 08:18:13 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
 <CACsJy8B=-V7XY+=5pwwSzg8B6Goa55DPPU3ErgjOEsSJVni18Q@mail.gmail.com>
In-Reply-To: <CACsJy8B=-V7XY+=5pwwSzg8B6Goa55DPPU3ErgjOEsSJVni18Q@mail.gmail.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Wed, 2 Jan 2019 08:18:02 -0800
Message-ID: <CA+dzEB=TPxng4YBC4Vfh=ZcctAzRQ+drJ3y2sXwP=JXf+UweSA@mail.gmail.com>
Subject: Re: Regression `git checkout $rev -b branch` while in a
 `--no-checkout` clone does not check out files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 2, 2019 at 3:08 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Jan 2, 2019 at 6:36 AM Anthony Sottile <asottile@umich.edu> wrote:
> >
> > Here's a simple regression test -- haven't had time to bisect this
>
> I can't reproduce with either 2.20.0, 2.20.1 or 'master'. It would be
> great if you could bisect this.
>
> There are no suspicious commits from 2.27.1 touching
> builtin/checkout.c. Though there are some more changes in
> unpack-trees.c that might cause this (big wild guess).
> --
> Duy


heated a small room but here's the results of the bisect!

fa655d8411cc2d7ffcf898e53a1493c737d7de68 is the first bad commit
commit fa655d8411cc2d7ffcf898e53a1493c737d7de68
Author: Ben Peart <Ben.Peart@microsoft.com>
Date:   Thu Aug 16 18:27:11 2018 +0000

    checkout: optimize "git checkout -b <new_branch>"

    Skip merging the commit, updating the index and working directory if and
    only if we are creating a new branch via "git checkout -b <new_branch>."
    Any other checkout options will still go through the former code path.

    If sparse_checkout is on, require the user to manually opt in to this
    optimzed behavior by setting the config setting checkout.optimizeNewBranch
    to true as we will no longer update the skip-worktree bit in the index, nor
    add/remove files in the working directory to reflect the current sparse
    checkout settings.

    For comparison, running "git checkout -b <new_branch>" on a large
repo takes:

    14.6 seconds - without this patch
    0.3 seconds - with this patch

    Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:040000 040000 817bfb8ef961545a554005d42967b5ab7cfdb041
e57e576d0d4fb7f25c12a5dcc7651ef6698e961b M    Documentation
:040000 040000 c089f91f4532caa2a17e4f10a1a7ed3aa5d2023c
7cf16a0aa288f898a880ffefe82ee7506b83bef4 M    builtin
:040000 040000 adfdb05964a692e03ee07d2e43841f6304d996bd
8681416093802b9051599ebea8f63f5a45968e6f M    t
bisect run success


Here's the script and invocations:

```
#!/usr/bin/env bash
set -euxo pipefail

rm -rf "$PWD/prefix"
make prefix="$PWD/prefix" -j8 install
export PATH="$PWD/prefix/bin:$PATH"

rm -rf src dest

git --version

git init src
echo hi > src/a
git -C src add .
git -C src commit -m "initial commit"
rev="$(git -C src rev-parse HEAD)"

git clone --no-checkout src dest
git -C dest checkout "$rev" -b branch
test -f dest/a

: 'SUCCESS!'
```

```
git bisect begin
git bisect bad HEAD
git bisect good v2.17.1
git bisect run ./bisect.sh
```

Anthony
