Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA2C1FC3E
	for <e@80x24.org>; Mon,  1 May 2017 22:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbdEAWSi (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 18:18:38 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33439 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdEAWSh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 18:18:37 -0400
Received: by mail-pg0-f50.google.com with SMTP id y4so45463276pge.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 15:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0lfuE62xK08N8YThBwqXqmS9qQ7g6Q5CcmXHIcNsVJo=;
        b=rQRAANmwQtvQYQYMrD3X2nBEwxpgu9C+p7QklduZmygy56mDEuFI0HA3A/twxwMOt+
         llin4Y+AR8EkdTxzqdHaObxbgsCBIiymtj8UykZGUXz4xrIppGcgqrG4kHAMQNS98+YH
         n0M2wuNxkeuDuzxkITyPmx03h1GUKdHzpMePvllGW+VEywIL6ebTKfWX4bFO4VnZzSfl
         g9I1vFbm9vxIN3J+Bm2JEdNwxi5G2YJoVawXRYHGWp1MzWrSvkwapj1MMIQdYX/3GbPN
         EpqqqNaT/S4lr2nhab9X6QFuQhIr2TlobCBHIksIDck66YId9ypMy3K9zx219J24bS/n
         nXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0lfuE62xK08N8YThBwqXqmS9qQ7g6Q5CcmXHIcNsVJo=;
        b=GgL75dCanNMZ3NYiaV+Px9Ypx7uL531jrGc9yyvhaopL5/svYkxx3zJ+2oAgQw3Rn0
         EBzwd3taSp2bUPd63/IzM//S14E8f1kdu1gwcPXbgZ/tzBAwOf//oiLGUXA8QeixX44u
         Yh+qvO8PfXKMxbZUQvTuOg55Uhr5pOzxFbMjOayRPKQxG3o8UBIITu2AzcnsLRhlD+JM
         z4/a5fz32sV+GCp86PbygBHDQJUCD13HM8BJmXpbSHSiL5bX2kci5HBDx+f4bjROZq5b
         0MTTLbeYYkycSX1EZ+bYbh+wVXw3ZAO0G07JWoBc4sFwJnnOm1jukZXTpoBfWx3xEHl1
         w96g==
X-Gm-Message-State: AN3rC/6BzuRhMdV6e5iKWCYKr8buqrniFcICso+30atI10nupR4+fiNW
        BsgbsiSosfWIQ5Ey+b1lZP7QVGkIJy9v
X-Received: by 10.84.232.133 with SMTP id i5mr36797652plk.172.1493677116875;
 Mon, 01 May 2017 15:18:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 1 May 2017 15:18:36 -0700 (PDT)
In-Reply-To: <20170501221345.4025-1-marcnarc@xiplink.com>
References: <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net> <20170501221345.4025-1-marcnarc@xiplink.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 15:18:36 -0700
Message-ID: <CAGZ79ka6Bnq=U4s2bZhLKwUD3SJEBmD-AvP63-RrpJ8MYGbKTw@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] Make diff plumbing commands respect the indentHeuristic.
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Changes since v2:
>
>   Patch 1/4 : Unchanged.
>
>   Patch 2/4 : Mentioned how the new behaviour matches the diff Porcelain.
>
>   Patch 3/4 : Updated the tests.

Thanks for picking up that patch and carrying it further!
The whole series looks good to me.

Thanks,
Stefan
