Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8AD20248
	for <e@80x24.org>; Wed, 20 Mar 2019 13:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfCTNxO (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 09:53:14 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38700 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTNxO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 09:53:14 -0400
Received: by mail-vs1-f65.google.com with SMTP id h132so1510692vsd.5
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVNKyfmU2zRgAZ2Opj5Gny60xy9Yd/9QuH5k+fiOZno=;
        b=EAAvK9GQjzvzUexcABVb3k/tvORQhxPBOI+Bm5C6HYgadR5CBvXKL6RKeXFfL65vBw
         ie2wBaKJs4XaFdbd54zHlyjsSnP724+CfVnARpGJTxCY+y6C+gZhDSw1rTlR6d1szIfA
         0RPSKQ/5Nh4gb0iLS/JKJ56GICbUFRWzoVu5dzKG0ePqUEJOj/5ar1jzHzSpqCnpT6o/
         vjfih4psntk3TNQ0EWqUlfhocnAdZi/SYL2H1+4RKb61dQmsGeX7xFpkQtjLRqiEY9Lq
         lTFxZGRqeTQGUr5Jo2GgImpyHBwGxppHUryrDgr4vXTAOPbYK3DoNW3bc+DmGK8IT6wr
         0ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVNKyfmU2zRgAZ2Opj5Gny60xy9Yd/9QuH5k+fiOZno=;
        b=A/Ba6BBze/Dx1HCBrFexJwy2LQ+MCzAfcuG5qgmee9lDowyo4sT9veum3IilZWgNPU
         +VFfI73bRsTVJVztE1qPQE4MdBCWsw1NlUe3xo7L19WkaU3qQNYvSI7uDa6rtWDOhCrr
         c34cmKUvOS+UA7DtuGbrBUpphU57TQtg68nYyPk3Pv6Cwwh946OYIPEaoExjHtkQjhRn
         YUIuopERa9SkbvSUdTRpNw95ILhVD6oV0OWoOAQ8WO+FPjhDH/Z1xVCQ0wuKWJH7kXGh
         gLYdhSmAa4gCqpxITGjI40p/VwWu1MxltP5D0/VvaNOTKHPwXjYnn7EArlTfNlO++hyg
         UiDg==
X-Gm-Message-State: APjAAAU5DlrVHhdM94NAJ3ziWh3d1XcYcVomAbI4BbfYv5t0mlW/BwgX
        Tp4b61TEOXOkg+MnID6wYtvtCP1RZ7NYQhLWmas=
X-Google-Smtp-Source: APXvYqxRuFVPmtL9/tdGFZEqPguCjznzDxvKNcySSe4HAZKSGcfnmdJAzEYd4DH9Alsax1oTo5tLEeNyg5Mk/xtgT9c=
X-Received: by 2002:a67:ad0a:: with SMTP id t10mr2919086vsl.117.1553089992926;
 Wed, 20 Mar 2019 06:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
 <20190319093910.20229-1-pclouds@gmail.com> <xmqqimwexujm.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BLxWea0ZrHkSU6+nE7dr5YvFNVH1tLhaqPRadi+2Hhwg@mail.gmail.com>
 <xmqqk1guwdeu.fsf@gitster-ct.c.googlers.com> <CACsJy8AUH4nOkt6H=yu=eRktK4me9kEkjqsC3zyNZDwUKXqCPg@mail.gmail.com>
 <xmqqftriwbz6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftriwbz6.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Mar 2019 07:53:01 -0600
Message-ID: <CABPp-BFB0jafua0CGEsr66EzQvHncLYvws8rt+LdkQ_LXcEq5A@mail.gmail.com>
Subject: Re: [PATCH] checkout.txt: note about losing staged changes with --merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 19, 2019 at 7:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > Kinda. But "--force --merge" makes no sense. --force discards all
> > local changes by definition, which means you can't have conflicts and
> > will not need --merge. I think this is the reason why we die() out
> > when both are specified. So we need something like
> > --discard-staged-changes-only...
>
> At that point, I would have to say that we do not need anything.
> The use case is already covered with "git reset && git checkout -m",
> isn't it?

I guess the problem is just that 'git checkout -m' has not refused to
run with either a dirty index or a dirty working tree, and if both are
dirty (making us require more of a four-way merge), then our three-way
merge has to have some kind of casualty in the implementation for at
least some case.  The current casualty as highlighted by Philip is
that newly staged files before the 'checkout -m' become untracked and
any carefully staged pieces before that command are lost amongst the
unstaged changes again even if there weren't any conflicts.

One solution is to just accept and document or warn about this
shortcoming for now as Duy did in his patch.  Another is to do as you
mentioned earlier in this thread when you stated 'I think "checkout -m
<otherbranch>" with a dirty index should refuse to run'.  Duy linked
to a third option that I outlined in his commit message, though it'd
require a bit more capability from merge-recursive than we have today.

So, I think we do need something (eventually at least).  Would you
prefer we dropped this patch from Duy and instead made 'checkout -m'
abort when the index is dirty?
