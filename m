Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9D7C12002
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 00:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83087613EB
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 00:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGQARy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 20:17:54 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:34363 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGQARx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 20:17:53 -0400
Received: by mail-ed1-f43.google.com with SMTP id ec55so15133358edb.1
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 17:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJTwup/LmsQ0KlGrn7pEA/v7S8gs0H5r1lCA7d2tvy0=;
        b=W0pwwAcV40XbcdAjvAVlDdjce9URnZ4aBmeK7j181fBT63aZgLwc2aVC4l93PuWgV4
         Q7nHsxlfC9qXdDcb9iPmvx4DlTanhie8dnp8lUSG2OCYxqRjAMwzOsAk/QhC5Cq/7H55
         H3KwAaw2cn+/ByFdFLjWLyClclh5wznZPrueNTwX8zbfgv9LMI0+eSd1WX57Jf1BYUz1
         sL6twM9QwuugvHDrWUiY1dvX/uXBS5R2IsI/p5X3EaUuNhAKmOtgTEiKnfnRH+SNLDXU
         yKq8RIaATur6J32eh+mHyzB+ZLqELTnmOgFSRNxbaIsgCpIHV7IpLysbZZTVTC7DJop7
         Wvag==
X-Gm-Message-State: AOAM5321sr0bNWPfv3LSyq+ezSLlfqmVEnYYb946mzR2KWV4bEkoOhHr
        hKoY/dBrVaqCtoYbVmjq9zKGDYI6uYc01doApn0=
X-Google-Smtp-Source: ABdhPJzQcf69E5TTtm1iye24pC7j6WrVNZUZtg14rDjFTM7NNwk0KJW76HfeRw4lgpS9x05tPE9R55Mo+93DO25pMw4=
X-Received: by 2002:a05:6402:d7:: with SMTP id i23mr18005092edu.291.1626480896482;
 Fri, 16 Jul 2021 17:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
 <pull.992.v4.git.1626316350.gitgitgadget@gmail.com> <CAPig+cT6KJ9=9pOS9jiXd0XQYdD0j1aZSyy29WyJ4w3x1dvqhg@mail.gmail.com>
In-Reply-To: <CAPig+cT6KJ9=9pOS9jiXd0XQYdD0j1aZSyy29WyJ4w3x1dvqhg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 16 Jul 2021 20:14:45 -0400
Message-ID: <CAPig+cSmkrQDDWgU-RTbAaswaGsG1xxgvOjxHjLc-8Bwgqk8wg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] worktree: teach add to accept --reason with --lock
To:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 1:17 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jul 14, 2021 at 10:32 PM Stephen Manz via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Changes since v3:
> >
> >  * Updated test to define a shell variable, lock_reason, set to "why not".
> >    Expand the variable to use with --reason and to echo to file, expected.
> >    This avoids the spacing comment made by Eric Sunshine.
>
> Thanks, these changes look fine to me. I don't know whether or not
> Junio has merged this series down to his "next" branch yet locally,
> though. If he has, then he may not pick up your v4, and this minor
> cleanup change could instead be done as a standalone patch atop v3 (or
> could be dropped since v3 was probably "good enough").

It looks like Junio did pick up v4, so no need for a standalone
cleanup patch atop v3.
