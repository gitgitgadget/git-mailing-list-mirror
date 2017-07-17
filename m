Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4591820357
	for <e@80x24.org>; Mon, 17 Jul 2017 19:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdGQTvq (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 15:51:46 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35683 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdGQTvp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 15:51:45 -0400
Received: by mail-pg0-f49.google.com with SMTP id v190so26949353pgv.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DcHGtlHd4M3Qlwf+SQQRZW8UkhDiu/emVrVuduN0qdg=;
        b=WHJ1oUVUnCg1P827jlzam3wWElkNDBLVnJ5B4UTUOby35jOrLRi3pWTGEmx+gESIXC
         2UaSZvG3FAUxQwRxD9kETUcR9M+kdGqhNmYiukM9wHzEP5Te54NhfDQyQ1I7Obpf5KtS
         MCCq65EiUyFf1GG/oasYg6edSGRdXLtonGdtT/upVMsuC98OPFkFH3xc54ZLHfDKe9nm
         4Ds9LK739FtPzfdMGxpYKufW5Dq+EDls6E7b5g+Vp1vh595zl5A6VgBhrIOvF4NXzLRX
         WOyKHa1eXZvfZNwIjeRV4zhBuBFmEWVXKNpaW2kjDRUwJEINhbwBvBXeyzsbS/o0rSsm
         FgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DcHGtlHd4M3Qlwf+SQQRZW8UkhDiu/emVrVuduN0qdg=;
        b=JkO8eRo+VWzrpnFnnQsU0PVGUsKqwMCp7pX6CoybzBtuOzootPsu5jTTNoKn8GIH0B
         g6W4XvayMUXuyZ/z9Ekt5/SFQanbK4H9WXhyxE1mpS2Q5iD0BsyNdsqpbsyVAhcDCcJZ
         RfOHJeKIqZbEENVhZnXc7davRgFlDZ+B7EAqb2Sbl0Ovi+nu7nlELvk3pRXF5MOAYSwo
         MF+fzxF7jVe1FPnuefo6xJ21TyqsrvJRBL4d3yi5nBqojocYvzNsDAUtADkX7Fvh8qCV
         PpOWnljV6lTXdOWH+MM7tEU6uOMjKsnsGw39/jk1d9WR3HIdgChw+bz6wk9oOtvoJ39q
         dYKg==
X-Gm-Message-State: AIVw112a/oaoVQ6GsdkC2EWgKUtl1jkA2rqKuP+pawYWzFoDxcEipKLV
        Z1d/P1vP87kPfo8XHB8=
X-Received: by 10.84.195.3 with SMTP id i3mr31440832pld.65.1500321104872;
        Mon, 17 Jul 2017 12:51:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id g7sm139661pfj.29.2017.07.17.12.51.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 12:51:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>
Subject: Re: reftable [v2]: new ref storage format
References: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com>
Date:   Mon, 17 Jul 2017 12:51:42 -0700
In-Reply-To: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com>
        (Shawn Pearce's message of "Mon, 17 Jul 2017 08:01:44 -0700")
Message-ID: <xmqqlgnmhmep.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> This is an updated draft after discussion on list with Peff, Michael
> Haggerty, and Dave Borowitz.
>
> You can read a rendered version of this here:
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>
> Biggest changes from the first proposal are:
>
> - reflog is now integrated into reftable
> - block headers slightly different
> - Peff's stack management idea is used
> - Michael's compaction idea is used

Just a few comments.

> A variable number of 4-byte `restart_offset` values follows the
> records.  Offsets are relative to the start of the block (0 in first
> block to include file header) and refer to the first byte of any
> `ref_record` whose name has not been prefixed compressed.  Readers can
> start linear scans from any of these records.

It is unclear what "0 in first block to include file header" wants
to say.  Do I write "8" if I want to express the offset of the first
record in the first block, or do I write "0"?

> The 2-byte `number_of_restarts + 1` stores the number of entries in
> the `restart_offset` list.

It is unclear whose responsibility it is to add this "1".  Does this
mean a reader thinks there is one entry in the restart table when it
sees "0" in the number_of_restarts field (hence you can have max
65536 entries in total)?

> Readers can use the restart count to binary search between restarts
> before starting a linear scan.  The `number_of_restarts` field must be
> the last 2 bytes of the block as specified by `block_len` from the
> block header.

Does the new term "restart count" mean the same thing as
number_of_restarts?

> ### Log block format
>
> A log block is written as:
>
>     'g'
>     uint24( block_len )
>     zlib_deflate {
>       log_record*
>       int32( restart_offset )*
>       int16( number_of_restarts )
>     }
>
> Log blocks look similar to ref blocks, except `block_type = 'g'`.

Is there a general recommended strategy for writers to choose how
many entries to include in a single physical block?  I understand
that the deflated whole must fit in the physical block whose length
is defined in the footer of the whole file, and in general you would
not know how small the data deflates down to before compressing,
right?

> Log record keys are structured as:
>
>     ref_name '\0' reverse_int32( time_sec )
>
> where `time_sec` is the update time in seconds since the epoch.  The
> `reverse_int32` function inverses the value so lexographical ordering
> the network byte order time sorts more recent records first:
>
>     reverse_int(int32 t) {
>       return 0xffffffff - t;
>     }

Is 2038 an issue, or by that time we'd all be retired together with
this file format and it won't be our problem?

As the file format uses delta compression with restarts, a reader
needs to sequencially scan some bounded number of entries to get the
contents of a specific entry anyway, so I am wondering if it is
worth storing a longer timestamp in varint() for an restart entry
and express the timestamp on delta entries as difference to the
previous entry.

> ### Log index
>
> The log index stores the log key (`refname \0 reverse_int32(time_sec)`)
> for the last log record of every log block in the file, supporting
> bounded-time lookup.

This assumes that timestamps never wildly rewind in the reflog,
doesn't it?  Is that a sensible assumption?

Or does "the last log record" in the above mean "the log record with
largest timestamp?  ... ah, not that is still not sufficient.  You'd
still need to assume that timestamps on entries in one log block must
be all older than the ones on entries in later log blocks.  Hmph...

Also it is not clear to me how reflogs for two refs would be
intermixed in the log blocks, and what log keys for the entries must
be recorded in the log index, to facilitate efficient lookup.  Is it
assumed that a consecutive sequence of log blocks record reflogs for
the same ref, before the sequence of log blocks switch to record
reflogs for another ref, or something?

> A log index block must be written if 2 or more log blocks are written
> to the file.  If present, the log index appears after the first log
> block.  There is no padding used to align the log index to block
> alignment.
>
> Log index format is identical to ref index, except the keys are 5
> bytes longer to include `'\0'` and the 4-byte `reverse_int32(time)`.
> Records use `block_offset` to refer to the start of a log block.

I am assuming that we do not care about being able to quickly
determine master@{24028}; I would imagine that it wouldn't be too
hard to add an index to help such query, but I offhand would not
know the details until I figure out how the format handles reflog
entries for multiple refs first.
