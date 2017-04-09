Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8BDE20966
	for <e@80x24.org>; Sun,  9 Apr 2017 08:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbdDIIt7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 04:49:59 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34437 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdDIIt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 04:49:57 -0400
Received: by mail-lf0-f49.google.com with SMTP id z15so58229773lfd.1
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 01:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GHMmcx/Cgg6aAERe/aWRIMjH8//PZqUOuaCf56qVOFY=;
        b=Q76ZLCX9l9rEvF1b4u7XYLQnMHUuSRKPFpCGfgwD6jCakc6E/Wx8ZCqfz2ZV/lwxvG
         8B0GgP0svZUhB4PCYtZiDgVoWAn0NoatLGFykVnhPKQ9MgptNsFRmN5HFiYw3JGv9YM4
         8invcs/JFipooE4buPPVbdnkazo29maRUYdCZ3QdLfdFH0Io75kCNhbraXv6niS/cAt3
         1jN07EZzpwaCJ6zl1EDh+pU5qrWkntBFDlYW7nOzqKNF8ezDxfjym/U17Jy2zGp2XyJF
         xNdod/C7jSQW7oFjG4vb5GdmhHhGF2oZU+eYT6yZZHWWvpG2yPlFVmHCHbT9eyJyEndZ
         1S/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GHMmcx/Cgg6aAERe/aWRIMjH8//PZqUOuaCf56qVOFY=;
        b=sxUYpcWl+b0pqEHS/z973XpFmr0sdxeBfT9ahpGYaTh9agHboWSZjGoYssXNR1iKZb
         Hp3Z9h0C5yDCWgVT9uCUbfsWG+vMuFgFf/wof/EW37z4sLvQkyd4XCUVrKNYCAjvOKbZ
         PmB0hUeOHs8yOsXygTHZA9RALHG0aBWRRBIqv3RcysALlOhZQYyaLV6IlstJAlDX/+oc
         34pb1YSR82zhT/9VFQanYwhXJ8qSfIkk2pvxeCeykc26vj77N26VdafNArUhSDOAdIb4
         OKo1mnWFjTM6nv5TtimE5JZ3Lgi5Fgy9tEU9/PMH6D7dL/PzK+6duC9wu0PG2W07BSvw
         rTrw==
X-Gm-Message-State: AFeK/H0nsa3lJweTGkiEeu8ennJ0dEo7nkiMpGsIAV0enrE4u6mPC2K+4OvRNpuGkrRJPEvB+nPTle/x6IS/NA==
X-Received: by 10.46.5.2 with SMTP id 2mr15140748ljf.34.1491727796139; Sun, 09
 Apr 2017 01:49:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Sun, 9 Apr 2017 01:49:35 -0700 (PDT)
In-Reply-To: <1n47m37.1xocjxu1j1pyM%haller@ableton.com>
References: <20170408221302.e7sv6cy4xayr2w7o@sigill.intra.peff.net> <1n47m37.1xocjxu1j1pyM%haller@ableton.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 9 Apr 2017 01:49:35 -0700
Message-ID: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
To:     Stefan Haller <haller@ableton.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=3F_Bjarmason?= <avarab@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 9, 2017 at 1:38 AM, Stefan Haller <haller@ableton.com> wrote:
> Jeff King <peff@peff.net> wrote:
>
>> > It might be possible to generate these lease tags prior to operations
>> > which modify history and then maybe having a way to list them so you
>> > can select which one you meant when you try to use force-with-lease..
>>
>> So yeah, I think that is the more interesting direction. I hadn't
>> considered resolving the multiple-operation ambiguity at push time. But
>> I guess it would be something like "you did a rebase on sha1 X at time
>> T, and then one on Y at time T+N", and you pick which one you're
>> expecting.
>
> I think it's wrong to think about these leases as something that you
> take before you start a rewindy operation. That's the wrong time to take
> the lease; by that time, the remote tracking branch may already contain
> new things that you haven't seen yet, so using that as a lease at that
> time will overwrite those things later. You have to take the lease at a
> time where you know that your local branch and the remote tracking
> branch are up to date with each other, which is after pull and push. And
> if you do that, there's no multiple-operation ambiguity to deal with at
> all.

Agreed. You "take" a lease whenever you push to the remote or when you
pull from the remote and when you pull into the branch. It should
store something that tracks both the branch and remote branch together
so that you can generalize it to multiple remotes.

It doesn't necessarily track perfectly with a branch that contains
extra work such as when doing pull --rebase, but maybe you have an
idea about that?

Thanks,
Jake

>
>> And I think that may be converging on the "integrate" refs that Stefan is
>> talking about elsewhere (or some isomorphism of it).
>
> Does it make things clearer if we don't use the term "integrate", but
> call the config value in my proposal simply "branch.*.lease"?
>

Yes, I think so.

>
> --
> Stefan Haller
> Ableton
> http://www.ableton.com/
