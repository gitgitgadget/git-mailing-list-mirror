Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B021F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeBHPm6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:42:58 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:45599 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeBHPmz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:42:55 -0500
Received: by mail-ua0-f169.google.com with SMTP id z3so3142318uae.12
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sKyF9oQx8nizFJ+zcQwL9kBLLhWKZOKB7D22BgzGLoA=;
        b=PKiCfR/ZWjP+8eg5+uSkuK0jTeZZdxzanlPDiQ0pPybEQeE8LWQmddAAFilgHrpnbk
         hMpA1Ng22rwW1LzMGsoRyFRDHeO4p6fVoGPbXJprIfGSaXIJEMdjLujHdOIRhnNrTNAq
         1erX/cIBEaSS05CycL847LtuxFDSOEf9PpZT928IvIZ0Aw5dZH9JqBJXIksRFf6Xatk3
         QJoCaOs0nr0zZ2G/ZcTP8RmAFvHmzBCeBFkK8gJ1nz94nS5xRy1HrGGyGMEa4HY80raD
         a+xBo+Fn+H7iv/QsEfHypIZDEzRKYb5s0xsimc5h3Y1XrFSbpIP/xdIjpVcpqC89XS+A
         TtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sKyF9oQx8nizFJ+zcQwL9kBLLhWKZOKB7D22BgzGLoA=;
        b=PAPxHaht1pjvdxWxyBnhL0A4toXSBr0l5lOBaacD662QsAu8HtG8581ioV21bh434H
         denH4kAv46J259HtBvup3gcLTRnoZzjoIyEHFksyloqkd9T1Cm5xmr+Laeo2XaoU+Fyu
         iDpVTZEENz10K55qEUAWWiy9FCh7QYHnmOYewAPmRvTlz9fqORF/+KKZ+y+5l2KHCtMT
         xzk93Kl39w/dQPrPLWjdY8tFmsEAU8Sa3XxErlxpsrdGy4KOQbdwfr+dJmfA2H5hEACt
         dGXALquEwhoh+XnEsLWzVWd/nne8E/w7L5zg/siZvyBMwoCrDNFgW+wvurg3qV5dnmPJ
         lwig==
X-Gm-Message-State: APf1xPDKq5EYLXgjQAWjN1GRcuf7+FaBy0LOy1Z9ek9V/Urj+b7wtYsF
        Edo6hjCZfNBpmtqjmieNkc0r5PxaTjYZMLx2cvg=
X-Google-Smtp-Source: AH8x2273Hes+qokXkI+i7R15lKnvOyDI9ImC6rviN7HFNv7fwA0UrHjtln7QDR+yXWTpMgsv+y+UP5F4Z40b+u/30ok=
X-Received: by 10.159.38.109 with SMTP id 100mr848303uag.9.1518104574162; Thu,
 08 Feb 2018 07:42:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Thu, 8 Feb 2018 07:42:53 -0800 (PST)
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Feb 2018 07:42:53 -0800
Message-ID: <CABPp-BEJniR9H4rN6Ks9bg99qrxJr8vp9pg8YK_+gqhu+oNf=w@mail.gmail.com>
Subject: Re: [RFC PATCH 000/194] Moving global state into the repository object
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 3:51 PM, Stefan Beller <sbeller@google.com> wrote:
> This series moves a lot of global state into the repository struct.
> It applies on top of 2512f15446149235156528dafbe75930c712b29e (2.16.0)
> It can be found at https://github.com/stefanbeller/git/tree/object-store
>
> Motivation for this series:
> * Easier to reason about code when all state is stored in one place,
>   for example for multithreading
> * Easier to move to processing submodules in-process instead of
>   calling a processes for the submodule handling.
>   The last patch demonstrates this.

For what it's worth...I spot checked some random patches, looked
closely at the changes to merge-recursive, and looked at what was
happening to cache.h

I like how you structured the series, and I like the goals.  Didn't
find any problems in the small pieces I looked at.
