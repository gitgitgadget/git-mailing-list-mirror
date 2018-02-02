Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3F11F404
	for <e@80x24.org>; Fri,  2 Feb 2018 18:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeBBSJf (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 13:09:35 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39266 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbeBBSJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 13:09:27 -0500
Received: by mail-wr0-f195.google.com with SMTP id f6so21745329wra.6
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 10:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gZ+V5gXXzaL8I5CQeuWITOsdZkN6LLDaFt5LQRlpqpc=;
        b=k7xsqVvEIMTap/mm9TRbXhQE5CSq77poxfK/vr97xajU7VtbTrqX5tB0kMJFz7FStA
         tt3jxoWKe9nnATrV8lBwZP7IN2LwLykcVsXqzhwcuZ56kiLRr/N4xx9ZVyszO3xQfCzN
         ceVkelDnnLw0ulLwywOFkBRYnpjI/K9pVIUnW70TZCxf3If4icYryVbEhhkeWX5Uk5to
         TTnEfcASIIt+/JqL/eC6vTIn6D6cF0BiZonjhHUuFTleAawkFISKrksVOz3ewmyNdy95
         Cai8hT3x07jCmky3mRUiRHtkedj0LaeB4SGD0qldTFuiBLDqqo6p1YVG9N2nyTTmZH3t
         rFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gZ+V5gXXzaL8I5CQeuWITOsdZkN6LLDaFt5LQRlpqpc=;
        b=eAFloVqVDr0smiLHSpDv+QZ+nev+NpyiRKfbAxSPrlzoUAN983f/SfH7uRPf2quO3O
         n1dBSDR5HFU+P+TCovs1DVZPpEpfBWF5YJMYDf0ldl6g/EyKtbqikGqnZhLrAjoJL+ct
         Ai6eGZAoOgYTn095SoYBh7mp7o+Fmk2bxJbi+awtYsqJvrd3mCoUX0/Yc3EzkH9Tm++O
         Q+/adF1WiR1LMg9M/cIh5gaK8913+IlHjuz2aPWGXkLS/OvXEiM1xfjxSzs2FirxLk4z
         MPcP9MArHfwNzTgOtK5xrgegk5UgjbK53RWDqvqS4gZlzyWDORJ37iz6KdcnRd2i0WXb
         dtJQ==
X-Gm-Message-State: AKwxytdM+8hU4AUJ4TWI1ecBV23a4Evz9UtEzwqnQ2CyKoR9iosdFvgD
        mBrvV+W3tjISgdipcT8awxg=
X-Google-Smtp-Source: AH8x226xF+iRL278r9uF251bDPmayUUrMCY1Xej5SHoKMhMs1/5Wq+qgBOlubamI5GQrqgP6p+b8Jw==
X-Received: by 10.223.132.195 with SMTP id 61mr5605846wrg.187.1517594966016;
        Fri, 02 Feb 2018 10:09:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t4sm1221524wmt.16.2018.02.02.10.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 10:09:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com>
        <87mv0tm0l7.fsf@evledraar.booking.com>
Date:   Fri, 02 Feb 2018 10:09:24 -0800
In-Reply-To: <87mv0tm0l7.fsf@evledraar.booking.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 01 Feb 2018 12:05:40 +0100")
Message-ID: <xmqq4lmzqn57.fsf@gitster-ct.c.googlers.com>
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
>> * ab/wildmatch-tests (2018-01-30) 10 commits
> The 2018-01-30 series is the update mentioned in
> 87vaga9mgf.fsf@evledraar.gmail.com. You probably noticed this / just
> didn't adjust the note since you queued in in pu already, but just in
> case: the known issues in it have been resolved, but hopefully Johannes
> Schindelin can test it on Windows & report.

Thanks for a correction.  Very much appreciated.  Let's start moving
this forward then.
>> * ab/sha1dc-build (2017-12-12) 4 commits
>>  . Makefile: use the sha1collisiondetection submodule by default
>>  - sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
>>  - Makefile: under "make dist", include the sha1collisiondetection submodule
>>  - Makefile: don't error out under DC_SHA1_EXTERNAL if DC_SHA1_SUBMODULE=auto
> Do you want to peel of 4/4 and just keep 1-3 should I submit another
> version without 4/4?

Nah, let's just discard the tip one without prejudice and move the
remainder forward.

Thanks.
