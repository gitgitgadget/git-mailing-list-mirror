Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5545220248
	for <e@80x24.org>; Mon,  8 Apr 2019 05:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDHFsg (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 01:48:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34869 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfDHFsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 01:48:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id j132so9524061oib.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JYPj0BnmSWv8RHeDxPS7KnwKtXYDkI9LOfAoIs3dDE=;
        b=AmgtgBLc+2K0TFZMGqC6NT+hGQZKXDQ65N8TCgmq4UDq7OCfq4wgKvwUjKvfpyKC1z
         M3ZRVCuK/lA0n7LzT8Z6JdoF6vHWr2DcvVQlzaGjKqXIirXzgWI8ao7u4tlUmY3jfIc1
         9kNVwT5ltD0f7kJ5OIXzvzZphRuNdWteTLsqj/GiLerc+mAk2IoxUZJdy9D9paOeqgFH
         kZB0KQTQ2bQhEEgkZFDL58kAbJFHDqCl3QHQiitpixm4Gfa2KLSRLny9V0g2BvrR2vZk
         ACrb40uyeEjhpJbfWpCNdmY8quneDs53ppvqDRqVG+WhihVmCDPnr8xGnSoRAfuBQhj9
         z8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JYPj0BnmSWv8RHeDxPS7KnwKtXYDkI9LOfAoIs3dDE=;
        b=DtYypU/c79EZe5SKzXP+NiK0HNcmCLpSWzai8vK55BqbIcj/58Yxo7Z2zzA1gr/8rW
         LHAWp10N60nxmKSG4RSil+in0wBV2iB/O7HhiKDN+cyo+MQ0HJAgwUu5w1yL8xw3Wn6J
         Cevm0z7A2anjKWgZyzhfQq/ZMOsHGxi+5AflvUIm8OVXolcM2U4VcAVXFHgzd8m9HGhx
         1G7Qqn2QAq/WlxIi0MmaJmrIlXM062pqZdKMT7BJY6CV/qdYoFDGbQcwTp91f9m6MwoC
         HjV9vCgFqCXOOrQqCipjamQYH/1VlYnYLF9Hm8mJpV0UARCZj8QThLRsYKQNW9yG59oK
         FUdQ==
X-Gm-Message-State: APjAAAXzNRfyyqVPggUH5jkNSPFu3hyComg37/loNpkkmBHxBmqC35ti
        O2/LbjBPc/ZAE6wGMNUxeoRa92KPuvfar7bquwM=
X-Google-Smtp-Source: APXvYqyVIxuRL4L5pgdyiu/EtfavK1nyP7ZqverAnFEruu8MLOCYcx2C7hDD3vYtwQ0R4opO9itBacaIi172llqdip0=
X-Received: by 2002:aca:e58b:: with SMTP id c133mr14706537oih.119.1554702514816;
 Sun, 07 Apr 2019 22:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEN1x5zDPn4vaZmw3ch-Oy2=NQ=cfF9YmXumcbZGWvTToQ@mail.gmail.com>
 <20190407183857.GA32487@hank.intra.tgummerer.com>
In-Reply-To: <20190407183857.GA32487@hank.intra.tgummerer.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Mon, 8 Apr 2019 11:18:23 +0530
Message-ID: <CAMknYEOAg1S8cNYdLPgJemxgikisNpmeuw74T0w+7PUo93stVg@mail.gmail.com>
Subject: Re: [GSoC][RFC] discussion about stashing with conflicts
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 12:09 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 04/07, Kapil Jain wrote:
> >
> > what is the use of ce_stage macro ?
> > tells about stage of an index entry.
> > if ce_stage says, stage #0 i.e staging area, then that index entry is
> > in staging area
> > and nothing needs to be done.
>
> I don't quite understand what you mean with "nothing needst to be
> done" here.  In the context of teaching 'git stash' to handle unmerged
> index entries, nothing that is not already being done needs to be done
> with an index entry that is at stage #0.  The current implementation
> already handles that correctly.
>
> > else a temporary index entry is created and repo_read_index_unmerged()
> > calls other function and tries to add it to index.
> > if it fails, it issues an error.
>
> Not sure what you mean here.  Index entries with higher stages are not
> temporary, they are written out to the index file, and can then be
> read back with 'repo_read_index()' for example.

sorry, i failed to provide detailed explanation. below is what i meant.

in repo_read_index_merged(),
if ce_stage() macro says that this cache_entry is in stage #0 i.e.
already merged,
then the function doesn't try to add that entry into index.

if (!ce_stage(ce))
    continue;

but when it is not in stage #0; the function, creates a temporary cache_entry,

struct cache_entry *new_ce;
new_ce = make_empty_cache_entry(istate, len);

and tries to add it to index file.

if (add_index_entry(istate, new_ce, ADD_CACHE_SKIP_DFCHECK))
    return error(_("%s: cannot drop to stage #0"),
             new_ce->name);

now if this try of adding index entry is successful, then that entry
is no longer unmerged, right ?
so can we make `unmerged` variable 0.

> >
> > 1) in repo_read_index_unmerged(), why don't we make the value of
> > `unmerged` 0, if adding index entry is successful; as the entry is no
> > longer unmerged ?
>
> Because the caller often wants to know if the index is unmerged in the
> first place, and would refuse to operate on such an index.  Read the
> comment documenting the function again, that explains this very
> nicely.  Then see how some callers actually use the function, and
> you'll see that they actually don't care about dropping the entry to
> stage 0,

>but they care about knowing whether the index is unmerged or
> not.

if they care about whether the index *is* unmerged, and that call to
add_index_entry()
is successful, then index is no longer unmerged (at least because of
that index_entry).
is it possible that they care about if index *was* unmerged ?


> So the question is, did you read this function in depth and understand
> what it does?  If you want to validate your understanding of the
> function, try to repeat what it does in your own words, and ask for us
> to correct you.

upcoming mail will do so.
