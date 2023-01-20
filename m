Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF9DC38159
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 05:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjATFWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjATFW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 00:22:28 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D14C73ECA
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 21:12:29 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id g14so4355436ljh.10
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 21:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BF0YaaoxUIaTpf0cMoyriyVqOASik+q/QEtCEKNl8Ek=;
        b=iqp1Z13i/afQXGDrelIQy2cPQCvJiewxeIK/8yOrcQ5QrBbSmm8PJfcyhnQKJrblY8
         NJxZAOeJumEtRrvNWhl/z8kjXftsUGobUgcWB5a/ks+h4DnMISKZopkMftJHZdAqZtt/
         VSXitwGo/cF9KhVu9kaP/rYACLql/GvpCCTPjGSk+gep3RIZUeGxfA7FJl8eOQLrzff1
         +DXHJpnaB0MNbEF74ItIj0SZO5g8M1sT0+fZm6fqPYvHW0K1D7uvBJaAzEP6YBx79wxX
         xCufqQNp4adKflXckbIIQJfcgahSCotQuQN7oG7v24wlVInkkzLTnaCEltUQmyiZmI7o
         a1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BF0YaaoxUIaTpf0cMoyriyVqOASik+q/QEtCEKNl8Ek=;
        b=Tfi22WjqbPvTLohhKNuMdmT+gKTMUK2xDfbVn3ewdL5xLoEvCMgyQjkiV92soEiu/y
         GBjaMp7UUVwWK73DLVXCo+qo6/oLpsSg8Cw5+ceonBw7OPOyp9koZpwLEcKlqeHlcnnC
         xU9YL1T3kqgpEe9Vr2yah/+sy0ROmNiChtQw6EQr6dPg7tPyRtBgOK8szrpGOWxHtAPT
         DkT85PaSqrFaIuYuXY/sZ8paF5ulb4GScVU6Ul9EZXUL9Cm5ylVMoKOdfQvzWMkOcomP
         yMpsk3TE8zOovlKMBVkTnRFh5ESDENp9JeUN9X3kiSF3KSI2dRu5J7Dbf4DUHFD/HZWL
         VHkw==
X-Gm-Message-State: AFqh2kpWN8RwMbI5DdLEa5w85ZDTqc19QKyOxBUjxKJDHzr/ltL2nMyQ
        YETZT1EgfNttf8jX+KQQyonghTlv7382B5h/8U4=
X-Google-Smtp-Source: AMrXdXsd+m57juq9bAtx3Eo7yshyN6L33beXpQhN5HbjZ6ZU9O+bv7T2KlLz4pPSgJhoAwejTiX8nEmPrH9oYjs+/iE=
X-Received: by 2002:a2e:9d99:0:b0:27f:e221:293c with SMTP id
 c25-20020a2e9d99000000b0027fe221293cmr1258328ljj.163.1674191543455; Thu, 19
 Jan 2023 21:12:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
 <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com> <cde4827da13a1391501057ee42655836f0ccd337.1674149666.git.gitgitgadget@gmail.com>
