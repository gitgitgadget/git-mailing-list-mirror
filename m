Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650A91F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeBTWkc (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:40:32 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35783 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeBTWkb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:40:31 -0500
Received: by mail-wr0-f172.google.com with SMTP id l43so18866851wrc.2
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Vn9wicvkZ+WNvtJtihmOCJ+Vsz5Wovty/fIZdKD0VM=;
        b=pu5NlR5/b3GWCj9uyDclSLog+7TUUAElH8DHAHUJAEnbMSoVBEoX+tkq3S+RMK2qUR
         5exvoVvgBrCmvlok3Ylp1909CfkqCioo9/WVAcCQcL22SFbclzywXq3MLie+1RygbuWc
         lNJqFdlRo2KbwgYkxkKTPtlPO9RJceO7909XywawCR2zbiV1Tb0PVWwny7TbozShRPmT
         8NLyq07wynRgITvEjlKm9BgDWMAQbUcQnRDwouSE6XU+uT4sKr1lAcUelXlpFVjPI7SU
         H3UEwqysYRADOtxd+kB+/Bo5pihzS5RTmucZ1+LglL8FIeyjyciZ/s5x+9ABbQL8d9GA
         9SMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Vn9wicvkZ+WNvtJtihmOCJ+Vsz5Wovty/fIZdKD0VM=;
        b=QqohNcz23jP8f+D++RwEYLyIpYAywwU+5/w7/gEgHeYo8v24J2UBCAY7AdoC+/iZvK
         3fjg7WRk8Or/fK2dfQ8863MuLOTdNTHpbl+pQn5cA64f1VGb5ISNTzyrlE25jH04OVi9
         TDN2QFCh7jiI6Qbcwvy70lQNF5CiTWoMIoK0ikdhyBOlOBhvR0q6iAfUFeI/FZw6zCwB
         WJ0kMcqk8fiVzy6Rz5vufWEcXxZsAPv2peCoy1epvcPXst79dqRKf2JVkOGdHQgACr2h
         BAaNn3L3Sqz9xGW6jBPajdd5D7QqRyZ5d8XcQLvTe1zdlNKSWJSY5R9qxF4eVYQH85Lw
         eU0Q==
X-Gm-Message-State: APf1xPD3tMtIhYHgN7Vo0KfHMRsEM8L0aq/qHF0Qi7QwNYuZ1WggolUh
        KBwtovetlgtyiUusRx0AfMA01DplxfAsx10QQlQ=
X-Google-Smtp-Source: AH8x2260XnJkJT0NOF+t9u9AAwrlsF093s5MlRWzB9DTPHWNldb4JO49yFSTb/GzvQUzCyyTBkJyEO7S9TS8BgS6U20=
X-Received: by 10.80.220.70 with SMTP id y6mr2176006edk.236.1519166429907;
 Tue, 20 Feb 2018 14:40:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Tue, 20 Feb 2018 14:40:09 -0800 (PST)
In-Reply-To: <20180220205603.GA13721@sigill.intra.peff.net>
References: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com>
 <20180219223653.GE6619@genre.crustytoothpaste.net> <CAE1pOi070p9VNPnLS3jSXp7TrbR2fhOc7sx+58exAp92k4D0dw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802201147300.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <nycvar.QRO.7.76.6.1802201240010.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180220205603.GA13721@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 20 Feb 2018 14:40:09 -0800
Message-ID: <CA+P7+xpWi0kekTM3aJ4VnxtVh0DpGb_U2D6=cUCqz0XqvYwJTQ@mail.gmail.com>
Subject: Re: Is there any way to "interrupt" a rebase?
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Git Users <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 12:56 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 20, 2018 at 12:44:51PM +0100, Johannes Schindelin wrote:
>
>> > It might be even possible to design a new subcommand for the interactive
>> > rebase to facilitate a variation of this strategy (possibly even making
>> > use of the fact that the interactive rebase accumulates mappings between
>> > the original commits and the rewritten ones in
>> > $GIT_DIR/rebase-merge/rewritten-list, intended for use in the post-rewrite
>> > hook).
>>
>> This feature might look somewhat like this:
>>
>>       git rebase --replay-latest-commits 3
>>
>> and it would not even have to look at the `rewritten-list`. All it would
>> do is to put back the latest `pick` from the `done` file (in case of merge
>> conflicts) into the `git-rebase-todo` file, then insert `pick lines for
>> HEAD~3.. at the beginning of that todo file, and then `git reset --hard
>> HEAD~3`.
>
> Keep in mind that the "pick" lines could be "edit", "squash", etc.
>
> I think the general form of your original email's proposal is something
> like: What if we had a "git rebase --rewind" that could "undo" the prior
> command? So if I had a todo file like:
>
>   pick 1
>   edit 2
>   x make test
>   edit 3
>   x make test
>   pick 4
>
> and I failed at the second "make test", then I'd have:
>
>   pick 1
>   edit 2
>   x make test
>   edit 3
>   x make test
>
> in the "done" file, with the final pick remaining in "todo". Could I
> then ask to "rewind" my state by moving "x make test" back to the
> "todo". And two rewinds would get me back to applying patch 3, which I
> could then fix up and re-run my test. Or four rewinds would get me back
> to patch 2, which maybe is where I made the initial mistake.
>
> That's a bit more primitive than what you're proposing in this
> follow-on, because you'd be doing the replay yourself (unless we remap
> the commits). But it's very easy to reason about and implement.
>
> Anyway, just musing at this point. I haven't thought it through, but I
> like the direction of everything you're saying. ;)
>
> -Peff

Using a --rewind that simply tracks the point of each history and can
reset back to each seems a bit more inline with what the original
suggestion is. Sort of like "undo" in an editor might. You could even
add a "rewind=x" so it could go back more than one step at a time, tho
just re-running rewind until you get where you want would be doable as
well.

I like the overall direction of both these suggestions.

Thanks,
Jake
