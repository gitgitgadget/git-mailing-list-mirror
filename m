Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48CAD1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 22:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdHCWsb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 3 Aug 2017 18:48:31 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43635 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751736AbdHCWsa (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2017 18:48:30 -0400
X-AuditID: 12074413-66dff70000000aee-b3-5983a83c739a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 48.D8.02798.C38A3895; Thu,  3 Aug 2017 18:48:29 -0400 (EDT)
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com [209.85.223.177])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v73MmSTX013168
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 3 Aug 2017 18:48:28 -0400
Received: by mail-io0-f177.google.com with SMTP id o9so328984iod.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 15:48:28 -0700 (PDT)
X-Gm-Message-State: AHYfb5j99ttuAt3/Ep1BFk577nHvrWsqj78dNzTTbdS/W5IdDqU8a1yH
        Juuhijf28/lZrBrSiDQwXbOKZrFFSA==
X-Received: by 10.107.187.135 with SMTP id l129mr498509iof.122.1501800507531;
 Thu, 03 Aug 2017 15:48:27 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Thu, 3 Aug 2017 15:48:26 -0700 (PDT)
In-Reply-To: <CAJo=hJvNgX06gkXp2Vsx=cSkcxRO9aRzOit6vvi4fqL3QeDsEg@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
 <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
 <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
 <CAMy9T_G5xorPGp=5=p_ku3RhB1E-c9+4mEgYhbyAhLdc1V=JBg@mail.gmail.com> <CAJo=hJvNgX06gkXp2Vsx=cSkcxRO9aRzOit6vvi4fqL3QeDsEg@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu, 3 Aug 2017 15:48:26 -0700
X-Gmail-Original-Message-ID: <CAMy9T_EU6hPbnnB72ouRAd0yNvWn6_Ef8Bh2iPxChpmDt1qmFw@mail.gmail.com>
Message-ID: <CAMy9T_EU6hPbnnB72ouRAd0yNvWn6_Ef8Bh2iPxChpmDt1qmFw@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqGu7ojnS4MhZHouuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGVcWN3AUrCkvuL8+7eMDYwLo7sYOTkkBEwklrZtYuli5OIQEtjB
        JHHn621mCOcJk8TFxj+MEE4Po8Ts3hnMEC35ErvnXGCFsEsl3rTdYQSxeQUEJU7OfMICYgsJ
        yEm82nCDEcL2kpjVdBusnlMgUGLphA5WiKE/mCWar18Da2AT0JVY1NPM1MXIwcEioCIx95QO
        xPxEiR87JjJBzA+Q+HpvLthMYQEjiY4L+8DuERFQk9h+oQdsJrPAVEaJYzOOsYEkmAU0JVq3
        /2aHsLUlli18zTyBUWQWkltnISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73c
        zBK91JTSTYyQwBfewbjrpNwhRgEORiUeXoMZzZFCrIllxZW5hxglOZiURHmrjzVFCvEl5adU
        ZiQWZ8QXleakFh9ilOBgVhLhLVkAVM6bklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBa
        BJOV4eBQkuDlWQ7UKFiUmp5akZaZU4KQZuLgBBnOAzS8ahnI8OKCxNzizHSI/ClGS44rV9Z9
        YeKYcmA7kJzze8cXJiGWvPy8VClxXnOQBgGQhozSPLiZsET2ilEc6EVh3uUgq3mASRBu6iug
        hUxAC//UNYIsLElESEk1MG4wFN26i/ljj6FDfLHkpa/5TYZBaZpiU97MC1wdbB07d/3mxN2n
        Zl7cxi7wTFmtVue2/qK2DXfY+BdNl+H95mO89dbfdev2HPJTfftUaVJqs9zBP+cvNkx6tzNt
        3TKPtI9XprNcyhXdzHBnxhW93FebDW+/jE3rNvH4ebJ1Guepk5ek7P+XLmRQYinOSDTUYi4q
        TgQAKnXpLD8DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've revised the blockless reftable proposal to address some feedback:

* Don't omit `prefix_len` for the first ref and first child in a
block. It doesn't save much but makes the reader more complicated.
* Get rid of `symref_target` (the backlink from a reference to the
symlink(s) that point at it). It is a solution to a problem that is
not worth solving.
* Get rid of the `SYMREF_PEELED` type. It is impossible to maintain
this field affordably without `symref_target`, but it seems fragile
and unnecessary anyway.
* Add a way to mark a reflog entry "deleted" without having to rewrite
everything. This is mostly meant to deal with `refs/stash`.
* Define an extension mechanism.
* Define the SHA-1 → object mapping as an extension rather than as
part of the main spec. My gut feeling is that it will never be
implemented for git-core.
* Revise how the SHA-1 → object mapping works:
    * Merge the bottommost OBJ_INDEX node with the old OBJ nodes to
