Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90342C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 14:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F0376100C
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 14:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhDBOjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 10:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbhDBOjp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 10:39:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CCFC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 07:39:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d13so7872595lfg.7
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gG7ZY95BWxRn7sDw2GVuje/QANKyz7kVWqSlfrTGJtM=;
        b=zAiQ2ecVffS9jKUoKIi0TSMOSJiyAS4hwLWkXLah/wmt2t68JaJukgI+PC8yKiEuqH
         S/irOHUsa1PQ8Y+RvGbnHMsHFUSqxO/7ZZgHgc1cK7nL/AzOmKapAFylDHJvOxPwtcOO
         rbN/ocDqN3j7SPHNLcK38cCAnwUrduaOyRw0vXN3nFwuxgQ9dpAuaP0f3g4h6TW2wpV6
         Hjk3zCNehUuq8e+ryZ/2lbbz3MsOsM5MCpLxl11oOAHoiujPOHdHwVJ7Y06kVm3cJ1wA
         xa3DV8peuQWnS/80jNCfbFm7Slm7+5Vol8PV6uc6hqQi7ps1ghsuUhCMe0+6ztJfxWLV
         hEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gG7ZY95BWxRn7sDw2GVuje/QANKyz7kVWqSlfrTGJtM=;
        b=YgTEm3+jHD9BeXVrmgqAgsTOtu7ckqrrdPPKvJhN8PaE8mLkEqklh8QwrZ9goNwRLU
         kLlmvrG0nFxSlEEX6iRNn7mXOUtcP3nYIU2501snvEM+IGDhiFMy2bKlBG072jwIMjRV
         IGNVqx5Ke8E3lHLkHcXFnJ95J5msK9FD4Mk6NU1w7dnKSBQaXl9rGp9PnYrL8C+5M9gI
         4c24RxIqRXsQfWkG5dkR+HJxvexozlbP3WQwnXXzMFawoKHLAx20xoKtIChF5FKFhyRv
         qk7dBr4F86HD6Qd25gqk/21lfuSnKisQdGjOuRZFlbm8yzkcmygMqP8/0+G1GtdQvGch
         zdKA==
X-Gm-Message-State: AOAM532HXTGytoeKe58SswrwQw+yqU67WDjKTFzejnbNUXRp1kLsbHMW
        0drGI+CzLVgKLDyelMemlnkWbbVI+OFCz+MNkB4w/g==
X-Google-Smtp-Source: ABdhPJzPVbEG9Xw38NfDEN/0LwMYg9jQ1H68cD8Al7gXqe9Zp9l/9iH3NrxMlbxgr+ZwTPatdzaZ1HhBV+oMK7WCzOQ=
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr9172772lfn.354.1617374381640;
 Fri, 02 Apr 2021 07:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616015337.git.matheus.bernardino@usp.br>
 <a3383042e2ee6c454e024db7a9154dc979a5af9e.1616015337.git.matheus.bernardino@usp.br>
 <CAP8UFD2eaaQEuytk6cPoYco2_dfdbsM3aAvJyYFqgYSfkZ487g@mail.gmail.com>
In-Reply-To: <CAP8UFD2eaaQEuytk6cPoYco2_dfdbsM3aAvJyYFqgYSfkZ487g@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 2 Apr 2021 11:39:30 -0300
Message-ID: <CAHd-oW7TYmbJAx9Jrzwsfb0zsdT=KmhumJnOJygk0yTWTW3i=Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] unpack-trees: add basic support for parallel checkout
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 1:22 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Mar 17, 2021 at 10:12 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>
> > +struct parallel_checkout_item {
> > +       /* pointer to a istate->cache[] entry. Not owned by us. */
> > +       struct cache_entry *ce;
> > +       struct conv_attrs ca;
> > +       struct stat st;
> > +       enum pc_item_status status;
> > +};
> > +
> > +struct parallel_checkout {
> > +       enum pc_status status;
> > +       struct parallel_checkout_item *items;
> > +       size_t nr, alloc;
> > +};
>
> It looks like this struct parallel_checkout contains what is called
> the parallel checkout queue in many places. It would be a bit better
> if a name or at least a comment could make that clear.

Right, will do.

