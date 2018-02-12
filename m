Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D000D1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754046AbeBLVPH (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:15:07 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:34648 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbeBLVPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:15:05 -0500
Received: by mail-it0-f51.google.com with SMTP id j21so7492784ita.1;
        Mon, 12 Feb 2018 13:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YIgpcCxQU1vE4Ff9ZQ/QyKiD9p/znGnKTnVC1SvXU+0=;
        b=aOFqcNBDcuLHyA23FUk/ZSmGQXRd6WjfloeW5yO0mb3wPtbouFkJehAvJ21ycfcuWj
         E314oB1BqEdXWrE9p7fARPJqDbz+9ZAKO65X26Jty9hO2X+TZ068DARUu5WOcJKfjkjZ
         ooNjezKXaTTqoM/sf2els5yCH2iSQnOeR+TBlOgaVgJ378ZKONw8w4NCzf4hJMqLHoAv
         rSiqI94f9xCuIdr3cwy8TokwrWyo1HZoKZhq0nO9mgeI0wjW97uUK9lEc0L+7VvX2jDZ
         IJE2P/daPlxPzG/YCZUNNaToFot+JHVZpLOImRX6QL4cKrHNUFnbrlwii2dMphBii6UC
         x6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YIgpcCxQU1vE4Ff9ZQ/QyKiD9p/znGnKTnVC1SvXU+0=;
        b=fqbdwgfPmm/UbffjplUtNAY8vWzroIyLvIfbGf5aj5lN5Djz3sTINiijFkdzbcv+7b
         2Ti2EU6LjApsDoFZ+flLe6YvwMlIOwzdm5b8v3YRhbUhZoxOQ+95Qsw4XVJgwdPY7+Le
         +Weo4L7P9+opY/jfkCpM4xqKNsMy258V7Sc2xwk9c/pnbc8t88Drn6guYVZ9x+STTB9L
         +/53WcfUuqHi43c7p5+PqcTcGqJA8seInDM/xB2ceLt2lztwTh61+36SdV/4stYg/zjp
         LK0n2v1I2ADahGtWs1v+QSYjEpR8NOLPE+cfd6q2g6HcsVVE57+XPZQyO77gTbDo1xKg
         m7QA==
X-Gm-Message-State: APf1xPAst24YR485t3Kwckc82Gx5/2MA0lHQzI2MNH+NUBfsuT63vjEn
        hqxCZxvQJ5r70lxUHOxThJnxeGNAYNWVt4KS5cT3rQ==
X-Google-Smtp-Source: AH8x225M6RUYVhMv2eFugdswImcqdLGK/M4ckBrlZwXO31xTmdOuLKInFTwAuIrdVP9sPpnOmbvRi0uXnfXiqeIxgYw=
X-Received: by 10.36.94.199 with SMTP id h190mr6603644itb.21.1518470104821;
 Mon, 12 Feb 2018 13:15:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.135.221 with HTTP; Mon, 12 Feb 2018 13:15:04 -0800 (PST)
In-Reply-To: <20180213080036.3bf3a908@canb.auug.org.au>
References: <20180213080036.3bf3a908@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Feb 2018 13:15:04 -0800
X-Google-Sender-Auth: HhhET1ykQmQ9TZ_zQOooMIkXTeM
Message-ID: <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 1:00 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Linus, this happens a bit after the merge window, so I am wondering
> about the rational of not doing a fast forward merge when merging a
> signed tag (I forget the reasoning).

The reasoning is to avoid losing the signature from the tag (when
merging a signed tag, the signature gets inserted into the merge
commit itself - use "git log --show-signature" to see them).

So when I merge a signed tag, I do *not* want to fast-forward to the
top commit, because then I'd lose the signature from the tag. Thus the
"merging signed tags are non-fast-forward by default" reasoning.

But, yes, that reasoning is really only valid for proper merges of new
features, not for back-merges.

The problem, of course, is that since git is distributed, git doesn't
know who is "upstream" and who is "downstream", so there's no
_technical_ difference between merging a development tree, and a
development tree doing a back-merge of the upstream tree.

Maybe it was a mistake to make signed tag merges non-fast-forward,
since they cause these kinds of issues with people who use "pull" to
update their otherwise unmodified trees.

I can always teach myself to just use --no-ff, since I end up doing
things like verifying at the signatures anyway.

Junio, comments?

               Linus
