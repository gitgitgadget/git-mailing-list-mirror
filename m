Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186CE1FAD5
	for <e@80x24.org>; Mon, 20 Aug 2018 23:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeHUCik (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 22:38:40 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44749 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeHUCik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 22:38:40 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so28885512oih.11
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9SsY7JH3lnm+Z/v9u9KRcs9rYO49LK7Wdd6lLkEvKc=;
        b=koram6NqZbbD4onWJ0fEy5loXnpi3y7nM0dlsmdVaD0oNyhj+vqclwIO2pBO2pXj92
         oQxnML2kl7rVW1WIWm2ufBacSvMfqWyLMF90UGCi2pMGFcuCkTmiR89VD271l6fKfold
         BeJGkN8xcaGhz/mpzGX4ZsLhCFa1TQ/smY0EHGrry8J5+DXn8RvaY96fvTCbtDfvq++G
         nxdVHUSPP9cSIt0nRlVSs70OXb7R6/wE6m7qJj1q6KOAb1wz4z2eyZI9KM7FPycF7ZNV
         pgAgk6ffybSyMX0Fmp7BTwiUujLu+ybX5hYb1Ewnd8bMXNZ85qwh8AKmVXIywLBcNBDJ
         jqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9SsY7JH3lnm+Z/v9u9KRcs9rYO49LK7Wdd6lLkEvKc=;
        b=OY8PYfxKDamMgytw+STSUXWEsVwfSRJ29fr3dPBd/oCpUY4Zdx5hnsh8WYRRtCtIqe
         oTGbB6rxtyoblT+IZWin3W0oeOfvirfTKQVI1Qw7AM1yK+XQdbDboITv7amqIs3TYnn9
         j0bQXcD1esWSGpHfoQEusmqGCaf7aFiYdlorfPLimA33GEICTXp7VxC6pJBWx5I7UgJx
         dLlrhahYQwffZvXiP38IeDnjHl08kB608SGTscBvnCmoXubK2fEpDcVkcgM+YiOc5PwK
         nJDuMWkZz7b3LXOsCy/+RDgzIGXMoDUecm4oXppvN2hYUtfqdssZS+UwKPDXwbHr6ofF
         8khQ==
X-Gm-Message-State: AOUpUlHj760yzh0/+4qtNcLtd8ZcvZMATS56/YQMDRQoM2GMOcP0nHVF
        ojQLnbSsrQHgS2b8EnNaO/aHNg3y1u3+t0NT6kD3
X-Google-Smtp-Source: AA+uWPxiPQJAPdlu9Ricp5TL5pF5Gxrd8bKqzAaCmsRHbEyoQjMbYBp0TgnWpmRc5gl3kDpD0sx8nqDTIFRwZ27dF0c=
X-Received: by 2002:aca:3507:: with SMTP id c7-v6mr17642151oia.46.1534807261959;
 Mon, 20 Aug 2018 16:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1534374650.git.matvore@google.com> <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
 <CACsJy8AE+MwBzzUFRGLKVp6vaAg2W_KO-qbUU2LQpd=rMQw2sA@mail.gmail.com>
 <cover.1533854545.git.matvore@google.com> <msg.1534770125.matvore@google.com> <CAGZ79kZfNeWnZEnX4Z0hMShxZZEsB2jYJ67JgE7F_d-3ymHi+A@mail.gmail.com>
In-Reply-To: <CAGZ79kZfNeWnZEnX4Z0hMShxZZEsB2jYJ67JgE7F_d-3ymHi+A@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 20 Aug 2018 16:20:50 -0700
Message-ID: <CAMfpvh+7NoOGAmypGSCAtxH7DxHTvVB8_C3OkWNC14+c3MBO4A@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, git@vger.kernel.org, git@jeffhostetler.com,
        jeffhost@microsoft.com, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 11:38 AM Stefan Beller <sbeller@google.com> wrote:
>
> On Mon, Aug 20, 2018 at 6:18 AM Matthew DeVore <matvore@google.com> wrote:
> >
> > There were many instances in this file where it seemed like BUG would be
> > better, so I created a new commit before this one to switch them over. The
> > interdiff is below.
> >
> > BTW, why are there so many instances of "die" without "_"? I expect all
> > errors that may be caused by a user to be localized.
>
> Well, there is the porcelain layer to be consumed by a human user
> and the plumbing that is good for scripts. And in scripts you might want
> to grep for certain errors and react to that, so a non-localized error
> message makes the script possible to run in any localisation.
>
> The BUG is strictly for things that are due to Gits internals,
> not for problematic user input. Problematic user input
> definitely wants a die(...), and depending on the plumbing/porcelain
> layer it may need to be _(translatable).
Ah I see. Plumbing commands are not translated. Makes perfect sense now.

>
> I think BUG() would never go with translated strings.
>
> > I'm going by the output of this: grep -IrE '\Wdie\([^_]' --exclude-dir=t
> >
> > diff --git a/list-objects-filter.c b/list-objects-filter.c
> > index 8e3caf5bf..09b2b05d5 100644
> > --- a/list-objects-filter.c
> > +++ b/list-objects-filter.c
> > @@ -44,8 +44,7 @@ static enum list_objects_filter_result filter_blobs_none(
> >
> >         switch (filter_situation) {
> >         default:
> > -               die("unknown filter_situation");
> > -               return LOFR_ZERO;
> > +               BUG("unknown filter_situation: %d", filter_situation);
> >
> >         case LOFS_BEGIN_TREE:
> >                 assert(obj->type == OBJ_TREE);
> > @@ -99,8 +98,7 @@ static enum list_objects_filter_result filter_trees_none(
> >
> >         switch (filter_situation) {
> >         default:
> > -               die("unknown filter_situation");
> > -               return LOFR_ZERO;
> > +               BUG("unknown filter_situation: %d", filter_situation);
> >
> >         case LOFS_BEGIN_TREE:
> >         case LOFS_BLOB:
> > @@ -151,8 +149,7 @@ static enum list_objects_filter_result
> > filter_blobs_limit(
> >
> >         switch (filter_situation) {
> >         default:
> > -               die("unknown filter_situation");
> > -               return LOFR_ZERO;
> > +               BUG("unknown filter_situation: %d", filter_situation);
> >
> >         case LOFS_BEGIN_TREE:
> >                 assert(obj->type == OBJ_TREE);
> > @@ -257,8 +254,7 @@ static enum list_objects_filter_result filter_sparse(
> >
> >         switch (filter_situation) {
> >         default:
> > -               die("unknown filter_situation");
> > -               return LOFR_ZERO;
> > +               BUG("unknown filter_situation: %d", filter_situation);
>
> Up until here we just have replace the die by BUG in the default
> case of the state machine switch. (We need the default due to strict
> compile flags, but as filter_situation is an enum I thought we would not
> as compilers are smart enough to see we got all values of the enum
> covered).
At the risk of going on a tangent, I assumed this was because enums
are really ints, and the "default" is there in case the enum somehow
got assigned to an int without a corresponding value. Either because
of a cast from an int that was out-of-range, or new values that were
obtained from arithmetic or bitwise operations on the declared enum
values, which created undeclared values.

>
> I agree that keeping the defaults and having a BUG() is reasonable.
>
>
> >
> >         case LOFS_BEGIN_TREE:
> >                 assert(obj->type == OBJ_TREE);
> > @@ -439,7 +435,7 @@ void *list_objects_filter__init(
> >         assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
> >
> >         if (filter_options->choice >= LOFC__COUNT)
> > -               die("invalid list-objects filter choice: %d",
> > +               BUG("invalid list-objects filter choice: %d",
> >                     filter_options->choice);
>
> This also makes sense, combined with the assert before, this looks like
> really defensive code.
>
> I think this patch is a good idea!
Thank you for your feedback :)

>
> Thanks,
> Stefan
