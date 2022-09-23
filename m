Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8605C54EE9
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 01:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiIWBr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 21:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIWBrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 21:47:25 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5297E8D9C
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 18:47:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w8so17502302lft.12
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 18:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WFRG0JPzsX6kTJJy7QUtnhAw9RS9WMWV0+lM/UPmPsU=;
        b=S+f3Hh4dr+mgtB6PAhanAuFSJTSNb1yzwMHnbBc9RhnHv2ZOHY9i0bo2M7SF+zqxpw
         P9mc0UsJIDrWG+R74H24SYUqA1JBYg9SZFy1AhPE78wT6s8mefp8jddFyBxIJseU5AJE
         GI5AV8SJAQU5gJKa9JiAWgXv1bB/D+dcp7y2wQw2aJA4jO8ejvBbBxQZMWM3J3ZvmWpW
         AtWgFh9awvMEY1FH//vx2nQ+88uP2scsiBJGMj0J17f3eBKjyZu9dVWxY5UwLgQAMl8M
         L/D6zWVMmtpFIltwbvbtq4Ecxnd+aFzH7Te7SIF3484PE9Lk6Iw6hrwqghXXPNURVJxo
         +Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WFRG0JPzsX6kTJJy7QUtnhAw9RS9WMWV0+lM/UPmPsU=;
        b=S+oChSOlzc7W7vgMGvVxaRpN61JiZAPHTEYue2voe105j6Ujs3fuxcAGaaouT9ddlv
         nHSrcQeQ+oYujr/45c+S0H4W40eWcs1kckImNV2xraqVD3onR1icK6jHIMFxIsJ2qC7z
         2jZmQmR8KpzMpIN1zHReSAqXeciK5CQMJUqX9QTbS/xemJ4zQpalw8v1OULsK7rZHiRZ
         rDGWCUxiufZVANeWlrftWjwF5q2uZAWYs5xJGB5aDFPBejR7A29zl1ap8SQUmm4L9D0F
         hU2oVIR3Gs+okI3j3kncqKcCSDsdrAkTcgjZNuiBv7SvBwjHcD0Pj1Lh7wrZ1N0k4evS
         TTVA==
X-Gm-Message-State: ACrzQf3/6eQcinekLwuMsqbb3c8bPZm3+0MsPf+pl9/TuMOTFAkMFviu
        J6lOnmb93S4KO3ekrDa7irUkUtrU8TmJBZQWMlE=
X-Google-Smtp-Source: AMsMyM5/pUM2DrRvPiB3PK4FJ2mnRfae7ZPfv6vIeyZGSgoL/weSKrZIdcmb1Pelu5KBni8z95gLX9hzLRAi3A0auks=
X-Received: by 2002:ac2:5107:0:b0:497:adac:7305 with SMTP id
 q7-20020ac25107000000b00497adac7305mr2385180lfb.32.1663897642203; Thu, 22 Sep
 2022 18:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com>
 <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com> <CABPp-BGUiDXxv8eQhKQXHcem3ke9e=Q99a_FDExZ5XZYUgir6A@mail.gmail.com>
 <n920r07n-8443-2r5o-09pr-q20r99q6o12o@tzk.qr>
