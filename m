Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9047E1F404
	for <e@80x24.org>; Fri, 29 Dec 2017 23:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdL2XUV (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 18:20:21 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:37343 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdL2XUU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 18:20:20 -0500
Received: by mail-wr0-f182.google.com with SMTP id f8so31866962wre.4
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 15:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QF7tFzD9zrCAYG0Y3Ybn81KWtDxgB/SLEkg+R4In+VI=;
        b=lHDmjP5izRu6zmtR7Yw/3VGNBww4o5ldg5grF1P0DmrC/IUFoP4z85gMvKalZb4q3d
         QMJ8jMPROKVUKJ9xwGFoK4C3mUTsVy4dPbI2vMYEWf+p+3Px1XAD0X/37ik1zYxrD1GA
         MraMgCqHGBMpsv7J455/fhnsewF7L9ahIDcBMs5j4kk0pDTCwmO9638KjQK/EUpNYegb
         FdEU9T20vJMpn/AgZ086DjWc6THm4PFX02p/B88Zh4kIYOtrEvbTw7T55OtlEP8wcXdL
         +2iAo1ImWmTm8tquONLBNjQQucIdeIw8Tmqd3WBoJ43P2I9/0vJX4bgJiNmdG+t5uCGz
         4dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QF7tFzD9zrCAYG0Y3Ybn81KWtDxgB/SLEkg+R4In+VI=;
        b=Od4IBogoVeOtzeWazbNmVJQZgZureEFey8IwadwQEr7tUe7eKD4SSBprQO39CKwAot
         KKys52sxasbwa/0AIfihqguetbb4HZOIIitQq9kifLNbYrQnnxzltfbQnQGFu2uOaR5I
         ahHxV8cvitK2Ri+8lzE/dBUo8kjudHS3iMr4iPLfki6QMuFV+Fz0Ncfx3l6TAHnSFwGK
         hBQMOSCI+ygwvf2W/1a/L/tx2kG2SoXsgQriTdGIdNGVHKprrIfTuO12M+pXvn9I3W5K
         +TPdA3pohJ79NPr22sTSrtFKHPKQqz1OC4wrUTpv+Isjou7voSXO8n/tWzPP8aMrePq4
         41kQ==
X-Gm-Message-State: AKGB3mJMoXb7q1z0grstVvm27m2BP91Vnd8J3iHnQhu8geKhDIIBIrDP
        Y758eR49W8oJ89gE2pRWud1NbkNi
X-Google-Smtp-Source: ACJfBouRLg8IlQN+tHpVrGY2d1VqcgNTIATfJ0y+dVLFhkbxdM+ncesB9tWuTTdatj+5woIe1ptnWQ==
X-Received: by 10.223.133.143 with SMTP id 15mr21954272wrt.266.1514589619304;
        Fri, 29 Dec 2017 15:20:19 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id e197sm103528978wmf.4.2017.12.29.15.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Dec 2017 15:20:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Keith Smiley <k@keith.so>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
References: <20171229135240.GQ3693@zaya.teonanacatl.net> <20171229224825.31062-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171229224825.31062-1-szeder.dev@gmail.com>
Date:   Sat, 30 Dec 2017 00:20:17 +0100
Message-ID: <87y3ll6s0e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 29 2017, SZEDER Gábor jotted:

>> Keith Smiley wrote:
>> > It looks like that was just about preferring remove in documentation
>> > and the like, I think it would still make sense to have both for
>> > completion since rm is still supported.
>>
>> I read it as a first step in a long process to eventually
>> remove 'remote rm', but if that's never intended, then sure,
>> restoring completion for it seems reasonable.
>>
>> It would be good to hear from those who know or recall the
>> intention.
>>
>> I think we should only complete the preferred subcommand.
>> That encourages use of 'remote remove' even if 'remote rm'
>> will stay forever to avoid breaking existing scripts.
>
> Quoting from the commit message of e17dba8fe1 ("remote: prefer
> subcommand name 'remove' to 'rm'", 2012-09-06):
>
>   'rm' is still supported and used in the test suite. It's just not
>   widely advertised.

I think we made the wrong choice in standardizing on remove instead of
rm, it should be rm for consistency with git-rm, and "remote rename"
should be "remote mv" etc., just like we have git-mv.

Maybe if we didn't have the Unix legacy we'd pick rename and remove to
be consitent for both, but since that's not going to happen this bit of
inconsistency is worse.

Now with that showing of my biases out of the way...

> I think adding 'rm' to completion definitely counts as advertisement.
> It doesn't have much practical use, after all: typing 'rm' with
> completion is actually one more keystroke than without (r<TAB>m vs. rm).

This is only one use of the completion interface, maybe you only use it
like that, but not everyone does.

The completion interface has two uses, one is to actually save you
typing, the other is subcommand discovery, and maybe someone who has a
use neither you or I have thought of is about to point out a third.

I'll type "git $whatever $subcommand<TAB>" as *validation* that I've
found the right command, not to complete it for me. This is a thing
that's in my muscle memory for everything.

The post-hoc reason is because if you're a fast typist you don't
actually save time on typing the command (usually I just use reverse
shell search anyway), but rather on not screwing up the command itself
via a typo.

Sometimes commands take a while to fail, and even if it's immediate
re-editing them takes longer than getting it right in the first place.

Since I've been typing "git remote rm<TAB>" for a while (started before
this deprecation happened) I've actually been meaning to submit
completion for "rm" since it works, not knowing about Duy's patch until
now.

Now, even if someone disagrees that we should have "rm" at all I think
that in general we should not conflate two different things, one is
whether:

    git remote <TAB>

shows both "rm" and "remove" in the list, and the other is whether:

    git remote rm<TAB>

Should yield:

    git remote rm<SPACE>

Or, as now happens:

    git remote rm<NOTHING AND ÆVAR THINKS IT'S BROKEN>

I can see why we'd, in general, we'd like to not advertise certain
options for completion (due to deprecation, or just to avoid verbosity),
but complete them once they're unambiguously typed out.

I don't know whether the bash completion interface supports making that
distinction, but it would be useful.
