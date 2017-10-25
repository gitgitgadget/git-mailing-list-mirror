Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13AF41FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 04:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdJYE5u (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 00:57:50 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:55744 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdJYE5t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 00:57:49 -0400
Received: by mail-it0-f53.google.com with SMTP id l196so12646624itl.4
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 21:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cQP8EWLo3meq6SfsZP7cKzVBO1kmh+tsEihMBZDSzzw=;
        b=RH4D/8NYRCeI8zj3o8xElWc+foRG4RVDttey63yxEo1WKB9vcAm9WRhVgmTljh5X9b
         DOdZUtHFg14me2C2hF7+sWmt9itGQSANsckCJZm1NvsBF38r7zXiKExLam41Q430fCBj
         MGJ+1twmff6Pj76k2Z8pL75kySjGhLe740aZH7RPh8n4vMbOctmV/mtN8ihPLtQS2hcF
         xyuHkCmhAZYhG3nQ++xmTfTsKWzs+SPT9xWluFQkynprecxpW2893j21pKImyCnBKkiV
         YYcEKKoXFtTE2mw1T3cYrhF3Exl0E2sgZ7NUSUmkdOos4d3+aNa1v0kowScB3XP48OG2
         wK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cQP8EWLo3meq6SfsZP7cKzVBO1kmh+tsEihMBZDSzzw=;
        b=PCKCYfTvWUqcZvF2AZ1bSc9QMlYidg2qhIbWwAykQNd+Wfk6d2vhicjQk/JtTTReRM
         I2KAqe7tMlhjoBDGnUJd4U1e/W0o/sv11yOmeb/3rEuClAgIqltZzASLhsgy4u9FsUxU
         JJ9cyGet+HO3+RooJbWr44xQuvFk35B3LDdiN3vhCN5zT5cWBXBHdjmIrhgUlxt0Au4G
         o+Yipuvj1J3UB2cusjXQFqFmmrkn5uYwig7/FYQpUtisimT777mYebil+bSPkOKzh+vA
         lQfbQsadQa15+SwjrJNf8Vh+pDhC3GDH9tCMcDjdFywLXmCtBAl4AlzESYGqgXQfDfek
         PGpA==
X-Gm-Message-State: AMCzsaVAJk52lG7Yy0hhf0KJxgGDQJAzUHa9UGI4A+ug5LGXOoy8hHDV
        4KOIODwOrymvzEvxNMrm0GzO+HMvlQtObE+DU5ahnHi3oFg=
X-Google-Smtp-Source: ABhQp+TVoVX0lg6/DSLcNL+jEB+CGpqd/qk6nm+zqfvNo1zPStaXtc5DYiqFZjUVeU/gChCG8ZIP7Mk1MBp3yH2wUwA=
X-Received: by 10.36.14.207 with SMTP id 198mr594468ite.66.1508907468147; Tue,
 24 Oct 2017 21:57:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.174.66 with HTTP; Tue, 24 Oct 2017 21:57:47 -0700 (PDT)
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 24 Oct 2017 21:57:47 -0700
Message-ID: <CAGf8dg+8AR=XfSV92ODAtKTNjBnD1+oVZp9rs4Y4Otz_eZyTfg@mail.gmail.com>
Subject: Re: [PATCH 00/13] WIP Partial clone part 1: object filtering
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 11:53 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> I've been working with Jonathan Tan to combine our partial clone
> proposals.  This patch series represents a first step in that effort
> and introduces an object filtering mechanism to select unwanted
> objects.
>
> [1] traverse_commit_list and list-objects is extended to allow
>     various filters.
> [2] rev-list is extended to expose filtering.  This allows testing
>     of the filtering options.  And can be used later to predict
>     missing objects before commands like checkout or merge.
> [3] pack-objects is extended to use filtering parameters and build
>     packfiles that omit unwanted objects.
>
> This patch series lays the ground work for subsequent parts which
> will extend clone, fetch, fetch-pack, upload-pack, fsck, and etc.

Thanks - I've taken a look at all of them except for the partialclone
extension one, which I've only glanced over briefly. Apart from some
style issues (indentation and typedef-ing of enums) I think that they
generally look all right.

One possible issue with using a formatted filter string (e.g.
blob:none) directly passed to the server as opposed to actual
client-interpreted flags (e.g. --blob-byte-limit=0) is that a user may
be confused if the version of Git they're using supports fancier
filters, which will work if they're running rev-list locally, but not
when they're fetching from a not-so-fancy Git server. Maybe that is
fine, though - something we've discussed internally is an ability to
offload some calculations (e.g. git log -S) to Git servers, and if we
end up doing something similar to that, users will need to deal with
this problem anyway.

The reason why I only glanced over the partialclone patch is because I
think that that change needs more discussion than the rest, and it
would be good to get the others in first. I know that you included the
partialclone patch because it is needed by the rev-list one, but as I
commented in the rev-list one, I think that it does not need to be
aware of partial clones, at least for now. The overall ideas in the
partialclone patch seem good, though - in particular, one conceptual
difference from my patch [1] is that the filter setting is a property
of the repository as opposed to the remote, which does seem like an
improvement, because it makes it easier to make and explain e.g. a
"git log --use-repo-filter -S" command that uses the preconfigured
config.

[1] https://public-inbox.org/git/407a298b52a9e0a2ee4135fe844e35b9a14c0f7b.1506714999.git.jonathantanmy@google.com/
