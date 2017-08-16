Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611631F667
	for <e@80x24.org>; Wed, 16 Aug 2017 15:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbdHPPyd (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 11:54:33 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:35109 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHPPyc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 11:54:32 -0400
Received: by mail-ua0-f177.google.com with SMTP id d29so15450845uai.2
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hof9ST28dLYIymV/sc8herRj7nK1D1FjU+etO7Pja5Y=;
        b=d4OlkHlT+Cb6hLY3uFBjXVnDlEy6SaG/XU5uYjLldFxYNbNU7Cm0Sl9ViJLXnAx0Fr
         BYLxwEWNjm/qnpIkzcZ5qiknjlsn2wZSqgKhQxrYRy/+piT+F/iCSRs598vdgx7TcbR4
         VvhDILlm/XcTRopFiU7cwXjMjKlKSFnGtsiTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hof9ST28dLYIymV/sc8herRj7nK1D1FjU+etO7Pja5Y=;
        b=FKq37P4rP7qcvFsWCpE9FMx3EXcBLrvlfntNVfAmfkBJ0ZzZYeEFUBJujh7G27PC/2
         gBVO5g1eVpub5aNugX3VTJz7eNAd4kP3V2mCqvPue+LH+lYobxcNiR6MNNT1FKJR0OU+
         4lMGPOKRChDKNhtvnDiCAYhnGRNxGq/iAi/vkULavMJOYD90DvK+lx93ZkcUanT/IFpy
         7wuAMUPihdichRY1FpL/bcYWVkd6Al9d16tDczuuH7Qm/g0qELOP3le6GPOxDtBwLABH
         wK5FgVqmrmSU889SiVDA6nRpAer/5dnqmdvx9mKMnwOZFu733f9PFjZ/5tOLfikDRDSD
         sL3w==
X-Gm-Message-State: AHYfb5jJmfJgBKvyHz4ZLnLPrgVWO8EYTujw9amTM9QceYT+4D/so62C
        bofZkPNBWPo0/Kvs8SJWS4H3+1j7OiU7
X-Received: by 10.176.71.17 with SMTP id h17mr1202579uac.138.1502898871154;
 Wed, 16 Aug 2017 08:54:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Wed, 16 Aug 2017 08:54:10 -0700 (PDT)
In-Reply-To: <CAGZ79kZ4m0-KBFs1pbOvRqkR=0vn-Jbn1FATL_KzW+km0K-S2A@mail.gmail.com>
References: <CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com>
 <CAGZ79kZ4m0-KBFs1pbOvRqkR=0vn-Jbn1FATL_KzW+km0K-S2A@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Wed, 16 Aug 2017 08:54:10 -0700
Message-ID: <CAJo=hJtAL9SX5Z4XyNFS5L+H3j3OaTe6t-ug7oefpNMXHh525A@mail.gmail.com>
Subject: Re: reftable [v7]: new ref storage format
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 11:15 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Aug 15, 2017 at 7:48 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> 7th iteration of the reftable storage format.
>>
>> You can read a rendered version of this here:
>> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>>
>> Changes from v6:
>> - Blocks are variable sized, and alignment is optional.
>> - ref index is required on variable sized multi-block files.
>>
>> - restart_count/offsets are again at the end of the block.
>> - value_type = 0x3 is only for symbolic references.
>> - "other" files cannot be stored in reftable.
>>
>> - object blocks are explicitly optional.
>> - object blocks use position (offset in bytes), not block id.
>> - removed complex log_chained format for log blocks
>>
>> - Layout uses log, ref file extensions
>> - Described reader algorithm to obtain a snapshot
>
> - back to the old "intra-block index is last"
>   for all block types. ok.

Yes, it simplifies "streaming writers" who don't want to buffer a lot.

> - changed (only ref?) indexes to start char + 3 byte size:
>   Which starting char do object/log indexes have?

All index blocks use 'i'.

> "Unaligned files must include the ref index to support fast lookup."
>
> Why this? I would imagine the client (which has ~5 branches),
> would not need this, but only a ref block, that's it.

The quoted part is I think incomplete. Unaligned files need the ref
index if there is more than one ref block, as there is no way to
divide the space for binary search. A single ref block with 5 branches
does not need the ref index.

> Ctrl-F for 'block_size' reveals nothing is computed
> relative to the block_size in this format, yet we can
> set it to an arbitrary number. If following the spec,
> the reader at $DAY_JOB needs to be able to read
> both aligned and unaligned reftables, despite our plan
> to ever write aligned ref tables, what would the reader
> use the block_size for? (I think we can omit that field
> from the header/footer now, no?)

Its really helpful to be present for the reader to know how to locate
and read blocks. If the ref index is missing and there are multiple
ref blocks in an aligned file, a reader can use block_size to divide
the space and perform binary search. Even when the ref index is
present, the reader can use block_size to issue a disk IO read of
block_size bytes without reading the block_len of the target block
first.

At $DAY_JOB the block_size is tunable by the writer and could change
at any time, so its useful to have it embedded in the output.
