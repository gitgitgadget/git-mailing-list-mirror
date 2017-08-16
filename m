Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29184208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 06:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbdHPGPr (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 02:15:47 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:32802 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdHPGPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 02:15:47 -0400
Received: by mail-yw0-f180.google.com with SMTP id p68so17050503ywg.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 23:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RhPMBtP+FHmseDjMU5ojr3UP52bfdrUaBnpARtN2Ac8=;
        b=Qcw7/3vwxxLYzoL0HE2+iUU3/6XQDx9lpRtbcsilKz9XlH3ejgBpMMa6O6u1MXJA4F
         pqfDG11glBEFHWfg7XfgmgepPePo7wLKWprHuOBNppJAL39xjB12ZzClV1OIfJc7ZYTv
         rvhqExLYsawcvV62xSgBaat4Eoe6TeqbB5Rj1YS2OUAv2STnx3U8+Ui1WeLIgfTxlyX8
         2DK78qstlmBmhnfPe0ioh/Q/mh5bQRENTR9ZBxFvgp/H7r2J2tAkrKBk/T5tIZUtih9G
         Vup4xIA/Apr7J7qFYYubqAXfUf+yZrfNoGtnQiakWXKzj5qI9K1AeTfaaMIZkdX8GpJY
         lSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RhPMBtP+FHmseDjMU5ojr3UP52bfdrUaBnpARtN2Ac8=;
        b=ic7nyxpF6MZ77V3VwcIRHoAxS8TDbJRi+7jTEqY7MEdOxnmwvljk+5kUyhNGh+oh+A
         OSh1zf7BpF1uPnIiRp9q7nY1nMC8FuEx1fXj5NT4E3z37lyXL5XYNfLEIMgofLB3DjOe
         +yeYkH1oz27SF391px87J+FDQyCPOkUvDnVZqSsX1hUa8j+zSKdA7CP9/jbl2wGTfKqW
         m9jBatIKCi8uVlQlE04DTjP7UOuaNJry8fTS67S8CuIVX6xswI0jMibDfIMlal4vknTs
         iI2gTECZUDHYNYiIiEFUgEqShJ6ZSqBspon7hEV8N99/3kRTRVyYNaLmS7QVZntDJBrv
         YdYw==
X-Gm-Message-State: AHYfb5gtVn1lg/IQcfsoPOvxoXFkQ4zprRQo1PfWZajxUQ5rY60338RL
        BPdiSpbSmwggTSooO8TqcyofC4XAKDPqF7IYMQ==
X-Received: by 10.129.120.4 with SMTP id t4mr461334ywc.422.1502864146147; Tue,
 15 Aug 2017 23:15:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 23:15:45 -0700 (PDT)
In-Reply-To: <CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com>
References: <CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 23:15:45 -0700
Message-ID: <CAGZ79kZ4m0-KBFs1pbOvRqkR=0vn-Jbn1FATL_KzW+km0K-S2A@mail.gmail.com>
Subject: Re: reftable [v7]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 7:48 PM, Shawn Pearce <spearce@spearce.org> wrote:
> 7th iteration of the reftable storage format.
>
> You can read a rendered version of this here:
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>
> Changes from v6:
> - Blocks are variable sized, and alignment is optional.
> - ref index is required on variable sized multi-block files.
>
> - restart_count/offsets are again at the end of the block.
> - value_type = 0x3 is only for symbolic references.
> - "other" files cannot be stored in reftable.
>
> - object blocks are explicitly optional.
> - object blocks use position (offset in bytes), not block id.
> - removed complex log_chained format for log blocks
>
> - Layout uses log, ref file extensions
> - Described reader algorithm to obtain a snapshot

- back to the old "intra-block index is last"
  for all block types. ok.
- changed (only ref?) indexes to start char + 3 byte size:
  Which starting char do object/log indexes have?

"Unaligned files must include the ref index to support fast lookup."

Why this? I would imagine the client (which has ~5 branches),
would not need this, but only a ref block, that's it.

Ctrl-F for 'block_size' reveals nothing is computed
relative to the block_size in this format, yet we can
set it to an arbitrary number. If following the spec,
the reader at $DAY_JOB needs to be able to read
both aligned and unaligned reftables, despite our plan
to ever write aligned ref tables, what would the reader
use the block_size for? (I think we can omit that field
from the header/footer now, no?)
