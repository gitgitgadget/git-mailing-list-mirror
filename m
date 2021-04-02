Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18356C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 14:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E972A60200
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhDBOmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 10:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBOml (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 10:42:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E645BC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 07:42:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r20so5837456ljk.4
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BM+ffRbSEKqdNt0dI/IxPBI63cemClWFIlv1zb2NMg=;
        b=t3LDV29uGT2It8cJaZA/2sT9ClJU6QgTaKbl6H0QKU3aQMUFIgeqxd47szraMYzEwN
         2ufuBdRA3UM8aWl3/BfQsUCMTGmwsTUtWcDGFk/5zz/dTS/DyLrFJEFwr7CCr12ARGFS
         9KBP4qiaT0RaCbd7NhpLW1+Os+Zq+GQH+14/u+uVYwpruAfXDpxt9b8WlAOxcaPVhqPB
         QpG6m1a+d6PZgft2GxGDVetTihVPpgujHqzrlHJ6tC2F3Dv6xupwHVBoefHRTdilCxUT
         orEB1nvi5P0EiZyaLMKXPw8HX51nzsiKMXJOk+6O9pxD35OU6h3QwLu9d/XBXxsB81h6
         xxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BM+ffRbSEKqdNt0dI/IxPBI63cemClWFIlv1zb2NMg=;
        b=bg2JEUn+ZTdlh6w6xMbhZghLL+PUNxzuU8e6Lx3j7KS8YceOZr+XZ5txQqYssr8MfF
         UXBmxOE98XkzpDeazkR5bOBmXSIWDyT+35xXI0lFXLxr0zzQVy5dmQYaqobizcAURmyy
         TJ5CKqpJpy+7FocwWDrBOoz5BpwcNa3FY0hHMtbXQdmGzsE6gvRaY7y12yG8tR+Q6QPw
         ogNiQsukNOI31INcPiIxBCskyX8/BF/9hWv5VERx1YXpmu7hdEwDtI8RzJUV4bWhKw7Q
         4se0RlmudYIX+XsxEYgoRMPVhNMWhFTBGhyp1Gb7TpnPFCsoWSXdbY0XNVifPCWxVwB6
         Ms8A==
X-Gm-Message-State: AOAM530akWL9aVoHVeLeGZ61zxKMC+r/M8qlwSLvrAlcdESMCkoz6tlx
        futRpBEwhKT1XSfWlKUaZZmp3CJ7iP7fJ58RMZN42A==
X-Google-Smtp-Source: ABdhPJxovsJ77MLzrTWDbgTHpCjFqqrUnsTsaI+Evg9/RGUHFZaysGdiGphBjLzSczmgXUrGxyITmm5cwPYB/bixK9M=
X-Received: by 2002:a2e:88ca:: with SMTP id a10mr8474649ljk.55.1617374557351;
 Fri, 02 Apr 2021 07:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616015337.git.matheus.bernardino@usp.br>
 <fca797698c78e2248bd2645bd0dce23ec4df35ae.1616015337.git.matheus.bernardino@usp.br>
 <CAP8UFD0CmPmvK7a-+5fKk0e0=te_e7cCFf6_-vSFrX9COTBg-w@mail.gmail.com>
In-Reply-To: <CAP8UFD0CmPmvK7a-+5fKk0e0=te_e7cCFf6_-vSFrX9COTBg-w@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 2 Apr 2021 11:42:26 -0300
Message-ID: <CAHd-oW7+x17uf2AuCrdYWUv9Ln2bq+V4rMPKo3VoYe3ZouQjLA@mail.gmail.com>
Subject: Re: [PATCH 2/5] parallel-checkout: make it truly parallel
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 1:32 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Mar 17, 2021 at 10:12 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>
> > diff --git a/.gitignore b/.gitignore
> > index 3dcdb6bb5a..26f8ddfc55 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -33,6 +33,7 @@
> >  /git-check-mailmap
> >  /git-check-ref-format
> >  /git-checkout
> > +/git-checkout--helper
>
> I wonder if "checkout--worker" would be better than "checkout--helper".

Yeah, good idea, I'll change that.

> >  /git-checkout-index
> >  /git-cherry
> >  /git-cherry-pick
>
> [...]
>
> > +#define ASSERT_PC_ITEM_RESULT_SIZE(got, exp) \
> > +{ \
> > +       if (got != exp) \
> > +               BUG("corrupted result from checkout worker (got %dB, exp %dB)", \
>
> Maybe precompilers are smart enough to not replace the "got" and "exp"
> in the above string, but it might be a bit confusing for readers.
> Anway I wonder if this macro could just be a regular (possibly inline)
> function.

Ok, I will replace this with an inline function.

> > +                   got, exp); \
> > +} while(0)
>
> > +static void parse_and_save_result(const char *line, int len,
> > +                                 struct pc_worker *worker)
> > +{
> > +       struct pc_item_result *res;
> > +       struct parallel_checkout_item *pc_item;
> > +       struct stat *st = NULL;
> > +
> > +       if (len < PC_ITEM_RESULT_BASE_SIZE)
> > +               BUG("too short result from checkout worker (got %dB, exp %dB)",
> > +                   len, (int)PC_ITEM_RESULT_BASE_SIZE);
> > +
> > +       res = (struct pc_item_result *)line;
> > +
> > +       /*
> > +        * Worker should send either the full result struct on success, or
> > +        * just the base (i.e. no stat data), otherwise.
> > +        */
> > +       if (res->status == PC_ITEM_WRITTEN) {
> > +               ASSERT_PC_ITEM_RESULT_SIZE(len, (int)sizeof(struct pc_item_result));
> > +               st = &res->st;
> > +       } else {
> > +               ASSERT_PC_ITEM_RESULT_SIZE(len, (int)PC_ITEM_RESULT_BASE_SIZE);
> > +       }
> > +
> > +       if (!worker->nr_items_to_complete || res->id != worker->next_item_to_complete)
>
> Nit: maybe it could be useful to distinguish between these 2 potential
> bugs and have a specific BUG() for each one.

Right, will do.

> > +static void gather_results_from_workers(struct pc_worker *workers,
> > +                                       int num_workers)
> > +{
> > +       int i, active_workers = num_workers;
> > +       struct pollfd *pfds;
> > +
> > +       CALLOC_ARRAY(pfds, num_workers);
> > +       for (i = 0; i < num_workers; i++) {
> > +               pfds[i].fd = workers[i].cp.out;
> > +               pfds[i].events = POLLIN;
> > +       }
> > +
> > +       while (active_workers) {
> > +               int nr = poll(pfds, num_workers, -1);
> > +
> > +               if (nr < 0) {
> > +                       if (errno == EINTR)
> > +                               continue;
> > +                       die_errno("failed to poll checkout workers");
> > +               }
> > +
> > +               for (i = 0; i < num_workers && nr > 0; i++) {
>
> Is it possible that nr is 0? If that happens, it looks like we would
> be in an infinite `while (active_workers) { ... }` loop.
>
> Actually in poll(2) there is: "A value of 0 indicates that the call
> timed out and no file descriptors were ready." So it seems that it
> could, at least theorically, happen.

I think a 0 return might not be possible in this case because we call
poll() with -1 as the timeout, which means "infinite timeout". So the
call should block until either an error occurs (negative return code)
or there is a file descriptor available for reading (positive return
code).

> > +enum pc_item_status {
> > +       PC_ITEM_PENDING = 0,
> > +       PC_ITEM_WRITTEN,
> > +       /*
> > +        * The entry could not be written because there was another file
> > +        * already present in its path or leading directories. Since
> > +        * checkout_entry_ca() removes such files from the working tree before
> > +        * enqueueing the entry for parallel checkout, it means that there was
> > +        * a path collision among the entries being written.
> > +        */
> > +       PC_ITEM_COLLIDED,
> > +       PC_ITEM_FAILED,
> > +};
> > +
> > +struct parallel_checkout_item {
> > +       /*
> > +        * In main process ce points to a istate->cache[] entry. Thus, it's not
> > +        * owned by us. In workers they own the memory, which *must be* released.
> > +        */
> > +       struct cache_entry *ce;
> > +       struct conv_attrs ca;
> > +       size_t id; /* position in parallel_checkout.items[] of main process */
> > +
> > +       /* Output fields, sent from workers. */
> > +       enum pc_item_status status;
> > +       struct stat st;
> > +};
>
> Maybe the previous patch could have declared both 'enum
> pc_item_status' and 'struct parallel_checkout_item' here, in
> parallel-checkout.h, so that this patch wouldn't need to move them
> here.

Yeah, while I was writing this patch I went back and forth on whether
to declare these here from the start. But because I wanted to have the
"parallel-checkout users" / "checkout--helper interface" division in
parallel-checkout.h, I thought it would be better to move the structs
to this header only after the checkout--helper was introduced.
