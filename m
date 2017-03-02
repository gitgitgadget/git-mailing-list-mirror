Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2462023D
	for <e@80x24.org>; Thu,  2 Mar 2017 01:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932083AbdCBBpm (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 20:45:42 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:37469 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753448AbdCBBpl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 20:45:41 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so42850071ith.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 17:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=v3INCOTasL+/XEN8tnmOHDIAczvrmKibHkO2Zh0q6gE=;
        b=FyGKk1KcETBp8VtoYkc6p9085iTm4OdPcJLI16NkwFZ4sHCA/FwcZPZtDXLPkvKRA5
         Xtllc+1ewtqU53QxI97TCbvLFl2LQsRVWy+0hgXq91pCP9L1UKT7yBdGIMsLaAaHPQKj
         blWIHSRf+kZQzCN8YNd0jSXO72lf8MjYyn30ShwBMNltGGKbEuUk4i1sjaltA/KvqryT
         u/FvNv5HmcNsJlUTMimxTpCZQaSNVb9hFk2G6sTd5J+3LVYHOsRJXWVVJdBabnuWPlMX
         +iaUSMoiWsrp9MF4LPxBR0R4sRQlbuc72vrP8cM4HZEn0B7EV6Foww71UHfbj31NfvAY
         jzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=v3INCOTasL+/XEN8tnmOHDIAczvrmKibHkO2Zh0q6gE=;
        b=cSoWXwDuaTvqX6mSC4Cy5QF/0i0Fom4seAIQOz9yZ9/5wtVfhhoT1I3c0orZQE+t7A
         AFatw2EPAlSXtkAE7Nth+j2/skPXVKOxvnpOzb4xfULm+jl+CQJsRsk92xVplnHIEbhG
         0JBJCpQlPRqFJJNEQyWhmVopwnFagdA7b1YWGbXLCNpab4xikP7PApwaSPy5Tce66J/9
         gYCAO/jCFZsFPJQLvfZ/DKfUoXj2CdNBH8LrJ5zLzEvVKFQvkTkBOHSRdBNrh/kefXde
         powenQB9XIx94WUGjuiHh6egCWhMsjvlfQVnLJreAimkThGXY/mWCFPxbwy4CStAvxDK
         uF8w==
X-Gm-Message-State: AMke39nPuvP4RRS+OSPeWFXxGbswiEzrwx9cuvgSZpf9SDwFgTB3hTv6bra7V/QRh2KIYezKkDq3aScrx8gQZg==
X-Received: by 10.36.225.13 with SMTP id n13mr7593732ith.114.1488415404945;
 Wed, 01 Mar 2017 16:43:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Wed, 1 Mar 2017 16:43:24 -0800 (PST)
In-Reply-To: <603afdf2-159c-6bed-0e85-2824391185d1@gmail.com>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
 <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com>
 <eba83461-34cf-6d64-4013-873b04af9b82@gmail.com> <CA+55aFx7QFqrHw4e72vOdM5z0rw1CCkL2-UX8ej5CLSBWjLNLA@mail.gmail.com>
 <603afdf2-159c-6bed-0e85-2824391185d1@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2017 16:43:24 -0800
X-Google-Sender-Auth: IRb3XcJjGnlccE5oZtdYjhsYe3M
Message-ID: <CA+55aFxxQUixAJWXkUgVvDNCHD4LuYYuQRTE7dJ_OZTo9Gxqew@mail.gmail.com>
Subject: Re: Delta compression not so effective
To:     Marius Storm-Olsen <mstormo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 4:12 PM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>
> No, the list of git verify-objects in the previous post was from the bottom
> of the sorted list, so those are the largest blobs, ~249MB..

.. so with a 6GB window, you should easily sill have 20+ objects. Not
a huge window, but it should find some deltas.

But a smaller window - _together_ with a suboptimal sorting choice -
could then result in lack of successful delta matches.

> So, this repo must be knocking several parts of Git's insides. I was curious
> about why it was so slow on the writing objects part, since the whole repo
> is on a 4x RAID 5, 7k spindels. Now, they are not SSDs sure, but the thing
> has ~400MB/s continuous throughput available.
>
> iostat -m 5 showed trickle read/write to the process, and 80-100% CPU single
> thread (since the "write objects" stage is single threaded, obviously).

So the writing phase isn't multi-threaded because it's not expected to
matter. But if you can't even generate deltas, you aren't just
*writing* much more data, you're compressing all that data with zlib
too.

So even with a fast disk subsystem, you won't even be able to saturate
the disk, simply because the compression will be slower (and
single-threaded).

> Filenames are fairly static, and the bulk of the 6000 biggest non-delta'ed
> blobs are the same DLLs (multiple of them)

I think the first thing you should test is to repack with fewer
threads, and a bigger pack window. Do somethinig like

  -c pack.threads=4 --window-memory=30g

instead. Just to see if that starts finding deltas.

> Right, now on this machine, I really didn't notice much difference between
> standard zlib level and doing -9. The 203GB version was actually with
> zlib=9.

Don't. zlib has *horrible* scaling with higher compressions. It
doesn't actually improve the end result very much, and it makes things
*much* slower.

zlib was a reasonable choice when git started - well-known, stable, easy to use.

But realistically it's a relatively horrible choice today, just
because there are better alternatives now.

>> Hos sensitive is your material? Could you make a smaller repo with
>> some of the blobs that still show the symptoms? I don't think I want
>> to download 206GB of data even if my internet access is good.
>
> Pretty sensitive, and not sure how I can reproduce this reasonable well.
> However, I can easily recompile git with any recommended
> instrumentation/printfs, if you have any suggestions of good places to
> start? If anyone have good file/line numbers, I'll give that a go, and
> report back?

So the first thing you might want to do is to just print out the
objects after sorting them, and before it starts trying to finsd
deltas.

See prepare_pack() in builtin/pack-objects.c, where it does something like this:

        if (nr_deltas && n > 1) {
                unsigned nr_done = 0;
                if (progress)
                        progress_state = start_progress(_("Compressing
objects"),
                                                        nr_deltas);
                QSORT(delta_list, n, type_size_sort);
                ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
                stop_progress(&progress_state);


and notice that QSORT() line: that's what sorts the objects. You can
do something like

                for (i = 0; i < n; i++)
                        show_object_entry_details(delta_list[i]);

right after that QSORT(), and make that print out the object hash,
filename hash, and size (we don't have the filename that the object
was associated with any more at that stage - they take too much
space).

Save off that array for off-line processing: when you have the object
hash, you can see what the contents are, and match it up wuith the
file in the git history using something like

   git log --oneline --raw -R --abbrev=40

which shows you the log, but also the "diff" in the form of "this
filename changed from SHA1 to SHA1", so you can match up the object
hashes with where they are in the tree (and where they are in
history).

So then you could try to figure out if that type_size_sort() heuristic
is just particularly horrible for you.

In fact, if your data is not *so* sensitive, and you're ok with making
the one-line commit logs and the filenames public, you could make just
those things available, and maybe I'll have time to look at it.

I'm in the middle of the kernel merge window, but I'm in the last
stretch, and because of the SHA1 thing I've been looking at git
lately. No promises, though.

                   Linus
