Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D071F576
	for <e@80x24.org>; Tue, 13 Feb 2018 09:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934294AbeBMJ5y (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 04:57:54 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:44674 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933872AbeBMJ5v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 04:57:51 -0500
Received: by mail-ot0-f177.google.com with SMTP id l5so16791797otj.11
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 01:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VSUrzAARTHpQ7pCawElLcx9nmi7lKuC05cua9tPiOI8=;
        b=i9v6duLihaJYj0LkuuHbNXDC9B0xNY3DbacSNdM341eAUAeYjBPsIsGhsXjreAR2lM
         FloV4D5CI9B2nmZAyEk+LhO/UT56jLmMMojZ41tEVusbkPeon6+W9IF8MKex4SSNDDgk
         5BuVvZN5s6f0OiBLH4iXhwWQnhRFX0Wf/+L9F0y0qUo5R664iJcR7kHoEtQ9NcfFGdyx
         a0efzFgQh+ijQYVyc4Usj2v0GUdtguGC6VFNcVSpkaazBc+t9yOwygCFPRZ+psP/KWW/
         jWgCFutokok5BuzjrgzEG8s8Mz7v8Qo0ZqcYbtGzVl4QurqqOr/t6+h4hXidzgRfKw5T
         cJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VSUrzAARTHpQ7pCawElLcx9nmi7lKuC05cua9tPiOI8=;
        b=cno5j2EXHUOiFg1u65pZNJgdWglvCUfVc5G+jeLk8I5cS/rBj6L5m3WkjRDPfBKf1t
         uNDcdzEpKewvlXZyUYzAjuWqtiiOf+RhArC/VirOfEJACIi3nkd5RSAAgABY+c/xa24X
         kN80VV/WVwk7KvXqGu+8od6YATViyrJYu88PW2uaYUwRzIH+hTDuG5cn7axAo68uWvIB
         FHLbdPgyKN3w+CY2EbFhHnRN0bmhuUNXOCUqpcpC6hIzbzNloHesFTQTco25C/8a45jl
         saml5KHTlG2EXTqliVkU47QP9gQqnhMJkZzUKrHLVoqGejbydUcvQ7I5fgbYAVQsVoGM
         UW7g==
X-Gm-Message-State: APf1xPBXhM5hSsRBZZHvVVWCDgdSpQZboXnTlLhYBTlfzX+dY3B51rJB
        V8qt5LAwr6xEZYb4nEHJB1KVpDAqno3d7aelguI=
X-Google-Smtp-Source: AH8x2257LFf5+tOLkxT9VLZadDkV2JnSB8g91DAMs8KEVTyoSdwVZqcON0rHhNz4JzDQxUUx/sZRBW/oCNoX9fw1rHc=
X-Received: by 10.157.14.67 with SMTP id n3mr425057otd.337.1518515871357; Tue,
 13 Feb 2018 01:57:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 13 Feb 2018 01:57:20 -0800 (PST)
In-Reply-To: <d1371a6c-2b30-515a-372e-4fea9bc09c43@gmail.com>
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180205215805.GA90084@google.com> <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
 <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>
 <0039c71c-cefd-4950-aa7c-ffbb7cf66e49@gmail.com> <CACsJy8A2=tWpiBOBxmTLHXm6bvjGCdoDEuJEy7PewvnzEQi2Qg@mail.gmail.com>
 <d1371a6c-2b30-515a-372e-4fea9bc09c43@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 13 Feb 2018 16:57:20 +0700
Message-ID: <CACsJy8BWh=e6_Sz20djd5ixxm_Pwa43OHNzXrBatm14k0P+qxQ@mail.gmail.com>
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
To:     Ben Peart <peartben@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 12:57 AM, Ben Peart <peartben@gmail.com> wrote:
>> Another case that could touches a lot of directories over time is
>> switch trees (e.g. "git checkout master" then "checkout next" or worse
>> "checkout v1.0").
>
>
> You're example above makes me wonder if you understand what my patch is
> doing.  If the index is flagged as dirty for _any_ reason, the entire index
> is written to disk with the latest information - including the updated
> untracked cache and all other extensions.  So in your checkout examples
> above, the index will still get written to disk with the updated untracked
> cache extension.  There would be zero change in behavior or performance.
> The _only_ time the index is not written to disk after my patch is if there
> were no other changes to the index.  In my experience, that is only status
> calls.

The untracked cache is updated and does get written down, but it's not
"repaired" unless you have called read_directory() before the index is
written. Though paths that hit untracked_cache_invalidate_path() will
continue on slow path until you call read_directory() and write down.
I don't think "git checkout" calls read_directory. There are some
commands, like "git add", that update the index and call
read_directory() at the same time. So yes I was wrong, the untracked
cache can be repaired sometimes, not never repaired.

We do try to improve performance at "git checkout" and a couple other
"slow" commands though (e.g. repair cache tree), perhaps we can do the
same for untracked cache. Though the cost of updating untracked cache
is potentially much higher than cache tree.
-- 
Duy
