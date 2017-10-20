Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C408202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 21:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdJTVuS (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 17:50:18 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:44108 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbdJTVuR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 17:50:17 -0400
Received: by mail-qk0-f174.google.com with SMTP id r64so16023905qkc.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b0elE8U+bDK5Ts3pVrTgLuEEQIpzcQLomsAH4bog78A=;
        b=iBBLmPjmMm0OAmGosEqrP7BgGTD3ZddHJA+q2AmxWmhokUba97Z1U3vUwL9I2LyWpG
         1qRd6phv1tb4N0ijbZ2WOJVgG6vDqgvukGkWMkfiBAEif2Nbo51HnjeVlZxeAGof1s9a
         uE7j83baqOSa3nWqSf1XVfBSKWDXhqWUT07RfpWMc4jvmno9B6wWhRDijJSji3SDREEd
         KfsLko3WrKr6waQuvf8BhEljIcvi2ZKGuc+smdRlRTmf+9V2A5TjzAsQGns9hc0KOSC2
         SeYvLPbTvo9elJ901eBHVVJ5GyLrIyD75rohvLFnUyJhBymWkHOJlMFO9XVJKDNSO4o0
         VPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b0elE8U+bDK5Ts3pVrTgLuEEQIpzcQLomsAH4bog78A=;
        b=BdzI2G9JPuHv2RouRWnEV8P5LKBF70QfWuwVTow1WieFZ8wyTJlq7ZcUhmfTaKyTGF
         6UJhXoLqPpp3vt/moFC53E6zao9Y0cpXHxsUuHxCSjEQO3W0DeHCzOHYJl7obvh1l8sE
         scEt9Nhz/rzewaIEYa4RR92Fx/tdIgSZFRJftMHm88O/D3zXkfXlIGgitsPoOrwT3R6l
         JgruhcAvJH3MZqDWmRoKWGFDrjyWWydD4erm6nJaNG7jceBRkHlgs+2V42+iEFp/uzfx
         vNTPc/4mEQMkJnHttfwiHXtxzKUnfVP4rqqvkoXSTs7s3++/14AKnES9kPb9H7P4vOGn
         ROXQ==
X-Gm-Message-State: AMCzsaVOcC7wDYmqiPVWL3Dv5nUslrNlS1UphRY2NH3FwCcSF+Ro6pPL
        8K2RthUZOn3SQaHI8MkSCZq1B75WDE0StjdB5+vBzw==
X-Google-Smtp-Source: ABhQp+TxYTOMWDA7FeZr+yqHtdQB0TUiwJTngmVD7lVqhsbEgJAq8XQLQbWxfpyUqv8LDvHVliKHS3Pxzvox9eLNx+s=
X-Received: by 10.55.18.165 with SMTP id 37mr8880736qks.352.1508536216535;
 Fri, 20 Oct 2017 14:50:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 20 Oct 2017 14:50:15 -0700 (PDT)
In-Reply-To: <20170925082024.2691-3-kaarticsivaraam91196@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com> <20170925082024.2691-3-kaarticsivaraam91196@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Oct 2017 14:50:15 -0700
Message-ID: <CAGZ79kYLX+mXaWA-ZGnCWE7UBoZ2N76_MHQ6tB7+yGYDBRXUCA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] branch: re-order function arguments to group
 related arguments
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 1:20 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> The ad-hoc patches to add new arguments to a function when needed
> resulted in the related arguments not being close to each other.
> This misleads the person reading the code to believe that there isn't
> much relation between those arguments while it's not the case.
>
> So, re-order the arguments to keep the related arguments close to each
> other.

Thanks for taking a lot at the code quality in detail.

In my currently checked out version of Git, there are two occurrences
of create_branch in builtin/branch.c, this patch converts only one occurrence.

(So you'd need to convert that second one, too. Oh wait; it is converted
implicitly as the arguments are both '0':
    create_branch(branch->name, new_upstream, 0, 0, 0, \
        quiet, BRANCH_TRACK_OVERRIDE);
)

This leads to the generic problem of this patch: Assume there are other
contributors that write patches. They may introduce new calls to
`create_branch`, but using the order of parameters as they may
be unaware of this patch and they'd test without this patch.

As the signature of the function call doesn't change the compiler
doesn't assist us in finding such a potential race between patches.

I am not aware of any other patches in flight, so we *might* be fine
with this patch. But hope is rarely a good strategy.

Can we change the function signature (the name or another order
of arguments that also makes sense, or making one of the
parameters an enum) such that a potential race can be detected
easier?

Thanks,
Stefan
