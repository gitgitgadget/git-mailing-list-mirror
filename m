Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E0F1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 19:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeDCTAg (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 15:00:36 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:41317 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbeDCTAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 15:00:34 -0400
Received: by mail-yb0-f181.google.com with SMTP id p126-v6so967292ybg.8
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ykj2n5DJUhTv93h1B6AFH49ykqAuusilqqZqFbUE7SI=;
        b=KjzxZYkh1siN25PiTIBwLzQflHdh8AW3PqsJVviYPL113DTB3MwfrepIw6nh+voJGA
         rjDFG/U0rlPUOTk6/RizgJvg3UjKvgHT1dfmeSj6wU8ujPDBfc3NcqfUMM4UXVZZbbT0
         7RX/A3Sh/UMSKjoK470ZM46y+KGFgpRtd/L/iYi6BqeXQq9RfPHBkArqamDI7jmk8jP9
         ghR2fHdOes7OTXPoO7gp6gnBnjDwbgT8cmXYOUSNc45gi9Z9Ad/pRnPJDnzDbx0mhndH
         AwTLkCjYGmvJOvjjOz2FMEblXZX7zqpKPyVxBPFhFTxjRVrzqt8WcjaL7IBPeJDga2wD
         b1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ykj2n5DJUhTv93h1B6AFH49ykqAuusilqqZqFbUE7SI=;
        b=KGJBC79xuoZIjtc9wuDDm+xGiXaZUB5TwNH8AkrOW+OPmSlv6P/7L3Q04ybGBjIT6G
         dUXPESTZJzmAMVIvizdfFFfL1XuFIvcq5+nmCBZEfzHtZwxlsgnCkupZ2iMvgqmFPfnu
         PyLmGm//GJ36zkNngOUAmRy4qD3e6zJXscaveUJqOSkJkxXh+l9mmlp7JBHc8MwCiwGg
         i12+OnVyqIWJBr7G5Bcxna6DZtqyHAXCaUCicZjvwaNIlhQIqTVaX6gf0NSNfU6CMt8h
         xjN2cRleqcWvRJoCFqVfu8eEvmGYZh4PIUZjk7LdKas/JXiKljZCuCA6s4IsxRoVH2gj
         51Rg==
X-Gm-Message-State: AElRT7HxIm2ELZ1fVJQJmSx6UbsvavgmYqQgsnebce4yp2VhAwzHw3oM
        pQ9TgbCX+PXRoHCmK0YCD4Lbls98kCCJjhJABrzjOg==
X-Google-Smtp-Source: AIpwx48itObCpaItSccJ1ZEc26awpKFp61MUS770Ic+KdYmMvXa+fX+hdtJl+o2BvijMcoAl7h7NpdhEyRU7A/NIjas=
X-Received: by 2002:a5b:143:: with SMTP id c3-v6mr5868868ybp.292.1522782032236;
 Tue, 03 Apr 2018 12:00:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 3 Apr 2018 12:00:31 -0700 (PDT)
In-Reply-To: <CA+P7+xpDfKSvQZ+YktsSSBPTc3JXzc9dR36tohLctfDf04iaOg@mail.gmail.com>
References: <20180402224854.86922-1-sbeller@google.com> <20180402164742.11d4c5507d6ee737c9935d73@google.com>
 <CA+P7+xpDfKSvQZ+YktsSSBPTc3JXzc9dR36tohLctfDf04iaOg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Apr 2018 12:00:31 -0700
Message-ID: <CAGZ79kZ-k7Ho-_Cg3OLLypfjoEn8pTDN7dWpX0=8o+o2BvUcqA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Moved code detection: ignore space on uniform indentation
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Simon Ruderich <simon@ruderich.org>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> The fun is in the last patch, which allows white space sensitive
>>> languages to trust the move detection, too. Each block that is marked as
>>> moved will have the same delta in {in-, de-}dentation.
>>> I would think this mode might be a reasonable default eventually.
>>
>> This sounds like a good idea. "Trust" is probably too strong a word, but
>> I can see this being useful even in non-whitespace-sensitive languages
>> with nested blocks (like C).
>
> The ability to detect moved code despite whitespace changes would be
> good, even while showing diffs with the whitespace intact.

That is what the last patch is about.
