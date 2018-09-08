Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BF81F404
	for <e@80x24.org>; Sat,  8 Sep 2018 06:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeIHLNy (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 07:13:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39304 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeIHLNy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 07:13:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so7501811plp.6
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 23:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tr9a3WZ1/hrN91jzkzsQinrnsyrV/M/AeRKB6qNat0s=;
        b=cYuZPASTdUFnYKThfVjzszXlZYgSlbQM4bQcb6i/KmZHWjzgdbObGDeq6uWGFe3XTW
         4Ub6CNUCeyVPQ8OtukKauDXJyE6NTgLDuDqdPjbILxYgoO1o3s6qK+4CaEEU5OBwowvW
         GOIywHOb3IdFMp/BVJZalzOxZoo1IYQ/ywyto0KLlSMxCFN52U8xQdGPLniJb0Adog3o
         SylnbtA7gQDw6boqxlkqQ5bX20jbxa+zeDhGOHVv0ntgxcF54CUp8q1mK3hN91hxEpEw
         4PcU6kwWAn3TSPPCcF8Rhf7o94o9l0ldXVxg7B6d98PVkQV8Z1Wt82m8chY/nctbMo+e
         fEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tr9a3WZ1/hrN91jzkzsQinrnsyrV/M/AeRKB6qNat0s=;
        b=BllCKHmJQj2zMT3p4Dbf/REYqT9BbFWjYb9sFGomLLLl9lY3QdBbhZmTQGOGvLrPYf
         b9JoLmvU4Pqn5mwEkoEMjjF3PiUQoGBI2f2nSR3fLOfzXBhSC5MrAozJdoI6y9zgQeS7
         RUajqVMZZBAhpRPFleQuyFpqbp5ke8svyp6uYLzXndyZzG/j0PCUnw/mFJDG7Xf0Ygyi
         wCjL/191mgY537Vb/sDnmS8LTIcwWGCmHm/bAedNt6TX6S520QGQyntN2nDCVrGKxHG/
         6VH30Pe8qEiBBar/97tRpovyY6+9DDwgrODzZJM7BjwUIObkjfc2BGIPDWbzaAZKQvf1
         9B/w==
X-Gm-Message-State: APzg51BdCbhmzYAVG/58YGx6ltIweMUhUeFzPLHrUVIOQwFlr4a4KTgR
        HD7t3SfbB2lho0f1SHk3TYojJoKoPWMrJwri4B8=
X-Google-Smtp-Source: ANB0Vdan900XmICyjDI3uQah09hIYVjsdAKCUEvU+nxK5w4XRD8oUtLNFQb5GBKY3aH94e60Q7w6/APF9fUB1pNx85k=
X-Received: by 2002:a17:902:42a3:: with SMTP id h32-v6mr11652153pld.105.1536388157873;
 Fri, 07 Sep 2018 23:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com> <20180906210227.54368-3-benpeart@microsoft.com>
 <xmqqpnxpw5sn.fsf@gitster-ct.c.googlers.com> <fc531863-c46c-6d27-4749-c6b092a14a6f@gmail.com>
In-Reply-To: <fc531863-c46c-6d27-4749-c6b092a14a6f@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 8 Sep 2018 08:29:03 +0200
Message-ID: <CAN0heSreAfMsseZcxR75CFDph-n1b8EUNsRhpFsVqxMLc0hvpA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] eoie: add End of Index Entry (EOIE) extension
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 7 Sep 2018 at 22:24, Ben Peart <peartben@gmail.com> wrote:
> > Ben Peart <benpeart@microsoft.com> writes:

> >> - 160-bit SHA-1 over the extension types and their sizes (but not
> >> their contents).  E.g. if we have "TREE" extension that is N-bytes
> >> long, "REUC" extension that is M-bytes long, followed by "EOIE",
> >> then the hash would be:

> The purpose of the SHA isn't to detect disk corruption (we already have
> a SHA for the entire index that can serve that purpose) but to help
> ensure that this was actually a valid EOIE extension and not a lucky
> random set of bytes. [...]

> >> +#define EOIE_SIZE 24 /* <4-byte offset> + <20-byte hash> */

> >> +    the_hash_algo->init_fn(&c);
> >> +    while (src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER) {
[...]
> >> +    the_hash_algo->final_fn(hash, &c);
> >> +    if (hashcmp(hash, (unsigned char *)index))
> >> +            return 0;
> >> +
> >> +    /* Validate that the extension offsets returned us back to the eoie extension. */
> >> +    if (src_offset != mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER)
> >> +            return 0;

Besides the issue you and Junio discussed with "should we document this
as being SHA-1 or NewHash" (or "the hash algo"), it seems to me that
this implementation is living somewhere between using SHA-1 and "the
hash algo". The hashing uses `the_hash_algo`, but the hash size is
hardcoded at 20 bytes.

Maybe it all works out, e.g., so that when someone (brian) merges a
NewHash and runs the testsuite, this will fail consistently and in a
safe way. But I wonder if it would be too hard to avoid the hardcoded 24
already now.

Martin
