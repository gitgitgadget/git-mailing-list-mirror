Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707F1211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 20:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeK3HuX (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 02:50:23 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:40087 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeK3HuX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 02:50:23 -0500
Received: by mail-it1-f174.google.com with SMTP id h193so5870840ita.5
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 12:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8tqUw4pGg4dS/LtSeHC60c4y1KYyjWPnZ+sAwQkrnZw=;
        b=pakcb37v2iX+X1NPEZDmNIKdjtozIbse4JnqW2QJCZgncUJjBjhBGieLdWrvhh9IFR
         Sz5uvD1zBgPmlsNpTw03XY6KJOLe2/o89iwnkDxLe+Zu2CSoiCtyiYvibxfS4NVT4Qtn
         DjM8JnVZ//zBPUZg38eEHHQ9Hn961XjdLK3X5SET0aoZQeAvNtbOVk7oNz+NtiK6emzT
         tGn5t++FxuKhvurTALX5eE8cBRpMnBhmiHD5pWO7EvSQFUbcWPAQFzKs+pujiGti9u1v
         r5hf3e3t3W39zO1ch3dwNJ5GYeUhl6+08YG/WtiKtGQ9aSIrk2P8gZFGwuaaSEzkKwH+
         n7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8tqUw4pGg4dS/LtSeHC60c4y1KYyjWPnZ+sAwQkrnZw=;
        b=UzDO9v7R/cdfWQdAn/yi5yiJmcunhKqXY4ouEL+tPqyleUDUPQkiDexNPIuNIpz2TN
         2RYm/E6hz44E7szCmpfNSpF7AJT0CpcyVz67CY2ASReXW8iZBils2NSg9h5V9p2cHO2x
         ww9vpoLN8XMMfOex4uY9eemcLBuF9zJetuao2LGwA8g14wc4AubzxFltexMDU3EDcwR2
         TmKDyv5bN8ak24C8qGupjexBiP9I9JoDoeeEXrVmiqqwykh7jXIuxJKpsQ2VL9UVACoF
         uURMK1ENh7iXyYbZdBeKWfN+bv9VADOJFGdilx23qG97ovSW+qXhD8EhQIow5lVG/6y8
         C3gw==
X-Gm-Message-State: AA+aEWby8J29tLa6SYw2WLHm+mnKhS5xYdgRL3SeIVSzVIs92Puj5Ssg
        rPlMn0JN6oktL88hZf+bj4cP4JUb3iSBY6P5nwg=
X-Google-Smtp-Source: AFSGD/Xwrv9jLsIUzqsnhCNPB9tENtCBsAeomiM6cSUbMYH/qjMQ0MlMjPnYJV1hNID9E1oI58kqbAJa6WwANs0MfvY=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr2586799jak.30.1543524221601;
 Thu, 29 Nov 2018 12:43:41 -0800 (PST)
MIME-Version: 1.0
References: <87zhtsx73l.fsf@evledraar.gmail.com> <CAGZ79ka1sjU+rHctRP4SVMP0GQsK2iZghkU46=f96ugqvX5Neg@mail.gmail.com>
 <87r2f3y7a9.fsf@evledraar.gmail.com>
In-Reply-To: <87r2f3y7a9.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Nov 2018 21:43:15 +0100
Message-ID: <CACsJy8A8XyzpMFDTFBaB58-AhDz0d6haacNMNuNEUNjFghYgsA@mail.gmail.com>
Subject: Re: How de-duplicate similar repositories with alternates
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-users@googlegroups.com,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 9:15 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Nov 29 2018, Stefan Beller wrote:
>
> > On Thu, Nov 29, 2018 at 7:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> A co-worker asked me today how space could be saved when you have
> >> multiple checkouts of the same repository (at different revs) on the
> >> same machine. I said since these won't block-level de-duplicate well[1=
]
> >> one way to do this is with alternates.
> >
> > Another way is to use git-worktree, which would solve the gc issues
> > mentioned below?
> >
> > I view alternates as a historic artefact as the deduping
> > of objects client side can be done using worktrees, and on the
> > serverside - I think - most of the git hosters use namespaces
> > and put a fork network into the same repository and use pack islands.
> >
> > Can you elaborate on why worktrees would not solve the problem?
> > (I initially was hesitant to use them as I liked going into .git and te=
mpering
> > with files such as the config directly. But now I cannot `cd .git` any =
more;
> > it turns out the advantages outweigh this corner case that I was attach=
ed to)
>
> This was discussed recently on-list & I chimed in with details about
> that here:
> https://public-inbox.org/git/87po1waqyc.fsf@evledraar.gmail.com/ &
> https://public-inbox.org/git/87muwzc2kv.fsf@evledraar.gmail.com/
>
> In particular the "multiple devs" use-case described in the latter
> E-Mail is what I have in mind. Worktrees are inherently unsuitable for
> that.

Yeah, the separate ref namespace is something I would like to have on
the client side too. I did consider implementing it a couple times but
it's really no small task. Naively, I could achieve that pretty quick
if all refs are loose, but performance would tank once the number of
refs goes over say a hundred.
--=20
Duy
