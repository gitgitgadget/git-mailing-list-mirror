Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AEAF20248
	for <e@80x24.org>; Tue, 12 Mar 2019 16:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCLQv1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 12:51:27 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39896 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLQv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 12:51:26 -0400
Received: by mail-vs1-f66.google.com with SMTP id w14so2011643vso.6
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXxNJRUcfw3Xd9vZFJaILT5+I/8ZXLLh2yXEwMobOwE=;
        b=NZxWXqPz2KcR8PVHOyUPwGRw6fJNmwZ53agOpwFTY18Nse9EFSy2h/r9jc8Vf5t4GB
         zIChEiHfBi4sxRNG2lLErgj7XfqfADZp9LD2JvUz/wUzfTddSkjgcOQT67aZgv12DYi2
         ghSNYQtnzUeTqoVV7jvhqUNyEqwHTHY7nHhIm5+6fkKylUic8YpOKI4AgRpgYZA1NNfy
         3mIbNDTwjd6MwlVMYg8Rs607tyJcMFCeuw+fNV58sx930yFwClpbiDmu51c6sdSh4PWo
         1Cy+yYHPKp/NjQ6KSZAPEu7l0XxcTWbIxPsLuUhVG4eAyDExG8qdm4Anyc28QAKeu7Wg
         +APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXxNJRUcfw3Xd9vZFJaILT5+I/8ZXLLh2yXEwMobOwE=;
        b=QUK7Zqdhn2IhmMvchX2DHdD+pXAGV23tyfjrDoTLyNPS77BIEUfuYxAyjJNb5RQIGJ
         MKefDMjaefRgqCgctuoDyakNJU5U8yYUyLcwORU/hfF/4Ge6TGJDZYxW17Jk39wbtryI
         rqp7CUfFjiV75qfXVEi6vUFbK2LDs+m67WDtkFrKYfffmQ6upEaukKeOt18NvatCF0eF
         XDtsPzB56OziU8/KYp6tXDl1j9jbfhni50/MEt07EnFpnUtiU8BMqeOnrCVAUlyxiGQ+
         fai0xaHhpuNDOHRbejBbNyhGyaMbfBk6mXcQzqdcdxoWlh5lKqCtbil/fAy6ZevlxQg7
         dC/A==
X-Gm-Message-State: APjAAAXKLoh49MI5iF8RhJEcyK1hBOHNfhmv9uHLaq+ZrMEmVSX5zeLT
        QwswAfms91PrJJ4a/R+fgXbobrh/pQ1Tb8/Rtw8=
X-Google-Smtp-Source: APXvYqwFy7F1l6/qo5gJqGgIjYPOk3U3ZzdLslhHuBz4ZA/m3HDc31SIxLSX85HmYJ5n84HSQOrvSlkHOygbnvBrCe0=
X-Received: by 2002:a67:f8cc:: with SMTP id c12mr20284643vsp.136.1552409485157;
 Tue, 12 Mar 2019 09:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com> <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
 <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
In-Reply-To: <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Mar 2019 09:51:13 -0700
Message-ID: <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 8:37 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Mar 12, 2019 at 8:19 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Tue, Mar 12, 2019 at 3:51 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > > I tend to agree with this but that's probably because I don't really use
> > > checkout -B. I'm not sure if it's widely used or not. I do find checkout
> > > -b convenient though.
> >
> > Yeah I think both -b and -B are about convenience.
> >
> > But I would not mind dropping -C for now, if people think it's not
> > that useful. We can bring it back in incremental updates if we realize
> > we miss it so much. I'll keep it unless somebody says something.
>
> It's not much of a datapoint, but I do use "git checkout -B" (and
> therefore would use "git switch -C") periodically (in addition to
> -b/-c, which I use all the time). And, convenience is important,
> especially considering that "git switch" is already more painful in
> some ways than "git checkout", due to having to trigger and spell out
> certain things explicitly (such as detaching).

Ooh, interesting.  I haven't used it and didn't know who did, but
since you do you can probably answer the question surrounding the
long-name for the -C option from earlier in the thread:

Do you use checkout -B only when checkout -b fails, or do you use it
pre-emptively?  The former would suggest we should use a name like
--recreate, while the latter would suggest a name more like
--force-create.

> > PS. The same probably goes for --orphan too. Wait and see if people
> > complain, then we know how they actually use it.
>
> Again, not much of a datapoint, but I do use --orphan periodically.
> The idea of "fixing" the behavior so that --orphan starts with a clean
> slate is certainly appealing (since it matches how I've used orphan
> branches in each case).

The only three people who have commented on --orphan in this thread
all apparently feel the same way: the current behavior is wrong.
Maybe we can switch it to start with an empty index after all?