form a new OBJ_LEAF node.
    * Allow the branching factor of each node to be specified
independently (to allow the node sizes to be matched more closely to
the preferred read sizes).
* Rename some fields for clarity.

I currently lean towards the opinion that we should store pseudorefs
(like `FETCH_HEAD`, `MERGE_HEAD` *outside of* reftables, except for
`HEAD` (which behaves more like a normal reference, which is
considered for reachability, and for which we want to retain reflogs),
which we should store *in* reftables.

I don't talk at all about how individual reftable files are stacked
together, because that is pretty much unchanged from Shawn's proposal.
The only thing I would suggest is to give the reftable files names
that indicate whether they include reference values, reflogs, or both,
so that readers can tell from the table of contents which files they
have to open.

The new proposal follows:

Definitions:

Varint encoding is similar to the unsigned varint encoding used for
protocol buffers; i.e., a little-endian base-128 format where the most
significant bit is used to indicate that another byte is coming.
Decoding is as follows:

```
val = *ptr & 0x7f
while (*ptr++ & 0x80) {
    val = (val << 7) | (*ptr & 0x7f)
}
```

Strings are usually encoded using `varstr` encoding, which is the same
as how strings are encoded in protocol buffers. A `varstr` consists of
a `varint` length followed by the specified number of bytes holding
the contents of the string. `varstr` strings are not intrinsically
NUL-terminated.

The `chunk_length` fields encode the total size of the containing
chunk, including its `chunk_type` field.

```
varstr(s) = {
    varint(strlen(s))
    s
}
```

```
reftable = {
    header
    [chunk | padding]*
    footer
}

header = {
    'REFT'
    uint8( version_number = 1 )

    # The length of the whole header, in bytes:
    header_length : uint16

    metadata
}

footer = {
    'REFT'
    uint8( version_number = 1 )
    metadata

    # The length of the whole footer, in bytes:
    footer_length : uint16

    uint32(CRC-32 of previous part of footer)
}

metadata = {
    # if `contains_values` is false, this file *must not* contain any
    # reference values; i.e., `value_type` must always be `NO_VALUE`.
    contains_values : bool

    # if `contains_logs` is false, this file *must not* contain any
    # reflog entries; i.e., `log_type` must always be `NO_REFLOG`.

    contains_logs : bool

    # If `offsets_negative` is true, then all `*_offset` fields point
    # backwards in the file; i.e., the corresponding varint value is
    # negated before use.
    offsets_negative : bool

    # update_index is a counter that is incremented by one for each
    # atomic reference update affecting a stack of reftables (even if
    # the reference update changes multiple references). Counting
    # starts at 1 (0 is used as a special value). The following two
    # fields indicate that this reftable file covers update_indexes in
    # the range
    #
    #     min_update_index < update_index <= max_update_index
    #
    # , with the possible exception of LOG_DELETED entries.

    max_update_index : uint64
    min_update_index : uint64

    # To accomodate systems that have to write files serially, the
    # following two entries can be zeroed out in the header to tell
    # the reader that it has to read the corresponding values from the
    # footer.

    # The file offset of the chunk containing the root of the
    # reference tree:
    ref_root_chunk_addr : uint64

    # This space can be used to add extensions to the file format. It
    # is included in `header_length` / `footer_length` to allo older
    # readers to skip over any extensions that it doesn't understand.
    extension*
}

extension = {
    # The name of the extension:
    extension_name : varstr

    # The address of the first block of data associated with the extension:
    extension_root_chunk_addr : uint64
}

chunk = {
    # The `chunk_type` determines how to interpret the payload, and
    # influences how to compute its length (which is needed to advance
    # to the next chunk).

    chunk_type : enum PAD_BYTE | PADDING
                    | INDEX | REFS
                    | EXTENSION

    if chunk_type == PAD_BYTE {
        # This chunk type can be used to add a single byte of padding,
        # which would otherwise be impossible because a `PADDING`
        # chunk requires a minimum of two bytes.
    }
    elif chunk_type == PADDING {
        # A form of padding that's cheaper to skip over than
        # `PAD_BYTE`.

        # The total number of bytes in this chunk, including
        # `chunk_type`. The contents will otherwise be ignored:

        chunk_length : varint
    }
    elif chunk_type == INDEX {
        chunk_length : varint
        children : {
            # Length of prefix being carried over from the previous
            # record (always zero for the first child in a chunk):
            prefix_len : varint
            suffix : varstr
            index_payload
        }*
    }
    elif chunk_type == REFS {
        chunk_length : varint
        refs : {
            # Length of prefix being carried over from the previous
            # record (always zero for the first reference in a chunk):
            prefix_len : varint
            suffix : varstr
            ref_payload
        }*
    }
    elif chunk_type == EXTENSION {
        chunk_length : varint
        # Additional data may be present here. It should be ignored by
        # readers that don't know about the extension.
    }
}

index_payload = {
    # The number of bytes from the begining of this chunk to the child
    # chunk. If child_offset is zero, then there are no entries in
    # this reftable whose refnames start with the specified prefix.
    #
    # The child pointed at is of type INDEX (another index chunk
    # containing the next finer level of detail) or of type REFS. In
    # either case, the first record in the pointed-to chunk must have
    # `prefix_len == 0` and contain the entire key as `suffix`.
    child_offset : varint
}

ref_payload = {
    value_type : enum NO_VALUE
                    | DELETED
                    | VALUE | VALUE_PEELED
                    | SYMREF
                    | SPECIAL
    log_type : enum NO_REFLOG | REFLOG | REFLOG_COMPRESSED

    if value_type == NO_VALUE {
        # This type is used if we need to store a reflog entry but
        # have no reference value to store in this file.
    }
    elif value_type == DELETED {
        # This type indicates that the reference has been deleted,
        # regardless of what any reftables deeper in the stack claim.
    }
    elif value_type == VALUE {
        # This is a normal (non-symbolic) reference.
        sha1 : uchar[20]
    }
    elif value_type == VALUE_PEELED {
        # This is a normal (non-symbolic) reference that points at a
        # tag. `peeled` is the reference peeled down to a non-tag.
        sha1 : uchar[20]
        peeled : uchar[20]
    }
    elif value_type == SYMREF {
        # This is a symref that points at a non-existent branch.
        target : varstr
    }
    elif value_type == SPECIAL {
        # This is one of the special references (like FETCH_HEAD,
        # MERGE_HEAD). The contents are stored as they would be in a
        # loose reference file:
        contents : varstr
    }

    if log_type == NO_REFLOG {
    }
    elif log_type == REFLOG {
        log_entry_length : varint
        log_entry
    }
    elif log_type == REFLOGS_COMPRESSED {
        compressed_length : varint
        zlib_deflate(
            log_entry*
        )
    }
}

# Log entries are stored from oldest to newest. The "chained" variants
# of `log_type` take their `new_id` from the current value of the
# reference (if it is the first log entry for the references) or from
# the preceding (i.e., next newest) log record's `old_id` value.
log_entry = {
    # `CREATE_CHAINED` and `UPDATE_CHAINED` take their `new_id` from
    # the preceding (i.e., next newest) record's `old_id` value.
    log_type : enum END_OF_LOG | LOG
    old_type : enum ABSENT | REF | SYMREF
    new_type : enum ABSENT | REF | SYMREF | CHAINED

    if log_type == LOG {
        # The update_index of this entry, or 0 if there are no more
        # entries. log_entries are always stored in order from largest
        # to smallest update_index.
        update_index : varint

        # `PUSHER_CHAINED` takes its `name` and `email` from the preceding
        # (i.e., next newest) record's fields.
        pusher_type : enum PUSHER_EXPLICIT | PUSHER_CHAINED

        if new_type == ABSENT {
        }
        elif new_type == REF {
            new_id : uchar[20]
        }
        elif new_type == SYMREF {
            new_ref : varstr
        }
        elif new_type == CHAINED {
        }

        if old_type == ABSENT {
        }
        elif old_type == REF {
            old_id : uchar[20]
        }
        elif old_type == SYMREF {
            old_ref : varstr
        }

        time_seconds : uint32
        tz_offset_minutes : sint16
        if pusher_type == PUSHER_EXPLICIT {
            name : varstr
            email : varstr
        }

        # The reflog message. For a bit more compression:
        #
        # * Many messages contain old/new SHA-1s for the reference
        #   updates. That redundancy could be eliminated by replacing
        #   the old SHA-1 with `%o`, the new one with `%n`, and `%`
        #   with `%%`.
        #
        # * Some "standard" log messages (i.e., the ones generated by
        #   Git itself) could be hard-coded as additional `log_type`
        #   constants.
        message : varstr
    } else if log_type == LOG_DELETED {
        # An entry of this type indicates that any reflog entries for
        # this reference in reftables with `update_index >
        # next_retained_update_index` should be ignored (either they
        # have been deleted or they have been superseded by entries in
        # this reftable). This feature will mainly be used for `git
        # stash drop` and related commands. Such an entry, if it
        # exists, must be the last (or only) log_entry in the
        # ref_payload.
        next_retained_update_index : varint
    } else if log_type == END_OF_LOG {
    }
}
```


## Object → reference lookup extension

This extension allows one to determine efficiently which references
(if any) point at an object with a specified name.

This data is structured as an N-way trie whose branching factors can
vary from level to level. There are two kinds of nodes:

* Internal nodes (composed of chunks of type `OBJ_INDEX`): always
  point to other chunks of type `OBJ_INDEX` or `OBJ_LEAF`.

* Leaf nodes (composed of chunks of type `OBJ_LEAF`): can also include
  branching, but the individual items point at `obj_record`s within
  the same `OBJ_LEAF`.

Each `obj_record` within an `OBJ_LEAF` node points at one or more
`REFS` chunks that contain references that point at an object whose
name starts with the indicated prefix. To find the name(s) of
reference(s) that point at your SHA-1, you have to read the `REFS`
chunk and compare the target SHA-1s to yours.

```
objref_extension = {
    extension_name : varstr("objref")

    # The file offset of the chunk containing the root of the object
    # trie. This value must be zero (or the extension must be absent)
    # if `contains_values` is false:
    obj_root_chunk_addr : uint64
}

