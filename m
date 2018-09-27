Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2820D1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeI1Aj4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:39:56 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35695 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeI1Aj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:39:56 -0400
Received: by mail-yb1-f195.google.com with SMTP id o63-v6so1529714yba.2
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upJsA5RPn89UL6zIgPe/q1uW13UOylEpaHnsq8xxcYg=;
        b=ToqUrLUhiOTyUbwBEAx9zXU5R3vA/SgHREMTCJHcNqrBD0EpByCkIhyaG+gFdhw5cP
         yITkfG+Kb/OkuZOjp5Ov/8ic9PoOA7ijh2oaSPpQtw4vyGu0cnM/exiY8ku8nX4Ybyx7
         w9+HfBKiMFfJQ0rSwdzSaxaV6uSbdrUSazPrc68qogC1x2KcHC91/8IL6SCfm6p51GPI
         BMl6ygATVMBPItKjDbdD0znXR3llu4KNT61uOPn9OVggxTm8XcWq6/WTFO0Gk0Cxe80u
         xNXFvybbcc/+NxYSwfJYj8QAp5OFmG7QuLRVZ8VYWdjs2U24i4WWbyqQurhKcmKTe5zc
         o7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upJsA5RPn89UL6zIgPe/q1uW13UOylEpaHnsq8xxcYg=;
        b=RdFXEFg9hPpzngjm8Cfsw7AaGhqo9vvPtDcHSM7AKKLqayRDTJ6pXGSQWSPvJ9+qvH
         nw4lqynYXORNUvoYkfdy2xmRUmHgf3Mf9qphTqGTb9nP/qDp4jcOaFdoWU/zdQnbh85I
         ZFdEyU5swVJXF1IJAcYLyGHcdBJXOvCcRfiUPcr2zIfVLU6BfU5f/nDtZtFUXar9/HsP
         i1BD2NlO37QHOgVkSe1Onwn43rCGdr51z3NRhzcGVeq9H+8tB1yrXSsmdGxKe3R4CVzC
         scWK01I0w+w1pSMoY9YORssJbO4X6es0rDepR+NKsxEBh6Gqvehpg7RhHQD5K7wZUCjw
         vvgQ==
X-Gm-Message-State: ABuFfogrbUtkT+C1ltp2iYwGH9q2WTriBGeptJcMPJ9WqPXcbMJFm6zB
        8Csqw6ez9lEpiQGI3aaGxlNgFtzhC4yRDqJvzq5TPcVMs0c=
X-Google-Smtp-Source: ACcGV62Oe+G2HeL8K/H2hIiKdHh/YJ8qPdRxek3mcVnqW56sjNno7BgYQ8jFJtZFdeZDYlIt6RZ4HCTBSaHwI8CZNBg=
X-Received: by 2002:a5b:1ce:: with SMTP id f14-v6mr6492499ybp.363.1538072424440;
 Thu, 27 Sep 2018 11:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com> <20180927012455.234876-1-steadmon@google.com>
In-Reply-To: <20180927012455.234876-1-steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Sep 2018 11:20:13 -0700
Message-ID: <CAGZ79kaBvHwUUf0rXeAwBY-M+Oi9JjsQnLs4v3FAvx4a9ZRbSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add proto v2 archive command with HTTP support
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 6:25 PM Josh Steadmon <steadmon@google.com> wrote:
>
> This is the second version of my series to add a new protocol v2 command
> for archiving, with support for HTTP(S).
>
> NEEDSWORK: a server built with this series is not backwards-compatible
> with clients that set GIT_PROTOCOL=version=2 or configure
> protocol.version=2. The old client will unconditionally send "argument
> ..." packet lines, which breaks the server's expectations of a
> "command=archive" request,

So if an old client sets protocol to v2, it would only apply that
protocol version
to fetch, not archive, so it would start following a v0 conversation, but
as the protocol version is set, it would be transmitted to the server.
This sounds like a bug in the client?

>  while the server's capability advertisement
> in turn breaks the clients expectation of either an ACK or NACK.

Could a modern client send either another protocol version (3?)
or a special capability along the protocol version ("fixed_archive")

> I've been discussing workarounds for this with Jonathan Nieder, but
> please let me know if you have any suggestions for v3 of this series.

Care to open the discussion to the list? What are the different
approaches, what are the pros/cons?
