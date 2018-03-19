Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 164FB1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 18:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968247AbeCSStG (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 14:49:06 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33149 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970180AbeCSSs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 14:48:58 -0400
Received: by mail-wm0-f51.google.com with SMTP id s206so13989368wme.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8iqMad6WfgPleV5Gwhr9vqG/uzhrSm3aZQJPwuFMfKI=;
        b=jyiz5Qz6RKL1Zo8g7Y+DQa0myo5bSBowZJkWCaB8d75MA7A7NS265FqQKOXyq5bLqU
         UUpLyKxagmi/rtsvjjtVtkpzKlYJHzujAC3ZG0jjjccEGCPuaDwTfdVIC+pazyfuTwml
         gSWMskKN0CdfVGBy2lp3DhZLfMY4MJIaS/vv4d/QrOCn243x8bFnoB9/xu9xlx+y150g
         ARG8JrztNts8BcAZ5g6jvEiuG2qWc0ghwe1I+BjaguepqWgUMUSVCFGv/xOzG0SlMV6K
         W3jder1qJlFci+OUBpFxrQ86t38RfG02OW62VDbZdEXwwW50tGBRa1ReXpPhxnzUcF4d
         MOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8iqMad6WfgPleV5Gwhr9vqG/uzhrSm3aZQJPwuFMfKI=;
        b=R2M0wCrRgwriB7/IEJrKFnfqkx/yaXQ5Ha0phBs8kgh7aaC4+LE8QB7q3DxBAvfKSr
         MXOIE3Z+YYkzGdT3rEJjkwmNCv33oPmZGmvqn7Ge4jXVPdIyXJ3UDgFE+8hUhbabLrsH
         XBndIeNo3tQCTWjhqo7zZb/g4icEuAiNWNedJrTTf4otT0OYtqsU6RkIx2qgtRMMcnXl
         NagQoTpXV+2gPsEZ0eYLymR52n+xifstM3UhHKpJOVxfjed7Eb6CYnwExz9GVZ56hPEA
         UWK80qw7r6AL9LBqh7w67EvqZusCHsAGGDI9PqUYGvTYGJjxnXTlQajh2DhmSjYUNS/g
         r4Nw==
X-Gm-Message-State: AElRT7H7xvqGdzqXjGw0bm7KjqK2KBiekc/2QHvhSamnjInS5006esaF
        HtIIIEIvU5RQYMoXht7AOTxdkmfX
X-Google-Smtp-Source: AG47ELvv5MrDpTyLtdxQFWT8NqXL3ktzbt76UF9O4U90M5XXqHyVyJVJ6osjS7zEJtB805b9uGx5lA==
X-Received: by 10.80.230.14 with SMTP id y14mr14564093edm.307.1521485336804;
        Mon, 19 Mar 2018 11:48:56 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id h1sm587671ede.2.2018.03.19.11.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 11:48:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 07/14] commit-graph: implement 'git-commit-graph write'
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
        <20180314192736.70602-1-dstolee@microsoft.com>
        <20180314192736.70602-8-dstolee@microsoft.com>
        <87bmflcy8a.fsf@evledraar.gmail.com>
        <5e394b91-fa78-5b70-8c5e-b06cc332bb3a@gmail.com>
        <874llccetp.fsf@evledraar.gmail.com>
        <0c2f17fa-5c0e-9539-a081-7827a6678bf1@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <0c2f17fa-5c0e-9539-a081-7827a6678bf1@gmail.com>
Date:   Mon, 19 Mar 2018 19:48:54 +0100
Message-ID: <87370vdhpl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 19 2018, Derrick Stolee jotted:

> On 3/19/2018 10:36 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Mon, Mar 19 2018, Derrick Stolee jotted:
>>
>>> On 3/18/2018 9:25 AM, Ævar Arnfjörð Bjarmason wrote:
>>>> On Wed, Mar 14 2018, Derrick Stolee jotted:
>>>>
>>>>> +'git commit-graph write' <options> [--object-dir <dir>]
>>>>> +
>>>>> +
>>>>> +DESCRIPTION
>>>>> +-----------
>>>>> +
>>>>> +Manage the serialized commit graph file.
>>>>> +
>>>>> +
>>>>> +OPTIONS
>>>>> +-------
>>>>> +--object-dir::
>>>>> +	Use given directory for the location of packfiles and commit graph
>>>>> +	file. The commit graph file is expected to be at <dir>/info/commit-graph
>>>>> +	and the packfiles are expected to be in <dir>/pack.
>>>> Maybe this was covered in a previous round, this series is a little hard
>>>> to follow since each version isn't In-Reply-To the version before it,
>>>> but why is this option needed, i.e. why would you do:
>>>>
>>>>       git commit-graph write --object-dir=/some/path/.git/objects
>>>>
>>>> As opposed to just pigging-backing on what we already have with both of:
>>>>
>>>>       git --git-dir=/some/path/.git commit-graph write
>>>>       git -C /some/path commit-graph write
>>>>
>>>> Is there some use-case where you have *just* the objects dir and not the
>>>> rest of the .git folder?
>>> Yes, such as an alternate. If I remember correctly, alternates only
>>> need the objects directory.
>>>
>>> In the GVFS case, we place prefetch packfiles in an alternate so there
>>> is only one copy of the "remote objects" per drive. The commit graph
>>> will be stored in that alternate.
>> Makes sense, but we should really document this as being such an unusual
>> option, i.e. instead say something like.
>>
>>      Use given directory for the location of packfiles and commit graph
>>      file. Usually you'd use the `--git-dir` or `-C` arguments to `git`
>>      itself. This option is here to support obscure use-cases where we
>>      have a stand-alone object directory. The commit graph file is
>>      expected to be at <dir>/info/commit-graph and the packfiles are
>>      expected to be in <dir>/pack.
>
> A slight change to your recommendation:
>
>
> OPTIONS
> -------
> --object-dir::
>  Use given directory for the location of packfiles and commit graph
>  file. This parameter exists to specify the location of an alternate
>  that only has the objects directory, not a full .git directory. The
>  commit graph file is expected to be at <dir>/info/commit-graph and
>  the packfiles are expected to be in <dir>/pack.

Sounds good. Although I think we should add

    For full .git directories use the `--git-dir` or `-C` arguments to
    git itself.

I.e. for documenting an unusual option it makes sense to have docs in
the form "this is bit odd, usually you'd use XYZ", rather than just
"this is a bit odd"..
