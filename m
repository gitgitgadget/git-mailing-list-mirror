Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64AF1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 06:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfG2Gyu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 02:54:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35058 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfG2Gyu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 02:54:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so43451027qke.2
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQ+mrRJ1zBPM1zTxSwb7yi11QE0r6NrMuv1mc4bsmQg=;
        b=jSQn09Lx6No3T3RQsR50nHvhdHOdK+fyMlPMU9nUT3G1u7Fa+kc/+Wk1FExxYcG1x6
         1IwV7bamfu/+38Z1f+7os8SPG4aQ74/HC9y3KKG34HuVPB0NqgSNtkDI6OhcaOg8CPN+
         AUGRXChvlCevAXnJ6kp78vJk7Y4jSzPL22gk1xw3nXpzjo+XdqYv7sA+3LXqyd6TvqdX
         YbeyjTSJ5JebpIz04+rHy0YIfVSJSvSoCSbLlVPR/ig4rpC06+Dr6u1QSgadkGBlZC2S
         2O7OiWf1cY7GYhTy7zqZjgQ9f5N/e549ug9qeZTL1l0Xuz46aujQ0mzHJzv2CeOeUKng
         OKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQ+mrRJ1zBPM1zTxSwb7yi11QE0r6NrMuv1mc4bsmQg=;
        b=ApA3tGv0v8EroWkFyw2AVY7V7lM4JCUiKO4wT9lPhQuSzUX11YJ2yyRaBXIZ8sWQID
         WJgmtJccPDWzWNXSkhOM9oHg2BfSHbvmXmSLqbBgnd9dDIFLJEIyLui8oE4lTxoT6Fpq
         1/YAcxn4KOWiTIxip0rKPB0EhI2UiDShw3O/fsZNiarzi6pnjxYdErYuaiM5J3lZAiOh
         Su9+at63YeaK+8xfIoqXKOAsc6Qr57ZtRaDmb23gd7MewcCZbRd9xGKJuPRuNINoZrYg
         Yx7TZF/BkeqOQNKwQlQozTN3faKIJJWmB39U8QuyTnVSdHyCHD2mMNHPi4MpvFUIzCkE
         t/vw==
X-Gm-Message-State: APjAAAVYc/E3VXSMwZy1d3jus/qaljH8mbycJt0OJjPKZ8M2kvc9exBQ
        RPW/al/rE0ktQddJS1S/HvNlcGDAh2d5Ad91/qzfL6EtWIs=
X-Google-Smtp-Source: APXvYqzXmOUIHkwqQAh5hfwQcwNKsdJFLi0jBQOrBkqhCraxsit2M5zpIy4fQ7BZLeARY3uTsdc7eLMfZH7zk8DYZyc=
X-Received: by 2002:a37:8b86:: with SMTP id n128mr70418118qkd.446.1564383289437;
 Sun, 28 Jul 2019 23:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190726045645.2437-1-vcnaik94@gmail.com> <20190726085756.GA20017@sigill.intra.peff.net>
In-Reply-To: <20190726085756.GA20017@sigill.intra.peff.net>
From:   Varun Naik <vcnaik94@gmail.com>
Date:   Sun, 28 Jul 2019 23:54:38 -0700
Message-ID: <CAK_rgsH6hL3g+PVfcMuq1dQLeNJcii=D_dQ8anmWLvYrShmkNg@mail.gmail.com>
Subject: Re: [PATCH] checkout.c: unstage empty deleted ita files
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 1:57 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jul 25, 2019 at 09:56:45PM -0700, Varun Naik wrote:
>
> > It is possible to delete a committed file from the index and then add it
> > as intent-to-add. After `git checkout HEAD` or `git restore --staged`,
> > the file should be identical in the index and HEAD. This patch provides
> > the desired behavior even when the file is empty in the index.
>
> OK, so the issue is that ITA entries have an empty-file sha1, so they
> confuse the logic to decide if we can use the old entry. Your fix makes
> sense.
>
> > ---
> > CC Jeff because you wrote the code that I am changing now.
> >
> > checkout.c:update_some() discards the newly created cache entry when its
> > mode and oid match those of the old entry. Since an ita file has the
> > same oid as an empty file, an empty deleted ita file passes both of
> > these checks, and the new entry is discarded. In this case, the file
> > should be added to the cache instead.
> >
> > This change should not affect newly added ita files. For those, inside
> > tree.c:read_tree_1(), tree_entry_interesting() returns
> > entry_not_interesting, so fn (which points to update_some()) is never
> > called.
>
> These two paragraphs would be a nice addition to the actual commit
> message.
>

I will add them to the commit message, with some minor changes.

> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index 91f8509f85..27daa09c3c 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -126,6 +126,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
> >       if (pos >= 0) {
> >               struct cache_entry *old = active_cache[pos];
> >               if (ce->ce_mode == old->ce_mode &&
> > +                 !ce_intent_to_add(old) &&
> >                   oideq(&ce->oid, &old->oid)) {
> >                       old->ce_flags |= CE_UPDATE;
> >                       discard_cache_entry(ce);
>
> My first thought here was that we could skip ITA entries here only when
> the HEAD hash is also the empty blob, which would let us retain index
> results in more cases. But it doesn't help. If the HEAD entry isn't the
> empty blob, then we'll have !oideq() and we'll skip anyway, because an
> ITA entry must be the empty blob (if we `git add` some other content,
> then it ceases to be ITA).
>
> So it makes sense to just always skip this "retain the old index entry"
> block for any ITA entry.
>
> > +test_expect_success 'checkout HEAD adds deleted intent-to-add file back to index' '
> > +     echo "nonempty" >nonempty &&
> > +     >empty &&
> > +     git add nonempty empty &&
> > +     git commit -m "create files to be deleted" &&
> > +     git rm --cached nonempty empty &&
> > +     git add -N nonempty empty &&
> > +     git checkout HEAD nonempty empty &&
> > +     git diff --staged --exit-code
> > +'
>
> This clearly demonstrates the problem. Nice.
>
> > +test_expect_success 'restore --staged adds deleted intent-to-add file back to index' '
> > +     echo "nonempty" >nonempty &&
> > +     >empty &&
> > +     git add nonempty empty &&
> > +     git commit -m "create files to be deleted" &&
> > +     git rm --cached nonempty empty &&
> > +     git add -N nonempty empty &&
> > +     git restore --staged nonempty empty &&
> > +     git diff --staged --exit-code
> > +'
>
> Hmm. This git-restore test means we don't apply to maint. But wouldn't
> we want the fix for "checkout" there?
>
> I.e., I'd expect a patch to fix and test git-checkout, and then an
> additional patch to be added on the merge of that plus master to test
> git-restore.
>

To make sure I understand, do you mean that I should omit the test
case for "restore" right now, wait for the patch to reach master, and
then create another patch for the "restore" test case?

> Other than that, the patch looks good to me.
>
> -Peff

Varun