> > +       case CA_CLASS_INCORE_PROCESS:
> > +               /*
> > +                * The parallel queue and the delayed queue are not compatible,
> > +                * so they must be kept completely separated. And we can't tell
> > +                * if a long-running process will delay its response without
> > +                * actually asking it to perform the filtering. Therefore, this
> > +                * type of filter is not allowed in parallel checkout.
> > +                *
> > +                * Furthermore, there should only be one instance of the
> > +                * long-running process filter as we don't know how it is
> > +                * managing its own concurrency. So, spreading the entries that
> > +                * requisite such a filter among the parallel workers would
> > +                * require a lot more inter-process communication. We would
> > +                * probably have to designate a single process to interact with
> > +                * the filter and send all the necessary data to it, for each
> > +                * entry.
> > +                */
> > +               return 0;
>
> So it looks like we don't process entries that need filtering. It's a
> bit disappointing as the commit message says:
>
> "This new interface allows us to enqueue some of the entries being
> checked out to later uncompress, smudge, and write them in parallel."
>
> So it seems to say that entries could be smudged in parallel. Or maybe
> I am missing something?

Good point, this part of the commit message is indeed misleading. Only
internal filters, like re-encoding and end-of-line conversions, can be
performed in parallel. I'll rephrase that sentence, thanks!

> > +static int handle_results(struct checkout *state)
[...]
> > +
> > +       if (have_pending)
> > +               error(_("parallel checkout finished with pending entries"));
>
> Is this an error that can actually happen? Or is it a bug? If this can
> actually happen what is the state of the working directory [...] ?

This could happen both due to a bug or due to an actual error, e.g. if
one of the workers die()s or gets killed before finishing its work
queue. In these cases, the files associated with the unfinished items
will be missing from the working tree, and their index entries will
have null stat() information.

> [...] and what
> can the user do? Start another checkout with an option to do it
> sequentially?

Hmm, it depends on what caused the error. For example, if the user
accidentally killed one of the workers, starting another checkout
(either parallel or sequential) should be able to create the missing
files. But that might not be the case if the error was caused by a
fatal condition in one of the workers which led it to die() (like a
packet write failure or corrupted object).

Nevertheless, I think it might be interesting to rephrase the error
message here to be more explicit about the outcome state. Perhaps even
mention how many entries will be missing.

> [...]
>
> > +static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
> > +                              const char *path)
> > +{
> > +       int ret;
> > +       struct stream_filter *filter;
> > +       struct strbuf buf = STRBUF_INIT;
> > +       char *new_blob;
> > +       unsigned long size;
>
> I thought that we shouldn't use unsigned long anymore for sizes, but
> unfortunately it looks like that's what read_blob_entry() expects.
>
> > +       size_t newsize = 0;
>
> I don't think we need to initialize newsize. Also we could perhaps
> declare it closer to where it is used below.
>
> > +       ssize_t wrote;
> > +
> > +       /* Sanity check */
> > +       assert(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
> > +
> > +       filter = get_stream_filter_ca(&pc_item->ca, &pc_item->ce->oid);
> > +       if (filter) {
> > +               if (stream_blob_to_fd(fd, &pc_item->ce->oid, filter, 1)) {
> > +                       /* On error, reset fd to try writing without streaming */
> > +                       if (reset_fd(fd, path))
> > +                               return -1;
> > +               } else {
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       new_blob = read_blob_entry(pc_item->ce, &size);
> > +       if (!new_blob)
> > +               return error("unable to read sha1 file of %s (%s)", path,
>
> With the support of sha256, I guess we should avoid talking about
> sha1. Maybe: s/sha1/object/ Or maybe we could just say that we
> couldn't read the object, as read_blob_entry() would perhaps read it
> from a pack-file and not from a loose file?

Good point, thanks!

> > +                            oid_to_hex(&pc_item->ce->oid));
> > +
> > +       /*
> > +        * checkout metadata is used to give context for external process
> > +        * filters. Files requiring such filters are not eligible for parallel
> > +        * checkout, so pass NULL.
> > +        */
> > +       ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
> > +                                        new_blob, size, &buf, NULL);
> > +
> > +       if (ret) {
> > +               free(new_blob);
> > +               new_blob = strbuf_detach(&buf, &newsize);
> > +               size = newsize;
>
> "newsize" seems to be used only here. It would be nice if we could get
> rid of it and pass "&size" to strbuf_detach(), but maybe we cannot
> because of the unsigned long/size_t type mismatch. At least we could
> declare "newsize" in this scope though.

Sure, I'll move "newsize" down to this block and remove the
initialization, thanks.
