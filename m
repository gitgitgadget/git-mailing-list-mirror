Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92E61F462
	for <e@80x24.org>; Wed, 29 May 2019 07:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfE2HaJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 03:30:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44745 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2HaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 03:30:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so2127279edm.11
        for <git@vger.kernel.org>; Wed, 29 May 2019 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCdxiaxQFaQR670YYnvcpXEnrB2JVwIGcQ73t4wyjNQ=;
        b=W0svx5APlF3cMHHkiwW+WYQ9dFLh11upC4N+5B37JJhH/+sgYdE68oRqZkukbOPgly
         5EOxoxRKpZc31tDAVisTuLGUk83IVV5vfUH+LbHm2aHbAhOS6eUPyLtRNzdscpGv3GiZ
         rJ3UFGBv/ntcifsmj9d002Ng3wz92U2stGWUdU0RYtmhMCJAli6N+n/D8I215vJF672G
         Lz88/BdofB/n6ZerCtarCjyNxNKJzAF+dXPYFuG8ZahXAaY4t7CxpWaFA14t2teF7UnV
         3wlS84dIHmji+uiTg3k+BF9oLJ/X6XvUCOjYuyablTvm2JDPHBFm1B2To1Bn847jF0pG
         eZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCdxiaxQFaQR670YYnvcpXEnrB2JVwIGcQ73t4wyjNQ=;
        b=PH4T80i3IBBA74mALQNhcopyridAvaSOfDSRoWGFeTAiNZxFpo1eUF/DWl7fuq7Paw
         m8L/mVniIPaVnlz3paqtLjRQbHr7hKq16crIX4SgFUMC8/s6uNkga/68BOFeeKTv/EWk
         WgJCWfl3UpUNfSvmV3jygtn2cGsbbRDEe/EPJ7/2gdb9P8JSkEyqd/K3I/18XZtXsQ5j
         H2O5zguL11vYpK0ssmsoUPrAkMeGmYIzkW23Lz5U8H4DCYHf9eDKzJvs0Jc/f0thSopV
         ZE7wHPJW6vMvvtw4bHdmR+Tchf+6IHtUELNDbHQ7ZVqXtAylkpullhclJLGTrvRhBcUA
         NOYg==
X-Gm-Message-State: APjAAAXvg3EQ6burCReARIP9vkzSkmR3JlbuIZ5peJc5Ok3TaS6deZcb
        d6x/OpfAIjf53f4O0yY6ZkmBNJldN6I/8CcKdVg3KEjrRZI=
X-Google-Smtp-Source: APXvYqzmHvWXsJ8arJb7OBjrsmIiVwmnhsYkJSRCED59oZUhBIdd2i77BYbQIMbjUGYNw82UryUVDuxkMGghdWWEsMQ=
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr46585010ejb.217.1559115007138;
 Wed, 29 May 2019 00:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190525142834.6168-1-chriscool@tuxfamily.org> <xmqqo93m1i49.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo93m1i49.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 29 May 2019 09:29:55 +0200
Message-ID: <CAP8UFD08pOmUGkTT3BtDqLwB0g3Q_C0_+RctGb_WfFq7K-7wsA@mail.gmail.com>
Subject: Re: [PATCH v2] list-objects-filter: disable 'sparse:path' filters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 9:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> What is curious is that this does not touch Documentation/ hierarchy
> at all---is that a sign that nobody makes any serious use of the
> --filter=... thing and we can freely drop "features" around it when
> we see it necessary (like in this case)?

I just forgot about the Documentation.

> Or do we need something like this on top (or squashed in)?  I can
> live with or without "Note that..." myself.

Yeah, I will squash something like what you suggest soon.

>  Documentation/rev-list-options.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index ddbc1de43f..73aafea8d6 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -725,9 +725,6 @@ specification contained in the blob (or blob-expression) '<blob-ish>'
>  to omit blobs that would not be not required for a sparse checkout on
>  the requested refs.
>  +
> -The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
> -specification contained in <path>.
> -+
>  The form '--filter=tree:<depth>' omits all blobs and trees whose depth
>  from the root tree is >= <depth> (minimum depth if an object is located
>  at multiple depths in the commits traversed). <depth>=0 will not include
> @@ -737,6 +734,9 @@ tree and blobs which are referenced directly by a commit reachable from
>  <commit> or an explicitly-given object. <depth>=2 is like <depth>=1
>  while also including trees and blobs one more level removed from an
>  explicitly-given commit or tree.
> ++
> +Note that the form '--filter=sparse:path=<path>' that wants to read from
> +an arbitrary path on the filesystem is not supported, for security reasons.

I'd rather say:

"Note that the form '--filter=sparse:path=<path>' that wants to read from
an arbitrary path on the filesystem has been dropped for security reasons."

to be more consistent with the error message (that Matthew suggested
in a comment following my initial RFC patch).

Thanks,
Christian.
