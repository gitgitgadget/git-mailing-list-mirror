Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889A620248
	for <e@80x24.org>; Fri, 15 Mar 2019 09:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfCOJ3p (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 05:29:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36132 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJ3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 05:29:45 -0400
Received: by mail-io1-f66.google.com with SMTP id f6so7658509iop.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uRo7NULV4bnhSwv02TvOmGb+NrTyERgVjLpwiA5lveE=;
        b=Al5TGYu9Frptg/4detyu+deLTo1nRk2ysqSyVEPoG3JtYXBAkyXNWdKh92PY6r4xIB
         4Q3deygKK2Uf7hcy8UK/jCe5f0A17YLc/hK+Li1jaBAhlF8x1CoPZA6gpm1XyrGcRmTP
         oJHR+rurbdTNF9VK+30IC1mo/KFVzhbYJokwG5zP0fTW3Tln2vLNl2DQZGYjJlHywEUy
         sDMS+PS4jbqMsd78EnWyvTp8/8ABw5ghsg0dLS/4g+nh+C7ZwHWG6OIhLwAecAPXsltF
         li7GOyfCZlzwe87/EnB5yf0Pf93PzTrfIrQUbIqSD+scH/bi22aXqAXHO2G1HMQ0Ii5w
         ZQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uRo7NULV4bnhSwv02TvOmGb+NrTyERgVjLpwiA5lveE=;
        b=bxvPhfC0FfsZDheRYnqrKGbX6vZs6tLF0qMd13yT36AW8asaNm6LccTz0kStvwWY4v
         205jyFavdQvOxZFY5XGB9i4X2wT5okOq5vmrEGKa6EZdrpQgYXqD3Gx5vWPj5Px7jf5Z
         CE8q3nzOVNPVERU4r8B42gIgjQMaS6zJktnZuWqFHkA9v47bjTronxGo0UITX9VwV1Jp
         hlZgMrC+iV1lScYNMGBx1ABpPXhMWqZcUsRJ4Ia6ZDONwD198H2ESJkN0QIvx/tYm4QO
         klS6K5eQfMO0Ngh35UQDMQJGYddcP4mQSD+eiHa7h+B2XXDEljZbWXdqFx+BqPhZBlu5
         mA1w==
X-Gm-Message-State: APjAAAWl162YnmzNZnuVoOSFvAmkmcl9fRGWmnMRUUGITyZwhBqreDU/
        yaQM1EF08aHWePZIbDgqHlMJjq42MJpKvzMwME4=
X-Google-Smtp-Source: APXvYqw07uYG66wF6q2cMWas5/UVIYQVOtt/LUbE1eDkzK1bTB4C0YJGm9lmcA5NtXfnn3zUTXQkObERNN6r+ykTs8k=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr1332009ioa.282.1552642184229;
 Fri, 15 Mar 2019 02:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-18-pclouds@gmail.com> <20190313183604.GA27503@esm> <CAPig+cQPMZhd-JSxD4Z6pL19qB1bFNu+EvPDh0vADpcaJ0tbqw@mail.gmail.com>
In-Reply-To: <CAPig+cQPMZhd-JSxD4Z6pL19qB1bFNu+EvPDh0vADpcaJ0tbqw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 15 Mar 2019 16:29:18 +0700
Message-ID: <CACsJy8CG1-6Fp72451fwVRVHuYchLqU0uda=AJbK_aXvhW4YmQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/21] switch: no implicit dwim, use --guess to dwim
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 3:19 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Wed, Mar 13, 2019 at 2:36 PM Eckhard Maa=C3=9F
> <eckhard.s.maass@googlemail.com> wrote:
> > On Fri, Mar 08, 2019 at 04:57:48PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
> > > Similar to automatic detach, this behavior could be confusing because
> > > it can sometimes create a new branch without a user asking it to,
> > > especially when the user is still not aware about this feature.
> > >
> > > In the future, perhaps we could have a config key to disable these
> > > safety nets and let 'switch' do automatic detach or dwim
> > > again. But that will be opt-in after the user knows what is what. For
> > > now give a short option if you want to use it often.
> >
> > As I am late to the patch series (sorry!), has there been already any
> > discussion on that? In my experience, people get confused with detached
> > HEAD state quite often, whereas the automatic creation of a local branc=
h
> > is no problem.
>
> This statement does a good job of articulating my (unspoken) response
> to this patch. Whereas a detached HEAD might be scary and confusing to
> newcomers, and difficult for them to recover from, automatic creation
> of a DWIM'd local branch doesn't seem so problematic (if at all).
>
> With git-checkout, it's very easy to accidentally get into a detached
> HEAD state, so it makes some sense to protect newcomers, by default,
> from that accident in git-switch. However, auto-creation of a new
> local branch is not, for a couple reasons, nearly so weighty a matter.
> First, in many cases it may be less likely to happen since it requires
> presence of a corresponding remote tracking branch. Second, it's
> intuitively easy to recover from it: when git-switch reports that it
> created a new branch, though perhaps surprising, the user would
> naturally know to look for a command to "delete a branch".
>
> And, unlike a detached HEAD, which newcomers may mistakenly believe
> lead to irretrievable loss of work, an unexpected branch creation
> carries no such penalty, perceived or real.

I can't remember the last time it was discussed, but part of the
reasons I chose to default --no-guess is because completion will be a
lot less noisy.

But that's a very personal preference. I will switch to --guess as
default no problem (unless someone jumps in and screams NOOO of
course).

Please don't hold back when you find something not quite right. At
least now I can fix it. Either that or by the time it's released, the
Internet will blame me for adding yet another confusing git command :P
--=20
Duy
