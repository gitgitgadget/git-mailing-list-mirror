Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580F61F453
	for <e@80x24.org>; Tue,  2 Oct 2018 17:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeJCAoS (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 20:44:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45600 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeJCAoR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 20:44:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id v18-v6so1843136edq.12
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oQr5fgMy5gF9wUhPI4Nkp+JEM5H4uTOso3AzCNG5sZ4=;
        b=Nlq2BtdlZDScg4hLymwihBnESL1TO2QyDEFfJ67QYY69Rfb3FEI3m6nDUkmD6UjXRU
         v/oa7SIZEdcPLZuhfS/nFZsYzAbYMdO2y4FgJNG5cXNRSJ4XSZY52fSVDzvLhFdOmR46
         BUiugYbDuEefpVtS1adD4Xa3BWIcHuI7fR6C4RrtpUYuNzQq+4HVdMmG0v2MXB9VZF8z
         rR5r2UgeemEJQ5Hx/g7fWrQ8sy+NvfYwguChNMFTfilHRCJT4O4zURq/Fl+cJ0c91di9
         hnLMmi5dJCMcIm9yWLXNe9SIob7iV9w5qCK1s9/opep/ODTFvwi7smw8p3hj+pEoc8Ww
         Pzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oQr5fgMy5gF9wUhPI4Nkp+JEM5H4uTOso3AzCNG5sZ4=;
        b=lKKnQ0L/lbXAXB9DREZcWHIn2d+wZb4BBOgDwcECXL+kE7NpvP0qdnPCdMUrwCwVej
         5w0Peyk6xDjM7/PrZKyuHJ4EIXQNB6L6gXfmXhX6iLJ0VrFXaO65sdRLy78sMx1bQ3F1
         yf0AX3S9UTG+gndcRZMUdi3ir1NJNz8Uj4iK6/DD77mXs0bXDbvE81wGPlEPBLG38xdU
         6Jcu0CncOVJ7U/Wp05pHkkpZI1Ytdpnc+sbEExeMS7GyDnS4HPmEL5hxnIjWpLjJ+q0Y
         jVzUIkVc/PQyzTqasZQ5Zih+p9IqV0T+1a1MpROhFFQqp0zCM/VB4sG2luJ3r8SojqoN
         cA7w==
X-Gm-Message-State: ABuFfoiRWEMI7qg7RzYLHBIEVw/n2uHv4zxYAN10qispLlmhwMoTD5Cu
        6p9W2PrP3mKZIbWKelK3DFUwWZgTe2D/F/DbPizlZA==
X-Google-Smtp-Source: ACcGV606Vk+1UivMI/MoUtVgXXI1THAdilRgx7H/bnIAzBamYcQKwyZj7c7o51x7R5gUgWsQQ1ZxndTZ+jvhJ/MigeA=
X-Received: by 2002:a50:b3dd:: with SMTP id t29-v6mr13106417edd.76.1538503180589;
 Tue, 02 Oct 2018 10:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.42.git.gitgitgadget@gmail.com> <6906c25415eddf79cc3f71f905a77b140f2f66f0.1538492321.git.gitgitgadget@gmail.com>
 <CAN0heSomOen+mWg1CuPGUCJFgmDQUjGLtAdxpWLwrStRU4Me8g@mail.gmail.com>
In-Reply-To: <CAN0heSomOen+mWg1CuPGUCJFgmDQUjGLtAdxpWLwrStRU4Me8g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Oct 2018 10:59:28 -0700
Message-ID: <CAGZ79kYtNnNPMv0=rB4ie=tOoYEPPZ=CmYFg4PG2_j96vjODeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit-graph: clean up leaked memory during write
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 8:40 AM Martin =C3=85gren <martin.agren@gmail.com> w=
rote:
>
> On Tue, 2 Oct 2018 at 17:01, Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 2a24eb8b5a..7226bd6b58 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -698,6 +698,8 @@ void write_commit_graph_reachable(const char *obj_d=
ir, int append,
> >         string_list_init(&list, 1);
> >         for_each_ref(add_ref_to_list, &list);
> >         write_commit_graph(obj_dir, NULL, &list, append, report_progres=
s);
> > +
> > +       string_list_clear(&list, 0);
> >  }
>
> Nit: The blank line adds some asymmetry, IMVHO.

I think these blank lines are super common, as in:

    {
      declarations;

      multiple;
      lines(of);
      code;

      cleanup;
      and_frees;
    }

(c.f. display_table in column.c, which I admit to have
cherry-picked as an example).

While in nit territory, I would rather move the string list init
into the first block:

  {
    struct string_list list =3D STRING_LIST_INIT_DUP;

    for_each_ref(add_ref_to_list, &list);
    write_commit_graph(obj_dir, NULL, &list, append);

    string_list_clear(&list, 0);
  }




>
> >  void write_commit_graph(const char *obj_dir,
> > @@ -846,9 +848,11 @@ void write_commit_graph(const char *obj_dir,
> >         compute_generation_numbers(&commits, report_progress);
> >
> >         graph_name =3D get_commit_graph_filename(obj_dir);
> > -       if (safe_create_leading_directories(graph_name))
> > +       if (safe_create_leading_directories(graph_name)) {
> > +               UNLEAK(graph_name);
> >                 die_errno(_("unable to create leading directories of %s=
"),
> >                           graph_name);
> > +       }
>
> Do you really need this hunk?

graph_name is produced via xstrfmt in get_commit_graph_filename,
so it needs to be free'd in any return/exit path.

> In my testing with LeakSanitizer and
> valgrind, I don't need this hunk to be leak-free.


> Generally speaking, it
> seems impossible to UNLEAK when dying, since we don't know what we have
> allocated higher up in the call-stack.

I do not understand; I thought UNLEAK was specifically for the purpose of
die() calls without imposing extra overhead; rereading 0e5bba53af
(add UNLEAK annotation for reducing leak false positives, 2017-09-08)
doesn't provide an example for prematurely die()ing, only for regular
program exit.

> Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>
>
> as I've verified the leaks before and after. With this hunk, I am
> puzzled and feel uneasy, both about having to UNLEAK before dying and
> about having to UNLEAK outside of builtin/.

I am not uneasy about an UNLEAK before dying, but about dying outside
builtin/ in general (but having a die call accompanied by UNLEAK seems
to be the right thing). Can you explain the worries you have regarding the
allocations on the call stack, as xstrfmt is allocating on the heap and we
only UNLEAK the pointer to that?

Stefan
