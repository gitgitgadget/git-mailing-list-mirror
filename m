Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB48C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443335AbiDVCdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379042AbiDVCdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:33:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F17B55B4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:30:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ks6so13658120ejb.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Km4q6i+TYl5ECaoS1fjZk6svQupzQs59+xXLHHUIlk=;
        b=TvuUiEXk6sz5K59Q+6WZnfrlI7M9OFaA2hi9pD5NZo5aAJSi6238SLBCOyZflz1eLQ
         0swwsFcDzzhpSgptFKQmjsYGZ2wHLHvGStrM43s9m2pksJF96t9EVd1NBAmPey2fLE2V
         2TdXASowyaAZ/CKJkzjeKT+EzvRIin+oSKRa91THNgzX6zR+8cqbpRfp8TE7qSeQuLvt
         5k85hBXzU5285LTugO2i5krCV8tsWhrnuvaGMMipk0r79JnaLoyR2s8Kl78MXxJO0TQq
         lhlMJb98PGTWeIrY/z7q0TxMjq5eAOsfFekinsDrwFIN04bnapRElqNNw/CG+wp/2602
         YYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Km4q6i+TYl5ECaoS1fjZk6svQupzQs59+xXLHHUIlk=;
        b=tpscOcn+cnH0OPXUUejYvlkSlhHMYgVQ816R0WUZMzHrRu0Y8KcqBFYg8UejXejeHI
         lnb4i4NVOtgRI15MxW5lGXpOOqOO876iiDCCZKoS9aMGJ4zc08uOSpYSMHA9C7puWWMx
         CMiCno6B38luXlGrpZWELSINhbGAd4i4Y0nRPj7krppQn+ktZUEIqqXzmGRCvoq7PMDl
         QTC9hUGd0iMAr18p3sY7vf5hIxuozCj2S3HYQcr0Sjh6tFD8nkBlSCSykabAuJxTbbAQ
         cHC9Q3hifqe4iDw5LkFo55DLjPjjcGohI4HnVfXN1YtLOVzDm8Bb4sO3MnyR9iGz2yfG
         Rvzw==
X-Gm-Message-State: AOAM530B/815g8Z2F73YO1M/jqppz75Xd6KPv0MOFkMwoWNZjtWhKga+
        tzVjjNNmJLH2nQf7qVpZ+Ox7FMLAmPhU8E4tL1xVKLJRmpI=
X-Google-Smtp-Source: ABdhPJxm0t0hgyyCt7kEHpXwiwcXnAcNSB6nUSLscxLYr7VqHv1zs6NqfU/B6NZIBzoIUsWJR2wXJGsw3XGJre++mOw=
X-Received: by 2002:a17:906:a05a:b0:6ef:a44d:2f46 with SMTP id
 bg26-20020a170906a05a00b006efa44d2f46mr2155499ejb.192.1650594608727; Thu, 21
 Apr 2022 19:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com> <eb3b318b39ec3eed754eab7d2c9d20198117545b.1647054681.git.gitgitgadget@gmail.com>
 <xmqqwngwp87k.fsf@gitster.g>
In-Reply-To: <xmqqwngwp87k.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Apr 2022 19:29:57 -0700
Message-ID: <CABPp-BEt0CzP7B_EvYXOhQoKqk+h=9OwXDmUDCYfB3fnHxv-uA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] git-sparse-checkout.txt: update docs for
 deprecation of 'init'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 14, 2022 at 1:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > -When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
> > -the input list is considered a list of patterns.  This mode is harder
> > -to use and less performant, and is thus not recommended.  See the
> > -"Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
> > -Set" sections below for more details.
> > +When `--no-cone` is passed, the input list is considered a list of
> > +patterns.  This mode is harder to use and less performant, and is thus
>
> "less perfromant" can be quantified, but "harder to use" is probably
> harder to defend.  Those on a project with need for more flexible
> way to specify than "these are the directories I care about" would
> not find it convincing.

That text wasn't added by this patch (or even by any patch in this
series); it was in the pre-image.  I can still change it, of course,
but I don't think it belongs in this particular patch.  How about I
replace this text in 8/9 with a link to the new section that was added
(the one that explains the problems we see with non-cone mode).

> > +not recommended.  See the "Sparse Checkout" section of
> > +linkgit:git-read-tree[1]
>
> The referenced section (I am reading "git read-tree --help" from
> seen with these patches) may need updating.  It shows an example
> of including everything except for unwanted, without mentioning
> if that is for cone or non-cone.

I wouldn't really say that the example is for either mode (the point
of the sparse-checkout command is so users don't need to directly edit
the $GIT_DIR/info/sparse-checkout file), but the examples might be
useful for people trying to understand the patterns used in non-cone
mode.  Perhaps this change would be helpful?:

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 99bb387134..0eae9e01fd 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -378,7 +378,9 @@ SPARSE CHECKOUT
 Note: The `update-index` and `read-tree` primitives for supporting the
 skip-worktree bit predated the introduction of
 linkgit:git-sparse-checkout[1].  Users are encouraged to use
-`sparse-checkout` in preference to these low-level primitives.
+`sparse-checkout` in preference to these low-level primitives.  However,
+the information below might be useful to users trying to understand the
+pattern style used in non-cone mode of the `sparse-checkout` command.

However, I don't think that belongs in this patch (since you were
commenting on text that only appeared in the diff due to reflowing
paragraphs), but I can add it to 9/9.

> > and the "Pattern Set" sections below for more
> > +details.
>
> Are we referring to "Internals - cone/full pattern set" sections?

Yeah, as you noted in a later patch, you got confused by looking at
the end result rather than the state of the tree as of this patch.
The "Internals -" prefix was added in a later patch.

> This may be a topic of another step in this series, but the "core"
> section starts by mentioning what characteristics the full pattern
> set has and uses it to steer readers away from it, which I find it
> less than ideal.  As we present "core" first (because it is the
> default), we should present "core" by itself, without requiring to
> know what the other thing is.

By '"core" section' do you mean the "cone pattern set" section?
That's my best guess after several comparisons.  I agree that it's
less than ideal, though I thought that perhaps adding the "Internals"
prefix would allow folks to just ignore it.  But you may be right that
I should also overhaul it a bit, maybe splitting it into two sections,
one about some implementation details about the mode, and another
later section about how the patterns in cone mode are a strictly
controlled subset of the possible full pattern set.  However, I think
that'd go better in patch 7 rather than here.

>  Perhaps replace the entire first
> paragraph so that the section begins more like so:
>
>         The "cone mode", which is the default, lets you specify only
>         what directories to include and what directories to exclude.

There's no provision to specify individual directories to exclude,
only which to include.  Everything not listed is excluded.

>         The accepted patterns in the cone pattern set are:...
>
> Especially, the last sentence in the paragraph to be struck still
> lives in the old world in which you needed to opt into the cone
> mode.

This patch didn't strike any paragraph, so I'm not sure which sentence
you're referring to.  I tried looking around, and didn't readily find
it either.  Perhaps my big reshufflings in my new patch 7 addressed
what you're talking about, though?
