Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321D420248
	for <e@80x24.org>; Mon, 11 Mar 2019 17:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfCKRZI (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 13:25:08 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37917 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfCKRZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 13:25:05 -0400
Received: by mail-ua1-f66.google.com with SMTP id d4so1801390uap.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RxRq82mUZk9XJE7OtGT+hnWy/XbCCtQlVH35x9pGSwI=;
        b=AvLclclXU6r6HU3zFVDx8siIssMC5YgZVTBdGqds/48YqqfAgMK36GzHcYyQV9zAtW
         iwApKxq0HPXgY1TXIQ0i8gnttoFcV5HY0nIqp9mlOTYHyjvrlHqnXpNOAIwtFmUadcmq
         L3CYlczNOC1loUNw/jDNE12YL3wN1Ff3mWMyPlBikMGf88YjmAYZaCNKKAR+83J5VjFM
         A9ntW+cyQJW1vG2ax/7VKmPsETATmOgDqS1uASuY68zu0B4idIv7I2eM7CoheghbZVKJ
         0FhYGLvuLIWNTPykTsDJnINBpoStkDepTx5ODBT98tljKvcJoRW1jX+BhCDy0lU+uD8U
         gdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RxRq82mUZk9XJE7OtGT+hnWy/XbCCtQlVH35x9pGSwI=;
        b=cU4K9AImMLefZAVcvR2iNzZUDCKjNtaZyaeKVLhjv2TH/C6Fx2/MN4Hh629uyRKDQb
         4NA/RwyMECqX2OqKeV/OH4TydFkVvEF6bnhz16hHC1++FbKc3IChBoeguS+vrNmbxdIB
         qr/MHl2qlhCPrWuiURyskISRQpb2+ChRt+FjReuJNJ9nvbyqtRfXeTx0GrmC9IGeUpSJ
         t5t+i07/kNoR3mjaL5dvfo4+X++kPYUqlMRqaGLMlFV/wj7FFDLgFkFBczgSY0Kx7EM9
         PuhyamdSt1Xa/uXU+0hOIhgASxgcspWN1kJPh8Z97GiOsFloxNQAphMyo1IoQI/wnfsn
         ag4A==
X-Gm-Message-State: APjAAAX63iaJZlQCX2WwisOhvgIXVCAuYoE0mtGoaizwcdi8HR9ImMRG
        02QdFlhBzvNuZdoZlZ+DVtxRGMgyLJRRj/owm74=
X-Google-Smtp-Source: APXvYqwtlO3uwxcXraPw4ZnaYzvH0zbSo2b/6U8OeNYICADzFaHPc7Pgst8OO4wspXlxtm1ngGi1/UWIXWV//4NmArE=
X-Received: by 2002:ab0:3445:: with SMTP id a5mr16503966uaq.130.1552325104687;
 Mon, 11 Mar 2019 10:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
In-Reply-To: <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Mar 2019 10:24:52 -0700
Message-ID: <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 4:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> =
wrote:
> >
> > Hi Duy
> >
> > On 08/03/2019 09:57, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > > "git checkout" doing too many things is a source of confusion for man=
y
> > > users (and it even bites old timers sometimes). To remedy that, the
> > > command will be split into two new ones: switch and
> > > something-to-checkout-paths.
> >
> > I think this is a good idea, thanks for working on it. I wonder if it
> > would be a good idea to have the new command refuse to checkout a new
> > branch if there is a cherry-pick/revert/merge/rebase in progress (with
> > an option to override the check) as switching branches in the middle of
> > one of those is likely to be confusing to users (if I do it it is
> > normally because I've forgotten that I've not run 'git whatever
> > --continue').
>
> Interesting. I think this would be a good default if we have an escape
> hatch (which could even come later). I often wander off to some other
> branch and go back. But then half the time I end up forgetting I'm in
> a middle of something and just "git rebase --quit" :P
>
> Of course with git-stash (*) and git-worktree, I guess there's little
> reason to just switch away from a something-in-progress worktree. I'll
> try to implement this in the next round, unless someone objects.

No objection here; I like this idea.

> (*) I hope git-stash remembers and restores "something-in-progress"
> status. Dunno. Never used it much.
>
> > > +-C <new-branch>::
> > > +--force-create <new-branch>::
> > > +     Similar to `--create` except that if `<new-branch>` already
> > > +     exists, it will be reset to `<start-point>`. This is a
> > > +     convenient shortcut for:
> >
> > If we're renaming the options to be more meaningful then maybe we shoul=
d
> > consider a different name for this one - it has nothing to do with
> > creating a branch. Maybe --reset or --update?
>
> -C can also create a new branch like -c though. --reset or --update
> does not convey that (and --update sounds a bit too safe). Another
> option is --recreate.

Maybe --recreate, but I don't see as much of a problem with the
original name you gave the option.  Which name is better probably
depends on how you envision its usage.  If you view this option as
only being used if/when '-c' fails (perhaps Phillip sees it that
way?), then it'd make sense to use --recreate instead.  But if you
think some might adopt a workflow where they just use -C without first
trying -c ("create this branch, and I don't care if I made it before
just create it here"), then --force-create makes sense.

Another option, possibly showing my lack of understanding why this
flag was useful in the first place: just drop this set of flags from
this command.  People can switch to the branch and then use reset
--hard <startpoint>, right?  Or (if they don't care about the reflog,
which they probably don't) delete the branch first and then recreate
it?  Not sure why we need to give another way to do these operations.
(In contrast, I see -c as being used frequently enough to have merit
even if it could be implemented as two separate commands.)

I don't have much of an opinion about which of these three is the best
option here (I'm slightly biased towards just jettisoning the option,
but I understand there might be a good reason for it even if I don't
know what it is), so really I'm just giving some food for thought on
this one.

> > > +-f::
> > > +--force::
> > > +     Proceed even if the index or the working tree differs from
> > > +     HEAD. Both the index and working tree are restored to match
> > > +     the switching target. This is used to throw away local
> > > +     changes.
> >
> > I'd always thought that --force meant "throw away my local changes if
> > they conflict with the new branch" not "throw them away regardless"
> > (which is better as it is deterministic). Maybe we can come up with a
> > clearer name here --discard-changes? At the moment --force does not
> > throw away conflicts properly (see the script below in my comments abou=
t
> > --merge).
>
> Yeah if you want to redefine --force, now is a very good time.
> Personally I'd rather have separate options than the "one catch all"
> --force (or worse, multiple of --force). I'll leave this for the
> community to decide.
>
> Adding Elijah too. He also had some concern about "git restore
> --force". Maybe he's interested in this as well.

I like Phillip's suggestion of --discard-changes.  I also like how he
came up with a simple testcase showing one bug each with checkout's
current -m and -f handling; we should fix those.