objref_chunk = {
    chunk_length : varint

    objref_chunk_type = OBJ_INDEX | OBJ_LEAF

    # The degree of branching at this node is `1 << radix_bits`. For
    # `OBJ_LEAF` nodes, it is allowed for this to be zero:
    radix_bits : uint4

    if objref_chunk_type == OBJ_INDEX {
        # The offset, relative to the start of this chunk, of the
        # chunk containing the next level of the obj index, for each
        # of the possible "next" bytes in the SHA-1, or zero if there
        # are no references with the given next byte.
        child_offset : varint * (1 << radix_bits)
    }
    elif objref_chunk_type == OBJ_LEAF {
        # The total number of SHA-1 bytes that are included in the
        # SHA-1 prefixes corresponding to each child, including those
        # accounted for by the `radix_bits` of all of the ancestor
        # nodes:
        prefix_bytes : uint4

        # The relative address, within this chunk, of the obj_record
        # for each combination of the next `radix_bits` bits of the
        # SHA-1, or zero if there are no references with the given
        # next byte.
        obj_record_addr : varint[1 << radix_bits]

        # The object records for the SHA-1 prefixes referred to above:
        obj_record*
    }
}

obj_record = {
    # The bytes `sha1[floor(sum(radix_bits) / 8) : prefix_bytes]` of
    # the SHA-1 being described (see below):
    prefix : uchar[n]

    # The number of child_addrs:
    count : varint

    # File offsets of the chunks containing references that point at
    # objects with this prefix:
    child_addr+ : varint
}
```

On Thu, Aug 3, 2017 at 3:26 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Thu, Aug 3, 2017 at 11:38 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On Tue, Aug 1, 2017 at 7:38 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>> On Tue, Aug 1, 2017 at 6:51 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>> On Tue, Aug 1, 2017 at 4:27 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>>>> On Mon, Jul 31, 2017 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>>>> [...]
>>>>> A couple of other notes about your contrasting design:
>>>>>
> ...
>>>> OBJS blocks can also be
>>>> unbounded in size if very many references point at the same object,
>>>> thought that is perhaps only a theoretical problem.
>>>
>>> Gah, I missed that in reftable. The block id pointer list could cause
>>> a single object id to exceed what fits in a block, and that will cause
>>> the writer to fail unless its caller sets the block size larger. I
>>> basically assumed this overflow condition is very unlikely, as its not
>>> common to have a huge number of refs pointing to the same object.
>>
>> Given what Peff pointed out, let's just leave this as a varint for OBJS blocks.
>
> We discussed this at $DAY_JOB yesterday. We realized that if an obj
> block has that many ref pointers present, it may be more efficient for
> a reader to scan all references instead of chasing those pointers
> individually. Latest draft of reftable now omits the ref pointer list
> in an obj block if it exceeds the obj block size, which only occurs
> when a high proportion of the ref blocks contain that SHA-1.
