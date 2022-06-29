Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40988C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 16:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiF2Q6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 12:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiF2Q6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 12:58:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B84F2018D
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 09:58:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so7841wml.2
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=iyVg25TyBzJSyQalcg7ytuqb9ZaGxzVBiqetlv86FWE=;
        b=Y3QRBSjD/3kJ6MOkqtoNheIxz00owLLAOADSfQJFl/KLaXcedkgKpwA7hHt5w2TfBf
         tlWYpczZnZ9jqAo5qiKzPFdNFiV3ytffdDVxjebVdfLX1ZduBd563fiiiLYnyb+sB8tV
         Ojnuzs9bm4QhlHiLW7/kvnfIPWPj4hIeryIMGChYUq00fucc7Fr0VsxMBuHtd3Hu4EqS
         XbJmvbU0ccaZYKKzf+ZFdd7mwkHcJ3zRZUnpQOkl6eDGnbCY0TgRyhJCEeJtItyIicDW
         NmaNwempw6Z7GchH5CL5Hu3jFWO2TBqiqvW0uk83FPnvDVSUkmfE/IpdwfSJaasSXmer
         QOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iyVg25TyBzJSyQalcg7ytuqb9ZaGxzVBiqetlv86FWE=;
        b=sZykdyfb/ZhgWc4EbORDL9NAZ75hGmDizzNBjPgv2BfenXAA1qbdgQYorEGyOxltrS
         ZfB9VDaQoUTHJzxtSq/50AMMIaZblrOxACCWCsgHQll1mw2VmZEx4lVAShSIiNEpE8IF
         akNo/SLQDVWLcP84X6crcvhRxM74voAAQI0e5D/74DLAgj+XXfAM+e7uW4422lYrb27C
         BpM3aQbRwg0WtpYshFA9gEXoVFn8BKE/E2rLqogyPv8VwxC/wVESZNsPdK0i8pGTM0Ul
         bzjBEX7P5ioDa7HXK21agiLQ68ezv8HgegIjIHxPwzE2en+0cjlLn14ho9L8UFKOr3KW
         OVzw==
X-Gm-Message-State: AJIora+Qlghkn8eRElezhnFBucm0uzfcjB5bZI4u20DZT7szEXdsQpzG
        sF0M1LPAdfUx3YevvmjI5+UD4wJi/xNb9Q==
X-Google-Smtp-Source: AGRyM1tjL42MLiEK1NMmdDZIQ+OJWottDCJoDcTH6fSYW40fboeOOGUS+N83ziqX6uSfIS6EUN9oFQ==
X-Received: by 2002:a1c:f709:0:b0:3a0:3b29:5eb2 with SMTP id v9-20020a1cf709000000b003a03b295eb2mr6727589wmh.133.1656521927291;
        Wed, 29 Jun 2022 09:58:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d44c2000000b0021a3d94c7bdsm17252109wrr.28.2022.06.29.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:58:46 -0700 (PDT)
Message-Id: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 16:58:43 +0000
Subject: [PATCH 0/2] [RFC] scalar: prepare documentation for future work
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Johannes.Schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


What's this series?
===================

The questions of "what is Scalar?" and "why is Scalar part of Git?" have
been discussed at length already [1], but in preparation for the next few
series I plan to submit "finishing" the initial Scalar implementation
effort, I'd like to start by reframing its purpose.

Beginning with the "Philosophy of Scalar" [2], much of the existing
documentation refers to Scalar as "opinionated" - not unlike git itself.
However, with scalar now part of Git, continuing to describe it as
"opinionated" could unintentionally portray it as a divergence from "the
rest of Git" and its development community.

Rather than think of Scalar as an opinionated take on Git, I prefer to think
of it as a manifestation of Git's own "opinions" for a specific use case,
like many of the built-in commands. Over the years, developers have
contributed tons of features - often gated behind config settings - that
address performance issues they've encountered working in large
repositories: untracked cache, sparse index, merge-ort, etc. Some of these
features (like merge-ort) provide near-universal benefit to users and become
part of Git's default configuration. More often, though, these features are
large and difficult to prove are stable, or require some advanced manual
configuration to use properly, or simply make the "average" Git user's
experience worse (e.g., improving performance in in large repos, but
degrading it in smaller repos).

