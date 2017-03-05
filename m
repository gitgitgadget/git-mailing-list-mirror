Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25B21FBEC
	for <e@80x24.org>; Sun,  5 Mar 2017 02:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbdCECfl (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 21:35:41 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:36016 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbdCECfk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 21:35:40 -0500
Received: by mail-io0-f169.google.com with SMTP id l7so95709373ioe.3
        for <git@vger.kernel.org>; Sat, 04 Mar 2017 18:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jZLri28faFuq+/T2/d7Lof6xVghRhRivtKWKiFwFoN0=;
        b=iJgZWGGtR+3VS5AE+VHY5imfZ7keXRCKMVuvZIkrQwpyhmG2RDri8uP5pJEmDe1tVb
         Z4GGkNQOir3x9CAmm/Euw4HBX/m4oP25YE1Vl/GqC5cF3J1XUKt+4XNJgEjxC6q9LgXC
         LHWRarfDQi0qzej2b1UzONpBgUe6RiGBtCL7xJpix1x3D4gaZJ3k319VRilD7HJ1p94H
         qV6Lb406A1WIGyWXVhs1D5InG35Ul8zFQuUeLQEgq3/0xAzVp0Gve+M+wuBKrGnwAy2q
         EvQhKhOwWQh2Pc0iyrXWu9qOsYvXbeeBCqmRZns7cl3jGq234l01J6NtXjQe4u1AkXJe
         NlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jZLri28faFuq+/T2/d7Lof6xVghRhRivtKWKiFwFoN0=;
        b=Ukt8kDRNoXV5a9QrANT2OrjPR5Riby2+sMTEFspNAIQ5BIl34g6HN8DH1MaDexeXZ2
         BPUfFTWToLRiRe0b7VqPykd7dDZ043hAQ+hZoobeIeiivZNS/6V/LN3dM4pFGU3hCRfZ
         2N0ah6U++RyG95CPQcCs7zddnOeKxC4Wch3qOUbw5qxVeQSilzDQ+F6plqsDYmZQM0D/
         eGqmgSJxsmm6ZU2+YBMt84Ral0UwbJ5iq46P8tTAG6Bg/gSjenM2h61KtuO5s2Zj08Nj
         ZU6FyEmo91dVP/g9atp3BR87ExpolMmReMqwmgVaSq7PRyR2GoM5YA19CLBCM3WvzDmk
         8tww==
X-Gm-Message-State: AMke39nITWZmluOwv3aOFxGehRbsRHkAULYQywrevFZkU2GbZSGwWW85tMfSxYpp4j1TvwT3lJhf9lh1S7fy1Q==
X-Received: by 10.107.5.213 with SMTP id 204mr8571193iof.189.1488681339370;
 Sat, 04 Mar 2017 18:35:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Sat, 4 Mar 2017 18:35:38 -0800 (PST)
In-Reply-To: <20170304011251.GA26789@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2017 18:35:38 -0800
X-Google-Sender-Auth: xuHWBqq-BhynHqT-RzwemFWLYtQ
Message-ID: <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
Subject: Re: RFC: Another proposed hash function transition plan
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        jonathantanmy@google.com, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 5:12 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> This document is still in flux but I thought it best to send it out
> early to start getting feedback.

This actually looks very reasonable if you can implement it cleanly
enough. In many ways the "convert entirely to a new 256-bit hash" is
the cleanest model, and interoperability was at least my personal
concern. Maybe your model solves it (devil in the details), in which
case I really like it.

I do think that if you end up essentially converting the objects
without really having any true backwards compatibility at the object
layer (just the translation code), you should seriously look at doing
some other changes at the same time. Like not using zlib compression,
it really is very slow.

Btw, I do think the particular choice of hash should still be on the
table. sha-256 may be the obvious first choice, but there are
definitely a few reasons to consider alternatives, especially if it's
a complete switch-over like this.

One is large-file behavior - a parallel (or tree) mode could improve
on that noticeably. BLAKE2 does have special support for that, for
example. And SHA-256 does have known attacks compared to SHA-3-256 or
BLAKE2 - whether that is due to age or due to more effort, I can't
really judge. But if we're switching away from SHA1 due to known
attacks, it does feel like we should be careful.

                Linus
