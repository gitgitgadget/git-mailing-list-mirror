Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586A11F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeBIVNt (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:13:49 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40953 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753026AbeBIVNr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:13:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id v123so18669378wmd.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 13:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KeSNKOgR6ZX4KDhLcncf4hkJD+UZXNHOtoHOK6Nq2VM=;
        b=q6nVAPmzzKRz4ia42eRHNqBOsLE+lTpOptAU7WJtk2Nt6zG6uAwqiTsRZxBikqh+rc
         RGJfP7BU0yjLU+k/dRZI6BYOAxoUxpI0ziveN24dVuWXZn5wvDu7fa/ja1JCfpbZSe+m
         umBTH8IAJI7VX2+8YwDIHwuVY5OQJCis84tXTB2Uxw7fpP9dvXqco8fHJ7M0Lqr1TPx4
         UAHsLOT2vzdc6btvjDM/37XMy6xhBbpo+i38jwvXryd8Oi5nieWmb1MGGBqBKcQqlZGR
         eA7NqiXCRLpt9RMv8tGeeKPP4nXRP9+H+BEiQGoFBajYTgLxCRXsTJPfXm67rWjxt2op
         xCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KeSNKOgR6ZX4KDhLcncf4hkJD+UZXNHOtoHOK6Nq2VM=;
        b=NjJbhVcERay8AFRKWXEJoIWDPybRlN18kcSwAjExFX/Mo+7wOJ3Xhh59OVFG2pd0Ni
         hjKt5z51kd9t6t7EMR08bLfCzBiZA+gWIv8RiD9ZpXG1ON4ACVa1wwImmupXwEN9liTk
         wgUccD9qet4XsAPpRbaW7vFdJn8wHTbwd+k1OKS+Kg1RR0xjrylfQGQSu3NMztkTJ3pn
         bZCwu5dT9Wa3EPEj0+fOW8BM2qYiAEtbl7mBz9DsTe4DHWNYlEcEtBMgiTPuveiECMZU
         Wn5QdVJM1TU1QaH7KtiBHxg9DQQQMtixGEhNUUgewEPD05xJe/X3bwkupVaolqwKXKmZ
         aypQ==
X-Gm-Message-State: APf1xPCsGcIuadP+Cs3J0d3uxCI7AiQjFgBAvTEvXYtYkqbqqfKoj/fr
        Pj4XGg5u0UN5AV2UII7N62A=
X-Google-Smtp-Source: AH8x227PNbaiYUgYS3n4WVMSqfDMcKcAmJ/tYxquZM1Fl6oqxZBLKRkLBiiIsBz1Ea0rsPfPbws+WA==
X-Received: by 10.28.71.135 with SMTP id m7mr3103964wmi.115.1518210825907;
        Fri, 09 Feb 2018 13:13:45 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d17sm3244075wrc.38.2018.02.09.13.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 13:13:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 11/17] fetch tests: fetch <url> <spec> as well as fetch [<remote>]
References: <20180123221326.28495-1-avarab@gmail.com>
        <20180208161936.8196-1-avarab@gmail.com>
        <20180208161936.8196-12-avarab@gmail.com>
        <CAPig+cS4xhyYSnUHXshB=2SPYELe_HXUwxL-OGU4zx=PMFXdqg@mail.gmail.com>
        <87zi4ikjyr.fsf@evledraar.gmail.com>
        <xmqqfu69x4mr.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 09 Feb 2018 13:13:44 -0800
In-Reply-To: <xmqqfu69x4mr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 09 Feb 2018 12:57:48 -0800")
Message-ID: <xmqqbmgxx3w7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>>> +               key=$(echo $1 | sed -e 's/^remote\.origin/fetch/')
>>>
>>> Faster (thus more Windows-friendly) assuming that $1 always starts
>>> with "remote.origin":
>>>
>>>     key=fetch${u#remote.origin}
>>
>> Tests fail with this and I'm not excited to be the first user in git's
>> test suite to use some novel shell feature, no existing uses of
>> ${u[...].
>
> s/u/1/, I think.

Ah, that's been already pointed out.  Sorry for the noise.
