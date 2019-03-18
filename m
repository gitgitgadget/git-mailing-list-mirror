Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28EB020248
	for <e@80x24.org>; Mon, 18 Mar 2019 12:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCRMGx (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 08:06:53 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52865 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfCRMGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 08:06:53 -0400
Received: by mail-it1-f195.google.com with SMTP id g17so20029482ita.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sug6OcjVGDRspv2PMJctftSAYLPdTuIZ5OCNipAVlwc=;
        b=KmhMgdBCwIilTiAm0J0aHzyUMxbzFg1mg2Zf0bOV05bUoVE1Rvj9PoEw1IggQl9UAO
         nDZq1gzMN1uQKXm8MQBz4+7ljjqdw5soPW3/ad/8CDeDwO2GBCiKU9uekX0XkKnr7nbq
         DsGHi2h954AJBlDXhMI+mu2tOmOquzd/HOiGcoo5FQuBAN7MStKZNYLwl9VcMfqC3q36
         po0QjHdBKZsvu8pg3Mcz1sCqbpst3i5YExF+Gwhk6Tg87/ononIfYHCpHuJz47YbTMAq
         ZdA3Fkk/ciF5ueF+xRblg3BiGL5bkuP+NUc0IjN+UZSQBNDvwVxMH8hFQMgg8fF4R/nu
         8zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sug6OcjVGDRspv2PMJctftSAYLPdTuIZ5OCNipAVlwc=;
        b=J+2En1HkZpkPBjy1GLd91ertespb7ws5gjLOmnEzyYcdzxq1+eAdzM6IeBFfCZCF3M
         FEmC8Yaq5XUJww7Lt/YQGTPK8x6ScnYHmeA1wzZXLPDgmgxl+tN68QLMOXHweYjzFb9w
         CRVU6h8SDSH8GQ0k2RU4TvYEHIr52vQLeiJgHPi5tflcTrdJmuZD04GWnbgZWL6akW9K
         XnoUeP4MBdrkCWlhmId3R3ffWBoKleiudrXyrhK0OXVjPILj7m+h1s/51wGfXVZsOpeb
         4GPofLhrb8sHYbYkYd5kVGj0y5cW8d6D2JMVAU9SuhNt05AxJqpkbXvRNkQYuf8niHd2
         SYHQ==
X-Gm-Message-State: APjAAAVpvt+/7ILouAdKOihV8clKKAbOEyfaGoRAg8pZbFGVv7od2/Q0
        HNlIrq1y24JkLHhhxJnTdEFZ87yIiSKg7EerIq4=
X-Google-Smtp-Source: APXvYqxfko7nJaqpTKyc5ta6SaP6qXmgP+0jRhXSASd2IsnVLvY81dE8G5BA+FJym2xmXHzkUi+IJhDvzpZXGVLOJzc=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr8973121ita.10.1552910811675;
 Mon, 18 Mar 2019 05:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com> <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com> <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
 <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
 <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
 <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
 <20190314091753.GA9852@ash> <CABPp-BF3_p3+fmQcWYEu2z3J4FfPmDmiMyFiBRXyz8TxKLL7jA@mail.gmail.com>
 <xmqqr2b56ir6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2b56ir6.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 18 Mar 2019 19:06:25 +0700
Message-ID: <CACsJy8Dfy4csm5xpGwz6EZXqN+uMFmf4woEPTZ2WjbeDTa-9Sw@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 9:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I don't see why <start-point> even makes sense to use with --orphan;
> > you should error if both are given, IMO.  The point of --orphan is to
> > create some entirely new history.  So, I'd expect "git switch --orphan
> > <new-branch>" to:
> >   * not create refs/heads/<new-branch>
> >   * set HEAD to refs/heads/<new-branch>
> >   * empty all tracked files from the working tree.
> >   * empty the index
> >
> > Alternatively, you could allow <start-point> to be passed with
> > --orphan, adjusting the above steps so that both the index and the
> > working tree are switched to match <start-point>, but ONLY if
> > <start-point> defaults to the empty tree when --orphan is passed.
>
> Do you mean that it's like <start-point> is not really a start-point
> but is an initial tree, i.e.
>
>         switch --orphan --initial-tree=<tree-ish> <new-branch>
>
> is a mere short-hand for
>
>         switch --orhpan <new-branch> &&
>         restore --from-tree=<tree-ish> .
>
> I think that does make sense, but at the same time, I think a major
> reason why people say "checkout does too many things depending on
> the arguments and conext to be easily explained" is exactly due to
> its many "if you give X, it is like writing this longer command
> sequence" short hands, so...

Yeah <start-point> is optional and probably only useful for people who
do a lot of --orphan. I did think if there's any other command that
could be a better host for this orphan branch creation. No such luck.

PS. There's one small difference between 'switch --orphan <new-branch>
<tree-ish>' and your switch/restore combination: the latter refuses if
you have any local changes because it has to remove all tracked files
first, while the former only refuses when the local changes are
outside <tree-ish>. If path A will be tracked by <tree-ish>, then
whatever changes in there may stay.
-- 
Duy
