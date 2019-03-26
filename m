Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B1420248
	for <e@80x24.org>; Tue, 26 Mar 2019 20:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbfCZUf6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 16:35:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45164 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZUf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 16:35:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id m16so11995260edd.12
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=eBdU1tMbvvy6A1y261a8K6SInLl5PBPf6Z/vFJMXqfM=;
        b=cP6TOiiuCEUXodqIA+axTqy0MSvEheLY0T6xrfU8AdnYvqo9sbaONJKgsZ2hFZiOM8
         S27OiGHgfz+0PpUBmBuo/+g7hCkPZ4pkmpaWr+9/JQ+OjGi8367FSILjf/MjeK4I5gaS
         SSlL48WrwLDOF80nDpErU1/d8X9gMS0/s0G53ZyvfzyaT9RcjVca9EnK8wDqfViYsEh7
         bOQ3xJxuGLlhKokKxO0GBhV7lB3qr8xW9qjCDXNWuRzHwcvqskFvM0VHPwCiGIYijLTl
         /FJi13JyZZ06hG9dL6ew8srkDsyQ5FXxjrHvK5Yn6LsVjKo7vxEFmWHsDe8KFbXrJ0H4
         1nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=eBdU1tMbvvy6A1y261a8K6SInLl5PBPf6Z/vFJMXqfM=;
        b=IPeXtx0VWbO99vL6l82Tdxkn2AaOmQH2Vx7yTvBPEK+Tbf05bkWUId1iE32rVYCCTS
         mBbgyvPjfxFc4wWlR0YbKmzDmA03y4knsDjnZOiKLhQurUrQEOHqd8h8diH+CmugqYmu
         1RtegC2qh9tonqPLCB/heFks8kie/eLhMHiN1yReDyzZXHZanV4pz0xsDVzn9ZQhV/P1
         U80a/Bdub3TmHwdG3UB9gPxOe6n+dd+T51pRonhP0+/MpUDFzL8GawMcALbX1/2ukTvV
         smJcFviJnzDwkoEV4wcMQsF7c2uzVF93HG19RIrbL75xOTP5dZr8BvYDqQi5TYLojQfR
         Cidw==
X-Gm-Message-State: APjAAAV0/OeFSIfHZtp6iK4zH6oKGpb6+xVWbc9p1t+w30/E+og1QRN/
        r2dToTyrv2PmcQ8A79+lEhL4kFQG
X-Google-Smtp-Source: APXvYqwjHtVcYrcK6yNhCFsfrdotKI7YPvDLtfNUvb1iPwVUC3Jj+aM8ubcbWDQz8Kz32YzL+pcgig==
X-Received: by 2002:aa7:cf18:: with SMTP id a24mr20755649edy.215.1553632556139;
        Tue, 26 Mar 2019 13:35:56 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id bz3sm2984127ejb.52.2019.03.26.13.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 13:35:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] rebase: learn --keep-base
References: <cover.1553354374.git.liu.denton@gmail.com> <87bm1xbt55.fsf@evledraar.gmail.com> <20190326175052.GA14922@dev-l>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190326175052.GA14922@dev-l>
Date:   Tue, 26 Mar 2019 21:35:48 +0100
Message-ID: <878sx1bcgr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 26 2019, Denton Liu wrote:

> Hi =C3=86var,
>
> On Tue, Mar 26, 2019 at 03:35:34PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Sat, Mar 23 2019, Denton Liu wrote:
>>
>> > This series teaches rebase the --keep-base option.
>> >
>> > 'git rebase --keep-base <upstream>' is equivalent to
>> > 'git rebase --onto <upstream>... <upstream>' or
>> > 'git rebase --onto $(git merge-base <upstream> HEAD) <upstream>' .
>> >
>> > This seems to be a common case that people (including myself!) run int=
o; I was
>> > able to find these StackOverflow posts about this use case:
>> >
>> > * https://stackoverflow.com/questions/53234798/can-i-rebase-on-a-branc=
hs-fork-point-without-explicitly-specifying-the-parent
>> > * https://stackoverflow.com/questions/41529128/how-do-you-rebase-only-=
changes-between-two-branches-into-another-branch
>> > * https://stackoverflow.com/a/4207357
>>
>> Like with another series of yours I think this would be best squashed
>> into one patch.
>
> Will do.
>
>>
>> Maybe I've misunderstood this but isn't this like --fork-point except
>> with just plain "git merge-base" instead of "git merge-base
>> --fork-point", but then again 2/3 shows multiple base aren't supported,
>> but merge-base supports that.
>>
>
> --fork-point gets used to determine the _set of_ commits which are to be
> rebased, whereas --keep-base (and --onto) determine the base where that
> set of commits will be spliced. As a result, these two options cover
> orthogonal use-cases.

