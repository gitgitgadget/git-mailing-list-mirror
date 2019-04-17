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
	by dcvr.yhbt.net (Postfix) with ESMTP id C683420305
	for <e@80x24.org>; Wed, 17 Apr 2019 10:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfDQKXB (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:23:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34084 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDQKXB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:23:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id a6so9250224edv.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=L7qvD5AkoCaMe8tyvidYKtMOuP5VTkPiDZsjzPM11Sk=;
        b=oiLKcbdX4dz43J5t1sFUwsqHi69hcayXqa1KDZB/C29FxGTSh+A01K3Xi3S/UVUhbo
         l7XelBbwqByOxrwRavNNlsiSIVdHHjYawBgnFZLjjRH06U3ih9OqQizDM/SB4jimTr6v
         oyd/zhQ1gfC77QJXosnrtXyudd6689LO4P1V2pgPK3G9EVyzjIEko6Y9Xv6xxeYOn7Nk
         sBnc3i/Swritn1zxXRN8s8rNpGvn1GyhvrbnvaU4af3mK1Hax4i9qnHwFv9UGo1QU1lr
         t0xWKJHOW0W3S6NpIQ0cqQZ8bljSgvKqWmvAxU4XzeStMv64ZI5wannoQJJlvg8dC5kN
         S24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=L7qvD5AkoCaMe8tyvidYKtMOuP5VTkPiDZsjzPM11Sk=;
        b=hfVS69eNG5vQbVZos+lgvw16JgpdL5egqkhG1w2KO8y9rTPl0ntaJZ8eq7OlxKWMPO
         QOEcOysW2esvxxX/fLTwv3SvY06H/+GXg/jZF8s8BecUUp2UCj+d0QBiEp3gfurci4Fl
         v/hEtuVBqFdI7R/9dR/d1chmzMZa5lVDE/0UPFneaMjOIin5e6bW+ZpJe6vqHV99RaNe
         Xclr5d2vMprWnY38jYlziP37l1DLwFaB9vB0wgXZvZMbSybDmCt8cx2sQm2XDJXj1yae
         XXGKXo2mLbw2KjacC0ExX9X9yGIgNCyFlAEQnlYgLX9TgNITN6DPB0pcddSrlnzogCWQ
         m6uw==
X-Gm-Message-State: APjAAAWlXePMfPAD619LmBgIozZbZWhzcGy6GJvNuSrnirqk+iz4SvNe
        4gifFPRNm+Z6mJxXL90nx0s=
X-Google-Smtp-Source: APXvYqyThepewRfWgcZA8805Rhioch9lc1tYch+vFePK9xMQdD85AeDxys5946C60rwUXZoHT3XdrQ==
X-Received: by 2002:a17:906:251b:: with SMTP id i27mr46930836ejb.146.1555496579214;
        Wed, 17 Apr 2019 03:22:59 -0700 (PDT)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id 30sm2715402edr.2.2019.04.17.03.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 03:22:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com> <87d0lmatr1.fsf@evledraar.gmail.com> <adb4a578-9bc6-f017-5817-cd045dcb0a32@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <adb4a578-9bc6-f017-5817-cd045dcb0a32@gmail.com>
Date:   Wed, 17 Apr 2019 12:22:54 +0200
Message-ID: <87a7gpaq2p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 17 2019, Phillip Wood wrote:

> On 16/04/2019 15:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Tue, Apr 16 2019, Junio C Hamano wrote:
>>
>>> * pw/rebase-i-internal-rfc (2019-03-21) 12 commits
>>>   - rebase -i: run without forking rebase--interactive
>>>   - rebase: use a common action enum
>>>   - rebase -i: use struct rebase_options in do_interactive_rebase()
>>>   - rebase -i: use struct rebase_options to parse args
>>>   - rebase -i: use struct object_id for squash_onto
>>>   - rebase -i: use struct commit when parsing options
>>>   - rebase -i: remove duplication
>>>   - rebase -i: combine rebase--interactive.c with rebase.c
>>>   - rebase: use OPT_RERERE_AUTOUPDATE()
>>>   - rebase: rename write_basic_state()
>>>   - sequencer: always discard index after checkout
>>>   - Merge branch 'ag/sequencer-reduce-rewriting-todo' into pw/rebase-i-=
internal-rfc
>>>   (this branch uses ag/sequencer-reduce-rewriting-todo.)
>>>
>>>   The internal implementation of "git rebase -i" has been updated to
>>>   avoid forking a separate "rebase--interactive" process.
>>>
>>>   Comments?  Is this ready?
>>
>> I gave this some stress testing/review in your infra, works for me so
>> far, and a good performance improvement.
>>
>> My only problem with it is that the commit message doesn't note just
>> quite how awesome it is, but I can live with that :)
>
> Thanks for testing this, I'll send a re-roll that mentions the
> performance improvement. I'm still surprised by it, are you seeing an
> improvement in production as well as on the perf test you mentioned
> before? I wonder if some of the improvement is due to
> ag/sequencer-reduce-rewriting-todo if that wasn't in master when you
> ran the benchmarks but I haven't had time to investigate.

Just the perf tests. I don't think it'll have much noticeable impact on
a typical rebase, but everything helps...
