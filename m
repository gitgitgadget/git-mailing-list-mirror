Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFA5211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 06:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeK3R6D (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 12:58:03 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:36579 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeK3R6D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 12:58:03 -0500
Received: by mail-io1-f51.google.com with SMTP id m19so3704498ioh.3
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 22:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4f/aHnGyvQH3pVIHuMAExuS6voLSDEC2Hu682LIwp/Q=;
        b=Kle/T64g9yJDmmDR0xh6B6fHuHL48J27SqgTgdXoUZTqC0aoWyD7MQRFRgoXsprbDT
         Ny+qUw40xnvI/2rCYIS6B7aqae1tsDbPcoa71FIl88/f8KsQMlX0ZPrzqfDLEmbPsYVl
         ElCVLNzP4H6Lb5dyB5Tjb0KLm+H8jn1H3UiUcKh+2UtrWN8NeyhMm7qAc7Zbc1+XMyH7
         c8s1tsq7VbDai4211F1/EhJS+VJZa64/2ITaLjwtM6m3+bEwQu+Q2Wb6QUa27qnnuQqc
         vrC6LWkmFFu3VTjNUdH9JM88oCj5CflDC0MfPQMdKCVY+dZ4LWrpR/RukGfajjW4LDpW
         WvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4f/aHnGyvQH3pVIHuMAExuS6voLSDEC2Hu682LIwp/Q=;
        b=DaECj1ZvY5cv2SI57HI65hL5pBUfHNvpR2qppSnwHM+o47WdhfroL+64kh0r6Ip5pV
         1RE6q1ExkKJdcUsijRU2SwWiqsa/REIIJDXvrheezyvmDOqDMnyxZ8PXBUvp0SKXgqw7
         +1HNGUKy0U94pS+qA5hMYbT9ozCceDk0YzRM3cj3+3ZU4gYwHnX4dc1B91U8/PnV4DHa
         F3Diq726OwCu/XTx3ALE2rWy28TPZucRS672h0NNGyW+0Ek0HC/sGCsDYNlJIGRiBPub
         y3KHPVEcyCglDr+ehS9G9krROgazeFY32GL8aTda/JK2seVJcOqXkk0dmP1Ld2G6xE4t
         Gifw==
X-Gm-Message-State: AA+aEWZPf3cWXu2+F+VKqFOKDVHzOJMRp5cD8QHqNn3e6+IDFxjxjr/N
        Y6D1URipuENpPzH4fGNzueGjE7co4X54op7ZuJQd6w==
X-Google-Smtp-Source: AFSGD/UvUisV6s+bHRHH/dZnWcw8ZkgL8esbN0Muph1mFkRiw3niwnIVa0CYIELLN7kAT05q0WYyeWJDsca4twmwLTU=
X-Received: by 2002:a5d:944d:: with SMTP id x13mr143210ior.282.1543560586779;
 Thu, 29 Nov 2018 22:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <87pnunxz5i.fsf@evledraar.gmail.com> <340837B7-3004-44F7-9A30-BD3A26876D76@fabulich.com>
In-Reply-To: <340837B7-3004-44F7-9A30-BD3A26876D76@fabulich.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 30 Nov 2018 07:49:20 +0100
Message-ID: <CACsJy8Dg06DbbSLuuVHKgQUwHXqqVZLjbmkdkN=m=Vx-QeP6zQ@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
To:     dan@fabulich.com
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 30, 2018 at 1:16 AM Dan Fabulich <dan@fabulich.com> wrote:
>
> Other thoughts on a global UI rethink:
>
> One of the most common complaints I hear about git is the conceptual diff=
iculty required in undoing changes. https://ohshitgit.com/
>
> > Git is hard: screwing up is easy, and figuring out how to fix your mist=
akes is fucking impossible. Git documentation has this chicken and egg prob=
lem where you can't search for how to get yourself out of a mess, unless yo=
u *already know the name of the thing you need to know about* in order to f=
ix your problem.
>
> A significant fraction of the top-voted questions on StackOverflow are ab=
out undoing changes. https://stackoverflow.com/questions/tagged/git
>
> What if there were a 'git undo' command that could unify the answers to a=
ll of these questions?
>
> git undo stage
> git undo rm
> git undo edit (checkout files from the stage)
>
> git undo commit (prompt the user whether to revert or reset)
> git undo reset
> git undo checkout
>
> git undo merge
> git undo pull
> git undo push (prompt the user whether to force push back to the past or =
whether to revert pushed commits)
> git undo rebase
>
> git undo undo
>
> git undo clean
> git undo delete-branch
> git undo delete-stash
>
> Some of these would be trivial effort, but a lot of them would require fu=
ndamental changes in the way git operates. (You can't undo a clean right no=
w because the files are just destroyed.)

We're getting there. The biggest problem I have is how this "git undo"
should work, not the changes behind to support it. For example, if I
pulled then did some rebase, what would "git undo pull" do?
--=20
Duy
