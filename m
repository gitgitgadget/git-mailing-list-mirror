Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F021F404
	for <e@80x24.org>; Fri, 20 Apr 2018 01:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753897AbeDTBiW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 21:38:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45713 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeDTBiW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 21:38:22 -0400
Received: by mail-wr0-f193.google.com with SMTP id u11-v6so18650782wri.12
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 18:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B2Xt+z663oqvg3+BqNKY8Us/VBiAuH029VMgxNMO6Bc=;
        b=j8Y4cXl2jy8OpoNysd/QAmD9qzqOkPKk6NuAe2K/ttGccurPzfd9Qzd3+aBzGo5w5Q
         Y8xqvtlpGN0tGy4Q8JyT/Ijyu6MH4lbzWxogsQlLzioQ8XuddEK0cM7yC0+PXOeIPHxj
         axDhIrV6HwkJZioh2tFO4cu/9CatZgUypvUOT00/t6dQOYorsufAFDibZvNeNk2LlFPq
         anrcFLOElLUqZk3yM6ElWm0rMbATHzBU9O/aGqelMK6+PcX9H2VlKjL9qzVDyoKZOzT5
         DXgwBX4tWM5L7U44l6f9V9IxSbVSw0FmGhYMPvUu3Wnk3n1Qg6e4vpzpCaZ/mKJqVkjS
         fTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B2Xt+z663oqvg3+BqNKY8Us/VBiAuH029VMgxNMO6Bc=;
        b=fm0X7bsnPxuwYmMZyRMW/zUGU3PAXOt50m0uO6+V2HH57lX2SfJ4XF6nHOEuOMvcAz
         +m3ALJh9sjaCTLIMuVbKINSS6VmjVgw4QIMgNIgr5WJfGvlw+3EduX7/y5xFd8DZv3s/
         z8aSfZBlLshzEbF5ySLyqB3WAcTYuUZNH0BpycVwxfr2Nhmhp8fh+PbMbFiTicdNswRY
         XQikZRAHTTDsp0Km6H1W809nOpRIJA/M/bZ1m0UbUsQ/uBV8T3daTJNj0e41Sdu/wme4
         rGPEDTlnTmNwk6RA5GFvYjSjCrGyUaKycdsxWGnLBLNQrq+2HG0KXTfW7CDM76x2HD0P
         GMFA==
X-Gm-Message-State: ALQs6tDoonuy1DhTFyC5Z3mJ9tLiZInjV9OQlYPuYeFc8Hwqmm+vlLpt
        TKUaIxgZTVi2zJfsnfGEAuY=
X-Google-Smtp-Source: AIpwx48VW+veUsoBNmx5pl3jXoQYEDCF+Um5CIafz3I2HPiFM9Ic7UBSa/ukBoIIPKRrCztcRK5zGQ==
X-Received: by 10.28.86.132 with SMTP id k126mr566031wmb.17.1524188300545;
        Thu, 19 Apr 2018 18:38:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r200sm1339398wmb.39.2018.04.19.18.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 18:38:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/2] completion: improvements for git stash
References: <20180417212945.24002-1-t.gummerer@gmail.com>
        <20180419232514.16572-1-t.gummerer@gmail.com>
Date:   Fri, 20 Apr 2018 10:38:19 +0900
In-Reply-To: <20180419232514.16572-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Fri, 20 Apr 2018 00:25:12 +0100")
Message-ID: <xmqq36zqd5dg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> I didn't find a good way to implement "reluctant completion" (I'm also
> by no means an expert in bash completion, so there may well be a way I
> couldn't find by googl'ing around), so I left that out of this
> series.
>
> I don't think it's strictly necessary for the deprecation either, as
> we can just print a warning message when the user actually uses 'git
> stash save' at some point, which would make a message printed when
> using the completion redundant anyway.  I feel like that warning
> message is not something we're quite ready for yet and I'd rather wait
> a few more releases before doing that though.

Yeah, I agree that what you outined above is quite sensible.

Thanks, will queue.
