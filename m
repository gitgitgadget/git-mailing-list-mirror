Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD1DB1F404
	for <e@80x24.org>; Sat,  7 Apr 2018 23:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeDGXtL (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 19:49:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44626 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbeDGXtK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 19:49:10 -0400
Received: by mail-lf0-f65.google.com with SMTP id g203-v6so5189350lfg.11
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qTf1f4J263WVp+QetPBaGzAOb8ZPgB2aZKj9Hr/FJGY=;
        b=h5ZplrcT/NwbqtXlEZ6RpzRzoWTeEOIhfIODsPE9zkpxF8RXOjiGUfHujyrpkqJmfO
         L3mZmn5TjTA0PE0YzWdu2Ov0ko+gFligVSwu7opTwmPKIjVqpNd38KVFLY1HCbgjjVG3
         Vg2WLh7QtSnXeMzZJGpz+txMMhpNUiX5uVfUkXWSRtKfAopVrYRB7PfIcF5jrDkdi95m
         CLrvrRJwsPZo8a6BFHkA6p68x50e7tRU1ojlzy1x9vqYi58FRBxwumXROQDg1NNcLzFX
         Hkgay9h2i8SQ8e0MvE4/x9Dg9bAAvKF+f3ESNtpJiXpXCwO4W+DxTEWXiP2ZrejgTTJP
         cwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=qTf1f4J263WVp+QetPBaGzAOb8ZPgB2aZKj9Hr/FJGY=;
        b=iUwtGZOWnvWG+Aau2sLAjCzA4LCYoFAG6VFy+Zs8vBHlhBXT8V7E/CSmsjV2qbSC8j
         ZJlfT0LVYF40teJiUPLQDoTLBRTVgOPlwd0/x/rp7GmRyDNUnV86fHrEfBoPyh6un4xp
         3aGgykhYdGpIrZJlI+zMz1mkygjk5w6pgmHbxgMkiK4Poohw/ETz9QYvtnWeo1tJ4mca
         Qp1gUaQf89kIJxql7lPZScO/HgY015/fApus78FCQxHefzxsMy0snMKrSo9lljIFbmsc
         mwdedll/iKJh1YH+jnKVlN/XuDKo4CdC2N9AcrbPeyEruRJC5YCYFBkapgu9fskBNxDN
         D5uA==
X-Gm-Message-State: ALQs6tAPCjbIQsw0Kq778jzjxE1rNolI8nj/tW68wciqqsNWVMMlpFqx
        pFueUkw0INvMEbmvYkASY9w=
X-Google-Smtp-Source: AIpwx4+2lxWLbo+tW8GWkUEbKqa0RflrSbxkGMJkVvMPtbrfPv/bklWV1/NRsduTTCu8N8GdwhmhnA==
X-Received: by 2002:a19:2041:: with SMTP id g62-v6mr17958732lfg.133.1523144948499;
        Sat, 07 Apr 2018 16:49:08 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (aga121.neoplus.adsl.tpnet.pl. [83.25.156.121])
        by smtp.gmail.com with ESMTPSA id q22sm647345ljj.68.2018.04.07.16.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Apr 2018 16:49:07 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 03/14] commit-graph: add format document
References: <20180314192736.70602-1-dstolee@microsoft.com>
        <20180402203427.170177-1-dstolee@microsoft.com>
        <20180402203427.170177-4-dstolee@microsoft.com>
Date:   Sun, 08 Apr 2018 01:49:03 +0200
In-Reply-To: <20180402203427.170177-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 2 Apr 2018 16:34:16 -0400")
Message-ID: <86efjqefww.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> diff --git a/Documentation/technical/commit-graph-format.txt
> b/Documentation/technical/commit-graph-format.txt
> new file mode 100644
> index 0000000000..ad6af8105c
> --- /dev/null
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -0,0 +1,97 @@
> +Git commit graph format
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Git commit graph stores a list of commit OIDs and some associated
> +metadata, including:
> +
> +- The generation number of the commit. Commits with no parents have
> +  generation number 1; commits with parents have generation number
> +  one more than the maximum generation number of its parents. We
> +  reserve zero as special, and can be used to mark a generation
> +  number invalid or as "not computed".

Actually we will be reserving "all bits 1" as special, though I don't
think it is worth mentioning here, and at this time.

