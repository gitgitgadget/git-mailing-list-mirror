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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1343520248
	for <e@80x24.org>; Tue, 12 Mar 2019 21:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfCLVBm (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 17:01:42 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35436 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfCLVBl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 17:01:41 -0400
Received: by mail-ed1-f43.google.com with SMTP id g19so3565254edp.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 14:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AJ0fJpJQaFHjetlBucfLpfmVD0ThlxF6Zrvd22E3gpE=;
        b=nkbEW4IDDoKHWV/2fEGh94qoq66J8wld2SiELyhB/6LBk83Pwbpyo/lyrb8VApMucv
         DgV2pKlfb+KuVTyLnFIPKcBq7s3KedMaovTtLwWVo5uFiJ55TXYp28tGrHeo7ipNcIqq
         vdhI6a01gZOfAAlFWHH4ZzIaAcF/YIRDrN/eP/2rLNh4im+PkgcD1KmIXEI0cm5ol45z
         Ae9pKO73Pjga8OPC0HIY8F3kmCpE2DM4g1RV/dzPmwjz6SyA2l8HYme70ptJuyf9pwb+
         2E+PXWjgtLN6Ei7bdMRfiWioY9ACFYb69J3BXc+WMtv9ERZ26dx4xzaF5t+hCgcssZxI
         4TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AJ0fJpJQaFHjetlBucfLpfmVD0ThlxF6Zrvd22E3gpE=;
        b=iWOn1nZ+FlI9dYm7KSU99P4u4UlIaiApmrbVEX41jnLhGlSFOKx905HZ12KqJTTcOu
         DexQ2pnw7YwThHCgZ84ZkZ4XgV6QqMYLX0UjSQ0nM111ak2UX6ZbZTWkVmUV5ZDYHbZr
         Rh612Q72LD9b++HWGjYtoy5qbHb5zQBJDog04tVIMfhNYEj/T4to8dkqJ3odVojO8znq
         1oegdOHHrp3OY9MxuKTmjlm4pElWJV9d1Rdmuz8wO2ZOTZndnoyfWEaHjIn2/jWR8I4L
         5IVtBtCPV4qsFyGigt0Buep+j9eA2VWSHD+bv2Fx5QLe7ejxsydBP0lj0yxV94ud18jz
         c+UQ==
X-Gm-Message-State: APjAAAVwEVBUSVmNcRZQ1sj4/NbU2yAGjt2pYedKDQlYGgunO1DMn8Wo
        AeLa0swFT3Sbm/1/37Wygsk=
X-Google-Smtp-Source: APXvYqz60ATqSe6YEPEWtc8aYHJTOSnWJtWWCaWrAohvjgkp5pltEuC3t8STxjcit0pKkWGLzmWY4g==
X-Received: by 2002:a17:906:6991:: with SMTP id i17mr4223980ejr.96.1552424499878;
        Tue, 12 Mar 2019 14:01:39 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b24sm5898695ede.93.2019.03.12.14.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 14:01:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        vincent.guittot@linaro.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecating git diff ..; dealing with other ranges
References: <20190311093751.GA31092@archbookpro.localdomain> <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com> <87va0orop4.fsf@igel.home>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <87va0orop4.fsf@igel.home>
Date:   Tue, 12 Mar 2019 22:01:38 +0100
Message-ID: <87wol3bydp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 12 2019, Andreas Schwab wrote:

> On M=C3=A4r 12 2019, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I however think it may be worth making sure that our docs do not
>> encourage "diff A..B" and teach "diff A B" when comparing two
>> endpoints.  That can be done without changing anything in the code.
>
> The nice thing about "diff A..B" is that you can c&p the output from the
> fetch run without the need to edit it.

Not to shoot down this effort, just to add another similar thing I do
regularly for ff-branches:

 1. Copy/paste A..B fetch output
 2. git log A..B
 3. ^log^diff

I.e. I just need to tell my terminal to re-run the same "log" command
with "diff" instead of "log".

Of course as covered in the linked thread it doesn't work for some
(non-ff) cases, and I'll sometimes end up cursing it and swapping around
".." for "..." with log/diff.
