Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FB0C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 01:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiCLCAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 21:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLCAI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 21:00:08 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7627CD58
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 17:59:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id d10so22598702eje.10
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 17:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znM0zoj3k9wiCjguiF/OM5HZ0oatQ2tDi7e7ofmmycU=;
        b=Y9DhUsMT3c2sv58ohC82ppXlwKjPvFsw/aVO7boi+83cfgtaXopM1loOQbm73/DFv6
         H4gppeqHZkv1uWlCW3aXWQl70uDoj/0TzW9uAFTzNr1J9kf45Q9QQuhaSbcjWwRXznz/
         LAaEg5WGb0bkFK3x0PVQSGexMQ5G+SbfqV2i47IvnHYSA2gIq+zX52jtP2vCT/7c/OsX
         8TPLhcY9UZWLn7f2oq8yhXrsYM34CcdkVQUpVBvM4qrZVQiAatHxwnztMXjS+8SdYGlM
         Caqt3nrZqT03fNZN14uREKggenR5qXdXYApX0VenGPorkEG96EecVctgCvbYgHwA2b+A
         Iolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znM0zoj3k9wiCjguiF/OM5HZ0oatQ2tDi7e7ofmmycU=;
        b=wQuGnBbT+HETPmskaNrx0eoK+GD6zqxOGDQzqpw2ijFAjwfpjLLy2ueXZZzPGrlH90
         1PBtXU9hR/p5dvptI2GQfLby17quuWLLdPjP+8QrxQBqei7wCqbGJM1UV4v/Bcg9qrQQ
         TVQxCZxdqDdi/ri9U099AgGZIgClnEZiVrCklkVrwIX9McnMXg14N4AJMHfKN+zYwmYI
         E+2Fkv8A8bEd50Prze+n8CpNMyTNN89keRlHhF4QuNvt1eK1pAq7ecLROPJNzxfwMTBb
         uDkzTbiJ/zuh+0IXegenB2zzN/0yV6cffYXhn527y9v4oC6M9NhQueQaQ9tPz2b65wG0
         K9DA==
X-Gm-Message-State: AOAM5339znGb3i1RiQfUn3XOFETlZkwI+vzooc+tQNfi/M0MPnKPKrhg
        /j0H2gM1fZIht3Th4AkUo46FFPuJuaTPQNKwMGs=
X-Google-Smtp-Source: ABdhPJwVnOjCr484Uh/qN3AO/fvb+a1G5BHiX0J2+x2e+LlUhFNxgaQyloQ/XcJaqGW5zGUX0+3fAsdhKAhMFwEkhjc=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr11210788eje.328.1647050342061; Fri, 11
 Mar 2022 17:59:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <3265f41bcab7202991da5a7a160a85820fbff0c4.1646725188.git.gitgitgadget@gmail.com>
 <5c59964a-a3ce-3723-8044-16727d9d3170@github.com>
In-Reply-To: <5c59964a-a3ce-3723-8044-16727d9d3170@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Mar 2022 17:58:50 -0800
Message-ID: <CABPp-BGfke=t99wY2OQuG3SnbFhRd1zpPFW8JqEBN-wANgVM1A@mail.gmail.com>
Subject: Re: [PATCH 6/9] git-sparse-checkout.txt: add a new EXAMPLES section
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 8, 2022 at 6:30 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 3/8/2022 2:39 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Since many users like to learn from examples, provide a section in the
> > manual with example commands that would be used and a brief explanation
> > of what each does.
>
> Examples are great!
>
> > +`git sparse-checkout reapply`::
> > +
> > +     It is possible for commands to update the working tree in a way
> > +     that does not respect the selected sparsity directories, either
> > +     because of special cases (such as hitting conflicts when
> > +     merging/rebasing), or because some commands didn't fully support
> > +     sparse checkouts (e.g. the old `recursive` merge backend had
> > +     only limited support).  This command reapplies the existing
> > +     sparse directory specifications to make the working directory
> > +     match.
>
> This focuses on how a Git command might cause extra data, but it
> doesn't mention how other tools might create ignored files outside
> of the sparse-checkout and this will clean them up. Do you want to
> add that, or do you prefer focusing on just Git reasons?

Does that happen in a significant number of cases?  Prior to
en/present-despite-skipped, it was essentially a null set of cases.
After it, we'd need:
   * the file to be tracked (reapply doesn't touch untracked or ignored files)
   * the file to have been SKIP_WORKTREE prior to the other tool modifying it
   * the file has to have its contents match what is staged in the index
and then reapply would clean the file out.

I guess there is kind of a converse case of someone manually removing
the SKIP_WORKTREE bit via direct manipulation using `git update-index
--no-skip-worktree $PATH` and removing the file locally, and then
using `reapply` to get it back, but that seems like a really unlikely
usecase.


 Maybe if I just made a simple tweak to the wording:

...selected sparsity directories. This can come from tools external to
Git writing files, or even affect Git commands because of either
special cases...

does that sound good?  I'll submit a re-roll with that but I'm open to
alternative wordings.
