Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59551F462
	for <e@80x24.org>; Wed,  5 Jun 2019 10:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfFEKR1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 06:17:27 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37738 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfFEKR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 06:17:27 -0400
Received: by mail-it1-f194.google.com with SMTP id s16so2653430ita.2
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDnyd2rDiKG34osrrZZLyM3HLwI/Q4zDnMubOBNu5vs=;
        b=KioWXB698IMBd9EcHXF+fRFVC29kf2sCoUKfTOTIdPhjSlDlcR5Ri8h4SgCbqP+ryN
         RPBQL1R3oYm8re/ZMT5d6ZeTmdJVe1Lji/I3dYS7ipoQ3LpdhQryVPEntFgkEytI7H2Y
         zfAmbLt5AUqc3FGZB4jhU0i4qI80uTrfQ4+zzN89awBLYw2qEUHgxILQVB6rvbk1/W5p
         T1f3io37EaWqMO1L1oIPLGTFbXhDgDy+uBJdWk5RPhYvjZ+hUrRVudszRvEiNuaz3Kkr
         voNPHZo5I+ruKWpWMKbXt9EPhEle9ay9XctnOo6P9HU3MJ3cPy9/b5/Ze1kT48ZoT8e5
         Jgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDnyd2rDiKG34osrrZZLyM3HLwI/Q4zDnMubOBNu5vs=;
        b=UyknZ/fQlyLggG4F7FMJsOPC8RzVll8x2SKVGLEIZwZGykvHorDnCNCsZwSSpAHXh2
         MovWEkZn+p6QdKxgaa92Z24mrWPFcwgB+zlXi6TK1HfHtpsmv/aHulubOimhMre0Td3j
         dHIP/leIvTkL3KYB8V5d56vQVrgrS7g6PbvtCDAn93cHm8MonVtHSmFz7dc+qBf4x/2G
         fbr7lB64OD9+GqhENFg/zeCDjLfLph3dQ6fs8w1ALXLb7QsbZ79pxvyv4PN6LzCKOKm7
         HdutAmC4I94FSD48hIvnC+IC1/C7GNKHY2VK9fuaoAA9Oiz+YzAMNAduZvqcVZwS1yL3
         Gfwg==
X-Gm-Message-State: APjAAAXsFSvSwHClk/is2LxQhPMD4lcYYl6C9yxfbo5UPwwuLX3T2eE8
        Kjven6H7pk6qOgyQVyHmf1QbqjNd6ZjW/8EExc9hTg==
X-Google-Smtp-Source: APXvYqyPlnQXgwqJ56uo1AoiVVm5iv+1R1SVEXZmmFEMivxf9HPkPFKJ7u87bwNFqweEKXyZfk9HMeT9+7shh67xub8=
X-Received: by 2002:a24:2448:: with SMTP id f69mr18583479ita.157.1559729846783;
 Wed, 05 Jun 2019 03:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <ad2ff81a-d75e-1ac4-07d0-c807a2ed9e36@gmx.de> <CAPig+cSsNQDe-3GLnmvA+EPior=RSPETJDjkCc7X1qi6gWSGDQ@mail.gmail.com>
 <CACsJy8CxSN90-EfTpkd6RUHFVp2iGjZXokpMqw7Tf0EMXT5LfQ@mail.gmail.com> <CAPig+cQ0po+cqdqohkVqFyk=aowtjuYGM2J=31pFu6ZuPeAUFA@mail.gmail.com>
In-Reply-To: <CAPig+cQ0po+cqdqohkVqFyk=aowtjuYGM2J=31pFu6ZuPeAUFA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Jun 2019 17:17:00 +0700
Message-ID: <CACsJy8DiueSPST64=iCZc=V6UtU61RXjJqhBHvG59BwFVSh3QA@mail.gmail.com>
Subject: Re: worktree add already exists
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ingo Wolf <ingo.wolf@gmx.de>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 4, 2019 at 1:32 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Jun 3, 2019 at 5:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Sun, Jun 2, 2019 at 2:11 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > On Mon, May 27, 2019 at 11:32 AM Ingo Wolf <ingo.wolf@gmx.de> wrote:
> > > > I would like to attach an existing dir to git (make it a workdir) and
> > > > then update the index with git reset and checkin the differences.
> > >
> > > I haven't thought through the possible ramifications, but the actual
> > > implementation might be as simple as changing this code in
> > > builtin/worktree.c:validate_worktree_add():
> >
> > Coming from "git clone" background I would still expect --no-checkout
> > to abort on non-empty directory (i.e. we always start at a good known
> > state). Maybe another option can be used in combination with
> > --no-checkout for this. And do we want the same option in "git clone"?
>
> Taking a potential use-case into account, it might be more appropriate
> to compare this suggested behavior to git-init rather than to
> git-clone. Say, for instance, someone downloads a "tarball" of a
> project (with no .git/ directory), experimentally hacks on it for a
> while and then decides that that work is worthy of being submitted to
> the project as patches or a pull-request. One could imagine that a way
> to accomplish this would be to "git clone ..." the project, and then
> "git worktree add --no-checkout /path/to/my/hacking", followed by a
> series of "git add ..." and "git commit ..." invocations to formalize
> the changes into discreet commits.

Or you could just git-clone directly to the place you unpacked the tarball.

> This is analogous to how you might start hacking from scratch on a new
> experimental project before you know if it will pan out, and before
> you know if it will be worthy of placing under revision control. If it
> does pan out, then you "git init" the existing populated directory,
> and follow with a series of "git add ..." and "git commit ..."
> invocations.
>
> I'm not sure how common such a use-case is, though. I recall being in
> such a situation once or twice over the years, but that's not
> necessarily a good metric. So, I'm not suggesting that such a feature
> should or need be added to git-worktree, but the above thought
> experiment perhaps provides some context for possible behavior.

Yeah I'm not suggesting we do anything immediately either.

I still think though that we should change --no-checkout behavior.
"worktree add --no-checkout --keep-worktree" is quite readable (and I
assume this is not a popular use case that people will have to specify
both options often)
-- 
Duy
