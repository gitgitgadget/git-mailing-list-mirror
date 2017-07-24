Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CFEC203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 22:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbdGXWWc (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 18:22:32 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:38365 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbdGXWW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 18:22:29 -0400
Received: by mail-pg0-f51.google.com with SMTP id s4so62584246pgr.5
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 15:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rGjYKevsAK4TWsYxvquq4xowrpenZsEmU4adoC93s7A=;
        b=MUmMd3RJLYdsLmLkmKLFMzVK89gX8TLM5EZTOW7juO2oOVUmvnAC/f//03uBHYX288
         3F1L2/taVx3h9TfyoP2VwEVtXeu5gnArWR7bSjKKO5e+DtZDOER0ps9w9CgQ/c5qz4TX
         eOLcp8lSJeEdcAcQ86YLOG0Aggz/1Q6netoUkoZ6pnehF6WciOjzX1SYTVyQ4Y3AryqT
         qGMezuozWmg05x4Gp/ho6cPMePrM3JumzKrID2x0jlGMXm3KP1iCLSPZNiuZXB4mXr2K
         5qig+jtUuKy7rLofX+XgvW64Lz9Gc/WM0bMFea0c2ub58MtfQ3C4nRFHhgoeeAivOcJp
         /8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rGjYKevsAK4TWsYxvquq4xowrpenZsEmU4adoC93s7A=;
        b=pA6nkc7Psv1XfNR2ocTmlm47oboOPN182+rrIB5sWzn4IrLkAdfIKFIXxrARLfJXFZ
         3fxGkbWnnyQ3E87tVRmJf5u71RsA9f5SeZEHPGDmKdVJfgmczt2JK+jdOdIpllbFvbaS
         T+W6mkvPfkLPQn+B5v7cyjsLM0qvHJtHBeuvEcWHrJgiM+o3Sw3TtOUYFpE+H3DWSybU
         oGSW7Wq6mFbhFqbQ3rEFNllyyQ5heEBlnLGFvSbXTWn60GVxfhIfc1lgNNxFtOlckWIq
         PR0TETK+GKYkxG9C3Xsx1swHjXe9bqfrWtmrvxS6BZRM7tZDDE33vr/jqPapZg/bO6/3
         oB4w==
X-Gm-Message-State: AIVw110LAxA5VG0M9qktgOXaZLfWMiEWVCzO8HQOmi8N+xZ1ri1RBFdG
        3aPtIjZ2DxeHevIZru/RQ5+Z5ErHodPUJA9Ctw==
X-Received: by 10.84.137.129 with SMTP id 1mr19197655pln.251.1500934949133;
 Mon, 24 Jul 2017 15:22:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Mon, 24 Jul 2017 15:22:28 -0700 (PDT)
In-Reply-To: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
References: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Jul 2017 15:22:28 -0700
Message-ID: <CAGZ79kZ48zTsHxrW-fvHRFQih=vBuywExSxA8a_=wzjdJPbtrg@mail.gmail.com>
Subject: Re: reftable [v3]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 22, 2017 at 11:29 AM, Shawn Pearce <spearce@spearce.org> wrote:
> 3rd iteration of the reftable storage format.
>
> You can read a rendered version of this here:
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>
> Significant changes from v2:
> - efficient lookup by SHA-1 for allow-tip-sha1-in-want.

I'll focus on that in the review, it sounds exciting.

> - type 0x4 for FETCH_HEAD, MERGE_HEAD.

So we'd have
    varint( (suffix_length << 3) | value_type )
which leaves us with 5 bits for the varint. One bit is needed
to indicate if ew have more bytes coming in the varint, so
only 4 bits in the first byte to encode the suffix length.
That means we can have suffixes up to 15 and we'd still be fine
with just one byte IIUC. That should be enough, specifically for
contiguous numbers as ref names.

> ### Block size
>
> The `block_size` is arbitrarily determined by the writer, and does not
> have to be a power of 2.  The block size must be larger than the
> longest reference name or deflated log entry used in the repository,
> as references cannot span blocks.
>
> Powers of two that are friendly to the virtual memory system or
> filesystem (such as 4k or 8k) are recommended.  Larger sizes (64k) can
> yield better compression, with a possible increased cost incurred by
> readers during access.
>
> The largest block size is `16777215` bytes (15.99 MiB).

Thanks for calling this out, 16MB ought to be enough for everyone.
(Not a joke, as we can have multiple blocks)

> ### Ref block format
...

> A variable number of 4-byte `restart_offset` values follow the
> records.  Offsets are relative to the start of the block and refer to
> the first byte of any `ref_record` whose name has not been prefix
> compressed.  Readers can start linear scans from any of these records.
> Offsets in the first block are relative to the start of the file
> (position 0), and include the file header.  This requires the first
> restart in the first block to be at offset 8.
>
> The 2-byte `restart_count_m1` stores *one less* than the number of
> entries in the `restart_offset` list.  There is always a restart
> corresponding to the first ref record. Readers are responsible for
> computing `restart_count = restart_count_m1 + 1`.

I had to reread these two paragraphs a couple of times as it calls out
the uninteresting things[1] and the interesting part is the logical
conclusion that one has to make themselves,
here is how I would write it:

    Readers can start linear scans from any record whose name has
    not been prefix compressed. The first record of a block must not
    be prefix-compressed.

    To aid finding the entry points for linear scans, a variable number
    of 4-byte `restart_offset` values follow the records. Offsets are
    relative to the start of the block and refer to the first byte of any
    such `ref_record` that is not prefix compressed.
    The first record can be omitted in the `restart_offset` values as it
    is implicit.

    The `restart_offset' values must be sorted (ascending,
    descending?).

    The 2-byte `restart_count_m1` stores the number of optional
    entry points, i.e. the number of values in `restart_offset'.
    As the first record is omitted in the offset table, there is at
    least one entry at 0. the `restart_count_m1` can be zero for
    best compression.

[1] The last paragraph in my proposal sounds less like an
off-by-one error to me, but just states what the number is and how
it relates to the surroundings in the file format.

...

> The `value` follows.  Its format is determined by `value_type`, one of
> the following:
>
> - `0x0`: deletion; no value data (see transactions, below)
> - `0x1`: one 20-byte object id; value of the ref
> - `0x2`: two 20-byte object ids; value of the ref, peeled target

Up to here it is easy to spot a pattern:
The number indicates how many oids follow.

> - `0x3`: symbolic reference: `varint( target_len ) target`
> - `0x4`: length delimited extension: `varint( data_len ) data`

This breaks the pattern.

Instead of hardcoding the numbers here, I wonder if we rather
want to make the bits more meaningful:

  bit 0, 1: number of oids iff bit 2 unset

  Iff bit 2 set, then we have a "varint (len) data"
  that follows, bits 0,1 are used for a different purpose,
  00 indicates 'symlink' and data is the string
  01 indicates 'multihead' such as FETCH_HEAD
  1* is reserved for now.

This *may* be neat micro optimization, but hardcoding all bits
to a lookup table is fine, too.

  Note that symrefs and multiheads could share the same
  type, iff we had dissallowed '\n' in refnames. (we do?
  otherwise FETCH_HEAD would be broken)
  The differentiator would be the '\n' or '\0' at the end of the
  first target.

> Types `0x5..0x7` are reserved.

The proposal above would make 0x3, 0x6, 0x7 be reserved.

> ### Ref index
...
>
> An index block should only be written if there are at least 4 blocks
> in the file, as cold reads using the index requires 2 disk reads, and
> binary searching <= 4 blocks also requires <= 2 reads.

This is the bare minimum to be recommended. Fine with me, but we'd
want to tune it eventually. (I imagine for 5 blocks in the file it may still be
cheaper to not have the index block)

> #### index record
>
> An index record describes the last entry in another block.
> Index records are written as:
>
>     varint( prefix_length )
>     varint( (suffix_length << 3) | 0 )
>     suffix
>     varint( block_offset )
>
> Index records use prefix compression exactly like `ref_record`.
>
> Index records store `block_offset` after the suffix, specifying the
> offset in bytes (from the start of the file) of the block that ends
> with this reference.

Instead of hardcoding the "0" in the last 3 bits, maybe pick one
of the reserved bit patterns to be there? I would imagine this
makes debugging easier:

    0x5? Hah that must be an index block I have been
    looking at the wrong block!

By picking a reserved bit pattern from above you can tell
the types apart. (No, it is not a deletion of a ref!)

> ### Obj block format
>
> Object blocks use unique, abbreviated 2-20 byte SHA-1s keys, mapping
> to ref blocks containing references pointing to that object directly,
> or as the peeled value of an annotated tag.  Like ref blocks, object
> blocks use the file's standard `block_size`.
>
> To save space in small files, object blocks may be omitted if the ref
> index is not present.  When missing readers should brute force a
> linear search of all references to lookup by SHA-1.
>
> An object block is written as:
>
>     'o'
>     uint24 ( block_len )
>     obj_record+
>     uint32( restart_offset )+
>     uint16( restart_count_m1 )
>     padding?
>
> Fields are identical to ref block.  Binary search using the restart
> table works the same as in reference blocks.
>
> Because object identifiers are abbreviated by writers to the shortest
> unique abbreviation within the reftable, obj key lengths are variable
> between 2 and 20 bytes.  Readers must compare only for common prefix
> match within an obj block or obj index.
>
> Object blocks should be block aligned, according to `block_size` from
> the file header.  The `padding` field is filled with NULs to maintain
> alignment for the next block.
>
> #### obj record
>
> An `obj_record` describes a single object abbreviation, and the blocks
> containing references using that unique abbreviation:
>
>     varint( prefix_length )
>     varint( (suffix_length << 3) | cnt_3 )
>     suffix
>     varint( cnt_rest )?
>     varint( block_delta )+
>
> Like in reference blocks, abbreviations are prefix compressed within
> an obj block.  On large reftable files with many unique objects,
> higher block sizes (64k), and higher restart interval (128), a
> `prefix_length` of 2 or 3 and `suffix_length` of 3 may be common in
> obj records (unique abbreviation of 5-6 raw bytes, 10-12 hex digits).
>
> Each record contains `block_count` number of block identifiers for ref
> blocks.  The `block_count` is determined by:
>
>     block_count = cnt_3
>     if (cnt_3 == 0x7) {
>       block_count += cnt_rest
>     }

Instead of having the first seven blocks treated special (omission of
cnt_rest), we could also pick one of the reserved bit patterns here to
aid debuggers, as a downside we'd require cnt_rest to be present at
all times.

> The `cnt_rest` field is only present when `block_count >= 0x7` and
> could overflow the `cnt_3` field available in the record start.  This
> encoding scheme is used as the vast majority of abbreviations are
> only one reference (or at most a few), and unlikely to exceed 6 blocks.

ok, I misunderstood what the cnt/block_count was aiming to tell, it
is very likely to have fewer than 7 here even for very large reftables.

> The first `block_delta` is the absolute block identifier counting from
> the start of the file. The offset of that block can be obtained by
> `block_delta[0] * block_size`.  Additional `block_delta` entries are
> relative to the prior entry, e.g. a reader would perform:
>
>     block_id = block_delta[0]
>     prior = block_id
>     for (j = 1; j < block_count; j++) {
>       block_id = prior + block_delta[j]
>       prior = block_id
>     }
>
> With a `block_id` in hand, a reader must linearly scan the ref block
> at `block_id * block_size` offset in the file, starting from the first
> `ref_record`, testing each reference's SHA-1s (for `value_type = 0x1`
> or `0x2`) for full equality.

