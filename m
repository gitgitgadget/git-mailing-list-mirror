Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A389C20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 02:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeLNCSd (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 21:18:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40903 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeLNCSd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 21:18:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so4289485wmf.5
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 18:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KQ/+cWhP6omMG9s8ioLTTaM4TSmMNjOD1ZR/tfrmKEs=;
        b=g+wb+yn7kERNjjR8Nscz7/h/GnIeSyUxqb0IZhz8Jf5ahISJMhmklcJ6yyxYpBxPOW
         9NJGKneXkhysIWIWb/3FoHhlG4rBuhtUe1dOsZAOcKBsmeQ2fxkkS8cxy3M2U3VNFhWK
         VefvWN/upoMsdF1S5Lu0pCTxkxIxSR/AVGcwZYHhWvu+icWSwGqxJh4Kk7T/Fs0A3WzH
         KTKjh1xuPB/cTbSfpLrWDpjZODPFSGvQx9T79m91lCdIBEv3PjyJWM8Jw2Esj6dHSH/W
         ZbN2HYAvnQZhOKbwrfmdixFZ8bGFy0EJplLqEkjdGXQh2Mdo3eqG+r7fNjr1Jk3ghT8b
         gdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KQ/+cWhP6omMG9s8ioLTTaM4TSmMNjOD1ZR/tfrmKEs=;
        b=SAp4h4BLf4IaI9VFB39T4cu//zNUlfOC1iMf6FTSOzlWYMwU+0rTiGR8YsZ/ib3EEr
         tJuYtIJHIMiROSJdWlYEdkbkOy1Q+Twd2kxZckrD9++mkEpkR00vCe7FtRu8R0k9t3er
         zNq4UU5ucwjG+biVmPoz1ziPKKgXxmdlY3gpp0o5swq8HhUC0rumXyg+926XEu3uaNbL
         jIgMAEk5twMsc+zxOvSpWCgr4+7ASzWEBRHgkT7f1f0FeHbBioKjbmH9E/1+GHXswFpz
         naOOqT7vz7mA9TLu2Wr5k0/aQsFbehRrVGrR7Mi72yrOo55EdPG+Qgv8P3OlaW77eeWM
         enpw==
X-Gm-Message-State: AA+aEWa5xsAaV+13PfHWJjLf0mAZRRuUlcmY6NgQmQv/GtySvfYPqEVl
        C/ah1aYhtlLlPMS23lATlAc=
X-Google-Smtp-Source: AFSGD/WKdOzTBpgNxyciDI8lQgKA+zG/OjVmWZaKBH1wcNOXX8Pz/NzGJ/Gu74ZY1jguI7qEJ8KrTQ==
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr1614448wmi.39.1544753911279;
        Thu, 13 Dec 2018 18:18:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l8sm2490033wrr.60.2018.12.13.18.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 18:18:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
        <20181213155817.27666-9-avarab@gmail.com>
        <87pnu51kac.fsf@evledraar.gmail.com>
Date:   Fri, 14 Dec 2018 11:18:30 +0900
In-Reply-To: <87pnu51kac.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 13 Dec 2018 17:08:43 +0100")
Message-ID: <xmqqftv0etqh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> +	# Other protocol versions (e.g. 2) allow fetching an unadvertised
>> +	# object, so run this test with the default protocol version (0).
>> +	test_must_fail env GIT_TEST_PROTOCOL_VERSION= git -C client fetch-pack ../server \
>>  		$(git -C server rev-parse refs/heads/master^) 2>err &&
>
> What? So the equivalent of uploadpack.allowAnySHA1InWant=true is on for
> v2 all the time?

UnfortunatelyYes (see Peff's three-patch series).
