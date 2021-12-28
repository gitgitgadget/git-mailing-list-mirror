Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325D1C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 21:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhL1Vsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhL1Vsb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 16:48:31 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B4EC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:48:30 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z9so8902279edm.10
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfhoJySHcn0bPWBeWcZZd5bw04piRFXNDhagrerPjNM=;
        b=EkuBGfxpECnB0AnLxYXMsifsnm8R9FBgFUcC5h9+9m9IeVAmZah1DNKDmA9hac6ng8
         6Ca8oh2QaK3SuIVcmc8CR8FwBAxTnk3w56l/5Q45k8P2oyjKc4q6KhOYhpVZQiDHdkmT
         flIZEvSC6v9OLySyW0/eiOS1osjkwXybUNOmzRaYvfFJ269sSG4m2rUbM7p6ll95t5VG
         sAjgrEHZiSEse57VgnHEGbjc0puiyA1U6W6wrQ9C/BzPI5UcVP5mbEweedpd476w0Ulr
         4GAbeTpUFKWEAYXIfPQaFQD7YuZ7HWoGpcEgg1dGjBwJA/n4iXUZ/hHkxzGOhow+qfie
         HAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfhoJySHcn0bPWBeWcZZd5bw04piRFXNDhagrerPjNM=;
        b=d0RtfvoG6i4MwtoUBZ1I8OzFc+e6aScIzXBEY7AGvZ5uuTsjnsZe0r3UnH9x9HIuNT
         ZEsb2l8M6uxGsBGjFopseaiX6Hvcrx3qPzQdBCbPdBcGH/UfItq4PdsnYRZxnk74yPoz
         Ix9QuTakJg9apzOJOO8hapzJRigMnB/1ArDMYotyzEYoPZNSez87Ns3gMSV3lKHMplOS
         QJMExbH/Ws8ko6ybudVFtRQJIZarVMunsDOekqgflKWpuo88qPExASDgurkKzbZrg0vd
         0AM8tkH0gNDl9EXNZD7ksgF5spJc02oxvn9snm83WBYbvOBqkJFqZcHCqncWg3rqsWEy
         MJFQ==
X-Gm-Message-State: AOAM533/ZTSn8NeAR+eFoQ6ex0sTwBDSBOKejaGQxWVcUOevlYC0F7sv
        M35beTcGgO4RdK/yPaGHbyXDf7HdO9GFqnaWTcBat70Vm37P5g==
X-Google-Smtp-Source: ABdhPJwhcz3k4oPBOsZoGBYKPckIvWFABz1hvrKKtdUQcjwf+dtrR1txs1DIxeaTROHZCLJm6Tt3cDOYn2U715r75lQ=
X-Received: by 2002:a50:da48:: with SMTP id a8mr21968348edk.146.1640728108871;
 Tue, 28 Dec 2021 13:48:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com> <887e46435c0561e86f1858682fe53e9de926b69c.1640419160.git.gitgitgadget@gmail.com>
 <20211228105642.ajmr2kqjm5yikneu@gmail.com>
