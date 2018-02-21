Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F691F404
	for <e@80x24.org>; Wed, 21 Feb 2018 19:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeBUTXo (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 14:23:44 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:39770 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbeBUTXn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 14:23:43 -0500
Received: by mail-yw0-f172.google.com with SMTP id b20so880860ywe.6
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 11:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tl9pKd4tfpwKlIksOtLmy2oHGHHaTpREdvR/nQC/aYY=;
        b=giKC4yYXXP8FOEmh81ks876j3Aab7s3+uixdBaA6aPbJsZpsqRfKmkgSMqSfZMd44u
         xyyXf8z2sGpmDf7O6QusH3D6moUuMWDVeWWQhoEdFcYGZ6HOFerz5urXesWV/ppGcZ1J
         DbrA8XbFs7fegEKFPymQewxPJYm99zBCNQekyl1v4RIHhXtdM2LaIf7W4QzVZmqskBrG
         p/A7CzdA3ypme6mP+zP2GL9ciG88u+ffVbsWmf4GwKYGxcVBDQcOhgsVTkxX9uITFbId
         gj1hGXAuopQ4tsoTj9qZ8ZcscfkaaSwqn+8vsSdqwEhjYS/ts5JXyIPvj8J6XeSMCSZH
         ZKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tl9pKd4tfpwKlIksOtLmy2oHGHHaTpREdvR/nQC/aYY=;
        b=W5M2pop4CTdEz3i+jnfCYlusjbUAE0pB0yuqDEEovdQiPje/zVw5qs/jat392tNzZZ
         NsPYPSlu1FQrXYe7+dEi+uRwG+h0Ko2aXbt5p71lj1orQ047GwHtAxGZIQiRhqdI5mdh
         RpAj0KVjsTtP4SoDBuoWVvk3puKZmFbZBM55yeNZnoas52ITKj4fmhFFI9K09pEQrcyI
         pu2rD7pEGAQlPvA26VTMHtLsN2qj2I/1b/S0X6Si10hDrPHY3G/vvjHQiEV+vHddNX7p
         nhx4A+YFWmTLdAvu+BXdNt7/4p4OyzQX/vB2h6JHUHsygGiZKiTzrAh6E8p6XiPG/J5x
         SjZw==
X-Gm-Message-State: APf1xPDe32/gknrEDsQBFrc2+q3xtsvVbv0qcv0yWD+YGeTKI/M92TXO
        zZ5D6tonYBo3PXgDMaEEio+fc20Ov1dtlsvxjygwLA==
X-Google-Smtp-Source: AH8x2270P8dm1Clu/v2aMnYs7xm3tDPtpXB831xZPstcM3rsnYLq074KAvzXLahfVgB/NqK0lQithFqkegq3ISuphUI=
X-Received: by 10.129.73.80 with SMTP id w77mr3191573ywa.421.1519241021692;
 Wed, 21 Feb 2018 11:23:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 21 Feb 2018 11:23:41
 -0800 (PST)
In-Reply-To: <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com> <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Feb 2018 11:23:41 -0800
Message-ID: <CAGZ79kawTtSzVV2=sNn_OFsmCbcLGhVi1pt4bVrOYfZA28E+6Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] commit-graph: add format document
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 10:53 AM, Derrick Stolee <stolee@gmail.com> wrote:
> Add document specifying the binary format for commit graphs. This
> format allows for:
>
> * New versions.
> * New hash functions and hash lengths.
> * Optional extensions.
>
> Basic header information is followed by a binary table of contents
> into "chunks" that include:
>
> * An ordered list of commit object IDs.
> * A 256-entry fanout into that list of OIDs.
> * A list of metadata for the commits.
> * A list of "large edges" to enable octopus merges.
>
> The format automatically includes two parent positions for every
> commit. This favors speed over space, since using only one position
> per commit would cause an extra level of indirection for every merge
> commit. (Octopus merges suffer from this indirection, but they are
> very rare.)
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/commit-graph-format.txt | 90 +++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/technical/commit-graph-format.txt
>
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> new file mode 100644
> index 0000000..11b18b5
> --- /dev/null
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -0,0 +1,90 @@
> +Git commit graph format
> +=======================
> +
> +The Git commit graph stores a list of commit OIDs and some associated
> +metadata, including:
> +
> +- The generation number of the commit. Commits with no parents have
> +  generation number 1; commits with parents have generation number
> +  one more than the maximum generation number of its parents. We
> +  reserve zero as special, and can be used to mark a generation
> +  number invalid or as "not computed".
> +
> +- The root tree OID.
> +
> +- The commit date.
> +
> +- The parents of the commit, stored using positional references within
> +  the graph file.
> +
> +== graph-*.graph files have the following format:
> +
> +In order to allow extensions that add extra data to the graph, we organize
> +the body into "chunks" and provide a binary lookup table at the beginning
> +of the body. The header includes certain values, such as number of chunks,
> +hash lengths and types.
> +
> +All 4-byte numbers are in network order.
> +
> +HEADER:
> +
> +  4-byte signature:
> +      The signature is: {'C', 'G', 'P', 'H'}
> +
> +  1-byte version number:
> +      Currently, the only valid version is 1.
> +
> +  1-byte Object Id Version (1 = SHA-1)
> +
> +  1-byte number (C) of "chunks"
> +
> +  1-byte (reserved for later use)

What should clients of today do with it?
* ignore it completely [as they have no idea what it is] or
* throw hands up in the air if it is anything other than 0 ?
  [because clearly we will increment the version
   or have new information in a new chunk instead of just sneaking
   in information here?]

> +CHUNK LOOKUP:
> +
> +  (C + 1) * 12 bytes listing the table of contents for the chunks:
> +      First 4 bytes describe chunk id. Value 0 is a terminating label.
> +      Other 8 bytes provide offset in current file for chunk to start.

offset [in bytes? I could imagine having a larger granularity here,
because chunks don't sound small.]

> +      (Chunks are ordered contiguously in the file, so you can infer
> +      the length using the next chunk position if necessary.)
> +
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

[ so in small repos, where there are fewer than 256 objects,
F[i] == F[i+1], for all i'th where there is no object starting with i byte]

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
> +  Large Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
> +      This list of 4-byte values store the second through nth parents for
> +      all octopus merges. The second parent value in the commit data stores
> +      an array position within this list along with the most-significant bit
> +      on. Starting at that array position, iterate through this list of int-ids
> +      for the parents until reaching a value with the most-significant bit on.
> +      The other bits correspond to the int-id of the last parent.
> +
> +TRAILER:
> +
> +       H-byte HASH-checksum of all of the above.
> +
> --
> 2.7.4

Makes sense so far, I'll read on.
I agree with Junio, that I could read this documentation without
the urge to point out nits. :)

Thanks,
Stefan
