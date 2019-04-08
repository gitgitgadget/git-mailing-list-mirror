Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4A120248
	for <e@80x24.org>; Mon,  8 Apr 2019 10:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfDHKcY (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 06:32:24 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39653 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHKcX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 06:32:23 -0400
Received: by mail-it1-f193.google.com with SMTP id 139so20063789ita.4
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XovO39ks9MllhmGkWvFR4xWCtvCY2p5M0qETKkZ0tWc=;
        b=JKTZgRhoDLY8DRh/V8lsM+XIP4KpqYnJTuXgCQWNy64R4UoTf6z4XSITQXboFqwpyp
         clXipFujB5BLY6o7EfSYwmJ1LuR6qXKMwQuy7BQ60LIrrtxYbNpjVneo+RVXwrCidMq/
         7sfxSuJKkUM5dvsJKyf5rmorZgyLeVYArpkQHPXfF1K9MQ4iacxpelpASqwxnPJwjrwb
         +ER3LxyzpLI+C/H+xgIwUtdL30+V+9hm3ijoETwdaDE+VeWqZFlQIMOZm8wJU2oKS7yf
         umT/v0vzUdVIhcwdlGn/lBqtwnOMC8kYv+pY3kJ68j7nRLCJgvd5TBDwn6uzLI4Z0Q6+
         AfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XovO39ks9MllhmGkWvFR4xWCtvCY2p5M0qETKkZ0tWc=;
        b=Vly91kCiiRCvoBgWd2tHeOYBqbqtWvRjgs+yJ5Q2mNJKvAQslfx+Dm/JbztVVY/x2m
         v2z0K6zXVN0O3nppzY8UC8uwV9cO60jSjc9o+MyGmEfCMitsz8s7B4uCqY0OdVCJoSI9
         yvYs7we+KPwSWdG5EAcraSNv5JOlN4y8Ezd7A5LGpPJO334Uzs/WpIQcYXYIbPVTMBjd
         s4HC4xvgZKIRovuCft/p1szvJA68mxH1fWQ4EmOZg6N8vLaTbqWlX9sZNvhOHClZDtFR
         kulhEKNplYsyoMkD/O9VHep1DMXnLpCqksf5hDH25Y8vCRJLCQK0/R6O8XMfx1xBFZj6
         nMLQ==
X-Gm-Message-State: APjAAAX81A46SpiPN+wHXn7BpkKwpOmeVB40LVTuBPYwUzbgFRigCo0T
        MKnvdTeCOH5OU6VcrIuVutMWw+X254ol2XdeDwM=
X-Google-Smtp-Source: APXvYqwQ8k3DY5ZqpxCE1afUk3adPZDVF1q8PJi4HEaiOfiQYmT36lhxzwm+Xgxe8AACqJ2y8571MXimW0Zv+QvVO1A=
X-Received: by 2002:a02:c50b:: with SMTP id s11mr21036572jam.84.1554719543201;
 Mon, 08 Apr 2019 03:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEN1x5zDPn4vaZmw3ch-Oy2=NQ=cfF9YmXumcbZGWvTToQ@mail.gmail.com>
 <20190407183857.GA32487@hank.intra.tgummerer.com> <CAMknYEOAg1S8cNYdLPgJemxgikisNpmeuw74T0w+7PUo93stVg@mail.gmail.com>
In-Reply-To: <CAMknYEOAg1S8cNYdLPgJemxgikisNpmeuw74T0w+7PUo93stVg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 8 Apr 2019 17:31:56 +0700
Message-ID: <CACsJy8Dc3fuXWOOO-hNJqGNomufP7bffoHVf5hHLTubHQvq9vA@mail.gmail.com>
Subject: Re: [GSoC][RFC] discussion about stashing with conflicts
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 12:49 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
>
> On Mon, Apr 8, 2019 at 12:09 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 04/07, Kapil Jain wrote:
> > >
> > > what is the use of ce_stage macro ?
> > > tells about stage of an index entry.
> > > if ce_stage says, stage #0 i.e staging area, then that index entry is
> > > in staging area
> > > and nothing needs to be done.
> >
> > I don't quite understand what you mean with "nothing needst to be
> > done" here.  In the context of teaching 'git stash' to handle unmerged
> > index entries, nothing that is not already being done needs to be done
> > with an index entry that is at stage #0.  The current implementation
> > already handles that correctly.
> >
> > > else a temporary index entry is created and repo_read_index_unmerged()
> > > calls other function and tries to add it to index.
> > > if it fails, it issues an error.
> >
> > Not sure what you mean here.  Index entries with higher stages are not
> > temporary, they are written out to the index file, and can then be
> > read back with 'repo_read_index()' for example.
>
> sorry, i failed to provide detailed explanation. below is what i meant.
>
> in repo_read_index_merged(),
> if ce_stage() macro says that this cache_entry is in stage #0 i.e.
> already merged,
> then the function doesn't try to add that entry into index.
>
> if (!ce_stage(ce))
>     continue;
>
> but when it is not in stage #0; the function, creates a temporary cache_entry,
>
> struct cache_entry *new_ce;
> new_ce = make_empty_cache_entry(istate, len);
>
> and tries to add it to index file.
>
> if (add_index_entry(istate, new_ce, ADD_CACHE_SKIP_DFCHECK))
>     return error(_("%s: cannot drop to stage #0"),
>              new_ce->name);
>
> now if this try of adding index entry is successful, then that entry
> is no longer unmerged, right ?
> so can we make `unmerged` variable 0.

There's a big block of comment on top saying return true if unmerged.
As you noticed, after the function returns, there will be no unmerged
entries left anyway. Always returning zero then does not even make
sense.

The main purpose of this function is probably just checking that there
are unmerged entries or not (and return 1 if so). The
add_index_entry() there is probably just to do some more validation.

Sometimes when I don't understand what some code does, I look at "git
log --patch". In this case, there a big explanation in ad3762042a
(read-cache: fix directory/file conflict handling in
read_index_unmerged(), 2018-07-31) that might help you.

Going further back to d147e501f3 (Builtin git-read-tree., 2006-05-23),
you can see that this function has two separate uses. One about the
return code, one about collapsing unmerged entries back to stage zero.
-- 
Duy
