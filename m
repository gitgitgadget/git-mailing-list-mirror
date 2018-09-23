Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 479C21F453
	for <e@80x24.org>; Sun, 23 Sep 2018 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeIWTM6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 15:12:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43870 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeIWTM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 15:12:58 -0400
Received: by mail-io1-f67.google.com with SMTP id y10-v6so15680639ioa.10
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWgBzGG7nEnLlOUX8Dk+FHKQBDWIHKKJuvT7zjHZNlc=;
        b=DFLBKE1BVytfA0ZS0FkpEBBg/+Ab97/u0P4wEkaFpsMXCs/4oiYRu97MV2o/Vim7eu
         YlDlIC0jQD9YOo/VeRZHWi5YcrZlVkL3azFU4VUrO10XmQ3beE6RqpxiliC39ti8bR9l
         FiasrTILBT1+C3rT5hdUiJIYXplmoClJd5hr2vvgG1m/q40F9whiz8Z8hWFiXG6OY1B6
         0yqt/tSZqn8iyvaGuYywXkSymtLOlajhP/UKMB0+R6z6HC90NXn7tRPUs9xfGKRkAgCg
         NNGeSI2azMSIykUTGP2Itk9stHE/3UIq4bxh1Q+Gprp9cDN9nZXpoIh5X3C+52/cJ+7W
         XZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWgBzGG7nEnLlOUX8Dk+FHKQBDWIHKKJuvT7zjHZNlc=;
        b=ZT2nc4GT0tU4aaCMmMFtVLL4W80UJm5kO5xfpLOc2Q6XwuTmbKioRCbZwJ04Wh1aBP
         y5N01jMwuFxySnjkoTN+buA19CCadDDidMdzncLfV2FLEkCGF6wVa8yEDj5Ae6++i8YC
         NJOebd/HGKNudnqc3SLYgAW5extCTOUUttJlegjvU6ujNO7OD9dgCXzd05wc7ZwM4lJs
         ethhuKRWxAJa6KyMd3CWD1ycf/XP/UOAX5Rw2CaCDRMF/F6IAYkP3XgpDD0rqaraohiT
         Dh+RgagRJ644IlhVGe9/WFLTf7MofQlVxBeo8R8bxSHKZa2JwYqyMA5RPM0uJaea3dbO
         7M6A==
X-Gm-Message-State: ABuFfoi9Zd5DPxvf/QGQSj1Z1BdiNb+im4x+b8IDITqb8lOuHRNN1/DU
        Su4m4UodpzZ8BeVUscw2anCAGFmwuHtcI2EfDTk=
X-Google-Smtp-Source: ACcGV61Ug4J00ouTXQ4Cvzm1QmpvWh0lKcl+Rky4J5d9qxCDKQayesumFbUoQQyqcj/b6Sq/kxL5DrS/4BdkhdLdw9M=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr4318424iok.236.1537708530643;
 Sun, 23 Sep 2018 06:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-6-pclouds@gmail.com>
 <CAPig+cTZpgU_n78wG4W0PDvM7Xdr3-1DoHz4d25XBFUmUy7a+A@mail.gmail.com>
In-Reply-To: <CAPig+cTZpgU_n78wG4W0PDvM7Xdr3-1DoHz4d25XBFUmUy7a+A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 23 Sep 2018 15:15:04 +0200
Message-ID: <CACsJy8CN-2vBhNrsunBoZ3WMSPK9ULoBRGULCeDbNjLTp5J+ig@mail.gmail.com>
Subject: Re: [PATCH 5/8] revision.c: better error reporting on ref from
 different worktrees
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 10:25 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > @@ -487,6 +487,28 @@ int submodule_uses_worktrees(const char *path)
> > +void strbuf_worktree_ref(const struct worktree *wt,
> > +                        struct strbuf *sb,
> > +                        const char *refname)
> > +{
> > +       if (wt && !wt->is_current) {
> > +               if (is_main_worktree(wt))
> > +                       strbuf_addstr(sb, "main/");
> > +               else
> > +                       strbuf_addf(sb, "worktrees/%s/", wt->id);
> > +       }
> > +       strbuf_addstr(sb, refname);
> > +}
>
> Seeing this use worktree->id to construct "worktrees/<id>/<refname>"
> makes me wonder how the user is going to know the ID of a worktree in
> order to specify such refs in the first place. For example, how is the
> user going to know the <id> in "git rev-parse worktrees/<id>/HEAD"? I
> don't think we print the worktree ID anywhere, do we? Certainly, "git
> worktree list" doesn't show it, and "git worktree add" stopped showing
> it as of 2c27002a0a (worktree: improve message when creating a new
> worktree, 2018-04-24).

Oh yes I forgot to point this out. With this approach we have to have
an id, and the directory name inside $GIT_DIR/worktrees seems a
natural choice. I was hoping to go with extended ref syntax instead
[1] which gives us more flexibility in identifying a worktree. But I
don't think that's going to happen. "git worktree" would need some
improvements to show this id, specify it at "git worktree add" and
potentially rename it even.

[1] https://public-inbox.org/git/CACsJy8BOvU_z-uLrFmzFyryMXHNDfc_FUN_4i4NnVXWoShaBLQ@mail.gmail.com/
-- 
Duy
