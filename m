Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6738C54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 17:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjAXRMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjAXRMX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 12:12:23 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042C22704
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 09:12:22 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d30so24451386lfv.8
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 09:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RMOx0x9JgaeIk0x9Kb+IaQy+g+mc3UKoLJL91HL3NWM=;
        b=nIcAPoDoD25hENYt2BPZ5Qch+DM0atLd+jFx7zrTSh6Ynn8S340rb7z92bp6Y1nbIv
         XETCAz/PwwH0zG0Zk3rZQmG662FKEZ+wB+c2HIeOxnT/dfdRGduKSpb8ne9BcWQzXCXn
         80JzjkyE8/Abqnt/JrBDX5uSdo7zk4zpFCOYH0EpVjJqwhe6F4knwyFjcM4rWyHJuXVb
         q3964ZnaZfblGQ0p0jvpiFbsxjfWj2SblyRYUDZiVr8cIlayTUtSq91Jfc0bQoSphWtj
         aO89KG5dm4GZaEbfTHDPdmxHbII7U0MXQWDBLYRMYAHRxSijN60WGGobTQ/WbI5uKxR0
         Wa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMOx0x9JgaeIk0x9Kb+IaQy+g+mc3UKoLJL91HL3NWM=;
        b=dhokNzbduKvRXZ89AcHHUUNmoguCLYH/sh+keJJKWQu9rzZNnXSNzFQFctJ5g1HAkq
         4HV0T33gtaDQi9GfeqzM+NWCoV8/+9c0qshb0+8pgJA4pD7jI5jJpu7FFkzaACzqfLiN
         rKN4EsHeHe/PylMqs44U70oL1MQyP+/yY9xl2Ct7odMJEw8GnDagcWSHGSFyjtuF/Hut
         MLeZiJvBFH7P+2Sc2oC43TyfwaMmXHSd/rZsfb5Ud7e52hckrOFTN1iqENhdhhh5wwhc
         4iWTfZEHXdlZ/DkU6vNWig6CrcGxWSHLBmKhvDNItCWkTi29puWt7XrKAPnG7xw9q3Q0
         rt4w==
X-Gm-Message-State: AFqh2kofL8AYFjmVDTmqlaS20RE9X3UJqKl/Wm1Vu84DAFjw6x3JU8Ak
        zGd/ZWzWft6XiHvzW4a+e4DGrqEXnxF1Druiq/U=
X-Google-Smtp-Source: AMrXdXvYxXjLANRy6iEnP9DjUWgg+FO66r9/M5kxUGnjuSHzMUdDi24MUkAsLeuLcbwLOVdf7VQe55x5iLzPeKfjluY=
X-Received: by 2002:a05:6512:3e11:b0:4cb:d46:94b7 with SMTP id
 i17-20020a0565123e1100b004cb0d4694b7mr1437239lfv.405.1674580340144; Tue, 24
 Jan 2023 09:12:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com> <5e4851e611ee18112bd71939ee900e02a8d590c5.1674367961.git.gitgitgadget@gmail.com>
 <759fb313-ce88-4eb7-96c0-4adeb75ca9f9@dunelm.org.uk> <CABPp-BE+wRgjmWknARQpNsdUFjNOz0ND9wgx_-_RTyK+EwJjXA@mail.gmail.com>
 <83d27162-59d4-d8c0-fde3-f522630d024d@dunelm.org.uk> <7b9ee972-2680-2e1b-bef3-201d8a1e4bdd@dunelm.org.uk>
 <CABPp-BHVUc7EdY9z_TPcHspCak6Yc3mfDXUkivj4zq_fJem3SQ@mail.gmail.com> <0418e5b6-8cbd-9dc9-085e-31380beda89b@dunelm.org.uk>
In-Reply-To: <0418e5b6-8cbd-9dc9-085e-31380beda89b@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Jan 2023 09:12:07 -0800
Message-ID: <CABPp-BEwv+cRMOR_-kz_UhfQt1+SGRdhictLmwmq=122LYZaDw@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] rebase: add coverage of other incompatible options
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2023 at 8:48 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 24/01/2023 15:41, Elijah Newren wrote:
[...]
> >> -        /*
> >> -         * --keep-base implements --reapply-cherry-picks by altering
> >> upstream so
> >> -         * it works with both backends.
> >> -         */
> >> -        if (options.reapply_cherry_picks && !keep_base)
> >> +        if (options.reapply_cherry_picks < 0)
> >> +                /*
> >> +                 * --keep-base defaults to --reapply-cherry-picks to
> >> +                 * avoid losing commits when using this option.
> >> +                 */
> >
> > I know you were copying the previous comment, but this comment is
> > really confusing to me.  Shouldn't it read "--reapply-cherry-picks
> > defaults to --keep-base" instead of vice-versa?
>
> Clearly this comment has not been as helpful as I indented it to be. I
> think maybe we should spell out the defaults with and without
> --keep-base. Perhaps something like
>
> default to --no-reapply-cherry-picks unless --keep-base is given in
> which case default to --reapply-cherry-picks

I like that; sounds good to me.

> >> +                options.reapply_cherry_picks = keep_base;
> >> +        else if (!keep_base)
> >> +                /*
> >> +                 * --keep-base implements --reapply-cherry-picks by
> >
> > Should this be --[no-]reapply-cherry-picks, to clarify that it handles
> > both cases?  Especially given how many times I missed it?
>
> This has obviously proved to be confusing. The aim was to explain that
> in order to work with the apply backend "[--reapply-cherry-picks]
> --keep-base" was doing something unusual with `upstream` to reapply
> cherry picks. "--no-reapply-cherry-picks --keep-base" does not do
> anything unusual with `upstream`. I don't think changing it to
> --[no-]reapply-cherry-picks quite captures that. I came up with
>
> To support --reapply-cherry-picks (which is not supported by the apply
> backend) --keep-base alters upstream to prevent cherry picked commits
> from being dropped.
>
> but it really needs to mention that --keep-base also supports
> --no-reapply-cherry-picks in the usual way

Somewhat wordy, but perhaps:

    /*
     * The apply backend always searches for and drops cherry
     * picks.  This is often not wanted with --keep-base, so
     * --keep-base allows --reapply-cherry-picks to be
     * simulated by altering the upstream such that
     * cherry-picks cannot be detected and thus all commits are
     * reapplied.  Thus, --[no-]reapply-cherry-picks is
     * supported when --keep-base is specified, but not when
     * --keep-base is left out.
     */

?
