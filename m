Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875831F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeJTAkt (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:40:49 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39145 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeJTAks (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:40:48 -0400
Received: by mail-it1-f193.google.com with SMTP id m15so5157471itl.4
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EpWm7lLhN4aTKwn/VTKhpt+4xqub2aVJE80/R38YZQQ=;
        b=b0VQbOBoHasWKbPodcgDxgxP6ogJsYHddNjVyG+M9QCX4/orEgLRIIDvyThbx9T6/E
         2j3GAXYBFq6aCYra7drnYm8MypCocj7NxSoWlGz51EFECQCjrTdSkRc25EXGkhvAX8sx
         LDDrlrK7JxNodygvzvrWc2JVY1bNcN4PV1fvUP2+73xeZSd9B/UnSip02mOHW18/gMxs
         +7SJXyXfNTj6l8IBsJdGVAI80cJ1+geoj3r/5adEMCRaXR8OByIiOeC+8ze8tDm5kbzL
         G/Uw8qarwIIHZ8EdyUwpsD5e7Gbsf14Kerf9OMwix2gQHf7Pot/8zZPdP4mnBTgOc2g4
         6c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EpWm7lLhN4aTKwn/VTKhpt+4xqub2aVJE80/R38YZQQ=;
        b=jaDN3anJle4CbnXj8khsM0RzwxC4puKGE2qV2m151+s8PwGBGZdJ4yIOznsibmk3TE
         p9IEIcTJOQNYs+pmDyoWOLWHcKe2/vYbaUEPHQAbsopDo9J8ZoAIMdW6Te2DSOe0y9uP
         wwo3OgDfFIbVBVqz6R7iAf9lZc3txcKwD6q/ezD2rD4gbyLmKkPFFFGzPZMtVyWuoGJ4
         SIetDFpwWzSDnKOupETyb76JUuWQCVpJdogrEDJVwAmN32fZIO9jj/+1RkIOXlr3VaqZ
         b0XXgeXlOmlMf+i3yJz9FvKtKW1zbuJCMJ/nuCdU2L6Cz/OtdZdX5hSBxf0zVXC7zVVl
         F5HQ==
X-Gm-Message-State: ABuFfoiEWbgw2SqcBC6QARHy7bwbebL/ydpm9VD2a6SPRGkCT4lUlEnJ
        BF8vILQ5mbqG2KXGsSeeJcGkgVXY8CjiRMYHwEQ=
X-Google-Smtp-Source: ACcGV63zFtIboT9sDJGtUIw0wCAfAcPY53woI3Po8KYB8HMNHDlKFQGri4RugNL7eqGWqoS1MzTpd2WYFtoXBi3o8Cc=
X-Received: by 2002:a02:a613:: with SMTP id c19-v6mr14127051jam.30.1539966836656;
 Fri, 19 Oct 2018 09:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-20-pclouds@gmail.com> <20181019162021.GA14778@sigill.intra.peff.net>
In-Reply-To: <20181019162021.GA14778@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Oct 2018 18:33:30 +0200
Message-ID: <CACsJy8CGLRi64WzNUM-6NUm3i0JW7+ptfh7+NhiSb7J9Qb0u0w@mail.gmail.com>
Subject: Re: [PATCH v2 19/24] submodule.c: remove implicit dependency on the_index
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 6:20 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Sep 03, 2018 at 08:09:27PM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
> > diff --git a/submodule.c b/submodule.c
> > index 50cbf5f13e..c0c1224760 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -766,7 +766,8 @@ static void collect_changed_submodules_cb(struct di=
ff_queue_struct *q,
> >   * have a corresponding 'struct oid_array' (in the 'util' field) which=
 lists
> >   * what the submodule pointers were updated to during the change.
> >   */
> > -static void collect_changed_submodules(struct string_list *changed,
> > +static void collect_changed_submodules(struct index_state *istate,
> > +                                    struct string_list *changed,
> >                                      struct argv_array *argv)
> >  {
> >       struct rev_info rev;
>
> This function doesn't actually make use of the newly added "istate" (nor
> does it use the_index, so there's not a spot that forgot to get
> converted). Is this in preparation for more refactoring, or is it just a
> mistake and can be dropped?

It's possible that it was needed at some point when I converted diff
api to pass index_state around. But in later iterations I think I
passed "struct repository *" instead because diff code needed much
more than the index, but did not clean this up. Sorry.

In this function, we still have the_repository for
repo_init_revisions() and it should be gone eventually. "struct
repository *r" could take the place of "struct index_state *istate"
instead and we would need to reopen the path again.

So I'm not sure, if it's really bad, we could remove it now. Otherwise
we could just leave it there, I don't think this "istate" will survive
very long. I already started deleting some of the_repository in "kill
the_index" series.

> I don't see anything in the "Kill the_index, final part" series that
> would need it.

Yeah. Killing the_index is just the first small step (didn't look that
small when I started). Now it's all about the_repository ;-) and we
have like 400 references of it just in library code.

> If this can be dropped, then most of the other changes here can, too,
> because they're just pushing the unused parameter down the stack. I.e.:
--=20
Duy
