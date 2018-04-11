Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0996B1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 18:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeDKSIA (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 14:08:00 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:38030 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeDKSH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 14:07:59 -0400
Received: by mail-yw0-f177.google.com with SMTP id x20so858525ywg.5
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oc7BMQbtzNsjqQT5Iycz0IAeMpgkW3kupJjsBxdHQX4=;
        b=ceiAOt36TDfASUWtlzcfZWpzepIbbEzqzB2Hm8y9kGIGwXVMPdWxe/4yV3f4V/g7TU
         vGoeuQJWvGqqQWOo/aafkdIwYGe1qVAu+hEV2Ed55zeXTBOhbtEkh0l3Pv2N5e/ApDFi
         G3tyfvdKWiZE/RWioEQxNn42TvyQI6Zt6Cl5Tj/pX6MuqNk06JYT8bkiXq6TT0zGPMk0
         UMiYbZS2z6VbhjwqAYeDOKdOKMHzWx5ngbQYDco0TQkZS/2JBKcz0JCLi0UTWF91kwLz
         9+kS2hMWEhSfZPssjGc5yQoxOG2NQYQLsWkziqWEG02E+G8+FEAohKyCO5An3RsIjikj
         ZInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oc7BMQbtzNsjqQT5Iycz0IAeMpgkW3kupJjsBxdHQX4=;
        b=oEbYf1U/ULpDDGw4B0ms2bwQVfMu66d/clePl27gVjWie7DV3URFFRRvjRE/do+CCD
         zXMA/EBYOnIPrkdpS2DjxDKMPnWbOT/xpQmcZJ+p9HYzNcB4aKL+aVNmG+P2V1kmibmg
         CA6zjq9knu8igpzXOo9NwSEy/4sr9r4LuvkdWD4xg8pE7TqScII30zKVIanzu1tIWw8g
         MlAll9nwoUujp8BcDitX5EX5P6FzkRQHOr8uBVgKWyg1Vu+P5GsA9q39tGSf1feZmM7X
         TZcv/DETZp/ZZXuBPwbGtVtku8+g60elr5J//QQpkq84c+5/Xto8A0dBii3YPVpm2SeF
         aLXw==
X-Gm-Message-State: ALQs6tDOTIeue9o4rXZ/uTPFTVqvy7aiB35NhIEz0scgTqV7EIaIDqQz
        KkhcYjUa13Y8naMm9B8CGTyu+5NeHkocAmUZOqE+1A==
X-Google-Smtp-Source: AIpwx48Q8CP0mf/MIsHXctjgkKvqy6gFKREA4j6g9LBi25m9mYgPkjdeV35D5ojFJPb5GQXFcw2MZjZsVzu3EGMg9KY=
X-Received: by 10.129.86.5 with SMTP id k5mr2574812ywb.345.1523470077923; Wed,
 11 Apr 2018 11:07:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 11 Apr 2018 11:07:57
 -0700 (PDT)
In-Reply-To: <CAHwyqnURebvfW4rGz9RAbe7B9p6ZDy0jUueDFrYE30dmjCtMVA@mail.gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <20180409014226.2647-1-haraldnordgren@gmail.com> <20180409014226.2647-2-haraldnordgren@gmail.com>
 <CAHwyqnURebvfW4rGz9RAbe7B9p6ZDy0jUueDFrYE30dmjCtMVA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 11 Apr 2018 11:07:57 -0700
Message-ID: <CAGZ79kYeM=CqKSWTL2tdDXWueMGoki4zAUmFy4wbhtagN7gEAA@mail.gmail.com>
Subject: Re: [PATCH v14 2/4] ref-filter: make ref_array_item allocation more consistent
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harald,

On Wed, Apr 11, 2018 at 10:57 AM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> There have been no new comments for the last few days. I know Jeff
> King will be away for the next two weeks, but should we still move
> forward with this? The initial reactions to the idea seemed positive.

Please see the "What's cooking?" email on the mailing list that is
sent out periodically by Junio.
the last one is
https://public-inbox.org/git/xmqqd0z865pk.fsf@gitster-ct.c.googlers.com/
which says:

> * jk/ref-array-push (2018-04-09) 3 commits
> - ref-filter: factor ref_array pushing into its own function
> - ref-filter: make ref_array_item allocation more consistent
> - ref-filter: use "struct object_id" consistently
> (this branch is used by hn/sort-ls-remote.)
>
> API clean-up aournd ref-filter code.
>
> Will merge to 'next'.

It will be merged to next and if no people speak up (due to bugs
observed or such)
then it will be merged to master eventually, later.

I am not able to find the documentation for the workflow right now,
though it is partially covered in Documentation/SubmittingPatches.
