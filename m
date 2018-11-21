Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C5D1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 09:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeKUUEO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 15:04:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41096 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbeKUUEO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 15:04:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id z28so4293620edi.8
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 01:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=cMZ6P1xMoeNSLXE9KKivzT8SiIx53h6b3qMxuaEc1n8=;
        b=a1jrBv4LKkI0+vbJ29mifhFVfeEq9L4q5uYSMwx/69qSWXWWftRw3oY03TMcQHhLsm
         xtAOMEkfS+0vkwjcw7jSTg1PpdtQarIJIzrRC6Mo2qq6eep2Nph6+re5ZcH+6fBWmKW2
         irfP+cJ2upLvBI2V8f0iD9nAJwqLxayimrRHrhtJElQEefAw1hZ827a1Yrq5Da1zSuJp
         W+5rMicRjydwzsyHHtUiT6yA4z6vgZluMP9M+qpvo6z6JGUsquC63sNVAdI5CPf/F3Zf
         jkS2wEkvHXMUS6lFdPEND9ynySsJMpSl6lIKIMeTQWjLcdw1tvmh/XkFhz2rT8oddjXG
         Za6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=cMZ6P1xMoeNSLXE9KKivzT8SiIx53h6b3qMxuaEc1n8=;
        b=fc+iMMwZfmZTyDV+bf/b1gK9lP6Y54Uc45HMP6jI+VR36PpFu+WXAvhsnuBLbpIFHJ
         QOw+TeQZuVNPPcxBVQ+NI/HrPpNgmfPMMIf+2OgQZGnmmh3RLNqUNDwpPbDlHQhbpb2Q
         hF+MF/JTf8di+Fpu8mkqFoXkCvmaJAoj10nbO8SXJ2VS++pwGGhzNGAqA3dKILV13xkh
         b5TLD/DuDpzEl/kSapDUqqdVmSeOJoSV01APXjMkJKTRDOol2PofudLPTkdXvmD1FdRj
         P1Qhkn3Bc6DF/sdGDpKfkgOyinoaGllyD5M3vwhN8D1E2XC6Blmp/B/rABMOSR/pf2k9
         UY1g==
X-Gm-Message-State: AA+aEWake0+PC4LIa7cT/vVxoinyNoP7r+hCa6QIYX7lbJv7rS9z9Hf0
        MmaRuYonUjLrIQm+j+KLC2g=
X-Google-Smtp-Source: AFSGD/Xl1daVj6rkcTj764chDCavJAYWlg3/bo+chK+OaIGqB+BJDN8NGJvSID1m450PZLPoQVgOMg==
X-Received: by 2002:a50:a399:: with SMTP id s25mr5253594edb.1.1542792628627;
        Wed, 21 Nov 2018 01:30:28 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id g31sm5583758eda.96.2018.11.21.01.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 01:30:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com
Subject: Re: [PATCH 5/5] index: offer advice for unknown index extensions
References: <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113003938.GC170017@google.com>
        <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
        <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
        <20181120060920.GA144753@google.com>
        <20181120061544.GF144753@google.com>
        <87sgzwyu94.fsf@evledraar.gmail.com>
        <cabd2e37-7389-ac74-6626-629eab7da53f@gmail.com>
        <xmqqefbf9t4j.fsf@gitster-ct.c.googlers.com>
        <20181121010309.GE149929@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181121010309.GE149929@google.com>
Date:   Wed, 21 Nov 2018 10:30:24 +0100
Message-ID: <87o9aizsjz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 21 2018, Jonathan Nieder wrote:

> Junio C Hamano wrote:
>
>>              This series has a strong smell of pushing back by the
>> toolsmiths who refuse to promptly upgrade to help their users, and
>> that is why I do not feel entirely happy with this series.
>
> Last reply, I promise. :)
>
> This sentence might have the key to the misunderstanding.  Let me say
> a little more about where this showed up in the internal deployment
> here, to clarify things a little.
>
> At Google we deploy snapshots of the "next" branch approximately
> weekly so that we can find problems early before they affect a
> published release.  We rely on the ability to roll back quickly when a
> problem is discovered, and we might care more about compatibility than
> some others because of that.
>
> A popular tool within Google has a bundled copy of Git (also a
> snapshot of the "next" branch, but from a few weeks prior) and when we
> deployed Git with the EOIE and IEOT extensions, users of that tool
> very quickly reported the mysterious message.
>
> That said, the maintainers of that tool did not complain at all, so
> hopefully I can allay your worries about toolsmiths pushing back.
> Once the problem reached my attention (a few days later than I would
> have liked it to), the Git team at Google knew that we could not roll
> back and were certainly alarmed about what that means about our
> ability to cope with other problems should we need to.  But we were
> able to quickly update that popular tool --- no issue.
>
> Instead, we ran into a number of other users running into the same
> problem, when sharing repositories between machines using sshfs, etc.
> That, plus the aforementioned inability to roll back Git if we need
> to, meant that this was a serious issue so we quickly addressed it in
> the internal installation.
>
> In general, we haven't had much trouble getting people to use Git
> 2.19.1 or newer.  So the problem here does not have to do with users
> being slow to upgrade.
>
> Instead, it's simply that upgrading Git should not cause the older,
> widely deployed version of Git to complain about the repositories it
> acts on.  That's a recipe for difficult debugging situations, it can
> lead to people upgrading less quickly and reporting bugs later, and
> all in all it's a bad situation to be in.  I've used tools like
> Subversion that would upgrade repositories so they are unusable by the
> previous version and experienced all of these problems.
>
> So I consider it important *to Git upstream* to handle this well in
> the Git 2.20 release.  We can flip the default soon after, even as
> soon as 2.21.
>
> Moreover, I am not the only one who ran into this --- e.g. from [1],
> 2018-10-19:
>
>   17:10 <peff> jrnieder: Yes, I noticed that annoyance myself. ;)
>   17:11 <newren> Yeah, I saw that message a few times and was slightly
>                  annoyed as well.
>
> Now, a meta point.  Throughout this discussion, I have been hoping for
> some acknowledgement of the problem --- e.g. an "I am sympathetic to
> what you are trying to do, but <X>".  I wasn't able to find that, and
> that is part of what contributed to the feeling of not being heard.
>
> Thanks for your patient explanations, and hope that helps,
> Jonathan

I think it makes total sense to fix this. I had not spotted this myself
since I tend to just roll forward and only use one version of git on one
system, but fixing this makes sense.