In-Reply-To: <n920r07n-8443-2r5o-09pr-q20r99q6o12o@tzk.qr>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 22 Sep 2022 18:47:10 -0700
Message-ID: <CABPp-BEW9RdH8RSFk2BtPwYSyP0mKTz-7oCQQP7jsR6ChmF3aQ@mail.gmail.com>
Subject: Re: [PATCH v2] merge-tree: fix segmentation fault in read-only repositories
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 12:50 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> now that I have studied more of the code, hunted down Coverity reports
> about `merge-ort.c` and `builtin/merge-tree.c` and essentially have grown
> a lot more confidence about my patch, I'll take the time to respond in a
> bit more detail.
>
> On Wed, 21 Sep 2022, Elijah Newren wrote:
>
> > On Wed, Sep 21, 2022 at 3:08 PM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
[...]
> > > @@ -446,7 +447,8 @@ static int real_merge(struct merge_tree_options *o,
> > >         if (o->show_messages == -1)
> > >                 o->show_messages = !result.clean;
> > >
> > > -       printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
> > > +       tree_oid = result.tree ? &result.tree->object.oid : null_oid();
> > > +       printf("%s%c", oid_to_hex(tree_oid), line_termination);
> >
> > Perhaps also print a warning to stderr when result.tree is NULL?
>
> I ended up not even touching `builtin/merge-tree.c` but instead ensuring
> that `result.clean` is negative if we fail to write an object (which could
> happen even in read/write repositories, think "disk full").
>
> As a consequence, we do not even reach this `printf()` anymore, as you
> pointed out, a negative `result.clean` is handled much earlier.

Works for me.  :-)

> It is handled via a `die()` in `real_merge()`, and that will need to
> change, I think, if we want to continue on the batched merges.

Indeed, good point.

> > >         if (!result.clean) {
> > >                 struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
> > >                 const char *last = NULL;
> > > @@ -473,7 +475,7 @@ static int real_merge(struct merge_tree_options *o,
> > >                                               &result);
> > >         }
> > >         merge_finalize(&opt, &result);
> > > -       return !result.clean; /* result.clean < 0 handled above */
> > > +       return !result.tree || !result.clean; /* result.clean < 0 handled above */
> >
> > Thinking out loud, should this logic be at the merge-ort.c level,
> > perhaps something like this:
> >
> > @@ -4940,6 +4941,9 @@ static void
> > merge_ort_nonrecursive_internal(struct merge_options *opt,
> >         result->tree = parse_tree_indirect(&working_tree_oid);
> >         /* existence of conflicted entries implies unclean */
> >         result->clean &= strmap_empty(&opt->priv->conflicted);
> > +       if (!result->tree)
> > +               /* This shouldn't happen, because if we did fail to
> > write a tree we should have returned early before getting here.  But
> > just in case we have some bugs... */
> > +               result->clean = -1;
> >         if (!opt->priv->call_depth) {
> >                 result->priv = opt->priv;
> >                 result->_properly_initialized = RESULT_INITIALIZED;
> >
> > That might benefit callers other than merge-tree, though maybe it
> > makes it harder to print a helpful error message (unless we're fine
> > with the library always throwing one?)
>
> The error messages are already thrown about (this is how it looks like
> with v3 of this patch):
>
>         [...]
>         + git -C read-only merge-tree side1 side2
>         error: insufficient permission for adding an object to repository database ./objects
>         error: error: Unable to add numbers to database
>         error: insufficient permission for adding an object to repository database ./objects
>         error: error: Unable to add greeting to database

Ah, this confirms my suspicions.  These lines look like two failures,
both for adding blob objects.  This shows that the return value from
the write_object_file() call within handle_content_merge() is not
being correctly propagated upwards, and the merge is (erroneously)
continuing on despite that.

>         error: insufficient permission for adding an object to repository database ./objects

And I'm guessing the lack of the "Unable to add %s to database"
following message means this was the attempt to write a new tree.

>         fatal: failure to merge

And this shows that with your patch, you are propagating and catching
the failure to write the tree object and aborting, so we at least
catch failures to write trees now.

[...]
> > And then, possibly post-v2.38.0 though we may be able to get it in
> > before, getting correct propagation of a -1 return value from the
> > source of the error would be good.  Would you like to look into that,
> > or would you prefer I did?
>
> It turned out not to be too bad.
>
> Essentially, to propagate `write_object_file()` failures I only had to
> change a couple of signatures (with the corresponding `return`s):
> `write_tree()`, `write_completed_directory()`, and `process_entries()`.
> And then, of course, I needed to change
> `merge_ort_nonrecursive_internal()` to respect the propagated error by
> setting `result->clean = -1`.
>
> Pretty straight-forward, really, much less involved than I had expected.

Nice!
