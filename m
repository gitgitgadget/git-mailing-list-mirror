Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D371F404
	for <e@80x24.org>; Thu,  8 Feb 2018 21:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeBHVVG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 16:21:06 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46722 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeBHVVE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 16:21:04 -0500
Received: by mail-wr0-f194.google.com with SMTP id 111so3321714wrb.13
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DS+wGlpqBcqfta0al/iVE3/iagVveGNXFhJIlRv3ps0=;
        b=EZY7HCnM9eM3hHjeakTfHP7HKJe20GzKZXzZ36P/6dxn4E+E6cb0+AvDaczDlgQye4
         2XHaVQ9PDXvY8E1JSsnzP8WqXDL8Ml+gDGs1b3bE8Z3TaRp/QdN+cHXwXg15UR6pcMqh
         u1nPMBG7KMaYedRz/QOXPG//bTWlHldu9EOxna+XjlwO0+/ALnG/WDZzYbSn52woHiXg
         5TqY3qKP/VbYiGF4I92zIvjUIvQ+gLbH4iZOSY3pTRiPgbYiQbXEmAFMCMMJCbjIkcR0
         x/yMYmscZLQ1WB7pE5bvnFiEw35ydRXeCPI9N34vPfYwGXiwG4G6fAphPApfn40FyKhb
         dpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DS+wGlpqBcqfta0al/iVE3/iagVveGNXFhJIlRv3ps0=;
        b=tftZlstgdIE01Pp7TkQLWgGWVbgkp0aeRVOJ2PsCnrl2qzBMfTBMosbskAYfwBJ7kp
         OyPY+e9tFgKHtqa98BDnfUPU0/7DYqeVi8kNwRheouNz5+CTjHQh2eezAxFt24N0BwL1
         Z4V3C5FbHIFEHz3SmtCmV6BZpKdBOvO1/AikrahI56wY1dCGr1dYYPJXnAea212CWGD/
         UAJ+0331Va4oCZgetQV3xQE3O+qR8fTuod4o2Z5CLymy/Eiq4r3ramfQ2quftUAdRDNb
         CoUNRh4W4TmyabAGZ2+OuC8kEiZ7y1/GIzZ6qRszWvLMqgUDPZjqpy5ZJNMG7LGZU0fX
         TSQw==
X-Gm-Message-State: APf1xPDmaMR/o+xtd2m6ZLqt8YCAkgH4thOruJBsOKu4q2hd88WXzZ0a
        5BPknSCmoRXn/BrVKgAbs/U=
X-Google-Smtp-Source: AH8x226pLw6O+IyyldP18PI1ev7LTKxAXGzSU+wLN64zMWTgMifq9qYAtj8T7wLDTm4stt0MawbNIA==
X-Received: by 10.223.208.141 with SMTP id y13mr481780wrh.31.1518124862529;
        Thu, 08 Feb 2018 13:21:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y55sm1100069wry.87.2018.02.08.13.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 13:21:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 01/14] commit-graph: add format document
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-2-git-send-email-dstolee@microsoft.com>
Date:   Thu, 08 Feb 2018 13:21:00 -0800
In-Reply-To: <1518122258-157281-2-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Thu, 8 Feb 2018 15:37:25 -0500")
Message-ID: <xmqq8tc3qitf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Add document specifying the binary format for commit graphs. This
> format allows for:
>
> * New versions.
> * New hash functions and hash lengths.

It still is unclear, at least to me, why OID and OID length are
stored as if they can be independent.  If a reader does not
understand a new Object Id hash, is there anything the reader can
still do by knowing how long the hash (which it cannot recompute to
validate) is?  And if a reader does know what OID hashing scheme is
used to refer to the objects, it certainly would know how long the
OIDs are.

Giving length may make sense only when a reader can treat these OIDs
as completely opaque identifiers, without having to (re)hash from
the contents, but if that is the case, then there is no point saying
what exact hash function is used to compute OID.

So I'd understand storing only either one or the other, but not
both.  Am I missing something?

> +The Git commit graph stores a list of commit OIDs and some associated
> +metadata, including:
> +
> +- The generation number of the commit. Commits with no parents have
> +  generation number 1; commits with parents have generation number
> +  one more than the maximum generation number of its parents. We
> +  reserve zero as special, and can be used to mark a generation
> +  number invalid or as "not computed".

This "most natural" definition of generation number is stricter than
absolutely necessary (a looser definition that is sufficient is
"gennum of a child is larger than all of its parents'").  While I
personally think that is OK, some people who floated different ideas
in previous discussions on generation numbers may want to articulate
their ideas again.  One idea that I found clever was to use the
total number of commits that are ancestors of a commit instead (it
is far more expensive to compute than the most natural gennum, but
doing so may help other topology math, like "describe").

> +CHUNK LOOKUP:
> +
> +  (C + 1) * 12 bytes listing the table of contents for the chunks:
> +      First 4 bytes describe chunk id. Value 0 is a terminating label.
> +      Other 8 bytes provide offset in current file for chunk to start.
> +      (Chunks are ordered contiguously in the file, so you can infer
> +      the length using the next chunk position if necessary.)

Aren't chunks numbered contiguously, starting from #1, thereby
making it unnecessary to store the 4-byte?

How does a reader obtain the length of the last chunk?  Ahh, that is
why there are C+1 entries in this table, not just C, so that the
reader knows where to stop while reading the last one.  Does that
mean that this table looks like this?
   
    { 1, offset_1 },
    { 2, offset_2 },
    ...
    { C, offset_C },
    { 0, offset_C+1 },

where where (offset_N+1 - offset_N) gives the length of chunk #N?

> +  The remaining data in the body is described one chunk at a time, and
> +  these chunks may be given in any order. Chunks are required unless
> +  otherwise specified.
> +
> +CHUNK DATA:
> +
> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
> +      The ith entry, F[i], stores the number of OIDs with first
> +      byte at most i. Thus F[255] stores the total
> +      number of commits (N).
> +
> +  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
> +      The OIDs for all commits in the graph, sorted in ascending order.
> +
> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
> +    * The first H bytes are for the OID of the root tree.
> +    * The next 8 bytes are for the int-ids of the first two parents
> +      of the ith commit. Stores value 0xffffffff if no parent in that
> +      position. If there are more than two parents, the second value
> +      has its most-significant bit on and the other bits store an array
> +      position into the Large Edge List chunk.
> +    * The next 8 bytes store the generation number of the commit and
> +      the commit time in seconds since EPOCH. The generation number
> +      uses the higher 30 bits of the first 4 bytes, while the commit
> +      time uses the 32 bits of the second 4 bytes, along with the lowest
> +      2 bits of the lowest byte, storing the 33rd and 34th bit of the
> +      commit time.
> +
> +  Large Edge List (ID: {'E', 'D', 'G', 'E'})
> +      This list of 4-byte values store the second through nth parents for
> +      all octopus merges. The second parent value in the commit data stores
> +      an array position within this list along with the most-significant bit
> +      on. Starting at that array position, iterate through this list of int-ids
> +      for the parents until reaching a value with the most-significant bit on.
> +      The other bits correspond to the int-id of the last parent. This chunk
> +      should always be present, but may be empty.

I am not convinced about the value of these 4-byte section IDs.  

They are useless unless you define what should happen when a reader
sees a block of data with an unknown ID; presence of these IDs given
an impression that you allow a reimplementation to reorder the
sections unnecessarily, especially when all of these are required
anyway, making the canonical reader implementation unnecessarily
complex, no?

