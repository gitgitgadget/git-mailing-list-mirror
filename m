Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9243208B4
	for <e@80x24.org>; Mon, 31 Jul 2017 19:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbdGaTBQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 15:01:16 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35156 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbdGaTBP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 15:01:15 -0400
Received: by mail-lf0-f42.google.com with SMTP id t128so87776119lff.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s6HdwW4LtnvjCHEEvDvrHhN8HBvOZMswTzFs3E+Pu6M=;
        b=XdMA1+meBOTP+fnz5DJlxKLvSo4dIch32RsNqDpMgg5GFdcO6ol76k2Q/BlpZnIvlq
         bVMaStf8qTKjzPTp5GhyDweCHNgIU77oozq5x3l8GDWmlYhl4ST56lvukxVqSy6dCDfn
         x/JNA3rRZDGr/PFqiRHOVN204in/MccGYuG4hEP4sPS8urIwZ8LjP4n3inOJHRQlhRPd
         XAjSoj1XAPMn7JQI+vB/RxOdSlk1KU2OsOC8+EIADuVYJo+q3EC3FpgfzbhpkCRsONpz
         8iZSSWBsXbn00P+xh4cGIZwzVbMuAUrDB8w77/1mAy9f3hbzKYu+LQFhOxNuLDyCQIeR
         dmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s6HdwW4LtnvjCHEEvDvrHhN8HBvOZMswTzFs3E+Pu6M=;
        b=IOJegP7nznhAXnKlWsvVdq1DNg1SYuIE7bPn2TFrcdKdeRRPbVPF23YIvCiuKwpTRc
         4QDG6s6/OVU/iuch/nm055DHQDC85vWLJStDVHf5gMVewPAiRYY6vcG2VMet3sU3UXQH
         K3sNiUtZEQ+yVZQNF0hHBvAb3elsQaVHhELDGUsml3WAaugmGNVH0wX1g5JBMLmZKImJ
         0KUcFb2ffK+YCX62iX45HXTfKOe6uj9QC/61hLjy53FrisIT9QdVY5vOaXKtOjg0LV0g
         h2BLojo9ocwSrzgNQvl/JafwLBELtRhZd4nEcloqaTM7/aj9kcGIG5OXHCDo1Pec3N1o
         4csw==
X-Gm-Message-State: AIVw113dGli7nY0B1LLe1nzNzscg+idXWTGefI8BOMogEOQsE4S09YvO
        DdeYV58CQs482ayQvefNvcqUnDhrhhJ8
X-Received: by 10.46.32.41 with SMTP id g41mr5889545ljg.96.1501527673669; Mon,
 31 Jul 2017 12:01:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 12:01:13 -0700 (PDT)
In-Reply-To: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 12:01:13 -0700
Message-ID: <CAGZ79kZ3vbpzSEMHVHMtF0drY1P1rgz1eB7OB-J31-y6K+x5sw@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
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

On Sun, Jul 30, 2017 at 8:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
> 4th iteration of the reftable storage format.
>
> You can read a rendered version of this here:
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>
> Significant changes from v3:
> - Incorporated Michael Haggerty's update_index concept for reflog.
> - Explicitly documented log-only tables.

I have read through v4 and I was missing the rationale
to why this is a good idea, digging up the discussion for
v3 seems to indicate that reflogs and refs themselves have
different usage patterns such that different compaction patterns
are desired, hence we need to have different files for them.

> ### Ref block format
>
> A ref block is written as:
>
>     'r'
>     uint24( block_len )
>     ref_record+
>     uint32( restart_offset )+

As the block_size is encoded in uint24, (and so is block_len),
the restart offsets could be made uint24 as well, though that may
have alignment issues, such that reading may be slower.
But as the ref_records may produce unaligned 32 bit ints
already, I am not worried about that.

>     uint16( restart_count )

When looking for 16/32/64 bit hard coded ints I came across
this one once again. How much more expensive is reading
a varint? As the block_len points at the restart_count, we cannot
replace it with a varint easily, but we could use a byte-reversed
varint instead. If we do this step, all restart offsets could also be
(reverse) varints?