In-Reply-To: <cde4827da13a1391501057ee42655836f0ccd337.1674149666.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Jan 2023 21:12:10 -0800
Message-ID: <CABPp-BEC4PmQfYT=UhtbJ5QcXXMqwF1e-KvSVVDNjDy69bGH5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: fix sparse-checkout docs link
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2023 at 9:34 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> There is a linking error when other documents want to refer to
> technical/sparse-checkout.txt, Also, there is something wrong
> with the format of the paragraphs in sparse-checkout.txt, which
> makes acsiidoc compile errors.
>
> So fix the format of sparse-checkout.txt, and link it in the
> Makefile to correct that.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/Makefile                      |  1 +
>  Documentation/technical/sparse-checkout.txt | 43 ++++++++++++++-------
>  2 files changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 9c67c3a1c50..7540da27b8c 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -121,6 +121,7 @@ TECH_DOCS += technical/reftable
>  TECH_DOCS += technical/scalar
>  TECH_DOCS += technical/send-pack-pipeline
>  TECH_DOCS += technical/shallow
> +TECH_DOCS += technical/sparse-checkout
>  TECH_DOCS += technical/trivial-merge
>  SP_ARTICLES += $(TECH_DOCS)
>  SP_ARTICLES += technical/api-index
> diff --git a/Documentation/technical/sparse-checkout.txt b/Documentation/technical/sparse-checkout.txt
> index fa0d01cbda4..52e86764a6c 100644
> --- a/Documentation/technical/sparse-checkout.txt
> +++ b/Documentation/technical/sparse-checkout.txt
> @@ -1,3 +1,6 @@
> +Sparse Checkout Design Notes
> +============================
> +
>  Table of contents:
>
>    * Terminology
> @@ -14,7 +17,8 @@ Table of contents:
>    * Reference Emails
>
>
> -=== Terminology ===
> +Terminology
> +-----------
>
>  cone mode: one of two modes for specifying the desired subset of files
>         in a sparse-checkout.  In cone-mode, the user specifies
> @@ -92,7 +96,8 @@ vivifying: When a command restores a tracked file to the working tree (and
>         file), this is referred to as "vivifying" the file.
>
>
> -=== Purpose of sparse-checkouts ===
> +Purpose of sparse-checkouts
> +---------------------------
>
>  sparse-checkouts exist to allow users to work with a subset of their
>  files.
> @@ -255,7 +260,8 @@ will perceive the checkout as dense, and commands should thus behave as if
>  all files are present.
>
>
> -=== Usecases of primary concern ===
> +Usecases of primary concern
> +---------------------------
>
>  Most of the rest of this document will focus on Behavior A and Behavior
>  B.  Some notes about the other two cases and why we are not focusing on
> @@ -300,7 +306,8 @@ Behavior C do not assume they are part of the Behavior B camp and propose
>  patches that break things for the real Behavior B folks.
>
>
> -=== Oversimplified mental models ===
> +Oversimplified mental models
> +----------------------------
>
>  An oversimplification of the differences in the above behaviors is:
>
> @@ -313,7 +320,8 @@ An oversimplification of the differences in the above behaviors is:
>               they can later lazily be populated instead.
>
>
> -=== Desired behavior ===
> +Desired behavior
> +----------------
>
>  As noted previously, despite the simple idea of just working with a subset
>  of files, there are a range of different behavioral changes that need to be
> @@ -544,7 +552,8 @@ understanding these differences can be beneficial.
>    * gitk?
>
>
> -=== Behavior classes ===
> +Behavior classes
> +----------------
>
>  From the above there are a few classes of behavior:
>
> @@ -611,7 +620,8 @@ From the above there are a few classes of behavior:
>      specification.
>
>
> -=== Subcommand-dependent defaults ===
> +Subcommand-dependent defaults
> +-----------------------------
>
>  Note that we have different defaults depending on the command for the
>  desired behavior :
> @@ -751,7 +761,8 @@ desired behavior :
>      implemented.
>
>
> -=== Sparse specification vs. sparsity patterns ===
> +Sparse specification vs. sparsity patterns
> +------------------------------------------
>
>  In a well-behaved situation, the sparse specification is given directly
>  by the $GIT_DIR/info/sparse-checkout file.  However, it can transiently
> @@ -823,7 +834,8 @@ under behavior B index operations are lumped with history and tend to
>  operate full-tree.
>
>
> -=== Implementation Questions ===
> +Implementation Questions
> +------------------------
>
>    * Do the options --scope={sparse,all} sound good to others?  Are there better
>      options?
> @@ -894,7 +906,8 @@ operate full-tree.
>      is seamless for them.
>
>
> -=== Implementation Goals/Plans ===
> +Implementation Goals/Plans
> +--------------------------
>
>   * Get buy-in on this document in general.
>
> @@ -922,13 +935,14 @@ operate full-tree.
>       commands.  IMPORTANT: make sure diff machinery changes don't mess with
>       format-patch, fast-export, etc.
>
> -=== Known bugs ===
> +Known bugs
> +----------

Everything so far makes sense.

>  This list used to be a lot longer (see e.g. [1,2,3,4,5,6,7,8,9]), but we've
>  been working on it.
>
> -0. Behavior A is not well supported in Git.  (Behavior B didn't used to
> -   be either, but was the easier of the two to implement.)
> +Behavior A is not well supported in Git.  (Behavior B didn't used to
> +be either, but was the easier of the two to implement.)

Why did you remove the numbering on this, though?  If asciidoc doesn't
like starting with 0 (the only guess I can think of for why you'd
change this), shouldn't the series be renumbered starting at 1 rather
than removing this from the list?

>  1. am and apply:
>
> @@ -1052,7 +1066,8 @@ been working on it.
>      https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/
>
>
> -=== Reference Emails ===
> +Reference Emails
> +----------------
>
>  Emails that detail various bugs we've had in sparse-checkout:
>
> --
> gitgitgadget
