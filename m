Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864611F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 15:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeK0CVt (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:21:49 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37435 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0CVt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:21:49 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so28264537iti.2
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ms57SHTHodoDzarhavru9UejPBoDO85OxxrUFrcz0E4=;
        b=aM2VATRCP616kZ591bJJRzCtoAlLaPIrRxKBgzlkwZA8/cTel4vtZ/PqcKEYXtIP4S
         b6LLrJrrLqGljmEPNRqE1rse7mAaIbEEh0x3cg2eUSlX+jUvQ4asknhDBH2Qxfl0UDTW
         SuNf7PzsTiEnrOOUe7dlwwMo8dus18NoSev5pPjIrFgUheQmfjuBJVKnzlTUT0uXDkui
         4zqBRL2lJ/0JtUdXqPdLxbCMSLsafQK5RaK8ysi5YX+cSJ8Yngz0Rjy9bx5uHqSm8sbr
         FeZ/RNfbq3IFRSbXptXZW3ymsvzb9uHqNvR7JwDEE2xh8NJXbkllqL/aL5MeY2QZIymN
         9f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ms57SHTHodoDzarhavru9UejPBoDO85OxxrUFrcz0E4=;
        b=NF5WtL8q/yI7eujNj7dNdfqW3CHSUKYHOr507FBS+eLb/1vgFh/nkHcLxfPBt6AqJ0
         MhUZWpgR22OX4wLJAqlX7aK5krYVx13BgxVfftcM1bOOMPPCokbqGwK8ahkUNn//H4g6
         AY2GTB+GuWQBO0/NJwBGBLxFvmV9gpf+HoiZzNkqKLhHUTRaVUDzDNNtmu7IsSk3Icct
         gm327hylamJM7AqzupFLWPcnm3Bf8Qeygxd3pAH+QPcQQKrZw2iRB6xKzykV7NZFfMLt
         DRyrpKvFg+YL7yxXwaDq8Mr5Z41X1Vn+s/Do9gXrno2HFIL/ppdZLRfrj4Y51yMt1WGm
         uaLw==
X-Gm-Message-State: AGRZ1gLIHuRv5cEAbeB7xEnDt9n4k3JXE31etiz6sPgY1rIb+DoUCa04
        udcoQrar55NiUwu5yAgWxNLUYi0qF4F+cevYNwI=
X-Google-Smtp-Source: AJdET5fA0AJrnvHVccIn7lrp5WBBn9CdFX9MAOTNSlgS2wLWGQCGJtwcC6Tc75N8zosIKCpb7hVBBAh6l9apFYW24i8=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr24809848jah.130.1543246041916;
 Mon, 26 Nov 2018 07:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com> <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
In-Reply-To: <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Nov 2018 16:26:54 +0100
Message-ID: <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     per.lundberg@hibox.tv
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>, git@matthieu-moy.fr,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 10:30 AM Per Lundberg <per.lundberg@hibox.tv> wrote:
>
> On 11/13/18 1:22 AM, brian m. carlson wrote:
> > This is going to totally hose automation.  My last job had files which
> > might move from tracked to untracked (a file that had become generated),
> > and long-running CI and build systems would need to be able to check out
> > one status and switch to the other.  Your proposed change will prevent
> > those systems from working, whereas they previously did.
> >
> > I agree that your proposal would have been a better design originally,
> > but breaking the way automated systems currently work is probably going
> > to be a dealbreaker.
>
> How about something like this:
>
> 1. Introduce a concept with "garbage" files, which git is "permitted to
> delete" without prompting.
>
> 2. Retain the current default, i.e. "ignored files are garbage" for now,
> making the new behavior _opt in_ to avoid breaking automated
> systems/existing scripts for anyone. Put the setting for this behind a
> new core.* config flag.
>
> 3. In the plan for version 3.0 (a new major version where some breakage
> can be tolerable, according to Semantic Versioning), change the default
> so that "only explicit garbage is garbage". Include very clear notices
> of this in the release notes. The config flag is retained, but its
> default changes from true->false or vice versa. People who dislike the
> new behavior can easily change back to the 2.x semantics.

How does this garbage thing interact with "git clean -x"? My
interpretation of this flag/attribute is that at version 3.0 by
default all ignored files are _not_ garbage, so "git clean -x" should
not remove any of them. Which is weird because most of ignored files
are like *.o that should be removed.

I also need to mark "precious" on untracked or even tracked files (*).
Not sure how this "garbage" attribute interacts with that.

(*) I was hoping I could get the idea [1] implemented in somewhat good
shape before presenting here. But I'm a bit slow on that front. So
yeah this "precious" on untracked/tracked thingy may be even
irrelevant if the patch series will be rejected.

[1] https://public-inbox.org/git/CACsJy8C3rOFv0kQeJrWufQQzbnfU4mSxJtphEYBGMmrroFFN-A@mail.gmail.com/

> Would this be a reasonable compromise for everybody?
-- 
Duy
