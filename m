Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_RP_RNBL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4811F453
	for <e@80x24.org>; Tue, 19 Feb 2019 23:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfBSXA6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 18:00:58 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45122 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfBSXA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 18:00:58 -0500
Received: by mail-ua1-f65.google.com with SMTP id e16so7547938uam.12
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 15:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xH5nvhfmZNqymkwlWqKOCy0kbMDV+Dd7nbQndk+/7c=;
        b=oyyinwv4gjsNjrpPDCsQ9DrGJIHvDjjLQA2akZS0h6PMpQARbek/E/6utAh2iVP6oI
         wLCkYdzaFvciXJLmeYcONDGBjmQoiumiShgZCrLh1tjEZrUCzgc6VerhkCn3ySRV1Rbq
         qt7FjN7O+Hbtp8W22InVajB7T+TEa9ZXCuc22auuQp039SRdI0r0RoFM36+/MVmEPNTh
         uowhcQGN+peBZAojaLjyV15hc8pubZfkXLFwO2hI5pqRDmqhiCUnvjSLfD+Ogaugb6tu
         P5tRH/qZZa7ZwW4zgkiOOEhUkv7Own89I4MGQx7uGklm6Fd/MLwXoXkw8/iBOGL04v37
         VHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xH5nvhfmZNqymkwlWqKOCy0kbMDV+Dd7nbQndk+/7c=;
        b=HkMUKDrWjn5CSjxGQ/qhoKXgG/a70vQIdBdm/PjAjzupvlX8O7wPfj2fp2gLZussoZ
         C0zbLxlnIdjTLV8rtOs6upi3AyRU9yij8yxiLKfOi/mNQR6mep1tB/LS2NNkZqn1GEkj
         VgMxrEXqVrRl21fcQ1yBGmxOfBDqqgqL2oEAIbwBoRv6cCJTerHPVBzosMKlY9gPXnBG
         07rnlTmpIY43HJNQ1vObk54uZqn+KQl+Jh1UK08AllJ4ASMrFkRdipMPCUFmHVSmac+y
         KZarHO9bf0rxreMRb/KlbyfVWqEvaO6XyTq/cFHWSeetAXXAmjYln14+hif7dV32LzDc
         HobQ==
X-Gm-Message-State: AHQUAub5e4x67meCQ+VuzyJpGaeyi2ZiKSLrydbQG0mVPpnZjfbIZNnL
        EvUgWfmMAGBUgjVZMxy0NVr6ubjQx9g0M5IfL9U=
X-Google-Smtp-Source: AHgI3Ianhs65iS+4rP9WuH/1QPKlwSmYjWhklQs5oulPwFt6UFhYuUFG0w5I3ign0uIJvri2SPhr3Mls7YBh3qUY4DM=
X-Received: by 2002:a9f:3205:: with SMTP id x5mr11301752uad.104.1550617256957;
 Tue, 19 Feb 2019 15:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com> <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
 <CABPp-BGkJOgKqE_vHsA1fkjQ80U10Hv7-HCvScq7WOgj1UF9=Q@mail.gmail.com>
 <xmqqsgwj1ts9.fsf@gitster-ct.c.googlers.com> <CABPp-BGp53DrP6=FpYpxy5cmWkcygCz_nrunXisC55KV1ydyXg@mail.gmail.com>
 <xmqqsgwjz9q1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgwjz9q1.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 19 Feb 2019 15:00:44 -0800
Message-ID: <CABPp-BE19yVzDife5PqdQGmKrwrffoOt2KzBisgbqxaGry7LBw@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 2:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> As long as worktree-only mode does not lose track of a
> >> previously-untracked path in the index (perhaps use the i-t-a bit),
> >> I do not have a strong objection against making the worktree-only
> >> mode the default.
> >
> > Could you unpack that for me a bit?
>
> Suppose in an ancient version v1.0 there was a file called
> README.txt but these days such a file does not exist (there may be
> README.md added though).  By default, the command does not stuff the
> contents to the index out of the tree and instead operate only on
> the working tree.
>
>   $ git restore-path --source v1.0 README.txt
>
> At this point, you are assuming that README.txt will become
> untracked and the user needs to manually add it.  I was asking if it
> makes sense to at least make the index "aware of" it with I-T-A bit,
> and I am leaning towards answering "yes" to that question.

Ah, thanks for all the clarifications (for this and the other emails).
Your suggestion here would mean that --worktree alone wouldn't
actually treat the index as read-only, but I too am leaning towards
the thought that it makes sense to set the i-t-a bit for such cases.