So this fails to detect sha1s in FETCH_HEAD, okay.

> Faster searching by SHA-1 within a
> single ref block is not supported by the reftable format.  Smaller
> block sizes reduces the number of candidates this step must consider.

By having block_delta as deltas of each other, we enforce an ordering
(well, varint could be negative, but who does that?)

Additionally we could give an offset to a restart block to start searching
from inside a ref block.

Coupled with the idea from above of having a reserved bit pattern, an
alternative design could look like:

    varint( prefix_length )
    varint( (suffix_length << 3) | special_bit_pattern )
    suffix
    varint( cnt_rest )
    (varint( block_delta ), varint( restart_offset ))+

>
> #### log record
>
> Log record keys are structured as:
>
>     ref_name '\0' reverse_int64( time_usec )

repeating from v2:

  The size of the integer
  is determined by the suffix length encoding and the preceding '\0',
  such that the file format allows arbitrary integer size. So instead of
  pretending we can only do 64 bit here, just say 'reverse_int' ?


>
> ### Log index
>
> The log index stores the log key (`refname \0 reverse_int32(time_sec)`)

int64 now?


> Log index format is identical to ref index, except the keys are 5
> bytes longer to include `'\0'` and the 4-byte `reverse_int32(time)`.
> Records use `block_offset` to refer to the start of a log block.

