Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB7E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbeHOUDn (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:03:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53616 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUDn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:03:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so1994582wmh.3
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4bp8o6akQwM/1km9cFkVKvJvRxb0FF5C/lxsnY9E9Qo=;
        b=l3X3ZO369SXr5Klr0b/ZW/6OfLNK4ZJzYoEHZtq7JdUT93D2uFg6u2u5tPcWlzKXYO
         38QrQkANtQznfvQ9zJGWb4+O3fO2kar7gl8Zs0LFkzqg+/stxwDMffL+aIfLLTReqiZr
         No2Vxfsr21fU4TXfwpaXLU6KDmDoRH4Tz/hF53s4dBQ91/S1koyTvppCm+4vMbOfKaFT
         dFEhjyptOToTZHp3tctJnVJYVT1JF0oUStXKdxTHb1eWBYlgH+6PQW/7aQckXu69S4uJ
         EuyaI6ktv+XbhIbm/qUpQpLPhEnaFmdhCjFIQu2OBx4vNsmUw9frAKZ0u13Ff6oSVbN2
         MgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4bp8o6akQwM/1km9cFkVKvJvRxb0FF5C/lxsnY9E9Qo=;
        b=nHxcvkvqPNXfbM52HTpD96oYxXheIylEPvOix4P/7pRf9Fb2qFWv7+F1EFTz+Dcm1D
         KPKJQ/KTCJMhHDCPl6QOo3C9wJBOVA4NnT3BkH2Q7oKan1pKBDHZDca+7/fufk8FGkVJ
         KmzwqXCSKAQ9hK/34xZubGyb03XV1bXCAlPlI7pIh0A1AtY4ttT+ohWvzFsqCjBSa2AW
         42/++vnBwJnvDyjokbHJdp7u4s5k85z/3w0Nher0m2/M2G/bEuaa6t1pNa3kfPzJlPBG
         5ID83HTi9230GZ86/Ce40UZtJbsdQw+Myih9WNWyjZPuW+836HB4ZL76bnfVBSvGsZp1
         o3xQ==
X-Gm-Message-State: AOUpUlEkpYUkb3G4G/6SCjCPBZEa7cnn1mZjr5MKnNz59r+5OR5+UPQJ
        R3pO/HOPGTkzfGlPBLyYOQ8=
X-Google-Smtp-Source: AA+uWPxhGQDNbJ0YMIHb5gxPPznpBC2i6ZGQBR70kJtqj8LaX76jeYZfkBK8rmirgqr0NHFOY3rHvw==
X-Received: by 2002:a1c:228b:: with SMTP id i133-v6mr14553415wmi.69.1534353042023;
        Wed, 15 Aug 2018 10:10:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f17-v6sm16829012wrs.1.2018.08.15.10.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 10:10:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eygene Ryabinkin <rea-git@codelabs.ru>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH] Makefile: extend NO_TCLTK=NoThanks to cover docs
References: <20180815151505.12011-1-avarab@gmail.com>
        <xmqq7ekrk1q0.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 15 Aug 2018 10:10:41 -0700
In-Reply-To: <xmqq7ekrk1q0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 15 Aug 2018 09:56:39 -0700")
Message-ID: <xmqq1sazk12m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  # Guard against environment variables
>>  MAN1_TXT =
>> +MAN1_TXT_WIP =
>> +TCLTK_FILES =
>
> The latter name loses the fact that it is to hold candidates to be
> on MAN1_TXT that happen to be conditionally included; calling it
> MAN1_TXT_TCLTK or something, perhaps, may be an improvement.
>
> The former name makes it look it is work-in-progress, but in fact
> they are definite and unconditional part of MAN1_TXT.  Perhaps
> MAN1_TXT_CORE or something?

Sorry, I misread the patch.  You collect all possible MAN1_TXT
candidates on _WIP, so "this is unconditional core part" is wrong.
Work-in-progress still sounds a bit funny, but now I know what is
going on a bit better, it has become at last understandable ;-)

>> +ifndef NO_TCLTK
>> +MAN1_TXT_WIP += gitk.txt
>> +MAN1_TXT = $(MAN1_TXT_WIP)
>> +else
>> +TCLTK_FILES += git-gui.txt
>> +TCLTK_FILES += gitk.txt
>> +TCLTK_FILES += git-citool.txt
>> +MAN1_TXT = $(filter-out \
>> +		$(TCLTK_FILES), \
>> +		$(MAN1_TXT_WIP))
>> +endif

I didn't notice it when I read it for the first time, but asymmetry
between these two looks somewhat strange.  If we are adding gitk.txt
when we are not declining TCLTK based programs, why can we do
without adding git-gui and git-citool at the same time?  If we know
we must add gitk.txt when we are not declining TCLTK based programs
to MAN1_TXT_WIP in this section, it must mean that when we do not
want TCLTK based programs, MAN1_TXT_WIP would not have gitk.txt on
it, so why do we even need it on TCLTK_FILES list to filter it out?
