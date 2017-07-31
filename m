Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C4C1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 17:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdGaRnU (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 13:43:20 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33454 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdGaRmD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 13:42:03 -0400
Received: by mail-qk0-f176.google.com with SMTP id a77so54965584qkb.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e+A4+wRZQXnQ/uVhYbn+ScYTq3wY1mC4zqD+h5FPhrQ=;
        b=QuDOq9f/auVlAo84vRuns1c44af7suEvWlpRieiGQya4nSJqpjJTseIEzjzWf/4Tje
         VQSjynt6LF5XC66zvtQb0Gc9cRLCDGBW2gv+jrXh8obS2H8IR2id+en4VoLaZIQq/oLv
         qhA7/8ZpCuBPTWookfqPy5EKwXi1+nACgtAPfAc6P7pLEkVDII8zgv58SCtxuq27AVvc
         a3jA/s5Po+qwUfaCv7Ur6d2LA/Qr9mb7LM3MZd/IDVadH+TXhPUESciuG1kSBbwM4Sgn
         bCzaXEnRYiVGXqrjQbex+gUmkTmySRHDRJ1RePfB9o8kkcClRqK7sJbMr+sbEWkWxFo6
         Jvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e+A4+wRZQXnQ/uVhYbn+ScYTq3wY1mC4zqD+h5FPhrQ=;
        b=dWgwFuEmJOEN+dYWmOrUMndbkrmIt5VpvKHC+nikOl69mn/Vho9kyGstYbChI36+qr
         LeJy8LFgoC9mtZ1WJgCKYmsl4BTuEqzXznXJ++xiincR7MWImshYZqMBMKBI1syL4+Ds
         KDxaq73tmvXBbGL4rPUJtPUOrg9NLUZHQCT4TaGDUZryczY+R/GOdc2oz73kCOuWhq+z
         4GNoFKL7Cs/aOt3M1ycCDZCb228Yf6Wkp5VOgfS2GvsbV7ogtcri+2NcNYiDL8Fk0xSI
         K3JauS2HMKamEsLsjh7rg6qbPqZ2OYNAoyVZgBeHp+rImQ+/IeiHYx69EIaxKk9diB2e
         /dGA==
X-Gm-Message-State: AIVw112xDbPbbVMraQMsgJAgUKTr6GpixCynJMlvJtssdTK/G2Y3QLcn
        K5ucYR4FcAxY/14YImib3YTw7QTxFbFx
X-Received: by 10.55.102.199 with SMTP id a190mr22965454qkc.163.1501522922690;
 Mon, 31 Jul 2017 10:42:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.44.102 with HTTP; Mon, 31 Jul 2017 10:41:42 -0700 (PDT)
In-Reply-To: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
From:   Dave Borowitz <dborowitz@google.com>
Date:   Mon, 31 Jul 2017 13:41:42 -0400
Message-ID: <CAD0k6qTLSghs2Z6iv+kVQe091b+6=zqcR1k7_2eGks01rWUAsQ@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 30, 2017 at 11:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
> - Near constant time verification a SHA-1 is referred to by at least
>   one reference (for allow-tip-sha1-in-want).

I think I understated the importance of this when I originally brought
up allow-tip-sha1-in-want. This is an important optimization for *any*
HTTP server, even without allow-tip-sha1-in-want, in order to validate
the SHA-1s sent in the upload-pack request, which doesn't share memory
state with the /info/refs request processing.
