Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3BCC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 13:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358240AbhLBNcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 08:32:13 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:40834 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346735AbhLBNcG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 08:32:06 -0500
Received: by mail-pf1-f174.google.com with SMTP id z6so27900895pfe.7
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 05:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcT/LNVJAlD3r4QjYlDVfimiiQRzMglk6JSJYZrWNJE=;
        b=MC9EY0KzOD5YD5rWdmbPTj/GrMpOPEziTBhUXxzNqN1o4KgyPSJpmyQ5ysl/Dx5YZi
         XgtLWKGfD+k1WdvUHKyVu9wxdTD3FEt7ICg6bbCF3eDtdh7NGbcL3kf5q4ms8WqwfhpB
         TOKA3PGKlLiUHwEhoU6vNQVrp6dJVcDSBvwSBM9rBIrEHRR9fJCQHvDVn7zut+5z6CwL
         nx6W0VY/B9t0Nko3vZTCQjZQ/mY34hO0x1yxi8/hCHcB74t+Qb9UGg/4+m9YZJ8ISo8b
         PDiXe+79xkeTYU/f1J49ycKEQ46VLgZ/1lQi0kE+GhxjI218+4RDVdbffh5ebdl1rNMo
         MUzQ==
X-Gm-Message-State: AOAM5325E765n+lafoB0SdW7LRZY1mNjK6IN5/guwgfzqPvGSoYEiFPv
        HPenbIyYP/r6IZA0Ko4c/4I6drjdplQsM7TKLi5ykAbJI98=
X-Google-Smtp-Source: ABdhPJwWUpsHrJZXy04nS3s/Es2g1QUuqYhcUmEqvSasMQurmK+ZjbF4k2aGKrbKyPbG8QdFG/JKrF0HMsCKibZu0Io=
X-Received: by 2002:aa7:9561:0:b0:49f:c8cd:ce6d with SMTP id
 x1-20020aa79561000000b0049fc8cdce6dmr12430179pfq.67.1638451723723; Thu, 02
 Dec 2021 05:28:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1036.v4.git.git.1637028785.gitgitgadget@gmail.com>
 <pull.1036.v5.git.git.1638317108.gitgitgadget@gmail.com> <409ae2bbd85c20a88347a4e1b8afdddcb7c82e5d.1638317108.git.gitgitgadget@gmail.com>
 <df70e408-9355-aff7-c6fe-540b5c687865@gmail.com>
In-Reply-To: <df70e408-9355-aff7-c6fe-540b5c687865@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Dec 2021 08:28:32 -0500
Message-ID: <CAPig+cRh6BLTqCFRkfspZt+7DnDt4is5=w1AUa6UiBtOYKnBBA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] update documentation for new zdiff3 conflictStyle
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 2, 2021 at 3:42 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On 01/12/21 07.05, Elijah Newren via GitGitGadget wrote:
> >       The same as `--merge` option above, but changes the way the
> >       conflicting hunks are presented, overriding the
> >       `merge.conflictStyle` configuration variable.  Possible values are
> > -     "merge" (default) and "diff3" (in addition to what is shown by
> > -     "merge" style, shows the original contents).
> > +     "merge" (default), "diff3", and "zdiff3".
>
> Missing '... (the latter both also shows the original contents)'.

The omission is clearly intentional. The additional text added to the
hunk just above this one (which you snipped), does a better job of
explaining the differences between the styles than this little blurb
did. Moreover, there is insufficient context at this location in the
documentation for a reader to fully understand the difference between
"merge" and "diff3", and the problem of lack of context becomes worse
with the addition of "zdiff3". So, Elijah's choice to drop this blurb
-- leaving just an enumeration of choices -- and elsewhere provide
comprehensive detail about the differences is quite sensible. The
revised text is improved by the loss of the blurb.
