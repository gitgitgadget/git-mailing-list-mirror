Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF8D1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBGKtq (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:49:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44411 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKtq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:49:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so8568423edd.11
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zR/PDu0hpZP7YDv31buHGaI1LKBbZNlX/gom4VqXadE=;
        b=JFBoFDx2LJzcwh2goNjfwTs+arMcgk0j4KXFDPkP8Nz1NAAruGokWEUEghoam/d6vH
         PB91RwraiyGWFsVamb4MmGnKrTtpKRkcS7QlO+ZqWV2eszuGuBLC3JWRA6vSIEOtHQMy
         Vjad1UEWqFuCIumxlyH5EMVBWcQl7KaOURYTjkb+rc9gcSmWNF6YTA7ACzxFTRQ3PLc8
         608hyRC8tq4ztakfH0VkknQmO/iIKaJKxPT86R1AmLd9fSu0KQLdYCI/Az7ksJ/0587b
         92BCkWy8Bnjp5CkRJGs44trta6YZ4ygua+aUrJfPfmGpqztLNRBXleq2nG/ezhibJtjq
         L0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zR/PDu0hpZP7YDv31buHGaI1LKBbZNlX/gom4VqXadE=;
        b=C5F5yXvWxax1/S/sf5FYAot+itr5fJfQTRbdY7TK/9Ruk+txtOxIiQRlBrf+q/6NRc
         tJhH/+NbvBqRlY5L5EuECWGN0W/EMV3YP3TaZTpeMpXSVNLmVb2D6VRV2YiXYpdQSVzU
         WBboQRuOo3U7GKD+4hzw4J4Kl31MfuMAusfGKuvK9oqc8klXP2+wauqe04H54lumG/Mu
         gddtWfxLSQ41+exnun3ZfA/uHTJ7X97aTae/bg/16D7UE0xQU0vgQ/uZrSRb83JWFwoA
         04HMfHPf1P4Jhal77Fd95gvv+Vnp2+m9EmyK/NKoErbEnPIxSHVYVJ+7OoBsqvoulzWN
         WfPQ==
X-Gm-Message-State: AHQUAuYSN/XL7ZGvDom8KfIt+AcluWJ29DM9ldkUatdZwWT6N4pUyvkK
        Z31YIUnc22oaGGDtXxwP3jDnWYxi
X-Google-Smtp-Source: AHgI3IbCuu7+DqrJgxXTk80Sb5PcK9qVWJ84gWAiOL635kpdMlYkBHoI8YpanrVkYexpamZ268dBUA==
X-Received: by 2002:a05:6402:758:: with SMTP id p24mr12317877edy.92.1549536583889;
        Thu, 07 Feb 2019 02:49:43 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f6sm6866613ede.53.2019.02.07.02.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:49:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        steadmon@google.com
Subject: Re: [PATCH 0/8] Resend of GIT_TEST_PROTOCOL_VERSION patches
References: <cover.1549411880.git.jonathantanmy@google.com> <20190206213458.GC12737@sigill.intra.peff.net> <87ef8klh4g.fsf@evledraar.gmail.com> <20190206221008.GB15378@sigill.intra.peff.net> <87bm3olftb.fsf@evledraar.gmail.com> <20190206230813.GC19901@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190206230813.GC19901@sigill.intra.peff.net>
Date:   Thu, 07 Feb 2019 11:49:42 +0100
Message-ID: <877eeblvp5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 07 2019, Jeff King wrote:

> On Wed, Feb 06, 2019 at 11:20:32PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> So far we've had the convention that these GIT_TEST_* variables,
>> >> e.g. the one for the commit graph, work the same way. Thus we guarant=
ee
>> >> that we get (in theory) 100% coverage even when running the tests in
>> >> this special mode. I think it's better to keep it as-is.
>> >
>> > But what's the point of that? Don't you always have to run the test
>> > suite _twice_, once with the special variable and once without?
>> > Otherwise, you are not testing one case or the other.
>> >
>> > Or are you arguing that one might set many special variables in one go
>> > (to prefer running the suite only twice, instead of 2^N times). In whi=
ch
>> > case we are better off running the test (as opposed to skipping it), as
>> > it might use one of the _other_ special variables besides
>> > GIT_TEST_PROTOCOL_VERSION.
>> >
>> > I can buy that line of reasoning. It still doesn't cover all cases that
>> > a true 2^N test would, but that clearly isn't going to be practical.
>>
>> Maybe I'm misunderstanding what you're proposing, but as an example,
>> let's say the test suite is just these two tests:
>>
>>     test_expect_success 'some unrelated thing' '...'
>>     test_expect_success 'test protocol v2' 'GIT_TEST_PROTOCOL_VERSION=3D=
2 ...'
>>
>> And GIT_TEST_PROTOCOL_VERSION=3D0 is the default, let's say I want to te=
st
>> with GIT_TEST_PROTOCOL_VERSION=3D1 for whatever reason,
>>
>> I'd still like both tests to be run, not just 1/2 with
>> GIT_TEST_PROTOCOL_VERSION=3D1 and 2/2 skipped because it's explicitly
>> testing for the GIT_TEST_PROTOCOL_VERSION=3D2 case, whereas I asked for a
>> GIT_TEST_PROTOCOL_VERSION=3D1.
>
> But that's my "why". The second test will run identically in both runs,
> regardless of your setting of GIT_TEST_PROTOCOL_VERSION. So there's
> value if you're only running the suite once in getting full coverage,
> but if you are literally going to run it with and without, then you're
> running the exact same code twice for no reason. And you have to run it
> both with and without, since otherwise all of the _other_ tests aren't
> seeing both options.

Yeah, by always running the 2nd test regardless of what
GIT_TEST_PROTOCOL_VERSION=3D* is set to we're wasting CPU if we know we're
going to run both with GIT_TEST_PROTOCOL_VERSION=3D1 and
GIT_TEST_PROTOCOL_VERSION=3D2.

But we don't know that, and in terms of CPU & time the tests that rely
on any given GIT_TEST_* flag are such a tiny part of the test suite,
that I think it's fine to run them twice in such a scenario to guard
against the case when we just run in one more or the other, and not
both.

>> IOW the point of these tests is to piggy-back on the tests that *aren't*
>> aware of the feature you're trying to test. So
>> e.g. GIT_TEST_COMMIT_GRAPH=3Dtrue should run our whole test suite with t=
he
>> commit graph, and *also* those tests that are explicitly aware of the
>> commit graph, including those that for some reason would want to test
>> for the case where it isn't enabled (to e.g. test that --contains works
>> without the graph).
>>
>> Otherwise I can't say "I care more about GIT_TEST_COMMIT_GRAPH=3Dtrue th=
an
>> not", and run just one test run with that, because I'll have blind spots
>> in the commit graph tests themselves, and would then need to do another
>> run with GIT_TEST_COMMIT_GRAPH=3D set to make sure I have 100% coverage.
>
> So if we are still talking about the same 2-test setup above, which only
> has a GIT_TEST_PROTOCOL_VERSION override, then yeah, I get the point of
> being able to run a "stock" test, and then one with _both_ of the flags
> (GIT_TEST_PROTOCOL_VERSION and GIT_TEST_COMMIT_GRAPH) because you don't
> quite know how each test will interact with all of the "other" flags.

Yeah that's another reason not to skip them, although we could imagine a
prereq where we skip the v2 tests if GIT_TEST_PROTOCOL_VERSION=3D1 is set
*and* no other GIT_TEST_*=3D* flag is set, but I think that would also be
a bad idea.

> So now I'm not 100% sure I understand what you're talking about, but I
> think maybe we are actually in agreement. ;)

I think there's two ways to view these GIT_TEST_FOO=3DBAR facilities:

 1. Run all tests with "FOO" set to "BAR", skip those (via prereq) we
    know would break in that mode.

 2. Ditto, but if a test says "I'm a test for FOO=3D!BAR" leave it alone.

#2 is what we have now. I read your
<20190206213458.GC12737@sigill.intra.peff.net> as suggesting that we
should move to #1.

You're correct that moving to #1 would force us to more exhaustively
mark things so that if the default moves to "BAR" we just have to flip a
switch.
