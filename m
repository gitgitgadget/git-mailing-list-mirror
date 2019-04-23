Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A72F81F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 02:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfDWCUu (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 22:20:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40033 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfDWCUt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 22:20:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so11982729ljq.7
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 19:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YIhEHZFBm6Zvbue7VVjShDD/GPJgBrk0VSITGsiRk4=;
        b=tcxx5bLh7nBv8ZJgNvF00Er0XWVdwiE+GG2XKWO33/PqwRnZj2d0+JXUbJauhlM7P+
         or2I/3QBwEQDkB8VhyPrFW2H978+lqJKt1pVo6A4w9yqkfy4CYM50kSPg/vZtS/1cij9
         JsYqvAF/czRYzscIBZy7OcdZVJqzKn6SblYNTSFOZ7bX1qOHVmKjIDki/MIQESFLjQS1
         O7MNDH5UeaeZYbhrVRuAqv/I2JeV2pINU8rrwvdtorI3jmGA73kokYj11NtYHfuh6gKt
         6WFYvtCT+LBggFpbJhMfKOaP6E/rwX5ToA2SSHePC4eMvq/ApEVf7rTBTVsa3UKcg+0l
         +O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YIhEHZFBm6Zvbue7VVjShDD/GPJgBrk0VSITGsiRk4=;
        b=Okv2HzkwETGgUyWtTW3UoFhzCQ8PKq+iVAmgNnPetDhvltMWLHO0g7iTjPpMVN9V1I
         L3e52JOaLE403OvjKPQkRFH0UNhoAvY9DqqgrpitN6Gt+/81UhKBtEtLU92vy+fuSoEU
         yeBq6gFewdCm07Vw9U44aA1YpBM0bK/3PMtqwJW9C4kxuMSYHRZrxK68f1IHkSinbWSF
         gXfXhki/qknVrjVcZ0lIev6rz+bUpArUkXFSX/zqUfkWt7ZgdGdtFnfTicrXtGfLfEI5
         FacaTTJth5iMr3LxwZP7QaaolhOHfWV2XOGo90opbnaj6/dekYmfrGeJJtnhq/JCIVnA
         Jaww==
X-Gm-Message-State: APjAAAVuWF1rClIDM4phHHWQJsv5bcSLySqUGJcauMMILa4geZaAklyv
        ZGAUB4z+N6W5D1mMyUVs9GPM6t0yO4JoW/gtnck=
X-Google-Smtp-Source: APXvYqyFp6PVcH6BDgLif5zZZxeRw8LTs9LppxPc9g2S/mb/IsGvr/BpHLllWXOvyYZ75fkXFbCaVEXQuTJtQKBh5pM=
X-Received: by 2002:a2e:8703:: with SMTP id m3mr11561020lji.107.1555986047759;
 Mon, 22 Apr 2019 19:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190422000712.13584-1-phil.hord@gmail.com> <xmqqk1fm9712.fsf@gitster-ct.c.googlers.com>
 <623d6ebd-60c4-916d-6295-4c648dbf3932@gmail.com> <xmqq4l6p7bz7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l6p7bz7.fsf@gitster-ct.c.googlers.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Mon, 22 Apr 2019 19:20:36 -0700
Message-ID: <CABURp0rLg=E6MT9Ld5EXpk127PURYMPdP9Mgo7duyerO-yCPOg@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] rebase: add switches to control todo-list setup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git <git@vger.kernel.org>, Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 6:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Doing "git rebase -i master" and then editing the todo list has the
> > side effect of rebasing the branch. Often I find I want to amend or
> > reword a commit without rebasing (for instance when preparing a
> > re-roll).
>
> I am not sure what you mean by "not rebasing".  Are you talking
> about --keep-base that uses the same --onto as the previous?
>
> I think that is often desired, but I do not think it has much to do
> with the topic of the proposal these two patches raises.
>
> And that (i.e. "this has nothing to do with the choice of 'onto'")
> was why I used the casual "rebase -i master" in my illustrations.

I know exactly what he means, because it usually is exactly what I
want to do here.  In fact, I almost always want `rebase --interactive`
to do this "in-place" editing of the history.  Sure, I may want to
`rebase @{upstream}` someday, but I seldom use --interactive for that.

Rebase invites conflicts.  It's nice to invite as few as possible at once.

P