In-Reply-To: <20211228105642.ajmr2kqjm5yikneu@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 13:48:17 -0800
Message-ID: <CABPp-BGbY-Kvsa_W7J0rcUBWuNOyVdkKbE-tHUOcNRnqwPnMWw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] merge-ort: format messages slightly different for
 use in headers
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 2:56 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> On Sat, Dec 25, 2021 at 07:59:17AM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When users run
> >     git show --remerge-diff $MERGE_COMMIT
> > or
> >     git log -p --remerge-diff ...
> > stdout is not an appropriate location to dump conflict messages, but we
> > do want to provide them to users.  We will include them in the diff
> > headers instead...but for that to work, we need for any multiline
> > messages to replace newlines with both a newline and a space.  Add a new
> > flag to signal when we want these messages modified in such a fashion,
> > and use it in path_msg() to modify these messages this way.
>
> makes sense (same for patches 4 & 5)
>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c       | 36 ++++++++++++++++++++++++++++++++++--
> >  merge-recursive.c |  3 +++
> >  merge-recursive.h |  1 +
> >  3 files changed, 38 insertions(+), 2 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 998e92ec593..9142d56e0ad 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -634,17 +634,46 @@ static void path_msg(struct merge_options *opt,
> >                    const char *fmt, ...)
> >  {
> >       va_list ap;
> > -     struct strbuf *sb = strmap_get(&opt->priv->output, path);
> > +     struct strbuf *sb, *dest;
> > +     struct strbuf tmp = STRBUF_INIT;
> > +
> > +     if (opt->record_conflict_msgs_as_headers && omittable_hint)
> > +             return; /* Do not record mere hints in tree */
> > +     sb = strmap_get(&opt->priv->output, path);
> >       if (!sb) {
> >               sb = xmalloc(sizeof(*sb));
> >               strbuf_init(sb, 0);
> >               strmap_put(&opt->priv->output, path, sb);
> >       }
> >
> > +     dest = (opt->record_conflict_msgs_as_headers ? &tmp : sb);
> > +
> >       va_start(ap, fmt);
> > -     strbuf_vaddf(sb, fmt, ap);
> > +     strbuf_vaddf(dest, fmt, ap);
> >       va_end(ap);
> >
> > +     if (opt->record_conflict_msgs_as_headers) {
> > +             int i_sb = 0, i_tmp = 0;
> > +
> > +             /* Copy tmp to sb, adding spaces after newlines */
> > +             strbuf_grow(sb, 2*tmp.len); /* more than sufficient */
> > +             for (; i_tmp < tmp.len; i_tmp++, i_sb++) {
> > +                     /* Copy next character from tmp to sb */
> > +                     sb->buf[sb->len + i_sb] = tmp.buf[i_tmp];
> > +
> > +                     /* If we copied a newline, add a space */
> > +                     if (tmp.buf[i_tmp] == '\n')
> > +                             sb->buf[++i_sb] = ' ';
> > +             }
> > +             /* Update length and ensure it's NUL-terminated */
>
> I think this and the two comments inside the loop are mostly redundant. I'd
> drop them (except maybe this one because it's a common oversight I guess).

I don't think redundancy is (necessarily) a reason to drop comments.
Take for example the following from early in abspath.c:

    /* Find start of the last component */
    while (offset < len && !is_dir_sep(path->buf[len - 1]))
        len--;
    /* Skip sequences of multiple path-separators */
    while (offset < len && is_dir_sep(path->buf[len - 1]))
        len--;

The comment quickly explains what might take a bit more time to reason
out.  Since I'm dealing with multiple different indices and various
arithmetic, I figured a quick explanation was helpful.  And, of
course, the reminder to make it NUL-terminated.  Granted, if the code
is very readily obvious then comments are not helpful, and there's a
gray area somewhere in between.  I think the code we're discussing
here is in that gray area, where it's a matter of taste what the
threshold is.  I don't find your taste here unreasonable, but I don't
find mine for the above examples to be unreasonable either.  I'd
rather leave these in.

>
> > +             sb->len += i_sb;
> > +             sb->buf[sb->len] = '\0';
> > +
> > +             /* Clean up tmp */
>
> Also this one I guess

Yeah, I'll nuke this one.  The reason for this comment was more that
sometimes I like having a comment apply to the code below it until the
next comment; do thing that way avoids the need to put a
here-ends-the-previous-comment comment, or arbitrarily avoid blank
lines after a comment.  But that reasoning is a bit weaker here, and
it clearly doesn't need any explanation, so I'll just drop it.

> > +             strbuf_release(&tmp);
> > +     }
> > +
> > +     /* Add final newline character to sb */
> >       strbuf_addch(sb, '\n');
> >  }
> >
> > @@ -4246,6 +4275,9 @@ void merge_switch_to_result(struct merge_options *opt,
> >               struct string_list olist = STRING_LIST_INIT_NODUP;
> >               int i;
> >
> > +             if (opt->record_conflict_msgs_as_headers)
> > +                     BUG("Either display conflict messages or record them as headers, not both");
> > +
> >               trace2_region_enter("merge", "display messages", opt->repo);
> >
> >               /* Hack to pre-allocate olist to the desired size */
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index bc73c52dd84..c9ba7e904a6 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -3714,6 +3714,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
> >
> >       assert(opt->priv == NULL);
> >
> > +     /* Not supported; option specific to merge-ort */
> > +     assert(!opt->record_conflict_msgs_as_headers);
> > +
> >       /* Sanity check on repo state; index must match head */
> >       if (repo_index_has_changes(opt->repo, head, &sb)) {
> >               err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> > diff --git a/merge-recursive.h b/merge-recursive.h
> > index 0795a1d3ec1..ebfdb7f994e 100644
> > --- a/merge-recursive.h
> > +++ b/merge-recursive.h
> > @@ -46,6 +46,7 @@ struct merge_options {
> >       /* miscellaneous control options */
> >       const char *subtree_shift;
> >       unsigned renormalize : 1;
> > +     unsigned record_conflict_msgs_as_headers : 1;
> >
> >       /* internal fields used by the implementation */
> >       struct merge_options_internal *priv;
> > --
> > gitgitgadget
> >
