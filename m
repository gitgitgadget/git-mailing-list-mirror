Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1966C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 08:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiGPIJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGPIJU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 04:09:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9442D10558
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 01:09:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fy29so11447189ejc.12
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dDdeAV+iFnOeTe4gMFda64Kw4+BrNxuXGs4Kx9sHoaI=;
        b=GfEcJfvUIhrMTHWNOWyK8Q3AfOmOdKRTAA+X++boAvIofRQ+o2wGcylb2ltid7VqBe
         nC1l/mKK4DnGPGWBlKMFWAYQGUgoVL0qK8bpM+2DbQ8rH0dvvYZJZCuuD3xHw0589qwW
         H4RDKf8BhbBQmfjznueiu/uqw0PHZKitjRVkuO7GmwQ9gzkVQJWmTeesPWTS2HxBdptd
         msopoa7KgJwiEOVcSWpJPXolzGe6V7A6yHraUtWmmQCsm75JUiwWFveBSxegEJFAFEWt
         1XJjp/vm+MO1vBNJj+FDyiMSFbWIxVOsQMadlEmJQubh1qV8zkZjezS29tH22wRvvuK5
         Avuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dDdeAV+iFnOeTe4gMFda64Kw4+BrNxuXGs4Kx9sHoaI=;
        b=FYj3qaE/XVQecSissXWlFhUTS1Q8M557mnp+8eJTlnZCa6+COsudnAShyv/CY/n+pZ
         I4XoeRqQcL0pR9fkNl/4N3Pvxn69YbzHriay/wlRQY7ivh9n14F7srIu35w16BzNUbPX
         toSRl/ohP4jDUgqriLB5xAI/2t+GZ6W1RI+RC+FYqegTQLont/u4bg1lxZYEh4obAtLP
         CACjkmdjYtbHBydRQJhuqW57Crfz7My2jGn9tuvVZVjKDirAnjcBloDlVsi7ZKVVlWpv
         e1dFAYqFxjjk5JrJ3TJZQHEOI6PKLFTrz42v2HlsTPOVX8fjnnI804ClwyAck+H5bL4z
         pflg==
X-Gm-Message-State: AJIora9Rl/Phjixx2IZ9NVtiTviwso+I5Sdhc9K9DMp4FHWaPu50GDcD
        e9Z67HxE2JvjH/3PyMIF52U=
X-Google-Smtp-Source: AGRyM1t3oIIlH/1nPZdhUsdBKAt/jl+ACMNetWoT+NuxEGh7fiJ6tlGyV4aZCD88bYyxOsh+X24feQ==
X-Received: by 2002:a17:906:f51:b0:6fe:cf1c:cdbf with SMTP id h17-20020a1709060f5100b006fecf1ccdbfmr16827934ejj.695.1657958958053;
        Sat, 16 Jul 2022 01:09:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b0072b14836087sm2902275ejo.103.2022.07.16.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 01:09:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCcrU-002tCn-8H;
        Sat, 16 Jul 2022 10:09:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-repack doc: remove discussion of ancient caveat
Date:   Sat, 16 Jul 2022 09:59:17 +0200
References: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
 <xmqqsfn21fmt.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqsfn21fmt.fsf@gitster.g>
Message-ID: <220716.8635f1zdg3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 15 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The backwards compatibility caveat discussed her hasn't been a concern
>> for anyone after Git v1.6.0. Let's simply remove it, I daresay
>> nobody's concerned these days with having git clients running older
>> than 2008-era git.
>
> For the purpose of this message, Git 1.6.0 has no significance.
> Anything newer than 1.4.4 should be able to understand packfiles
> that use delta-base-offset, even though they may not have used
> delta-base-offset when writing a new one.
>
> That's all academic.  I wouldn't have written the above if the
> proposed log message stopped here.  But with the rest of proposed
> log message that hints that the above statement is backed by a solid
> study of history, it is wrong to write a wrong version number there.
>
> I agree that it is safe to say that anything before Git 2.0.0 is
> irrelevant at this point (I would actually say before Git 2.16.0,
> i.e. anything older than 3-4 years).

1.4.4 is the version that introduced the flag, but the paragraphs I'm
removing is relevant to 1.6.0, as it discusses concerns with that
new-in-1.4.4 --delta-base-offset flag being turned on by default.

So this documentation matches e.g. the RelNotes update you made in
e903b4095a0 (Update draft release notes for 1.6.0, 2008-07-01).

I.e. 1.4.4 was released in late 2006, 1.6.0 in mid-2008. Hence the
mention of "git clients older than 2008-era git" not being a concern.

I.e. the target audience for this bit of documentatino is someone
running 1.6.0. or newer that's also concerned about pre-1.4.4.

>> See b6945f570ac (git-repack: repo.usedeltabaseoffset, 2006-10-13) and
>> 9f17688d93c (update git-repack documentation wrt
>> repack.UseDeltaBaseOffset, 2010-02-04) for the commits that previously
>> introduced and adjusted this documentation.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/git-repack.txt | 10 ----------
>>  1 file changed, 10 deletions(-)
>>
>> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
>> index 0bf13893d81..fe1eac37090 100644
>> --- a/Documentation/git-repack.txt
>> +++ b/Documentation/git-repack.txt
>> @@ -218,16 +218,6 @@ CONFIGURATION
>>  Various configuration variables affect packing, see
>>  linkgit:git-config[1] (search for "pack" and "delta").
>>=20=20
>> -By default, the command passes `--delta-base-offset` option to
>> -'git pack-objects'; this typically results in slightly smaller packs,
>> -but the generated packs are incompatible with versions of Git older than
>> -version 1.4.4. If you need to share your repository with such ancient G=
it
>> -versions, either directly or via the dumb http protocol, then you
>> -need to set the configuration variable `repack.UseDeltaBaseOffset` to
>> -"false" and repack. Access from old Git versions over the native protoc=
ol
>> -is unaffected by this option as the conversion is performed on the fly
>> -as needed in that case.
>> -
>>  Delta compression is not used on objects larger than the
>>  `core.bigFileThreshold` configuration variable and on files with the
>>  attribute `delta` set to false.

