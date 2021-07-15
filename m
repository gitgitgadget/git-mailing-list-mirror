Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35CAC636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F7A6100B
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhGORUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:20:44 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:40654 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhGORUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:20:44 -0400
Received: by mail-ed1-f41.google.com with SMTP id t3so9178801edc.7
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kA8gsDeayuJ+tKfVOve0h+rXdXTN6sUDk57Zg7Dj/9w=;
        b=b7WdedN8kIPm6RsuohTe83P+REHYeyWME2DZ+OXknsjaQ8XR3QdVLRKkBkRGWjzxYW
         d1DQWLTmVqd4Lvyf6xEXTDEMTskjB382IXrCPMYN3Wh015TJES45WS5xNj/7zElPoCax
         OqSf1WanteYX/9kWMp+Xl6UxyJ+Zr0W4uY9HkEBRHyxZgyYL1yCclg6nuTVzHCmOeAM7
         +4pWrNKg+afRICAKE/8+r0sLoh8RlLXQcnd/PpqGp1FB53NaZ4lsV2YsypfFr9qbym+z
         lmy6qlS1vF2qvpnHK2/NcuhVERgHIOsT1KQn2zcWAhxwXJFT3vPGz0hn4wCw/d/Q9ECd
         JthA==
X-Gm-Message-State: AOAM530QbIDOH7liZzjL7lh0DbPLzTnFjiwcc/ztGkwnYmAU1g8QrfIQ
        4LcEJ/FtW8v6c6Lqw4MiPOUylLRJ4ayGC+DHjEM=
X-Google-Smtp-Source: ABdhPJzEQdjlOlaAIxb48bL3yPTRs033PEESfuSYBA9yRZTI/uDSLRWqK8BTdfqM/nI/zuAkZ2JBVeh6yKNOv2jDNUE=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr8518517edu.221.1626369468601;
 Thu, 15 Jul 2021 10:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com> <pull.992.v4.git.1626316350.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v4.git.1626316350.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Jul 2021 13:17:37 -0400
Message-ID: <CAPig+cT6KJ9=9pOS9jiXd0XQYdD0j1aZSyy29WyJ4w3x1dvqhg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] worktree: teach add to accept --reason with --lock
To:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:32 PM Stephen Manz via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The default reason stored in the lock file, "added with --lock", is unlikely
> to be what the user would have given in a separate git worktree lock
> command. Allowing --reason to be specified along with --lock when adding a
> working tree gives the user control over the reason for locking without
> needing a second command.
>
> Changes since v3:
>
>  * Updated test to define a shell variable, lock_reason, set to "why not".
>    Expand the variable to use with --reason and to echo to file, expected.
>    This avoids the spacing comment made by Eric Sunshine.

Thanks, these changes look fine to me. I don't know whether or not
Junio has merged this series down to his "next" branch yet locally,
though. If he has, then he may not pick up your v4, and this minor
cleanup change could instead be done as a standalone patch atop v3 (or
could be dropped since v3 was probably "good enough").

In any case, this series is still Reviewed-by: me.
