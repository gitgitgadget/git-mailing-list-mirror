Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269611F609
	for <e@80x24.org>; Wed, 28 Nov 2018 19:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeK2GVO (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 01:21:14 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39917 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeK2GVO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 01:21:14 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so6017396itl.4
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 11:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UStLfy87swufedMfYsYM+sa1xfAqdfoM6tcLX711FZM=;
        b=pWt3Knucy4kNe9MIHyDipoZnElmvF+TUj5pXMOHlNv7jDY4ExIjDMEo0xUR1pyKE2Y
         HLQhqQF6b1yVr+KREuztQEzPHVd/KTSOYU6lk87rZkBzHxmsWfNwsHnOKAv2TXmLHkB2
         KiHQEYSnkrDGejxGNZirNQgGM3ZURiy/IvZEBIrSSEZ9Z2R6p/EgQi+pRp2SEUhE2PYk
         Jd0jaQ84+rlLZ5Q5bB9m6oMRsREJcfOQ3UQwxaYm47245FB9tVvxxVwBGWoMhNbC7BXO
         8ZUelfVjx6bLIdnB3otoeLrxkj9SPR49IVpHKl77wPhuMR/fwXrzntTEhmeAGVBblhNb
         PjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UStLfy87swufedMfYsYM+sa1xfAqdfoM6tcLX711FZM=;
        b=Syp3w557VmA43erxKvI5rrBk2ZiE84E17HG/C8yUScqs9OTDQgUrbaaN6jqvWqNfda
         aIwGEd4QBvo20nbI7keL+7v1SbaOMZ3DtUyIw6R7grO7VeHPB05lR6UqcIozO/MWimkx
         xSqOBEJ/A+SEIMZc0juAQxR80K22r2gyZJzywPAcZc9TCU7FvqzvY73Pn4Mu1WI/zA08
         /JphZWM1dUM+ZUR2bvaOjgkZImnu9dbcD4bLreJeuFXIbkzm+4qWD/JyGpFYRu6sLtgf
         +dIs+E3WIKttmHCpsJZdF6yGe87w0aDUd+wz7XoxFSQ9dsHA9c0/i+I5ZC6qQnZHAC52
         X5EA==
X-Gm-Message-State: AGRZ1gLrZ4viYugLQml3uy/984RFeWMKDLfstIQmEwBJJ6RNzn/wjaBr
        SeNaa+eSuGcJDX+gncIApuJ9sS9NfCdAXId0qT4=
X-Google-Smtp-Source: AJdET5eH9nsCBaYdWAsv/2zPkMy2qaSPxsVsmLOIEMAHm2EU4Gpb1yWZw63bGohMnrMdBuTVCHY9bkvDc9dKD4guIpU=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr32223775jak.30.1543432712641;
 Wed, 28 Nov 2018 11:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com> <CAGZ79kbWqfMHZeYFXNh00N5xSSkW0_Mzja1EtuzxQxrhESoZxQ@mail.gmail.com>
In-Reply-To: <CAGZ79kbWqfMHZeYFXNh00N5xSSkW0_Mzja1EtuzxQxrhESoZxQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Nov 2018 20:18:06 +0100
Message-ID: <CACsJy8AUogchEBhgv5mqUnr7drHwFdRFSNzwLoqrw7RSeNBgDQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 8:08 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Wed, Nov 28, 2018 at 7:31 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Wed, Nov 28, 2018 at 7:03 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> > >
> > > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
> > >
> > > > The good old "git checkout" command is still here and will be until
> > > > all (or most of users) are sick of it.
> > >
> > > Two comments on the goal (the implementation looked reasonable
> > > assuming the reader agrees with the gaol).
> > >
> > > At least to me, the verb "switch" needs two things to switch
> > > between, i.e. "switch A and B", unless it is "switch to X".
> > > Either "switch-to-branch" or simply "switch-to", perhaps?
> > >
> > > As I already hinted in my response to Stefan (?) about
> > > checkout-from-tree vs checkout-from-index, a command with multiple
> > > modes of operation is not confusing to people with the right mental
> > > model, and I suspect that having two separate commands for "checking
> > > out a branch" and "checking out paths" that is done by this step
> > > would help users to form the right mental model.
> >
> > Since the other one is already "checkout-files", maybe this one could
> > just be "checkout-branch".
>
> I dislike the checkout-* names, as we already have checkout-index
> as plumbing, so it would be confusing as to which checkout-* command
> should be used when and why as it seems the co-index moves
> content *from index* to the working tree, but the co-files moves content
> *to files*, whereas checkout-branch is neither 'moving' to or from a bran=
ch
> but rather 'switching' to that branch.

OK back to square one. Another thing I noticed, not sure if it
matters, is that these two commands will be the only ones with a
hyphen in them in "git help". But I guess it's even harder to find
one-word command names for these.
--=20
Duy
