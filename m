Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88F6B20248
	for <e@80x24.org>; Mon, 11 Mar 2019 14:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfCKOhZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 10:37:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40068 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfCKOhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 10:37:25 -0400
Received: by mail-io1-f68.google.com with SMTP id p17so4200718iol.7
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fM9iBUUwTbxCG3wlVEZBuHFQGidFBfVo74Aq+lFmqCM=;
        b=aRCu/L/LjQHCjuPfQ0u2693akqZ0h7XJ0oKoEN/9EX8PLKQqm0Rqivty9N1QApuoHK
         5Z59JgpDgbiFlKuOVPXg60ZCu3FjWn1CKui5hYG0EY9GfoFk5kAh3BHYNzA/hn7g6kZ4
         cfBRlhgvdWQkSf3QreGdQ14DMRAmue6oZtM+AQ2obJ7EF8sP8AvX3VrbHElBe8CJ9ZSj
         r/7lf1W9J7kveLTXvbynlZjFEH3vQjTaDWcLAPMUWFaTq73ryUDOwHxwmkjhjE9WURvL
         /1AmfxDWsYa7hWwcQVPWn71jlC6VuL3odM3+UPempIscF6PgsP/lF6B5Hhqw08MT/pYt
         StxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fM9iBUUwTbxCG3wlVEZBuHFQGidFBfVo74Aq+lFmqCM=;
        b=dawx6zrkfpLYOxpXfAfK8h+7WKki7GAz/zzyW+zkB3DIluRLh0U9aK1m0czHn0jOcJ
         ++LEKC4JQLWZKmnKXLMokAPbnLbhIzdMutE5YkehleNtv7v9lnUK8P2jlznAt0IhrDGK
         2pB/RfVKuHGA7foXBToiJP1kC28vp3ehBssU6QmoIVh5r5cqsTpXmhzH2D1c/iKVD03x
         fcWaHKbHxOjmIFoepzAQbWtt/q8y4IPo+ZQGeuWwRJlxp8ptBqlTd/PkpsTnrUp/T/aM
         8guyiFFV9LyXWlSP4dlEQJKSt8+BOzSL7X3Ix63LbmDSPptM4vHCUqBqE7vWitJlRk+0
         RsnQ==
X-Gm-Message-State: APjAAAUvr0egND51iMlp5mPdzpPIFyHGEPlOUzdVh6cd9z6R3HqT54Ey
        7wXZGCXHeigPVJm9A8rUOS9Pzopem1XtDmS36d8=
X-Google-Smtp-Source: APXvYqz6btw5VvT5w+77bvQzEKjyQvlV2kHjceHcasquU8SJxqJh2j2iwu/IYoI+p3QfafLDbU94BbGCxbqsa1rrD2g=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr7898809ioa.282.1552315044098;
 Mon, 11 Mar 2019 07:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-12-pclouds@gmail.com>
 <CABPp-BEVMc+k7fTtZqqAf=WdpFi3W-Tcjw+Ah57bcetOXVwxkQ@mail.gmail.com> <000b01d4d814$64907000$2db15000$@nexbridge.com>
In-Reply-To: <000b01d4d814$64907000$2db15000$@nexbridge.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Mar 2019 21:36:58 +0700
Message-ID: <CACsJy8CJ5VimEJsJMN4G2sFxn7X72qM-8QLBo7NNSjWx39npug@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] doc: promote "git restore"
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 9:12 PM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> > -----Original Message-----
> > From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
> > Of Elijah Newren
> > Sent: March 9, 2019 14:38
> > To: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> > Cc: Git Mailing List <git@vger.kernel.org>; Junio C Hamano
> > <gitster@pobox.com>
> > Subject: Re: [PATCH v1 11/11] doc: promote "git restore"
> >
> > On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y
> > <pclouds@gmail.com> wrote:
> > >
> > > The new command "git restore" (together with "git switch") are added
> > > to avoid the confusion of one-command-do-all "git checkout" for new
> > > users. They are also helpful to avoid ambiguation context.
> >
> > s/ambiguation/ambiguous/ or s/ambiguation context/ambiguity/?
> >
> > > For these reasons, promote it everywhere possible. This includes
> > > documentation, suggestions/advice from other commands.
> > >
> > > One nice thing about git-restore is the ability to restore
> > > "everything", so it can be used in "git status" advice instead of bot=
h
> > > "git checkout" and "git reset".  The three commands suggested by "git
> > > status" are add, rm and restore.
> > >
> > > "git checkout" is also removed from "git help" (i.e. it's no longer
> > > considered a commonly used command)
>
> Just curious: At what point did git checkout become not commonly used? Gi=
t switch and git restore are not yet in git as of 2.21.0, which is rather c=
urrent. Maybe I missed a thread.

I declare "git checkout" not commonly used the moment git-switch and
git-restore are released!

More seriously, this is an attempt to promote new commands. The
"commonly used" here refers to the set of commands that show when you
run "git help" (they are called "common" in command-list.txt
classification). Since the people who type "git help" are mostly new
people, I think promoting the friendlier alternative is a good idea.
And no neither switch or restore has been released. They are not even
in 'pu' yet.
--=20
Duy