also 64? /me is confused.

> ### Footer
>
> After the last block of the file, a file footer is written.  It begins
> like the file header, but is extended with additional data.
>
> A 52-byte footer appears at the end:
>
> ```
>     '\1REF'
>     uint8( version_number = 1 )
>     uint24( block_size )
>     uint64( ref_index_offset )
>
>     uint64( obj_offset )
>     uint64( obj_index_offset )
>
>     uint64( log_offset )
>     uint64( log_index_offset )
>
>     uint32( CRC-32 of prior )
> ```
>
> If a section is missing (e.g. ref index) the corresponding offset
> field (e.g. `ref_index_offset`) will be 0.
>
> - `obj_offset`: byte offset for the first obj block.
> - `log_offset`: byte offset for the first log block.
> - `ref_index_offset`: byte offset for the start of the ref index.
> - `obj_index_offset`: byte offset for the start of the obj index.
> - `log_index_offset`: byte offset for the start of the log index.

By the design of the footer, refs must come first.
Whether objects or logs come thereafter can both be encoded here,
however the initial design claims an order.

> ## Repository format
>
> ### Version 1
>
> A repository must set its `$GIT_DIR/config` to configure reftable:
>
>     [core]
>         repositoryformatversion = 1
>     [extensions]
>         reftable = 1
>
> ### Layout
>
> The `$GIT_DIR/refs` path is a file when reftable is configured, not a
> directory.  This prevents loose references from being stored.

That is cool.

> Reftable files not listed in `refs` may be new (and about to be added
> to the stack by the active writer), or ancient and ready to be pruned.

To prevent confusion between the two in 2038, we may rather want
to use ISO_8601 instead of seconds since the epoch?
("2017-07-25-XXXXXX")

> ### Compaction
...
> This strategy permits compactions to proceed independently of updates.

Not just that, but D+E can also be compacted at the same time.
That implies an unmaintained repo with *lots* of reftables can be
compacted in O(n log n) compactions.

Thanks for a pleasant read,
Stefan
