Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302D81F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfBSO6Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:58:24 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53356 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSO6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:58:24 -0500
Received: by mail-it1-f194.google.com with SMTP id x131so6647315itc.3
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lz2qEn4a6wel24zPDJKRhWnjZvkekBk+f9fvX8U53BE=;
        b=k9CS1oU9WWoyA20pnCA/CrTX3UDrn3pJpjSgYITBTzjhd3xsPgR8NVohJ5yg8EVfsp
         QZx7tg4Xy2Is3u9FrF/wwv/2feRhVSHOCnLzdG+C1Toq/h3mZZN0zAUizWlprjSz+/HU
         uzZEakcV3X6CdO23jOCy5boaHpO3WNetKH4rSUV3dNMQ2KE9SfVAOyA5dyAIRE0QPse5
         +eulaFXO7WuZ9r3LLRnt7mUu3k4LoWBQ/SIsT0xyx2IWiBgmxMpL/tXD/CcRjxyKKzC1
         f002IexiZTkAaY+MB+IpvOVlBfPbNPU+c2iF6/y8nzBPBShZ8Cn4l+RtTtu5aIuCTKJt
         /THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lz2qEn4a6wel24zPDJKRhWnjZvkekBk+f9fvX8U53BE=;
        b=kapi7BDBDz+d8+cFskgtou0CdB9z4pJmr8RveY/Pnvq2SXdbTqGPmlGnznupXABT5G
         G96USalt+EtM0Vt1DsYUzCgJN/x3JSXk4CzpQlWrTYW3wW9oofnfJwkg7RmrOVaCp5q3
         pP3Aez2j5Vwcw3rkwqaNSDhLWuHWl9kZpyoJv6MguEi7lRP19a6INithwgF7+8qn5GFU
         CwapQBsblyMz4g91/qUOyNXhy4BOEJv8aA+ifJOB3pbcxrzFEJMTb5ryYau/mjsV9jdn
         KW05SmwEVqoKnGie+uuofWj4wLMyA53MXNblXnJVuA9Nf/TuPRC6ReAQoiYk4nJaACOJ
         lZCQ==
X-Gm-Message-State: AHQUAuYqh7SGysQuFcUrvvMX4mDRQw/u2cgePddHlA22jbpBztz7ol3N
        aAjjD4at1DrsZvkgAh5axAk6C5jIML/x3xaUcbo=
X-Google-Smtp-Source: AHgI3IaBOvZq8ctM+je+t7h3S17zjxRhNv41YEZmdyfNs4qw9N3g4znCG/d/Jtpyw8N/dqYs4nCqlLaQoV2IzEZjUeM=
X-Received: by 2002:a24:c056:: with SMTP id u83mr2068398itf.10.1550588303438;
 Tue, 19 Feb 2019 06:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com> <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
 <CABPp-BGkJOgKqE_vHsA1fkjQ80U10Hv7-HCvScq7WOgj1UF9=Q@mail.gmail.com>
In-Reply-To: <CABPp-BGkJOgKqE_vHsA1fkjQ80U10Hv7-HCvScq7WOgj1UF9=Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 19 Feb 2019 21:57:57 +0700
Message-ID: <CACsJy8AqcCgMLObhpgPmWV261c1zQaaZNHXOO8w_VXMoW0pm0Q@mail.gmail.com>
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

On Tue, Feb 19, 2019 at 9:42 PM Elijah Newren <newren@gmail.com> wrote:
> > OK this hopefully will be the final design
> >
> > (git restore) "[--worktree] <paths>" restores worktree paths from index
> >
> > "--index <paths>" restores the index from HEAD (aka "git reset")
> >
> > "--source <tree> (--index|--worktree) <paths>" restores index or
> > worktree (or both) from <tree>
> >
> > I'm a bit reluctant to support "git restore --index --worktree
> > <paths>" without --source, which should default to HEAD, since it's a
> > bit unclear/inconsistent ("git restore --worktree <paths>" defaults to
> > index as the source, but here we use a different default source).
>
> Sorry for going missing a while from the conversation, and thanks so
> much for pushing this forward.
>
> Overall this looks good, but there's just one part that confuses me.
> Here you seem to suggest that if you pass --source but neither --index
> or --worktree that both the index and working tree will be written to.

No no. Sorry for not being clear. If neither --index or --worktree is
given, the default will be --worktree. --source changes the "source"
but cannot influence target selection. So "git restore --source=HEAD
foo.c" will restore foo.c on the worktree but not the index. I still
remember that point you and Stefan Xenos raised ;-)

Full git-restore.txt is here if you're interested. I think I'll send
it out soon once git-switch part more or less settles.

https://gitlab.com/pclouds/git/blob/switch-and-restore-forever/Documentation/git-restore.txt

> Why are "restored" changes considered ready for commit?  That seems
> confusing to me (and was one of the bugs of checkout, IMO).  See also
> second half of https://public-inbox.org/git/xmqq1s6yezk3.fsf@gitster-ct.c.googlers.com/
>
> Elijah



-- 
Duy
