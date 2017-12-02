Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87CF020A40
	for <e@80x24.org>; Sat,  2 Dec 2017 20:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbdLBT6q (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 14:58:46 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:39118 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbdLBT6p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 14:58:45 -0500
Received: by mail-it0-f44.google.com with SMTP id 68so5939045ite.4
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 11:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k7dTwI177ymCcUj46C6jjX7diy0bc+iWexa1LEfWG6c=;
        b=bvXSvEmeauooNBv4PkY72S0caaaAl2RxvBjko/AF0OOlK5OUOE+B96KcwytM1Z5O/f
         qD11Prq7dgzi/GX82k6xxzJmB0w+rWrKR3udG0Wr7a8ak+d306WLvS5vLJ76f4NX1CUo
         nxLcjdGEPYEQn2RTxh2oHndUt6NkNLtgFAjgo2ajQqk/ObOzhqCYQ0aK+BIIyPWHQkg4
         ZY27RzNwY9TQk2o/daZ0ZdUlb6+IN/YGH83ulDrXOdhlb8nQYmqu1FbUNkDqj7OatHNu
         jrTL0VLWS7FyP1UkeStXk1fffC5Z/JL43vap5Wz2cWp9dXyzvNqR6VfNhlP5haNAkEem
         hATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k7dTwI177ymCcUj46C6jjX7diy0bc+iWexa1LEfWG6c=;
        b=a1FCrz1f/d1opCyxdQ6AXlOoNeQUwEIjVczbuEJiKlaLZooZ8BmTy9MdQ0NwP5/mPR
         x7u1wSPFw9oflfRgn+MZeWFo7YQd6GIeV9tKBYhJQESJyx5q5SJTCuRV19es2gL3+gI/
         ig87vIUcX2b3HtYvHFFav5vpdPdWwUFXU73QvtDCIhnKAMYLsok/NN/Th2ycdOUyR8mA
         PVFi1iQOJ43qAGRUdE0bGxIzWcA0n0BgzrtudrF/3Mcd3uOVi5/Ea0rbIMg8tvUrToqe
         2E7gemK5LevtIneyj1EpFegwHt9kF3ZL89KRLylnpuPwpebPvWRi4cpl9jAQXlECRbhC
         Ymdw==
X-Gm-Message-State: AKGB3mI1F7osT9B22UeeHNdBiEF3LuIiOo4MmKJip8iLiWSV/5DDTfzi
        3aKrkmM5U8VxmOGvXJspigiru15qeVkvI/esOV8=
X-Google-Smtp-Source: AGs4zMbgqVzaEUh7AVGSlB7XxJZDEoNq/J2RsUozkBWr6pdLz0oZ+TvQ7GtjZ/sfkIvuq1aR5WGhn9OUirrQs7A561o=
X-Received: by 10.36.90.11 with SMTP id v11mr6945504ita.127.1512244724464;
 Sat, 02 Dec 2017 11:58:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.36.169.76 with HTTP; Sat, 2 Dec 2017 11:58:44 -0800 (PST)
In-Reply-To: <CAE5ih78GOFqe_Vb3k_-jPiS7zbX1EdvYmsUyWvKKy=xOH9WrcQ@mail.gmail.com>
References: <CAL1_K8AYf1jKDO8+czcqkUxDAuOODgKv9avaiikWi+4zpqenMQ@mail.gmail.com>
 <57A92686-9161-4234-8341-CD6FAD7AE049@gmail.com> <CAL1_K8C3bNMae6PFk73c7n6AvnbO=5Sujz3oqL_jBj=DpiEO1g@mail.gmail.com>
 <A6F43B7B-F0AF-46E7-B34B-7D54493E2C8B@gmail.com> <CAL1_K8A=7xmLCYzWa0ejtwjy9P+rD+D0cqz+kOXCaQWOgQfuEw@mail.gmail.com>
 <CAE5ih78GOFqe_Vb3k_-jPiS7zbX1EdvYmsUyWvKKy=xOH9WrcQ@mail.gmail.com>
From:   Patrick Rouleau <prouleau72@gmail.com>
Date:   Sat, 2 Dec 2017 14:58:44 -0500
Message-ID: <CAL1_K8DGVzcbWFPz3vbEntB08sEhrV-j-sLxAh0QhV=8KRGf-Q@mail.gmail.com>
Subject: Re: git-p4: cloning with a change number does not import all files
To:     Luke Diamand <luke@diamand.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 2, 2017 at 12:55 PM, Luke Diamand <luke@diamand.org> wrote:
> I think I've sort of stumbled across something like the problem you've
> described in the past. Perhaps the files you need have been deleted
> and then re-integrated or some such.
>
> Would you be able to take a look at some files with this problem and
> see if you can spot what's happened to it ("p4 changes" and perhaps
> "p4 changes -i").

Sorry, but these commands only show the date and an extract of the commit
message.

>
> One thing that can certainly happen is that Perforce gets *very*
> confused if you start getting too clever with symlinked directories,
> and git-p4 can only do so much in the face of this. But it may be
> something else.

Overall, the depot history is very "messy". It contains a lot of projects. The
project on which I work has reach v5 and it has been branched from v4.
From p4v's "show graph", I can see there was a 'main' branch at some point,
but it doesn't exist anymore.

One of the files missing from my clone only has 2 revisions and it was created
in the v5 branch. It was created at 608436 and modified at 608816. I cloned
from 610443, mainly because we added a feature branch and I want to access
it from git too (610443 is one month before the branch creation).

I will play a little bit with p4 to see if I can locate where the problem comes
from and maybe hack git-p4 to make it more verbose.

Thanks,
P. Rouleau
