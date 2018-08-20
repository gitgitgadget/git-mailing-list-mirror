Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65F91F97F
	for <e@80x24.org>; Mon, 20 Aug 2018 18:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeHTVzL (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:55:11 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34510 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTVzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:55:11 -0400
Received: by mail-yb0-f193.google.com with SMTP id t10-v6so1425832ybb.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HliKkzlR2uwqH1MgKGVoAztZeCcRiPkipMQ3gSIVJeY=;
        b=Fu9oQBfdiz7RGf9b0NW/JKnSUhmGl6CyjGtNKz0nl6tiyUDH7Gr969iowpUqzYXAsM
         yERZsK5IiNU/e6rWXb1DDqMBCF8Y4eWBmbAGyC8TsjPfQHZ12slWtQk+370v9EN1fKeT
         Akv9tv7Y4o+Skuv/YUhduoZG6yrLyIYVR1vPaPuc39jmx0YJ4sBzD3GGbHUq5E5lSl9G
         +tk3TYARiziKnbLSEmPlEY2TNFv/QpWb8RR6zEktGt6bX5/E3qIOQXmo7SeK0RY6N1ai
         qEAHW4j+k97mfqJ75vwxFtVvFGowfcti5whAzkJj8DEmOnB6M66Zb4VIWu6fs8L2B1fe
         vkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HliKkzlR2uwqH1MgKGVoAztZeCcRiPkipMQ3gSIVJeY=;
        b=n6mNRkNH1K2qC/c8IX+hC/GnW2KxiIs5e11wZLj9F5UxG6YGWaT/2iJn1RTpzqQTD7
         c+r5jmn/IRA603Y8EO9mLqwjGnfH09W3U6zwDFbPXhwc8ruaIwX+iVLkO811d0tDqXyE
         GSXUgiX3LDuqDf+ETS0xXvlBq4Sp1MwZCfwI3O0vX/La3a/2poOImE3on63r1zWBQH6i
         0eJ1lShYDyYLvIoaIvXG29PFNU8ktYXsgy1J9J++ckaMRF4vlMbq/4tVdykpWVN90OEd
         iMQ3+ILC/QBYGkhaqLQpjSfRc1fAG3DpCuH6U/9iPq5oMwIWJN361MOfJhfjcpvGTzNg
         fyeA==
X-Gm-Message-State: AOUpUlEozV+A4NovgxCef+Wk3/c5x6rckSUUQj42xaseCd1R0rRYr21S
        mGfueexaFC+qTk6Fcu1jA9YhZ7QElsPWqwH1rXdZrQ==
X-Google-Smtp-Source: AA+uWPxejkBE0eL5+vPLWAwJdJ7un52hdSHTuI5k+wHsAXlLwqgkfqOrxZZPHEkyZv3oiPbUTT52yVARzFaCGuZI0IY=
X-Received: by 2002:a25:6007:: with SMTP id u7-v6mr13776437ybb.191.1534790304819;
 Mon, 20 Aug 2018 11:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1534374650.git.matvore@google.com> <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
 <CACsJy8AE+MwBzzUFRGLKVp6vaAg2W_KO-qbUU2LQpd=rMQw2sA@mail.gmail.com>
 <cover.1533854545.git.matvore@google.com> <msg.1534770125.matvore@google.com>
In-Reply-To: <msg.1534770125.matvore@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 11:38:13 -0700
Message-ID: <CAGZ79kZfNeWnZEnX4Z0hMShxZZEsB2jYJ67JgE7F_d-3ymHi+A@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     Matthew DeVore <matvore@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 6:18 AM Matthew DeVore <matvore@google.com> wrote:
>
> There were many instances in this file where it seemed like BUG would be
> better, so I created a new commit before this one to switch them over. The
> interdiff is below.
>
> BTW, why are there so many instances of "die" without "_"? I expect all
> errors that may be caused by a user to be localized.

Well, there is the porcelain layer to be consumed by a human user
and the plumbing that is good for scripts. And in scripts you might want
to grep for certain errors and react to that, so a non-localized error
message makes the script possible to run in any localisation.

The BUG is strictly for things that are due to Gits internals,
not for problematic user input. Problematic user input
definitely wants a die(...), and depending on the plumbing/porcelain
layer it may need to be _(translatable).

I think BUG() would never go with translated strings.

> I'm going by the output of this: grep -IrE '\Wdie\([^_]' --exclude-dir=t
>
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index 8e3caf5bf..09b2b05d5 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -44,8 +44,7 @@ static enum list_objects_filter_result filter_blobs_none(
>
>         switch (filter_situation) {
>         default:
> -               die("unknown filter_situation");
> -               return LOFR_ZERO;
> +               BUG("unknown filter_situation: %d", filter_situation);
>
>         case LOFS_BEGIN_TREE:
>                 assert(obj->type == OBJ_TREE);
> @@ -99,8 +98,7 @@ static enum list_objects_filter_result filter_trees_none(
>
>         switch (filter_situation) {
>         default:
> -               die("unknown filter_situation");
> -               return LOFR_ZERO;
> +               BUG("unknown filter_situation: %d", filter_situation);
>
>         case LOFS_BEGIN_TREE:
>         case LOFS_BLOB:
> @@ -151,8 +149,7 @@ static enum list_objects_filter_result
> filter_blobs_limit(
>
>         switch (filter_situation) {
>         default:
> -               die("unknown filter_situation");
> -               return LOFR_ZERO;
> +               BUG("unknown filter_situation: %d", filter_situation);
>
>         case LOFS_BEGIN_TREE:
>                 assert(obj->type == OBJ_TREE);
> @@ -257,8 +254,7 @@ static enum list_objects_filter_result filter_sparse(
>
>         switch (filter_situation) {
>         default:
> -               die("unknown filter_situation");
> -               return LOFR_ZERO;
> +               BUG("unknown filter_situation: %d", filter_situation);

Up until here we just have replace the die by BUG in the default
case of the state machine switch. (We need the default due to strict
compile flags, but as filter_situation is an enum I thought we would not
as compilers are smart enough to see we got all values of the enum
covered).

I agree that keeping the defaults and having a BUG() is reasonable.


>
>         case LOFS_BEGIN_TREE:
>                 assert(obj->type == OBJ_TREE);
> @@ -439,7 +435,7 @@ void *list_objects_filter__init(
>         assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
>
>         if (filter_options->choice >= LOFC__COUNT)
> -               die("invalid list-objects filter choice: %d",
> +               BUG("invalid list-objects filter choice: %d",
>                     filter_options->choice);

This also makes sense, combined with the assert before, this looks like
really defensive code.

I think this patch is a good idea!

Thanks,
Stefan
