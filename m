Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 260E41F404
	for <e@80x24.org>; Fri,  9 Feb 2018 18:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbeBISy4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 13:54:56 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42250 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeBISyz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 13:54:55 -0500
Received: by mail-wr0-f196.google.com with SMTP id 41so9236503wrc.9
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 10:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XXuk2j0PTFuXqse28Jis7qRKK7a8F3wsCnx95s1aZys=;
        b=ok2nSp/Ok8gHNWnp5ex1fgLH47TwXHYwzjlzT+EUiIoabSzpgFV8+DOnYImX2hmlYI
         gtVTks6iMtnMfl2QolRlC+J1hkJUyoN408Ud9hCijywsk3/le3M07BEtA+pwTLiEu0mK
         0YZyHsQAC8y/8GCggQdH4GehzXz61OKnLdjphD/aMxCgkhyZzWzdPAV44vgAqLFWJVRj
         VKj8ZyEuRW4E+u4FBteHGEjdZ1RrqYrJGe6BGrpbf9jd9/ykpkN3AtbjxczO8cR08jI1
         Jkw3QMtFS5U1Et4DRviSjo42pjLZpvHtL2D4KqDYcdtacfxaowpSfihBHXLmAAdmPA/W
         b+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XXuk2j0PTFuXqse28Jis7qRKK7a8F3wsCnx95s1aZys=;
        b=EXAA1MqUc9s22labVXe1/nnt1CYb1ivJVi/Pv2WWZwuT60BZAWERHVqN4NrsiF0iPN
         TCLcQTKAcM5M0tmQ+2MOUXbEhoFPrvBEvaVii/p6jMm/WVoN8M1NaeDvGW4EsUWv9vC+
         wJStyN0hU2DtrgqKLzm54rGskGqA6b+KxNGGVJhLsieGrVMnszvze/5yzBOLHYl27V0F
         KBa3bJhijRP29kTL53EUxvm1YHDCdOwqn5PukroKoloTjOpz63kmOV99V2Bx/wROrRoS
         CI1u0Ge5TXGM2BvqyqjzFC6TOJY2cknRLWmgUCXfvX2uxMdXF7NgVqJe9ya0nLjcy7qk
         t+NQ==
X-Gm-Message-State: APf1xPA3b9YG/i8LpxhPHJ+FTeAUBesY3VdiDqvpkVdNkVtZvDyJj/7p
        tqYj6DWmlBf1zMghcWEqUUc=
X-Google-Smtp-Source: AH8x226zXHPE5RuVZ9LzxO1KEda4L4zk1sUbDqv2a6zp1gWX/AKQJHpNQEkD0gyc2ewheqSFN2iJ/g==
X-Received: by 10.223.160.176 with SMTP id m45mr3225089wrm.119.1518202493624;
        Fri, 09 Feb 2018 10:54:53 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l2sm2609838wre.6.2018.02.09.10.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 10:54:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com>
        <87372am2ls.fsf@evledraar.gmail.com>
Date:   Fri, 09 Feb 2018 10:54:51 -0800
In-Reply-To: <87372am2ls.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Feb 2018 19:37:03 +0100")
Message-ID: <xmqq6076xabo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 01 2018, Junio C. Hamano jotted:
>
>> * nd/fix-untracked-cache-invalidation (2018-01-24) 5 commits
>>  - dir.c: stop ignoring opendir() error in open_cached_dir()
>>  - update-index doc: note a fixed bug in the untracked cache
>>  - dir.c: fix missing dir invalidation in untracked code
>>  - dir.c: avoid stat() in valid_cached_dir()
>>  - status: add a failing test showing a core.untrackedCache bug
>>
>>  Some bugs around "untracked cache" feature have been fixed.
>>
>>  Will merge to 'next'.
>
> I think you / Nguyễn may not have seen my
> <87d11omi2o.fsf@evledraar.gmail.com>
> (https://public-inbox.org/git/87d11omi2o.fsf@evledraar.gmail.com/)
>
> As noted there I think it's best to proceed without the "dir.c: stop
> ignoring opendir[...]" patch.
>
> It's going to be a bad regression in 2.17 if it ends up spewing pagefuls
> of warnings in previously working repos if the UC is on.

Well, I am not sure if it is a regression to diagnose problematic
untracked cache information left by earlier version of the software
with bugs.  After all, this is still an experimental feature, and we
do want to see the warning to serve its purpose to diagnose possible
remaining bugs, and new similar ones when a newer iteration of the
feature introduces, no?
