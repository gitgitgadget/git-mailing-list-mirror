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
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F961F404
	for <e@80x24.org>; Tue, 28 Aug 2018 20:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeH2AHp (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 20:07:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38789 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH2AHp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 20:07:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id h33-v6so2297652edb.5
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Wn74WqRRzh6sbtIf0XAJ5rtBbBXXrEv78I5hbw6SZdQ=;
        b=CaeGMUWMwu7em0s4GjOpxXKx1aZOYX25QrY4GH8HwtrdNeGlLfPXz2F4yxRUf8TEpc
         Hzr49fk1l/bmwCp80zb/dyuTtXI6ZhfgZHAFGeUcrk1DE+9ruKHy42FghvLcCQ++yUx8
         52rFb59viKWb3na7wVASaXoK5U/WxYdEwzMlHrlodWe7mFY2wMHKRsGY3Ol9S/bU6qgL
         rpZMnTr3XFW7VJ7qq7qy7iOpVQO/cAlO/WgyZdCvKb0FQLKqNVlmqMEdxfE2jI827XzN
         tO/c50TEAAYIwbxUa1GK9jhsFb5vMvWF0ZQWHUZFr7ECtl0Qy3O6/gmBHfyFIV8tYPt8
         U3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Wn74WqRRzh6sbtIf0XAJ5rtBbBXXrEv78I5hbw6SZdQ=;
        b=g2ODKhAkX8SeTSyOC3pCXP6XoK4w3xH2tRJ16v42kdTYi3M1UPlkbyAANsyJsQjfrE
         xvJzDSeBkhFRxR2BMi983Jymd5YPKemHg5j8o0czdhjWGYGLIAXLcSCVVjq3MLVPajOI
         90pnwXqQSvJXQ6xZ93ulsm/PvE/gKGxhvnQJG4yBqiWnNcaRpn7jbr+B/o+9uapT4uGw
         13uneSv9qXlRA5tG0n131z5zkxNunVRifuJYl90Ywm+A9enio+0rZevc1p8bOzi3+/w9
         mhZ82dSk15514VX/e1TfBY77vrt0MtGtJorTD+uHQ0nOjyDTDXu9hrpgWkMJUkHhnDhm
         SnPA==
X-Gm-Message-State: APzg51CCe+DlXmT2VzACSfpYkYk/Fc+qngvjOr/CHSjAlBQl7LKC7JoE
        CrKKcvATWZT834D1f207b/3Suqqe9Yk=
X-Google-Smtp-Source: ANB0VdbAcD/HnkjsNbdyTLWNyF7UtwD+A5+DE03HQhEluODLINooutomt1V8lpSoA9HpVKvzu1RByw==
X-Received: by 2002:aa7:d416:: with SMTP id z22-v6mr4247397edq.258.1535487269813;
        Tue, 28 Aug 2018 13:14:29 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id w2-v6sm1236493edw.83.2018.08.28.13.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 13:14:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, benoit@openbsd.org, kn@openbsd.org,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 4/6] tests: use shorter here-docs in chainlint.sed for AIX sed
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
        <20180824152016.20286-5-avarab@gmail.com>
        <CAPig+cQxUdr0g+i6AztcH4Q51X-W4MtdhKGv=wau+b6SFsniAQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cQxUdr0g+i6AztcH4Q51X-W4MtdhKGv=wau+b6SFsniAQ@mail.gmail.com>
Date:   Tue, 28 Aug 2018 22:14:28 +0200
Message-ID: <87a7p6dza3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 24 2018, Eric Sunshine wrote:

> On Fri, Aug 24, 2018 at 11:20 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Improve the portability of chainlint by using shorter here-docs. On
>> AIX sed will complain about:
>>
>>     sed: 0602-417 The label :hereslurp is greater than eight
>>     characters
>
> Shortening the names makes them ugly and often unreadable. That's not
> a complaint with this patch; just a general observation regarding
> 8-byte limitation with this platform's "sed" (and POSIX). See a few
> suggested improvements below, but probably not worth a re-roll.
>
>> This, in combination with the previous fix to this file makes
>> GIT_TEST_CHAIN_LINT=1 (which is the default) working again on AIX
>> without issues, and the "gmake check-chainlint" test also passes.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>
> FWIW,
> Acked-by: Eric Sunshine <sunshine@sunshineco.com>
>
>> diff --git a/t/chainlint.sed b/t/chainlint.sed
>> -:checkchain
>> +:chkchn
>
> ":chkchain"
>
>>  # found incomplete line "...\" -- slurp up next line
>> -:incomplete
>> +:icmplte
>
> ":fold" (for "fold out NL")
>
>>  # found nested multi-line "(...\n...)" -- pass through untouched
>> -:nestslurp
>> +:nstslurp
>
> ":nesteat"
>
>> -:nestcontinue
>> +:nstcnt
>
> ":nestcont"
>
>> -:nestclose
>> +:nstclose
>
> ":nestend" or ":endnest"
>
>>  # found closing ")" on own line -- drop "suspect" from final line of subshell
>>  # since that line legitimately lacks "&&" and exit subshell loop
>> -:closesolo
>> +:clssolo
>
> ":endsolo"

I was meaning to get to this with a re-roll, but since this is already
in next & these label renames seem cosmetic, it seems better to do this
after 2.19, i.e. the compiler doesn't care about the specific names, but
shortening them to <=8 fixes the bug.
