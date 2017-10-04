Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DCC72036B
	for <e@80x24.org>; Wed,  4 Oct 2017 00:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbdJDA32 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 20:29:28 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:48419 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdJDA3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 20:29:03 -0400
Received: by mail-io0-f182.google.com with SMTP id f72so2710117ioj.5
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 17:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WSOqGR6fPTu/EGhGSItGEj3bK3P9Yy0dsrhyRZqDF5M=;
        b=EbcyoouYz80syOBP/OqwJCL4XSHyB6i8RanFOxYFdG2JzI4V/ezbAbH+HlNfQmDU0B
         dk3gc0H9hf5ARuKvXXFE55uP8sMddf1RI//v/eyW7JMP6OK8RHnnSW2184rQWYOEj0+y
         puJtzVjDpyLxIn/JALrl240/GP13wM0Uue1FhLmVnw562QN9RuLQ73SgZPraEtGSHl2D
         AQ0plcnAR9dwag5edhgR7wBOv7khRl3y578YmQuAXNNEWckWdQsTmAyOgiMwnbkakygr
         PFuejZIjFYEnreerLqFircH8L7YAgLFiczwl/RLgiYVrklpPaWNW7498k5OVr2VAyUcq
         DRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WSOqGR6fPTu/EGhGSItGEj3bK3P9Yy0dsrhyRZqDF5M=;
        b=FrJVZ4gpoheLtL4Hm5ttvTJ+76j4K40D/2EhbuJ2UMLKDfIpcVwN/8snaOfYiCtQsK
         DA0KhBTEPm7uZazpdeI0Lbr5lxMs+BDGJRcmtnBqKDsIBiG9ORkvg/qw84p6Ycq8tHnz
         55efFB+K9bkakrP94LStNzX1mIBUMR4aj3Ou+kKYVDaV+V697o3W7LMB+WTN99D/u18+
         AKoC2/JrVTqgpNAlwjWS8JAnHxNRti59wCMv8BW6NRIf5Jf94Gp77wW7QYtPmk3SRHF2
         PRvoHmt4ElwUyNdGaIKVzROQGLflW7v0L2oWiHeKRI7OtIwb60EqBbsrxnzkohA4h0c1
         wSNg==
X-Gm-Message-State: AMCzsaWq+o++wrhIaTrsOUJvvIBbooCWKz1yX3Mc/RP61JU5iyD9s2kQ
        tFQD0EIS9rVOolcozmFiUjjbbiRgmIhRy7/VlQoLU9WJgYM=
X-Google-Smtp-Source: AOwi7QC7WzcK8p0H69Mcwi2RskSz3WW4vBaPLwFVOaZiuC7R2FuSmnNQUkHzG49ecEQTBhR6MGjtpBPNnop3NcabLr8=
X-Received: by 10.107.68.25 with SMTP id r25mr18869219ioa.97.1507076942607;
 Tue, 03 Oct 2017 17:29:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.129.66 with HTTP; Tue, 3 Oct 2017 17:29:01 -0700 (PDT)
In-Reply-To: <20171003063119.iht5kl7zsiuxpaqz@sigill.intra.peff.net>
References: <20170927221910.164552-1-jonathantanmy@google.com>
 <20170929225422.81467-1-jonathantanmy@google.com> <20171002234848.GG5189@google.com>
 <20171003063119.iht5kl7zsiuxpaqz@sigill.intra.peff.net>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 3 Oct 2017 17:29:01 -0700
Message-ID: <CAGf8dgKtwdT912CaARdjYnSAd2m7mmdOzM=OGCUupw80snrd_w@mail.gmail.com>
Subject: Re: [PATCH v2] oidmap: map with OID as key
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 2, 2017 at 11:31 PM, Jeff King <peff@peff.net> wrote:
> Right, I kind of wonder if this has fallen into an uncanny value where
> we have this almost-hashmap infrastructure, but the end result is not
> significantly easier to use than a plain-old hashmap.
>
> I.e., it looks like you still have to declare something like:
>
>   struct my_data {
>         struct oidmap_entry oid;
>         int value; /* mapping to an int */
>   };
>
> and handle the allocation of the entry yourself. If we instead just
> adding an oidhash() and oidcmpfn(), then callers could those directly.

I thought of something like that, but it seems that you have to
remember quite a few things:
- your entry must have "struct oidmap_entry" at the start, not "struct
hashmap_entry"
- initialize your hashmap with oidcmpfn()
- when getting, hashmap_get_from_hash(map, oidhash(&oid), &oid) (and
oid might be longer e.g. ref->old_oid)

> The invocations are a _little_ longer with a raw hashmap, but not much
> (as you can see from the actual oidmap implementation, and the changes
> to oidset).

About the invocation of hashmap_get_from_hash(), I felt that it would
get annoying quickly enough that I would want an oidmap_get(const
struct hashmap *, const struct object_id *) but it might be strange
that the "get" method is named differently from the rest. If we
tolerate oidmap_get(), and tolerate the fact that the user must both
declare "struct oidmap_entry" instead of "struct hashmap_entry" and
initialize the hashmap with oidcmpfn() (so that the invocation to
hashmap_get_from_hash() within oidmap_get() sends the correct
keydata), we can avoid the thin wrapper issue where callers can no
longer use other methods of hashmap. At this point I decided that I
prefer the thin wrapper, but the "light touch" (struct oidmap_entry,
oidcmpfn(), oidmap_get() only) still better than the status quo.
