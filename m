Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B80C20899
	for <e@80x24.org>; Thu, 27 Jul 2017 14:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbdG0O2L (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 10:28:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63391 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751636AbdG0O2H (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jul 2017 10:28:07 -0400
X-AuditID: 12074413-66dff70000000aee-e9-5979f876b906
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 15.6C.02798.678F9795; Thu, 27 Jul 2017 10:28:06 -0400 (EDT)
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com [209.85.214.44])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v6RES5em022442
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 10:28:06 -0400
Received: by mail-it0-f44.google.com with SMTP id v127so1825998itd.0
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 07:28:06 -0700 (PDT)
X-Gm-Message-State: AIVw110WrvHAddymEgzzxIZ1ffiS631iUOTgpJWOrYoKuO+VMnevsMJ7
        VhQSdOrGezR/XN2LxBwd5DMmKttSaA==
X-Received: by 10.36.117.204 with SMTP id y195mr5280027itc.34.1501165685052;
 Thu, 27 Jul 2017 07:28:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Thu, 27 Jul 2017 07:28:04 -0700 (PDT)
In-Reply-To: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
References: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu, 27 Jul 2017 07:28:04 -0700
X-Gmail-Original-Message-ID: <CAMy9T_GeE5Xh7HJ7VZPX5B5SGUmjUbELER07-u0se5Y0ZJ5YtQ@mail.gmail.com>
Message-ID: <CAMy9T_GeE5Xh7HJ7VZPX5B5SGUmjUbELER07-u0se5Y0ZJ5YtQ@mail.gmail.com>
Subject: Re: reftable [v3]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1C37URlpsKlPxaLrSjeTA6PH501y
        AYxRXDYpqTmZZalF+nYJXBknLxxgLnhuU7HqxUPWBsY5hl2MnBwSAiYSk1bcYu5i5OIQEtjB
        JHHwywM2COcRk8TeaRvYIZw+Rok9y/pZuxg5gFryJSbstIToLpHYc2kGE4jNKyAocXLmExYQ
        W0hATuLVhhuMELa3xKwT58BqOAUCJfpXTGEHGSMkECBxbHcFSJhNQFdiUU8zWAmLgKrE1/lX
        mCHGJ0pcvNEHNT5A4vbmC2DjhQWMJDrO9oPZIgJqEtsv9LCCnMksMJVR4tiMY2wgCWYBTYnW
        7b/ZJzAKz0Jy3iwkqQWMTKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJTSjcxQoJY
        eAfjrpNyhxgFOBiVeHgffKyMFGJNLCuuzD3EKMnBpCTKO8m0IlKILyk/pTIjsTgjvqg0J7X4
        EKMEB7OSCG/CHaBy3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE76Vv
        QI2CRanpqRVpmTklCGkmDk6Q4TxAw5+A1PAWFyTmFmemQ+RPMRpzXLmy7gsTx5QD278wCbHk
        5eelSonz8n4HKhUAKc0ozYObBktErxjFgZ4T5lUEqeIBJjG4ea+AVjEBrZrYBLaqJBEhJdXA
        WOo+9wTfru4yk9D6G3HLEr45OG16t6/7Uquqz6zVgvezjzSZtx1WKblm0rCiTEC72//0W61L
        tZ81v9s//Ollv0R09zXL6ksnA+/aqjJZHbWs/L7VOGDCsjM3f55aPkt43ZeNig32RbcuGx30
        Chb8cPTW7LLJUzcdYFwysfFdT6Xbc24P3RMz/iuxFGckGmoxFxUnAgCoGlGnHwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your continued work on this.

I have some comments about v3 (inline below).

On Sat, Jul 22, 2017 at 11:29 AM, Shawn Pearce <spearce@spearce.org> wrote:
> 3rd iteration of the reftable storage format.
>
> [...]
> ### Objectives
>
> - Near constant time lookup for any single reference, even when the
>   repository is cold and not in process or kernel cache.
> - Near constant time verification a SHA-1 is referred to by at least
>   one reference (for allow-tip-sha1-in-want).
> - Efficient lookup of an entire namespace, such as `refs/tags/`.
> - Support atomic push `O(size_of_update)` operations.
> - Combine reflog storage with ref storage.

I think that the optimization enabled by obj_records is only
interesting for server-side repositories that will frequently be
fetched from, and which additionally have allow-tip-sha1-in-want
turned on, right? So could we make it explicitly optional?

> [...]
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
>
> The `cnt_rest` field is only present when `block_count >= 0x7` and
> could overflow the `cnt_3` field available in the record start.  This
> encoding scheme is used as the vast majority of abbreviations are
> only one reference (or at most a few), and unlikely to exceed 6 blocks.

I agree that this `cnt_3` handling is overly cute. There will never be
records with `block_count == 0`, will there? Then I propose that
`cnt_3` be set to zero if `block_count` is greater than 7, in which
case the full block count is stored as a varint. It's simpler, and I
think the only `block_count`s for which this scheme costs a byte more
than your scheme are implausible: 128-134, 16383-16390, etc.

> [...]
> ### Log block format

I'm still not happy about how you store reflogs. Here are my objections:

* You store reflogs by appending a high-resolution time to the
refname. This is awkward:
  * There is always some uncertainty about uniqueness, even with a
high-resolution clock. If you want to eliminate that uncertainty, you
have to read the last entry in the reflog for the reference *for every
update* to be sure that your timestamp is not already "in use".
  * There is a need to invent microsecond values on systems with
low-resolution clocks, again to ensure uniqueness.
  * If there is clock skew, then either you lose information about the
*order* of reference updates (which I would consider unacceptable), or
you might have to invent fictional times for new updates to retain the
order relative to previous updates. But inventing fictional times is
very problematic: suppose somebody's clock is incorrectly set to the
year 2020 when they make a commit. As far as Git is concerned, that is
plausible, so the reflog entry gets that timestamp. Then the user
corrects the clock and makes another commit. We would either be forced
to rewrite the old reflog entry(ies) or to give a timestamp in 2020 to
the new update.
* With reftable storage, multiple-reference updates can be done
atomically. But the reflogs don't retain the information about which
references were updated together.
* Even if all reflogs are retained, it is not possible to deduce the
global state of all references at a moment in the past.

I propose to solve all of the above problems, plus some others, as follows:

Let's keep an integer `update_index`, which starts at zero and
increases by one each atomic reference update (i.e., it increases by
one even if the update touches multiple references).

Let's store reflog entries under keys `(refname, update_index)`, and
store the timestamp of the entry *within* the record rather than as
part of the key. The tuple `(refname, update_index)` has to be encoded
somehow that ensures the desired order; see below. This encoding
ensures that the order of reference updates is well-defined regardless
of clock skew, and that one can use the reflog to determine which
references were updated together and what the complete state of
references was after any update (assuming that the user retains all
reflogs).

Let's store in the header of each reftable file the `min_update_index`
and `max_update_index` that are covered by the file. Do this such that
the indexes chain together properly for the reftables in the stack;
i.e. `reftable[n].min_update_index == reftable[n-1].max_update_index +
1`. This has two purposes:
* The current `update_index` can be read quickly from the header of
the top reftable in the stack. When you want to create a new reference
update, you can set its `update_index` to that value plus one and know
that it is unique.
* If the table of contents should somehow get lost, the order of the
reftable files can be reconstructed from their `update_index` ranges.

If a range of reftable files is compacted together, the new file gets
its `min_update_index` from the oldest file being compacted and its
`max_update_index` from the newest file. If reflogs are expired, that
doesn't affect the `min_update_index` or `max_update_index` for the
reftables even if some of the `update_index`es in that range no longer
appear in the file.

How to encode the `(refname, update_index)` tuple so that it sorts the
way we want, namely with entries grouped by refname and backwards in
time? The simplest way would be `refname + \0 + uint32(0xffffffff -
update_index)`, and that should prefix-compress relatively well. One
could squeeze that down a bit by using a custom sort function, but
that would complicate the code, and anyway, zlib hides all sins,
doesn't it?

I'm also still unhappy that completely packing references down to one
reftable will require all reflogs to be fully rewritten, even though
the reflogs will mostly be append-only. And I'm worried that your
comforting numbers about how well the reflogs compress won't apply to
GitHub, because we store lots of information in our reflog messages. I
think that some small tweaks would improve the situation.

Suppose one could create `reflog-only` reftables. Then a `pack-refs`
implementation could choose to create one or more `reflog-only`
reftables at the bottom of the stack for accumulating reflogs (such
files would rarely have to be compacted), and on top of that a big
reftable holding most of the reference values, and on top of that
multiple small reftables containing both reference values and reflogs
(for recent updates). Perhaps one would even record in the table of
contents which files in the stack contain what kinds of data, to avoid
(for example) having to open reflog-only files at all if you are only
interested in reference values.

This would require a small amendment to my `update_index` suggestion
above, namely that reflog-only and ref-only reftables might have
overlapping `update_index` ranges, but the end result should be that
the files together cover the whole range of `update_index`es for refs
and also for reflogs.

Michael
