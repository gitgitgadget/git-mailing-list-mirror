Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D852720248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCNPtK (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:49:10 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39013 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfCNPtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:49:10 -0400
Received: by mail-ua1-f67.google.com with SMTP id s15so2079113uap.6
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzbY5TFfbL4cpF4FDEfmoe69HM3Lt9uSUmLwKbX4xZY=;
        b=Os0Y9h2m8mHDWvIeYYtSL96DFfFFB0eKYlNjB7rpa580sJDTZ1pw7AFag3VdQq1daC
         jFxptveWOBHH71c4dek0XOa8RQ0lbN3zAiGdmnWeTaxB7jGPpIBu0OW2rZd2zZHR5w6a
         Iu6MvJhxyHx2lfXArgvs7gZC/NMAn3gnRJ9X7KwIHHegdz2GpU47ouw4jHoJQvUvlR6f
         wH7ZoTY2tlm9dmqhtfrzPaciWgOgrGOKGUZkvt9ltqLkroP+ipyd7ynLaVFCN7UTshSZ
         9I7cm8f6V65cjoG5reYZK8U+UTf8FsIAtWkMHxEN7um7K4B2wso2KzII0BZq2p/fkOBy
         3z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzbY5TFfbL4cpF4FDEfmoe69HM3Lt9uSUmLwKbX4xZY=;
        b=fbRAqyL1Dlu5vA/LS9A/PpsZataq1SMaUgfsdDLOOrR8LGTMYtyJmKnVCf2WYIzq+c
         HdOPYdmGRMW+/R1/mehGmTYGNigNLtuKZ5cB8Ax7OCZzKqF1y7l4AtrLvqQc5k8KKYNJ
         W9DmKDMGMbjww/hWmG22FkCQ9VLczVJqI4vVwp6s/cXnX3io3rAbJBpSrPxHzW8RN/eW
         nGUqaEy99OXddHrBXaMQOcUXtPpc8g+r1z5BgAMvhaCWvbLXBuJbM32Zkt0pud/zFmql
         XVYmjVjoF2P2WvqB43E1THyUn5mck1f002oLAbenMwwndqgOgTDVgBZ3YvrISNqmd9rX
         cSzg==
X-Gm-Message-State: APjAAAWLQzdZurBYuqaQN+Lisp8eRIgdTuUpmjN6la4bzaVO4wvQhavY
        YLDeA5giaqe1y67QRaLhM2vatRnsW3U0Y7366gM=
X-Google-Smtp-Source: APXvYqzSmzGIPejQJQwnJgfOuNhYQlLOEGLyySNq82W3Hn4mCC75doycJMkjJR/d+XqqoIivjrSmauSNGmBPi3kaHwc=
X-Received: by 2002:a9f:3205:: with SMTP id x5mr25140855uad.104.1552578548815;
 Thu, 14 Mar 2019 08:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8CuNQR7javX7KTC7txivH1OkejCbVJdHGD+XJ-0ftT3ag@mail.gmail.com>
 <CABPp-BHB3c0XqS57Do8=YFtbVyBEe26kbJtgDxWAaWAMzsgdoA@mail.gmail.com> <xmqqsgvp9axu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgvp9axu.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 14 Mar 2019 08:48:55 -0700
Message-ID: <CABPp-BHks42bhFr68TvM-Hu185EjuqoYdPexbJeWEepBaK9kyA@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 12:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> I think sometimes a 3-way merge creates marker conflicts in file, and
> >> this does not look easy to reverse when switching back. If it's true
> >> and we can detect it, we can still abort this case (i.e. requiring -m
>
> Paths with actual conflicts are much easier to recover from than
> paths that cleanly merge.   You have your original in stage #2, so
> you should be able to "restore-path --stage=2 --from-stage path..."
> them.  Once the contents are auto-resolved cleanly, however, the
> cached contents are automaticaly updated to the auto-resolved result,
> and it needs more work to reverse the effect of the merge (it is
> doable, of course, as you know exactly the contents of the
> switched-to branch and the contents of the switching-from branch, so
> it is just the matter of running 3-way merge in the right direction
> to recover what used to be in the working tree).

I agree that mixtures of conflicts and clean merges would be the most
difficult to reverse.  However, recovering from conflict cases is
actually harder than you mention, at least when renames are involved.
If foo is modified on both sides of history in conflicting ways AND
renamed to bar in the other branch, then all three staged will be
stored under the path bar.  Using your method to restore would cause
you to get a file named bar (though it would have the contents of the
original foo).

It can unfortunately get even worse.  With rename/rename(2to1)
conflicts; there are up to six values that needed to be shoved into
the normal three slots in the index, which merge-recursive achieves by
first content merging three at a time and shoving the (possibly
conflict-marker containing) results from that into two slots of the
index and then two-way merging from there to get the worktree contents
(possibly resulting in nested conflict markers).  Checking something
out of stage 2 thus not only might get the file path wrong but can
also get you contents with conflict markers.


However, this whole exercise gave me an idea that answers Duy's
original question definitively: you cannot necessarily reverse a
successful (i.e. no conflicts present) three-way merge with another
three-way merge.  Here's an example to demonstrate that...let's say
you are on branch A, and you have two identical files:
  A: foo, bar
and you want to switch to branch B which renamed foo but didn't modify it:
  B: baz, bar
locally on A you had renamed bar but didn't modify it:
  C: foo, baz
(C isn't an actual commit; I just wanted a label to refer to it)

doing a "git switch -m B" will result in merge-recursive noting that
both foo and bar were renamed to baz but that both versions of baz
where identical, so we'd end up with:
  D: baz
(D isn't an actual commit; I just wanted a label to refer to it)

Now, if we were to run "git switch -m A" to go back to A,
merge-recursive would need to do a three-way merge of D & A using B as
the base.  merge-recursive would note that A renamed baz->foo, and
that D deleted bar.  So, you'd end up with:
  E: foo

Unfortunately, C != E, so our reversing was unsuccessful.


In summary, this is yet another reason that making --merge the default
for either checkout or switch would be unsafe.