> +
> +- The root tree OID.
> +
> +- The commit date.
> +
> +- The parents of the commit, stored using positional references within
> +  the graph file.
> +
> +These positional references are stored as unsigned 32-bit integers
> +corresponding to the array position withing the list of commit OIDs. We
> +use the most-significant bit for special purposes, so we can store at mo=
st
> +(1 << 31) - 1 (around 2 billion) commits.
> +
> +=3D=3D Commit graph files have the following format:
> +
> +In order to allow extensions that add extra data to the graph, we organi=
ze
> +the body into "chunks" and provide a binary lookup table at the beginning
> +of the body. The header includes certain values, such as number of chunks
> +and hash type.
> +
> +All 4-byte numbers are in network order.
> +
> +HEADER:
> +
> +  4-byte signature:
> +      The signature is: {'C', 'G', 'P', 'H'}

The mnemonics: CGPH =3D Commit GraPH

> +
> +  1-byte version number:
> +      Currently, the only valid version is 1.
> +
> +  1-byte Hash Version (1 =3D SHA-1)
> +      We infer the hash length (H) from this value.
> +
> +  1-byte number (C) of "chunks"
> +
> +  1-byte (reserved for later use)
> +     Current clients should ignore this value.

All right, with this reserved byte that makes header word-aligned (be it
32-bit or 64-bit)

> +
> +CHUNK LOOKUP:
> +
> +  (C + 1) * 12 bytes listing the table of contents for the chunks:
> +      First 4 bytes describe the chunk id. Value 0 is a terminating labe=
l.

As I understand it, it is value 0 as 4-byte integer, that is 4 x byte 0.
This may need clarification (or may need not).

> +      Other 8 bytes provide the byte-offset in current file for chunk to
> +      start. (Chunks are ordered contiguously in the file, so you can in=
fer
> +      the length using the next chunk position if necessary.) Each chunk
> +      ID appears at most once.
> +
> +  The remaining data in the body is described one chunk at a time, and
> +  these chunks may be given in any order. Chunks are required unless
> +  otherwise specified.

Perhaps there should be here list of all required chunks, and list of
all optional chunks.

> +
> +CHUNK DATA:
> +
> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)

The mnemonics: OIDF =3D CID Fanout

> +      The ith entry, F[i], stores the number of OIDs with first
> +      byte at most i. Thus F[255] stores the total
> +      number of commits (N).

So in other words this is cumulative histogram?  Just ensuring that I
understand it correctly.

> +
> +  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)

The mnemonics: OIDL =3D OID Lookup

> +      The OIDs for all commits in the graph, sorted in ascending order.
> +
> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)

The mnemonics: CGET =3D ???

It is not CDAT, CGDT, DATA, etc.

> +    * The first H bytes are for the OID of the root tree.
> +    * The next 8 bytes are for the positions of the first two parents
> +      of the ith commit. Stores value 0xffffffff if no parent in that
> +      position. If there are more than two parents, the second value
> +      has its most-significant bit on and the other bits store an array
> +      position into the Large Edge List chunk.

Possibly better:

  +      position into the Large Edge List chunk (EDGE chunk).

> +    * The next 8 bytes store the generation number of the commit and
> +      the commit time in seconds since EPOCH.

The commit time is committer date (without timezone info), that is the
date that the commit object was created, isn't it?

>                                                 The generation number
> +      uses the higher 30 bits of the first 4 bytes, while the commit
> +      time uses the 32 bits of the second 4 bytes, along with the lowest
> +      2 bits of the lowest byte, storing the 33rd and 34th bit of the
> +      commit time.
> +
> +  Large Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]

Well, it is optional in the sense that it may not be here if the project
doesn't have any octopus merges.  It is not optional in the sense that
Git can ignore this chunk if it doesn't know its type.


Sidenote: PNG has critical and ancillary chunks [1]. Critical chunks
contain information that is necessary to read the file. If a decoder
encounters a critical chunk it does not recognize, it must abort reading
the file or supply the user with an appropriate warning.  If the first
letter of chunk name is uppercase, the chunk is critical; if not, the
chunk is ancillary.

[1]: https://en.wikipedia.org/wiki/Portable_Network_Graphics#%22Chunks%22_w=
ithin_the_file

> +      This list of 4-byte values store the second through nth parents for
> +      all octopus merges. The second parent value in the commit data sto=
res
> +      an array position within this list along with the most-significant=
 bit
> +      on. Starting at that array position, iterate through this list of =
commit
> +      positions for the parents until reaching a value with the most-sig=
nificant
> +      bit on. The other bits correspond to the position of the last pare=
nt.

The second sentence in the above paragraph is not entirely clean to me.

> +
> +TRAILER:
> +
> +	H-byte HASH-checksum of all of the above.

Best,
--=20
Jakub Nar=C4=99bski
