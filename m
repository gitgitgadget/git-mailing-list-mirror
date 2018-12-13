Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808A2211B3
	for <e@80x24.org>; Thu, 13 Dec 2018 20:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeLMUes (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 15:34:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40716 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeLMUes (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 15:34:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so1572032pgp.7
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 12:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3wmTZIdB41W8J/68sCZRdQ3VpmtQmjtvBT2wj2muMA=;
        b=Lyf0ViMgUTrMol2hbOkVgjrigBpOFdibVda7vbxEBa2cWI2Chx9Ee2o/GT1y44vq62
         GzJIsL/hmnrsRttXsw47RV7tSPJI/6lv1aMyw82pYhF+FzPxfiHD9RfYz+L6sFVad7Vd
         h3ziaRVqpu/9lJlscSVOcuI8TDrYeW3ZWxVu4OlHV7A2/AkQ+lKn3Lp9e254Nd2FGVl7
         9ofFQ4FKgMCjW9tNUaNUN6pGoOD4XIkgsBevMKRpD3fo1U/ogpVvc5yxCZk+b745CFxO
         IkqZISntzqITzsnjie97gShGZ070U6OvpJhWipAonuCohu1kJfpVA10ZsrsEBOa9XVa5
         f39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3wmTZIdB41W8J/68sCZRdQ3VpmtQmjtvBT2wj2muMA=;
        b=uQLQaF0RfUqCS9wJ5nf61vK547r0Sfw09sGq0bipZp6mTLtSpkb+uLTz9WiCQdhZER
         PALN/DmrouC229FpyNcpeTkhnirKjrjTlh19kn2kRze5/behdrTb2xBermMWdtyO+Hxh
         utp7OWBbRqhUqh0eauBwEMw6tyZrlFSOip6S+/CGh8b5iaBMLyqK2B/nZV1rMTvv3pAZ
         XLOrgQogE18yIQgGxfqokYmCROujnaBkkJDOOPhhADJGuMauELMXGlr8LA/3/zh/A3J4
         qhq8q5QR5fz8pM+ynlFtyWLXMKD8IDLUHBCaMZg2sxODcWfidL7mkgv52qW37MoXVjeg
         kyig==
X-Gm-Message-State: AA+aEWZ2nhTcAunQ/3c9gzF9n4Hy5hVvHPlW5Gp/SA90VhMAMx16TVyF
        JXlIiYacGCU/6wRbAAEnvDMU2DCrZEZ9LX4qNfoOeatM
X-Google-Smtp-Source: AFSGD/Wd4p2f8ydHzDMOp/0ecgHXj9VfiirNg5wN0QbxdIxcYqK14P0KLOUJGsHghUujEPc8PT2T8T5bsghsBgo72cc=
X-Received: by 2002:a65:41c2:: with SMTP id b2mr242271pgq.67.1544733286959;
 Thu, 13 Dec 2018 12:34:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
In-Reply-To: <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Thu, 13 Dec 2018 15:34:35 -0500
Message-ID: <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 3:23 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Dec 13, 2018 at 8:56 PM Michael Rappazzo via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Michael Rappazzo <rappazzo@gmail.com>
> >
> > On a worktree which is not the primary, using the symbolic-ref 'head' was
> > incorrectly pointing to the main worktree's HEAD.  The same was true for
> > any other case of the word 'Head'.
> >
> > Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> > ---
> >  refs.c                   | 8 ++++----
> >  t/t1415-worktree-refs.sh | 9 +++++++++
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/refs.c b/refs.c
> > index f9936355cd..963e786458 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -579,7 +579,7 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
> >                                 *ref = xstrdup(r);
> >                         if (!warn_ambiguous_refs)
> >                                 break;
> > -               } else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
> > +               } else if ((flag & REF_ISSYMREF) && strcasecmp(fullref.buf, "HEAD")) {
>
> This is not going to work. How about ~40 other "strcmp.*HEAD"
> instances? All refs are case-sensitive and this probably will not
> change even when we introduce new ref backends.

The current situation is definitely a problem.  If I am in a worktree,
using "head" should be the same as "HEAD".

I am not sure if you mean that the fix is too narrow or too wide.
Maybe it is only necessary in 'is_per_worktree_ref'.  On the other
side of the coin, I could change every strcmp to strcasecmp where the
comparison is against "HEAD".


>
> >                         warning(_("ignoring dangling symref %s"), fullref.buf);
> >                 } else if ((flag & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
> >                         warning(_("ignoring broken ref %s"), fullref.buf);
> --
> Duy
