Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7281FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbcLEKDZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 05:03:25 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35121 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbcLEKDX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 05:03:23 -0500
Received: by mail-io0-f194.google.com with SMTP id h133so13298576ioe.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 02:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CxEZunE4etf5kBJuFWw9DMDvBlKe/lNLe/ieO8Q5qQ4=;
        b=c0294auZ2qdFZ8JahBubFAaHOPpJ0/JhBOlhxPLjCnVAXORZ9VCdAuOdV2WPDxFp7P
         FEfmcXbEWZnuDmNl1OYekNFJ0dCVoICciUc541Fnsbr/OQlN5iUmAeQ5sQajFnjwtGz5
         JFZ9cbmsJBHsO3ydRNFpmfImjsgXJouXvSsg8gey+rpfKKavgGmtxDOvjPaAvDScflkX
         GbPpnWPoX6uAm37S3R5xW+IZHJcGn71RYvzfOpfFAwALAoEVj1elAZPw84ug80HKl5yF
         8SDPW3c8zISp778Z9NeaVu4axqhWXIaaGsqhQgy6tlE0N6yKhaBcZOHWUEXNaYunELdj
         w+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CxEZunE4etf5kBJuFWw9DMDvBlKe/lNLe/ieO8Q5qQ4=;
        b=jE0eRgRhgqYoCAjmUjHI2jZQjvgeyfI36AWvgNeorVy0NA1nDXSc/lPPOQxKxWg4G5
         swBih3Cvi2fGi/6T5+J676ETsKQx/5dD2pNepRbEZ/Hllb6jl2mUX4VbDfAsm6C16egm
         mQ30UN5Cq0XpX3aUZSO+xYYbJVE5cXGv7dz5B7cIzxez7wr2cWLg+eHicUZG1P4LF1gi
         o1Ks24IfpBuRRk8S7lq/zgnGXM1m9BzKWNzuEpEDkXM1TLvfSnEO4oFetkRXx3Sw+jIt
         N0XJ6/A1sK9gAqjccJJEzD9ip4ySS5Noc6rHlI5pWuAUhx6JfLxKAU3XbaptodXe8QB6
         MMNw==
X-Gm-Message-State: AKaTC02mhhm+2pDu6HRNSEtVuxx7O1UpbOj+ksfjvUdNOwblwbOnh/TNz4JHPXP6DMwUt+O5tJDqwN7SMa4H4w==
X-Received: by 10.36.26.148 with SMTP id 142mr7580922iti.74.1480932202624;
 Mon, 05 Dec 2016 02:03:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 5 Dec 2016 02:02:52 -0800 (PST)
In-Reply-To: <20161203051454.vp772xtto5ddxe7g@sigill.intra.peff.net>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk> <20161203051454.vp772xtto5ddxe7g@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Dec 2016 17:02:52 +0700
Message-ID: <CACsJy8CMd3bnLFuJhkC7u3JO5dLOq6tOwLJXLsJmHgwXi+2FQw@mail.gmail.com>
Subject: Re: [PATCH 1/4] shallow.c: make paint_alloc slightly more robust
To:     Jeff King <peff@peff.net>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 3, 2016 at 12:14 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 02, 2016 at 09:31:01PM +0100, Rasmus Villemoes wrote:
>
>> I have no idea if this is a real issue, but it's not obvious to me that
>> paint_alloc cannot be called with info->nr_bits greater than about
>> 4M (\approx 8*COMMIT_SLAB_SIZE). In that case the new slab would be too
>> small. So just round up the allocation to the maximum of
>> COMMIT_SLAB_SIZE and size.
>
> I had trouble understanding what the problem is from this description,
> but I think i figured it out from the code.
>
> Let me try to restate it to make sure I understand.
>
> The paint_alloc() may be asked to allocate a certain number of bits,
> which it does across a series of independently allocated slabs. Each
> slab holds a fixed size, but we only allocate a single slab. If the
> number we need to allocate is larger than fits in a single slab, then at
> the end we'll have under-allocated.

Each bit here represents a ref. This code walks the commit graph and
"paints" all commits reachable by the n-th ref with the n-th bit,
stored in the commit slab. But because the majority of commits will
have the same bitmap (e.g. when you exclude tag ABC and nothing else,
then all commits from ABC will have the same bitmap "1"), it's a waste
to allocate the same bitmap per commit (and it's also inefficient to
let malloc allocate 1 bit). I tried to reduce the memory usage: if the
a commit and its parent has the same bitmap, and the slab pointer of
the child commit points to the memory of the parent's, no extra
allocation is done. This manual memory management is pretty much like
alloc.c

The COMMIT_SLAB_SIZE here is really an arbitrary big number so that we
don't have to allocate often. It's basically allocating a new memory
pool. When we use all of that pool, we allocate a new one.. Yeah I
probably should define a new one instead of reusing COMMIT_SLAB_SIZE.
Tthe chances of under-allocation is super low, but still possible: you
need to send more than 4M "exclude" (or "shallow") requests to
upload-pack, to create a bitmap of over 512KiB. That's a lot of
traffic in git protocol.

> Your solution is to make the slab we allocate bigger. But that seems
> odd to me. Usually when we are using COMMIT_SLAB_SIZE, we are allocating
> a series of slabs that make up a virtual array, and we know that each
> slab has the same size. So if you need to find the k-th item, and each
> slab has length n, then you'd look at slab (k / n), and then at item (k
> % n) within that slab.
>
> In other words, I think the solution isn't to make the one slab bigger,
> but to allocate slabs until we have enough of them to meet the request.

If I still understand my code (it's been a long time since I wrote
this thing), then I think we just need to catch the problem and die().
Normal users should never ask the server to allocate this much.
-- 
Duy
