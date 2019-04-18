Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B86920248
	for <e@80x24.org>; Thu, 18 Apr 2019 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbfDRKU2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 06:20:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51074 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388382AbfDRKU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 06:20:27 -0400
Received: by mail-it1-f193.google.com with SMTP id q14so2521766itk.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mzqBr5zqDRpbTnVD0UEPHfnc8OaQmUbPJyoeBDPu6S0=;
        b=WYkenXN1nhbAXPDCDF53bLDXoQrR491vCuqT3GwFqe6r4JzeFBpH3kvbv77d5xCkdo
         W57IjN3JiYtIWi30CvH1bTcBmxPPPKGUo3alvW3EDD9FukKmHdouLJ+hMl8z77oW4Ckv
         Z9kt7cplYIH0X5//eS6rFrg6OKmUUUQeG1YFfWHgFuIckcyz3DRiGhNyXmQ1eY+ILdm9
         j/0TkEK73nuPnKeqQgBAm8TECT3PBVQbh1NDJ+OKUi40g2N8azEZn8YZdizCeAcnZPkZ
         eMw6O3H+b8DbA3b7FBSKSZDjDTmFZMWUkhRbyfB9q25XSNsfti4vTiloFVPcmmF1ohye
         4bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mzqBr5zqDRpbTnVD0UEPHfnc8OaQmUbPJyoeBDPu6S0=;
        b=Anqw/ZF6u88jEJHknctkY0fsODqJpoqmX8nmIX8mSIrhrkQT976EQUG/8K+ZIQYxAR
         lQr3gW2odpahSGNQvKrhAcdyLSm89xXh7DLnfcF1cBmcJNr+EenLZYo6JZ4jK5W1bw/a
         28buq61YD5wjIoKcmkjZr8+AGQLoWDc5ktqoSxVylmokHnRFHRIzgrxp3OKiNMX7qZ9H
         ZdrWYPAwpRLTfZ4G5FexDdhjy9Y4NucPpXKhqXJ8b5vAwAv9bLNlJRXDgj/7GDRm9hBf
         yGdFcgFSRBPG9dV9npWFIwFcH7sd8mFpHj4brVNJ88XPcCxoEl8q1pQjqBgrnPEYc/du
         oifg==
X-Gm-Message-State: APjAAAWp3vj9lMBJ8pJnH+vEUz9/WonWIfKdIOSMc4QW/zieLLN2NLdO
        EbLDsMK8BcL+2dg/8Bm07N4ewhA4W8QvJ5pkTYY=
X-Google-Smtp-Source: APXvYqw4wBy69BCrXLcgNWa+RSJk66C5TrDWDiyCXKNstbWBj2Ob9Nbzp6icz80yz7hmJQXZdlwJU8LE0zdwcbXzOSI=
X-Received: by 2002:a24:5493:: with SMTP id t141mr2347452ita.10.1555582826699;
 Thu, 18 Apr 2019 03:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190411131218.19195-1-pclouds@gmail.com>
 <CACsJy8A9xfR7FheOHUoywNz_D7W1X1fv=mUBz-uu82CGZqYfVA@mail.gmail.com>
 <xmqqa7gojggg.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1904181201180.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1904181201180.46@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 18 Apr 2019 17:20:00 +0700
Message-ID: <CACsJy8DR6gkzuvY71ka-4F0=1ZzHpc5pux7tCidqyw_dehqBuA@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Add new command 'restore'
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 18, 2019 at 5:03 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Thu, 18 Apr 2019, Junio C Hamano wrote:
>
> > Duy Nguyen <pclouds@gmail.com> writes:
> >
> > > On Thu, Apr 11, 2019 at 8:12 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
> > >>
> > >> This is the companion of "git switch" and is based on that topic.
> > >> This command peforms the "checkout paths" from git-checkout, git-res=
et
> > >> and also has a third mode to reset only worktree, leaving the index
> > >> alone.
> > >
> > > It does not have to be done now. But I'm just wondering, does anyone
> > > think adding --dry-run is a good idea? This command is destructive by
> > > default, so careful people might want it, I dunno.
> >
> > Yeah, "give --dry-run for anything potentially destructive" may be a
> > good general principle, although we'd need to know where to stop.
> > For example, I am not sure if "git reset --hard -n" would make all
> > that much sense, as the sole point of running "reset --hard" is "I
> > made an unrecoverable mess---get me back to a clean and known state
> > no matter what" and in that context, "let me see which files in the
> > working tree will be removed and checked out of the tree-ish and
> > which paths in the index records a different blob than what is in
> > the tree-ish, before deciding if I still want to stay in the
> > unrecoverable mess or I want to get out of it" is something you
> > could request, but at the same time, there is not much point in
> > actually asking it.  Of course, a --dry-run that is not used often
> > simply because it is not all that useful in practice is fine to have
> > as long as it works correctly---I am saying that it's not something
> > I'd personally prioritize myself.
> >
> > It would be an excellent addition to "restore-path" (and also to
> > "checkout [<tree-ish> [--]] pathspec") to give "--dry-run".  Not
> > just because it is destructive, but because unlike "reset --hard",
> > it is selectively destructive.  Having a way to make sure that the
> > given pathspec touches only the paths that the user intends to
> > recover from the tree-ish or the index would be valuable.
> >
> > But it is a new feature, and I'd think it can (and probably should)
> > be done as a follow-on series outside the main series you have been
> > working on.  Let's make sure that we have the basics ready by the
> > end of this cycle.
>
> Since this command is supposed to make our not-quite-user-friendly
> command-line interface a lot more user-friendly, I think that we should
> take a step back and think very hard about a way to make this recoverable
> an action.

backup-log can handle that (or at least provide the foundation) and it
even allows to recover from accidental "git reset --hard". But since
I'm not going to resubmit that again (I'm done with thinking hard
about "git undo" or overwriting ignored files, I do not have the
answer), I'll let --dry-run rest in peace.

> The recently discussed project to make `git stash` handle unmerged index
> entries should be a good step in that direction.
>
> And I do not think that it would make a lot of sense to advance this
> feature prematurely, i.e. without this safety hatch firmly in place.
>
> Ciao,
> Dscho
--=20
Duy
