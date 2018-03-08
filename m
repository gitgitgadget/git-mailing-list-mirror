Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496891FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 09:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933762AbeCHJlO (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 04:41:14 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38661 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755238AbeCHJlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 04:41:12 -0500
Received: by mail-wm0-f42.google.com with SMTP id z9so9743393wmb.3
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 01:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=e6JjiTZznwiyOp4KIoWBE+ouNlC+U6XCugfToIKOUAk=;
        b=pHirwfQeE8+xkGxN9eC7jpt3nd7ovGOewN9N9NCkRNYWLJxyIG6DX5xUbBdOAJSD3C
         e44E7yDMDdmYTSGO1vuR9vxy1vQ6pbwbhU9OM+Ri9ME558E/1kibCl7ykGHsYX/mA6n1
         5n3oJGvyBpDn3Bz+Patzh6d7PnKLgYlaP92wdrnfThNFlN2FH7c5B7TsKUGOlFTpxetO
         wMEcxN6NdE4XYuBthHFJxw58sl/lS3bDNrmantXATfYG9UKLh6Qu0dXgV79E1TPGOH5P
         Ul1FOfskGYB2g4/SnpuSuf04SvGCDbS6UJmZ+GdIrW+7J6bcQoMCnbWq4YMPZ0ADo8PX
         n6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=e6JjiTZznwiyOp4KIoWBE+ouNlC+U6XCugfToIKOUAk=;
        b=QHuyKW7uv7HQ+HoD5bIWuZ/N7GXNbaBdnyAubegBVMOGeZnSvxs34tk9ltCH2G3Y44
         V7Rqs261CYj6fX3MbMdaNtuaCfudywlgUy/Xxt5fbObe9vj4db+hSeD3jvAcAQ9pHyEX
         8KOD9Pw182xQFmkVoBHSP8OQ+0lAhOR3Tk6EuU3z4IcgFN6gIAjD1EkxuVibgDdejOxn
         rMn91XZWhU6KDM6iCeRwoJwB1Br/vNGB01++rNlCrcRZrdEQw01dcoPlh+8kNqOyaWAz
         UItQHYcSgkDJgZ37krBvxbJn12yIsM27IsYMUMIP5utJhLRGzIIIPcA4TryI0p26pC7C
         Dy8A==
X-Gm-Message-State: AElRT7ELPHTENEl/fThxiwK3DmIC6WWZAY7RgDcfeoEJSiG6MIgJS9Q+
        XE7Aiu0+jozd1Xj5QPoQfW4=
X-Google-Smtp-Source: AG47ELsNOGAAUwRC5f42R+XlhO8XxdgagrByTOLwbXv1CbnU03iX5JW9ckI0Uby1ybHqgn30utqQ2w==
X-Received: by 10.28.194.2 with SMTP id s2mr16271818wmf.55.1520502071642;
        Thu, 08 Mar 2018 01:41:11 -0800 (PST)
Received: from evledraar ([84.88.84.116])
        by smtp.gmail.com with ESMTPSA id s125sm12165623wmf.4.2018.03.08.01.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 01:41:10 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dorab Patel <dorabpatel@gmail.com>
Cc:     Alexandre Julliard <julliard@winehq.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] git.el: handle default excludesfile properly
References: <20180303034803.21589-1-dorabpatel@gmail.com>
        <CAPig+cR=adC_Ok=FJw2APaLahXX_v1ix4ufEJyBhED5ruXaQxA@mail.gmail.com>
        <CAE09B1+XXJvrOucHwehUGk=Taio7sirfOh5gq7KGs4iZSpK=vQ@mail.gmail.com>
        <xmqqr2oz9rka.fsf@gitster-ct.c.googlers.com>
        <87muzlwhb0.fsf@winehq.org>
        <CAE09B1LaKxk7CLaZ7M9vLFx7aJwUpxO25ZH4btXpYuwzo6sVyQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAE09B1LaKxk7CLaZ7M9vLFx7aJwUpxO25ZH4btXpYuwzo6sVyQ@mail.gmail.com>
Date:   Thu, 08 Mar 2018 10:41:08 +0100
Message-ID: <87y3j2nbuz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 07 2018, Dorab Patel jotted:

> Thanks for updating us with the status of git.el.
>
> The last time I looked at magit, it was too heavyweight for my needs.
> I like the simplicity of git.el. But perhaps it's time for me to take
> another look at magit.

You can also check out the VC mode that ships with Emacs itself. I
prefer Magit, but the VC mode is more lightweight.

> On Tue, Mar 6, 2018 at 3:54 AM, Alexandre Julliard <julliard@winehq.org> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Having said that, I am sorry to say that I am not sure if the copy
>>> we have is the one to be patched, so I would appreciate if Alexandre
>>> (cc'ed) can clarify the situation.  The last change done to our copy
>>> of the script is from 2012, and I do not know if Alexandre is still
>>> taking care of it here but the script is so perfect that there was
>>> no need to update it for the past 5 years and we haven't seen an
>>> update, or the caninical copy is now being maintained elsewhere and
>>> we only have a stale copy, or what.
>>
>> This is the canonical version, and I guess in theory I'm still taking
>> care of it. However, the need that git.el was originally addressing is
>> now fulfilled by better tools. As such, I feel that it has outlived its
>> usefulness, and I'm no longer actively developing it.
>>
>> I'd recommend that anybody still using it switch to Magit, which is
>> being actively maintained, and IMO superior to git.el in all respects.
>>
>> --
>> Alexandre Julliard
>> julliard@winehq.org
