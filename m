Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081C2211B5
	for <e@80x24.org>; Fri, 11 Jan 2019 06:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfAKG2y (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 01:28:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40292 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbfAKG2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 01:28:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so11364308oie.7
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 22:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDRi3gDsGUd+07RqhRLVcjy1DkVpSRv+5ZEMGs7Qxm0=;
        b=fhnZxXqAkOH6jpznr4xwbxT8Q/eskB65EN2rNgcNQktBxHuTrCmA3vAyQoQIEBoXP8
         OQ4DUW/k4FXY9655wpU5kU1HKIAqKhXp+2y/F68l79GkOPoSOggWgusfWlVseuMJa2jj
         tE0dL1VUWnnXM+cPdHDyO7EyOSPGuz8EPxh2S+KOniGk5wm2EkN2QViDaZKyoL7eNTI+
         Q+5gIHi8IXJJ+gpArkul0DrM5iG0Ze5tfTYqPzTSMB+o7wrifswYevm/SISsbVFZ7RUH
         l+ZWIrcYgHZjrxQq+ETciZIsqJIqac2VyV8SvVky8xzB9/cYBNeR+5wOZs1rBkdCHjWA
         0WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDRi3gDsGUd+07RqhRLVcjy1DkVpSRv+5ZEMGs7Qxm0=;
        b=rz8KSNpNVGnD87ufU3Qla+Bb3h50eFGCJ2np/LRs4wx1igDLor0m4d++aRykrXH7aj
         8kx12unMTqkAjCPMBTJzL9WmyR5qNEya+0leZo+Qb9BIwgGbMiBtE303oBPlvdLIWWYY
         Z0LjgLfmN0mwa01nlVzKoLqsVhDdiuKJJva0/kXqBXmAPnD7tFoiFHFGNlvV58cIin70
         YnEDHr1uTenvqewdDzZM9IxU/4Ye3u3cm7qptsQ6pcKs7/aqwCJOVh5xxiqHy4nLJICl
         qlrKil3/4GyQOPjwSFljZ6kzDDImcHZrz332YxyK7L0gHdocmob+V6rdMwvTYZLkKSzu
         uQ8g==
X-Gm-Message-State: AJcUukfAsjuZnKpdxFTWjpMWuvIywHDwWDmR8xMKKKAHgNzi/pj8Kw5E
        iAU6WSIbS8v9GA8lbm1IMPmGv0bP5AiBRp3vT5b72qxt6VQ=
X-Google-Smtp-Source: ALg8bN4uBdX3RiQ6c6ZpVjX9vh6HxfCHWep+7EyMcZFoWf53p+knNkm8lStX9EuRLHWEnF+FmA5OJO79Qb1PFX4C3Jg=
X-Received: by 2002:aca:3209:: with SMTP id y9mr7994303oiy.198.1547188133045;
 Thu, 10 Jan 2019 22:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20190108132048.57142-1-issactrotts@google.com> <xmqqmuoa4wp7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuoa4wp7.fsf@gitster-ct.c.googlers.com>
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Thu, 10 Jan 2019 22:28:41 -0800
Message-ID: <CANdyxMzDevigyMTCixjV7bfa-UZ1vknwxt0X=RGc6LZz7F4UXQ@mail.gmail.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Noemi Mercado <noemi@sourcegraph.com>,
        Issac Trotts <issactrotts@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 8, 2019 at 2:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> issac.trotts@gmail.com writes:
>
> > From: Issac Trotts <issac.trotts@gmail.com>
>
> Heh, I'll edit this line to match S-o-b: below.

Thanks. Otherwise I have to set up git send-email again on my work laptop.

> > Make it possible to write for example
> >
> >         git log --format="%H,%S"
> >
> > where the %S at the end is a new placeholder that prints out the ref
> > (tag/branch) for each commit.
> >
> > Using %d might seem like an alternative but it only shows the ref for the last
> > commit in the branch.
> >
> > Signed-off-by: Issac Trotts <issactrotts@google.com>
> >
> > ---
>
>
>
> > diff --git a/log-tree.c b/log-tree.c
> > index 10680c139..3cb14256e 100644
> > --- a/log-tree.c
> > +++ b/log-tree.c
> > @@ -700,6 +700,7 @@ void show_log(struct rev_info *opt)
> >       ctx.color = opt->diffopt.use_color;
> >       ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
> >       ctx.output_encoding = get_log_output_encoding();
> > +     ctx.rev = opt;
>
> There are quite a few existing codepaths that change their behaviour
> based on NULL-ness of ctx.rev field.  How would we make sure that
> this change have no unintended consequence, I wonder?
>
> > +     case 'S':               /* tag/branch like --source */
> > +             if (c->pretty_ctx->rev == NULL || c->pretty_ctx->rev->sources == NULL) {
> > +                     return 0;
> > +             }
> > +             slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
> > +             if (!(slot && *slot)) {
> > +                     return 0;
> > +             }
> > +             strbuf_addstr(sb, *slot);
> > +             return 1;
>
> Let's update the style of this hunk here like so:
>
>         if (!c->pretty_ctx->rev || !c->pretty_ctx->rev->sources)
>                 return 0;
>         slot = ...;
>         if (!(slot && *slot))
>                 return 0;
>         strbuf_addstr(...);
>         return 1;

Done.

>
> I wonder if it is even better to apply de-Morgan to one of the above
> two, i.e.
>
>         if (!(c->pretty_ctx->rev && c->pretty_ctx->rev->sources))
>                 return 0;
>

Done.

>
> Anyway, thanks.  Will queue.
>

Sounds good. Btw, did you queue it yet? I didn't see it at the mirror:
https://github.com/git/git/commits/master.

I'll send out another patch with your suggestions, in case you haven't
already queued it.

Issac
