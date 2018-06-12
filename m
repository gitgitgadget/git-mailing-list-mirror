Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E738F1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 22:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934918AbeFLWfd (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 18:35:33 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40008 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933988AbeFLWfc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 18:35:32 -0400
Received: by mail-it0-f67.google.com with SMTP id 188-v6so1399271ita.5
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 15:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BsBKOzl9X3Aklh/g5+H/4jNt5veLxUdeYf3Xtj9jyGc=;
        b=mPszENoGbNxcSa4O+ADDIzGzZqxwYxpKAZOR6cquHOpNQvs2nzP4QmN6RX+OreRElP
         Bq+VB70WR21s40hHdoYnGCh9rzJtLBLrBTpP0PBQiYiojWaCv+2IKmEEqyj5jMja6cN4
         X+qPYs5k09suYitqoR1ZO7O+p/n+8C4xxpVgFHhbRhDEbiQJ1ZzqbJKMecZlU4RbHTNp
         qqc9NrWMcWPzbZTwLY00Ss+uUN1/gOWrY6J8Lwa+eemnPrgu/L2sZiHFXsWEip3H27X5
         pBnyqv6kyD59p2JPWcKTZbAeUgg9BiS1/EUrnWG+W0FrK6D+pY144dfCzyJEUZWe06VK
         WV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BsBKOzl9X3Aklh/g5+H/4jNt5veLxUdeYf3Xtj9jyGc=;
        b=i3vRqDRPOQsjgSBtB7+W/bD1MMc+H8Xf/9jMwjKad8mjgnGjzE802L3Q5tP5e+lahL
         KqOFkUsxQpvmr6ptRozHIzw1MW3y1Cw+jFgW3Fp0ok20p/PjQ9HnFH92D2bVuAqtXVd1
         PaLqGeRsMRCsgdvXWt6qpWtMTSo9cl1qRJBYUtbZm7kGGgeJmB0OmHrRBj60G7cCQ8/h
         2xPwpIF3xTYEQtF+ofyW4rociSMilULGrNDpupSQjRUkhaATW7pZKQo2zNeBGsOb9nzN
         Tdb12g3daUIaxHbLY5ml6pKRAs8xGssk1YNCmYQJC2tqk52qw6LhzkhD0h2u0LffaF4a
         6NAw==
X-Gm-Message-State: APt69E06IvSk1OVu7cd1w5YGD6rnmwxStoTJsOUxVXsmMYDJBT2wGd8h
        o1+F+FA1IcpGW8WYlMHOgrT9bWIdZ9WmxDGmwdM=
X-Google-Smtp-Source: ADUXVKIuEgQ69KLSTzDGg75KMgDbF+NXGS5r3lmBmNyqodZh8yfiNE+vuKd5y8lgWWTghV+Lw6Cp+Zy11krMQt2hAog=
X-Received: by 2002:a24:3c42:: with SMTP id m63-v6mr2367605ita.138.1528842931851;
 Tue, 12 Jun 2018 15:35:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad5:50cd:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 15:35:30
 -0700 (PDT)
In-Reply-To: <xmqqr2lb9406.fsf@gitster-ct.c.googlers.com>
References: <CAD-JurLXh=rOC=bhjTa8jCpeDWkbDhCztSpjLuMEUGm1-QnAiw@mail.gmail.com>
 <xmqqr2lb9406.fsf@gitster-ct.c.googlers.com>
From:   Sam Kuper <sam.kuper@uclmail.net>
Date:   Tue, 12 Jun 2018 23:35:30 +0100
X-Google-Sender-Auth: TpGX1H3LBRRDS7FyelWBWGu-GlM
Message-ID: <CAD-Jur+CSfUASSFoXZndEoKvWoc3CU9+V3KrngANskFmQgwNhw@mail.gmail.com>
Subject: Re: `git merge --abort` does not run `git rerere clear`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06/2018, Junio C Hamano <gitster@pobox.com> wrote:
> Sam Kuper <sam.kuper@uclmail.net> writes:
>> [...] It makes sense that `git am [--skip|--abort]` and `git rebase
>> [--skip|--abort]` would run `git rerere clear`.
>>
>> However, if they run it, then shouldn't `git merge --abort` run it, too?
>>
>> If not, then what is the reason why not [...]
>
> I do not think there was any reason, other than that those who added
> "git merge --abort" weren't as careful as they should have been ;-)

Thanks, good to know.

> The command is a mere synonym to "git reset --merge";

Indeed it seems so. Thank you for pointing this out.

> I am not so
> confident that "git reset --merge" should also clear the current
> rerere state.  If (and this is a big if) "git reset --merge" should,
> probably the right place to do so would be remove_branch_state(),
> before the function removes merge_rr file.

Unfortunately, I am still not familiar enough with the Git codebase to
be able to express an informed opinion about this. Sorry :(

> Doing so might allow us
> to lose calls to rerere_clear() individual codepaths of various
> "abort" implementations make,

That, I think, was an example of a garden path sentence.[1] Took me
more than one parse to understand it :)

Anyhow, yes, I agree that this might be an opportunity to DRY the
codebase in that regard. (And this would be a good thing, if so.)

> but that would certainly require
> careful thinking to avoid unintended regressions.

I don't use `git reset --merge` often enough to have formed an opinion
about whether there are any use-cases for it in which it would be
inappropriate for it to run `git rerere clear`. Apologies again not to
be able to be more helpful. I hope that you or others on the list will
be able to consider this matter, and the question of how/where to best
implement the change.

Thank you for your work maintaining Git!

[1] https://en.wikipedia.org/wiki/Garden_path_sentence
