Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60801FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 18:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbdFMSAE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 14:00:04 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34560 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbdFMSAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 14:00:03 -0400
Received: by mail-pg0-f48.google.com with SMTP id v18so63978143pgb.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kVQie1J0EQPpoYJKx2LDKFWn7IFIG2hsEj5HYYvnhXA=;
        b=UTFvJMy4o3dHgJ5VzSyLEGFku503M5BsNU3DsZMvsrjR1tVW8ierOGP+qnG5DUUz7p
         Cav87iPpRFolcTCJtbmBPS/qDM6Y2KrNOkDqWSyl1BuoIjNC5B3DUrDlEGXXwm6Brx/X
         ENWNPYmVP9DlZNFVTqKJni2/uLDSxcqdWujeMo4GVX5WjppxQhrBSjQWqagkxzT3nW5H
         t7bt41RuNrq9I+Ug4mUp56oVEn1OTQfTQpqd8Q2u+5TKr1ZgfX8djEtSZe0ffagspflv
         ko4XuZ89io+NTNSTE25j+cIN/V1eNIXhXW0YS1Gf8RWNv7qfHaXf1XtbwD7wuFjEC7Gt
         HUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kVQie1J0EQPpoYJKx2LDKFWn7IFIG2hsEj5HYYvnhXA=;
        b=aYv8M8STuXFXF0+BXW9NY4C8t9QclxRiKfdaTWNAqJYNBWHOka4ZgPvbLYT3ht23wA
         8vUP/osHZ+PlHJOaQZxUEN9gMgIA4V75JF7p3tJuZIO94U0868Fsg+WHSJz7h90ClTYP
         qzgoqGRpwinqZktYzQToRvlef5udMRdrgQXPjLZX/NKAk9oAluR7Oegbkfqqjy18kkoS
         G/cYtSmQm7SyBrToZX6ileiuUqG9LDf2CmoKc771AJf/YdkJxtBdad3pDoKEgzcGaShN
         IcZAHr71dHEzLagN5UBu0NMH1qHXM3Ugaf/KhBt8y2cBMClxy4kGQSAE4/IPMZQce/Yr
         bs2w==
X-Gm-Message-State: AKS2vOzmtLPJuLAxwZA1IzA3JpofrsQAZnGAJjyWZPrstwhl0L+0yC3j
        zzKAIDcPHeALEmbmLHuOceLBFMifd3/uqSj8cQ==
X-Received: by 10.98.63.10 with SMTP id m10mr743853pfa.19.1497376802906; Tue,
 13 Jun 2017 11:00:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 11:00:02 -0700 (PDT)
In-Reply-To: <xmqq37b37p9o.fsf@gitster.mtv.corp.google.com>
References: <20170613023151.9688-1-sbeller@google.com> <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com>
 <xmqqa85b9626.fsf@gitster.mtv.corp.google.com> <CAGZ79kYV8Ngis=ux50Zs1r5XOBUJ=hw2=8BEkNqk7PiGamX0AA@mail.gmail.com>
 <xmqqo9tr7qkk.fsf@gitster.mtv.corp.google.com> <CAGZ79kafV5aXd9SAOHHGOgsAdpuY=YV6yWoWSsuG9rncLYhphA@mail.gmail.com>
 <xmqqbmpr7pyj.fsf@gitster.mtv.corp.google.com> <CAGZ79kZNXCjBBnzPZLJqPY9S_ovPAegNT0pdCKAMWJH5AQoCCw@mail.gmail.com>
 <xmqq37b37p9o.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 11:00:02 -0700
Message-ID: <CAGZ79kakSt8bYr7E9gnNPSVFafyD9G+VUAU+hBBJnX+r_TH=Ag@mail.gmail.com>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 10:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I never said "start and end" (you did).  I just wanted the boundary
> of A and B and C clear, so I'd be perfectly happy with:
>
>          context
>         +A      dim
>         +A      dim
>         +A      highlight #1
>         +C      highlight #2
>         +B      highlight #1
>         +B      dim
>         +B      dim
>          context
>
> You can do that still with only two highlight colors, no?

So to put it into an algorithm:

1) detect blocks
2) if blocks are adjacent, their bounds are eligible for highlighting
3) the highlighting is implemented using the "alternate" strategy
  in that any line highlighted belonging to a different block flips
  the highlighting, such that:

          context
         +A      dim
         +A      dim
         +A      highlight #1
         +B      highlight #2
         +B      dim
         +B      dim
          context

So if we go this way, we would need indeed 6 colors:

  Dimmed, Highlighted, HighlightedAlternative

color-moved modes:
nobounds::
  uses dimmed only
allbounds::
adjacentbounds::
  See algorithm above, using dimmed for inside the block and
  both highlights for bounds, making sure adjacent block bounds
  alternate the highlighting color.
alternate::
  Uses only highlighting colors, complete block is colored with
  one of the highlights

I think that is reasonable to implement. But I do still wonder if
we really want to add so many new colors.
I'll give it a try after my next submodule series.

Thanks,
Stefan
