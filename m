Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC4DC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED221611CE
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 14:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhFMOTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhFMOTj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 10:19:39 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8683C061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 07:17:38 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p66so34968567iod.8
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Y/sZF19pcwokOBIk5xZcA0rl1fDjDG5nPTCgea3DrqA=;
        b=Q9R+m2qnML/WwgbQOGflkUUTIiv6juO+7D83XF2rj8e0l06GQWC26jStBxdmQGCva6
         39zZ/+OaAKsVmlge29h+YrJoWVRtIN9MzUH4rhc+86wdAL3Va5YsumyyTHpj43KYAf37
         Yux7Pi6C3TAyO1jNNCvEnSxxuntB09BD4NILNVlxsQE63AgepAnbagKywGFYakjCmTq6
         redR3dxfbBXGsxT4WNXyS4ieTX71UwSmBgh/ErpHhm0Jyjc/kRQRVBIBLIlySz+JE9M8
         o9DfiDD5DeMCR4cmnYzZaygOd6HTyVJChPxf9dJVSmmm3h/grjcgzDwbVJawbSe7W+7b
         XCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Y/sZF19pcwokOBIk5xZcA0rl1fDjDG5nPTCgea3DrqA=;
        b=AjpNkBAob3ACqSofdKWPvPqwXKEpB77bHzse3lThrRDCuKSpdsM03XamCn1xBBoFfb
         /6k7dya1G9PeUnW4HCWE11j31IEE+mXOw3NXVVajvHfK7YD50yb+yLJO5Z1Bt71S7Vr0
         tqzFF9myGkqC8Py61e+sR2um4RN065PwR8TpBGZI8y2mPEiqKJMbB2GaXuCfqlYpw6ZK
         zpvcYeCk5TFz1+4XZOwsfRsW/d9URiHkMbnsTlGEJkYEkOpemmQ/U1TjTZPajWDj6wMc
         Y+aEoaP0MUmW1yRCVHxpuqPAryl9hT/rSxSBoTH8J2cH+O7QrBNR95S5RtI/IH1fy+gm
         XwQQ==
X-Gm-Message-State: AOAM533ntWv/AfOX2a/k2N+uFW07JK1CpV09d6JKxHKZsMEeUqr76fHD
        /C8kAvUoPfyJJhQwj1S/L+h10gEXnoJzAvfwgwMYtrWYedwLWQ==
X-Google-Smtp-Source: ABdhPJzWZ7neBUHhn6sPzU2DhCw/sMrkyCwvfhrt3aRqFusL09SwTefv5DPNmnBkRSeSiVKjZLmj7KJqtR4AM4FVDZw=
X-Received: by 2002:a02:647:: with SMTP id 68mr12595213jav.29.1623593854298;
 Sun, 13 Jun 2021 07:17:34 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 13 Jun 2021 22:17:23 +0800
Message-ID: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
Subject: [GSoC] Git Blog 4
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My fourth week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-3/

## Week4: Trouble is a friend

At the beginning of this week , since my previous code
broke some Github CI tests , I tried to solve these bugs
related to the atom `%(raw)` . The most confusing thing
is that some bugs may pass the tests of your local machine,
but fail to pass in the CI of GitHub .

E.g. I need to add the `GPG` prerequisites to the test like this:

```sh
test_expect_success GPG 'basic atom: refs/tags/signed-empty raw' '
git cat-file tag refs/tags/signed-empty >expected &&
git for-each-ref --format="%(raw)" refs/tags/signed-empty >actual &&
sanitize_pgp <expected >expected.clean &&
sanitize_pgp <actual >actual.clean &&
echo "" >>expected.clean &&
test_cmp expected.clean actual.clean
'
```

Otherwise, some operating systems that do not contain GnuPG
may not be able to perform related tests.

In addition, some scripts like `printf "%b" "a\0b\0c" >blob1` will
be truncated at the first NUL on a 32-bit machine, but it performs
well on 64-bit machines, and NUL is normally stored in the file.
This made me think that Git's file decompression had an error on
a 32-bit machine before I used Ubuntu32's docker container to
clone the git repository and In-depth analysis of bugs... In the end,
I used `printf "a\0b\0c"` to make 32-bit machines not truncated
in NUL. Is there a better way to write binary data onto a file than
`printf` and `echo`?

Since I am a newbie to docker, I would like to know if there is any
way to run the Git's Github CI program remotely or locally?

In the second half of this week, I tried to make `cat-file` reuse the
logic of `ref-filter`. I have to say that this is a very difficult process.
"rebase -i" again and again to repair the content of previous commits.
squeeze commits, split commits, modify commit messages... Finally, I
submitted the patches to the Git mailing list in
[[PATCH 0/8] [GSOC][RFC] cat-file: reuse `ref-filter`
logic](https://lore.kernel.org/git/pull.980.git.1623496458.gitgitgadget@gmail.com/).
Now `cat-file` has learned most of the atoms in `ref-filter`. I am very
happy to be able to make git support richer functions through my own code.

Regrettably, `git cat-file --batch --batch-all-objects` seems to take up
a huge amount of memory on a large repo such as git.git, and it will
be killed by Linux's oom. This is mainly because we will make a large
number of copies of the object's raw data. The original `git cat-file`
uses `read_object_file()` or `stream_blob()` to output the object's
raw data, but in `ref-filter`, we have to use `v->s` to copy the object's
data, it is difficult to eliminate `v->s` and print the output directly to the
final output buffer. Because we may have atoms like `%(if)`, `%(else)`
that need to use buffers on the stack to build the final output string
layer by layer, or the `cmp_ref_sorting()` needs to use `v->s` to
compare two refs. In short, it is very difficult for `ref-filter` to reduce
copy overhead. I even thought about using the string pool API
`memintern()` to replace `xmemdupz()`, but it seems that the effect
is not obvious. A large number of objects' data will still reside in memory,
so this may not be a good method.

Anyway, stay confident. I can solve these difficult problems with
the help of mentors and reviewers. `:)`
