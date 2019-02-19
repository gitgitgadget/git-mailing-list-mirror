Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DD91F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfBSOmm (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:42:42 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37312 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfBSOml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:42:41 -0500
Received: by mail-vs1-f65.google.com with SMTP id s16so11841360vsk.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 06:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJBWBqfIl12hdRC8EWBfnMk18uIyZrcdj4NOCDS+dus=;
        b=Nze11WRqt5iao2zTqNdxDyUK6D6JUvMQT6JgYMHplcdprB2VqCLjFWVQ87UpKoWZm1
         dr4u8lV5MrLuSgrqkL/cSCp+KFOZAOhF4o9aWgQVBSthfccxjd81EFfyLu0hLhAMt2+n
         el2ezM3IjftcARWwddBdjQvKbYMJRSlv3NYblyLjYqniiFuMzrlfB26fo7d8+OOFU9GU
         pHzs8jWEybuCgU9TDUmKwaqShAyUCrgiv+9rHsUI486HS7h/WHohikT0EJyfOpoCssjg
         8IuVZMZUBzf2yqI7Wtbyq+vGajN6rXMU1fNY+vD0oXwtPOwps7E/vy2l1h2lM8jGn6Fb
         av7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJBWBqfIl12hdRC8EWBfnMk18uIyZrcdj4NOCDS+dus=;
        b=q6CcAFjRbTJPVDPemk+4NhxuD/Nyl+9BWqwNj/6gHzd6hHyK/K25pDLWfi9bEAY7Sn
         r4dBEOAr4LeadEuXMLeU85yy+ey8p/sA/PB06H5TAv3IJPNqgX52x/THrYnMlg1KVQ1G
         1Y0V4MnduBw6vDSE9nMEkUgu+z2KopaKsYOEgu6cA6ek1KyRDInSgbNf5f/wwCIDB4TQ
         29T4q4gG9YyQcaEbtpN2PRjLF08S/KyzpYsIDq6oeXeCYLgAl9OHsduyt3o+XoVU73I+
         Mi+9QkQURS7aVnHCJ6P2EG9vABKvti/EW08+Czfo/ezm399ctrH/Ej7V/dXxKzka+2ub
         2DAg==
X-Gm-Message-State: AHQUAubwfL47uC5gouuDS+VD3cB/Ukok82nEsWWqspJzRk6vFblVBSO5
        fGjmJQU/8nj6jf2XcK4BmMm/J7QXphJnBVQvxWs=
X-Google-Smtp-Source: AHgI3IZ1PLL//yy1bh/01SRvReXY+4T7tt0MWOJeB9tETJS7nwY7IZJ6sRO9MS+Xz01rJSMbhnPKlOA9cFiKPymgLBw=
X-Received: by 2002:a67:3052:: with SMTP id w79mr6374977vsw.116.1550587360278;
 Tue, 19 Feb 2019 06:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com> <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
In-Reply-To: <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 19 Feb 2019 06:42:29 -0800
Message-ID: <CABPp-BGkJOgKqE_vHsA1fkjQ80U10Hv7-HCvScq7WOgj1UF9=Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Mon, Feb 18, 2019 at 8:21 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Feb 2, 2019 at 12:57 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Duy Nguyen <pclouds@gmail.com> writes:
> >
> > > Of course we could just do --index and --worktree, each option
> > > restores the respective part. Then it's combinable (and extensible in
> > > the future). But then "git restore" means "git restore --index
> > > --worktree" and typing "git restore --index" effectively removes the
> > > default "--worktree", which seems a bit twisted.
> >
> > Or "git restore --no-worktree" (essentially, instead of saying
> > "keep", say "no" to mean "negation").
> >
> > Incidentally, "git restore --no-index" does not have a counterpart
> > in "git checkout", but I think it is probably a good thing to add;
> > as it has to do far more than "git cat-file blob $tree:$path >$path"
> > these days.
>
> OK this hopefully will be the final design
>
> (git restore) "[--worktree] <paths>" restores worktree paths from index
>
> "--index <paths>" restores the index from HEAD (aka "git reset")
>
> "--source <tree> (--index|--worktree) <paths>" restores index or
> worktree (or both) from <tree>
>
> I'm a bit reluctant to support "git restore --index --worktree
> <paths>" without --source, which should default to HEAD, since it's a
> bit unclear/inconsistent ("git restore --worktree <paths>" defaults to
> index as the source, but here we use a different default source).

Sorry for going missing a while from the conversation, and thanks so
much for pushing this forward.

Overall this looks good, but there's just one part that confuses me.
Here you seem to suggest that if you pass --source but neither --index
or --worktree that both the index and working tree will be written to.
Why are "restored" changes considered ready for commit?  That seems
confusing to me (and was one of the bugs of checkout, IMO).  See also
second half of https://public-inbox.org/git/xmqq1s6yezk3.fsf@gitster-ct.c.googlers.com/

Elijah
