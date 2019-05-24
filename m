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
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5E31F462
	for <e@80x24.org>; Fri, 24 May 2019 19:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391775AbfEXTnc (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 15:43:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33858 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391745AbfEXTnc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 15:43:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id p27so15863132eda.1
        for <git@vger.kernel.org>; Fri, 24 May 2019 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZuVgtKdOBTcd3Q+3VZXXXsYGGwi7IdGrXlkfD1MuPQ=;
        b=oC4vGOyXTpCsx7c5lW3X8HZKnYbLbpRPZV7JPxvPgNODHkQ+OQK8R9kx/UytFIVcyB
         TEAUOBvDQirs98UWZLnpQOi3/ZJ8wEFBymnNNIL/KKnWfl013qB6W7tY/cAOcRDlnZVG
         re45Yie7+jIzq0BA/ZHu8ZKiEOnLT2b0CzB4TDhkvHdgzgTbP47SVADOduiuEhe/rrVj
         5nVsJlSnIRxwqHs1T3M/lAyh8dnpsYv/S6CBVq+8EJHawUwo1O/+IJi8tWZf20Ls0SW0
         iEprxEQK078YhCerdKE83AVnqt628zdHvSjqQfTDAi6lbBzYmBE2jP0mXRp6kY1fLRZO
         pQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZuVgtKdOBTcd3Q+3VZXXXsYGGwi7IdGrXlkfD1MuPQ=;
        b=sUzzPqYGhyYjTpA2pZ91nBD7kAk3VwUWU7v3ad6k4+Z3KdtckEKi8cnFSeBBEHM0FB
         3Cdbwma0M4938KVbiKmw3lJoWEVdaxC/QGcrEUgXzlysspE90x7Wzu6KIn1HmaOpWuOF
         9KboE/vKBYPQvev8YneZ7cYBV1/VqMGSHUZQDhCBj2//LubcGhEuWnImcqLgjKsOrBhv
         sBoXbrE1H4CPpHy47ZabqLLrNhsF+5Yh+jwG5JMqOAMzg1wuL3Ojfe5BvrBBbVhkDkjO
         bT+4+VZBFkFAd/PuPFIsPSNh4JsQhg5lbwr3Of68WsIdKduWgd05fs3f8jqn6XNCh+b+
         7hJg==
X-Gm-Message-State: APjAAAVS0dgc99mEiLZG3h6dOr6BookrG1UB/hVfDojgyja7UDnyiNX0
        MbXAR20Wa1VKSbGgIlxx36XT2cGiO+QEAHuIpYU=
X-Google-Smtp-Source: APXvYqwsbxWaQC42Y8LRU6DmfIsEyowqN8sw8l9UWFM8tMdVjNL37uJEozGeWN3bQ3NSdyCKWKA6tI0UMFRBKrmaEis=
X-Received: by 2002:a50:a51c:: with SMTP id y28mr100840433edb.280.1558727010662;
 Fri, 24 May 2019 12:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190524120318.4851-1-chriscool@tuxfamily.org> <20190524170758.GB7160@comcast.net>
In-Reply-To: <20190524170758.GB7160@comcast.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 24 May 2019 21:43:18 +0200
Message-ID: <CAP8UFD1uojiT+PSAWTq9+hvr5Nzc707=4+Wfmm=pwJbzN1es-w@mail.gmail.com>
Subject: Re: [RFC PATCH] list-objects-filter: disable 'sparse:path' filters
To:     Matthew DeVore <matvore@comcast.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 7:08 PM Matthew DeVore <matvore@comcast.net> wrote:
>
> On Fri, May 24, 2019 at 02:03:18PM +0200, Christian Couder wrote:
> > For now though, let's just disable 'sparse:path' filters.
>
> This is probably the right thing to do. I did jump through a lot of hoops to
> support escaping sub-filters in my pending filter combination patchset, since
> sparse spec path names can have arbitrary characters. After this patch we only
> support a handful of characters in filterspecs, so a lot of that escaping logic
> can be dropped, at least for now. Anyway, this is not a complaint, just an
> observation.

Thanks for telling about it.

> >       } else if (skip_prefix(arg, "sparse:path=", &v0)) {
> > -             filter_options->choice = LOFC_SPARSE_PATH;
> > -             filter_options->sparse_path_value = strdup(v0);
> > -             return 0;
> > +             if (errbuf) {
> > +                     strbuf_addstr(
> > +                             errbuf,
> > +                             _("sparse:path filters are now disabled"));
>
> This wording may leave room for misunderstanding, since it sounds a little like
> the filter can be re-enabled somehow. Maybe you can say "sparse:path filters
> support has been dropped [optional: 'for security reasons' etc.]"

Yeah, that seems better to me.

> >        * Please update _git_fetch() in git-completion.bash when you
>
> As the comment states, don't forget to update git-completion.bash :)

Ok, I will resend soon with better wording and an update to
"git-completion.bash".
