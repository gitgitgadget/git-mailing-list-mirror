Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C01ECCA47C
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 01:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiFSB0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 21:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSB0N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 21:26:13 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253511055F
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 18:26:11 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y79so8005416iof.2
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 18:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bnjf.id.au; s=dkim;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OXIwLMwac1fNvM8LzRgPeOocC737Ec7XCSdTgFrajto=;
        b=fuelfhyh+gNqI+nc7OHYAEem1XaxdBdm65CiUh0EvzJJCnv5ovE0jZi9PWRZyiK2SO
         IsGT5QtZCC1k92subrkAKnumeEumXCJUAOXuv8kDxLjgL8DVtyxtp3LqP+CU3dWjsG6z
         hmO31Z8wC9hVJnBg3zmdtvgREKx6EvXg7SXqVncVAuceZOmpQ25gZwhIh8CjccklIWU9
         SMS/I6H6rEBbBhPPWdziEouf+/7rgrBS5D/z8nLlmn3g3wEPoVdqtsbcwb8dNl8XjJfg
         V92LKCypxhttuX8ByfXImMLUJiZdOezWVGScLEygEfV8LlfcmWxfvwRr8zvp2PWLeg0G
         eEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OXIwLMwac1fNvM8LzRgPeOocC737Ec7XCSdTgFrajto=;
        b=1ETWtI+kBoBvR3ARPllWC3rLmuJ8SaKQRQrFMfDz/X1OCZJMTeko+129G8MeM2aFMs
         W1YhZ3A5M2tqRN3UImZlTmT1d7XKHeH1l1YUc6rTiM/U/Qx5Cdgb8RGA4ohQoOuukIQD
         4L0w9GN5vnZ2SnoTmowNSBr2L47hgExSFhqLh+YuqlSVtravxiT3i25SRzlOAIv52JC2
         F98OzlLimId4aioiWEJ+LT5egJk7yro4EjXm1EJDXNiVpaCxaVfmfXKDdVOLexJZqed8
         ZGQIXd0DJvX/DBroIDMyS3odrOLLmp0T3AHFEkxDypeWWIDlsLlqTsKPYPsZco/X/WUm
         QPJQ==
X-Gm-Message-State: AJIora/JKax62KSTf0FfpvTlSob5tlZcOep4wi/cDJcG00RE//Lb0vw7
        LTiW6PWw1m2YexhTRcj3Lq2rcw==
X-Google-Smtp-Source: AGRyM1tuqSbXGIu6rm5wyPxQE2UfzSE9MqwTLCvConE6nGgJKrrSNKds72k/sfhx2q2gzMhDllaKrg==
X-Received: by 2002:a05:6638:38a0:b0:331:ec50:d191 with SMTP id b32-20020a05663838a000b00331ec50d191mr9624639jav.40.1655601970398;
        Sat, 18 Jun 2022 18:26:10 -0700 (PDT)
Received: from bnjf.id.au (vm.bnjf.id.au. [34.133.10.104])
        by smtp.gmail.com with ESMTPSA id u15-20020a02aa8f000000b0032b3a781765sm4122335jai.41.2022.06.18.18.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 18:26:09 -0700 (PDT)
Date:   Sun, 19 Jun 2022 01:26:08 +0000
From:   Brad Forschinger <bnjf@bnjf.id.au>
To:     Jeff King <peff@peff.net>
Cc:     Brad Forschinger via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: use builtin test
Message-ID: <Yq57MP47M5fAzkFC@bnjf.id.au>
References: <pull.1260.git.1655197751403.gitgitgadget@gmail.com>
 <YquwpxEoAVWen8tZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YquwpxEoAVWen8tZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 06:37:27PM -0400, Jeff King wrote:
> > The test and [ commands are used throughout the prompt generation.  They
> > also happen to be valid function names that can be defined, leading to
> > unintentional results.  Prevent the somewhat unusual case of this
> > happening by simply using [[, which is reserved.
> 
> Hmm. I do think we need to be a bit more paranoid about style in the
> prompt and completion code, because they are sourced into the user's
> shell alongside whatever other weird customizations they'd have. So we
> already have adjustments to work under "set -u", and so forth.
> 
> But at some point we may say "you have made the environment too hostile
> for us to function". Is redefining "test" to something that doesn't
> behave the same way such a case? Part of me wants to say yes. :)

I'd be inclined to agree!  But disregarding a user with malicious
intent, these environment changes can also be unintentional: I came
across it when I stubbed out a quick test() function while prototyping
something unrelated.

> That said, if it's not _hard_ to support, maybe it is worth doing to be
> on the cautious side? A few thoughts:
> 
>   - my biggest concern on cost is that this is an unusual style for our
>     project (which usually writes in POSIX shell, though of course this
>     file is meant to be bash/zsh specific). Will it be a maintenance
>     burden going forward?

That's possible, but I suspect the burden is minimal.  As you said, this
is bash and zsh specific, and for those shell coders who only write
Bourne dialect it's to be read as a "strong" left square bracket.  For
example, to minimize any shock to the eyeballs I've intentionally not
re-written string operations `[ a = b ] && [ c = d ]` to `[[ a == b && c
== d ]]`.  I promise it wasn't mere laziness!

>   - this only changes git-prompt.sh; doesn't the completion code have
>     the same issue?

It does.  Although there has been some movement towards the
bash-specific builtin:

    $ git show v2.36.1:./git-completion.bash | awk '
      /(^\[|[^[]\[) |\<test\>/ && !++slb || /\[\[ / && !++dlb || 0;
      END { print slb, dlb; }'
    119 15
    $

This can be addressed in a future patch.

>   - I don't write much bash-specific code, but I seem to recall that
>     "[[" has some subtle differences to "[". Is it sufficiently a
>     superset that these conversions are all equivalent?
>
>     I think some like:
> 
> > -	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
> > +	if [[ $pcmode = yes ]] && [[ $ps1_expanded = yes ]]; then
> 
>     are not equivalent, but it's an actual improvement (bash's builtin
>     "[[" isn't confused by unquoted empty variables), but I don't know
>     if there may be other gotchas.
> 
>     (I doubt this is an actual bug in the current code, as $pcmode
>     always seems to be set, but just a more defensive style).

Yeah, there's no word splitting or pathname expansion.  Also, bash4
onwards changed the < and > operators within [[ to locale order rather
than ASCII.

Regards,
Brad
