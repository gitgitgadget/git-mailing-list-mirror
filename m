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
	by dcvr.yhbt.net (Postfix) with ESMTP id C89111F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391631AbeIVFkx (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:40:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39258 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeIVFkx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:40:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so11991552edi.6
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2AOIRlKCdakVQbcw3cVsyiaWVWfmiKZEj5Mjn9JgJf8=;
        b=g6EqhyJ7KqiLpVCKzlDxnF4QD0kpBM55rqFgApvX+eJ5BRj2aGLCCBsAYeGYdPpCa/
         INKr/jIU+zOMQVn+xsf1XymcOKVBp66nBK+s6s4MwdgV2DrtoHERPGL8LeriJqZVK1Q5
         H4AN6xN1OpRZtFy7W2kctXoyeGsiM6wlhUIJM1Zkq4DCp1X1C2KUWO4/fGkDfNiNz2Hp
         t3ECS3imBqcVSNtICoESPa4k0BXT+9EaEQDJSeiHjcfUHyPx3R8tjHywJGUpVFhJFORU
         E7LHk3KWeDwhxxqYjyrpabjJHr1SBHX3my0xp8tSvDXtmuLPB68MRwDHbEhGcWGkkau8
         OOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=2AOIRlKCdakVQbcw3cVsyiaWVWfmiKZEj5Mjn9JgJf8=;
        b=r9PYXK3Ky7SF8mDQDJPgVP4MOXH/CuVDWESGTtr5myLlTB5afjMjlTldT3Bl1tk1P0
         p1x7D0FQiBW1HwHuhHl4qvT5gLSAwZHzkVojsQCVKt4AdjQPRjlIYYchMEq0QthaLabF
         bxEdKpS1mm0416fLP5M2447HS/PsK3tSdQvh6qncqTQHYIOdzdj0J+cmQuwIouzhmqPg
         wd8lzyVpWhYxf4BHR2okmqM3swnAi3LSG+qHYzPqtLLz8pIgtEHk1yykmB8+3lLmIFqx
         dXUyo/xsmFyRxNN0lhwyAlF6b2EIKi/E6Za7NvI4GWROivIukDAp1yAIsSuQ27MDH3P6
         bjPg==
X-Gm-Message-State: ABuFfoiWVDEXi4hxq9PWwBf/Xs04c3gxLMXsV8RQ+XPXFnM72JjDYHVr
        YMyhwjC7u74AQ8lPzZuTHlM=
X-Google-Smtp-Source: ACcGV61YCvk6v+dKxvnhe96axv32V2CE7zX4RHlnZZUjf6GmUdCSHekNOXcJxUa7X85Ss1XgJvqg1A==
X-Received: by 2002:aa7:c549:: with SMTP id s9-v6mr64101edr.73.1537573781137;
        Fri, 21 Sep 2018 16:49:41 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id g4-v6sm2695564eda.86.2018.09.21.16.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 16:49:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Segfault in master due to 4fbcca4eff
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com> <87pnx6kjn8.fsf@evledraar.gmail.com> <62a46e49-e539-cbb8-4aaf-6f9b5ae6be57@gmail.com> <87o9cqkj6p.fsf@evledraar.gmail.com> <5e7e6519-21c1-daff-65a5-7d2ca5e1dbd4@gmail.com> <xmqqefdmyhe9.fsf@gitster-ct.c.googlers.com> <87lg7ujuc2.fsf@evledraar.gmail.com> <20180921234543.GA3412@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180921234543.GA3412@sigill.intra.peff.net>
Date:   Sat, 22 Sep 2018 01:49:38 +0200
Message-ID: <87k1nejtrh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 21 2018, Jeff King wrote:

> On Sat, Sep 22, 2018 at 01:37:17AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> > Thanks, both of you ;-).  I was aware of the issue and proposed fix
>> > but forgot about it when merging things down to 'master'.  Sorry
>> > about that.
>> 
>> Just a follow-up question, in your merge commit you just pushed to
>> "next" you say:
>> 
>>     Recent update broke the reachability algorithm when tags pointing
>>     at objects that are not commit were involved, which has been fixed.
>> 
>> And in Derrick's commit message it says:
>> 
>>     [...]but incorrectly assumed that all objects provided were commits[...]
>> 
>> I just wanted to double check (without having the time to dig myself at
>> this point) whether this bug was understood & tested for, or whether the
>> case I had was just /also/ fixed for unexpected reasons.
>> 
>> I.e. in my upthread test case I have two annotated tags pointing at
>> commits, whereas the merge to "next" says "when tags pointing at objects
>> that are not commit were involved", which I I assume means say annotated
>> tags pointing at blobs..., but that's not what I had.
>> 
>> Wasn't this just a bug fix that had nothing to do with tags not pointing
>> to commits, but just ones where we had the simple case of tags pointing
>> to commits, but they just weren't peeled?
>> 
>> I'm hoping for a "Junio skimmed the fix and wrote a merge message that
>> wasn't quite accurate" here, but maybe that's not the case and something
>> might be missing (e.g. missing test code).
>
> I think it's a combination of the merge message being slightly
> inaccurate, and you slightly misreading it. :)
>
> I think by "tags pointing", Junio meant "tag refs". Which of course,
> often point at tag objects, but can also point at trees, etc.
>
> But the problem is not limited to tag refs. I think it's a problem with
> any "want" that is a non-commit. So really any ref pointing to a
> non-commit is a problem. But of course tags are the likely way for that
> to happen, since refs/heads is generally limited to commits.
>
> So in short, yeah, the bug was triggered by fetching any annotated tag.

Thanks for clearing that up.
