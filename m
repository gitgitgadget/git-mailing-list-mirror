Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B9C1F424
	for <e@80x24.org>; Sat,  7 Apr 2018 07:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeDGHcC (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 03:32:02 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:39646 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeDGHcC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 03:32:02 -0400
Received: by mail-qk0-f177.google.com with SMTP id j73so3696133qke.6
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KiGTflL8O4vpV6s/cI2tXIiS3I/9DsVmHRDzl7c5+04=;
        b=req8NkO6PekDSS6iJVXS3W70j2MwUo5flrbgmH/dIdiJxufNGuHLjqOyH3ifuwaCwp
         g8VGjUCQR/gI/DWFAOHsexcdm32ylft4//yGik4EsE9gfrXwfpYL/+T5NnjKVbo9iizw
         GXHeSQCOXEiRAeInimjy5+u4Gmh8tDj6pHAby/nVwLvzD3xA140okIR5500zw3kOQHNQ
         giPGtimXG2qL1PKZKHIyDEkGIj21pWsThhziffmMt7l57pGjo8F7HGOkqPG5ooBh1j8e
         WiAp2jj3MEuWu/Zts5mbpxCpU7AhSUoIzEhrw2HtT2lKCiugFO5b1bLmwDEt/oHRrcLK
         AP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KiGTflL8O4vpV6s/cI2tXIiS3I/9DsVmHRDzl7c5+04=;
        b=fu808M+x2JEEeEC5O0T+kw02HthWDKxa7PM4UzFjPCXc2GguS2godKcU/xs9eriTBw
         8E7zAbNNy/zVI5vSgAYvkuGa8adI6RVpKtp2wz7xZ9/4LkXmsFIsHGpHUDhxBuOm726b
         EWxxolRuAwm80CcA3sBqYngfGz3zo5KG1phmoXqqxfCXGDeK9VmVJOmysqP50rNNuT7i
         SNkxLVt5tUMRI0qKr8ibWkdq+aw0YajYxbsBzfw2vnoXjO69KRMcMMvKEMe7Ed2JW29x
         0lkDC8LF2HFkF9F7M4/SuKnMO8w50yQIpNlxQgos2KJkv1+lZ6L6/Hsw1+wl5QCktOg3
         OEyg==
X-Gm-Message-State: ALQs6tB50WN6C8nIHJchStLAzhWM8ocaRHycUKDPl2z06Kex8xE6Igmi
        8zN72Qe/M9f0JMHlcYaOVQxJD+kMGS/j7ldBjOmRhQ==
X-Google-Smtp-Source: AIpwx48X91ekB2M5UASHkTV5hiy2R0OnPxZ+YaKKKxdHf39HzfQQH7yvU8Bea/l5XJWudkOPHKrId7DJ+nLM27VNkjY=
X-Received: by 10.55.108.69 with SMTP id h66mr39381912qkc.42.1523086321302;
 Sat, 07 Apr 2018 00:32:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 7 Apr 2018 00:32:00 -0700 (PDT)
In-Reply-To: <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com> <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 03:32:00 -0400
X-Google-Sender-Auth: 3OnvmGdo7MLM-bYrXuB-CFmEEjY
Message-ID: <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Igor Korot <ikorot01@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 10:20 PM, Igor Korot <ikorot01@gmail.com> wrote:
>>> dyld: lazy symbol binding failed: Symbol not found: ___strlcpy_chk
>>>   Referenced from: /usr/local/git/libexec/git-core/git
>>>   Expected in: /usr/lib/libSystem.B.dylib
>>
>> It's not clear what installer you used? Was it the package from
>> git-scm? Was it from Homebrew?
>
> I just tried the git-scm installer and got exactly the same error
> during the runtime.

Have you tried any of the suggestions at these pages for resolving this issue?

https://stackoverflow.com/questions/22920497/git-mountain-lion-dyld-lazy-symbol-binding-failed-symbol-not-found-str

https://stackoverflow.com/questions/20929689/git-commands-not-working-in-mac-terminal-dyld-symbol-not-found-strlcpy-ch

>> I would guess that, even if the git-scm installer no longer supports
>> 10.8, it is likely that Homebrew does. Have you tried it?
>
> I don't want to pollute my system with Homebrew.
>
>> If both those options fail, you can always build from source.
>
> Where do I get the soure code? And how do I build it?
> I guess I have only one option left. ;-)

Source code for the latest release is at:
https://github.com/git/git/archive/v2.17.0.zip

To build it, you'll need to have the MacOS Developer Tools installed.
It's also quite likely that you'll need to build some prerequisite
libraries; at minimum OpenSSL. You may be able to skip other libraries
if you don't care about the functionality. Build settings which you
may need to adjust to disable dependence on libraries in which you're
not interested are documented at the top of Makefile. Place overrides
for those settings in a file named config.mak in the git directory.
