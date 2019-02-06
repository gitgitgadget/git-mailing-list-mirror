Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91FA1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 22:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfBFWUf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 17:20:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45962 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 17:20:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id t6so6085213edw.12
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 14:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=o5LHLhXWQv9J9veWIdbNP+FsmtA7SNBG1oYlrWwrfnA=;
        b=bhIujHANrkSRzSwwK2LV0nmzAfCbcr/4k2drh3eP962gZ4mYI7FAfg9cxz5RNKoWig
         iuPwXx3cQuZCWy9wgT6JwFPDd3CBeboYlaRB+8Gn98nzpHTHShV2fm3YgzXBEJ50Wf4R
         tkz4Y+vw0w1VyxFc9G9S7C5uldz8+vcfng7K1qaT9cg16Wv7bXLVUTvuV2hgZWs6BhGD
         N8Wn30gZYgYgYjTtf7GMBy8N/x7LD8pqVM104CJIPixwIHKbEobrWYvOK+IIZCG4djEv
         LmTwOOwsNp0ycCrAofHAl+I37zGdnclz1gcbVwojRPzUxbsuCu0k/muXaWMDGUqncO8s
         SZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=o5LHLhXWQv9J9veWIdbNP+FsmtA7SNBG1oYlrWwrfnA=;
        b=bFJ38bmZS9KsQENbOAt8FnJ8TrW0h2Z8sIaxil9dr3yk4fGBBn7WQG6V5WXsGMq63P
         vPBsXAAK7OKeSV6gVxn499i3AacKhJagZ/SJRFWxoZQEUjWrcKOI54GKSephldMb6gOu
         +1QgYl0pVFRu/bV1tSvXWrA0n/Hoe6Cxa9CfRXxfboYWzuAENPTz5rYj0yBWOD37g4ja
         83wFDN6LXdlOIEZ2kHLePk76ZJPfdC3qKB4k7AVoF25HQ8tRGqsQnsnNpTZs6n5bYLLN
         8LP7BOxNortf6Gqxz6bN/adhcEl2hqxgIMGJVjRHtU0nldPrr/DHPPMrmZEdIFvR1Mw/
         NMYQ==
X-Gm-Message-State: AHQUAuaqjZOJOg9s61/CVrF7uMyS7ps/LRHSTtwt5CJzXtjsvjg0Bh3A
        fpSwauSiVEMTY/7/bu9b/1BSp3wzFc0=
X-Google-Smtp-Source: AHgI3IZlvvgbIF3hG3Xccg+YouVZ3QMYEIgmjDtUWBAC6OczNp6yxgv869V2XBfpC6U8GkgJ4T40Cw==
X-Received: by 2002:a50:983a:: with SMTP id g55mr9985792edb.143.1549491633569;
        Wed, 06 Feb 2019 14:20:33 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id a27sm6356558eda.65.2019.02.06.14.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 14:20:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        steadmon@google.com
Subject: Re: [PATCH 0/8] Resend of GIT_TEST_PROTOCOL_VERSION patches
References: <cover.1549411880.git.jonathantanmy@google.com> <20190206213458.GC12737@sigill.intra.peff.net> <87ef8klh4g.fsf@evledraar.gmail.com> <20190206221008.GB15378@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190206221008.GB15378@sigill.intra.peff.net>
Date:   Wed, 06 Feb 2019 23:20:32 +0100
Message-ID: <87bm3olftb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 06 2019, Jeff King wrote:

> On Wed, Feb 06, 2019 at 10:52:15PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I wonder if it would be more obvious what's going on if we instead had=
 a
>> > prereq like:
>> >
>> >   test_expect_success !PROTO_V2 'ls-remote --symref' '
>> >      ...
>> >   '
>> >
>> > and just skipped those tests entirely (and in a way that appears in the
>> > TAP output).
>> >
>> > I think it would also future-proof us a bit for v2 becoming the default
>> > (i.e., when GIT_TEST_PROTOCOL_VERSION being blank does mean "use v2").
>> >
>> > I dunno. It probably doesn't matter all that much, so it may not be
>> > worth going back and changing at this point. Just a thought.
>>
>> So far we've had the convention that these GIT_TEST_* variables,
>> e.g. the one for the commit graph, work the same way. Thus we guarantee
>> that we get (in theory) 100% coverage even when running the tests in
>> this special mode. I think it's better to keep it as-is.
>
> But what's the point of that? Don't you always have to run the test
> suite _twice_, once with the special variable and once without?
> Otherwise, you are not testing one case or the other.
>
> Or are you arguing that one might set many special variables in one go
> (to prefer running the suite only twice, instead of 2^N times). In which
> case we are better off running the test (as opposed to skipping it), as
> it might use one of the _other_ special variables besides
> GIT_TEST_PROTOCOL_VERSION.
>
> I can buy that line of reasoning. It still doesn't cover all cases that
> a true 2^N test would, but that clearly isn't going to be practical.

Maybe I'm misunderstanding what you're proposing, but as an example,
let's say the test suite is just these two tests:

    test_expect_success 'some unrelated thing' '...'
    test_expect_success 'test protocol v2' 'GIT_TEST_PROTOCOL_VERSION=3D2 .=
..'

And GIT_TEST_PROTOCOL_VERSION=3D0 is the default, let's say I want to test
with GIT_TEST_PROTOCOL_VERSION=3D1 for whatever reason,

I'd still like both tests to be run, not just 1/2 with
GIT_TEST_PROTOCOL_VERSION=3D1 and 2/2 skipped because it's explicitly
testing for the GIT_TEST_PROTOCOL_VERSION=3D2 case, whereas I asked for a
GIT_TEST_PROTOCOL_VERSION=3D1.

IOW the point of these tests is to piggy-back on the tests that *aren't*
aware of the feature you're trying to test. So
e.g. GIT_TEST_COMMIT_GRAPH=3Dtrue should run our whole test suite with the
commit graph, and *also* those tests that are explicitly aware of the
commit graph, including those that for some reason would want to test
for the case where it isn't enabled (to e.g. test that --contains works
without the graph).

Otherwise I can't say "I care more about GIT_TEST_COMMIT_GRAPH=3Dtrue than
not", and run just one test run with that, because I'll have blind spots
in the commit graph tests themselves, and would then need to do another
run with GIT_TEST_COMMIT_GRAPH=3D set to make sure I have 100% coverage.
