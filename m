Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C727C1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 03:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfBTDwb (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 22:52:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52408 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfBTDwb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 22:52:31 -0500
Received: by mail-it1-f195.google.com with SMTP id r11so12108074itc.2
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 19:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nezX/ohiwECinffb7er2EE9/vr7JXP7qCNdBNXfYyek=;
        b=kgqckKZKjkMYZsNM7BBh5x81wX6RUHpgntsFCALiYjOLjyBIxXYGXYHj2xvmgGyR6K
         vfwtsKiGVqIV/5Ds7Ekj+26UYV6w+lnSfsNP6qYxXzM80I4x1/FokCOkObms/fo3htjT
         qSffVVdkHFKbI+BaweDMK4x1xQ6LS5oXd9y4AyAQCq3VLL+lze1HelrvoMSp41Bc+CIQ
         yBcDmjBpNlIyLAJ31HsSaUgrN76LJsgC4Wbnr0DPxq68tvqZ0nocSMlcZuBx+eDGn45w
         LdYn2qyNIVdZtONiV0v8V+mYtXqqJnT8zATxdJLQysCI56bDc+bfa1YOzA7vzbRMla9v
         ITMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nezX/ohiwECinffb7er2EE9/vr7JXP7qCNdBNXfYyek=;
        b=QXPZw9tMaSax9bRgusCyUAFnOZtHJm81e5AlThvngsTiHiZZ+VXeALTvff1a36Vn0s
         ZOba9pghRERn34yh1w8RtkXywQD1Zy4tsnNLa/KFggFr0xkvFvkRc9sfiWzkJJJE4KCA
         FCHNn+ko14lQ86ilDQ5WIfLdgizAK5ApcyO+Z4TaMSwQbvun6rj88aAOrJSYayTqQqBN
         w546TRzxldf/y/cXI7fb1Mdr7huweg0Og8FjwMX+v4hMzhuiLb2kdast8gDuUzHebj69
         F6JPI23ooQZUAtJ2utBkTUbl6vRAqQHkqsNArLttIfYHs3FWVWhuRhhjg1dbbkBNbS3d
         oGwg==
X-Gm-Message-State: AHQUAuZZ150gKViqFvvkBl/7kBYsvpptLRJkkNWDWW5zdWhWrvoAhxcS
        7Cky2JVUlDRS6eEa/XF3uH9efHB6o8AFdR3sOUk=
X-Google-Smtp-Source: AHgI3IbFQ4byKdF4U8TPqVEMTaf1C0k1Dlv9w1lAGnTONdjbJlz1Cw2J+pN7U0RcLyCdacS9sc75zbS49t3hZ6PqAL0=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr16472806ioc.282.1550634750430;
 Tue, 19 Feb 2019 19:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com> <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
 <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com> <xmqqo9771tnj.fsf@gitster-ct.c.googlers.com>
 <CABPp-BERuEtdjHhqaao+2=rsLXiPdkG4SbeULQ6=59hgWS5BLg@mail.gmail.com>
In-Reply-To: <CABPp-BERuEtdjHhqaao+2=rsLXiPdkG4SbeULQ6=59hgWS5BLg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Feb 2019 10:52:03 +0700
Message-ID: <CACsJy8BbBx4jrmUKsDOEGcQay5FuGfc0DzCUjkYKLaq21yimVQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 5:05 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Feb 19, 2019 at 11:10 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > I am getting the impression that to save typing, you would want to
> > > make "--index --worktree" the default (i.e. among the above, only
> > > --no-index and --no-worktree need to be spelled explicitly), but
> > > there is one glitch.  Updating from the index must be spelled
> > > explicitly with "--no-index --worktree".
> >
> > And after getting reminded by Elijah, the default pair is
> > <--no-index, --worktree>.
>
> Why would you want --no-index or --no-worktree as flags?  That seems
> to presume a default of modifying both the index and the working tree,
> as these names imply undoing pieces of such a default.
>
> I'd rather have a flag like --worktree which alone only modifies the
> working tree and is presumed to be the default (but useful to be
> explicit or as mentioned later), have a flag for applying the changes
> to the index instead (--index?), and treat applying to both the
> working tree and the index as unusual and require either both flags
> (--worktree --index ?) or some special flag that likely has a longer
> name (--worktree-and-index?).

I'd prefer separate options. I even gave --worktree and --index
shortcuts so we could write "git restore -IW" if "git restore --index
--worktree" is used often (and I think it could be an alternative for
"git reset --hard HEAD" if --force is also specified)

> I _think_ Duy does the latter reading over his manpage that he linked
> to, but maybe I'm just reading my own biases into it.

Nah you read it right. The "examples" section also shows it.
-- 
Duy
