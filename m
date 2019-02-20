Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C723C1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 02:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfBTCcj (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 21:32:39 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56156 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfBTCci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 21:32:38 -0500
Received: by mail-it1-f195.google.com with SMTP id z131so11695683itf.5
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 18:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEqV9KKchqj20GsMZh5fN79Z8vzWR7iUCQiCpO16194=;
        b=LcH9TN55SwmjAq29ksWyDAAkTEHfDA4BavDOEFiH2u20u0YPSH1ISJQQzhoMXw/q3f
         PdDgk2Mot7u6bxC3O0My0o+DLv58xhU4NMPTWm26qalIaHC6J0HmeyDXPuSe+l3lmEDf
         MUla7LLO3bpjYOG5w0r9fOk+e/Iao6ik+aMXJ1HCWhFXoVot43fY3o1YNImvnrzNjEmz
         TPZVFirJoha71hU5+8igHb+FiQe7qFrpviTqDFcAdYov9Jf4PE0IHfg9b+Tg3u8SHdLz
         5EA+2aYWIXKisKbxSJAg6U5smTwSDIFK7X3XFH6HpuyaZnQRECahFPaWaqmTbyLKVJfN
         yBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEqV9KKchqj20GsMZh5fN79Z8vzWR7iUCQiCpO16194=;
        b=fqQlsogy7g7QqNBEdGJleTrXafM7SxvntZtlAF0NJSw6g4gjNbiGV9lYVq2joL7ifU
         occJAR/+UNm7KvZIJlgjqgM1xXLe+NviubEMfW4kyM2xvzGwTYW8eTQQshsyieMe8m7P
         l0/rk+kaRyUrWEveUHm8agemqmdg5DmQmq5end7XANkTftXyoS+O4U6QRADSGoFkhLoj
         GPfbnvSfG/B72P3xXamBAicXsTLe2CaTSw6mrbovd5SU5uq2/jdU6zgwo1aY0sWJ3Mq+
         MzZqnC0pRKGpp4Nb4UpgdE0lfB3wYEvwmDEiuPN6ZjJ/4xg8+NlWN5qKxaSzcXejgZ8p
         aobg==
X-Gm-Message-State: AHQUAuZOyPjPoq3sZOaUMrjxZOZnT2HFC8xeW52+OOIqd6jO3IdA3sib
        I1oyKl8IspYXQ50rrKG4zqrIg3DCg1NDjCZs+tY=
X-Google-Smtp-Source: AHgI3IbwiajVVwILiLKyk/12F5i5MOPG2kYJLyUeMqb8MGmX2nqJwWS5mqeMaDoDf47bHHr3ri9pw0JAiYaBLqK3fnw=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr4089582itk.70.1550629957509;
 Tue, 19 Feb 2019 18:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com> <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
 <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com> <xmqqo9771tnj.fsf@gitster-ct.c.googlers.com>
 <CABPp-BERuEtdjHhqaao+2=rsLXiPdkG4SbeULQ6=59hgWS5BLg@mail.gmail.com> <xmqq1s431kf0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s431kf0.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Feb 2019 09:32:11 +0700
Message-ID: <CACsJy8AkbWPx10w2vQYhywk4HbEfVaAZ4vDr4X=pvsLDK6DkvA@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 5:29 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, Feb 19, 2019 at 11:10 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> > I am getting the impression that to save typing, you would want to
> >> > make "--index --worktree" the default (i.e. among the above, only
> >> > --no-index and --no-worktree need to be spelled explicitly), but
> >> > there is one glitch.  Updating from the index must be spelled
> >> > explicitly with "--no-index --worktree".
> >>
> >> And after getting reminded by Elijah, the default pair is
> >> <--no-index, --worktree>.
> >
> > Why would you want --no-index or --no-worktree as flags?  That seems
> > to presume a default of modifying both the index and the working tree,
> > as these names imply undoing pieces of such a default.
>
> By "flags" I think you mean "treat them as two orthogonal booleans"?
>
> It was just how I read Duy's examples (especially the "both --index
> and --worktree given" example where "--source <tree>" becomes
> mandatory).  I do not have strong preference either way myself, but
> I tend to think that treating these as two independent booleans
> would be a way to make it clear that the new design departs from
> what we have been doing (i.e. "--index" means "both", "--cached"
> means "index only" and if we were to introduce the "cat-file -p >"
> variant that would be called "--worktree-only"; in these, there is
> no "two orthogonal booleans" that can be mixed---instead they come
> premixed).

There is indeed inconsistency in "git status" advice with my patches,
where it suggests both "git restore --index" and "git rm --cached",
both operate only in the index but with different option name.

"--index --no-worktree" is one way to deal with this. Another way may
be avoid --index in git-restore and use another name like
--staging-area or something? That avoids the name clash, and we could
even add --worktree and --staging-area to "git rm" / "git apply"
later, deprecating (but still supporting) --index and --cached there.
-- 
Duy
