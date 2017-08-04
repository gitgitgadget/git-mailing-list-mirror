Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4111F991
	for <e@80x24.org>; Fri,  4 Aug 2017 02:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbdHDCuv (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 22:50:51 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:36241 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdHDCuu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 22:50:50 -0400
Received: by mail-ua0-f172.google.com with SMTP id k43so1906038uaf.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 19:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BQTk8wG39a5nZxW3DukCBbiv1nqgRofuOoWKTWgcYl4=;
        b=bKFwf8lZo74of8pznMf4JPddERleWsEF3RI5ywrXRS1fkFwn8WYhvxZKxBF8nJnm0B
         Lj7o5Vzm0aiUB6nbYZO42uPvfo8q3a9VYPcJju90cZEkoeE2kLbYB7gwEl2CNDY3UKxc
         ke0nbmYz1CIDLgc8rezwd+Q3F2a7g2oRh5Cuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BQTk8wG39a5nZxW3DukCBbiv1nqgRofuOoWKTWgcYl4=;
        b=ZhblsVC5vjvvY+58oX91IBAfFKyHgSfofU58zVmmlpgta+LoEiEOIyiMcWXx7NHp3H
         BRH1J7yWUlsH/jMAfRPP7SRznXnM4/WiqAGa0f3hnTxlg8l+PbqxbFUnRYBX9ZdOt+XM
         qcbze3/lq9aIdWB2X1ut87R7PuWdVAznXaJ0gU/LlwImwN3El7zkbMkV7vU2uXllP6MB
         yu29N7Yq13CLfE/8n30terRZLalkrOcOMWV7F++2rQORP3gqxWe9bCg2IMca+jX2/Bzi
         idxeqDyy2+jjYMrySr0Wu448KNMTe1Uh8X8pHufdWbqC1DneiWf14w7PCz+9mWE1QQ7G
         ONyw==
X-Gm-Message-State: AIVw110jpUIazY4xq6xElKdh66En0dqOZMjZLLmPvFyIAol1kW8apOb+
        aJS2KuOrsUeHrsnb4exQlKKTRPRuVmfM
X-Received: by 10.176.71.17 with SMTP id h17mr534253uac.138.1501815049393;
 Thu, 03 Aug 2017 19:50:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Thu, 3 Aug 2017 19:50:28 -0700 (PDT)
In-Reply-To: <CAMy9T_EU6hPbnnB72ouRAd0yNvWn6_Ef8Bh2iPxChpmDt1qmFw@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
 <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
 <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
 <CAMy9T_G5xorPGp=5=p_ku3RhB1E-c9+4mEgYhbyAhLdc1V=JBg@mail.gmail.com>
 <CAJo=hJvNgX06gkXp2Vsx=cSkcxRO9aRzOit6vvi4fqL3QeDsEg@mail.gmail.com> <CAMy9T_EU6hPbnnB72ouRAd0yNvWn6_Ef8Bh2iPxChpmDt1qmFw@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Thu, 3 Aug 2017 19:50:28 -0700
Message-ID: <CAJo=hJvw3UBP7p-5Yxni++_CL8c3JC3etPkYqxSQiaBiKPQWww@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 3:48 PM, Michael Haggerty <mhagger@alum.mit.edu> wro=
te:
> I've revised the blockless reftable proposal to address some feedback:

I've been thinking more about your blockless proposal.

I experimentally modified my reftable implementation to omit padding
between blocks, bringing it a tiny bit closer to your blockless
proposal. Unfortunately this slightly increased latency for lookups on
a 4k chunk size. I speculate this is because chunks are no longer
aligned with the filesystem page, and I'm forcing Mac OS X to give me
two pages out of the filesystem. Using padding to align to a 4k block
is slightly faster, and the average wasted per block is <=3D20 bytes,
too small to fit another ref.

The restart table and binary search within the 4k block is a
performance win. Disabling the restart table significantly increased
lookup latency.

tl;dr:  I think the block alignment and restart table are wins vs. the
multi-level index.


A suggested downside of my reftable design is the ref index at 4k
block size for 866k refs is 199 KiB, and must be paged in for binary
search to locate the correct block for any lookup. The pack idx for
the two main packs in this repository is 210 MiB. We think fairly
little of mmap'ing 210 MiB to perform binary search to find object
data. 199 KiB for ref data seems to be a bargain. An advantage of the
single level index is its only one page touched after the index is
loaded.

Hot reftable reads (5.6 usec) are faster than loose ref reads (6.5
usec). Once the ref index is loaded, reftable can read a ref more
quickly than the time required to open-read-close a loose ref.
Admittedly, a large index slows down a cold read.

tl;dr:  I just don't think the size of the index is a concern.


I really favor the reflog data in a different section from the ref
values themselves. Even for smaller transaction files, it improves
scan and lookup time by allowing readers who just care about the name
and SHA-1 value of a ref to not be paging in or skipping over log
record payloads. However, I also agree that the aggregates may benefit
from ref and log being separate files.


> * Add a way to mark a reflog entry "deleted" without having to rewrite
> everything. This is mostly meant to deal with `refs/stash`.

This is an interesting idea. Given how I implemented reftable in JGit,
just inserting a deletion record for the same (ref,update_index) tuple
would make it trivial to hide the prior entry.

> * Define an extension mechanism.
> * Define the SHA-1 =E2=86=92 object mapping as an extension rather than a=
s
> part of the main spec. My gut feeling is that it will never be
> implemented for git-core.

While the SHA-1 -> object mapping may never be implemented for
git-core, I'd still prefer to see it as an optional part of the file
specification, rather than an extension that is specified. IMHO the
extension stuff in DIRC has made it unnecessarily complicated, and
we've still revved that file through many revisions.

> * Revise how the SHA-1 =E2=86=92 object mapping works:
>     * Merge the bottommost OBJ_INDEX node with the old OBJ nodes to
> form a new OBJ_LEAF node.
>     * Allow the branching factor of each node to be specified
> independently (to allow the node sizes to be matched more closely to
> the preferred read sizes).

I'm not sure objects warrant this kind of complexity. The obj support
in reftable is nearly identical to the ref support. I have a
significant amount of code that is common between them. Your approach
has objects different enough from refs that they need their own code,
increasing complexity in both the writer and reader.


> I currently lean towards the opinion that we should store pseudorefs
> (like `FETCH_HEAD`, `MERGE_HEAD` *outside of* reftables, except for
> `HEAD` (which behaves more like a normal reference, which is
> considered for reachability, and for which we want to retain reflogs),
> which we should store *in* reftables.

I'm on the fence, and don't really have a strong opinion about where
we store the pseudorefs. Happy to keep them in $GIT_DIR, happy to have
them supported inside a reftable.
