Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C481F405
	for <e@80x24.org>; Tue, 18 Dec 2018 03:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLRDf5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 22:35:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45455 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeLRDf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 22:35:56 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so829891oie.12
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 19:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yk94AlqiUZH42FZRKnwd4l7R29fvggHoTVNuja7RriI=;
        b=haymrIHvQ0PcfXdgNsWzjhaXe9u73PnsxEOTHyfjGcabEzk5xLod+7pRNbNzbzgraO
         2wEPTITZLa92iCXaBhhTNo3MiOGsFkIDZX8WbS4umhZDfbtVyUo3+3QbdHRU2QTf+GVo
         cDW/zkZPu6LCUzOcz8I1CfVjnc14jsLbmu3F5FtkK5/DGfs4jcv0VVLLTL7OL9tdRCro
         QtFStBrm6DHD5T6CQbLgUNR5cSyc/ovWUSTpk2zM862D2o8QtUNx+kMYKCgcWkX0KNyt
         qZxqxal0pj+Vt9G1N2MdoRZeMmXZnNkfcaQiOikNYq0zueEy6uMrDKSYmjg2RIVJ71Ph
         TBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yk94AlqiUZH42FZRKnwd4l7R29fvggHoTVNuja7RriI=;
        b=L7F+nW8N8+sPZ8YjxyBHRzLZRMB/yoE9cXLtuKhdQAikMmYT0waldVhV4EKQtOYsVc
         HVEJ1k35snv1CIo1h5BaquweC8ZOAgnuBmgnESUIz0+OgC2K6ex/ZXDGFOLzRTOV/jLp
         bKexIzjs0LPqR+PzR9G7VoWLpP/ZWp6oGdqctUTE/X6KtHUZjnwitZemWh9JUAGb+Rr7
         4NxiShSEnKgJZJIl1FwRuEWycUWRCUAxLvXJb7WUt8I89Yu/xBmXgm+ac+J4sXEQxJJQ
         JB8k6T/LRnbuH4f19UDAUyIN3q7QOJwgFrOExjgX66mRVfTLmIKyntPa3b6It7CPdVq7
         zl1Q==
X-Gm-Message-State: AA+aEWbaBcuHZVvwSDf22+l4xm24dSn56OsFrR7LSNf0Mxey6q6D25Mh
        3brdl/JGmNztphRiG/0a4t8G+oES+IvMv9LLAmOvdA==
X-Google-Smtp-Source: AFSGD/VPANJSjpmUdWtVM0hze5n2cv2qPsKNqq4IHUg15rFyhrKaRmBmxywOtK0lfNUyqbmFqrPDbmg/crh7JfUaq7U=
X-Received: by 2002:aca:49cb:: with SMTP id w194mr6578583oia.114.1545104155726;
 Mon, 17 Dec 2018 19:35:55 -0800 (PST)
MIME-Version: 1.0
References: <CANdyxMwxPqTMfLsoK-2JT3Wf3hXZnQNCPRS04aSHzsMbYJZo-Q@mail.gmail.com>
 <xmqqk1k8bitm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1k8bitm.fsf@gitster-ct.c.googlers.com>
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Mon, 17 Dec 2018 19:35:43 -0800
Message-ID: <CANdyxMxCe9xjkRYGyovRo4UU5A5PGRwpFbE4ej74hXJUF3_9zQ@mail.gmail.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Noemi Mercado <noemi@sourcegraph.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, thanks for your feedback. I'll submit a new patch as soon as
I've addressed all the feedback.

On Mon, Dec 17, 2018 at 1:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Issac Trotts <issac.trotts@gmail.com> writes:
>
> > Make it possible to write for example
> >
> >         git log --format="%H,%S"
> >
> > where the %S at the end is a new placeholder that prints out the ref
> > (tag/branch) for each commit.
> >
> > Using %d might seem like an alternative but it only shows the ref for
> > the last commit in the branch.
>
> Have your sign-off here (see Documentation/SubmittingPatches),

Done.

> and then have a line that only has three-dashes on it,
>
> and then any other additional info like this.

Done.

> > This change is based on a question from Stack Overflow:
> > https://stackoverflow.com/questions/12712775/git-get-source-information-in-format
> > ---
>
>
>
>
> >  Documentation/pretty-formats.txt |  2 ++
> >  builtin/log.c                    |  2 +-
> >  log-tree.c                       |  1 +
> >  pretty.c                         | 10 +++++++
> >  t/t4205-log-pretty-formats.sh    | 50 ++++++++++++++++++++++++++++++++
> >  5 files changed, 64 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> > index 417b638cd..acfe7e0a4 100644
> > --- a/Documentation/pretty-formats.txt
> > +++ b/Documentation/pretty-formats.txt
> > @@ -104,6 +104,8 @@ The placeholders are:
> >
> >  - '%H': commit hash
> >  - '%h': abbreviated commit hash
> > +- '%S': ref name given on the command line by which the commit was reached
> > +  (like `git log --source`)
>
> This looks entirely out of place, among the description of the basic
> basic data like the object name of the commit itself, its tree, etc.
>
> Describe this immediately after %d and %D are explained, perhaps.

Done.

>
> > diff --git a/builtin/log.c b/builtin/log.c
> > index e8e51068b..a314ea2b6 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -203,7 +203,7 @@ static void cmd_log_init_finish(int argc, const
> > char **argv, const char *prefix,
> >          rev->diffopt.filter || rev->diffopt.flags.follow_renames)
> >          rev->always_show_header = 0;
> >
> > -    if (source) {
> > +    if (source || (rev->pretty_given && rev->commit_format ==
> > CMIT_FMT_USERFORMAT)) {
>
> Broken line (you let your MUA line-wrap and corrupt your patch???)

I see. I need to use `git send-email`.

>
> >          init_revision_sources(&revision_sources);
> >          rev->sources = &revision_sources;
> >      }
>
> This means anybody who asks for say --format='%aN %s' pays the price
> of keeping track of each commit's source, which is unreasonable.
>
> Perhaps mimick the way how presence of %N is detected in
> userformat_want_item() so that we do not pay the price for
> init_display_notes() when a format that does not care about %N is
> given?

Done.

>
> > @@ -1149,6 +1150,15 @@ static size_t format_commit_one(struct strbuf
> > *sb, /* in UTF-8 */
> >          parse_object(the_repository, &commit->object.oid);
> >
> >      switch (placeholder[0]) {
> > +    case 'S':        /* tag/branch like --source */
> > +        slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
> > +        if (slot && *slot) {
> > +            strbuf_addstr(sb, *slot);
> > +            return 1;
> > +        } else {
> > +            die(_("failed to get info for %%S"));
> > +            return 0;
> > +        }
>
> Have this next to case arms that deal with 'd' and 'D".

Done.

>
> >      case 'H':        /* commit hash */
> >          strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
> >          strbuf_addstr(sb, oid_to_hex(&commit->object.oid));
>
> This is a tangent, but I think this existing case arm should move to
> the previous block before parsing the commit, as %H only needs the
> object name of the commit itself (reword the comment before that
> switch to read from "independent of the commit" to "computable
> without parsing the commit")..

I hope it's all right if I keep my patch focused on just one thing.
