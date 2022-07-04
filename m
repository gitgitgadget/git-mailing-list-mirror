Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8360C43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 16:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiGDQ7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 12:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGDQ7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 12:59:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E91921B0
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 09:59:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x10so5058521edd.13
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/GEyYNg3ndcpvW3rvrL0tFVuIEjI5jrHsTbLBF6iX8=;
        b=XOSZXnAvGr9tnkqaIjSfw96080tgUPsIqrG3zpHvxS1P/CzcqH3UiSYlGf52X85Ns9
         kXe4CJUqHw9HEbrtm3vhPTrwZ/HaB0NII4JDngJImT9x58PJuOfGnRfWccshw1tJCjP8
         QdEeRILyAZiT0cdLoMYdC85WLItIt51x/XXLXNVB6HP2DzJf+T5ZvORnM82stwTahnaN
         eR7Ni+No4na9XbfwOo1upLRhxR3unuCsZKguLqVAp41VQ+DLZrGTF1pdAj5bVHOi8s1d
         8B+/aLXo0s24iLyywZ9Fx0/tm1Oqe5nywoczlaHXFdZokgX+XZvgjfVncsgQK6uujtcx
         0tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/GEyYNg3ndcpvW3rvrL0tFVuIEjI5jrHsTbLBF6iX8=;
        b=sRIziT8BSdNoLsuIsZWg9x+RyyUMD31DUtlD1pyrHM5dN/bYeeThwSQYIwaAl96uhv
         3V9WdaiKNedhCo3gzlP99PE6yEBp9jjyhHDf3gdweIbzMraZ3xPmfYTHEuUqNxLuh7z4
         oaOEUI1tUTy4X+7G8AalOLaQghZB64+uJPdYy7AYYeW3uTji5mR8dJqJUfX7tWhzGQ9i
         8GsIyzVNPhFnDE78O4gbSly1KdMv4e2W9wigE918v027CQ3fwIVpismO16SGsPYOJWcc
         3ZZSjZ6Au/1Eijdw5qZMW+1/2RkBgE9wr1T77mXb4blhq09d4DLo9vv5/0WsgZIfjg+P
         j2RQ==
X-Gm-Message-State: AJIora+kXOiIJat/tceza4UxCi6YsM6QktWsDAukRtIiyO7EBMhamrjW
        LXxsPcvJ9Lt6y0lumJpy6tdACgFBzU9HIkn97lN5IHCnE1Y=
X-Google-Smtp-Source: AGRyM1s+qRXQNO7QPwtHkMJckIgyofSLr4T66Z8+qI8SPxQRUmSJFWEPngUte0+3zK+jYHq/M901HHjq3ZDfbmCvW74=
X-Received: by 2002:a05:6402:27cf:b0:435:dae6:26aa with SMTP id
 c15-20020a05640227cf00b00435dae626aamr40044501ede.323.1656953940004; Mon, 04
 Jul 2022 09:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo7y85t44.fsf@gitster.g> <15631ea2-6722-fd24-c8a6-0cee638b0602@github.com>
In-Reply-To: <15631ea2-6722-fd24-c8a6-0cee638b0602@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Jul 2022 09:58:48 -0700
Message-ID: <CABPp-BEHj6gXe+GNR8cw+UUG27E0Mn-wiBb=Dp=ZgX_2gT915w@mail.gmail.com>
Subject: Re: ds/rebase-update-re (was Re: What's cooking in git.git (Jul 2022,
 #01; Fri, 1))
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 4, 2022 at 6:26 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 7/1/22 5:08 PM, Junio C Hamano wrote:
>
> > * ds/rebase-update-ref (2022-06-28) 8 commits
> >  - rebase: add rebase.updateRefs config option
> >  - rebase: update refs from 'update-ref' commands
> >  - rebase: add --update-refs option
> >  - sequencer: add update-ref command
> >  - sequencer: define array with enum values
> >  - rebase-interactive: update 'merge' description
> >  - branch: consider refs under 'update-refs'
> >  - t2407: test branches currently using apply backend
> >  (this branch uses ds/branch-checked-out.)
> >
> >  "git rebase -i" learns to update branches whose tip appear in the
> >  rebased range.
> >
> >  Will merge to 'next'?
> >  source: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
>
> Please expect at least one more re-roll. Here are the things I
> intend to fix in the next re-roll, which should arrive sometime
> this week.
>
> * Some commit message tweaks.
> * Actually interrupt 'git bisect' and 'git rebase' in the tests.
> * Be careful to update the update-refs file when the user edits
>   the todo file.
> * Consider storing the "before" values in the update-refs file
>   and removing refs whose update-ref steps were removed by the
>   user.

First half sounds good to me.  Not sure I understand the second half
about "removing refs"; do you mean actually deleting the ref, or just
not updating it, or something else?

> * Elijah had a question about focusing on "pick" actions, not
>   "fixup" or "squash" steps. This might be worth marking the
>   option as experimental so we have flexibility in changing the
>   behavior as new workflows are tested against this option.

This sounds good to me.  I do sometimes want to fixup or squash into a
commit that a branch I depend upon directly points to, so I'm worried
your feature may update refs incorrectly without this support.

> * Elijah also had some optimization ideas, but I'm not sure if
>   we should prioritize them here or have them as future
>   improvements after the feature is stable.

You know, thinking about it more, with every single commit, sequencer
already updates the index, the working tree, HEAD, and *several*
control files.  So these optimizations would probably just be lost in
the noise.  Unless we restructure sequencer.c, it may not be worth
implementing these ideas at all.  Either way, I'd say this certainly
shouldn't hold up this series.
