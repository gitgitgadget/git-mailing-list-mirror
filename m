Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9130320A40
	for <e@80x24.org>; Tue,  5 Dec 2017 20:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbdLEUCg (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 15:02:36 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36488 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdLEUCf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 15:02:35 -0500
Received: by mail-it0-f68.google.com with SMTP id d16so4428417itj.1
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 12:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSRAFXv/6c2qNWaKh1ys1PGPZi4OcEVk3cm/Ef3w6Kg=;
        b=ZN6dp8GhUzsdPqdVyRHckKNh7NcVjmu1gCEExz9hcIW5poX0OjUsA94SxsK92Vbswi
         H0cnAA8JQVdcm++4TVEnExhxVnIKaRdld6VFc7JVLmVkuPjgx7ofL797ZyK5m7F0Zpca
         X/rmg1YzkjrQluIXvdGCgYpSu2nZvSD030fDgeEei5Pbw5xhqux1fD5I/G/yaUUx4+C3
         Z4szrHqBm4mY1QHDNtd+kMBeTUhGXYJEYEztCPFm5KUg0gVHrfkFspN4q87rhIOBWMZ3
         3M1FBmCkJdKRzdktZVpfWpq82JMJ0kjxZFYLSczM0q6iDPie+B7iOdPYafDufngC6ycs
         QY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSRAFXv/6c2qNWaKh1ys1PGPZi4OcEVk3cm/Ef3w6Kg=;
        b=NCsie85/gMCEnKDaBC/x5kzAJSIOJXwW0SETBGdvjvAc39pYckTSmchjdeZ3HzJdqP
         5Lo1RNqBAOzpIaJOX79iDajFUA6sYQWgbuGkr0H2t4woVwNqDygs+g003sSnsW+/tksU
         Yo5/QOc/yPQT79PEyIe83zF8yFSa41ICQv3dQ2Gy+rnPDjbvQSzql7wFn9IsXJ53ADX4
         08Fs1BzOlB8J+OaQ0CTD6bg0UKKPxx2XuCh8aIuzZ04v3yirSmxbt/CF5jl5ymgUUshD
         X2vHiAzIMGOpBLI1GuJS8g16FM81TiLw8tF9p0fHz2xztuDD3/9h4E+S23rqB7BrcPqD
         hkFQ==
X-Gm-Message-State: AKGB3mItzYtVCYP829+P6hldAZeMEiixbk45PnDgfZt+48a2SxHSU0ac
        SjjCJE2QPjO+dZa3B8I1ZlaW7r4F/Y8=
X-Google-Smtp-Source: AGs4zMYSZEAZt50n1t25NkTJnihw1wZ7toA+RpzNe2UN7r1w9tsrnS+96BA2dKrXUQwxVACGnI0XPA==
X-Received: by 10.36.196.85 with SMTP id v82mr1714043itf.136.1512504154942;
        Tue, 05 Dec 2017 12:02:34 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:7cdf:8835:5040:e17a])
        by smtp.gmail.com with ESMTPSA id j204sm547721itj.16.2017.12.05.12.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 12:02:34 -0800 (PST)
Date:   Tue, 5 Dec 2017 12:02:33 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        christian.couder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 00/12] Partial clone part 2: fsck and promisors
Message-Id: <20171205120233.02cb5850ead14137c2a426c0@google.com>
In-Reply-To: <20171205165854.64979-1-git@jeffhostetler.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  5 Dec 2017 16:58:42 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> This is V6 of part 2 of partial clone.  This assumes V6 of part 1
> is already present.  This version fixes a problem in fetch-pack
> observed in V5.  It also contains 2 "fixup" commits that are
> WIP responses to comments on V5.

A note on the fix of a problem in fetch-pack observed in V5: to do this,
I renamed the "no_haves" setting to "no_dependents", since this setting
now has a broader effect than merely suppressing "have" lines. This
setting is described in patch 7 ("introduce fetch-object: fetch one
promisor object").

> Part 2 is concerned with fsck, gc, initial support for dynamic
> object fetching, and tracking promisor objects.  Jonathan Tan
> originally developed this code.  I have moved it on top of
> part 1 and updated it slightly.

Thanks. I checked the diff between this and V5 and it looks as I
expected. ("git am -3" didn't work on the patches as e-mailed to the
list, though - I had to use the one hosted at GitHub [1].)

[1] https://github.com/jeffhostetler/git/tree/core/pc6_p2
