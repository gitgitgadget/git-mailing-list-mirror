Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8D51F97F
	for <e@80x24.org>; Tue,  9 Oct 2018 21:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJJEtH (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 00:49:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45129 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJEtH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 00:49:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so3370985wrw.12
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BqY1zBhBJTEKKmWxvy/0cEZICUfmzvmbBpoNEGlO88c=;
        b=IO9UlhmbNiHyYPQjMjWOnBuDwEByYQDkIq+D9CNptDgzVRXjT05Cjkjj6ZuK6DozrI
         VHx+Vc4Apf6tlJcNXFCMH1rByG/463LwkdSOZj2sPiu4BAJ8h5pH5waWzzkMxIo08DW3
         Bj8ZZDT1kgBqmkHjleUwDtI6TFkU8RoyOrDZTJR1F/78fy+uBBj9B960Cm78WBkAKvPR
         WadHbX4Lym26+x2FxW/IPN4aeqnO8LC/beP+YI+DD6d0DILUR7Mj9gmDAAIrQg6TphZk
         kF5W8Mk4K465cZii3xnSTGz9drij4u7IYhKxniFxPFpq1pWM+2qiaoRVmpUm3x3GZl63
         +zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BqY1zBhBJTEKKmWxvy/0cEZICUfmzvmbBpoNEGlO88c=;
        b=J7D2kluuamF+sd2NxTW97cOcxSsQ1jR9aA10zJF4DjqoPmz9qsepoPbDixPyabP7C5
         oYPkyHkEeQnJF4NU/xYA2FfpevwOpJ2KIOZyOctPuYwZPeEgDYvJikzo1bmTfAWaWzRl
         SPnTIy/2SggdjbWEhNL8cwgQXUU8uvEo5QwiCDkL3zVtdrr7J+tbNgLM27Mi1CUQ3t2D
         Me2UurAhJHB/EGaL0iKtVCAPpHA6pRaCd+mrhJJYZWJPlCnwlTfYOI2GOeN3gX/UsP3l
         kaFhC9RLNfa+zKEFPaKChTBc1sFlamZ732VZVIS97pg+hT91w+kBkKGziVCsAP7xCoKc
         su/w==
X-Gm-Message-State: ABuFfoiZzrfH9IXgOwMOAs4XABfIomZuuVFnVkAWRG3lvMZCY7dsBcwE
        vOaspvx+6xexeorUI0T5f6U=
X-Google-Smtp-Source: ACcGV61hCNHkr8B36akcfC3cjirtC2COvKIPInMyQjFQbik9UOk0SQ8TMOdzEjEbO0NOnAgsE8SR0A==
X-Received: by 2002:adf:bc13:: with SMTP id s19-v6mr22753761wrg.255.1539120610812;
        Tue, 09 Oct 2018 14:30:10 -0700 (PDT)
Received: from szeder.dev (x4dbd5132.dyn.telefonica.de. [77.189.81.50])
        by smtp.gmail.com with ESMTPSA id x139-v6sm26085740wme.3.2018.10.09.14.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:30:09 -0700 (PDT)
Date:   Tue, 9 Oct 2018 23:30:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181009213007.GB23446@szeder.dev>
References: <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
 <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
 <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
 <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
 <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181008181015.GA23446@szeder.dev>
 <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
 <20181009030803.GA6250@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009030803.GA6250@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 08, 2018 at 11:08:03PM -0400, Jeff King wrote:
> I'd have done it as one fixed-size filter per commit. Then you should be
> able to hash the path keys once, and apply the result as a bitwise query
> to each individual commit (I'm assuming that it's constant-time to
> access the filter for each, as an index into an mmap'd array, with the
> offset coming from a commit-graph entry we'd be able to look up anyway).

I used one big Bloom filter for the whole history, because that was
the simplest way to get going, and because I was primarily interested
in the potential benefits instead of the cost of generating and
maintaining it.

Using a 8MB filter for git.git results in a false positive rate
between 0.21% - 0.53%.  Splitting that up for ~53k commits we get ~160
bytes for each.  On first sight that seems like rather small, but
running a bit statistics shows that 99% of our commits don't change
more than 10 files.

One advantage of the "one Bloom filter for each commit" is that if a
commit doesn't have a corresponding Bloom filter, then, well, we can't
query the non-existing filter.  OTOH, with one big Bloom filter we
have to be careful to only ever query it with commits whose changes
have already been added, otherwise we can get false negatives.

> I think it would also be easier to deal with maintenance, since each
> filter is independent (IIRC, you cannot delete from a bloom filter
> without re-adding all of the other keys).

Accumulating entries related to unreachable commits will eventually
increase the false positive rate, but otherwise it won't cause false
negatives, and won't increase the size of the Bloom filter or the time
necessary to query it.  So not deleting those entries right away is
not an issue, and I think it could be postponed until bigger gc runs.

[...]

> But there's also a related question: how do we match pathspec patterns?
> For a changed path like "foo/bar/baz", I imagine a bloom filter would
> mark all of "foo", "foo/bar", and "foo/bar/baz".

Indeed, that's what I did.

> But what about "*.c"? I
> don't think a bloom filter can answer that.

Surely not, but it could easily return "maybe", and thus simply fall
back to look at the diff.

However, I've looked through the output of

  grep '^git log[^|]*[\[*?]' ~/.bash_history

and haven't found a single case where I used Git's globbing.  When I
did use globbing, then I always used the shell's.  Yeah, just one data
point, and others surely use it differently, etc...  but I think we
should consider whether it's common enough to worry about and to
increase complexity because of it.

[...]

> So let's imagine we'd store such a cache external to the regular object
> data (i.e., as a commit-graph entry). The "log --raw" diff of linux.git
> has 1.7M entries. The paths should easily compress to a single 32-bit
> integer (e.g., as an index into a big path list). The oids are 20 bytes.
> Add a few bytes for modes. That's about 80MB. Big, but not impossibly
> so. Maybe pushing it for true gigantic repos, though.

In my experiments with the Linux repo a 256MB Bloom filter has ~0.3%
false positive rate, while a 128MB filter had 3-4%.  Even bigger,
though compared to the size of the checkout of the full kernel tree,
arguably not that much.

> Those numbers are ignoring merges, too. The meaning of "did this commit
> touch that path" is a lot trickier for a merge commit, and I think may
> depend on context. I'm not sure how even a bloom filter solution would
> handle that (I was assuming we'd mostly punt and let merges fall back to
> opening up the trees).

During revision walking rev_compare_tree() checks whether the given
paths changed between a commit and _one_ of its parents, and in case
of merge commits it's invoked multiple times with the same commit but
with different parent parameters.  By storing (changed-path,
parent-oid, commit-oid) tuples in the Bloom filter it can deal with
merges, too.

