Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678921F453
	for <e@80x24.org>; Thu, 27 Sep 2018 17:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeI1ATQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:19:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41222 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbeI1ATQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:19:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so5850184edd.8
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mcT19AiTN6rNNhGxqmHpuE8JyeXrcfH+GGt+YxT4/mU=;
        b=KzaS+Ni0HJbQscokS8zSnni0lnH+YR1huWCf/6ARn4MVUBgUpBbVrOAzd7gYo98GbQ
         ZidExzVkWSQdPrg+jfmmy2D+Zs4lu8Gx+yuoJT9iIR5DY0KnBoKmNPdviCXSWgoFLw5H
         kkVW3v57oFGRJTT86T7GhVkfSz6/eoIp+zi7czEjcIpvAalc8QqWZ8g6ise7Hx2JW/1t
         6IiqkFQWuD785bWa+ZFDiRiUq3xFYOF+iD3TfJPvONHeEc2uC+LNv86xbPr2UMQx71Fi
         bIRBqLoEpEJKJG9shMkTKuNre/qzUJNF273qFJCbKfvsTpU72cUdrQYrnU7ZJnxdzZbi
         5iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mcT19AiTN6rNNhGxqmHpuE8JyeXrcfH+GGt+YxT4/mU=;
        b=TQpixUdGU6LNZddfMAXAs0KfSRfaQQYapmpdh5De+M2FWkhfMh2QwGg04RTY1xIOJP
         zxNgNMOtgYiDe5Pp0yuj/6aF9aemDhOkfNA0jY6kcCoeyYzNY9lXijHyR6lC547PheNe
         MSf6S1VHNWMlkWZO5IIHw0SrigQZotoGYhy2STdDOxUc+r7HvPWtECjTwN74/mCg2Dis
         Uf+U4I1NlR3oEURxTySOqdKXoNBRuGzV1Tzudwu5guL+cWnxE24HkkZyJwS68pDgLuIO
         gM66prSII4s7tV1Wjk0KkC1TZcjPdy1aA9vZToK+LBpD8bVdNOZ2N/pvaAg50eoUlt0h
         4Jmw==
X-Gm-Message-State: ABuFfohpINX28RS1MoMZAqi9bXlSYSWA1EwCKa9Du3ULqkqqqDcbxWaB
        AUAtpSehi3Ul6wHYrjj/4M98FFYsMHg=
X-Google-Smtp-Source: ACcGV61aA32IX18SIvIugC6VuL9JbetZlTXGj87egef34ltAYvPYpEtT/hMxuAgs6gPCadLxIEOn5w==
X-Received: by 2002:a50:998a:: with SMTP id m10-v6mr19898656edb.7.1538071188396;
        Thu, 27 Sep 2018 10:59:48 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id e8-v6sm209728ejm.75.2018.09.27.10.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:59:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] branch: colorize branches checked out in a linked working tree the same way as the current branch is colorized
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com> <87y3bnhs5a.fsf@evledraar.gmail.com> <CAC05387S9P+w8yqqcjkQDnURYSgQmqtukxS4KvqJu-kDA+_o0g@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAC05387S9P+w8yqqcjkQDnURYSgQmqtukxS4KvqJu-kDA+_o0g@mail.gmail.com>
Date:   Thu, 27 Sep 2018 19:59:46 +0200
Message-ID: <87sh1uizxp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Nickolai Belakovski wrote:

> Will do re: screenshot when I get home, although it's pretty easy to
> imagine, the git branch output will have one other branch colored in green,
> bit without the asterisk (for one linked worktree) :)
>
> Also will do re: changing comments to /**/ (didn't know // was from C++,
> TIL) and I'll clean up the comments to remove some of the more obvious
> ones, but I'll try to keep a comment explaining the basic flow of creating
> a nest if statement to evaluate worktree refs for color.
>
> And yes, I copy/pasted into gmail. I was having trouble setting up
> send-email, but I think I may have it figured out now. Should I create a
> new thread with send-email? Or maybe reply to this one (I can do that by
> specifying the Message-ID to reply to right?

You'd run git format-patch master..your-topic with
--subject-prefix="PATCH v2" and
--in-reply-to="<CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>". Then
it'll show up in reply to your v1.

You can also for an easier experience do this via GitGitGadget, see
https://github.com/gitgitgadget/gitgitgadget looking at its code it
seems to have some way to reference a Message-ID, but I don't know how
to trigger that.

> This is my first time using this workflow, so I appreciate your
> patience :) )?

No worries, happy to help.

> On Thu, Sep 27, 2018 at 8:33 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> wrote:
>
>>
>> On Thu, Sep 27 2018, Nickolai Belakovski wrote:
>>
>> > In order to more clearly display which branches are active, the output
>> > of git branch is modified to colorize branches checked out in any linked
>> > worktrees with the same color as the current branch.
>> >
>> > This is meant to simplify workflows related to worktree, particularly
>> > due to the limitations of not being able to check out the same branch in
>> > two worktrees and the inability to delete a branch checked out in a
>> > worktree. When performing branch operations like checkout and delete, it
>> > would be useful to know more readily if the branches in which the user
>> > is interested are already checked out in a worktree.
>> >
>> > The git worktree list command contains the relevant information, however
>> > this is a much less frquently used command than git branch.
>> >
>> > Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
>>
>> Sounds cool, b.t.w. would be neat-o to have some screenshot uploaded to
>> imgur or whatever just to skim what it looks like before/after.
>>
>> > diff --git a/builtin/branch.c b/builtin/branch.c
>> > index 4fc55c350..65b58ff7c 100644
>> > --- a/builtin/branch.c
>> > +++ b/builtin/branch.c
>> > @@ -334,11 +334,36 @@ static char *build_format(struct ref_filter
>> > *filter, int maxwidth, const char *r
>> >         struct strbuf local = STRBUF_INIT;
>> >         struct strbuf remote = STRBUF_INIT;
>> >
>> > -       strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)
>> %s%%(end)",
>> > -                   branch_get_color(BRANCH_COLOR_CURRENT),
>> > -                   branch_get_color(BRANCH_COLOR_LOCAL));
>> > -       strbuf_addf(&remote, "  %s",
>> > -                   branch_get_color(BRANCH_COLOR_REMOTE));
>> > +       // Prepend the current branch of this worktree with "* " and
>> > all other branches with "  "
>>
>>
>> We use /* ... */ C comments, not C++-style // (well, it's in C now, but
>> not the ancient versions we need to support).
>>
>> It also seems all of this patch was copy/pasted into GMail or something,
>> it has wrapping and doesn't apply with "git am".
>>
>> Also most/all of these comments I'd say we could better do without,
>> i.e. the ones explaining basic code flow that's easy to see from the
>> code itself.
>>
