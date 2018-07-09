Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4F411F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeGIVrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:47:18 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36262 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933118AbeGIVrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:47:17 -0400
Received: by mail-yw0-f196.google.com with SMTP id t198-v6so7108467ywc.3
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 14:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulxRs9pkpKpkzKdJYVW4SWYsvFkexprthLaDCsqLEEE=;
        b=kGJWBKfdT9eSQmI8JsoGcXstGHXNA71aQuv1GowZUfdsJsGpMxUxzFQM45a342vyjG
         Y2MX04zN1X0FbbIqPw23Ns4K2Tk1YDSoQFuG2z07Y8t8VCBrN8/iLbeLLsdDhR4TVwqV
         m2N7j8zt8sGvZ6TyrX5TCKPbdRGO+kGFguzsj71k3KgOYS05nIN1GgqBU/lCQinkcT5j
         x2LDwBLZdadywybHqCKZXbGPXtQADqdecq5ScYN9OG/2WtHAD3UIxek/ymzcllNXpaXl
         ag9z8YMBeEXGH1MqMjFNcajQt/z2jDkGRxuS02P/o9HyUkHeuyD2ebo+pCmTvPNZHwtz
         758Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulxRs9pkpKpkzKdJYVW4SWYsvFkexprthLaDCsqLEEE=;
        b=ucyLwcSIlChqd0yVvUAHh/ywHlDyLL//drhpYT1ZmbNFHUoPoUSe7WfkEMVsgAxI6b
         izmdxYnIb1MQ7M4xyraQsgNm5Ir29rBw2tSx2SFM2XHpRqQesfPiZu0BueQR6wodOuSm
         xxJ86zy+dtMW063C2sf9xKB27dVrngt4MTkrYqLi2Tg//oH5Df0bICktrEsbZpryWzPW
         17u9kdsiVA1xsWUFu3xAYHLS7QhYhj/Zb7gV2as6pOTKG2D2Zvi+WBMX1zpQJTHMbC8q
         KO+vyqZsN4ZqQYfD713zNQZEKxJQWR52e/PAkweZDJv9iwd3vZSBR5zoleF79KT1fHgn
         TAQQ==
X-Gm-Message-State: APt69E1IpwrD5ag2e9+PgC5hcZOKjgZO/f7i2mx3kQLb7yAbnc/SjiOI
        s2k0urtRbl9vnMS4XVzbYDHVrulLO7Xz3dzV9d46Yw==
X-Google-Smtp-Source: AAOMgperhlyvDfsLrNHQ92zyfWO3dzNoiVSQ7gj0/CbZad8LGlgj59Z052XpqnvzjkOEJd6TmyEbTN743ZEfsACTxiI=
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr10792739ywd.414.1531172836937;
 Mon, 09 Jul 2018 14:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531168854.git.jonathantanmy@google.com>
In-Reply-To: <cover.1531168854.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jul 2018 14:47:05 -0700
Message-ID: <CAGZ79kadsaoiM4o+GJQGX=HF2nLrgcLfHbvarvF+22cNDsn95w@mail.gmail.com>
Subject: Re: [PATCH v2 on ds/commit-graph-fsck 0/6] Object store refactoring:
 commit graph
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

> This is on ds/commit-graph-fsck.
>
[...]
> I've also added a patch (patch 1) that removes some duplication of
> implementation that Junio talked about in [1].

I think this series is good;
Thanks,
Stefan
