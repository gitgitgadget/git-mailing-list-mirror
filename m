Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 858C520954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbdKVXIE (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:08:04 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36328 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdKVXIB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:08:01 -0500
Received: by mail-qk0-f181.google.com with SMTP id o6so18879872qkh.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 15:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OxNUtWBOqG2WbKOhfloDAY23mi6zX9vuJZT+Aumwkzc=;
        b=eol62cSp+RWUD9dJiGetqLpjk1mX/jS+Xfv6QQViYm5xgeekFr1vnVXHM9eWc9dx2r
         TBdyJQxLxMU79HZBKUwQaA19FfhRpyZYW/svg9dfEptCRBDirCzZKumaEyVC8jDcOQKL
         hMkmJ7dmOxbv/qk+tHJ4803rhSmLRDNJj6dMXHqV9it615AP+iKhkOXeXwRt+WXLk6jr
         tV32FvpnROpkrNZVNDC81nHD3yJOVljvYHdAifda8ZwgppxGtzpc8lUNTKZvYHp1pUJy
         UeRIlhgEXGrB5blltbStVpG+fWXV1Et3/ZYlIATG4y4s4Y70w3mXWRkNVJWYpiz+VNQe
         lDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OxNUtWBOqG2WbKOhfloDAY23mi6zX9vuJZT+Aumwkzc=;
        b=iL/trOogLXnNN/iMsHJ7A1jYmIs1QqxyPV0s7Gzx5yZKqOdm85mpkzyLzJ2/7Xawfi
         CYo62M1fp5jjFjQBiAgUpsRW2IK1kVaZaHTB4R4DzgntB0mXSGmXuTgZ/2TPhzDcvQ/K
         qrRpXFMn9rEYw6btHqjKka+/HeiBRDv3vSa43CwqxRbxp/3uOlDkBN/v3jZLm0dm3wQM
         IYVikcVxvdlt35rq7ZUIBVv99Yx91rOlgwocGCUweFlacJxSqb5ysySSXnLLl+A2Gk/G
         gczxpo/fr7snONqfojplUqLabR2i8xahltqup8dCapqgwHPPlc4V9hIcv9J9tx1I9jP4
         nh8g==
X-Gm-Message-State: AJaThX4Y8J0N5zo1a708H3U796YdhD6K0h2RSWsl3Vn9TognkW8yZjOD
        R8j7CFaArH7tB5aJdoAFMoJVGzy52Cf2Lg2HPwf3sA==
X-Google-Smtp-Source: AGs4zMZmvIic5+6ccfDRZOxhKCaV983oogGdYc4yhBKJkLvD0XbBAJ5CuTw+rewE2gKeKqtFnQluJd3fRhmXSPToIpU=
X-Received: by 10.55.76.193 with SMTP id z184mr4500050qka.346.1511392080937;
 Wed, 22 Nov 2017 15:08:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 22 Nov 2017 15:08:00 -0800 (PST)
In-Reply-To: <20171122225913.GF11671@aiede.mtv.corp.google.com>
References: <20171122223827.26773-1-sbeller@google.com> <20171122223827.26773-2-sbeller@google.com>
 <20171122225913.GF11671@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Nov 2017 15:08:00 -0800
Message-ID: <CAGZ79kY7yrgYSM7jLQD3Q4sRpjovXY=HZwU4M-Ai_XRPseda9A@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/CodingGuidelines: explain why assert is bad
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 2:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> In a certain ideal world, the preference would be reversed: you'd want
> to use assert() wherever you can and require the compiler to check
> that all assert()s are verifiable at compile time.  A check that a
> static analyzer can verify is more valuable than a run-time check.
> When a compile-time check is not possible, you'd have to fall back to
> BUG_ON().

Linux has BUILT_BUG_ON as well, which we may desire?
