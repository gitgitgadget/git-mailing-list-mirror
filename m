Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946581F453
	for <e@80x24.org>; Tue,  2 Oct 2018 19:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeJCC3W (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 22:29:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35287 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCC3W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 22:29:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id y19-v6so3209248edd.2
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=co3ZtlenWfWRretF6HFUmWl0u56+TC5hbj57kka38dc=;
        b=qj8KrkaP6RTX/SHLvVSnxluzp00WZkfITCnOZfOaP/PYsrwDXzbLE68B8okW8Yc1LV
         ++BJwjEJcDM3DrvBY/LZi/LXNU4n4eo0CvZD6CezxGZh35QiQSSJLSt7a4VDG9uwBPMM
         eF7QP9pPBRKW6ERegsF4huzoM3KAk06998cpL6UDr1BfP6fsDyU1cZBKP8+iqLVBkt13
         kjk5t9mNyre9OlXKzpw21z7W85Q7iC46cvxYHIdIBIPO8jpFINMtonHGXq2uarho/crj
         SAhmuoN541oa9WMGeQpG2hUUCE4zcFQ5hZHKRr4mds530EVxbMsXWEPS+zEWJd4bMkxl
         itgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=co3ZtlenWfWRretF6HFUmWl0u56+TC5hbj57kka38dc=;
        b=lmWQTBX0KbJepkoE8D2efC7RjkpjKdbEApsT094k9AgDHrki8pwODKOTmdvFtt0jcg
         /sqd+Ubc92jJBwCBoQowgkAKfup7fqPgwOm9bu6cB8eegyIPiu7NlZ7V2+gOxjx1WeiH
         aG5q7+WLduSlHRRXPkqu6UUBRIqOeHs/A6jtAgRECNinA862wD6Tcpq9QNpxUQgbLENr
         tZysNeXRC1ZvNpIP0h5t/2S7io9kQdLnGNDfboLH4R3qpjlWYoCgjHX92nl2rvQT2pCn
         LWkwZCnvhSILCZ86thKmbh1hcmTvd9TacpAD029JL6uq9GFn+z73nNDCLSu2bX30mNsM
         sylg==
X-Gm-Message-State: ABuFfogq40kg6heY6mw8QBwV822O2/rJ8xdXhYsgH2fnSlodFmUFTio6
        iuVpFe4wpt/eKjnFqXT1SdnEHoDBOOqOqu24nWua0g==
X-Google-Smtp-Source: ACcGV63xDVyxjpaxTVPGt4GVMvc88V7qLb9Cbmtqb4JqTqdNbNZucu6vA2CcLU6+glPy8MaiDff7PRwTll/Pi08n1c8=
X-Received: by 2002:a17:906:1910:: with SMTP id a16-v6mr20393757eje.19.1538509460348;
 Tue, 02 Oct 2018 12:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.42.git.gitgitgadget@gmail.com> <6906c25415eddf79cc3f71f905a77b140f2f66f0.1538492321.git.gitgitgadget@gmail.com>
 <CAN0heSomOen+mWg1CuPGUCJFgmDQUjGLtAdxpWLwrStRU4Me8g@mail.gmail.com>
 <CAGZ79kYtNnNPMv0=rB4ie=tOoYEPPZ=CmYFg4PG2_j96vjODeQ@mail.gmail.com> <CAN0heSqOjYDXRf4KE_C0GDnFW8r4qVfWnUVuW-Q+4D87nhFURQ@mail.gmail.com>
In-Reply-To: <CAN0heSqOjYDXRf4KE_C0GDnFW8r4qVfWnUVuW-Q+4D87nhFURQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Oct 2018 12:44:09 -0700
Message-ID: <CAGZ79kb2pE3pFQx4A=oo-mYORjN1ubCgV6Gotc78i7d+BqZdBw@mail.gmail.com>
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

On Tue, Oct 2, 2018 at 12:09 PM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> On Tue, 2 Oct 2018 at 19:59, Stefan Beller <sbeller@google.com> wrote:
> > > > +
> > > > +       string_list_clear(&list, 0);
> > > >  }
> > >
> > > Nit: The blank line adds some asymmetry, IMVHO.
> >
> > I think these blank lines are super common, as in:
> >
> >     {
> >       declarations;
> >
> >       multiple;
> >       lines(of);
> >       code;
> >
> >       cleanup;
> >       and_frees;
> >     }
> >
> > (c.f. display_table in column.c, which I admit to have
> > cherry-picked as an example).
> >
> > While in nit territory, I would rather move the string list init
> > into the first block:
> >
> >   {
> >     struct string_list list =3D STRING_LIST_INIT_DUP;
> >
> >     for_each_ref(add_ref_to_list, &list);
> >     write_commit_graph(obj_dir, NULL, &list, append);
> >
> >     string_list_clear(&list, 0);
> >   }
>
> Now this looks very symmetrical. :-)
>
> > > >  void write_commit_graph(const char *obj_dir,
> > > > @@ -846,9 +848,11 @@ void write_commit_graph(const char *obj_dir,
> > > >         compute_generation_numbers(&commits, report_progress);
> > > >
> > > >         graph_name =3D get_commit_graph_filename(obj_dir);
> > > > -       if (safe_create_leading_directories(graph_name))
> > > > +       if (safe_create_leading_directories(graph_name)) {
> > > > +               UNLEAK(graph_name);
> > > >                 die_errno(_("unable to create leading directories o=
f %s"),
> > > >                           graph_name);
> > > > +       }
> > >
> > > Do you really need this hunk?
> >
> > graph_name is produced via xstrfmt in get_commit_graph_filename,
> > so it needs to be free'd in any return/exit path.
>
> Agreed. Although I am questioning that `die()` and its siblings count.
>
> > > In my testing with LeakSanitizer and
> > > valgrind, I don't need this hunk to be leak-free.
> >
> >
> > > Generally speaking, it
> > > seems impossible to UNLEAK when dying, since we don't know what we ha=
ve
> > > allocated higher up in the call-stack.
> >
> > I do not understand; I thought UNLEAK was specifically for the purpose =
of
> > die() calls without imposing extra overhead; rereading 0e5bba53af
> > (add UNLEAK annotation for reducing leak false positives, 2017-09-08)
> > doesn't provide an example for prematurely die()ing, only for regular
> > program exit.
> >
> > > [...] With this hunk, I am
> > > puzzled and feel uneasy, both about having to UNLEAK before dying and
> > > about having to UNLEAK outside of builtin/.
> >
> > I am not uneasy about an UNLEAK before dying, but about dying outside
> > builtin/ in general
>
> Yeah, not dying would be even better (out of scope for this patch).
>
> > (but having a die call accompanied by UNLEAK seems
> > to be the right thing). Can you explain the worries you have regarding =
the
> > allocations on the call stack, as xstrfmt is allocating on the heap and=
 we
> > only UNLEAK the pointer to that?
>
> I think we agree that leaking things "allocat[ed] on the call stack"
> isn't much of a worry. The reason I mentioned the call stack is that
> we've got any number of calls behind us on it, and we might have made
> all sorts of allocations on the heap, and at this point, we have no
> idea about what we should be UNLEAK-ing.

Wouldn't that be the responsibility of each function to make sure things
are UNLEAK'd or free'd before the function is either over or stopped
intermittently (by a subroutine dying) ?

In an ideal world we'd only ever exit/die in the functions high up
the call chain (which are in builtin/) and all other code would gracefully
return error codes or messages instead or even cope with some failure
conditions?

> My worry is that one of these would seem to be true:
>
> * UNLEAK is unsuitable for the job. Whenever we have a `die()` as we do
>   here, we can UNLEAK the variables we know of, but we can't do anything
>   about the allocations we have made higher up the call-chain.

IMHO that is the issue of the functions higher up the call chain and ought
to not affect this patch. By doing the right thing here locally the code ba=
se
will approach a good state eventually.

> Our test
>   suite obviously provokes lots of calls to `die()` -- imagine that each
>   of those leaves a few leaked allocations behind. We'd have a semi-huge
>   number of leaks being reported. While we could mark with UNLEAK to
>   reduce that number, we wouldn't be able to bring the number of leaks
>   down to anywhere near manageable where we'd be able to find the last
>   few true positives.

Makes sense.

> * We add code with no purpose. In this case, we're not talking a lot of
>   lines, but across the code base, if they bring no gain, they are bound
>   to provide a negative net value given enough time.

I see. I did not estimate its negative impact to be high enough, as the
UNLEAK near a die() call was obvious good thing (locally).

I don't know what the best way to proceed is in this case.

Thanks,
Stefan
