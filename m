Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFE4215F4
	for <e@80x24.org>; Tue,  1 May 2018 19:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeEATqT (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 15:46:19 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33521 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeEATqS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 15:46:18 -0400
Received: by mail-wm0-f51.google.com with SMTP id x12so16008424wmc.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jTkFB08pvoiXucEOO+4E1k2Er9NNhfK4PGyW5ektdOU=;
        b=C+TU5Fyq58aZkTa+SS1kvoZvAkkg3YmdTPRMUwxpnZfkRuPt1WbBdv9WQbtWEIYyYT
         x5k12lpo1dtiYguZKjWSE5Etq7ZF1tn9ioJikcyM8Rffyk8XbPw22yaRgWu+aLU5vIt3
         kIzNE+JWGAgP40Md8Gvx85MQ6J3zzv6E7XFaWr51/FHXpCBMxfX6aQ/uIUGH96DxFzDF
         q57VI42YC3AUcb4Mouot4WW3+7gdWsUAOOEo3qBWsIBMvkKYMEFuLU1YngotfhTEAh+R
         1Hp28eJM2gY1f/IiSI02wyzfj64Otsx1Ckn+cabm8OcsixTAeWZsr3oocxw7QFDRF+CB
         9/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jTkFB08pvoiXucEOO+4E1k2Er9NNhfK4PGyW5ektdOU=;
        b=V/ZKH2M5knJfGt4UwR7pLfAUBtSxquJYo8Xn+MJHANHCD/DCfZ/uO1zaPrnta+EpKB
         cnimatSTRZrwg8VGWwLtvtuWtvghwhV6zwY4G077aboCitHskEeaKk1Et8iW7FoNGzoN
         dA0V7BniyezV3eLpPduOCEjPn3EGWUVlZ974k5lkj9+Lqy93rZJrEEEVJ/Ow2KtZv4lR
         v3Qv+NU7KU+CdS1siiq6I0dSSxnaOco8zvg6GCiQkpMck3mMKSIMLiwoNH0cY+dhYT++
         RNBqHxOjaCV49CZcgO76Q/5xqZIheksZhya8gvsACKtPgZlyMf062F+quC0xxcIfNN/q
         f+1w==
X-Gm-Message-State: ALQs6tBLyKRA1kWUIXWsBGdNh1aZ2W7KHmU8LVe5msH3JHWbQ0dbXQyd
        qXYTORoIi6bPCBTHmGq/qT/q576LoqtybsTSNTOlEQ==
X-Google-Smtp-Source: AB8JxZp3dX16n/HXs7fB6Ep2yje17YUIKfC9/0oKgQ3H/USi8+bVr8wXCC14fMCSKYv4o/NOKmh3pCTdWhyQLsnMsZs=
X-Received: by 2002:a50:cd45:: with SMTP id d5-v6mr22204677edj.118.1525203977090;
 Tue, 01 May 2018 12:46:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Tue, 1 May 2018 12:45:56 -0700 (PDT)
In-Reply-To: <87zi1jxjqn.fsf@evledraar.gmail.com>
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com> <20180501165931.25515-1-wink@saville.com>
 <87zi1jxjqn.fsf@evledraar.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 1 May 2018 12:45:56 -0700
Message-ID: <CA+P7+xry-dE0-TMtRzNjiJpR1ZVmGXDy5ObfMxKyWA+eR8XMsQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/3] Optional sub hierarchy for remote tags
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Wink Saville <wink@saville.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 12:24 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Thanks a lot for working on this, it's great to have something the
> direction of getting rid of this discrepancy between the 1=3D1 mapping fo=
r
> branches, but the 1=3Dmany mapping for tags. My recent patch series and
> the pruneTags feature I added in 2.17.0 are really just hacks around not
> having that.
>
> My concern with your patches is not that they're not implementing some
> mythical future where we're mapping each <remote>'s refs to
> remotes/<fully qualified ref> and local refs to local/<fully qualified
> ref>, which is what we should really be aiming for and would forever get
> us out of this rut of 1=3Dmany and local & remote refs existing in the
> same namespace, but that they might make it harder to get there.
>

I also agree, I'd prefer if we aim for the mapping to be something
which works for all refs in the future, even if such support isn't
added now, which is why i've proposed using "refs/remote/<name>/" so
that a tag would go from

refs/tags/v1.7

to

refs/remote/<name>/tags/v1.7

Ideally, we could work to update "refs/remotes/<name>" to go to
"refs/remote/<name>/heads" as well. This allows obtaining any ref and
mapping it safely per remote. I don't really like the fact that we
can't simply re-use "remotes", nor do I like the fact that "remote" is
very close to "remotes" increasing the chance of typos... historically
I suggested using "tracking" but I don't really like that either..
because honestly there *is* no good name left for this purpose once
"remotes" became only about branches.

The reason I care about this is that I do want to be able to share the
notes refs in a way that allows easy merging, which currently is not
really doable without a lot of work from all users of notes knowing
exactly how you plan to work on them.

Thanks,
Jake

> So specifically, your 1/3 writes this to the config:
>
>   [remote "gbenchmark"]
>     url =3D git@github.com:google/benchmark
>     fetch =3D +refs/heads/*:refs/remotes/gbenchmark/*
>     fetch =3D +refs/tags/*:refs/remote-tags/gbenchmark/*
>     tagopt =3D --remote-tags
>
> If the user clones with your patch, and then uses an older git version
> on the same repo (a use case we need to support) that older version
> doesn't know about --remote-tags, and will fetch them all.
>
> As a workaround for that maybe we'll need something like:
>
>   [remote "gbenchmark"]
>     url =3D git@github.com:google/benchmark
>     fetch =3D +refs/heads/*:refs/remotes/gbenchmark/*
>     fetch =3D +refs/tags/*:refs/remote-tags/gbenchmark/*
>         tagStyle =3D remote
>     tagopt =3D --no-tags
>
> Or whatever, i.e. something where only the new version will fetch the
> tags and ignore the tagopt option (which I never liked anyway). It's a
> hack, but at least you don't end up with crap it your ref namespace by
> flip-flopping between versions.
>
> Then as I alluded to in my
> https://public-inbox.org/git/20180429202100.32353-6-avarab@gmail.com/ we
> have a lot of stuff that hardcodes special behaviors for
> refs/{tags,heads}/, including but not limited to:
>
>     git grep -C2 -e TAG_REFSPEC -e tag_refspec -e '"refs/tags/' -- '*.[ch=
]'
>
> So maybe we need to start this series with some set of patches where we
> make the currently hardcoded behavior for refs/{heads,tags}/
> configurable.
>
> Sorry about this "nice shed you built, how about you make a cathedral
> instead?" E-Mail. I really don't think we should make perfect the enemy
> of the good, but at the same time it would be unfortunate if we can't
> get perfect because we settled for good.
