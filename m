Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41FB62036D
	for <e@80x24.org>; Tue, 21 Nov 2017 22:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdKUWpe (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 17:45:34 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:44398 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdKUWpc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 17:45:32 -0500
Received: by mail-qt0-f174.google.com with SMTP id h42so21357095qtk.11
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 14:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l4fcSFMD3w4yMEWrInSIaA6vfVPEGPRwzaea73eii54=;
        b=p5Y//cccBGQVbxQ/EFUqxNvXCWVdxR493+oKtrkwmnnvBFv4xmIg0DuP22VolEv+cf
         i9k4zTQMyxsP1x/nxsJWbN9C2wOdZ6/mFoyu6r/cFMLLBtSBpaszUEUBiyt/j4I6XEhZ
         caAqw2wA/kmb97s628nND5SkCxWfn9o7/9wKvydJ9/LlMgakx/lqMpGecfEi+UJSCbhd
         ugA5DvEgdwIf7dfqnr+llMDd7d5vS9MGorM8SPHk6DYvhRoj3LVVovng08O9KiX0oK5A
         un5OZR6cBaSrf2NY5mReb+NuC03B2kdHT8y4WRPpHCnvKKNMaIlN74KYr6eEOYcm06Sv
         VC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l4fcSFMD3w4yMEWrInSIaA6vfVPEGPRwzaea73eii54=;
        b=Cy9xM/AoO3TGGw3irXliy1C2EG0+p35hG3TurS6xXxa3FOhKqty+UqwHoQnS7vnuvw
         Dqq4S/XlCy+WYy6JKT8TNCouF6sztrQFqC1PhR5eg+1zzaxE4RsBFP3KDwnhjdsTY4C2
         ujDgy34HjRiWP9a91H+YCZefQGoe8eBymTR08AKd6nHbyQJ4tzXE2IACTbLUAVhIB46o
         v9+qltE8FcIwqAICoTkO3hLG2CBc02qFQ9+kyYcraqWIdOdDMj4rGQH6tgZlewn0+BM2
         pZ4QydmDxkHzWZTkooJK72oHHyzAJNV7fB6wHyOrqgCcNiEYX1C8X2X14/6FRtOJAVfv
         9JHg==
X-Gm-Message-State: AJaThX57wsPQlhGpo+Ib/9XtY5CkSDInviCNA9rZ8GlRuknM6Lhhodn6
        na9TGrZMTnBnNgsw07YrjvOt0WOYjnABdkIpuuKJJw==
X-Google-Smtp-Source: AGs4zMYRf1tCvohmFboJ5pkw3n7mQIz2y/Jv8hBy9TP5/IGoizVigGtN9IwMXqGj8jLp4uGvsKMtBqHcrYxA8+ss1Z4=
X-Received: by 10.200.9.91 with SMTP id z27mr30020143qth.207.1511304331402;
 Tue, 21 Nov 2017 14:45:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 21 Nov 2017 14:45:30 -0800 (PST)
In-Reply-To: <20171121223449.GI3429@aiede.mtv.corp.google.com>
References: <20170724173601.19921-1-sbeller@google.com> <20170724180312.GE13924@aiede.mtv.corp.google.com>
 <xmqq8tjdcyf1.fsf@gitster.mtv.corp.google.com> <xmqqr2x5bhk7.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZdoktBRBuNxVk-zehZR3Z-egEPG81KQ9WqHTEtrm+5uw@mail.gmail.com> <20171121223449.GI3429@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Nov 2017 14:45:30 -0800
Message-ID: <CAGZ79kZxD4r0J+uZCuBStkZq1mqPSTaOdkpyOmPXjdLLr6rkOQ@mail.gmail.com>
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 2:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>
>>>> Also, while I do agree with you that the problem exists, it is
>>>> unclear why this patch is a solution and not a hack that sweeps a
>>>> problem under the rug.
>>>>
>>>> It is unclear why this "silently detach HEAD without telling the
>>>> user" is a better solution than erroring out, for example [*1*].
> [...]
>> So I took a step back and wrote about different proposals where
>> we want to go long term. See below. This will help us
>> figuring out how to approach this bug correctly.
>
> Stefan, do you know what thread I should look at to find the current
> state of this patch?  I've had it applied locally for a long time.

It was "Undecided" for some time, then Junio kicked it back to pu, expecting a
reroll[1]. The "send out a plan" that was referenced is found in [2]
describing 6
plans for the future of submodules. The approach in [3] which is
different on the
implementation level, but very similar on the UX level sounds best currently.
I'll coordinate with JTan to come up with patches for that.

[1] https://public-inbox.org/git/CAGZ79kYUZv0g+3OEMrbT26A7mSLJzeS-yf5Knr-CnARHqVB=aQ@mail.gmail.com/
[2] https://public-inbox.org/git/20171109001007.11894-1-sbeller@google.com/
[3] https://public-inbox.org/git/20171108172945.33c42a0e91b4ac494217b788@google.com/

> The thread I am replying to appears to be where the patch comes from
> but I have some memories of more recent discussion that I'm not
> finding.
>
> More context:
> https://public-inbox.org/git/xmqqshd8i3ze.fsf@gitster.mtv.corp.google.com/
> says
>
>  * sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
>   - Documentation/checkout: clarify submodule HEADs to be detached
>   - recursive submodules: detach HEAD from new state
>
>   "git checkout --recursive" may overwrite and rewind the history of
>   the branch that happens to be checked out in submodule
>   repositories, which might not be desirable.  Detach the HEAD but
>   still allow the recursive checkout to succeed in such a case.
>
>   Expecting a reroll.
>
> Thanks,
> Jonathan
