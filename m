Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67581F454
	for <e@80x24.org>; Thu, 27 Sep 2018 18:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeI1A7a (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:59:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46182 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1A7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:59:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id h22-v6so3834426qtr.13
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EFDjwz6UzxcvIRD35eVXVaDbgKiqDhPPqTTG2QtJjU=;
        b=KsH73L6tiqPbj8Qq02y0FBGNUC8CMC007z9pgvdk7m1t5AiTMYZYOHKtyxDPbKGoSP
         hEvjLzDFZjlj+NNr+CE3Gj6XoXfCBlUac0MiINVtMzhUKZNsnIVxq0hh/BLUj1OnCCbs
         gbseABrgBSnBI4Cdg2Tt2GYc+a8ExkPWTYMp2QiprVb+HhG1iswpJHys65ERSBbc6kUb
         a5KwYfeMdz51VY55iPvxtRR6TncQTOBkZup64Dqxg72tsjRG6iW8fIbtEnpbw987NLnQ
         x9kL3NQq9f79RLGKt3cm6qP4bGX0bvusEi0EsfMdtWc9oy+0NumEpSfltrqXBoL0YYhR
         jRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EFDjwz6UzxcvIRD35eVXVaDbgKiqDhPPqTTG2QtJjU=;
        b=ih+QBC6BdabocWHS7LiBvWLYZ27Fl0EU1cle+yKOndmiXaX5xMyeeL/WM9m3RimkJZ
         1O1pWsPZnK9WtsfX9JO33scN1vIo+ec07DQiMLAfxVZKmNliCgKnvtGl8bWDXtszTiEI
         1AeNL9oN2nUvEPYqQMrDSividxo1VesWfP4y9mgAmMs22O9ajG5RX6hRNvXZ0GdqtG00
         VNR4ghX9r15Tk7njEe5Lq91WBBieBuV/eSSkC3dGapS5ykn28iJFti8V4J30vtx/aJJ2
         QunqeLxoNK0IwbyKgEOr0xH+03hxZcTsFpqGyNce9SfAf40sj8A3LdGpQxTV8mm0O976
         Vp4A==
X-Gm-Message-State: ABuFfog7nAk1u5rdKOi3fGcdkOixZtd9o50A3KiHi3VBpyfWw4i1/Vho
        RiwBtTcU06dxz0FNEg37E9XdIIFqUAkJPpUWPqA=
X-Google-Smtp-Source: ACcGV63h3cE4tC+nSgny4E1IbXf8T25bQ5YOmoCPjU7/Zg4LkMLsR4wHWr6kHCuPvN+h9mSud6BNIi8Nh0Tn7vbDfYE=
X-Received: by 2002:a0c:81c7:: with SMTP id 7-v6mr883899qve.135.1538073592331;
 Thu, 27 Sep 2018 11:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20180927181708.GA2468@sigill.intra.peff.net>
In-Reply-To: <20180927181708.GA2468@sigill.intra.peff.net>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Thu, 27 Sep 2018 11:39:26 -0700
Message-ID: <CAC053843M-dXgRXziibLET+r+0adNaefnMBjED8bTwXrvvgrzg@mail.gmail.com>
Subject: Re: [PATCH] branch: colorize branches checked out in a linked working
 tree the same way as the current branch is colorized
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback Peff. I actually agree with all your points.
I'd considered an approach like what you proposed, but rejected it for
the first iteration in an effort to keep scope limited and see what
kind of feedback I'd get overall (like would people even want this?).
This is a much better approach, and also gives a path for listing the
worktree path in the verbose output.

@Duy yea we can use a different color, maybe a darker shade of green.
I saw plenty to choose from in the color list so I'll play around with
it. It would definitely make it easier to distinguish at a glance
which branch is checked out in the current worktree vs others.
On Thu, Sep 27, 2018 at 11:17 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Sep 27, 2018 at 08:13:13AM -0700, Nickolai Belakovski wrote:
>
> > In order to more clearly display which branches are active, the output
> > of git branch is modified to colorize branches checked out in any linked
> > worktrees with the same color as the current branch.
>
> I think the goal makes sense.
>
> Do we want to limit this to git-branch, though? Ideally any output you
> get from git-branch could be replicated with for-each-ref (or with
> a custom "branch --format").
>
> I.e., could we have a format in ref-filter that matches HEAD, but
> returns a distinct symbol for a worktree HEAD? That would allow a few
> things:
>
>   - custom --formats for for-each-ref and branch could reuse the logic
>
>   - we could show the symbol (in place of "*") even when color is not
>     enabled
>
>   - it should be much faster if there are a lot of worktrees; your patch
>     does a linear if/else chain to look at each worktree, and it does it
>     in the format-language, which is much slower than actual C. :)
>
> Something like the patch below. I just picked "+" arbitrarily, but any
> character would do (I avoided "*" just to make it visually distinct from
> the current-worktree HEAD). I've left plugging this into git-branch's
> default format as an exercise for the reader. ;)
>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index e1bcb4ca8a..b17eefed0d 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -20,6 +20,7 @@
>  #include "commit-slab.h"
>  #include "commit-graph.h"
>  #include "commit-reach.h"
> +#include "worktree.h"
>
>  static struct ref_msg {
>         const char *gone;
> @@ -114,6 +115,7 @@ static struct used_atom {
>                 } objectname;
>                 struct refname_atom refname;
>                 char *head;
> +               struct string_list worktree_heads;
>         } u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> @@ -420,6 +422,29 @@ static int head_atom_parser(const struct ref_format *format, struct used_atom *a
>         return 0;
>  }
>
> +static int worktree_head_atom_parser(const struct ref_format *format,
> +                                    struct used_atom *atom,
> +                                    const char *arg,
> +                                    struct strbuf *unused_err)
> +{
> +       struct worktree **worktrees = get_worktrees(0);
> +       int i;
> +
> +       string_list_init(&atom->u.worktree_heads, 1);
> +
> +       for (i = 0; worktrees[i]; i++) {
> +               if (worktrees[i]->head_ref)
> +                       string_list_append(&atom->u.worktree_heads,
> +                                          worktrees[i]->head_ref);
> +       }
> +
> +       string_list_sort(&atom->u.worktree_heads);
> +
> +       free_worktrees(worktrees);
> +       return 0;
> +
> +}
> +
>  static struct {
>         const char *name;
>         info_source source;
> @@ -460,6 +485,7 @@ static struct {
>         { "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
>         { "flag", SOURCE_NONE },
>         { "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
> +       { "worktree", SOURCE_NONE, FIELD_STR, worktree_head_atom_parser },
>         { "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
>         { "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
>         { "end", SOURCE_NONE },
> @@ -1588,6 +1614,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>                         else
>                                 v->s = " ";
>                         continue;
> +               } else if (!strcmp(name, "worktree")) {
> +                       if (string_list_has_string(&atom->u.worktree_heads,
> +                                                  ref->refname))
> +                               v->s = "+";
> +                       else
> +                               v->s = " ";
> +                       continue;
>                 } else if (starts_with(name, "align")) {
>                         v->handler = align_atom_handler;
>                         v->s = "";
