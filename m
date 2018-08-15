Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8216D1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeHOUE7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:04:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51262 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:04:59 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so2653396itf.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G0th3J7O8ULtTAS3Cnu40qJ8sXng12iqYBjchh+Eg68=;
        b=hG3PZxB8v3zxHypdqaowJnmuts3j+LiGlbPqd2S0pTIL5zyHJDzraVHBrUX0hrCkrK
         Huyo4EQ3Ig6X1KvTtB+QkAdfBzwwIOvb37m8AoE2irN6lJ06tDYuLoKkWEvVWzwiXU/6
         n6eQ7uelJepYrBffwgBYdoXI7b5r2EWAv3TyP5BWRbnJRjT+aE63qG0pkdqdkg2ALWeo
         22xUkLe+iURTlc4ucLeHRly9t/3dclFFriQppiOCLJr/ZjrvtISznFbMdvSufl81S8xD
         xaxbR8JAIsdCDn5X/uzd9B56MRPZBQ5qmvTP8rq6Zq3bcjrRUgqC0eljRbyBDRSQhxjo
         oEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G0th3J7O8ULtTAS3Cnu40qJ8sXng12iqYBjchh+Eg68=;
        b=s7BjNfk5yhOnUgAMkxBVV/dJvU7wzlSVaTU6Xdz1GVrGvW0lYV4WmXpvf7DVnzlnXx
         i0z4vgiBO9yI9STkz4ozP1E426L/KlS0AP/rWtw6ZZ6ngUTSxDqJKV2JRDoFRLADGFJ7
         GRU+f1OCa/sYEHGod+2lDXWspdizdu5zActcLuysNP9s8Kfd/tnWHueeGlEpgKrrHuTw
         jX7gWYCDu1AG9gEaMeIvywb7McIrE9dQIQfCwoBL3RsBh/Lh4CDbUl/c2TAqT4S3D+wp
         3knyt2/jXxUPGhLyDR+G5gUMAokP4NlFX+3g7KjWz5D+83ZVf9fMZpGTtiGFGBG2j5E/
         2XPg==
X-Gm-Message-State: AOUpUlGeozV8NTWF33KS6WtYJd4aqmMmFy4c1VQ71t2UflnpBOwh8Pg4
        JQ55wY484JEOjmptI9TPJS4WQbjXbXVh3Z5127M=
X-Google-Smtp-Source: AA+uWPxbfcAYqKuarHvKQc/yKEq0fMLkhWg6MEvgR6sVIBSRdnJDl8iJlaOSdxkt4NT6KJy4clWJL5K2dxzCMpD13sk=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr18948849itc.68.1534353118993;
 Wed, 15 Aug 2018 10:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180815162308.17747-1-pclouds@gmail.com> <CABPp-BEC45snMzGeCre-dD1rtqGok-RKuLGbMaV=VJhwx1ceew@mail.gmail.com>
 <CACsJy8B3ip+_sDrpvaZ32a35-6hWkY=eE6g4RObWgbHnf6g8uw@mail.gmail.com> <CAGZ79kbSa2chcUj_2=v7iE59R6_0m==ecYkB86+-4Fd_Zgd5_g@mail.gmail.com>
In-Reply-To: <CAGZ79kbSa2chcUj_2=v7iE59R6_0m==ecYkB86+-4Fd_Zgd5_g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 19:11:32 +0200
Message-ID: <CACsJy8ASVqV9mmokTMmap9q7o--3nk1rRyFuuYrrNRO9mnrUvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] branch.c: remove explicit reference to the_repository
To:     Stefan Beller <sbeller@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 6:58 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Wed, Aug 15, 2018 at 9:53 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Wed, Aug 15, 2018 at 6:48 PM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Wed, Aug 15, 2018 at 9:24 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
> > >
> > > The patch looks good, but since this touches multiple .c files, I
> > > think I'd s/branch.c/branch/ in the subject line.
> >
> > It is about removing the_repository from branch.c though. As much as I
> > want to completely erase the_repository, that would take a lot more
> > work.
>
> What is your envisioned end state?
>
> 1) IMHO we'd first want to put the_repository in place where needed,
> 2) then start replacing s/the_repository/a repository/ in /
> 3) builtin/ is not critical, but we'd want to do that later
> 4) eventually (in the very long run), we'd change the signature of
>   all commands from cmd_foo(int argc, char argv, char *prefix)
>   to cmd_foo(int argc, char argv, struct repository *repo)
>
> you seem to be interested in removing the_repository from branch.c,
> but not as much from bultin/ for now, which is roughly step 2 in that pla=
n?

Yes. Though I think step 4 is to make setup_git_directory() and
enter_repo() return a 'struct repository *'. This means if you have
not called either function and not take the repo as an argument, you
do not have access to any repository.

I've been trying to make setup_git_directory() not touch any global
variables, which would be the first step towards that. Unfortunately
I'm currently stopped at the one exception called "git init".
--=20
Duy