Right. After playing with this a bit more though --fork-point is mostly
there, it it does find the same fork point, as evidenced all your tests
(that aren't asserting incompatibility with other options) passing with
this:

    diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-thr=
eedots.sh
    index 9c2548423b..ab2d50e69a 100755
    --- a/t/t3416-rebase-onto-threedots.sh
    +++ b/t/t3416-rebase-onto-threedots.sh
    @@ -116,7 +116,7 @@ test_expect_success 'rebase --keep-base master from=
 topic' '
            git checkout topic &&
            git reset --hard G &&

    -       git rebase --keep-base master &&
    +       git rebase $(git merge-base --fork-point master HEAD) &&
            git rev-parse C >base.expect &&
            git merge-base master HEAD >base.actual &&
            test_cmp base.expect base.actual &&
    @@ -140,7 +140,7 @@ test_expect_success 'rebase -i --keep-base master f=
rom topic' '
            git reset --hard G &&

            set_fake_editor &&
    -       EXPECT_COUNT=3D2 git rebase -i --keep-base master &&
    +       EXPECT_COUNT=3D2 git rebase -i $(git merge-base --fork-point ma=
ster HEAD) &&
            git rev-parse C >base.expect &&
            git merge-base master HEAD >base.actual &&
            test_cmp base.expect base.actual &&

I've poked at some of this recently in
https://public-inbox.org/git/20190221214059.9195-3-avarab@gmail.com/ as
noted in the feedback there (I haven't gotten around to v2 yet) it's
entirely possible that I haven't understood this at all :)

But it seems to me that this patch/implementation conflates two
unrelated things.

Once is that we use --fork-point to mean that we're going to find the
divergence point with "merge-base --fork-point". This gets you halfway
to where you want to be, i.e. AFAICT the --keep-base and --fork-point
will always find the same commit for "git rebase" and "git rebase
--keep-base". See the "options.restrict_revision =3D get_fork_point(...)"
part of the code.

The other, which you want to disable, is that --fork-point *also* says
"OK, once we've found the divergence point, let's then rebase it on the
latest upstream. Or in the example above the "master" part of "git
merge-base --fork-point master HEAD".

Shouldn't --keep-base just be implemented in terms of skipping *that*
part, i.e. we find the fork point using the upstream info, but then
don't rebase *on* upstream.

The reason the distinction matters is because with your patch these two
act differently:

    git rebase --keep-base
    git rebase $(git merge-base @{u} HEAD)

The latter will skip work ("Current branch master is up to date"), but
--keep-base will always re-rebase things. There's some cases where
--fork-point does that, which I was trying to address with my linked WIP
patch above.

Whereas the thing you actually want to work is:

    git rebase -i --keep-base
    git rebase -i $(git merge-base @{u} HEAD)

I.e. to have both of those allow you to re-arrange/fixup whatever and
still rebase on the same divergence point with @{u}, and won't run
rebase when there's no work to do unless you give it --force-rebase.

> reason that --onto already disallows multiple bases. If we have multiple
> bases, how do we determine which one is the "true base" to use? It makes
> more sense to error out and let the user manually specify it.

Ah, makes sense.

>> I'd find something like the "DISCUSSION ON FORK-POINT MODE" in
>> git-merge-base helpful with examples of what we'd pick in the various
>> scenarios, and also if whatever commit this picks was something you
>> could have "git merge-base" spew out, so you could get what rebase would
>> do here from other tooling (which maybe is possible, but I'm confused by
>> the "no multiple bases"...).
>
> If I'm understanding you correctly then yes, this could be done with
> other tooling. See the 0/3 for equivalent commands.
>
> Perhaps I should update the rebase documentation to mention that
> --fork-point and --keep-base are orthogonal because it's unclear for
> you, it's probably unclear for other users as well.
>
> Thanks,
>
> Denton
