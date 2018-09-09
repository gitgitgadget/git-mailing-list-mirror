Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321C81F404
	for <e@80x24.org>; Sun,  9 Sep 2018 17:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeIIWKN (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 18:10:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36877 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeIIWKN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 18:10:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20-v6so14817774edd.4
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 10:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ziQFq4s8MlGXT+EXj/lxQUw0XQ4HUgVBzL07GcV0bWY=;
        b=FSp6qsx+lCw/OSEFVm4/fbrUh/OgYD3SWsrpzUF9x8/GP3pDy2p/OmnIN72oDU++GB
         dAOdtaoNA79+CWfu+12beCul62FhZr937tcwykdxsrfzntCpb6iqR0katjpuWRvf31je
         +soaomKUMZHt+j719oe7IEC+34nZF5Yu51vhdVP1IUVcXvYTPk8Ne7c9G1JyU+lvgjca
         RmU3FGpgjaIIgJQJ9dv31Yh6JiNCtrFKnfdnsa73GiGln8GlIH0PfBPmY8CLjLxEu68n
         vE8kVEP1ui5BI5d6BZIOkrzDwtnovdHLuL/D+iS8pFKl7JkAEHyWxaCQtuzVdvRya1Pf
         K6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ziQFq4s8MlGXT+EXj/lxQUw0XQ4HUgVBzL07GcV0bWY=;
        b=okxwc1b09+MWX5pbYHVfPbDilGDT4k4ZHqHTOoRLXwX19/9vWo0OIrgNq7fhW0Rj25
         4/vvhi8al2nqboTD50fTpIBJBC9SmLN/PXSRakx1FXLhV8tOWR80SZSJPUSOsXP4GY3L
         0ycQOkTML5M9xBD97AbuuY8SHWCr/0O638bGs9aF08lvVCPLgzdZuMonOJKNOn3vIkv4
         Ttbk2nlG5Nh97ubXT+SzzarzfjBwd1MGZo4lwfV6wCM1y8eHBBShmv6Zp6O3PgZWqU1c
         vI+bE/hE/zVPI3d5fsdRRXQfUmaRPggTtkd0ltd3sN5SY8goxNvw4+SDeXLbHd8hKs9D
         vMTw==
X-Gm-Message-State: APzg51AuJ/FLpSr1MXPUEcLmXXEn/38VzQDsPHQA+50CMOul/+ULBAjQ
        CPZrT3ue+1u5KRKpN2p3vUs=
X-Google-Smtp-Source: ANB0VdaPcwSy76hXZ8b5OGp9QulCN8l+Qn9msUdo3mEUjIXr4VICySexOB7DL77r7qrCXH6k+qNQ4A==
X-Received: by 2002:a50:f0c2:: with SMTP id a2-v6mr19824219edm.90.1536513592707;
        Sun, 09 Sep 2018 10:19:52 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id v1-v6sm6232696edf.3.2018.09.09.10.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 10:19:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 17/21] range-diff: populate the man page
References: <pull.1.v5.git.gitgitgadget@gmail.com> <pull.1.v6.git.gitgitgadget@gmail.com> <8c5543a0667fffe0cb0684427f726fdfb75b28d0.1534159977.git.gitgitgadget@gmail.com> <87lg8a7wj2.fsf@evledraar.gmail.com> <20180909165431.GA17224@localhost>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180909165431.GA17224@localhost>
Date:   Sun, 09 Sep 2018 19:19:51 +0200
Message-ID: <87k1nu7fm0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 09 2018, SZEDER Gábor wrote:

> On Sun, Sep 09, 2018 at 01:14:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Mon, Aug 13 2018, Johannes Schindelin via GitGitGadget wrote:
>>
>> I realize this topic has long since landed, just seemed like a good
>> thing to reply to to ask this question:
>>
>> > [...]
>> > +	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
>> > [...]
>> > +<range1> <range2>::
>> > +	Compare the commits specified by the two ranges, where
>> > +	`<range1>` is considered an older version of `<range2>`.
>> > +
>> > +<rev1>...<rev2>::
>> > +	Equivalent to passing `<rev2>..<rev1>` and `<rev1>..<rev2>`.
>> > +
>> > +<base> <rev1> <rev2>::
>> > +	Equivalent to passing `<base>..<rev1>` and `<base>..<rev2>`.
>> > +	Note that `<base>` does not need to be the exact branch point
>> > +	of the branches. Example: after rebasing a branch `my-topic`,
>> > +	`git range-diff my-topic@{u} my-topic@{1} my-topic` would
>> > +	show the differences introduced by the rebase.
>>
>> I find myself using range-diff often by watching forced pushes to public
>> repos to see what others are doing, e.g. just now:
>>
>>      + 38b5f0fe72...718fbdedbc split-index-racy       -> szeder/split-index-racy  (forced update)
>
> Heh, spying on my wip bugfixes :)
>
>> And then I turn that into:
>>
>>     # @{u} because I happen to be on 'master' and it's shorter to type
>>     # than origin/master...
>>     git range-diff @{u} 38b5f0fe72...718fbdedbc
>
> I don't understand what you want with that @{u} or 'origin/master' in
> the first place.  It's unnecessary, the three-dot notation on its own
> works just fine.

Maybe I've been using the wrong mode all along, I passed over by habits
from tbdiff, which were surely copy/pasted from somewhere.

Looking at the git-range-diff manpage though it recommends <base> <rev1>
<rev2> over <rev1>...<rev2> when the topic has been rebased, which is
usually the case for e.g. a topic that's submitted to git.git (usually
be the time feedback has been gathered & a re-submission has been made
Junio has pushed another "master").

So isn't "<base> <rev1> <rev2>" the right thing to use over
"<rev1>...<rev2>" for git.git use? I think so, but I'm not sure.

In any case, there are going to be those use-case where you should be
using "<base> <rev1> <rev2>", and a rebase will be propagated by a
force-push, so I thought it made sense that range-diff could directly
consume the output of "fetch" in that case...

>> Only to get an error because it doesn't support that, but just:
>>
>>     git range-diff @{u} 38b5f0fe72 718fbdedbc
>>
>> I think it would be convenient given that "fetch" produces this output
>> to support this sort of invocation as synonymous with the three-arg
>> form. Then you can directly copy/paste that from terminals that have a
>> convenient feature to highlight a continuous \S+ reason to copy/paste
>> it.
>>
>> I can patch it in, but maybe there's UI reasons not to do this that I'm
>> missing, e.g. confusion with the existing <rev1>...<rev2> syntax. What
>> do you think?