We've accumulated so many of these features that it's become difficult for
users to even find all of them, let alone use them. Git "knows" these
features exist, but also "knows" not to enable them by default because
they're either too experimental or not helpful to most users. Scalar is a
way for Git to take all of these features, bundle them together, and tell a
user, "Hey, do you need to make your large repo faster? Use this!" without
touching the default user experience.

All that to say, Scalar is essentially a collection of porcelain commands
[3] that fill a substantial UX niche in Git. Now, let's get into Scalar's
"future state".


A plan for Scalar
=================

Given the slightly tweaked "philosophy" above, my ultimate goal for Scalar
is to have it contain only what is too experimental or too large
repo-focused to be a default option or behavior in Git. Over time, some
features may be moved out of Scalar and into Git defaults as they are proven
stable and beneficial to the vast majority of users [4].

So what do we need to get there?

At a high level, the remaining work to "finalize" Scalar (past this RFC) can
be broken into three parts:

 1. Complete a few more features and subcommands of Scalar (integrate with
    the built-in FSMonitor & implement scalar help).
 2. Move stable, general-purpose parts of 'scalar.c' into other Git
    builtins/libraries (mainly scalar diagnose, either as part of git
    bug-report [5] or a new git built-in).
 3. Move Scalar out of contrib/ and into the "top-level" of Git. Includes
    expanded testing, especially performance testing.

The first makes scalar "feature complete" enough to be valuable to large
repo users (per my entirely subjective assessment, at least). The second
brings it in line with the goal of making Scalar only contain what can't
exist as a default feature of Git. Once those are finished, I think Scalar
will be out of its "work-in-progress" phase and ready to use as a built-in
component of Git (accompanied by sufficient testing, of course).


What's Scalar's future?
=======================

With the completion of the tasks listed in the previous section, there's
nothing left from the original Scalar CLI (in the Microsoft fork of Git) to
upstream. I don't consider that the "end" of supporting Scalar because, for
it to remain an effective tool, it'll need to stay up-to-date with the
latest performance features introduced to Git.

For example, one possible future extension might be to have Scalar enable
the sparse index by default, especially when more built-ins are updated with
sparse index compatibility. I'm interested in hearing what other features
might fit well there!


What I'm looking for
====================

The two patches in this series revise existing documentation to match the
description above. Please let me know if 1) those revisions match your
understanding of the above, 2) they convey the intent clearly, and (most
importantly) 3) they reflect a reasonable direction to take Scalar. And, of
course, if there's something I missed, I welcome any and all feedback &
ideas!

Thanks,

 * Victoria

[1]
https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/

[2]
https://github.com/microsoft/git/blob/173a9b783a414/contrib/scalar/docs/philosophy.md

[3] If you're wondering "why not call it git-scalar then?", my short answer
is 1) backward compatibility with the original "scalar" CLI, and 2) its
scope is larger and more persistent than a single command; Scalar works
across multiple repos, and each Scalar subcommand has scope and
functionality on par with a built-in command. I'm happy to talk through this
more if people are still unsure, though!

[4] That being said, Scalar's existence should not make Git more risk averse
in accepting new general-purpose features.

[5] https://lore.kernel.org/git/220517.86y1z05gja.gmgdl@evledraar.gmail.com/

Victoria Dye (2):
  scalar: reword command documentation to clarify purpose
  scalar: convert README.md into a technical design doc

 contrib/scalar/README.md            |  82 ------------------
 contrib/scalar/scalar.txt           |   9 +-
 contrib/scalar/technical/scalar.txt | 127 ++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 87 deletions(-)
 delete mode 100644 contrib/scalar/README.md
 create mode 100644 contrib/scalar/technical/scalar.txt


base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1275%2Fvdye%2Fscalar%2Fdoc-update-rfc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1275/vdye/scalar/doc-update-rfc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1275
-- 
gitgitgadget
